"
I am a 3x3 matrix.
"
Class {
	#name : #Matrix3x3,
	#superclass : #AbstractPrimitiveMatrix,
	#instVars : [
		'm11',
		'm12',
		'm13',
		'm21',
		'm22',
		'm23',
		'm31',
		'm32',
		'm33'
	],
	#category : #'WodenMath-Core-LinearAlgebra'
}

{ #category : #'special matrices' }
Matrix3x3 class >> columnMajorIndices [
	^ self columns: #(0 1 2 3 4 5 6 7 8)
]

{ #category : #accessing }
Matrix3x3 class >> columns [
	^ 3
]

{ #category : #'instance creation' }
Matrix3x3 class >> columns: columns [
	<constructor>
	columns size = 3 ifTrue: [ 
		^ self basicNew
			firstColumn: columns first;
			secondColumn: columns second;
			thirdColumn: columns third;
			yourself
	].
	columns size = 9 ifTrue: [ 
		^ self basicNew
			m11: columns first; m21: columns second; m31: columns third;
			m12: columns fourth; m22: columns fifth; m32: columns sixth;
			m13: columns seventh; m23: columns eighth; m33: columns ninth;
			yourself
	].
	self error: 'Unsupported element count for matrix creation.'
]

{ #category : #'special matrices' }
Matrix3x3 class >> lookAtBack [
	^ self yRotation: Float pi
]

{ #category : #'special matrices' }
Matrix3x3 class >> lookAtBottom [
	^ self xRotation: Float halfPi negated
]

{ #category : #'special matrices' }
Matrix3x3 class >> lookAtDirection: direction up: upVector [
	| up f s u |
	up := upVector normalized.

	f := direction normalized.
	s := (direction cross: up) normalized.
	u := s cross: f.

	^ self columns: {s . u . f negated}.
]

{ #category : #'special matrices' }
Matrix3x3 class >> lookAtFront [
	^ self identity
]

{ #category : #'special matrices' }
Matrix3x3 class >> lookAtLeft [
	^ self yRotation: Float halfPi
]

{ #category : #'special matrices' }
Matrix3x3 class >> lookAtRight [
	^ self yRotation: Float halfPi negated
]

{ #category : #'special matrices' }
Matrix3x3 class >> lookAtTop [
	^ self yRotation: Float halfPi
]

{ #category : #'special matrices' }
Matrix3x3 class >> ndcToTexcoord2D [
	^ self columns: #(
		0.5 0 0
		0 0.5 0
		0.5 0.5 1
	)
]

{ #category : #'special matrices' }
Matrix3x3 class >> rowMajorIndices [
	^ self rows: #(0 1 2 3 4 5 6 7 8)
]

{ #category : #accessing }
Matrix3x3 class >> rows [
	^ 3
]

{ #category : #'instance creation' }
Matrix3x3 class >> rows: rows [
	rows size = 3 ifTrue: [ 
		^ self basicNew
			firstRow: rows first;
			secondRow: rows second;
			thirdRow: rows third;
			yourself
	].
	rows size = 9 ifTrue: [ 
		^ self basicNew
			m11: rows first; m12: rows second; m13: rows third;
			m21: rows fourth; m22: rows fifth; m23: rows sixth;
			m31: rows seventh; m32: rows eighth; m33: rows ninth;
			yourself
	].
	self error: 'Unsupported element count for matrix creation.'
]

{ #category : #'special matrices' }
Matrix3x3 class >> scale: scale [
	| coercedScale |
	coercedScale := scale asVector3.
	^ self basicNew
		m11: coercedScale x; m12: 0; m13: 0;
		m21: 0; m22: coercedScale y; m23: 0;
		m31: 0; m32: 0; m33: coercedScale z
]

{ #category : #'special matrices' }
Matrix3x3 class >> scaleX: x y: y z: z [
	^ self basicNew
		m11: x; m12: 0; m13: 0;
		m21: 0; m22: y; m23: 0;
		m31: 0; m32: 0; m33: z
]

{ #category : #'special matrices' }
Matrix3x3 class >> texScale: scale offset: offset [
	| coercedScale coercedOffset |
	coercedScale := scale asVector2.
	coercedOffset := offset asVector2.
	^ self basicNew
		m11: coercedScale x; m12: 0; m13: coercedOffset x;
		m21: 0; m22: coercedScale y; m23: coercedOffset y;
		m31: 0; m32: 0; m33: 1
]

{ #category : #'special matrices' }
Matrix3x3 class >> texScale: scale rotation: rotation offset: offset [
	| coercedScale coercedOffset cos sin |
	coercedScale := scale asVector2.
	coercedOffset := offset asVector2.
	cos := rotation cos.
	sin := rotation sin.
	^ self basicNew
		m11: cos * coercedScale x; m12: sin * coercedScale x; m13: coercedOffset x;
		m21: sin negated * coercedScale y; m22: cos * coercedScale y; m23: coercedOffset y;
		m31: 0; m32: 0; m33: 1
]

{ #category : #'instance creation' }
Matrix3x3 class >> withAll: value [
	^ self basicNew
		m11: value; m12: value; m13: value;
		m21: value; m22: value; m23: value;
		m31: value; m32: value; m33: value;
		yourself
]

{ #category : #'special matrices' }
Matrix3x3 class >> xRotation: angle [
	| c s |
	c := angle cos.
	s := angle sin.
	^ self columns: {
		1. 0. 0.
		0. c. s.
		0. s negated. c
	}
]

{ #category : #'special matrices' }
Matrix3x3 class >> xyzRotation: angles [
	^ (self xRotation: angles x) * (self yRotation: angles y) * (self zRotation: angles z)
]

{ #category : #'special matrices' }
Matrix3x3 class >> yRotation: angle [
	| c s |
	c := angle cos.
	s := angle sin.
	^ self columns: {
		c. 0. s negated.
		0. 1. 0.
		s. 0. c
	}
]

{ #category : #'special matrices' }
Matrix3x3 class >> zRotation: angle [
	| c s |
	c := angle cos.
	s := angle sin.
	^ self columns: {
		c. s. 0.
		s negated. c. 0.
		0. 0. 1
	}
]

{ #category : #'special matrices' }
Matrix3x3 class >> zyxRotation: angles [
	^ (self zRotation: angles z) * (self yRotation: angles y) * (self xRotation: angles x)
]

{ #category : #comparing }
Matrix3x3 >> <=> other [
	m11 ~= other m11 ifTrue: [ ^ m11 <=> other m11].
	m12 ~= other m12 ifTrue: [ ^ m12 <=> other m12].
	m13 ~= other m13 ifTrue: [ ^ m13 <=> other m13].

	m21 ~= other m21 ifTrue: [ ^ m21 <=> other m21].
	m22 ~= other m22 ifTrue: [ ^ m22 <=> other m22].
	m23 ~= other m23 ifTrue: [ ^ m23 <=> other m23].

	m31 ~= other m31 ifTrue: [ ^ m31 <=> other m31].
	m32 ~= other m32 ifTrue: [ ^ m32 <=> other m32].
	^ m33 <=> other m33

]

{ #category : #comparing }
Matrix3x3 >> = other [
	^ self class == other class and: [
		m11 = other m11 and: [ m12 = other m12 and: [ m13 = other m13 and: [
		m21 = other m21 and: [ m22 = other m22 and: [ m23 = other m23 and: [
		m31 = other m31 and: [ m32 = other m32 and: [ m33 = other m33 ]]]]]]]]]
]

{ #category : #converting }
Matrix3x3 >> asMatrix3x3 [
	^ self
]

{ #category : #converting }
Matrix3x3 >> asQuaternion [
	| diag signs xyzw |
	"Matrix to quaternion conversion algorithm from: https://www.euclideanspace.com/maths/geometry/rotations/conversions/matrixToQuaternion/"
	diag := self diagonal.
	signs := Vector3
		x: (self secondColumn z - self thirdColumn y) sign
      y: (self thirdColumn x - self firstColumn z) sign
      z: (self firstColumn y - self secondColumn x) sign.

	xyzw := Vector4
		x: (1 + diag x - diag y - diag z max: 0.0) sqrt * 0.5 * signs x
		y: (1 - diag x + diag y - diag z max: 0.0) sqrt * 0.5 * signs y
		z: (1 - diag x - diag y + diag z max: 0.0) sqrt * 0.5 * signs z
		w: (1 + diag x + diag y + diag z max: 0.0) sqrt * 0.5.
	^ Quaternion xyzw: xyzw
]

{ #category : #comparing }
Matrix3x3 >> closeTo: other [
	^ self class == other class and: [
		(m11 closeTo: other m11) and: [ (m12 closeTo: other m12) and: [ (m13 closeTo: other m13) and: [
		(m21 closeTo: other m21) and: [ (m22 closeTo: other m22) and: [ (m23 closeTo: other m23) and: [
		(m31 closeTo: other m31) and: [ (m32 closeTo: other m32) and: [ (m33 closeTo: other m33) ]]]]]]]]]
]

{ #category : #comparing }
Matrix3x3 >> closeTo: other precision: precision [
	^ self class == other class and: [
		(m11 closeTo: other m11 precision: precision) and: [
		(m12 closeTo: other m12 precision: precision) and: [
		(m13 closeTo: other m13 precision: precision) and: [

		(m21 closeTo: other m21 precision: precision) and: [
		(m22 closeTo: other m22 precision: precision) and: [
		(m23 closeTo: other m23 precision: precision) and: [

		(m31 closeTo: other m31 precision: precision) and: [
		(m32 closeTo: other m32 precision: precision) and: [
		(m33 closeTo: other m33 precision: precision) ]]]]]]]]]
]

{ #category : #enumerating }
Matrix3x3 >> collect: aBlock [
	^ self class basicNew
		m11: (aBlock value: m11);
		m12: (aBlock value: m12);
		m13: (aBlock value: m13);

		m21: (aBlock value: m21);
		m22: (aBlock value: m22);
		m23: (aBlock value: m23);

		m31: (aBlock value: m31);
		m32: (aBlock value: m32);
		m33: (aBlock value: m33);
		yourself
]

{ #category : #testing }
Matrix3x3 >> determinant [
	"
	| m11 m12 m13 | m11 m12
	| m21 m22 m23 | m21 m22
	| m31 m32 m33 | m31 m32
	"
	^ (m11 * m22 * m33) + (m12 * m23 * m31) + (m13 * m21 *m32)
		- (m31 * m22 * m13) - (m32 * m23 * m11) - (m33 * m21 * m12)
]

{ #category : #accessing }
Matrix3x3 >> diagonal [
	^ Vector3 x: m11 y: m22 z: m33
]

{ #category : #enumerating }
Matrix3x3 >> do: aBlock [
	aBlock value: m11.
	aBlock value: m12.
	aBlock value: m13.
	
	aBlock value: m21.
	aBlock value: m22.
	aBlock value: m23.
	
	aBlock value: m31.
	aBlock value: m32.
	aBlock value: m33.
]

{ #category : #accessing }
Matrix3x3 >> firstColumn [
	^ Vector3 x: m11 y: m21 z: m31
]

{ #category : #accessing }
Matrix3x3 >> firstColumn: column [
	| coercedColumn |
	coercedColumn := column asVector3.
	m11 := coercedColumn x.
	m21 := coercedColumn y.
	m31 := coercedColumn z.
]

{ #category : #accessing }
Matrix3x3 >> firstRow [
	^ Vector3 x: m11 y: m12 z: m13
]

{ #category : #accessing }
Matrix3x3 >> firstRow: row [
	| coercedRow |
	coercedRow := row asVector3.
	m11 := coercedRow x.
	m12 := coercedRow y.
	m13 := coercedRow z.
]

{ #category : #comparing }
Matrix3x3 >> hash [
	| result |
	result := m11 hash.
	result := result hashMultiply + m12 hash.
	result := result hashMultiply + m13 hash.

	result := result hashMultiply + m21 hash.
	result := result hashMultiply + m22 hash.
	result := result hashMultiply + m23 hash.

	result := result hashMultiply + m31 hash.
	result := result hashMultiply + m32 hash.
	result := result hashMultiply + m33 hash.

	^ result
]

{ #category : #initialization }
Matrix3x3 >> initialize [
	m11 := 0. m12 := 0. m13 := 0.
	m21 := 0. m22 := 0. m23 := 0.
	m31 := 0. m32 := 0. m33 := 0.
]

{ #category : #operations }
Matrix3x3 >> inverse [
	| det detVector firstColumn secondColumn thirdColumn |
	det := self determinant.
	self flag: 'Select a more appropiate epsilon here.'.
	det = 0 ifTrue: [ ^ self error: 'Matrix is not invertible.' ].
	"Formula from: https://en.wikipedia.org/wiki/Invertible_matrix#Inversion_of_3_%C3%97_3_matrices [30th September, 2020]"

	detVector := det asVector3.
	firstColumn := self firstColumn.
	secondColumn := self secondColumn.
	thirdColumn := self thirdColumn.
	^ self class rows: {
		(secondColumn cross: thirdColumn) / detVector.
		(thirdColumn cross: firstColumn) / detVector.
		(firstColumn cross: secondColumn) / detVector.
	}
]

{ #category : #testing }
Matrix3x3 >> isIdentity [
	^ m11 = 1 and: [ m12 = 0 and: [ m13 = 0 and: [
	  m21 = 0 and: [ m22 = 1 and: [ m23 = 0 and: [
	  m31 = 0 and: [ m32 = 0 and: [ m33 = 1 ]]]]]]]]
]

{ #category : #testing }
Matrix3x3 >> isOnes [
	^ m11 = 1 and: [ m12 = 1 and: [ m13 = 1 and: [
	  m21 = 1 and: [ m22 = 1 and: [ m23 = 1 and: [
	  m31 = 1 and: [ m32 = 1 and: [ m33 = 1 ]]]]]]]]
]

{ #category : #testing }
Matrix3x3 >> isZeros [
	^ m11 = 0 and: [ m12 = 0 and: [ m13 = 0 and: [
	  m21 = 0 and: [ m22 = 0 and: [ m23 = 0 and: [
	  m31 = 0 and: [ m32 = 0 and: [ m33 = 0 ]]]]]]]]
]

{ #category : #accessing }
Matrix3x3 >> m11 [

	^ m11
]

{ #category : #accessing }
Matrix3x3 >> m11: anObject [

	m11 := anObject
]

{ #category : #accessing }
Matrix3x3 >> m12 [

	^ m12
]

{ #category : #accessing }
Matrix3x3 >> m12: anObject [

	m12 := anObject
]

{ #category : #accessing }
Matrix3x3 >> m13 [

	^ m13
]

{ #category : #accessing }
Matrix3x3 >> m13: anObject [

	m13 := anObject
]

{ #category : #accessing }
Matrix3x3 >> m21 [

	^ m21
]

{ #category : #accessing }
Matrix3x3 >> m21: anObject [

	m21 := anObject
]

{ #category : #accessing }
Matrix3x3 >> m22 [

	^ m22
]

{ #category : #accessing }
Matrix3x3 >> m22: anObject [

	m22 := anObject
]

{ #category : #accessing }
Matrix3x3 >> m23 [

	^ m23
]

{ #category : #accessing }
Matrix3x3 >> m23: anObject [

	m23 := anObject
]

{ #category : #accessing }
Matrix3x3 >> m31 [

	^ m31
]

{ #category : #accessing }
Matrix3x3 >> m31: anObject [

	m31 := anObject
]

{ #category : #accessing }
Matrix3x3 >> m32 [

	^ m32
]

{ #category : #accessing }
Matrix3x3 >> m32: anObject [

	m32 := anObject
]

{ #category : #accessing }
Matrix3x3 >> m33 [

	^ m33
]

{ #category : #accessing }
Matrix3x3 >> m33: anObject [

	m33 := anObject
]

{ #category : #arithmetic }
Matrix3x3 >> multiplyWithMatrix: other [
	| coerced |
	coerced := other asMatrix3x3.
	^ self class basicNew
		firstColumn: (self firstColumn * coerced firstColumn x) + (self secondColumn * coerced firstColumn y) + (self thirdColumn * coerced firstColumn z);
		secondColumn: (self firstColumn * coerced secondColumn x) + (self secondColumn * coerced secondColumn y) + (self thirdColumn * coerced secondColumn z);
		thirdColumn: (self firstColumn * coerced thirdColumn x) + (self secondColumn * coerced thirdColumn y) + (self thirdColumn * coerced thirdColumn z);
		yourself

]

{ #category : #arithmetic }
Matrix3x3 >> postMultiplyVector: vector [
	| coercedVector |
	coercedVector := vector asVector3.
	^ Vector3
		x: (self firstColumn dot: coercedVector)
		y: (self secondColumn dot: coercedVector)
		z: (self thirdColumn dot: coercedVector)
]

{ #category : #arithmetic }
Matrix3x3 >> preMultiplyVector: vector [
	| coercedVector |
	coercedVector := vector asVector3.
	^ (self firstColumn * coercedVector x) + (self secondColumn * coercedVector y)
	+ (self thirdColumn * coercedVector z)
]

{ #category : #printing }
Matrix3x3 >> printOn: aStream [
	aStream nextPut: $(; nextPutAll: self class name; nextPutAll: ' rows: #('; cr;
		tab; print: m11; space; print: m12; space; print: m13; cr;
		tab; print: m21; space; print: m22; space; print: m23; cr;
		tab; print: m31; space; print: m32; space; print: m33; cr;
		nextPutAll: ')'
]

{ #category : #accessing }
Matrix3x3 >> secondColumn [
	^ Vector3 x: m12 y: m22 z: m32
]

{ #category : #accessing }
Matrix3x3 >> secondColumn: column [
	| coercedColumn |
	coercedColumn := column asVector3.
	m12 := coercedColumn x.
	m22 := coercedColumn y.
	m32 := coercedColumn z.
]

{ #category : #accessing }
Matrix3x3 >> secondRow [
	^ Vector3 x: m21 y: m22 z: m23
]

{ #category : #accessing }
Matrix3x3 >> secondRow: row [
	| coercedRow |
	coercedRow := row asVector3.
	m21 := coercedRow x.
	m22 := coercedRow y.
	m23 := coercedRow z.
]

{ #category : #initialization }
Matrix3x3 >> setIdentity [
	m11 := 1. m12 := 0. m13 := 0.
	m21 := 0. m22 := 1. m23 := 0.
	m31 := 0. m32 := 0. m33 := 1.
]

{ #category : #accessing }
Matrix3x3 >> thirdColumn [
	^ Vector3 x: m13 y: m23 z: m33
]

{ #category : #accessing }
Matrix3x3 >> thirdColumn: column [
	| coercedColumn |
	coercedColumn := column asVector3.
	m13 := coercedColumn x.
	m23 := coercedColumn y.
	m33 := coercedColumn z.
]

{ #category : #accessing }
Matrix3x3 >> thirdRow [
	^ Vector3 x: m31 y: m32 z: m33
]

{ #category : #accessing }
Matrix3x3 >> thirdRow: row [
	| coercedRow |
	coercedRow := row asVector3.
	m31 := coercedRow x.
	m32 := coercedRow y.
	m33 := coercedRow z.
]

{ #category : #arithmetic }
Matrix3x3 >> transformPosition3: position [
	^ self * position
]

{ #category : #arithmetic }
Matrix3x3 >> transformVector2: vector2 [
	| coervedVector2 |
	coervedVector2 := vector2 asVector2.
	^ Vector2
		x: (m11*coervedVector2 x) + (m12*coervedVector2 y) + m13
		y: (m21*coervedVector2 x) + (m22*coervedVector2 y) + m23
]

{ #category : #arithmetic }
Matrix3x3 >> transformVector3: vector [
	^ self * vector
]

{ #category : #accessing }
Matrix3x3 >> transpose [
	^ self class basicNew
		m11: m11; m12: m21; m13: m31;
		m21: m12; m22: m22; m23: m32;
		m31: m13; m32: m23; m33: m33
]

{ #category : #enumerating }
Matrix3x3 >> with: other collect: aBlock [
	| coercedOther |
	coercedOther := other asMatrix3x3.
	^ self class basicNew
		m11: (aBlock value: m11 value: other m11);
		m12: (aBlock value: m12 value: other m12);
		m13: (aBlock value: m13 value: other m13);

		m21: (aBlock value: m21 value: other m21);
		m22: (aBlock value: m22 value: other m22);
		m23: (aBlock value: m23 value: other m23);

		m31: (aBlock value: m31 value: other m31);
		m32: (aBlock value: m32 value: other m32);
		m33: (aBlock value: m33 value: other m33);

		yourself
]

"
I am a 2x2 matrix.
"
Class {
	#name : #Matrix2x2,
	#superclass : #AbstractPrimitiveMatrix,
	#instVars : [
		'm11',
		'm12',
		'm21',
		'm22'
	],
	#category : #'WodenMath-Core-LinearAlgebra'
}

{ #category : #'special matrices' }
Matrix2x2 class >> columnMajorIndices [
	^ self columns: #(0 1 2 3)
]

{ #category : #accessing }
Matrix2x2 class >> columns [
	^ 2
]

{ #category : #accessing }
Matrix2x2 class >> columns: columns [
	columns size = 2 ifTrue: [ 
		^ self basicNew
			firstColumn: columns first;
			secondColumn: columns second;
			yourself
	].
	columns size = 4 ifTrue: [ 
		^ self basicNew
			m11: columns first; m21: columns second;
			m12: columns third; m22: columns fourth;
			yourself
	].
	self error: 'Unsupported element count for matrix creation.'
]

{ #category : #accessing }
Matrix2x2 class >> rotation: angle [
	| c s |
	c := angle cos.
	s := angle sin.
	^ self basicNew
		m11: c; m12: s negated;
		m21: s; m22: c;
		yourself
]

{ #category : #'special matrices' }
Matrix2x2 class >> rowMajorIndices [
	^ self rows: #(0 1 2 3)
]

{ #category : #accessing }
Matrix2x2 class >> rows [
	^ 2
]

{ #category : #accessing }
Matrix2x2 class >> rows: rows [
	rows size = 2 ifTrue: [ 
		^ self basicNew
			firstRow: rows first;
			secondRow: rows second;
			yourself
	].
	rows size = 4 ifTrue: [ 
		^ self basicNew
			m11: rows first; m12: rows second;
			m21: rows third; m22: rows fourth;
			yourself
	].
	self error: 'Unsupported element count for matrix creation.'
]

{ #category : #accessing }
Matrix2x2 class >> scale: scale [
	| coercedScale |
	coercedScale := scale asVector2.
	^ self basicNew
		m11: coercedScale x; m12: 0;
		m21: 0; m22: coercedScale y;
		yourself
]

{ #category : #accessing }
Matrix2x2 class >> scaleX: x y: y [
	^ self basicNew
		m11: x; m12: 0;
		m21: 0; m22: y;
		yourself
]

{ #category : #'instance creation' }
Matrix2x2 class >> withAll: value [
	^ self basicNew
		m11: value; m12: value;
		m21: value; m22: value;
		yourself
]

{ #category : #comparing }
Matrix2x2 >> <=> other [
	m11 ~= other m11 ifTrue: [ ^ m11 <=> other m11].
	m12 ~= other m12 ifTrue: [ ^ m12 <=> other m12].

	m21 ~= other m21 ifTrue: [ ^ m21 <=> other m21].
	^ m22 <=> other m22
]

{ #category : #comparing }
Matrix2x2 >> = other [
	^ self class == other class and: [
		m11 = other m11 and: [ m12 = other m12 and: [
		m21 = other m21 and: [ m22 = other m22 ]]]]
]

{ #category : #converting }
Matrix2x2 >> asMatrix2x2 [
	^ self
]

{ #category : #comparing }
Matrix2x2 >> closeTo: other [
	^ self class == other class and: [
		(m11 closeTo: other m11) and: [ (m12 closeTo: other m12) and: [
		(m21 closeTo: other m21) and: [ (m22 closeTo: other m22) ]]]]
]

{ #category : #comparing }
Matrix2x2 >> closeTo: other precision: precision [
	^ self class == other class and: [
		(m11 closeTo: other m11 precision: precision) and: [
		(m12 closeTo: other m12 precision: precision) and: [

		(m21 closeTo: other m21 precision: precision) and: [
		(m22 closeTo: other m22 precision: precision) ]]]]
]

{ #category : #enumerating }
Matrix2x2 >> collect: aBlock [
	^ self class basicNew
		m11: (aBlock value: m11);
		m12: (aBlock value: m12);
		m21: (aBlock value: m21);
		m22: (aBlock value: m22);
		yourself
]

{ #category : #testing }
Matrix2x2 >> determinant [
	^ (m11 * m22) - (m21 * m12)
]

{ #category : #accessing }
Matrix2x2 >> firstColumn [
	^ Vector2 x: m11 y: m21
]

{ #category : #accessing }
Matrix2x2 >> firstColumn: column [
	| coercedColumn |
	coercedColumn := column asVector2.
	m11 := coercedColumn x.
	m21 := coercedColumn y.
]

{ #category : #accessing }
Matrix2x2 >> firstRow [
	^ Vector2 x: m11 y: m12
]

{ #category : #accessing }
Matrix2x2 >> firstRow: row [
	| coercedRow |
	coercedRow := row asVector2.
	m11 := coercedRow x.
	m12 := coercedRow y.
]

{ #category : #comparing }
Matrix2x2 >> hash [
	| result |
	result := m11 hash.
	result := result hashMultiply + m12 hash.
	result := result hashMultiply + m21 hash.
	result := result hashMultiply + m22 hash.
	^ result
]

{ #category : #initialization }
Matrix2x2 >> initialize [
	m11 := 0. m12 := 0.
	m21 := 0. m22 := 0.
]

{ #category : #operations }
Matrix2x2 >> inverse [
	| det |
	det := self determinant.
	(det closeTo: 0) ifTrue: [ ^ self error: 'Matrix is not invertible.' ].

	^ self class basicNew
		m11: m22 / det; m12: m12 negated / det;
		m21: m21 negated / det; m22: m11 / 	det;
		yourself
]

{ #category : #testing }
Matrix2x2 >> isIdentity [
	^ m11 = 1 and: [ m12 = 0 and: [
	  m21 = 0 and: [ m22 = 1 ]]]
]

{ #category : #testing }
Matrix2x2 >> isOnes [
	^ m11 = 1 and: [ m12 = 1 and: [
	  m21 = 1 and: [ m22 = 1 ]]]
]

{ #category : #testing }
Matrix2x2 >> isZeros [
	^ m11 = 0 and: [ m12 = 0 and: [
	  m21 = 0 and: [ m22 = 0 ]]]
]

{ #category : #accessing }
Matrix2x2 >> m11 [

	^ m11
]

{ #category : #accessing }
Matrix2x2 >> m11: anObject [

	m11 := anObject
]

{ #category : #accessing }
Matrix2x2 >> m12 [

	^ m12
]

{ #category : #accessing }
Matrix2x2 >> m12: anObject [

	m12 := anObject
]

{ #category : #accessing }
Matrix2x2 >> m21 [

	^ m21
]

{ #category : #accessing }
Matrix2x2 >> m21: anObject [

	m21 := anObject
]

{ #category : #accessing }
Matrix2x2 >> m22 [

	^ m22
]

{ #category : #accessing }
Matrix2x2 >> m22: anObject [

	m22 := anObject
]

{ #category : #arithmetic }
Matrix2x2 >> multiplyWithMatrix: other [
	| coerced |
	coerced := other asMatrix3x3.
	^ self class basicNew
		firstColumn: (self firstColumn * coerced firstColumn x) + (self secondColumn * coerced firstColumn y);
		secondColumn: (self firstColumn * coerced secondColumn x) + (self secondColumn * coerced secondColumn y);
		yourself

]

{ #category : #arithmetic }
Matrix2x2 >> postMultiplyVector: vector [
	| coercedVector |
	coercedVector := vector asVector2.
	^ Vector2 x: (self firstColumn dot: coercedVector) y: (self secondColumn dot: coercedVector)
]

{ #category : #arithmetic }
Matrix2x2 >> preMultiplyVector: vector [
	| coercedVector |
	coercedVector := vector asVector2.
	^ (self firstColumn * coercedVector x) + (self secondColumn * coercedVector y)
]

{ #category : #printing }
Matrix2x2 >> printOn: aStream [
	aStream nextPut: $(; nextPutAll: self class name; nextPutAll: ' rows: #('; cr;
		tab; print: m11; space; print: m12; cr;
		tab; print: m21; space; print: m22; cr;
		nextPutAll: ')'
]

{ #category : #accessing }
Matrix2x2 >> secondColumn [
	^ Vector2 x: m12 y: m22
]

{ #category : #accessing }
Matrix2x2 >> secondColumn: column [
	| coercedColumn |
	coercedColumn := column asVector2.
	m12 := coercedColumn x.
	m22 := coercedColumn y.
]

{ #category : #accessing }
Matrix2x2 >> secondRow [
	^ Vector2 x: m21 y: m22
]

{ #category : #accessing }
Matrix2x2 >> secondRow: row [
	| coercedRow |
	coercedRow := row asVector2.
	m21 := coercedRow x.
	m22 := coercedRow y.
]

{ #category : #initialization }
Matrix2x2 >> setIdentity [
	m11 := 1. m12 := 0.
	m21 := 0. m22 := 1.
]

{ #category : #testing }
Matrix2x2 >> transpose [
	^ self class basicNew
		m11: m11; m12: m21;
		m21: m12; m22: m22
]

{ #category : #enumerating }
Matrix2x2 >> with: other collect: aBlock [
	| coercedOther |
	coercedOther := other asMatrix2x2.
	^ self class basicNew
		m11: (aBlock value: m11 value: other m11);
		m12: (aBlock value: m12 value: other m12);

		m21: (aBlock value: m21 value: other m21);
		m22: (aBlock value: m22 value: other m22);
		yourself
]

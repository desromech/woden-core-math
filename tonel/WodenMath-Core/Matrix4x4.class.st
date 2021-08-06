"
I am a 4x4 matrix.
"
Class {
	#name : #Matrix4x4,
	#superclass : #AbstractPrimitiveMatrix,
	#instVars : [
		'm11',
		'm12',
		'm13',
		'm14',
		'm21',
		'm22',
		'm23',
		'm24',
		'm31',
		'm32',
		'm33',
		'm34',
		'm41',
		'm42',
		'm43',
		'm44'
	],
	#category : #'WodenMath-Core-LinearAlgebra'
}

{ #category : #'special matrices' }
Matrix4x4 class >> columnMajorIndices [
	^ self columns: #(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
]

{ #category : #accessing }
Matrix4x4 class >> columns [
	^ 4
]

{ #category : #'instance creation' }
Matrix4x4 class >> columns: columns [
	<constructor>
	columns size = 4 ifTrue: [ 
		^ self basicNew
			firstColumn: columns first;
			secondColumn: columns second;
			thirdColumn: columns third;
			fourthColumn: columns fourth;
			yourself
	].
	columns size = 16 ifTrue: [ 
		^ self basicNew
			m11: (columns at: 1); m21: (columns at: 2); m31: (columns at: 3); m41: (columns at: 4);
			m12: (columns at: 5); m22: (columns at: 6); m32: (columns at: 7); m42: (columns at: 8);
			m13: (columns at: 9); m23: (columns at: 10); m33: (columns at: 11); m43: (columns at: 12);
			m14: (columns at: 13); m24: (columns at: 14); m34: (columns at: 15); m44: (columns at: 16);
			yourself
	].
	self error: 'Unsupported element count for matrix creation.'
]

{ #category : #'special matrices' }
Matrix4x4 class >> frustumLeft: left right: right bottom: bottom top: top near: near far: far [
	^ self rows: {
		Vector4 x: 2*near /(right - left) y: 0 z: (right + left) / (right - left) w: 0.
		Vector4 x: 0 y: 2*near /(top - bottom) z: (top + bottom) / (top - bottom) w: 0.
		Vector4 x: 0 y: 0 z: far negated / (far - near) w: near*far negated / (far - near).
		Vector4 x: 0 y: 0 z: -1 w: 0
	}
]

{ #category : #'special matrices' }
Matrix4x4 class >> mat3: mat3 [
	^ self basicNew
		m11: mat3 m11; m12: mat3 m12; m13: mat3 m13; m14: 0;
		m21: mat3 m21; m22: mat3 m22; m23: mat3 m23; m24: 0;
		m31: mat3 m31; m32: mat3 m32; m33: mat3 m33; m34: 0;
		m41: 0; m42: 0; m43: 0; m44: 1
]

{ #category : #'special matrices' }
Matrix4x4 class >> mat3: mat3 translation4: translation4 [
	^ self basicNew
		m11: mat3 m11; m12: mat3 m12; m13: mat3 m13; m14: translation4 x;
		m21: mat3 m21; m22: mat3 m22; m23: mat3 m23; m24: translation4 y;
		m31: mat3 m31; m32: mat3 m32; m33: mat3 m33; m34: translation4 z;
		m41: 0; m42: 0; m43: 0; m44: translation4 w
]

{ #category : #'special matrices' }
Matrix4x4 class >> mat3: mat3 translation: translation [
	^ self basicNew
		m11: mat3 m11; m12: mat3 m12; m13: mat3 m13; m14: translation x;
		m21: mat3 m21; m22: mat3 m22; m23: mat3 m23; m24: translation y;
		m31: mat3 m31; m32: mat3 m32; m33: mat3 m33; m34: translation z;
		m41: 0; m42: 0; m43: 0; m44: 1
]

{ #category : #'special matrices' }
Matrix4x4 class >> orthoLeft: left right: right bottom: bottom top: top
	near: near far: far [
	^ self rows: {
		Vector4 x: 2 /(right - left) y: 0 z: 0 w: ((right + left) / (right - left)) negated.
		Vector4 x: 0 y: 2 /(top - bottom) z: 0 w: ((top + bottom) / (top - bottom)) negated.
		Vector4 x: 0 y: 0 z: -1 / (far - near) w: near / (far - near) negated.
		Vector4 x: 0 y: 0 z: 0 w: 1
	}
]

{ #category : #'special matrices' }
Matrix4x4 class >> perspectiveFovY: fovy aspect: aspect near: near far: far [
	| fovyRad top right |
	fovyRad := fovy degreesToRadians * 0.5.
	top := near * fovyRad tan.
	right := top * aspect.
	^ self frustumLeft: right negated right: right bottom: top negated top: top near: near far: far
]

{ #category : #'special matrices' }
Matrix4x4 class >> projectionInvertYMatrix [
	^ self basicNew setIdentity; m22: -1.0; yourself
]

{ #category : #'special matrices' }
Matrix4x4 class >> reverseDepthFrustumLeft: left right: right bottom: bottom top: top near: near far: far [
	^ self rows: {
		Vector4 x: 2*near /(right - left) y: 0 z: (right + left) / (right - left) w: 0.
		Vector4 x: 0 y: 2*near /(top - bottom) z: (top + bottom) / (top - bottom) w: 0.
		Vector4 x: 0 y: 0 z: near / (far - near) w: near*far / (far - near).
		Vector4 x: 0 y: 0 z: -1 w: 0
	}
]

{ #category : #'special matrices' }
Matrix4x4 class >> reverseDepthOrthoLeft: left right: right bottom: bottom top: top near: near far: far [
	^ self rows: {
		Vector4 x: 2 /(right - left) y: 0 z: 0 w: ((right + left) / (right - left)) negated.
		Vector4 x: 0 y: 2 /(top - bottom) z: 0 w: ((top + bottom) / (top - bottom)) negated.
		Vector4 x: 0 y: 0 z: 1 / (far - near) w: far / (far - near).
		Vector4 x: 0 y: 0 z: 0 w: 1
	}
]

{ #category : #'special matrices' }
Matrix4x4 class >> reverseDepthPerspectiveFovY: fovy aspect: aspect near: near far: far [
	| fovyRad top right |
	fovyRad := fovy degreesToRadians / 2.0.
	top := near * fovyRad tan.
	right := top * aspect.
	^ self reverseDepthFrustumLeft: right negated right: right bottom: top negated top: top near: near far: far
]

{ #category : #'special matrices' }
Matrix4x4 class >> rowMajorIndices [
	^ self rows: #(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
]

{ #category : #accessing }
Matrix4x4 class >> rows [
	^ 4
]

{ #category : #'instance creation' }
Matrix4x4 class >> rows: rows [
	rows size = 4 ifTrue: [ 
		^ self basicNew
			firstRow: rows first;
			secondRow: rows second;
			thirdRow: rows third;
			fourthRow: rows fourth;
			yourself
	].
	rows size = 16 ifTrue: [ 
		^ self basicNew
			m11: (rows at: 1); m12: (rows at: 2); m13: (rows at: 3); m14: (rows at: 4);
			m21: (rows at: 5); m22: (rows at: 6); m23: (rows at: 7); m24: (rows at: 8);
			m31: (rows at: 9); m32: (rows at: 10); m33: (rows at: 11); m34: (rows at: 12);
			m41: (rows at: 13); m42: (rows at: 14); m43: (rows at: 15); m44: (rows at: 16);
			yourself
	].
	self error: 'Unsupported element count for matrix creation.'
]

{ #category : #'special matrices' }
Matrix4x4 class >> scale: scale [
	| coercedScale |
	coercedScale := scale asVector4.
	^ self basicNew
		m11: coercedScale x; m12: 0; m13: 0; m14: 0;
		m21: 0; m22: coercedScale y; m23: 0; m24: 0;
		m31: 0; m32: 0; m33: coercedScale z; m34: 0;
		m41: 0; m42: 0; m43: 0; m44: coercedScale w
]

{ #category : #'special matrices' }
Matrix4x4 class >> scaleX: x y: y z: z w: w [
	^ self basicNew
		m11: x; m12: 0; m13: 0; m14: 0;
		m21: 0; m22: y; m23: 0; m24: 0;
		m31: 0; m32: 0; m33: z; m34: 0;
		m41: 0; m42: 0; m43: 0; m44: w
]

{ #category : #'special matrices' }
Matrix4x4 class >> translation4: translation4 [
	^ self basicNew
		m11: 1; m12: 0; m13: 0; m14: translation4 x;
		m21: 0; m22: 1; m23: 0; m24: translation4 y;
		m31: 0; m32: 0; m33: 1; m34: translation4 z;
		m41: 0; m42: 0; m43: 0; m44: translation4 w
]

{ #category : #'special matrices' }
Matrix4x4 class >> translation: translation [
	^ self basicNew
		m11: 1; m12: 0; m13: 0; m14: translation x;
		m21: 0; m22: 1; m23: 0; m24: translation y;
		m31: 0; m32: 0; m33: 1; m34: translation z;
		m41: 0; m42: 0; m43: 0; m44: 1
]

{ #category : #'instance creation' }
Matrix4x4 class >> withAll: value [
	^ self basicNew
		m11: value; m12: value; m13: value; m14: value;
		m21: value; m22: value; m23: value; m24: value;
		m31: value; m32: value; m33: value; m34: value;
		m41: value; m42: value; m43: value; m44: value;
		yourself
]

{ #category : #comparing }
Matrix4x4 >> <=> other [
	m11 ~= other m11 ifTrue: [ ^ m11 <=> other m11].
	m12 ~= other m12 ifTrue: [ ^ m12 <=> other m12].
	m13 ~= other m13 ifTrue: [ ^ m13 <=> other m13].
	m14 ~= other m14 ifTrue: [ ^ m14 <=> other m14].

	m21 ~= other m21 ifTrue: [ ^ m21 <=> other m21].
	m22 ~= other m22 ifTrue: [ ^ m22 <=> other m22].
	m23 ~= other m23 ifTrue: [ ^ m23 <=> other m23].
	m24 ~= other m24 ifTrue: [ ^ m24 <=> other m24].

	m31 ~= other m31 ifTrue: [ ^ m31 <=> other m31].
	m32 ~= other m32 ifTrue: [ ^ m32 <=> other m32].
	m33 ~= other m33 ifTrue: [ ^ m33 <=> other m33].
	m34 ~= other m34 ifTrue: [ ^ m34 <=> other m34].

	m41 ~= other m41 ifTrue: [ ^ m41 <=> other m41].
	m42 ~= other m42 ifTrue: [ ^ m42 <=> other m42].
	m43 ~= other m43 ifTrue: [ ^ m43 <=> other m43].
	^ m24 <=> other m24

]

{ #category : #comparing }
Matrix4x4 >> = other [
	^ self class == other class and: [
		m11 = other m11 and: [ m12 = other m12 and: [ m13 = other m13 and: [ m14 = other m14 and: [
		m21 = other m21 and: [ m22 = other m22 and: [ m23 = other m23 and: [ m24 = other m24 and: [
		m31 = other m31 and: [ m32 = other m32 and: [ m33 = other m33 and: [ m34 = other m34 and: [
		m41 = other m41 and: [ m42 = other m42 and: [ m43 = other m43 and: [ m44 = other m44 ]]]]]]]]]]]]]]]]
]

{ #category : #arithmetic }
Matrix4x4 >> adjugateMatrix [
	^ self class columns: { 
			self cofactorAtRow: 1 atColumn: 1.
			self cofactorAtRow: 1 atColumn: 2.
			self cofactorAtRow: 1 atColumn: 3.
			self cofactorAtRow: 1 atColumn: 4.

			self cofactorAtRow: 2 atColumn: 1.
			self cofactorAtRow: 2 atColumn: 2.
			self cofactorAtRow: 2 atColumn: 3.
			self cofactorAtRow: 2 atColumn: 4.

			self cofactorAtRow: 3 atColumn: 1.
			self cofactorAtRow: 3 atColumn: 2.
			self cofactorAtRow: 3 atColumn: 3.
			self cofactorAtRow: 3 atColumn: 4.

			self cofactorAtRow: 4 atColumn: 1.
			self cofactorAtRow: 4 atColumn: 2.
			self cofactorAtRow: 4 atColumn: 3.
			self cofactorAtRow: 4 atColumn: 4.
		}
]

{ #category : #converting }
Matrix4x4 >> asMatrix4x4 [
	^ self
]

{ #category : #comparing }
Matrix4x4 >> closeTo: other [
	^ self class == other class and: [
		(m11 closeTo: other m11) and: [ (m12 closeTo: other m12) and: [ (m13 closeTo: other m13) and: [ (m14 closeTo: other m14) and: [
		(m21 closeTo: other m21) and: [ (m22 closeTo: other m22) and: [ (m23 closeTo: other m23) and: [ (m24 closeTo: other m24) and: [
		(m31 closeTo: other m31) and: [ (m32 closeTo: other m32) and: [ (m33 closeTo: other m33) and: [ (m34 closeTo: other m34) and: [
		(m41 closeTo: other m41) and: [ (m42 closeTo: other m42) and: [ (m43 closeTo: other m43) and: [ (m44 closeTo: other m44) ]]]]]]]]]]]]]]]]
]

{ #category : #comparing }
Matrix4x4 >> closeTo: other precision: precision [
	^ self class == other class and: [
		(m11 closeTo: other m11 precision: precision) and: [
		(m12 closeTo: other m12 precision: precision) and: [
		(m13 closeTo: other m13 precision: precision) and: [
		(m14 closeTo: other m14 precision: precision) and: [

		(m21 closeTo: other m21 precision: precision) and: [
		(m22 closeTo: other m22 precision: precision) and: [
		(m23 closeTo: other m23 precision: precision) and: [
		(m24 closeTo: other m24 precision: precision) and: [
			
		(m31 closeTo: other m31 precision: precision) and: [
		(m32 closeTo: other m32 precision: precision) and: [
		(m33 closeTo: other m33 precision: precision) and: [
		(m34 closeTo: other m34 precision: precision) and: [

		(m41 closeTo: other m41 precision: precision) and: [
		(m42 closeTo: other m42 precision: precision) and: [
		(m43 closeTo: other m43 precision: precision) and: [
		(m44 closeTo: other m44 precision: precision) ]]]]]]]]]]]]]]]]
]

{ #category : #arithmetic }
Matrix4x4 >> cofactorAtRow: row atColumn: column [
	^ (self minorMatrixAtRow: row atColumn: column) determinant * ((row + column) even ifTrue: [ 1 ] ifFalse: [ -1 ])
]

{ #category : #enumerating }
Matrix4x4 >> collect: aBlock [
	^ self class basicNew
		m11: (aBlock value: m11);
		m12: (aBlock value: m12);
		m13: (aBlock value: m13);
		m14: (aBlock value: m14);

		m21: (aBlock value: m21);
		m22: (aBlock value: m22);
		m23: (aBlock value: m23);
		m24: (aBlock value: m24);

		m31: (aBlock value: m31);
		m32: (aBlock value: m32);
		m33: (aBlock value: m33);
		m34: (aBlock value: m34);

		m41: (aBlock value: m41);
		m42: (aBlock value: m42);
		m43: (aBlock value: m43);
		m44: (aBlock value: m44);

		yourself
]

{ #category : #testing }
Matrix4x4 >> determinant [
	^ ((self minorAtRow: 1 atColumn: 1) * m11)
		- ((self minorAtRow: 1 atColumn: 2) * m12)
		+ ((self minorAtRow: 1 atColumn: 3) * m13)
		- ((self minorAtRow: 1 atColumn: 4) * m14)
]

{ #category : #accessing }
Matrix4x4 >> firstColumn [
	^ Vector4 x: m11 y: m21 z: m31 w: m41
]

{ #category : #accessing }
Matrix4x4 >> firstColumn: column [
	| coercedColumn |
	coercedColumn := column asVector4.
	m11 := coercedColumn x.
	m21 := coercedColumn y.
	m31 := coercedColumn z.
	m41 := coercedColumn w.
]

{ #category : #accessing }
Matrix4x4 >> firstRow [
	^ Vector4 x: m11 y: m12 z: m13 w: m14
]

{ #category : #accessing }
Matrix4x4 >> firstRow: row [
	| coercedRow |
	coercedRow := row asVector4.
	m11 := coercedRow x.
	m12 := coercedRow y.
	m13 := coercedRow z.
	m14 := coercedRow w.
]

{ #category : #accessing }
Matrix4x4 >> fourthColumn [
	^ Vector4 x: m14 y: m24 z: m34 w: m44
]

{ #category : #accessing }
Matrix4x4 >> fourthColumn: column [
	| coercedColumn |
	coercedColumn := column asVector4.
	m14 := coercedColumn x.
	m24 := coercedColumn y.
	m34 := coercedColumn z.
	m44 := coercedColumn w.
]

{ #category : #accessing }
Matrix4x4 >> fourthRow [
	^ Vector4 x: m41 y: m42 z: m43 w: m44
]

{ #category : #accessing }
Matrix4x4 >> fourthRow: row [
	| coercedRow |
	coercedRow := row asVector4.
	m41 := coercedRow x.
	m42 := coercedRow y.
	m43 := coercedRow z.
	m44 := coercedRow w.
]

{ #category : #comparing }
Matrix4x4 >> hash [
	| result |
	result := m11 hash.
	result := result hashMultiply + m12 hash.
	result := result hashMultiply + m13 hash.
	result := result hashMultiply + m14 hash.

	result := result hashMultiply + m21 hash.
	result := result hashMultiply + m22 hash.
	result := result hashMultiply + m23 hash.
	result := result hashMultiply + m24 hash.

	result := result hashMultiply + m31 hash.
	result := result hashMultiply + m32 hash.
	result := result hashMultiply + m33 hash.
	result := result hashMultiply + m34 hash.

	result := result hashMultiply + m41 hash.
	result := result hashMultiply + m42 hash.
	result := result hashMultiply + m43 hash.
	result := result hashMultiply + m44 hash.

	^ result
]

{ #category : #initialization }
Matrix4x4 >> initialize [
	m11 := 0. m12 := 0. m13 := 0. m14 := 0.
	m21 := 0. m22 := 0. m23 := 0. m24 := 0.
	m31 := 0. m32 := 0. m33 := 0. m34 := 0.
	m41 := 0. m42 := 0. m43 := 0. m44 := 0.
]

{ #category : #arithmetic }
Matrix4x4 >> inverse [
	| det detVector adjugate |
	det := self determinant.
	(det = 0) ifTrue: [ ^ self error: 'Matrix is not invertible.' ].

	detVector := det asVector4.
	adjugate := self adjugateMatrix.
	^ self class basicNew
		firstColumn: adjugate firstColumn / detVector;
		secondColumn: adjugate secondColumn / detVector;
		thirdColumn: adjugate thirdColumn / detVector;
		fourthColumn: adjugate fourthColumn / detVector;
		yourself
]

{ #category : #comparing }
Matrix4x4 >> isIdentity [
	^  m11 = 1 and: [ m12 = 0 and: [ m13 = 0 and: [ m14 = 0 and: [
		m21 = 0 and: [ m22 = 1 and: [ m23 = 0 and: [ m24 = 0 and: [
		m31 = 0 and: [ m32 = 0 and: [ m33 = 1 and: [ m34 = 0 and: [
		m41 = 0 and: [ m42 = 0 and: [ m43 = 0 and: [ m44 = 1 ]]]]]]]]]]]]]]]
]

{ #category : #comparing }
Matrix4x4 >> isOnes [
	^  m11 = 1 and: [ m12 = 1 and: [ m13 = 1 and: [ m14 = 1 and: [
		m21 = 1 and: [ m22 = 1 and: [ m23 = 1 and: [ m24 = 1 and: [
		m31 = 1 and: [ m32 = 1 and: [ m33 = 1 and: [ m34 = 1 and: [
		m41 = 1 and: [ m42 = 1 and: [ m43 = 1 and: [ m44 = 1 ]]]]]]]]]]]]]]]
]

{ #category : #comparing }
Matrix4x4 >> isZeros [
	^  m11 = 0 and: [ m12 = 0 and: [ m13 = 0 and: [ m14 = 0 and: [
		m21 = 0 and: [ m22 = 0 and: [ m23 = 0 and: [ m24 = 0 and: [
		m31 = 0 and: [ m32 = 0 and: [ m33 = 0 and: [ m34 = 0 and: [
		m41 = 0 and: [ m42 = 0 and: [ m43 = 0 and: [ m44 = 0 ]]]]]]]]]]]]]]]
]

{ #category : #accessing }
Matrix4x4 >> m11 [

	^ m11
]

{ #category : #accessing }
Matrix4x4 >> m11: anObject [

	m11 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m12 [

	^ m12
]

{ #category : #accessing }
Matrix4x4 >> m12: anObject [

	m12 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m13 [

	^ m13
]

{ #category : #accessing }
Matrix4x4 >> m13: anObject [

	m13 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m14 [

	^ m14
]

{ #category : #accessing }
Matrix4x4 >> m14: anObject [

	m14 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m21 [

	^ m21
]

{ #category : #accessing }
Matrix4x4 >> m21: anObject [

	m21 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m22 [

	^ m22
]

{ #category : #accessing }
Matrix4x4 >> m22: anObject [

	m22 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m23 [

	^ m23
]

{ #category : #accessing }
Matrix4x4 >> m23: anObject [

	m23 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m24 [

	^ m24
]

{ #category : #accessing }
Matrix4x4 >> m24: anObject [

	m24 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m31 [

	^ m31
]

{ #category : #accessing }
Matrix4x4 >> m31: anObject [

	m31 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m32 [

	^ m32
]

{ #category : #accessing }
Matrix4x4 >> m32: anObject [

	m32 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m33 [

	^ m33
]

{ #category : #accessing }
Matrix4x4 >> m33: anObject [

	m33 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m34 [

	^ m34
]

{ #category : #accessing }
Matrix4x4 >> m34: anObject [

	m34 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m41 [

	^ m41
]

{ #category : #accessing }
Matrix4x4 >> m41: anObject [

	m41 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m42 [

	^ m42
]

{ #category : #accessing }
Matrix4x4 >> m42: anObject [

	m42 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m43 [

	^ m43
]

{ #category : #accessing }
Matrix4x4 >> m43: anObject [

	m43 := anObject
]

{ #category : #accessing }
Matrix4x4 >> m44 [

	^ m44
]

{ #category : #accessing }
Matrix4x4 >> m44: anObject [

	m44 := anObject
]

{ #category : #arithmetic }
Matrix4x4 >> minorAtRow: row atColumn: column [
	^ (self minorMatrixAtRow: row atColumn: column) determinant
]

{ #category : #arithmetic }
Matrix4x4 >> minorMatrixAtRow: row atColumn: column [
	| result |
	result := Matrix3x3 basicNew.
	column = 1 ifTrue: [
		^ result
			firstColumn: (self secondColumn minorAt: row);
			secondColumn: (self thirdColumn minorAt: row);
			thirdColumn: (self fourthColumn minorAt: row);
			yourself
	].
	column = 2 ifTrue: [
		^ result
			firstColumn: (self firstColumn minorAt: row);
			secondColumn: (self thirdColumn minorAt: row);
			thirdColumn: (self fourthColumn minorAt: row);
			yourself
	].
	column = 3 ifTrue: [
		^ result
			firstColumn: (self firstColumn minorAt: row);
			secondColumn: (self secondColumn minorAt: row);
			thirdColumn: (self fourthColumn minorAt: row);
			yourself
	].
	column = 4 ifTrue: [
		^ result
			firstColumn: (self firstColumn minorAt: row);
			secondColumn: (self secondColumn minorAt: row);
			thirdColumn: (self thirdColumn minorAt: row);
			yourself
	].
	self error
]

{ #category : #arithmetic }
Matrix4x4 >> multiplyWithMatrix: other [
	| coerced |
	coerced := other asMatrix4x4.
	^ self class basicNew
		firstColumn: (self firstColumn * coerced firstColumn x) + (self secondColumn * coerced firstColumn y) + (self thirdColumn * coerced firstColumn z) + (self fourthColumn * coerced firstColumn w);
		secondColumn: (self firstColumn * coerced secondColumn x) + (self secondColumn * coerced secondColumn y) + (self thirdColumn * coerced secondColumn z) + (self fourthColumn * coerced secondColumn w);
		thirdColumn: (self firstColumn * coerced thirdColumn x) + (self secondColumn * coerced thirdColumn y) + (self thirdColumn * coerced thirdColumn z) + (self fourthColumn * coerced thirdColumn w);
		fourthColumn: (self firstColumn * coerced fourthColumn x) + (self secondColumn * coerced fourthColumn y) + (self thirdColumn * coerced fourthColumn z) + (self fourthColumn * coerced fourthColumn w);
		yourself

]

{ #category : #arithmetic }
Matrix4x4 >> postMultiplyVector: vector [
	| coercedVector |
	coercedVector := vector asVector4.
	^ Vector4
		x: (self firstColumn dot: coercedVector)
		y: (self secondColumn dot: coercedVector)
		z: (self thirdColumn dot: coercedVector)
		w: (self fourthColumn dot: coercedVector)
]

{ #category : #arithmetic }
Matrix4x4 >> preMultiplyVector: vector [
	| coercedVector |
	coercedVector := vector asVector4.
	^ Vector4
		x: (m11 * coercedVector x) + (m12 * coercedVector y) + (m13 * coercedVector z) + (m14 * coercedVector w)
		y: (m21 * coercedVector x) + (m22 * coercedVector y) + (m23 * coercedVector z) + (m24 * coercedVector w)
		z: (m31 * coercedVector x) + (m32 * coercedVector y) + (m33 * coercedVector z) + (m34 * coercedVector w)
		w: (m41 * coercedVector x) + (m42 * coercedVector y) + (m43 * coercedVector z) + (m44 * coercedVector w)
]

{ #category : #printing }
Matrix4x4 >> printOn: aStream [
	aStream nextPut: $(; nextPutAll: self class name; nextPutAll: ' rows: #('; cr;
		tab; print: m11; space; print: m12; space; print: m13; space; print: m14; cr;
		tab; print: m21; space; print: m22; space; print: m23; space; print: m24; cr;
		tab; print: m31; space; print: m32; space; print: m33; space; print: m34; cr;
		tab; print: m41; space; print: m42; space; print: m43; space; print: m44; cr;
		nextPutAll: ')'
]

{ #category : #accessing }
Matrix4x4 >> secondColumn [
	^ Vector4 x: m12 y: m22 z: m32 w: m42
]

{ #category : #accessing }
Matrix4x4 >> secondColumn: column [
	| coercedColumn |
	coercedColumn := column asVector4.
	m12 := coercedColumn x.
	m22 := coercedColumn y.
	m32 := coercedColumn z.
	m42 := coercedColumn w.
]

{ #category : #accessing }
Matrix4x4 >> secondRow [
	^ Vector4 x: m21 y: m22 z: m23 w: m24
]

{ #category : #accessing }
Matrix4x4 >> secondRow: row [
	| coercedRow |
	coercedRow := row asVector4.
	m21 := coercedRow x.
	m22 := coercedRow y.
	m23 := coercedRow z.
	m24 := coercedRow w.
]

{ #category : #initialization }
Matrix4x4 >> setIdentity [
	m11 := 1. m12 := 0. m13 := 0. m14 := 0.
	m21 := 0. m22 := 1. m23 := 0. m24 := 0.
	m31 := 0. m32 := 0. m33 := 1. m34 := 0.
	m41 := 0. m42 := 0. m43 := 0. m44 := 1.
]

{ #category : #accessing }
Matrix4x4 >> thirdColumn [
	^ Vector4 x: m13 y: m23 z: m33 w: m43
]

{ #category : #accessing }
Matrix4x4 >> thirdColumn: column [
	| coercedColumn |
	coercedColumn := column asVector4.
	m13 := coercedColumn x.
	m23 := coercedColumn y.
	m33 := coercedColumn z.
	m43 := coercedColumn w.
]

{ #category : #accessing }
Matrix4x4 >> thirdRow [
	^ Vector4 x: m31 y: m32 z: m33 w: m34
]

{ #category : #accessing }
Matrix4x4 >> thirdRow: row [
	| coercedRow |
	coercedRow := row asVector4.
	m31 := coercedRow x.
	m32 := coercedRow y.
	m33 := coercedRow z.
	m34 := coercedRow w.
]

{ #category : #'as yet unclassified' }
Matrix4x4 >> topLeft3x3 [
	^ Matrix3x3 basicNew
		m11: m11; m12: m12; m13: m13;
		m21: m21; m22: m22; m23: m23;
		m31: m31; m32: m32; m33: m33;
		yourself
]

{ #category : #arithmetic }
Matrix4x4 >> transformPosition3: position [
	^ Vector3
		x: (m11 * position x) + (m12 * position y) + (m13 * position x) + m14
		y: (m21 * position x) + (m22 * position y) + (m23 * position x) + m24
		z: (m31 * position x) + (m32 * position y) + (m33 * position x) + m34
]

{ #category : #arithmetic }
Matrix4x4 >> transformVector3: vector [
	^ Vector3
		x: (m11 * vector x) + (m12 * vector y) + (m13 * vector x)
		y: (m21 * vector x) + (m22 * vector y) + (m23 * vector x)
		z: (m31 * vector x) + (m32 * vector y) + (m33 * vector x)
]

{ #category : #accessing }
Matrix4x4 >> transpose [
	^ self class basicNew
		m11: m11; m12: m21; m13: m31; m14: m41;
		m21: m12; m22: m22; m23: m32; m24: m42;
		m31: m13; m32: m23; m33: m33; m34: m43;
		m41: m14; m42: m24; m43: m34; m44: m44
]

{ #category : #enumerating }
Matrix4x4 >> with: other collect: aBlock [
	| coercedOther |
	coercedOther := other asMatrix4x4.
	^ self class basicNew
		m11: (aBlock value: m11 value: other m11);
		m12: (aBlock value: m12 value: other m12);
		m13: (aBlock value: m13 value: other m13);
		m14: (aBlock value: m14 value: other m14);

		m21: (aBlock value: m21 value: other m21);
		m22: (aBlock value: m22 value: other m22);
		m23: (aBlock value: m23 value: other m23);
		m24: (aBlock value: m24 value: other m24);

		m31: (aBlock value: m31 value: other m31);
		m32: (aBlock value: m32 value: other m32);
		m33: (aBlock value: m33 value: other m33);
		m34: (aBlock value: m34 value: other m34);

		m41: (aBlock value: m41 value: other m41);
		m42: (aBlock value: m42 value: other m42);
		m43: (aBlock value: m43 value: other m43);
		m44: (aBlock value: m44 value: other m44);

		yourself
]

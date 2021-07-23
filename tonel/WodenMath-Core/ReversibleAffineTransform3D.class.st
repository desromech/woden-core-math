Class {
	#name : #ReversibleAffineTransform3D,
	#superclass : #Object,
	#instVars : [
		'matrix',
		'inverseMatrix',
		'translation',
		'inverseTranslation'
	],
	#category : #'WodenMath-Core-Transform'
}

{ #category : #'instance creation' }
ReversibleAffineTransform3D class >> from: eye lookAt: reference up: upVector [
	^ self from: eye lookAtDirection: reference - eye up: upVector.
]

{ #category : #'instance creation' }
ReversibleAffineTransform3D class >> from: eye lookAtDirection: direction up: upVector [
	^ self basicNew
		setOrthonormalMatrix: (self matrix3x3Type lookAtDirection: direction normalized up: upVector) translation: eye;
		yourself.
		
]

{ #category : #'instance creation' }
ReversibleAffineTransform3D class >> fromInvertibleMatrix4: matrix4 [
	^ self basicNew setInvertibleMatrix4: matrix4; yourself
]

{ #category : #'instance creation' }
ReversibleAffineTransform3D class >> identity [
	^ self basicNew setIdentity; yourself
]

{ #category : #comparing }
ReversibleAffineTransform3D >> = other [
	^ self class == other class and: [
	matrix = other matrix and: [
	translation = other translation and: [
	inverseMatrix = other inverseMatrix and: [
	inverseTranslation = other inverseTranslation ]]]]
]

{ #category : #comparing }
ReversibleAffineTransform3D >> hash [
	^ self class identityHash bitXor: (matrix hash bitXor: (
	translation hash bitXor: (
	inverseMatrix hash bitXor: inverseTranslation hash)))
]

{ #category : #initialization }
ReversibleAffineTransform3D >> initialize [
	matrix := Matrix3x3 zeros.
	inverseMatrix := Matrix3x3 zeros.
	translation := Vector3 zeros.
	inverseTranslation := Vector3 zeros.
]

{ #category : #operations }
ReversibleAffineTransform3D >> inverse [
	^ self class basicNew
		setMatrix: inverseMatrix inverseMatrix: matrix translation: inverseTranslation
]

{ #category : #accessing }
ReversibleAffineTransform3D >> inverseMatrix [

	^ inverseMatrix
]

{ #category : #accessing }
ReversibleAffineTransform3D >> inverseMatrix4 [
	^ Matrix4x4 mat3: inverseMatrix translation: inverseTranslation
]

{ #category : #accessing }
ReversibleAffineTransform3D >> inverseTranslation [

	^ inverseTranslation
]

{ #category : #testing }
ReversibleAffineTransform3D >> isIdentity [
	^ matrix isIdentity and: [ translation isZeros ]
]

{ #category : #accessing }
ReversibleAffineTransform3D >> matrix [

	^ matrix
]

{ #category : #accessing }
ReversibleAffineTransform3D >> matrix4 [
	^ Matrix4x4 mat3: matrix translation: translation
]

{ #category : #initialization }
ReversibleAffineTransform3D >> setIdentity [
	matrix := Matrix3x3 identity.
	inverseMatrix := Matrix3x3 identity.
	translation := Vector3 zeros.
	inverseTranslation := Vector3 zeros.
]

{ #category : #accessing }
ReversibleAffineTransform3D >> setMatrix4: matrix4 inverseMatrix4: inverseMatrix4 [
	matrix := matrix4 topLeft3x3.
	translation := matrix4 fourthColumn xyz.

	inverseMatrix := inverseMatrix4 topLeft3x3.
	inverseTranslation := inverseMatrix4 fourthColumn xyz
]

{ #category : #accessing }
ReversibleAffineTransform3D >> setMatrix: newMatrix inverseMatrix: newInverseMatrix translation: newTranslation [
	matrix := newMatrix asMatrix3x3.
	inverseMatrix := newInverseMatrix asMatrix3x3.
	translation := newTranslation asVector3.
	inverseTranslation := inverseMatrix * translation negated
]

{ #category : #accessing }
ReversibleAffineTransform3D >> setOrthonormalMatrix: newMatrix [
	matrix := newMatrix asMatrix3x3.
	inverseMatrix := matrix transpose.
	
	"Recompute the inverse translation."
	inverseTranslation := inverseMatrix * translation negated.
]

{ #category : #accessing }
ReversibleAffineTransform3D >> setOrthonormalMatrix: newMatrix translation: newTranslation [
	self setMatrix: newMatrix inverseMatrix: newMatrix asMatrix3x3 transpose translation: newTranslation
]

{ #category : #accessing }
ReversibleAffineTransform3D >> translation [

	^ translation
]

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

{ #category : #'as yet unclassified' }
ReversibleAffineTransform3D class >> orthonormal: matrix translation: translation [
	^ self basicNew setOrthonormalMatrix: matrix translation: translation
]

{ #category : #'instance creation' }
ReversibleAffineTransform3D class >> rotation: aRotation translation: aTranslation [
	^ self basicNew setRotation: aRotation translation: aTranslation
]

{ #category : #'instance creation' }
ReversibleAffineTransform3D class >> scale: aScale rotation: aRotation translation: aTranslation [
	^ self basicNew setScale: aScale rotation: aRotation translation: aTranslation
]

{ #category : #'instance creation' }
ReversibleAffineTransform3D class >> translation: aTranslation [
	^ self basicNew setIdentity; translation: aTranslation; yourself
]

{ #category : #comparing }
ReversibleAffineTransform3D >> = other [
	^ self class == other class and: [
	matrix = other matrix and: [
	translation = other translation and: [
	inverseMatrix = other inverseMatrix and: [
	inverseTranslation = other inverseTranslation ]]]]
]

{ #category : #transforming }
ReversibleAffineTransform3D >> applyMatrix: extraMatrix inverseMatrix: extraMatrixInverse [
	matrix := extraMatrix * matrix.
	inverseMatrix := inverseMatrix * extraMatrixInverse.
	translation := extraMatrix * translation.
	inverseTranslation := extraMatrixInverse * inverseTranslation
]

{ #category : #transforming }
ReversibleAffineTransform3D >> applyOrthonormalMatrix: orthonormal [
	^ self applyMatrix: orthonormal inverseMatrix: orthonormal transpose
]

{ #category : #converting }
ReversibleAffineTransform3D >> asReversibleAffineTransform [
	^ self
]

{ #category : #converting }
ReversibleAffineTransform3D >> asTRSTransform3D [
	^ TRSTransform3D matrix: matrix translation: translation
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

{ #category : #transforming }
ReversibleAffineTransform3D >> inverseTransformNormalVector: vector [
	^ vector * matrix
]

{ #category : #transforming }
ReversibleAffineTransform3D >> inverseTransformPosition: aPosition [
	^ (inverseMatrix*aPosition) + inverseTranslation
]

{ #category : #arithmetic }
ReversibleAffineTransform3D >> inverseTransformTransform: transform [
	^ self class basicNew
		setMatrix: inverseMatrix * transform matrix
		inverseMatrix: transform inverseMatrix * matrix
		translation: (inverseMatrix * transform translation) + inverseTranslation;
		yourself.
]

{ #category : #transforming }
ReversibleAffineTransform3D >> inverseTransformVector3: aVector3 [
	^ inverseMatrix*aVector3
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

{ #category : #transforming }
ReversibleAffineTransform3D >> rotateDegreesOnX: amount [
	self rotateRadiansOnX: amount degreesToRadians.
]

{ #category : #transforming }
ReversibleAffineTransform3D >> rotateDegreesOnY: amount [
	self rotateRadiansOnY: amount degreesToRadians.
]

{ #category : #transforming }
ReversibleAffineTransform3D >> rotateDegreesOnZ: amount [
	self rotateRadiansOnZ: amount degreesToRadians.
]

{ #category : #transforming }
ReversibleAffineTransform3D >> rotateRadiansOnX: amount [
	self applyOrthonormalMatrix: (Matrix3x3 xRotation: amount).
]

{ #category : #transforming }
ReversibleAffineTransform3D >> rotateRadiansOnY: amount [
	self applyOrthonormalMatrix: (Matrix3x3 yRotation: amount).
]

{ #category : #transforming }
ReversibleAffineTransform3D >> rotateRadiansOnZ: amount [
	self applyOrthonormalMatrix: (Matrix3x3 zRotation: amount).
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

{ #category : #initialization }
ReversibleAffineTransform3D >> setRotation: anOrientation translation: aTranslation [
	self setOrthonormalMatrix: anOrientation asMatrix3x3 translation: aTranslation
]

{ #category : #initialization }
ReversibleAffineTransform3D >> setScale: aScale rotation: anOrientation translation: aTranslation [
	| orientationMatrix scaleMatrix inverseScaleMatrix |
	orientationMatrix := anOrientation asMatrix3x3.
	scaleMatrix := Matrix3x3 scale: aScale.
	inverseScaleMatrix := Matrix3x3 scale: aScale safeReciprocal.
	self setMatrix: orientationMatrix * scaleMatrix inverseMatrix: inverseScaleMatrix * orientationMatrix transpose translation: aTranslation
]

{ #category : #transforming }
ReversibleAffineTransform3D >> transformNormalVector: vector [
	^ vector * inverseMatrix
]

{ #category : #transforming }
ReversibleAffineTransform3D >> transformPosition: aPosition [
	^ (matrix*aPosition) + translation
]

{ #category : #arithmetic }
ReversibleAffineTransform3D >> transformTransform: transform [
	^ self class basicNew
		setMatrix: matrix * transform matrix
		inverseMatrix: transform inverseMatrix * inverseMatrix
		translation: translation + (matrix * transform translation);
		yourself.
]

{ #category : #transforming }
ReversibleAffineTransform3D >> transformVector3: aVector3 [
	^ matrix * aVector3
]

{ #category : #transforming }
ReversibleAffineTransform3D >> translateBy: vector3 [
	self translation: translation  + vector3
]

{ #category : #transforming }
ReversibleAffineTransform3D >> translateByX: x [
	self translateBy: (Vector3 x: x y: 0 z: 0)
]

{ #category : #transforming }
ReversibleAffineTransform3D >> translateByY: y [
	self translateBy: (Vector3 x: 0 y: y z: 0)
]

{ #category : #transforming }
ReversibleAffineTransform3D >> translateByZ: z [
	self translateBy: (Vector3 x: 0 y: 0 z: z)
]

{ #category : #accessing }
ReversibleAffineTransform3D >> translation [

	^ translation
]

{ #category : #accessing }
ReversibleAffineTransform3D >> translation: newTranslation [
	translation := newTranslation shallowCopy.
	inverseTranslation := inverseMatrix * translation negated.
]

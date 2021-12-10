"
I am a 3D transform that is decomposed in a successive sequence of scale, rotation, and translation.
"
Class {
	#name : #TRSTransform3D,
	#superclass : #Object,
	#instVars : [
		'scale',
		'rotation',
		'translation'
	],
	#category : #'WodenMath-Core-Transform'
}

{ #category : #'instance creation' }
TRSTransform3D class >> identity [
	^ self new
]

{ #category : #converting }
TRSTransform3D >> asReversibleAffineTransform [
	^ ReversibleAffineTransform3D scale: scale rotation: rotation translation: translation
]

{ #category : #converting }
TRSTransform3D >> asTRSTransform3D [
	^ self
]

{ #category : #initialization }
TRSTransform3D >> initialize [
	self setIdentity.
]

{ #category : #testing }
TRSTransform3D >> isIdentity [
	^ scale = Vector3 ones and: [ rotation = Quaternion identity and: [ translation = Vector3 zeros ] ]
]

{ #category : #accessing }
TRSTransform3D >> matrix [
	^ rotation asMatrix3x3 * (Matrix3x3 scale: scale)
]

{ #category : #accessing }
TRSTransform3D >> matrix4 [
	^ Matrix4x4 mat3: self matrix translation: translation
]

{ #category : #transforming }
TRSTransform3D >> rotateDegreesOnX: amount [
	self rotateRadiansOnX: amount degreesToRadians
]

{ #category : #transforming }
TRSTransform3D >> rotateDegreesOnY: amount [
	self rotateRadiansOnY: amount degreesToRadians
]

{ #category : #transforming }
TRSTransform3D >> rotateDegreesOnZ: amount [
	self rotateRadiansOnZ: amount degreesToRadians
]

{ #category : #transforming }
TRSTransform3D >> rotateRadiansOnX: amount [
	rotation := (Quaternion xRotation: amount) * rotation
]

{ #category : #transforming }
TRSTransform3D >> rotateRadiansOnY: amount [
	rotation := (Quaternion yRotation: amount) * rotation
]

{ #category : #transforming }
TRSTransform3D >> rotateRadiansOnZ: amount [
	rotation := (Quaternion zRotation: amount) * rotation
]

{ #category : #accessing }
TRSTransform3D >> rotation [

	^ rotation
]

{ #category : #accessing }
TRSTransform3D >> rotation: anObject [

	rotation := anObject
]

{ #category : #accessing }
TRSTransform3D >> scale [

	^ scale
]

{ #category : #accessing }
TRSTransform3D >> scale: anObject [

	scale := anObject
]

{ #category : #initialization }
TRSTransform3D >> setIdentity [
	scale := Vector3 ones.
	rotation := Quaternion identity.
	translation := Vector3 zeros.
]

{ #category : #transforming }
TRSTransform3D >> transformNormalVector: vector3 [
	^ (rotation transformVector3: vector3 / scale) normalized
]

{ #category : #transforming }
TRSTransform3D >> transformPosition: position [
	^ (rotation transformVector3:  scale * position) + translation
]

{ #category : #transforming }
TRSTransform3D >> transformVector3: vector3 [
	^ (rotation transformVector3: scale * vector3)
]

{ #category : #transforming }
TRSTransform3D >> translateBy: vector [
	translation := translation + vector
]

{ #category : #transforming }
TRSTransform3D >> translateByX: distance [
	translation := translation + (Vector3 x: distance)
]

{ #category : #transforming }
TRSTransform3D >> translateByY: distance [
	translation := translation + (Vector3 y: distance)
]

{ #category : #transforming }
TRSTransform3D >> translateByZ: distance [
	translation := translation + (Vector3 z: distance)
]

{ #category : #transforming }
TRSTransform3D >> translateToX: x y: y z: z [
	self translation: (Vector3 x: x y: y z: z)
]

{ #category : #accessing }
TRSTransform3D >> translation [

	^ translation
]

{ #category : #accessing }
TRSTransform3D >> translation: anObject [

	translation := anObject
]

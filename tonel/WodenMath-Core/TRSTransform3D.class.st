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

{ #category : #serialization }
TRSTransform3D class >> loadFromJson: jsonData [
	^ self new
		scale: (Vector3 loadFromJson: jsonData);
		rotation: (Quaternion loadFromJson: jsonData);
		translation: (Vector3 loadFromJson: jsonData);
		yourself
]

{ #category : #accessing }
TRSTransform3D class >> rotation: aRotation [
	^ self new rotation: aRotation; yourself
]

{ #category : #accessing }
TRSTransform3D class >> scale: aScale [
	^ self new scale: aScale; yourself
]

{ #category : #accessing }
TRSTransform3D class >> translation: aTranslation [
	^ self new translation: aTranslation; yourself
]

{ #category : #comparing }
TRSTransform3D >> = other [
	^ self class == other class and: [ scale = other scale and: [ rotation = other rotation and: [ translation = other translation ] ] ]
]

{ #category : #converting }
TRSTransform3D >> asReversibleAffineTransform [
	^ ReversibleAffineTransform3D scale: scale rotation: rotation translation: translation
]

{ #category : #converting }
TRSTransform3D >> asTRSTransform3D [
	^ self
]

{ #category : #comparing }
TRSTransform3D >> closeTo: other [
	^ self class == other class and: [
		(scale closeTo: other scale) and: [
		(rotation closeTo: other rotation) and: [
		(translation closeTo: other translation) ] ] ]
]

{ #category : #comparing }
TRSTransform3D >> closeTo: other precision: precision [
	^ self class == other class and: [
		(scale closeTo: other scale precision: precision) and: [
		(rotation closeTo: other rotation precision: precision) and: [
		(translation closeTo: other translation precision: precision) ] ] ]
]

{ #category : #serialization }
TRSTransform3D >> encodeForJSON [
	^ OrderedDictionary newFromPairs: { 
		#scale . scale encodeForJSON.
		#rotation . rotation encodeForJSON.
		#translation . translation encodeForJSON.
	}
]

{ #category : #comparing }
TRSTransform3D >> hash [
	^ self class identityHash bitXor: (scale hash bitXor: (
	rotation hash bitXor: (
	translation hash)))
]

{ #category : #initialization }
TRSTransform3D >> initialize [
	self setIdentity.
]

{ #category : #operations }
TRSTransform3D >> inverse [
	^ self class basicNew
		scale: self inverseScale;
		rotation: self inverseRotation;
		translation: self inverseTranslation;
		yourself
]

{ #category : #accessing }
TRSTransform3D >> inverseRotation [
	^ rotation conjugated
]

{ #category : #accessing }
TRSTransform3D >> inverseScale [
	^ rotation rotateScale: scale safeReciprocal
]

{ #category : #transforming }
TRSTransform3D >> inverseTransformPosition: position [
	^ (rotation conjugated transformVector3: position - translation) / scale
]

{ #category : #transforming }
TRSTransform3D >> inverseTransformTransform: otherTransform [
	^ self inverse transformTransform: otherTransform
]

{ #category : #transforming }
TRSTransform3D >> inverseTransformVector3: vector3 [
	^ (rotation conjugated transformVector3: vector3) / scale
]

{ #category : #accessing }
TRSTransform3D >> inverseTranslation [
	^ scale safeReciprocal * (rotation inverseRotateVector: translation negated)
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

{ #category : #printing }
TRSTransform3D >> printOn: aStream [
	aStream nextPut: $(; nextPutAll: self class name;
		nextPutAll:  ' scale: '; print: scale;
		nextPutAll:  ' rotation: '; print: rotation;
		nextPutAll:  ' translation: '; print: translation;
		nextPut: $)
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
	^ rotation transformVector3: vector3 / scale
]

{ #category : #transforming }
TRSTransform3D >> transformPosition: position [
	^ (rotation transformVector3: scale * position) + translation
]

{ #category : #arithmetic }
TRSTransform3D >> transformTransform: otherTransform [
	self assert: otherTransform class == self class.
	^ self class basicNew
		scale: (otherTransform rotation inverseRotateScale: scale) * otherTransform scale;
		rotation: rotation * otherTransform rotation;
		translation: (self transformPosition: otherTransform translation);
		yourself
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

"
I am a rigid transform which is composed of a rotational and translational component. I do not have any scaling component.
"
Class {
	#name : #RigidTransform3D,
	#superclass : #Object,
	#instVars : [
		'rotation',
		'translation'
	],
	#category : #'WodenMath-Core-Transform'
}

{ #category : #'instance creation' }
RigidTransform3D class >> identity [
	^ self new
]

{ #category : #serialization }
RigidTransform3D class >> loadFromJson: jsonData [
	^ self new
		rotation: (Quaternion loadFromJson: (jsonData at: #rotation));
		translation: (Vector3 loadFromJson: (jsonData at: #translation));
		yourself
]

{ #category : #accessing }
RigidTransform3D class >> rotation: aRotation [
	^ self new rotation: aRotation; yourself
]

{ #category : #accessing }
RigidTransform3D class >> rotation: aRotation around: pivot [
	^ self new
		rotation: aRotation;
		translation: pivot - (aRotation rotateVector: pivot);
		yourself
]

{ #category : #accessing }
RigidTransform3D class >> translation: aTranslation [
	^ self new translation: aTranslation; yourself
]

{ #category : #comparing }
RigidTransform3D >> = other [
	^ self class == other class and: [ rotation = other rotation and: [ translation = other translation ] ]
]

{ #category : #converting }
RigidTransform3D >> asTRSTransform3D [
	^ TRSTransform3D new rotation: rotation; translation: translation; yourself
]

{ #category : #comparing }
RigidTransform3D >> closeTo: other [
	^ self class == other class and: [
		(rotation closeTo: other rotation) and: [
		(translation closeTo: other translation) ] ]
]

{ #category : #comparing }
RigidTransform3D >> closeTo: other precision: precision [
	^ self class == other class and: [
		(rotation closeTo: other rotation precision: precision) and: [
		(translation closeTo: other translation precision: precision) ] ]
]

{ #category : #serialization }
RigidTransform3D >> encodeForJSON [
	^ OrderedDictionary newFromPairs: { 
		#rotation . rotation encodeForJSON.
		#translation . translation encodeForJSON.
	}
]

{ #category : #comparing }
RigidTransform3D >> hash [
	^ self class identityHash bitXor: (rotation hash bitXor: (
	translation hash))
]

{ #category : #initialization }
RigidTransform3D >> initialize [
	self setIdentity.
]

{ #category : #operations }
RigidTransform3D >> inverse [
	^ self class basicNew
		rotation: self inverseRotation;
		translation: self inverseTranslation;
		yourself
]

{ #category : #accessing }
RigidTransform3D >> inverseRotation [
	^ rotation conjugated
]

{ #category : #transforming }
RigidTransform3D >> inverseTransformNormalVector: vector3 [
	^ rotation conjugated transformVector3: vector3
]

{ #category : #transforming }
RigidTransform3D >> inverseTransformPosition: position [
	^ rotation conjugated transformVector3: position - translation
]

{ #category : #transforming }
RigidTransform3D >> inverseTransformVector3: vector3 [
	^ rotation conjugated transformVector3: vector3
]

{ #category : #accessing }
RigidTransform3D >> inverseTranslation [
	^ rotation inverseRotateVector: translation negated
]

{ #category : #matrix }
RigidTransform3D >> matrix [
	^ rotation asMatrix3x3
]

{ #category : #accessing }
RigidTransform3D >> matrix4 [
	^ Matrix4x4 mat3: self matrix translation: translation
]

{ #category : #accessing }
RigidTransform3D >> rotation [

	^ rotation
]

{ #category : #accessing }
RigidTransform3D >> rotation: anObject [

	rotation := anObject
]

{ #category : #accessing }
RigidTransform3D >> scale [
	^ Vector3 ones.
]

{ #category : #initialization }
RigidTransform3D >> setIdentity [
	rotation := Quaternion identity.
	translation := Vector3 zeros.
]

{ #category : #transforming }
RigidTransform3D >> transformNormalVector: vector3 [
	^ rotation transformVector3: vector3
]

{ #category : #transforming }
RigidTransform3D >> transformPosition: position [
	^ (rotation transformVector3: position) + translation
]

{ #category : #arithmetic }
RigidTransform3D >> transformTransform: otherTransform [
	self assert: otherTransform class == self class.
	^ self class basicNew
		rotation: rotation * otherTransform rotation;
		translation: (self transformPosition: otherTransform translation);
		yourself
]

{ #category : #transforming }
RigidTransform3D >> transformVector3: vector3 [
	^ rotation transformVector3: vector3
]

{ #category : #accessing }
RigidTransform3D >> translation [

	^ translation
]

{ #category : #accessing }
RigidTransform3D >> translation: anObject [

	translation := anObject
]

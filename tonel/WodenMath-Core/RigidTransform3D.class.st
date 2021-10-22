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

{ #category : #initialization }
RigidTransform3D >> initialize [
	self setIdentity.
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

{ #category : #accessing }
RigidTransform3D >> translation [

	^ translation
]

{ #category : #accessing }
RigidTransform3D >> translation: anObject [

	translation := anObject
]

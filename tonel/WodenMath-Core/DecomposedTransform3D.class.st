"
I am a 3D transform that is decomposed in a successive sequence of scale, rotation, and translation.
"
Class {
	#name : #DecomposedTransform3D,
	#superclass : #Object,
	#instVars : [
		'scale',
		'rotation',
		'translation'
	],
	#category : #'WodenMath-Core-Transform'
}

{ #category : #converting }
DecomposedTransform3D >> asDecomposedTransform3D [
	^ self
]

{ #category : #initialization }
DecomposedTransform3D >> initialize [
	self setIdentity.
]

{ #category : #testing }
DecomposedTransform3D >> isIdentity [
	^ scale = Vector3 ones and: [ rotation = Quaternion identity and: [ translation = Vector3 zeros ] ]
]

{ #category : #accessing }
DecomposedTransform3D >> rotation [

	^ rotation
]

{ #category : #accessing }
DecomposedTransform3D >> rotation: anObject [

	rotation := anObject
]

{ #category : #accessing }
DecomposedTransform3D >> scale [

	^ scale
]

{ #category : #accessing }
DecomposedTransform3D >> scale: anObject [

	scale := anObject
]

{ #category : #initialization }
DecomposedTransform3D >> setIdentity [
	scale := Vector3 ones.
	rotation := Quaternion identity.
	translation := Vector3 zeros.
]

{ #category : #accessing }
DecomposedTransform3D >> translation [

	^ translation
]

{ #category : #accessing }
DecomposedTransform3D >> translation: anObject [

	translation := anObject
]

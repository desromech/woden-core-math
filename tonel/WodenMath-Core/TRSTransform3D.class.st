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
TRSTransform3D >> translateBy: vector [
	translation := translation + vector
]

{ #category : #accessing }
TRSTransform3D >> translation [

	^ translation
]

{ #category : #accessing }
TRSTransform3D >> translation: anObject [

	translation := anObject
]

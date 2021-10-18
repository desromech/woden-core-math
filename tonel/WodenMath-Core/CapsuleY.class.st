"
I am a capsule aligned with the Y axis.
"
Class {
	#name : #CapsuleY,
	#superclass : #Object,
	#instVars : [
		'center',
		'height',
		'radius'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #construction }
CapsuleY class >> center: center height: height radius: radius [
	^ self basicNew center: center; height: height; radius: radius; yourself
]

{ #category : #construction }
CapsuleY class >> height: height radius: radius [
	^ self new height: height; radius: radius; yourself
]

{ #category : #accessing }
CapsuleY >> center [

	^ center
]

{ #category : #accessing }
CapsuleY >> center: anObject [

	center := anObject
]

{ #category : #accessing }
CapsuleY >> halfHeight [
	^ height / 2
]

{ #category : #accessing }
CapsuleY >> height [

	^ height
]

{ #category : #accessing }
CapsuleY >> height: anObject [

	height := anObject
]

{ #category : #initialization }
CapsuleY >> initialize [
	center := Vector3 zeros.
	height := 0.
	radius := 0.
]

{ #category : #accessing }
CapsuleY >> radius [

	^ radius
]

{ #category : #accessing }
CapsuleY >> radius: anObject [

	radius := anObject
]

{ #category : #support }
CapsuleY >> supportFunction [
	^ [ :d | self supportInDirection: d ]
]

{ #category : #support }
CapsuleY >> supportInDirection: d [
	^ center + (Vector3 y: d y sign * self halfHeight) + (d normalized * radius).
]

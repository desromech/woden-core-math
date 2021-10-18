"
I am a capsule aligned with the X axis.
"
Class {
	#name : #CapsuleX,
	#superclass : #CapsuleY,
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #support }
CapsuleX >> supportInDirection: d [
	^ center + (Vector3 x: d x sign * self halfHeight) + (d normalized * radius).
]

"
I am a capsule aligned with the Z axis.
"
Class {
	#name : #CapsuleZ,
	#superclass : #CapsuleY,
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #support }
CapsuleZ >> supportInDirection: d [
	^ center + (Vector3 z: d z sign * self halfHeight) + (d normalized * radius).
]

"
A SphereTest is a test class for testing the behavior of Sphere
"
Class {
	#name : #SphereTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Geometry'
}

{ #category : #tests }
SphereTest >> testCenterRadius [
	| sphere center |
	center := Vector3 x: 1 y: 2 z: 3.
	sphere := Sphere center: center radius: 4.
	self assert: sphere center equals: center.
	self assert: sphere radius equals: 4.
]

{ #category : #tests }
SphereTest >> testNew [
	| sphere |
	sphere := Sphere new.
	self assert: sphere center isZeros.
	self assert: sphere radius isZero.
]

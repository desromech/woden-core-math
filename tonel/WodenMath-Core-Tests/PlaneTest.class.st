"
A PlaneTest is a test class for testing the behavior of Plane
"
Class {
	#name : #PlaneTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Geometry'
}

{ #category : #tests }
PlaneTest >> testNew [
	| plane |
	plane := Plane new.
	self assert: plane isZero.
	self assert: plane normal isZeros.
	self assert: plane distance isZero.
]

{ #category : #tests }
PlaneTest >> testNormalDistance [
	| normal plane |
	normal := Vector3 y: 1.
	plane := Plane normal: normal distance: 0.
	self assert: plane normal equals: normal.
	self assert: plane distance equals: 0.
]

{ #category : #tests }
PlaneTest >> testPointPointPoint [
	| plane |
	plane := Plane point: Vector3 zeros point: (Vector3 x: 1) point: (Vector3 y: 1).
	self assert: plane normal equals: (Vector3 z: 1).
	self assert: plane distance equals: 0.

	self assert: (plane signedDistanceToPoint: (Vector3 x: 2 y: 3 z: 3)) equals: 3.
	self assert: (plane isPointInFront: (Vector3 x: 2 y: 3 z: 3)).

	self assert: (plane signedDistanceToPoint: (Vector3 x: 2 y: 3 z: -3)) equals: -3.
	self assert: (plane isPointBehind: (Vector3 x: 2 y: 3 z: -3)).
]

{ #category : #tests }
PlaneTest >> testPointPointPoint2 [
	| plane |
	plane := Plane point: (Vector3 x: 1) point: (Vector3 x: 2) point: (Vector3 x: 1 y: 1).
	self assert: plane normal equals: (Vector3 z: 1).
	self assert: plane distance equals: 0.
]

{ #category : #tests }
PlaneTest >> testPointPointPoint3 [
	| plane |
	plane := Plane point: (Vector3 z: 2) point: (Vector3 x: 1 y: 0 z: 2) point: (Vector3 x: 0 y: 1 z: 2).
	self assert: plane normal equals: (Vector3 z: 1).
	self assert: plane distance equals: 2.
]

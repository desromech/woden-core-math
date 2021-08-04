"
An AABoxTest is a test class for testing the behavior of AABox
"
Class {
	#name : #AABoxTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Geometry'
}

{ #category : #tests }
AABoxTest >> testEmpty [
	| box |
	box := AABox empty.
	self assert: box min equals: Vector3 infinity.
	self assert: box max equals: Vector3 negativeInfinity.
	self assert: box isEmpty.
]

{ #category : #tests }
AABoxTest >> testEquals [
	self deny: AABox new equals: AABox empty.
	self assert: AABox new equals: AABox new.
	self assert: AABox new hash equals: AABox new hash.

	self assert: AABox empty equals: AABox empty.
	self assert: AABox empty hash equals: AABox empty hash.

	self assert: (AABox point: (Vector3 x: 1 y: 2 z: 3)) equals: (AABox point: (Vector3 x: 1 y: 2 z: 3)).
	self assert: (AABox point: (Vector3 x: 1 y: 2 z: 3)) hash equals: (AABox point: (Vector3 x: 1 y: 2 z: 3)) hash.

	self deny: (AABox point: (Vector3 x: 1 y: 2 z: 3)) equals: (AABox point: (Vector3 x: -1 y: -2 z: -3)).

	self assert: (AABox min: (Vector3 x: -1 y: -2 z: -3) max: (Vector3 x: 1 y: 2 z: 3)) equals: (AABox min: (Vector3 x: -1 y: -2 z: -3) max: (Vector3 x: 1 y: 2 z: 3)).
	self assert: (AABox min: (Vector3 x: -1 y: -2 z: -3) max: (Vector3 x: 1 y: 2 z: 3)) hash equals: (AABox min: (Vector3 x: -1 y: -2 z: -3) max: (Vector3 x: 1 y: 2 z: 3)) hash.

]

{ #category : #tests }
AABoxTest >> testInsertBox [
	| box |
	box := AABox empty.
	box insertBox: AABox new.
	self assert: box equals: AABox new.

]

{ #category : #tests }
AABoxTest >> testInsertBox2 [
	| box |
	box := AABox min: (Vector3 x: -1 y: -2 z: -3) max: (Vector3 x: 1 y: 2 z: 3).

	box insertBox: AABox new.
	self assert: box equals: (AABox min: (Vector3 x: -1 y: -2 z: -3) max: (Vector3 x: 1 y: 2 z: 3)).

]

{ #category : #tests }
AABoxTest >> testInsertPoint [
	| box point |
	box := AABox empty.
	self assert: box isEmpty.
	point := Vector3 x: 1 y: 2 z: 3.
	box insertPoint: point.
	self assert: box min equals: point.
	self assert: box max equals: point.
	self deny: box isEmpty.
	self assert: box isPoint.
]

{ #category : #tests }
AABoxTest >> testInsertPoint2 [
	| box minPoint maxPoint |
	box := AABox empty.
	self assert: box isEmpty.
	minPoint := Vector3 x: -1 y: -2 z: -3.
	maxPoint := Vector3 x: 1 y: 2 z: 3.
	box
		insertPoint: maxPoint;
		insertPoint: minPoint.
	self assert: box min equals: minPoint.
	self assert: box max equals: maxPoint.
	self deny: box isEmpty.
	self deny: box isPoint.
]

{ #category : #tests }
AABoxTest >> testNew [
	| box |
	box := AABox new.
	self assert: box min equals: Vector3 zeros.
	self assert: box max equals: Vector3 zeros.
	self deny: box isEmpty.
	self assert: box isPoint.
]

{ #category : #tests }
AABoxTest >> testUnionWithPoint [
	| box point |
	point := Vector3 x: 1 y: 2 z: 3.
	box := AABox empty unionWithPoint: point.
	self assert: box min equals: point.
	self assert: box max equals: point.
	self deny: box isEmpty.
	self assert: box isPoint.
]

{ #category : #tests }
AABoxTest >> testUnionWithPoint2 [
	| box minPoint maxPoint |
	minPoint := Vector3 x: -1 y: -2 z: -3.
	maxPoint := Vector3 x: 1 y: 2 z: 3.
	box := (AABox empty unionWithPoint: maxPoint) unionWithPoint: minPoint.
	self assert: box min equals: minPoint.
	self assert: box max equals: maxPoint.
	self deny: box isEmpty.
	self deny: box isPoint.
]

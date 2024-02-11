"
A WMDbvtTest is a test class for testing the behavior of WMDbvt
"
Class {
	#name : #WMDbvtTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-DataStructures'
}

{ #category : #tests }
WMDbvtTest >> testBalance [
	| dbvt |
	dbvt := WMDbvt new.
	1 to: 100 do: [ :x | 
		dbvt insertValue: x withBoundingBox: (AABox center: (Vector3 x: x * 2) halfExtent: 0.5).
	].
	
	self deny: dbvt isEmpty.
	self assert: dbvt isNotEmpty.

	self assert: (dbvt balanceFactor between: -1 and: 1).
]

{ #category : #tests }
WMDbvtTest >> testEmpty [
	| dbvt |
	dbvt := WMDbvt new.
	self assert: dbvt isEmpty.
	self deny: dbvt isNotEmpty.
	self assert: (dbvt leavesIntersectingBox: AABox unit) isEmpty.
	self assert: (dbvt leavesIntersectingSphere: (Sphere radius: 1)) isEmpty.
	self assert: (dbvt leavesIntersectingRay: (Ray3D from: (Vector3 x: 0) to: (Vector3 x: 2))) isEmpty.
]

{ #category : #tests }
WMDbvtTest >> testSingleBox [
	| dbvt |
	dbvt := WMDbvt new.
	dbvt insertValue: 1 withBoundingBox: (AABox unit).
	
	self deny: dbvt isEmpty.
	self assert: dbvt isNotEmpty.
	self assert: (dbvt leavesIntersectingBox: AABox unit) size equals: 1.
	self assert: (dbvt leavesIntersectingSphere: (Sphere radius: 1)) size equals: 1.
	self assert: (dbvt leavesIntersectingRay: (Ray3D from: (Vector3 x: 0) to: (Vector3 x: 2))) size equals: 1.
]

{ #category : #tests }
WMDbvtTest >> testThreeBoxes [
	| dbvt |
	dbvt := WMDbvt new.
	dbvt insertValue: 1 withBoundingBox: (AABox unit).
	dbvt insertValue: 2 withBoundingBox: (AABox center: (Vector3 x: 10) halfExtent: 0.5).
	dbvt insertValue: 3 withBoundingBox: (AABox center: (Vector3 y: 10) halfExtent: 0.5).
	
	self deny: dbvt isEmpty.
	self assert: dbvt isNotEmpty.

	self assert: (dbvt leavesIntersectingBox: AABox unit) size equals: 1.
	self assert: (dbvt leavesIntersectingSphere: (Sphere radius: 1)) size equals: 1.
	self assert: (dbvt leavesIntersectingRay: (Ray3D from: (Vector3 x: 0) to: (Vector3 x: 2))) size equals: 1.
	
	self assert: (dbvt leavesIntersectingBox: (AABox halfExtent: 10)) size equals: 3.
	self assert: (dbvt leavesIntersectingSphere: (Sphere radius: 10)) size equals: 3.
	self assert: (dbvt leavesIntersectingRay: (Ray3D from: (Vector3 x: 0) to: (Vector3 x: 10))) size equals: 2.
	self assert: (dbvt leavesIntersectingRay: (Ray3D from: (Vector3 y: 0) to: (Vector3 y: 10))) size equals: 2.
]

{ #category : #tests }
WMDbvtTest >> testTwoBoxes [
	| dbvt |
	dbvt := WMDbvt new.
	dbvt insertValue: 1 withBoundingBox: (AABox unit).
	dbvt insertValue: 2 withBoundingBox: (AABox center: (Vector3 x: 10) halfExtent: 0.5).
	
	self deny: dbvt isEmpty.
	self assert: dbvt isNotEmpty.

	self assert: (dbvt leavesIntersectingBox: AABox unit) size equals: 1.
	self assert: (dbvt leavesIntersectingSphere: (Sphere radius: 1)) size equals: 1.
	self assert: (dbvt leavesIntersectingRay: (Ray3D from: (Vector3 x: 0) to: (Vector3 x: 2))) size equals: 1.
	
	self assert: (dbvt leavesIntersectingBox: (AABox halfExtent: 10)) size equals: 2.
	self assert: (dbvt leavesIntersectingSphere: (Sphere radius: 10)) size equals: 2.
	self assert: (dbvt leavesIntersectingRay: (Ray3D from: (Vector3 x: 0) to: (Vector3 x: 10))) size equals: 2.
	self assert: (dbvt leavesIntersectingRay: (Ray3D from: (Vector3 y: 0) to: (Vector3 y: 10))) size equals: 1.
]

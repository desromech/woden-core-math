"
A GJKVoronoiSimplexSolverTest is a test class for testing the behavior of GJKVoronoiSimplexSolver
"
Class {
	#name : #GJKVoronoiSimplexSolverTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Geometry'
}

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testEmpty [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	self assert: simplex points isEmpty.
	simplex reduce.
	self assert: simplex points isEmpty.
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testLineFirst [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 1).
	simplex insertPoint: (Vector3 x: 2).

	self assert: simplex closestPointToOrigin equals: (Vector3 x: 1).
	self assert: simplex barycentricCoordinates equals: #(1 0).
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 1.
	self assert: simplex points first equals: (Vector3 x: 1).
	self assert: simplex barycentricCoordinates equals: #(1).
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testLineInside [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: -1).
	simplex insertPoint: (Vector3 x: 1).

	self assert: simplex closestPointToOrigin equals: Vector3 zeros.
	self assert: simplex barycentricCoordinates equals: #(0.5 0.5).
	self assert: simplex containsOrigin.
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testLineInside2 [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 1).
	simplex insertPoint: (Vector3 x: -1).

	self assert: simplex closestPointToOrigin equals: Vector3 zeros.
	self assert: simplex barycentricCoordinates equals: #(0.5 0.5).
	self assert: simplex containsOrigin.
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testLineMiddle [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: -1 y: 1).
	simplex insertPoint: (Vector3 x: 1 y: 1).

	self assert: simplex closestPointToOrigin equals: (Vector3 y: 1).
	self assert: simplex barycentricCoordinates equals: #(0.5 0.5).
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 2.
	self assert: simplex barycentricCoordinates equals: #(0.5 0.5).

]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testLineMiddle2 [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 1 y: 1).
	simplex insertPoint: (Vector3 x: -1 y: 1).

	self assert: simplex closestPointToOrigin equals: (Vector3 y: 1).
	self assert: simplex barycentricCoordinates equals: #(0.5 0.5).
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 2.
	self assert: simplex barycentricCoordinates equals: #(0.5 0.5).

]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testLineSecond [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: -2).
	simplex insertPoint: (Vector3 x: -1).

	self assert: simplex closestPointToOrigin equals: (Vector3 x: -1).
	self assert: simplex barycentricCoordinates equals: #(0 1).
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 1.
	self assert: simplex points first equals: (Vector3 x: -1).
	self assert: simplex barycentricCoordinates equals: #(1).

]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testSinglePoint [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 1).

	self assert: simplex closestPointToOrigin equals: (Vector3 x: 1).
	self deny: simplex containsOrigin.
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testSinglePoint2 [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 0).

	self assert: simplex closestPointToOrigin equals: (Vector3 x: 0).
	self assert: simplex barycentricCoordinates equals: #(1).
	self assert: simplex containsOrigin.
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTetrahedronABC [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: -1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 0 y: -1 z: -1).
	simplex insertPoint: (Vector3 x: 0 y: -2 z: 0).

	self assert: simplex closestPointToOrigin equals: (Vector3 y: -1).
	self assert: simplex barycentricCoordinates equals: {1/4. 1/4. 1/2 . 0}.
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 3.
	self assert: simplex closestPointToOrigin equals: (Vector3 y: -1).
	self assert: simplex barycentricCoordinates equals: {1/4. 1/4. 1/2}.
	self deny: simplex containsOrigin.
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTetrahedronABD [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: -1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 0 y: -2 z: 0).
	simplex insertPoint: (Vector3 x: 0 y: -1 z: -1).

	self assert: simplex closestPointToOrigin equals: (Vector3 y: -1).
	self assert: simplex barycentricCoordinates equals: {1/4. 1/4. 0 . 1/2}.
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 3.
	self assert: simplex closestPointToOrigin equals: (Vector3 y: -1).
	self assert: simplex barycentricCoordinates equals: {1/4. 1/4. 1/2}.
	self deny: simplex containsOrigin.
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTetrahedronACD [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: -1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 0 y: -2 z: 0).
	simplex insertPoint: (Vector3 x: 1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 0 y: -1 z: -1).

	self assert: simplex closestPointToOrigin equals: (Vector3 y: -1).
	self assert: simplex barycentricCoordinates equals: {1/4. 0 . 1/4. 1/2}.
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 3.
	self assert: simplex closestPointToOrigin equals: (Vector3 y: -1).
	self assert: simplex barycentricCoordinates equals: {1/4. 1/4. 1/2}.
	self deny: simplex containsOrigin.
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTetrahedronBCD [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 0 y: -2 z: 0).
	simplex insertPoint: (Vector3 x: -1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 0 y: -1 z: -1).

	self assert: simplex closestPointToOrigin equals: (Vector3 y: -1).
	self assert: simplex barycentricCoordinates equals: {0 . 1/4. 1/4. 1/2}.
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 3.
	self assert: simplex closestPointToOrigin equals: (Vector3 y: -1).
	self assert: simplex barycentricCoordinates equals: {1/4. 1/4. 1/2}.
	self deny: simplex containsOrigin.
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTetrahedronInside [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: -1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 0 y: -1 z: -1).
	simplex insertPoint: (Vector3 x: 0 y: 1 z: 0).

	self assert: simplex closestPointToOrigin equals: Vector3 zeros.
	self assert: simplex containsOrigin.
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTriangleA [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 1).
	simplex insertPoint: (Vector3 x: 3).
	simplex insertPoint: (Vector3 x: 2 y: 1).

	self assert: simplex closestPointToOrigin equals: (Vector3 x: 1).
	self assert: simplex barycentricCoordinates equals: #(1 0 0).
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 1.
	self assert: simplex points first equals: (Vector3 x: 1).
	self assert: simplex barycentricCoordinates equals: #(1).
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTriangleAB [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: -1 y: 1).
	simplex insertPoint: (Vector3 x: 1 y: 1).
	simplex insertPoint: (Vector3 x: 0 y: 2).

	self assert: simplex closestPointToOrigin equals: (Vector3 y: 1).
	self assert: simplex barycentricCoordinates equals: #(0.5 0.5 0).
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 2.
	self assert: simplex points first equals: (Vector3 x: -1 y: 1).
	self assert: simplex points second equals: (Vector3 x: 1 y: 1).

	self assert: simplex barycentricCoordinates equals: #(0.5 0.5).
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTriangleB [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 3).
	simplex insertPoint: (Vector3 x: 1).
	simplex insertPoint: (Vector3 x: 2 y: 1).

	self assert: simplex closestPointToOrigin equals: (Vector3 x: 1).
	self assert: simplex barycentricCoordinates equals: #(0 1 0).
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 1.
	self assert: simplex points first equals: (Vector3 x: 1).
	self assert: simplex barycentricCoordinates equals: #(1).
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTriangleBC [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 0 y: 2).
	simplex insertPoint: (Vector3 x: -1 y: 1).
	simplex insertPoint: (Vector3 x: 1 y: 1).

	self assert: simplex closestPointToOrigin equals: (Vector3 y: 1).
	self assert: simplex barycentricCoordinates equals: #(0 0.5 0.5).
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 2.
	self assert: simplex points first equals: (Vector3 x: -1 y: 1).
	self assert: simplex points second equals: (Vector3 x: 1 y: 1).

	self assert: simplex barycentricCoordinates equals: #(0.5 0.5).
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTriangleC [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 3).
	simplex insertPoint: (Vector3 x: 2 y: 1).
	simplex insertPoint: (Vector3 x: 1).

	self assert: simplex closestPointToOrigin equals: (Vector3 x: 1).
	self assert: simplex barycentricCoordinates equals: #(0 0 1).
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 1.
	self assert: simplex points first equals: (Vector3 x: 1).
	self assert: simplex barycentricCoordinates equals: #(1).
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTriangleCA [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: 1 y: 1).
	simplex insertPoint: (Vector3 x: 0 y: 2).
	simplex insertPoint: (Vector3 x: -1 y: 1).

	self assert: simplex closestPointToOrigin equals: (Vector3 y: 1).
	self assert: simplex barycentricCoordinates equals: #(0.5 0 0.5).
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 2.
	self assert: simplex points first equals: (Vector3 x: 1 y: 1).
	self assert: simplex points second equals: (Vector3 x: -1 y: 1).

	self assert: simplex barycentricCoordinates equals: #(0.5 0.5).
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTriangleInside [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: -1 y: -1).
	simplex insertPoint: (Vector3 x: 1 y: -1).
	simplex insertPoint: (Vector3 x: 0 y: 1).

	self assert: simplex closestPointToOrigin equals: Vector3 zeros.
	self assert: simplex barycentricCoordinates equals: {1/4. 1/4. 1/2}.
	self assert: simplex containsOrigin
]

{ #category : #tests }
GJKVoronoiSimplexSolverTest >> testTriangleMiddle [
	| simplex |
	simplex := GJKVoronoiSimplexSolver new.
	simplex insertPoint: (Vector3 x: -1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 1 y: -1 z: 1).
	simplex insertPoint: (Vector3 x: 0 y: -1 z: -1).

	self assert: simplex closestPointToOrigin equals: (Vector3 y: -1).
	self assert: simplex barycentricCoordinates equals: {1/4. 1/4. 1/2}.
	self deny: simplex containsOrigin.

	simplex reduce.
	self assert: simplex points size equals: 3.
	self assert: simplex closestPointToOrigin equals: (Vector3 y: -1).
	self assert: simplex barycentricCoordinates equals: {1/4. 1/4. 1/2}.
	self deny: simplex containsOrigin.
]

"
A GeometricFunctionsTest is a test class for testing the behavior of GeometricFunctions
"
Class {
	#name : #GeometricFunctionsTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Geometry'
}

{ #category : #tests }
GeometricFunctionsTest >> testBoxBoxPenetrationDistance [
	| firstShape secondShape distanceAndNormal distance normal |
	firstShape := AABox center: Vector3 zeros halfExtent: (Vector3 x: 5 y: 0.5 z: 20).
	secondShape := AABox center: (Vector3 x: 5 y: 0.0 z: -20) halfExtent: (Vector3 x: 0.5 y: 0.5 z: 0.5).
	distanceAndNormal := GeometricFunctions samplePenetrationDistanceAndNormalForSupport: firstShape supportFunction with: secondShape supportFunction.
	distance := distanceAndNormal first.
	normal := distanceAndNormal second.
	self assert: (distance closeTo: 0.5).
	self assert: (normal closeTo: (Vector3 x: -1)).			
]

{ #category : #tests }
GeometricFunctionsTest >> testBoxBoxPenetrationDistance2 [
	| firstShape secondShape distanceAndNormal distance normal |
	firstShape := AABox center: Vector3 zeros halfExtent: (Vector3 x: 5 y: 0.5 z: 20).
	secondShape := AABox center: (Vector3 x: -5 y: 0.0 z: -20) halfExtent: (Vector3 x: 0.5 y: 0.5 z: 0.5).
	distanceAndNormal := GeometricFunctions samplePenetrationDistanceAndNormalForSupport: firstShape supportFunction with: secondShape supportFunction.
	distance := distanceAndNormal first.
	normal := distanceAndNormal second.
	self assert: (distance closeTo: 0.5).
	self assert: (normal closeTo: (Vector3 x: 1)).
]

{ #category : #tests }
GeometricFunctionsTest >> testBoxScaledBoxPenetrationDistance [
	| firstShape secondShape distanceAndNormal distance normal |
	firstShape := AABox center: Vector3 zeros halfExtent: Vector3 ones.
	secondShape := AABox center: (Vector3 x: -5 y: 0.3 z: -20) halfExtent: (Vector3 x: 0.5 y: 0.5 z: 0.5).
	distanceAndNormal := GeometricFunctions samplePenetrationDistanceAndNormalForSupport:
	(GeometricFunctions transformSupportFunction: firstShape supportFunction with: (TRSTransform3D scale: (Vector3 x: 5 y: 0.5 z: 20)))  with: secondShape supportFunction.
	distance := distanceAndNormal first.
	normal := distanceAndNormal second.
	self assert: (distance closeTo: 0.5).
	self assert: (normal closeTo: (Vector3 x: 1)).
]

{ #category : #tests }
GeometricFunctionsTest >> testBoxScaledBoxPenetrationDistance2 [
	| firstShape secondShape distanceAndNormal distance normal |
	firstShape := AABox center: Vector3 zeros halfExtent: Vector3 ones.
	secondShape := AABox center: (Vector3 x: 5 y: 0.3 z: -20) halfExtent: (Vector3 x: 0.5 y: 0.5 z: 0.5).
	distanceAndNormal := GeometricFunctions samplePenetrationDistanceAndNormalForSupport:
	(GeometricFunctions transformSupportFunction: firstShape supportFunction with: (TRSTransform3D scale: (Vector3 x: 5 y: 0.5 z: 20)))  with: secondShape supportFunction.
	distance := distanceAndNormal first.
	normal := distanceAndNormal second.
	self assert: (distance closeTo: 0.5).
	self assert: (normal closeTo: (Vector3 x: -1)).
]

{ #category : #tests }
GeometricFunctionsTest >> testCapsuleBoxPenetrationDistance [
	| firstShape secondShape distanceAndNormal distance normal |
	firstShape := AABox center: Vector3 zeros halfExtent: (Vector3 x: 5 y: 0.5 z: 20).
	secondShape := CapsuleY center: (Vector3 x: -5 y: 0.3 z: -20) height: 1.0 radius: 0.5.
	distanceAndNormal := GeometricFunctions samplePenetrationDistanceAndNormalForSupport: firstShape supportFunction with: secondShape supportFunction.
	distance := distanceAndNormal first.
	normal := distanceAndNormal second.
	self assert: (distance closeTo: 0.5).
	self assert: (normal closeTo: (Vector3 x: 1 y: 0 z: 1) normalized).
]

{ #category : #tests }
GeometricFunctionsTest >> testClosestPointInLine [
	| line |
	line := { Vector3 zeros . (Vector3 x: 1) }.
	self assert: (GeometricFunctions closestPointInLine: line to: (Vector3 x: 0.5 y: 1.0)) equals: (Vector3 x: 0.5).
	self assert: (GeometricFunctions closestPointInLine: line to: (Vector3 x: -0.5 y: 1.0)) equals: (Vector3 x: 0.0).
	self assert: (GeometricFunctions closestPointInLine: line to: (Vector3 x: 20.5 y: 1.0)) equals: (Vector3 x: 1.0).
	self assert: (GeometricFunctions closestPointInLine: line to: (Vector3 x: 0.5 y: -1.0)) equals: (Vector3 x: 0.5).
	self assert: (GeometricFunctions closestPointInLine: line to: (Vector3 x: -0.5 y: -1.0)) equals: (Vector3 x: 0.0).
	self assert: (GeometricFunctions closestPointInLine: line to: (Vector3 x: 20.5 y: -1.0)) equals: (Vector3 x: 1.0).
]

{ #category : #tests }
GeometricFunctionsTest >> testClosestPointInTetrahedron [
	| tetrahedron |
	tetrahedron := { Vector3 zeros . (Vector3 x: 1.0) . (Vector3 y: 1.0) . (Vector3 z: 1.0)}.

	"Bottom triangle test."
	self assert: (GeometricFunctions closestPointInTetrahedron: tetrahedron to: Vector3 zeros) equals: Vector3 zeros.
	self assert: (GeometricFunctions closestPointInTetrahedron: tetrahedron to: (Vector3 x: 1.0)) equals: (Vector3 x: 1.0).
	self assert: (GeometricFunctions closestPointInTetrahedron: tetrahedron to: (Vector3 y: 1.0)) equals: (Vector3 y: 1.0).
	self assert: (GeometricFunctions closestPointInTetrahedron: tetrahedron to: (Vector3 x: 0.5 y: 0.5)) equals: (Vector3 x: 0.5 y: 0.5).
	self assert: (GeometricFunctions closestPointInTetrahedron: tetrahedron to: (Vector3 x: 0.5 y: -0.5)) equals: (Vector3 x: 0.5).
	self assert: (GeometricFunctions closestPointInTetrahedron: tetrahedron to: (Vector3 x: -0.5 y: 0.5)) equals: (Vector3 y: 0.5).
	self assert: (GeometricFunctions closestPointInTetrahedron: tetrahedron to: Vector3 ones) closeTo: Vector3 ones /3.
	
	"Other tests."
	self assert: (GeometricFunctions closestPointInTetrahedron: tetrahedron to: (Vector3 x: 0.25 y: 0.25 z: 0.25)) equals: (Vector3 x: 0.25 y: 0.25 z: 0.25).

]

{ #category : #tests }
GeometricFunctionsTest >> testClosestPointInTriangle [
	| triangle |
	triangle := { Vector3 zeros . (Vector3 x: 1.0) . (Vector3 y: 1.0) }.
	self assert: (GeometricFunctions closestPointInTriangle3D: triangle to: Vector3 zeros) equals: Vector3 zeros.
	self assert: (GeometricFunctions closestPointInTriangle3D: triangle to: (Vector3 x: 1.0)) equals: (Vector3 x: 1.0).
	self assert: (GeometricFunctions closestPointInTriangle3D: triangle to: (Vector3 y: 1.0)) equals: (Vector3 y: 1.0).
	self assert: (GeometricFunctions closestPointInTriangle3D: triangle to: (Vector3 x: 0.5 y: 0.5)) equals: (Vector3 x: 0.5 y: 0.5).
	self assert: (GeometricFunctions closestPointInTriangle3D: triangle to: (Vector3 x: 0.5 y: -0.5)) equals: (Vector3 x: 0.5).
	self assert: (GeometricFunctions closestPointInTriangle3D: triangle to: (Vector3 x: -0.5 y: 0.5)) equals: (Vector3 y: 0.5).
	self assert: (GeometricFunctions closestPointInTriangle3D: triangle to: Vector3 ones) equals: (Vector3 x: 0.5 y: 0.5).

]

{ #category : #tests }
GeometricFunctionsTest >> testCollinearPoints3D [
	self assert: (GeometricFunctions isPoint3DCollinear: Vector3 zeros with: Vector3 zeros with: Vector3 zeros).
	self assert: (GeometricFunctions isPoint3DCollinear: Vector3 ones with: Vector3 ones with: Vector3 ones).
	self assert: (GeometricFunctions isPoint3DCollinear: Vector3 zeros with: Vector3 ones with: Vector3 ones).
	self assert: (GeometricFunctions isPoint3DCollinear: Vector3 ones with: Vector3 zeros with: Vector3 ones).
	self assert: (GeometricFunctions isPoint3DCollinear: Vector3 ones with: Vector3 ones with: Vector3 zeros ).
	self assert: (GeometricFunctions isPoint3DCollinear: (Vector3 x: 1) with: Vector3 zeros with: (Vector3 x: 20)).
	self assert: (GeometricFunctions isPoint3DCollinear: Vector3 ones with: Vector3 ones*2 with: Vector3 ones*2).
	self deny: (GeometricFunctions isPoint3DCollinear: Vector3 zeros with: Vector3 ones with: (Vector3 y: 1.0)).
]

{ #category : #tests }
GeometricFunctionsTest >> testCoplanarPoints3D [
	self assert: (GeometricFunctions isPoint3DCoplanar: Vector3 ones with: Vector3 ones with: Vector3 ones with: Vector3 ones).
	self assert: (GeometricFunctions isPoint3DCoplanar: Vector3 zeros with: Vector3 ones with: Vector3 ones *2 with: Vector3 ones).
	self assert: (GeometricFunctions isPoint3DCoplanar: Vector3 zeros with: (Vector3 x: 1.0) with: (Vector3 x: 1.0 y: 1.0) with: (Vector3 y: 1.0)).
	self deny: (GeometricFunctions isPoint3DCoplanar: Vector3 zeros with: (Vector3 x: 1.0) with: Vector3 ones with: (Vector3 y: 1.0)).

]

{ #category : #tests }
GeometricFunctionsTest >> testSphereSphereDistance [
	| firstShape secondShape |
	firstShape := Sphere center: (Vector3 x: -2) radius: 1.
	secondShape := Sphere center: (Vector3 x: 2) radius: 1.
	self assert: (GeometricFunctions gjkDistanceFrom: firstShape supportFunction to: secondShape supportFunction) closeTo: (firstShape distanceWithSphere: secondShape).
]

{ #category : #tests }
GeometricFunctionsTest >> testSphereSphereDistance2 [
	| firstShape secondShape |
	firstShape := Sphere center: (Vector3 x: -2) radius: 1.
	secondShape := Sphere center: (Vector3 x: 2 y: 1) radius: 1.
	self assert: (GeometricFunctions gjkDistanceFrom: firstShape supportFunction to: secondShape supportFunction) closeTo: (firstShape distanceWithSphere: secondShape).
]

{ #category : #tests }
GeometricFunctionsTest >> testSphereSphereDistance3 [
	| firstShape secondShape |
	firstShape := Sphere center: (Vector3 x: -2) radius: 1.
	secondShape := Sphere center: (Vector3 x: 2 y: 1 z: 25) radius: 1.
	self assert: (GeometricFunctions gjkDistanceFrom: firstShape supportFunction to: secondShape supportFunction) closeTo: (firstShape distanceWithSphere: secondShape).
]

{ #category : #tests }
GeometricFunctionsTest >> testSphereSpherePenetrationDistance [
	| firstShape secondShape distanceAndNormal distance normal |
	firstShape := Sphere center: (Vector3 x: -1) radius: 1.
	secondShape := Sphere center: (Vector3 x: 1) radius: 1.
	distanceAndNormal := GeometricFunctions samplePenetrationDistanceAndNormalForSupport: firstShape supportFunction with: secondShape supportFunction.
	distance := distanceAndNormal first.
	normal := distanceAndNormal second.
	self assert: (distance closeTo: 0).
	self assert: (normal closeTo: (Vector3 x: -1)).
]

{ #category : #tests }
GeometricFunctionsTest >> testSphereSpherePenetrationDistance2 [
	| firstShape secondShape distanceAndNormal distance normal |
	firstShape := Sphere center: (Vector3 x: -1) radius: 2.
	secondShape := Sphere center: (Vector3 x: 1) radius: 2.
	distanceAndNormal := GeometricFunctions samplePenetrationDistanceAndNormalForSupport: firstShape supportFunction with: secondShape supportFunction.
	distance := distanceAndNormal first.
	normal := distanceAndNormal second.
	self assert: (distance closeTo: 2).
	self assert: (normal closeTo: (Vector3 x: -1)).
]

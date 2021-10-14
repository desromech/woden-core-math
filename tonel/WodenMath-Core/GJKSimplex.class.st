"
I am simplex that is used for implementing GJK and other algorithms that are based on it.
"
Class {
	#name : #GJKSimplex,
	#superclass : #Object,
	#instVars : [
		'points',
		'closestPointToOrigin',
		'containsOrigin'
	],
	#classVars : [
		'Epsilon',
		'Epsilon2',
		'Origin'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #initialization }
GJKSimplex class >> initialize [
	Origin := Vector3 zeros.
	Epsilon := 0.00001.
	Epsilon2 := Epsilon*Epsilon.
]

{ #category : #'instance creation' }
GJKSimplex class >> with: aPoint [
	^ self basicNew points: { aPoint }
]

{ #category : #accessing }
GJKSimplex >> closestPointToOrigin [
	closestPointToOrigin ifNotNil: [ ^ closestPointToOrigin ].
	points size = 1 ifTrue: [ 
		^ closestPointToOrigin := points first differencePoint
	].

	points size = 2 ifTrue: [ 
		^ closestPointToOrigin := GeometricFunctions closestPointInLineFrom: points first differencePoint to: points second differencePoint to: Origin
	].

	points size = 3 ifTrue: [ 
		^ closestPointToOrigin := GeometricFunctions closestPointInTriangle3DA: points first differencePoint
			B: points second differencePoint
			C: points third differencePoint
			to: Origin
	].

	points size = 4 ifTrue: [ 
		^ closestPointToOrigin := GeometricFunctions closestPointInTetrahedronA: points first differencePoint
			B: points second differencePoint
			C: points third differencePoint
			D: points fourth differencePoint to: Origin
	].
	
	self error: 'Unsupported case.'
]

{ #category : #accessing }
GJKSimplex >> containsOrigin [
	containsOrigin ifNotNil: [ ^ containsOrigin ].
	^ containsOrigin := (self closestPointToOrigin - Origin) length2 < Epsilon2
]

{ #category : #initialization }
GJKSimplex >> initialize [
	points := #()
]

{ #category : #modifying }
GJKSimplex >> insertPoint: newPoint [
	closestPointToOrigin := nil.
	containsOrigin := nil.
	
	points size = 1 ifTrue: [
		points := { points first . newPoint }.
		^ self
	].

	points size = 2 ifTrue: [
		self assert: (points first closeTo: newPoint) not.		
		(GeometricFunctions isPoint3DCollinear: points first differencePoint with: points second differencePoint with: newPoint differencePoint) ifTrue: [
			points := {points second . newPoint }
		] ifFalse: [ 
			points := {points first . points second . newPoint }
		].
		^ self
	].

	points size = 3 ifTrue: [
		(GeometricFunctions isPoint3DCoplanar: points first differencePoint with: points second differencePoint with: points third differencePoint with: newPoint differencePoint) ifTrue: [
			points := {points second . points third . newPoint }
		] ifFalse: [ 
			points := {points first . points second . points third . newPoint }
		].

		^ self
	].

	self assert: points size = 4.
	points := { points second . points third . points fourth . newPoint }
]

{ #category : #accessing }
GJKSimplex >> lastPoint [
	^ points last
]

{ #category : #accessing }
GJKSimplex >> points [

	^ points
]

{ #category : #accessing }
GJKSimplex >> points: anObject [

	points := anObject
]

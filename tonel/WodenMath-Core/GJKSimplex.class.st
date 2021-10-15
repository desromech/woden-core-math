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
		^ closestPointToOrigin := points first 
	].

	points size = 2 ifTrue: [ 
		^ closestPointToOrigin := GeometricFunctions closestPointInLineFrom: points first  to: points second  to: Origin
	].

	points size = 3 ifTrue: [ 
		^ closestPointToOrigin := GeometricFunctions closestPointInTriangle3DA: points first 
			B: points second 
			C: points third 
			to: Origin
	].

	points size = 4 ifTrue: [ 
		^ closestPointToOrigin := GeometricFunctions closestPointInTetrahedronA: points first 
			B: points second 
			C: points third 
			D: points fourth  to: Origin
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
GJKSimplex >> insertPointOrdered: newPoint [
	closestPointToOrigin := nil.
	containsOrigin := nil.
	self assert: points size <= 4.

	points size = 4 ifTrue: [ 
		points := { points second . points third . points fourth . newPoint }.
		^ self
	].

	points size = 3 ifTrue: [
		(GeometricFunctions isPoint3DCoplanar: points first with: points second with: points third with: newPoint ) ifTrue: [
			points := {points second . points third . newPoint }
		] ifFalse: [ 
			points := {points first . points second . points third . newPoint }
		].

		^ self
	].

	points size = 2 ifTrue: [
		self assert: (points first closeTo: newPoint) not.		
		(GeometricFunctions isPoint3DCollinear: points first with: points second with: newPoint ) ifTrue: [
			points := {points second . newPoint }
		] ifFalse: [ 
			points := {points first . points second . newPoint }
		].
		^ self
	].
	
	points size = 1 ifTrue: [
		points := { points first . newPoint }.
		^ self
	].

	points size = 0 ifTrue: [
		points := { newPoint }.
		^ self
	].
	self error
]

{ #category : #modifying }
GJKSimplex >> insertPointUnordered: newPoint [
	"If the point is already inserted, nothing changes"
	(self isPointASimplexVertex: newPoint) ifTrue: [ ^ self ].

	closestPointToOrigin := nil.
	containsOrigin := nil.
	self assert: points size <= 4.

	points size = 4 ifTrue: [ 
		self removeFarthestPointTo: newPoint
	].

	points size = 3 ifTrue: [
		(GeometricFunctions isPoint3DCoplanar: points first  with: points second  with: points third  with: newPoint ) ifTrue: [
			self removeFarthestPointTo: newPoint
		] ifFalse: [ 
			points := {points first . points second . points third . newPoint }.
			^ self
		].
	].

	points size = 2 ifTrue: [
		(GeometricFunctions isPoint3DCollinear: points first  with: points second  with: newPoint ) ifTrue: [
			self removeFarthestPointTo: newPoint
		] ifFalse: [ 
			points := {points first . points second . newPoint }
		].
		^ self
	].
	
	points size = 1 ifTrue: [
		points := { points first . newPoint }.
		^ self
	].

	points isEmpty ifTrue: [
		points := { newPoint }.
		^ self
	].

	self error
]

{ #category : #testing }
GJKSimplex >> isPointASimplexVertex: point [
	^ points anySatisfy: [ :p | p closeTo: point ]
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

{ #category : #removing }
GJKSimplex >> removeFarthestPointTo: testPoint [
	| bestDistance bestIndex result destIndex |
	self assert: points isNotEmpty.
	bestDistance := -1.
	bestIndex := 0.
	points doWithIndex: [ :p :index |
		| l2 |
		l2 := (p - testPoint ) length2.
		l2 > bestDistance ifTrue: [
			bestDistance := l2.
			bestIndex := index
		]
	].

	result := Array new: points size - 1.
	destIndex := 1.
	points doWithIndex: [ :p :index |
		index ~~ bestIndex ifTrue: [ 
			result at: destIndex put: p.
			destIndex := destIndex + 1
		]		
	].
	
	points := result

]

{ #category : #modifying }
GJKSimplex >> transformPointsWith: aBlock [
	closestPointToOrigin := nil.
	containsOrigin := nil.
	1 to: points size do: [ :i |
		points at: i put: (aBlock value: (points at: i))
	]
]

"
I am voronoi diagram simplex solver used for implementing gjk and related algorithms. I am based on an implementation already existent and used by the bullet physics engine, which works by computing the barycentric coordinates of the point closest to the origin. The zero barycentric coordinates are removed when reducing the simplex.
"
Class {
	#name : #GJKVoronoiSimplexSolver,
	#superclass : #Object,
	#instVars : [
		'points',
		'firstPoints',
		'secondPoints',
		'barycentricCoordinates',
		'usedPoints',
		'hasComputedClosest',
		'closestPointToOrigin',
		'containsOrigin'
	],
	#classVars : [
		'Origin'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #initialization }
GJKVoronoiSimplexSolver class >> initialize [
	Origin := Vector3 zeros.
]

{ #category : #'instance creation' }
GJKVoronoiSimplexSolver class >> with: aPoint [
	^ self new insertPoint: aPoint; yourself
]

{ #category : #'instance creation' }
GJKVoronoiSimplexSolver class >> with: aPoint first: aFirstPoint second: aSecondPoint [
	^ self new insertPoint: aPoint first: aFirstPoint second: aSecondPoint; yourself
]

{ #category : #accessing }
GJKVoronoiSimplexSolver >> barycentricCoordinates [
	hasComputedClosest ifFalse: [ 
		self computeClosest.
	].
	^ barycentricCoordinates
]

{ #category : #accessing }
GJKVoronoiSimplexSolver >> closestPointToOrigin [
	hasComputedClosest ifFalse: [ 
		self computeClosest.
	].
	^ closestPointToOrigin
]

{ #category : #accessing }
GJKVoronoiSimplexSolver >> closestPointToOriginInFirst [
	| result barycentricSum |
	hasComputedClosest ifFalse: [ 
		self computeClosest.
	].

	result := Vector3 zeros.
	barycentricSum := 0.0.
	barycentricCoordinates doWithIndex: [ :coordinate :index |
		result := result + ((firstPoints at: index) * coordinate).
		barycentricSum := barycentricSum + coordinate
	].

	^ result / barycentricSum
]

{ #category : #accessing }
GJKVoronoiSimplexSolver >> closestPointToOriginInSecond [
	| result barycentricSum |
	hasComputedClosest ifFalse: [ 
		self computeClosest.
	].

	result := Vector3 zeros.
	barycentricSum := 0.0.
	barycentricCoordinates doWithIndex: [ :coordinate :index |
		result := result + ((secondPoints at: index) * coordinate).
		barycentricSum := barycentricSum + coordinate
	].

	^ result / barycentricSum
]

{ #category : #private }
GJKVoronoiSimplexSolver >> computeClosest [
	hasComputedClosest ifTrue: [ ^ self ].

	points isEmpty ifTrue: [
		hasComputedClosest := true.
		closestPointToOrigin := nil.
		^ self
	].

	points size = 1 ifTrue: [
		hasComputedClosest := true.
		closestPointToOrigin := points first.
		barycentricCoordinates := #(1).
		usedPoints := #(true).
		^ self
	].

	points size = 2 ifTrue: [
		^ self computeClosestToLine
	].

	points size = 3 ifTrue: [
		^ self computeClosestToTriangle
	].

	points size = 4 ifTrue: [
		^ self computeClosestToTetrahedron
	].
	
	self error: 'Unsupported case'
]

{ #category : #private }
GJKVoronoiSimplexSolver >> computeClosestToLine [
	| from to delta lambda |
	from := points first.
	to := points second.

	delta := to - from.
	lambda := Origin - from dot: delta.
	lambda <= 0 ifTrue: [ 
		barycentricCoordinates := #(1 0).
		usedPoints := #(true false).
		closestPointToOrigin := from.
		^ self
	].

	lambda := lambda / delta length2.
	lambda >= 1 ifTrue: [ 
		barycentricCoordinates := #(0 1).
		usedPoints := #(false true).
		closestPointToOrigin := to.
		^ self
	].

	closestPointToOrigin := from + (delta * lambda).
	barycentricCoordinates := { 1 - lambda . lambda }.
	usedPoints := #(true true).

]

{ #category : #private }
GJKVoronoiSimplexSolver >> computeClosestToTetrahedron [
	| a b c d abcSide p abdSide acdSide bcdSide subSimplex subBarycentric bestResult newResult |
	a := points first.
	b := points second.
	c := points third.
	d := points fourth.
	p := Origin.
	
	abcSide := self point: p with: d sideOfPlane: a p2: b p3: c.
	abdSide := self point: p with: c sideOfPlane: a p2: b p3: d.
	acdSide := self point: p with: b sideOfPlane: a p2: c p3: d.
	bcdSide := self point: p with: a sideOfPlane: b p2: c p3: d.

	"Is inside?"
	(abcSide >= 0 and: [ abdSide >= 0 and: [acdSide >= 0 and: [bcdSide >= 0]]]) ifTrue: [ 
		closestPointToOrigin := Origin.
		barycentricCoordinates := #(0 0 0 0).
		usedPoints := #(true true true true).
		^ self
	].
	
	bestResult := Float infinity.
	
	abcSide <= 0 ifTrue: [
		subSimplex := self class new
			points: { a . b . c };
			computeClosestToTriangle.
		newResult := subSimplex closestPointToOrigin length2.
		newResult < bestResult ifTrue: [
			bestResult := newResult.
			subBarycentric := subSimplex barycentricCoordinates.
			closestPointToOrigin := subSimplex closestPointToOrigin.
			barycentricCoordinates := {subBarycentric first . subBarycentric second . subBarycentric third . 0}.
			usedPoints := #(true true true false).
		].
	].

	abdSide <= 0 ifTrue: [ 
		subSimplex := self class new
			points: { a . b . d };
			computeClosestToTriangle.
		newResult := subSimplex closestPointToOrigin length2.
		newResult < bestResult ifTrue: [
			bestResult := newResult.
			subBarycentric := subSimplex barycentricCoordinates.
			closestPointToOrigin := subSimplex closestPointToOrigin.
			barycentricCoordinates := {subBarycentric first . subBarycentric second . 0 . subBarycentric third}.
			usedPoints := #(true true false true).
		]
	].

	acdSide <= 0 ifTrue: [ 
		subSimplex := self class new
			points: { a . c . d };
			computeClosestToTriangle.
		newResult := subSimplex closestPointToOrigin length2.
		newResult < bestResult ifTrue: [
			bestResult := newResult.
			subBarycentric := subSimplex barycentricCoordinates.
			closestPointToOrigin := subSimplex closestPointToOrigin.
			barycentricCoordinates := {subBarycentric first . 0 . subBarycentric second . subBarycentric third}.
			usedPoints := #(true false true true).
		]
	].	

	bcdSide <= 0 ifTrue: [ 
		subSimplex := self class new
			points: { b . c . d };
			computeClosestToTriangle.
		newResult := subSimplex closestPointToOrigin length2.
		newResult < bestResult ifTrue: [
			bestResult := newResult.
			subBarycentric := subSimplex barycentricCoordinates.
			closestPointToOrigin := subSimplex closestPointToOrigin.
			barycentricCoordinates := {0 . subBarycentric first . subBarycentric second . subBarycentric third}.
			usedPoints := #(false true true true).
		]
	].	

	bestResult isInfinite ifTrue: [ 
		self error: 'Unsupported case'.
	].

]

{ #category : #private }
GJKVoronoiSimplexSolver >> computeClosestToTriangle [
	"Algorithm from 'Real Time Collision detection' by Ericson. ClosestPtPointTriangle."
	| a b c p snom sdenom tnom tdenom unom udenom n vc va vb lambda u v w |
	a := points first.
	b := points second.
	c := points third.
	p := Origin.

	"P on AB."
	snom := p - a dot: b - a.
	sdenom := p - b dot: a - b.
	
	"P on AC."
	tnom := p - a dot: c - a.
	tdenom := p - c dot: a - c.
	
	"Check the vertex region."
	(snom <= 0.0 and: [ tnom <= 0.0 ]) ifTrue: [
		barycentricCoordinates := #(1 0 0).
		usedPoints := #(true false false).
		closestPointToOrigin := a.
		^ self
	].
	
	"P on BC"
	unom := p - b dot: c - b.
	udenom := p - c dot: b - c.
	(sdenom <= 0.0 and: [ unom <= 0.0 ]) ifTrue: [	
		barycentricCoordinates := #(0 1 0).
		usedPoints := #(false true false).
		closestPointToOrigin := b.
		^ self
	].
	(tdenom <= 0.0 and: [ udenom <= 0.0 ]) ifTrue: [
		barycentricCoordinates := #(0 0 1).
		usedPoints := #(false false true).
		closestPointToOrigin := c.
		^ self
	].
	
	n := b - a cross: c - a.
	
	vc := n dot: (a - p cross: b - p).
	(vc <= 0.0 and: [ snom >= 0.0 and: [sdenom >= 0.0 ] ]) ifTrue: [
		lambda := snom / (snom + sdenom).
		closestPointToOrigin := a + (lambda * (b - a)).
		barycentricCoordinates := { 1 - lambda . lambda . 0 }.
		usedPoints := #(true true false).
		^ self
	].

	va := n dot: (b - p cross: c - p).
	(va <= 0.0 and: [ unom >= 0.0 and: [udenom >= 0.0 ] ]) ifTrue: [
		lambda := unom / (unom + udenom).
		closestPointToOrigin := b + (lambda * (c - b)).
		barycentricCoordinates := { 0 . 1 - lambda . lambda}.
		usedPoints := #(false true true).
		^ self
	].

	vb := n dot: (c - p cross: a - p).
	(vb <= 0.0 and: [ tnom >= 0.0 and: [tdenom >= 0.0 ] ]) ifTrue: [ 
		lambda := tnom / (tnom + tdenom).
		closestPointToOrigin := a + (lambda * (c - a)).
		barycentricCoordinates := { 1 - lambda . 0 . lambda}.
		usedPoints := #(true false true).
		^ self
	].
	
	u := va / (va + vb + vc).
	v := vb / (va + vb + vc).
	w := 1 - u - v.

	barycentricCoordinates := { u . v . w }.
	usedPoints := #(true true true).
	closestPointToOrigin := (a*u) + (b*v) + (c*w)
]

{ #category : #accessing }
GJKVoronoiSimplexSolver >> containsOrigin [
	hasComputedClosest ifFalse: [ 
		self computeClosest.
	].
	^ containsOrigin ifNil: [ containsOrigin := closestPointToOrigin closeTo: Origin ]
]

{ #category : #testing }
GJKVoronoiSimplexSolver >> containsPoint: aPoint [
	^ points anySatisfy: [ :p | p closeTo: aPoint ]
]

{ #category : #initialization }
GJKVoronoiSimplexSolver >> initialize [
	points := #().
	firstPoints := #().
	secondPoints := #().
	barycentricCoordinates := #().
	usedPoints := #().
	hasComputedClosest := false
]

{ #category : #modifying }
GJKVoronoiSimplexSolver >> insertPoint: aPoint [
	self insertPoint: aPoint first: aPoint second: aPoint
	
]

{ #category : #modifying }
GJKVoronoiSimplexSolver >> insertPoint: aPoint first: aFirstPoint second: aSecondPoint [
	points := points , { aPoint }.
	firstPoints := firstPoints , { aFirstPoint }.
	secondPoints := secondPoints , { aSecondPoint }.
	self invalidateCache
	
]

{ #category : #modifying }
GJKVoronoiSimplexSolver >> invalidateCache [
	barycentricCoordinates := #().
	usedPoints := #().
	hasComputedClosest := false.
	closestPointToOrigin := nil.
	containsOrigin := nil.
	
]

{ #category : #private }
GJKVoronoiSimplexSolver >> point: p sideOfPlane: p1 p2: p2 p3: p3 [
	| u v n d |
	u := p2 - p1.
	v := p3 - p1.
	n := u cross: v.
	d := p1 dot: n.
	^ ((p dot: n ) - d) sign
]

{ #category : #private }
GJKVoronoiSimplexSolver >> point: p with: p4 sideOfPlane: p1 p2: p2 p3: p3 [
	| u v n d signP signP4 |
	u := p2 - p1.
	v := p3 - p1.
	n := u cross: v.
	d := p1 dot: n.
	signP := ((p dot: n) - d) sign.
	signP4 := ((p4 dot: n) - d) sign.	
	^ signP*signP4
]

{ #category : #accessing }
GJKVoronoiSimplexSolver >> points [
	^ points
]

{ #category : #accessing }
GJKVoronoiSimplexSolver >> points: newPoints [
	points := newPoints.
	self invalidateCache
]

{ #category : #accessing }
GJKVoronoiSimplexSolver >> reduce [
	| usedPointCount newPoints newBarycentricCoordinates destIndex newFirstPoints newSecondPoints |
	hasComputedClosest ifFalse: [ 
		self computeClosest.
	].

	usedPointCount := 0.
	usedPoints do: [ :each |
		each ifTrue: [ usedPointCount := usedPointCount + 1 ]
	].
	usedPointCount = points size ifTrue: [ ^ self ].
	points size <= 1 ifTrue: [ ^ self ].
	
	newPoints := Array new: usedPointCount.
	newFirstPoints := Array new: usedPointCount.
	newSecondPoints := Array new: usedPointCount.
	newBarycentricCoordinates := Array new: usedPointCount.
	destIndex := 1.
	1 to: points size do: [ :i |
		(usedPoints at: i) ifTrue: [ 
			newPoints at: destIndex put: (points at: i).
			newFirstPoints at: destIndex put: (firstPoints at: i).
			newSecondPoints at: destIndex put: (secondPoints at: i).

			newBarycentricCoordinates at: destIndex put: (barycentricCoordinates at: i).
			destIndex := destIndex + 1
		]
	].

	points := newPoints.
	firstPoints := newFirstPoints.
	secondPoints := newSecondPoints.
	usedPoints := Array new: points size withAll: true.
	barycentricCoordinates := newBarycentricCoordinates.
]

{ #category : #accessing }
GJKVoronoiSimplexSolver >> transformPointsWith: aBlock [
	points := points collect: aBlock.
	firstPoints := firstPoints collect: aBlock.
	secondPoints := secondPoints collect: aBlock.
	self invalidateCache
]

"
I hold a set of geometric functions.
"
Class {
	#name : #GeometricFunctions,
	#superclass : #Object,
	#classVars : [
		'Epsilon',
		'Epsilon2',
		'MaxNumberOfIterations',
		'PenetrationDistanceSampleVectors'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #'closest point computation' }
GeometricFunctions class >> closestPointInLine: line to: targetPoint [
	^ self closestPointInLineFrom: line first to: line second to: targetPoint
]

{ #category : #'closest point computation' }
GeometricFunctions class >> closestPointInLineFrom: a to: b to: targetPoint [
	| delta lambda |	
	delta := b - a.
	lambda := (targetPoint - a dot: delta) / delta length2.
	lambda := lambda min: 1.0 max: 0.0.
	^ a + (delta*lambda)
]

{ #category : #'closest point computation' }
GeometricFunctions class >> closestPointInTetrahedron: tetrahedron to: point [
	^ self closestPointInTetrahedronA: tetrahedron first B: tetrahedron second C: tetrahedron third D: tetrahedron fourth to: point
]

{ #category : #'closest point computation' }
GeometricFunctions class >> closestPointInTetrahedronA: a B: b C: c D: d to: point [
	| p1 |
	
	p1 := Plane point: a point: b point: c.
	(p1 isPointBehind: d) ifTrue: [
		^ self doClosestPointInTetrahedronA: a B: b C: c D: d to: point
	] ifFalse: [
		^ self doClosestPointInTetrahedronA: b B: a C: c D: d to: point
	].
]

{ #category : #'closest point computation' }
GeometricFunctions class >> closestPointInTriangle3D: triangle to: p [
	^ self closestPointInTriangle3DA: triangle first B: triangle second C: triangle third to: p
]

{ #category : #'closest point computation' }
GeometricFunctions class >> closestPointInTriangle3DA: a B: b C: c to: p [
	"Algorithm from 'Real Time Collision detection' by Ericson. ClosestPtPointTriangle."
	| snom sdenom tnom tdenom unom udenom n vc va vb u v w |

	"P on AB."
	snom := p - a dot: b - a.
	sdenom := p - b dot: a - b.
	
	"P on AC."
	tnom := p - a dot: c - a.
	tdenom := p - c dot: a - c.
	
	"Check the vertex region."
	(snom <= 0.0 and: [ tnom <= 0.0 ]) ifTrue: [ ^ a ].
	
	"P on BC"
	unom := p - b dot: c - b.
	udenom := p - c dot: b - c.
	(sdenom <= 0.0 and: [ unom <= 0.0 ]) ifTrue: [ ^ b ].
	(tdenom <= 0.0 and: [ udenom <= 0.0 ]) ifTrue: [ ^ c ].
	
	n := b - a cross: c - a.
	
	vc := n dot: (a - p cross: b - p).
	(vc <= 0.0 and: [ snom >= 0.0 and: [sdenom >= 0.0 ] ]) ifTrue: [ 
		^ a + (snom / (snom + sdenom) * (b - a))
	].

	va := n dot: (b - p cross: c - p).
	(va <= 0.0 and: [ unom >= 0.0 and: [udenom >= 0.0 ] ]) ifTrue: [ 
		^ b + (unom / (unom + udenom) * (c - b))	
	].

	vb := n dot: (c - p cross: a - p).
	(vb <= 0.0 and: [ tnom >= 0.0 and: [tdenom >= 0.0 ] ]) ifTrue: [ 
		^ a + (tnom / (tnom + tdenom) * (c - a))
	].
	
	u := va / (va + vb + vc).
	v := vb / (va + vb + vc).
	w := 1.0 - u - v.

	^ (a*u) + (b*v) + (c*w)
]

{ #category : #private }
GeometricFunctions class >> doClosestPointInTetrahedronA: a B: b C: c D: d to: point [
	| p1 p2 p3 p4 |
	
	p1 := Plane point: a point: b point: c.
	(p1 isPointInsideOrInFront: point) ifTrue: [ ^ self closestPointInTriangle3D: { a . b . c } to: point ].

	p2 := Plane point: b point: a point: d.
	(p2 isPointInsideOrInFront: point) ifTrue: [ ^ self closestPointInTriangle3D: { b . a . d } to: point ].

	p3 := Plane point: a point: c point: d.
	(p3 isPointInsideOrInFront: point) ifTrue: [ ^ self closestPointInTriangle3D: { a . c . d } to: point ].

	p4 := Plane point: c point: b point: d.
	(p4 isPointInsideOrInFront: point) ifTrue: [ ^ self closestPointInTriangle3D: { c . b . d } to: point ].

	"The point itself is in the tetrahedron."
	^ point

]

{ #category : #'closest point computation' }
GeometricFunctions class >> gjkConvexCast: firstSupportFunction from: firstStartPoint to: firstEndPoint with: secondSupportFunction from: secondStartPoint to: secondEndPoint [
	| lambda r n v simplex remainingIterations firstDelta secondDelta firstSupport secondSupport interpolatedFirstPosition interpolatedSecondPosition |
	lambda := 0.
	n := Vector3 zeros.
	
	firstDelta := firstEndPoint - firstStartPoint.
	secondDelta := secondEndPoint - secondStartPoint.
	r := firstDelta - secondDelta.

	firstSupport := (firstSupportFunction value: r) + firstStartPoint.
	secondSupport := (secondSupportFunction value: r negated) + secondStartPoint.
	v := firstSupport - secondSupport.

	interpolatedFirstPosition := firstStartPoint.
	interpolatedSecondPosition := secondStartPoint.
	
	remainingIterations := MaxNumberOfIterations.
	simplex := GJKVoronoiSimplexSolver new.
	[ remainingIterations > 0 and: [v length2 > Epsilon2] ] whileTrue: [
		| w VdotW |
		lambda > 1 ifTrue: [ ^ nil ].
		
		firstSupport := (firstSupportFunction value: v negated) + interpolatedFirstPosition.
		secondSupport := (secondSupportFunction value: v) + interpolatedSecondPosition.
		w := firstSupport - secondSupport.

		VdotW := v dot: w.
		VdotW > 0 ifTrue: [
			| VdotR oldOffset newOffset deltaOffset |
			VdotR := (v dot: r).
			VdotR >= Epsilon2 negated ifTrue: [ ^ nil ].
			lambda := lambda - (VdotW / VdotR).
			lambda > 1 ifTrue: [ ^ nil ].
			n := v.

			oldOffset := interpolatedFirstPosition - interpolatedSecondPosition.
			interpolatedFirstPosition := firstStartPoint interpolateTo: firstEndPoint at: lambda.
			interpolatedSecondPosition := secondStartPoint interpolateTo: secondEndPoint at: lambda.
			newOffset := interpolatedFirstPosition - interpolatedSecondPosition.
			deltaOffset := newOffset - oldOffset.
			
			firstSupport := (firstSupportFunction value: v negated) + interpolatedFirstPosition.
			secondSupport := (secondSupportFunction value: v) + interpolatedSecondPosition.
			w := firstSupport - secondSupport.
			simplex transformPointsWith: [ :sp | sp + deltaOffset ].
			simplex containsOrigin ifTrue: [ ^ {lambda . n } ].
			simplex reduce.
		].

		(simplex containsPoint: w) ifFalse: [ 
			simplex insertPoint: w.
		].

		simplex containsOrigin ifTrue: [ 
			remainingIterations := 0
		] ifFalse: [ 
			v := simplex closestPointToOrigin.
			simplex reduce.
			remainingIterations := remainingIterations - 1
		].
	].

	 ^ {lambda . n }
]

{ #category : #'closest point computation' }
GeometricFunctions class >> gjkDistanceFrom: firstSupportFunction to: secondSupportFunction [
	| simplex |
	simplex := self gjkSimplexFor: firstSupportFunction with: secondSupportFunction.
	^ simplex containsOrigin ifTrue: [ 0 ] ifFalse: [ simplex closestPointToOrigin length ]
]

{ #category : #'intersection testing' }
GeometricFunctions class >> gjkIntersectionTest: firstSupportFunction with: secondSupportFunction [
	^ (self gjkDistanceFrom: firstSupportFunction to: secondSupportFunction) closeTo: 0
]

{ #category : #'closest point computation' }
GeometricFunctions class >> gjkRayCast: ray support: supportFunction [
	"Algorithm from 'Ray Casting against General Convex Objectswith Application to Continuous CollisionDetection' by G. Van Den Bergen."
	| lambda lambdaMax x s r n v simplex remainingIterations |
	
	"
	Code for testing the convex cast.
	"
	"false ifTrue: [ 
		| startPoint endPoint pair |
		startPoint := ray pointAtDistance: ray tmin.
		endPoint := ray pointAtDistance: (ray tmax min: 1000000).
		pair := self gjkConvexCast: [:d | Vector3 zeros] from: startPoint to: endPoint
			with: supportFunction from: Vector3 zeros to: Vector3 zeros.
		pair ifNil: [ ^ pair ].
		^ { ray tmin interpolateTo: (ray tmax min: 1000000) at: pair first . pair second }
	]."

	lambda := ray tmin.
	lambdaMax := ray tmax.
	s := ray origin.
	r := ray direction.
	x := s + (r * lambda).
	n := Vector3 zeros.
	
	v := x - (supportFunction value: r negated).
	simplex := GJKVoronoiSimplexSolver new.
	remainingIterations := MaxNumberOfIterations.
	[ remainingIterations > 0 and: [v length2 > Epsilon2] ] whileTrue: [
		| w p VdotW |
		lambda > lambdaMax ifTrue: [ ^ nil ].

		p := supportFunction value: v.
		w := x - p.
		VdotW := v dot: w.
		VdotW > 0 ifTrue: [
			| VdotR oldX deltaX |
			VdotR := (v dot: r).
			VdotR >= Epsilon2 negated ifTrue: [ ^ nil ].
			lambda := lambda - (VdotW / VdotR).
			lambda > lambdaMax ifTrue: [ ^ nil ].
			oldX := x.
			x := s + (r * lambda).
			n := v.
			w := x - p.
			deltaX := x - oldX.
			simplex transformPointsWith: [ :sp | sp + deltaX ].
			simplex containsOrigin ifTrue: [ ^ {lambda . n } ].
			simplex reduce.
		].

		(simplex containsPoint: w) ifFalse: [ 
			simplex insertPoint: w.
		].
		simplex containsOrigin ifTrue: [ 
			remainingIterations := 0
		] ifFalse: [ 
			v := simplex closestPointToOrigin.
			simplex reduce.
			remainingIterations := remainingIterations - 1
		].
	].

	 ^ {lambda . n }
]

{ #category : #'closest point computation' }
GeometricFunctions class >> gjkSimplexFor: firstSupportFunction with: secondSupportFunction [
	| lastPoint simplex nextDirection remainingIterations |
	nextDirection := Vector3 x: 1.
	lastPoint := (firstSupportFunction value: nextDirection) - (secondSupportFunction value: nextDirection negated).
	simplex := GJKVoronoiSimplexSolver with: lastPoint.
	nextDirection := lastPoint negated.
		
	remainingIterations := MaxNumberOfIterations.
	[ remainingIterations > 0 ] whileTrue: [ 	
		| nextPoint delta |
		nextPoint := (firstSupportFunction value: nextDirection) - (secondSupportFunction value: nextDirection negated).

		"Are we getting closer to the origin?"
		delta := nextPoint - lastPoint.
		(delta dot: nextDirection) <= Epsilon ifTrue: [
			^ simplex
		].
	
		simplex insertPoint: nextPoint.
		lastPoint := nextPoint.
		
		"Do we contain the origin?"
		simplex containsOrigin ifTrue: [ ^ simplex ].
	
		"Advance in direction to the origin."
		nextDirection := simplex closestPointToOrigin negated.
		
		"Reduce the simplex."
		simplex reduce.
	].

	^ simplex
]

{ #category : #initialization }
GeometricFunctions class >> initialize [
	| penetrationDistanceSampleVectorCoordinates sourceIndex |
	MaxNumberOfIterations := 32.
	Epsilon := 0.00001.
	Epsilon2 := Epsilon*Epsilon.

	PenetrationDistanceSampleVectors := OrderedCollection new.
	penetrationDistanceSampleVectorCoordinates := #(-0.7071067811865476 0.0 -0.7071067811865476 -0.5773502691896258 -0.5773502691896258 -0.5773502691896258 -0.7071067811865476 -0.7071067811865476 0.0 -1.0 0.0 0.0 -0.5773502691896258 -0.5773502691896258 0.5773502691896258 -0.7071067811865476 0.0 0.7071067811865476 -0.5773502691896258 0.5773502691896258 0.5773502691896258 -0.7071067811865476 0.7071067811865476 0.0 -0.5773502691896258 0.5773502691896258 -0.5773502691896258 0.7071067811865476 0.0 -0.7071067811865476 0.5773502691896258 0.5773502691896258 -0.5773502691896258 0.7071067811865476 0.7071067811865476 0.0 1.0 0.0 0.0 0.5773502691896258 0.5773502691896258 0.5773502691896258 0.7071067811865476 0.0 0.7071067811865476 0.5773502691896258 -0.5773502691896258 0.5773502691896258 0.7071067811865476 -0.7071067811865476 0.0 0.5773502691896258 -0.5773502691896258 -0.5773502691896258 0.0 -0.7071067811865476 -0.7071067811865476 0.0 -1.0 0.0 0.0 -0.7071067811865476 0.7071067811865476 0.0 0.7071067811865476 -0.7071067811865476 0.0 1.0 0.0 0.0 0.7071067811865476 0.7071067811865476 0.0 0.0 -1.0 0.0 0.0 1.0).
	
	sourceIndex := 1.
	1 to: penetrationDistanceSampleVectorCoordinates size  // 3 do: [ :i |
	| x y z |
		x := penetrationDistanceSampleVectorCoordinates at: sourceIndex.
		y := penetrationDistanceSampleVectorCoordinates at: sourceIndex + 1.
		z := penetrationDistanceSampleVectorCoordinates at: sourceIndex + 2.
		PenetrationDistanceSampleVectors add: (Vector3 x: x y: y z: z).
		sourceIndex := sourceIndex + 3
	].
	PenetrationDistanceSampleVectors := PenetrationDistanceSampleVectors asArray
]

{ #category : #testing }
GeometricFunctions class >> isPoint3DCollinear: first with: second with: third [
	| u v |
	u := second - first.
	v := third - first.
	^ (u cross: v) length2 closeTo: 0.0
]

{ #category : #testing }
GeometricFunctions class >> isPoint3DCoplanar: first with: second with: third with: fourth [
	"Algorithm from: http://www.ambrsoft.com/TrigoCalc/Plan3D/PointsCoplanar.htm"
	| v1 v2 v3 |
	v1 := second - first.
	v2 := third - first.	
	v3 := fourth - first.
	^ (v1 dot: (v2 cross: v3)) closeTo: 0.0
]

{ #category : #'closest point computation' }
GeometricFunctions class >> samplePenetrationDistanceAndNormalForSupport: firstSupport with: secondSupport [
	| bestDistanceSquared bestNormal |
	bestDistanceSquared := Float infinity.
	bestNormal := Vector3 zeros.
	PenetrationDistanceSampleVectors do: [ :sampleVector |
		| supportDistanceSquared |
		supportDistanceSquared := ((firstSupport value: sampleVector) - (secondSupport value: sampleVector negated)) length2.
		supportDistanceSquared < bestDistanceSquared ifTrue: [
			bestDistanceSquared := supportDistanceSquared.
			bestNormal := sampleVector
		]
	].
	
	^ { bestDistanceSquared sqrt / 2 . bestNormal }
]

{ #category : #'support function utilities' }
GeometricFunctions class >> transformSupportFunction: supportFunction with: transform [
	^ [ :d | transform transformPosition: (supportFunction value: (transform inverseTransformVector3: d)) ]
]

{ #category : #'see class side' }
GeometricFunctions >> seeClassSide [
]

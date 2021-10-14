"
I hold a set of geometric functions.
"
Class {
	#name : #GeometricFunctions,
	#superclass : #Object,
	#classVars : [
		'Epsilon',
		'Epsilon2',
		'MaxNumberOfIterations'
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
GeometricFunctions class >> gjkDistanceFrom: firstSupportFunction to: secondSupportFunction [
	| simplex |
	simplex := self gjkSimplexFrom: firstSupportFunction to: secondSupportFunction.
	^ simplex containsOrigin ifTrue: [ 0 ] ifFalse: [ simplex lastPoint differencePoint length ]
]

{ #category : #'closest point computation' }
GeometricFunctions class >> gjkSimplexFrom: firstSupportFunction to: secondSupportFunction [
	| lastPoint simplex nextDirection remainingIterations |
	lastPoint := GJKSimplexPoint forDirection: (Vector3 x: 1) firstSupport: firstSupportFunction secondSupport: secondSupportFunction.
	simplex := GJKSimplex with: lastPoint.
	nextDirection := lastPoint 	differencePoint negated.
		
	remainingIterations := MaxNumberOfIterations.
	[ remainingIterations > 0 ] whileTrue: [ 	
		| nextPoint delta |
		nextPoint := GJKSimplexPoint forDirection: nextDirection firstSupport: firstSupportFunction secondSupport: secondSupportFunction.

		"Are we getting closer to the origin?"
		delta := nextPoint differencePoint - lastPoint differencePoint.
		(delta dot: nextDirection) <= Epsilon ifTrue: [
			^ simplex
		].
	
		simplex insertPoint: nextPoint.
		lastPoint := nextPoint.
		
		"Do we contain the origin?"
		simplex containsOrigin ifTrue: [ ^ simplex ].
	
		"Advance in direction to the origin."
		nextDirection := simplex closestPointToOrigin negated
	].

	^ simplex
]

{ #category : #initialization }
GeometricFunctions class >> initialize [
	MaxNumberOfIterations := 32.
	Epsilon := 0.00001.
	Epsilon2 := Epsilon*Epsilon.
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

{ #category : #'see class side' }
GeometricFunctions >> seeClassSide [
]

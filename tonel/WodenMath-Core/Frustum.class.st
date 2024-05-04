"
I represent the geometry of a camera frustum. I am typically used for implementing frustum culling.
"
Class {
	#name : #Frustum,
	#superclass : #Object,
	#instVars : [
		'leftBottomNear',
		'rightBottomNear',
		'leftTopNear',
		'rightTopNear',
		'leftBottomFar',
		'rightBottomFar',
		'leftTopFar',
		'rightTopFar',
		'planes'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #computation }
Frustum >> computePlanes [
	planes := { 
		"Near plane"
   		Plane point: leftBottomNear point: rightBottomNear point: leftTopNear.
		"Far plane"
   		Plane point: rightBottomFar point: leftBottomFar point: leftTopFar.

		"Left"
		Plane point: leftBottomNear point: leftTopNear point: leftTopFar.
		"Right"
		Plane point: rightTopNear point: rightBottomNear point: rightTopFar.

		"Bottom"
   		Plane point: rightBottomNear point: leftBottomNear point: leftBottomFar.
		"Top"
		Plane point: leftTopNear point: rightTopNear point: leftTopFar
	}
]

{ #category : #enumerating }
Frustum >> corners [
	^ {
		leftBottomNear.
		rightBottomNear.
		leftTopNear.
		rightTopNear.
		leftBottomFar.
		rightBottomFar.
		leftTopFar.
		rightTopFar.
	}
]

{ #category : #enumerating }
Frustum >> cornersDo: aBlock [
	aBlock value: leftBottomNear.
	aBlock value: rightBottomNear.
	aBlock value: leftTopNear.
	aBlock value: rightTopNear.
	aBlock value: leftBottomFar.
	aBlock value: rightBottomFar.
	aBlock value: leftTopFar.
	aBlock value: rightTopFar.
]

{ #category : #testing }
Frustum >> intersectsOrContainsBox: box [
	box isEmpty ifTrue: [ ^ false ].
	box isInfinite ifTrue: [ ^ true ].
	^ (self isBoxOutside: box) not
]

{ #category : #testing }
Frustum >> intersectsOrContainsSphereWithCenter: sphereCenter radius: sphereRadius [
	| distance |
	1 to: planes size do: [ :planeIndex |
		distance := (planes at: planeIndex) signedDistanceToPoint: sphereCenter.
		distance > sphereRadius ifTrue: [
			^ false
		]
	].
	^ true
]

{ #category : #testing }
Frustum >> isBoxOutside: box [
	"This technique comes from this article: http://www.lighthouse3d.com/tutorials/view-frustum-culling/geometric-approach-testing-boxes-ii/"
	^ planes anySatisfy: [ :each |
		each isPointInFront: (box negativeVertex: each normal)
	]
]

{ #category : #accessing }
Frustum >> leftBottomFar [

	^ leftBottomFar
]

{ #category : #accessing }
Frustum >> leftBottomFar: anObject [

	leftBottomFar := anObject
]

{ #category : #accessing }
Frustum >> leftBottomNear [

	^ leftBottomNear
]

{ #category : #accessing }
Frustum >> leftBottomNear: anObject [

	leftBottomNear := anObject
]

{ #category : #accessing }
Frustum >> leftTopFar [

	^ leftTopFar
]

{ #category : #accessing }
Frustum >> leftTopFar: anObject [

	leftTopFar := anObject
]

{ #category : #accessing }
Frustum >> leftTopNear [

	^ leftTopNear
]

{ #category : #accessing }
Frustum >> leftTopNear: anObject [

	leftTopNear := anObject
]

{ #category : #computation }
Frustum >> makeFrustumLeft: left right: right bottom: bottom top: top near: near far: far [
	|  factor |
	leftBottomNear := Vector3 x: left y: bottom z: near negated.
	rightBottomNear := Vector3 x: right y: bottom z: near negated.
	leftTopNear := Vector3 x: left y: top z: near negated.
	rightTopNear := Vector3 x: right y: top z: near negated.

	factor := far / near.
	leftBottomFar := leftBottomNear * factor.
	rightBottomFar := rightBottomNear * factor.
	leftTopFar := leftTopNear * factor.
	rightTopFar := rightTopNear * factor.

	self computePlanes.
]

{ #category : #computation }
Frustum >> makeOrthoLeft: left right: right bottom: bottom top: top near: near far: far [
	leftBottomNear := Vector3 x: left y: bottom z: near negated.
	rightBottomNear := Vector3 x: right y: bottom z: near negated.
	leftTopNear := Vector3 x: left y: top z: near negated.
	rightTopNear := Vector3 x: right y: top z: near negated.

	leftBottomFar := Vector3 x: left y: bottom z: far negated.
	rightBottomFar := Vector3 x: right y: bottom z: far negated.
	leftTopFar := Vector3 x: left y: top z: far negated.
	rightTopFar := Vector3 x: right y: top z: far negated.

	self computePlanes.
]

{ #category : #computation }
Frustum >> makePerspectiveFovY: fovy aspect: aspect near: near far: far [
	| fovyRad top right |
	fovyRad := fovy degreesToRadians * 0.5.
	top := near * fovyRad tan.
	right := top * aspect.
	self makeFrustumLeft: right negated right: right bottom: top negated top: top near: near far: far
]

{ #category : #computation }
Frustum >> makeWithTangents: tangents near: nearDistance far: farDistance [
	self  makeFrustumLeft: tangents left * nearDistance right: tangents right * nearDistance
		bottom: tangents bottom * nearDistance top: tangents top * nearDistance
		near: nearDistance far: farDistance
]

{ #category : #computation }
Frustum >> normalizedPoint: aPosition linearDepth: aDepth [
	^ (self normalizedPointInNearPlane: aPosition) interpolateTo: (self normalizedPointInFarPlane: aPosition) at: aDepth
]

{ #category : #computation }
Frustum >> normalizedPointInFarPlane: normalizedPoint [
	^ (leftBottomFar interpolateTo: rightBottomFar at: normalizedPoint x) interpolateTo:
		(leftTopFar interpolateTo: rightTopFar at: normalizedPoint x) at: normalizedPoint y.
]

{ #category : #computation }
Frustum >> normalizedPointInNearPlane: normalizedPoint [
	^ (leftBottomNear interpolateTo: rightBottomNear at: normalizedPoint x) interpolateTo:
		(leftTopNear interpolateTo: rightTopNear at: normalizedPoint x) at: normalizedPoint y.
]

{ #category : #accessing }
Frustum >> planes [

	^ planes
]

{ #category : #accessing }
Frustum >> planes: anObject [

	planes := anObject
]

{ #category : #enumerating }
Frustum >> printOn: aStream [
	aStream nextPutAll: self class name; nextPutAll: ' corners: '; print: self corners
]

{ #category : #computation }
Frustum >> rayForNormalizedPoint: normalizedPoint [
	| nearPoint farPoint |
	nearPoint := self normalizedPointInNearPlane: normalizedPoint.
	farPoint := self normalizedPointInFarPlane: normalizedPoint.
	^ Ray3D from: nearPoint to: farPoint
]

{ #category : #accessing }
Frustum >> rightBottomFar [

	^ rightBottomFar
]

{ #category : #accessing }
Frustum >> rightBottomFar: anObject [

	rightBottomFar := anObject
]

{ #category : #accessing }
Frustum >> rightBottomNear [

	^ rightBottomNear
]

{ #category : #accessing }
Frustum >> rightBottomNear: anObject [

	rightBottomNear := anObject
]

{ #category : #accessing }
Frustum >> rightTopFar [

	^ rightTopFar
]

{ #category : #accessing }
Frustum >> rightTopFar: anObject [

	rightTopFar := anObject
]

{ #category : #accessing }
Frustum >> rightTopNear [

	^ rightTopNear
]

{ #category : #accessing }
Frustum >> rightTopNear: anObject [

	rightTopNear := anObject
]

{ #category : #splitting }
Frustum >> splitAtBottomLambda: bottomLambda topLambda: topLambda [
	self assert: (bottomLambda between: 0 and: 1).
	self assert: (topLambda between: 0 and: 1).

	^ self class basicNew
		leftBottomNear: (leftBottomNear interpolateTo: leftTopNear at: bottomLambda);
		rightBottomNear: (rightBottomNear interpolateTo: rightTopNear at: bottomLambda);
		leftTopNear: (leftBottomNear interpolateTo: leftTopNear at: topLambda);
		rightTopNear: (rightBottomNear interpolateTo: rightTopNear at: topLambda);

		leftBottomFar: (leftBottomFar interpolateTo: leftTopFar at: bottomLambda);
		rightBottomFar: (rightBottomFar interpolateTo: rightTopFar at: bottomLambda);
		leftTopFar: (leftBottomFar interpolateTo: leftTopFar at: topLambda);
		rightTopFar: (rightBottomFar interpolateTo: rightTopFar at: topLambda);
		computePlanes;
		yourself
]

{ #category : #splitting }
Frustum >> splitAtLeftLambda: leftLambda rightLambda: rightLambda [
	self assert: (leftLambda between: 0 and: 1).
	self assert: (rightLambda between: 0 and: 1).

	^ self class basicNew
		leftBottomNear: (leftBottomNear interpolateTo: rightBottomNear at: leftLambda);
		rightBottomNear: (leftBottomNear interpolateTo: rightBottomNear at: rightLambda);
		leftTopNear: (leftTopNear interpolateTo: rightTopNear at: leftLambda);
		rightTopNear: (leftTopNear interpolateTo: rightTopNear at: rightLambda);

		leftBottomFar: (leftBottomFar interpolateTo: rightBottomFar at: leftLambda);
		rightBottomFar: (leftBottomFar interpolateTo: rightBottomFar at: rightLambda);
		leftTopFar: (leftTopFar interpolateTo: rightTopFar at: leftLambda);
		rightTopFar: (leftTopFar interpolateTo: rightTopFar at: rightLambda);
		computePlanes;
		yourself
]

{ #category : #splitting }
Frustum >> splitAtNearLambda: splitNearLambda farLambda: splitFarLambda [
	self assert: (splitNearLambda between: 0 and: 1).
	self assert: (splitFarLambda between: 0 and: 1).

	^ self class basicNew
		leftBottomNear: (leftBottomNear interpolateTo: leftBottomFar at: splitNearLambda);
		rightBottomNear: (rightBottomNear interpolateTo: rightBottomFar at: splitNearLambda);
		leftTopNear: (leftTopNear interpolateTo: leftTopFar at: splitNearLambda);
		rightTopNear: (rightTopNear interpolateTo: rightTopFar at: splitNearLambda);

		leftBottomFar: (leftBottomNear interpolateTo: leftBottomFar at: splitFarLambda);
		rightBottomFar: (rightBottomNear interpolateTo: rightBottomFar at: splitFarLambda);
		leftTopFar: (leftTopNear interpolateTo: leftTopFar at: splitFarLambda);
		rightTopFar: (rightTopNear interpolateTo: rightTopFar at: splitFarLambda);
		computePlanes;
		yourself
]

{ #category : #support }
Frustum >> supportFunction [
	^ [ :d | self supportInDirection: d ]
]

{ #category : #support }
Frustum >> supportInDirection: d [
	| best bestDot |
	best := nil.
	bestDot := Float negativeInfinity.
	self cornersDo: [ :v |
		| dot |
		dot := v dot: d.
		dot > bestDot ifTrue: [
			best := v.
			bestDot := dot
		]
	].

	^ best

]

{ #category : #transforming }
Frustum >> transformedWith: transform [
	^ self class basicNew
		leftBottomNear: (transform transformPosition: leftBottomNear);
		rightBottomNear: (transform transformPosition: rightBottomNear);
		leftTopNear: (transform transformPosition: leftTopNear);
		rightTopNear: (transform transformPosition: rightTopNear);

		leftBottomFar: (transform transformPosition: leftBottomFar);
		rightBottomFar: (transform transformPosition: rightBottomFar);
		leftTopFar: (transform transformPosition: leftTopFar);
		rightTopFar: (transform transformPosition: rightTopFar);
		computePlanes;
		yourself
]

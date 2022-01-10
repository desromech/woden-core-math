"
I am plane defined in 3D in hessian form:

```
<P, N> = D
```
"
Class {
	#name : #Plane,
	#superclass : #Object,
	#instVars : [
		'normal',
		'distance'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #'as yet unclassified' }
Plane class >> normal: normal distance: distance [
	^ self basicNew normal: normal; distance: distance; yourself
]

{ #category : #'as yet unclassified' }
Plane class >> nx: nx ny: ny nz: nz distance: distance [
	^ self normal: (Vector3 x: nx y: ny z: nz) distance: distance
]

{ #category : #'as yet unclassified' }
Plane class >> point: first point: second point: third [
	^ self basicNew setForPoint: first point: second point: third
]

{ #category : #accessing }
Plane >> distance [

	^ distance
]

{ #category : #accessing }
Plane >> distance: anObject [

	distance := anObject
]

{ #category : #geometry }
Plane >> distanceToPoint: aPoint [
	^ (self signedDistanceToPoint: aPoint) abs
]

{ #category : #initialization }
Plane >> initialize [
	normal := Vector3 zeros.
	distance := 0.
]

{ #category : #'ray casting' }
Plane >> intersectionWithRay: ray [
	| den t |
	den := normal dot: ray direction.
	(den closeTo: 0) ifTrue: [ ^ nil ].
	t := ((distance - (normal dot: ray origin)) / den).
	(t < ray tmin or: [t > ray tmax]) ifTrue: [ ^ nil ].
	^ t
]

{ #category : #geometry }
Plane >> isPointBehind: aPoint [
	^ (self signedDistanceToPoint: aPoint) < 0
]

{ #category : #geometry }
Plane >> isPointInFront: aPoint [
	^ (self signedDistanceToPoint: aPoint) > 0
]

{ #category : #geometry }
Plane >> isPointInsideOrBehind: aPoint [
	^ (self signedDistanceToPoint: aPoint) <= 0
]

{ #category : #geometry }
Plane >> isPointInsideOrInFront: aPoint [
	^ (self signedDistanceToPoint: aPoint) >= 0
]

{ #category : #testing }
Plane >> isZero [
	^ normal isZeros and: [ distance isZero ]
]

{ #category : #accessing }
Plane >> normal [

	^ normal
]

{ #category : #accessing }
Plane >> normal: anObject [

	normal := anObject
]

{ #category : #accessing }
Plane >> setForPoint: first point: second point: third [
	| u v |
	u := second - first.
	v := third - first.
	normal := (u cross: v) normalized.
	distance := first dot: normal
]

{ #category : #geometry }
Plane >> signedDistanceToPoint: aPoint [
	^ (normal dot: aPoint) - distance
]

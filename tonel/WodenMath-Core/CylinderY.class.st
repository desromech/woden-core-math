"
I am a cylinder aligned with the Y axis.
"
Class {
	#name : #CylinderY,
	#superclass : #Object,
	#instVars : [
		'center',
		'height',
		'radius'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #construction }
CylinderY class >> center: center height: height radius: radius [
	^ self basicNew center: center; height: height; radius: radius; yourself
]

{ #category : #construction }
CylinderY class >> height: height radius: radius [
	^ self new height: height; radius: radius; yourself
]

{ #category : #'ray casting' }
CylinderY >> capIntersectionIntersectionWithRay: ray [
	| oy dy halfHeight t1 t2 isT1Valid isT2Valid |
	dy := ray direction y.
	dy isZero ifTrue: [ ^ nil ].

	oy := ray origin y - center y.	

	halfHeight := self halfHeight.
	t1 := (halfHeight - oy) / dy.
	t2 := (halfHeight negated - oy) / dy.
	
	isT1Valid := (t1 between: ray tmin and: ray tmax) and: [ self isCapPointInCylinder: (ray pointAtDistance: t1) ].
	isT2Valid := (t2 between: ray tmin and: ray tmax) and: [ self isCapPointInCylinder: (ray pointAtDistance: t2) ].

	(isT1Valid and: [isT2Valid]) ifTrue: [ ^ t1 min: t2 ].
	isT1Valid ifTrue: [ ^ t1 ].
	isT2Valid ifTrue: [ ^ t2 ].

	^ nil
]

{ #category : #accessing }
CylinderY >> center [

	^ center
]

{ #category : #accessing }
CylinderY >> center: anObject [

	center := anObject
]

{ #category : #'as yet unclassified' }
CylinderY >> computeNormalForPoint: point [
	| delta hh |
	delta := point - center.
	hh := self halfHeight.
	(delta y closeTo: hh) ifTrue: [ ^ Vector3 y: 1 ].
	(delta y closeTo: hh negated) ifTrue: [ ^ Vector3 y: -1 ].

	^ (Vector3 x: delta x y: 0 z: delta z) normalized
]

{ #category : #accessing }
CylinderY >> halfHeight [
	^ height / 2
]

{ #category : #accessing }
CylinderY >> height [

	^ height
]

{ #category : #accessing }
CylinderY >> height: anObject [

	height := anObject
]

{ #category : #'ray casting' }
CylinderY >> infiniteCylinderIntersectionWithRay: ray [
	| d d2 o o2 a b c delta deltaSqrt t1 t2 isT1Valid isT2Valid |
	d := ray direction.
	d2 := d*d.

	o := ray origin - center.
	o2 := o*o.
	
	a := d2 x + d2 z.
	b := 2 * ((o x * d x) + (o z * d z)).
	c := o2 x + o2 z - (radius*radius).
	
	delta := b*b - (4*a*c).
	delta < 0 ifTrue: [ ^ nil ].

	deltaSqrt := delta sqrt.
	t1 := (b negated - deltaSqrt) / (2*a).	
	t2 := (b negated + deltaSqrt) / (2*a).
	
	isT1Valid := (t1 between: ray tmin and: ray tmax) and: [self isInfiniteCylinderPointInside: (ray pointAtDistance: t1)].
	isT2Valid := (t2 between: ray tmin and: ray tmax) and: [self isInfiniteCylinderPointInside: (ray pointAtDistance: t2)].
	
	(isT1Valid and: [isT2Valid]) ifTrue: [ ^ t1 min: t2 ].
	isT1Valid ifTrue: [ ^ t1 ].
	isT2Valid ifTrue: [ ^ t2 ].
	^ nil
]

{ #category : #initialization }
CylinderY >> initialize [
	center := Vector3 zeros.
	height := 0.
	radius := 0.
]

{ #category : #'ray casting' }
CylinderY >> intersectionWithRay: ray [
	| capIntersection infiniteCylinderIntersection |

	capIntersection := self capIntersectionIntersectionWithRay: ray.
	infiniteCylinderIntersection := self infiniteCylinderIntersectionWithRay: ray.

	infiniteCylinderIntersection ifNil: [ ^ capIntersection ].
	capIntersection ifNil: [ ^ infiniteCylinderIntersection ].
	
	^ capIntersection min: infiniteCylinderIntersection
]

{ #category : #'as yet unclassified' }
CylinderY >> isCapPointInCylinder: capPoint [
	| dx dz |
	dx := capPoint x - center x.
	dz := capPoint z - center z.
	^ (dx*dx) + (dz*dz) <= (radius*radius)
]

{ #category : #'as yet unclassified' }
CylinderY >> isInfiniteCylinderPointInside: infiniteCylinderPoint [
	| halfHeight |
	halfHeight := self halfHeight.
	^ infiniteCylinderPoint y between: halfHeight negated and: halfHeight
]

{ #category : #accessing }
CylinderY >> radius [

	^ radius
]

{ #category : #accessing }
CylinderY >> radius: anObject [

	radius := anObject
]

{ #category : #support }
CylinderY >> supportFunction [
	^ [ :d | self supportInDirection: d ]
]

{ #category : #support }
CylinderY >> supportInDirection: d [
	| sigma sor |
	sigma := ((d x * d x) + (d z * d z)) sqrt.
	sor := sigma > 0 ifTrue: [ radius / sigma] ifFalse: [ 0 ].
	^ center + (Vector3 x: sor * d x y: d y sign * self halfHeight z: sor * d z).
	

]

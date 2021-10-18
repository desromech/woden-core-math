"
I am a cylinder aligned with the X axis.
"
Class {
	#name : #CylinderX,
	#superclass : #CylinderY,
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #'ray casting' }
CylinderX >> capIntersectionIntersectionWithRay: ray [
	| ox dx halfHeight t1 t2 isT1Valid isT2Valid |
	dx := ray direction x.
	dx isZero ifTrue: [ ^ nil ].

	ox := ray origin x - center x.	

	halfHeight := self halfHeight.
	t1 := (halfHeight - ox) / dx.
	t2 := (halfHeight negated - ox) / dx.
	
	isT1Valid := (t1 between: ray tmin and: ray tmax) and: [ self isCapPointInCylinder: (ray pointAtDistance: t1) ].
	isT2Valid := (t2 between: ray tmin and: ray tmax) and: [ self isCapPointInCylinder: (ray pointAtDistance: t2) ].

	(isT1Valid and: [isT2Valid]) ifTrue: [ ^ t1 min: t2 ].
	isT1Valid ifTrue: [ ^ t1 ].
	isT2Valid ifTrue: [ ^ t2 ].

	^ nil
]

{ #category : #geometry }
CylinderX >> computeNormalForPoint: point [
	| delta hh |
	delta := point - center.
	hh := self halfHeight.
	(delta x closeTo: hh) ifTrue: [ ^ Vector3 x: 1 ].
	(delta x closeTo: hh negated) ifTrue: [ ^ Vector3 x: -1 ].

	^ (Vector3 x: 0 y: delta y z: delta z) normalized
]

{ #category : #'ray casting' }
CylinderX >> infiniteCylinderIntersectionWithRay: ray [
	| d d2 o o2 a b c delta deltaSqrt t1 t2 isT1Valid isT2Valid |
	d := ray direction.
	d2 := d*d.

	o := ray origin - center.
	o2 := o*o.
	
	a := d2 y + d2 z.
	b := 2 * ((o y * d y) + (o z * d z)).
	c := o2 y + o2 z - (radius*radius).
	
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

{ #category : #testing }
CylinderX >> isCapPointInCylinder: capPoint [
	| dy dz |
	dy := capPoint y - center y.
	dz := capPoint z - center z.
	^ (dy*dy) + (dz*dz) <= (radius*radius)
]

{ #category : #testing }
CylinderX >> isInfiniteCylinderPointInside: infiniteCylinderPoint [
	| halfHeight |
	halfHeight := self halfHeight.
	^ infiniteCylinderPoint x between: halfHeight negated and: halfHeight
]

{ #category : #support }
CylinderX >> supportInDirection: d [
	| sigma sor |
	sigma := ((d y * d y) + (d z * d z)) sqrt.
	sor := sigma > 0 ifTrue: [ radius / sigma] ifFalse: [ 0 ].
	^ center + (Vector3 x: d x sign * self halfHeight y: sor * d y z: sor * d z).

]

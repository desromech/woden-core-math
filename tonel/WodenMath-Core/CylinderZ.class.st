"
I am a cylinder aligned with the Z axis.
"
Class {
	#name : #CylinderZ,
	#superclass : #CylinderY,
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #private }
CylinderZ >> capIntersectionIntersectionWithRay: ray [
	| oz dz halfHeight t1 t2 isT1Valid isT2Valid |
	dz := ray direction z.
	dz isZero ifTrue: [ ^ nil ].

	oz := ray origin z - center z.	

	halfHeight := self halfHeight.
	t1 := (halfHeight - oz) / dz.
	t2 := (halfHeight negated - oz) / dz.
	
	isT1Valid := (t1 between: ray tmin and: ray tmax) and: [ self isCapPointInCylinder: (ray pointAtDistance: t1) ].
	isT2Valid := (t2 between: ray tmin and: ray tmax) and: [ self isCapPointInCylinder: (ray pointAtDistance: t2) ].

	(isT1Valid and: [isT2Valid]) ifTrue: [ ^ t1 min: t2 ].
	isT1Valid ifTrue: [ ^ t1 ].
	isT2Valid ifTrue: [ ^ t2 ].

	^ nil
]

{ #category : #geometry }
CylinderZ >> computeNormalForPoint: point [
	| delta hh |
	delta := point - center.
	hh := self halfHeight.
	(delta z closeTo: hh) ifTrue: [ ^ Vector3 z: 1 ].
	(delta z closeTo: hh negated) ifTrue: [ ^ Vector3 z: -1 ].

	^ (Vector3 x: delta x y: delta y z: 0) normalized
]

{ #category : #private }
CylinderZ >> infiniteCylinderIntersectionWithRay: ray [
	| d d2 o o2 a b c delta deltaSqrt t1 t2 isT1Valid isT2Valid |
	d := ray direction.
	d2 := d*d.

	o := ray origin - center.
	o2 := o*o.
	
	a := d2 x + d2 y.
	b := 2 * ((o x * d x) + (o y * d y)).
	c := o2 x + o2 y - (radius*radius).
	
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
CylinderZ >> isCapPointInCylinder: capPoint [
	| dx dy |
	dx := capPoint x - center x.
	dy := capPoint y - center y.
	^ (dx*dx) + (dy*dy) <= (radius*radius)
]

{ #category : #testing }
CylinderZ >> isInfiniteCylinderPointInside: infiniteCylinderPoint [
	| halfHeight |
	halfHeight := self halfHeight.
	^ infiniteCylinderPoint z between: halfHeight negated and: halfHeight
]

{ #category : #geometry }
CylinderZ >> supportInDirection: d [
	| sigma sor |
	sigma := ((d x * d x) + (d y * d y)) sqrt.
	sor := sigma > 0 ifTrue: [ radius / sigma] ifFalse: [ 0 ].
	^ center + (Vector3 x: sor * d x y: sor * d y z: d z sign * self halfHeight).

]

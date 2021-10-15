"
I am a 3D ellipsoid.
"
Class {
	#name : #Ellipsoid,
	#superclass : #Object,
	#instVars : [
		'center',
		'radiuses'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #construction }
Ellipsoid class >> center: center radiuses: radiuses [
	^ self basicNew center: center; radiuses: radiuses; yourself
]

{ #category : #construction }
Ellipsoid class >> radiuses: radiuses [
	^ self center: Vector3 zeros radiuses: radiuses
]

{ #category : #accessing }
Ellipsoid >> center [

	^ center
]

{ #category : #accessing }
Ellipsoid >> center: anObject [

	center := anObject
]

{ #category : #'as yet unclassified' }
Ellipsoid >> computeNormalForPoint: point [
	| delta |
	delta := point - center.
	^ (delta / (radiuses * radiuses)) normalized
]

{ #category : #initialization }
Ellipsoid >> initialize [
	center := Vector3 zeros.
	radiuses := Vector3 zeros.
]

{ #category : #'ray casting' }
Ellipsoid >> intersectionWithRay: ray [
	| rxry2 rxrz2 ryrz2 rxryrz2 o o2 d d2 a b c delta deltaSqrt t1 t2 isT1Valid isT2Valid |

	rxry2 := radiuses x * radiuses y.
	rxry2 := rxry2 * rxry2.

	rxrz2 := radiuses x * radiuses z.
	rxrz2 := rxrz2 * rxrz2.

	ryrz2 := radiuses y * radiuses z.
	ryrz2 := ryrz2 * ryrz2.

	rxryrz2 := radiuses x * radiuses y * radiuses z.
	rxryrz2 := rxryrz2 * rxryrz2.
	
	o := ray origin.
	o2 := o*o.
	d := ray direction.
	d2 := d*d.
	
	"Quadratic formula terms"
	a := (d2 x * ryrz2) + (d2 y * rxrz2) + (d2 z * rxry2) .
	b := 2 * ((o x * d x * ryrz2) + (o y * d y * rxrz2) + (o z * d z * rxry2) ).
	c := (o2 x * ryrz2) + (o2 y * rxrz2) + (o2 z * rxry2) - rxryrz2.
	
	delta := b*b - (4*a*c).
	delta < 0 ifTrue: [ ^ nil ].

	deltaSqrt := delta sqrt.
	t1 := (b negated - deltaSqrt) / (2*a).	
	t2 := (b negated + deltaSqrt) / (2*a).
	
	isT1Valid := t1 between: ray tmin and: ray tmax.
	isT2Valid := t2 between: ray tmin and: ray tmax.
	
	(isT1Valid and: [isT2Valid]) ifTrue: [ ^ t1 min: t2 ].
	isT1Valid ifTrue: [ ^ t1 ].
	isT2Valid ifTrue: [ ^ t2 ].
	^ nil
]

{ #category : #accessing }
Ellipsoid >> radiuses [

	^ radiuses
]

{ #category : #accessing }
Ellipsoid >> radiuses: anObject [

	radiuses := anObject
]

{ #category : #'as yet unclassified' }
Ellipsoid >> supportFunction [
	^ [ :direction | self supportInDirection: direction ]
]

{ #category : #'as yet unclassified' }
Ellipsoid >> supportInDirection: aDirection [
	^ center + (aDirection normalized * radiuses)
]

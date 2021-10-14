"
I am a 3D sphere that is defined by a center and a radius.
"
Class {
	#name : #Sphere,
	#superclass : #Object,
	#instVars : [
		'center',
		'radius'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #'instance creation' }
Sphere class >> center: center radius: radius [
	^ self basicNew center: center; radius: radius; yourself
]

{ #category : #accessing }
Sphere >> center [

	^ center
]

{ #category : #accessing }
Sphere >> center: anObject [

	center := anObject
]

{ #category : #'as yet unclassified' }
Sphere >> computeNormalForPoint: point [
	^ (point - center) normalized
]

{ #category : #'as yet unclassified' }
Sphere >> distanceWithSphere: otherSphere [
	^ ((center - otherSphere center) length - (radius + otherSphere radius)) abs
]

{ #category : #initialization }
Sphere >> initialize [
	center := Vector3 zeros.
	radius := 0.
]

{ #category : #'ray casting' }
Sphere >> intersectionWithRay: ray [
	"Ray sphere intersection formula from: https://viclw17.github.io/2018/07/16/raytracing-ray-sphere-intersection/"
	| a b c delta deltaSqrt t1 t2 isT1Valid isT2Valid |
	a := ray direction dot: ray direction.
	b := 2.0 * (ray direction dot: ray origin - center).
	c := (ray origin - center) length2 - (radius*radius).
	
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
Sphere >> radius [

	^ radius
]

{ #category : #accessing }
Sphere >> radius: anObject [

	radius := anObject
]

{ #category : #'as yet unclassified' }
Sphere >> supportFunction [
	^ [ :direction | self supportInDirection: direction ]
]

{ #category : #'as yet unclassified' }
Sphere >> supportInDirection: aDirection [
	^ center + (aDirection normalized * radius)
]

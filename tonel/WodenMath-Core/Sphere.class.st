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
Sphere >> distanceWithSphere: otherSphere [
	^ ((center - otherSphere center) length - (radius + otherSphere radius)) abs
]

{ #category : #initialization }
Sphere >> initialize [
	center := Vector3 zeros.
	radius := 0.
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

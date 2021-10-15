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

{ #category : #initialization }
Ellipsoid >> initialize [
	center := Vector3 zeros.
	radiuses := Vector3 zeros.
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

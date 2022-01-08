"
I am a 3D ray.
"
Class {
	#name : #Ray3D,
	#superclass : #Object,
	#instVars : [
		'origin',
		'direction',
		'inverseDirection',
		'tmin',
		'tmax'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #'instance creation' }
Ray3D class >> from: startPoint to: endPoint [
	| vector vectorLength direction |
	vector := endPoint - startPoint.
	vectorLength := vector length.
	direction := vector / (vectorLength ~= 0 ifTrue: [vectorLength] ifFalse: [1]).
	^ self origin: startPoint direction: direction tmin: 0 tmax: vectorLength.
]

{ #category : #'instance creation' }
Ray3D class >> origin: origin direction: direction tmin: tmin tmax: tmax [
	^ self basicNew
		origin: origin;
		direction: direction;
		inverseDirection: direction safeReciprocal;
		tmin: tmin;
		tmax: tmax;
		yourself
]

{ #category : #accessing }
Ray3D >> direction [

	^ direction
]

{ #category : #accessing }
Ray3D >> direction: anObject [

	direction := anObject
]

{ #category : #accessing }
Ray3D >> inverseDirection [

	^ inverseDirection
]

{ #category : #accessing }
Ray3D >> inverseDirection: anObject [

	inverseDirection := anObject
]

{ #category : #accessing }
Ray3D >> origin [

	^ origin
]

{ #category : #accessing }
Ray3D >> origin: anObject [

	origin := anObject
]

{ #category : #geometry }
Ray3D >> pointAtDistance: alpha [
	^ origin + (direction * alpha)
]

{ #category : #accessing }
Ray3D >> tmax [

	^ tmax
]

{ #category : #accessing }
Ray3D >> tmax: anObject [

	tmax := anObject
]

{ #category : #accessing }
Ray3D >> tmin [

	^ tmin
]

{ #category : #accessing }
Ray3D >> tmin: anObject [

	tmin := anObject
]

{ #category : #transforming }
Ray3D >> transformedWith: aTransform [
	self flag: 'Fixme: handle the non-orthonomal transform case'.
	^ self class
		origin: (aTransform transformPosition: origin)
		direction: (aTransform transformVector3: direction) tmin: tmin tmax: tmax
]

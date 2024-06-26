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

{ #category : #'as yet unclassified' }
Ray3D >> distanceForPoint: point [
	^ (point - origin dot: direction) / direction length2
]

{ #category : #accessing }
Ray3D >> inverseDirection [

	^ inverseDirection
]

{ #category : #accessing }
Ray3D >> inverseDirection: anObject [

	inverseDirection := anObject
]

{ #category : #transforming }
Ray3D >> inverseTransformedWith: aTransform [
	| newOrigin newDirection newTMin newTMax |
	newOrigin := aTransform inverseTransformPosition: origin.
	newDirection := aTransform inverseTransformVector3: direction.
	newTMin := tmin.
	newTMax := tmax.
	(tmin ~= 0 and: [ tmin isInfinite not]) ifTrue: [
		newTMin := ((aTransform inverseTransformPosition: (self pointAtDistance: tmin)) - newOrigin dot: newDirection) / newDirection length2
	].

	(tmax ~= 0 and: [ tmax isInfinite not]) ifTrue: [ 
		newTMax := ((aTransform inverseTransformPosition: (self pointAtDistance: tmax)) - newOrigin dot: newDirection) / newDirection length2
	].
	
	^ self class
		origin: newOrigin
		direction: newDirection tmin: newTMin tmax: newTMax
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

{ #category : #printing }
Ray3D >> printOn: aStream [
	aStream nextPutAll: self class name;
		nextPutAll: ' origin: '; print: origin;
		nextPutAll: ' direction: '; print: direction;
		nextPutAll: ' tmin: '; print: tmin;
		nextPutAll: ' tmax: '; print: tmax
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
	| newOrigin newDirection newTMin newTMax |
	newOrigin := aTransform transformPosition: origin.
	newDirection := aTransform transformVector3: direction.
	
	newTMin := tmin.
	newTMax := tmax.
	(tmin ~= 0 and: [ tmin isInfinite not]) ifTrue: [
		newTMin := ((aTransform transformPosition: (self pointAtDistance: tmin)) - newOrigin dot: newDirection) / newDirection length2
	].

	(tmax ~= 0 and: [ tmax isInfinite not]) ifTrue: [ 
		newTMax := ((aTransform transformPosition: (self pointAtDistance: tmax)) - newOrigin dot: newDirection) / newDirection length2
	].

	^ self class
		origin: newOrigin
		direction: newDirection tmin: newTMin tmax: newTMax
]

{ #category : #transforming }
Ray3D >> withMaxDistance: maxDistance [
	^ self copy tmax: maxDistance / direction length; yourself
]

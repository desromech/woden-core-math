"
I am an axis aligned bounding box.
"
Class {
	#name : #AABox,
	#superclass : #Object,
	#instVars : [
		'min',
		'max'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #requirements }
AABox class >> empty [
	^ self min: Vector3 infinity max: Vector3 negativeInfinity
]

{ #category : #accessing }
AABox class >> min: min max: max [
	^ self basicNew min: min; max: max; yourself
]

{ #category : #accessing }
AABox class >> point: aPoint [
	^ self min: aPoint max: aPoint
]

{ #category : #comparing }
AABox >> = other [
	^ self class == other class and: [ min = other min and: [ max = other max ] ]
]

{ #category : #comparing }
AABox >> hash [
	^ min hash hashMultiply + max hash
]

{ #category : #initialization }
AABox >> initialize [
	min := max := Vector3 zeros
]

{ #category : #modifying }
AABox >> insertBox: aBox [
	min := min min: aBox min.
	max := max max: aBox max.
]

{ #category : #modifying }
AABox >> insertPoint: aPoint [
	min := min min: aPoint.
	max := max max: aPoint.
]

{ #category : #testing }
AABox >> isEmpty [
	^ min x > max x or: [ min y > max y or: [ min z > max z ] ]
]

{ #category : #testing }
AABox >> isPoint [
	^ min = max
]

{ #category : #accessing }
AABox >> max [

	^ max
]

{ #category : #accessing }
AABox >> max: anObject [

	max := anObject
]

{ #category : #accessing }
AABox >> min [

	^ min
]

{ #category : #accessing }
AABox >> min: anObject [

	min := anObject
]

{ #category : #printing }
AABox >> printOn: aStream [
	aStream nextPut: $(; nextPutAll: self class name;
		nextPutAll: ' min: '; print: min;
		nextPutAll: ' max: '; print: max; nextPut: $)
]

{ #category : #'as yet unclassified' }
AABox >> unionWithPoint: aPoint [
	^ self shallowCopy insertPoint: aPoint; yourself
]

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

{ #category : #accessing }
AABox class >> center: center halfExtent: halfExtent [
	^ self min: center - halfExtent max: center + halfExtent
]

{ #category : #requirements }
AABox class >> empty [
	^ self min: Vector3 infinity max: Vector3 negativeInfinity
]

{ #category : #accessing }
AABox class >> halfExtent: halfExtent [
	^ self min: halfExtent negated max: halfExtent
]

{ #category : #accessing }
AABox class >> min: min max: max [
	^ self basicNew min: min; max: max; yourself
]

{ #category : #accessing }
AABox class >> point: aPoint [
	^ self min: aPoint max: aPoint
]

{ #category : #accessing }
AABox class >> unit [
	^ self halfExtent: (Vector3 withAll: 1/2)
]

{ #category : #comparing }
AABox >> = other [
	^ self class == other class and: [ min = other min and: [ max = other max ] ]
]

{ #category : #accessing }
AABox >> center [
	^ min + self halfExtent
]

{ #category : #geometry }
AABox >> computeNormalForPoint: point [
	^ (self computePenetrationNormalAndDistanceForPoint: point) first
]

{ #category : #geometry }
AABox >> computePenetrationNormalAndDistanceForPoint: point [
	| delta deltaAbsolute normal penetrationDistance |
	delta := point - self center.
	deltaAbsolute := delta abs / self halfExtent.
	normal := deltaAbsolute x >= deltaAbsolute y ifTrue: [
			deltaAbsolute x >= deltaAbsolute z ifTrue: [
				Vector3 x: delta x sign
			] ifFalse: [ 
				Vector3 z: delta z sign
			]
		] ifFalse: [
			deltaAbsolute y >= deltaAbsolute z ifTrue: [
				Vector3 y: delta y sign
			] ifFalse: [
				Vector3 z: delta z sign
			].
		].
	penetrationDistance := (delta - (self halfExtent*normal) dot: normal) abs.
	^ {normal . penetrationDistance}
]

{ #category : #accessing }
AABox >> halfExtent [
	^ (max - min) / 2
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

{ #category : #'ray casting' }
AABox >> intersectionWithRay: ray [
	"Slab testing algorithm from: A Ray-Box Intersection Algorithm andEfficient Dynamic Voxel Rendering. By Majercik et al"
	| t0 t1 tmin tmax maxTMin minTMax hasIntersection |
	t0 := (min - ray origin)*ray inverseDirection.
	t1 := (max - ray origin)*ray inverseDirection.
	tmin := t0 min: t1.
	tmax := t0 max: t1.
	maxTMin := ((tmin x max: tmin y) max: tmin z) max: ray tmin.
	minTMax := ((tmax x min: tmax y) min: tmax z) min: ray tmax.

	hasIntersection := maxTMin <= minTMax.
 	hasIntersection ifFalse: [ ^ nil ].

	^ maxTMin min: minTMax
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

{ #category : #support }
AABox >> negativeVertex: direction [
	| vertex |
	vertex := max copy.
	direction x >= 0 ifTrue: [ vertex x: min x ].
	direction y >= 0 ifTrue: [ vertex y: min y ].
	direction z >= 0 ifTrue: [ vertex z: min z ].
	^ vertex
]

{ #category : #support }
AABox >> positiveVertex: direction [
	| vertex |
	vertex := min copy.
	direction x >= 0 ifTrue: [ vertex x: max x ].
	direction y >= 0 ifTrue: [ vertex y: max y ].
	direction z >= 0 ifTrue: [ vertex z: max z ].
	^ vertex
]

{ #category : #printing }
AABox >> printOn: aStream [
	aStream nextPut: $(; nextPutAll: self class name;
		nextPutAll: ' min: '; print: min;
		nextPutAll: ' max: '; print: max; nextPut: $)
]

{ #category : #support }
AABox >> supportFunction [
	^ [ :d | self supportInDirection: d ]
]

{ #category : #support }
AABox >> supportInDirection: direction [
	^ self positiveVertex: direction
]

{ #category : #'as yet unclassified' }
AABox >> trsTransformToConvertToMe: sourceBox [
	| scale |
	(self isEmpty or: [ sourceBox isEmpty ]) ifTrue: [ ^ TRSTransform3D identity ].
	scale := self halfExtent / sourceBox halfExtent.
	
	^ TRSTransform3D identity
		scale: scale;
		translation: self center - (scale * sourceBox center);
		yourself.
]

{ #category : #'as yet unclassified' }
AABox >> trsTransformToConvertUnitBoxToMe [
	^ self trsTransformToConvertToMe: self class unit
]

{ #category : #'set arithmetic' }
AABox >> unionWithPoint: aPoint [
	^ self shallowCopy insertPoint: aPoint; yourself
]

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
AABox >> bottomPoint [
	^ (self leftBottomPoint + self rightBottomPoint) / 2
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
AABox >> corners [
	^ {
		self nearBottomLeft.
		self nearBottomRight.
		self nearTopLeft.
		self nearTopRight.
		
		self farBottomLeft.
		self farBottomRight.
		self farTopLeft.
		self farTopRight.
	}
]

{ #category : #accessing }
AABox >> cornersDo: aBlock [
	aBlock value: self nearBottomLeft.
	aBlock value: self nearBottomRight.
	aBlock value: self nearTopLeft.
	aBlock value: self nearTopRight.
	
	aBlock value: self farBottomLeft.
	aBlock value: self farBottomRight.
	aBlock value: self farTopLeft.
	aBlock value: self farTopRight.
]

{ #category : #accessing }
AABox >> depth [
	^ max z - min z
]

{ #category : #accessing }
AABox >> farBottomLeft [
	^ Vector3 x: min x y: min y z: max z
]

{ #category : #accessing }
AABox >> farBottomPoint [
	^ (self farBottomLeft + self farBottomRight) / 2
]

{ #category : #accessing }
AABox >> farBottomRight [
	^ Vector3 x: max x y:min y z: max z
]

{ #category : #accessing }
AABox >> farLeftPoint [
	^ (self farBottomLeft + self farTopLeft) / 2
]

{ #category : #accessing }
AABox >> farPoint [
	^ (self farLeftPoint + self farRightPoint) / 2
]

{ #category : #accessing }
AABox >> farRightPoint [
	^ (self farBottomRight + self farTopRight) / 2
]

{ #category : #accessing }
AABox >> farTopLeft [
	^ Vector3 x: min x y: max y z: max z
]

{ #category : #accessing }
AABox >> farTopPoint [
	^ (self farTopLeft + self farTopRight) / 2
]

{ #category : #accessing }
AABox >> farTopRight [
	^ max
]

{ #category : #accessing }
AABox >> halfExtent [
	^ (max - min) / 2
]

{ #category : #comparing }
AABox >> hash [
	^ min hash hashMultiply + max hash
]

{ #category : #accessing }
AABox >> height [
	^ max y - min y
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
AABox >> leftBottomPoint [
	^ (self nearBottomLeft + self farBottomLeft) / 2
]

{ #category : #accessing }
AABox >> leftPoint [
	^ (self leftBottomPoint + self leftTopPoint) / 2
]

{ #category : #accessing }
AABox >> leftTopPoint [
	^ (self nearTopLeft + self farTopLeft) / 2
]

{ #category : #accessing }
AABox >> manipulationPoints [
	^ { 
		self nearBottomLeft .
		self nearBottomRight .
		self nearTopLeft .	
		self nearTopRight .

		self farBottomLeft .
		self farBottomRight .
		self farTopLeft .
		self farTopRight .

		self nearLeftPoint .
		self nearRightPoint .
		self nearTopPoint .
		self nearBottomPoint .

		self farLeftPoint .
		self farRightPoint .
		self farTopPoint .
		self farBottomPoint .

		self leftBottomPoint .
		self rightBottomPoint .
		self leftTopPoint .
		self rightTopPoint .

		self leftPoint .
		self rightPoint .
		self bottomPoint .
		self topPoint .
		self nearPoint .
		self farPoint .
	}
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

{ #category : #accessing }
AABox >> nearBottomLeft [
	^ min
]

{ #category : #accessing }
AABox >> nearBottomPoint [
	^ (self nearBottomLeft + self nearBottomRight) / 2
]

{ #category : #accessing }
AABox >> nearBottomRight [
	^ Vector3 x: max x y: min y z: min z
]

{ #category : #accessing }
AABox >> nearLeftPoint [
	^ (self nearBottomLeft + self nearTopLeft) / 2
]

{ #category : #accessing }
AABox >> nearPoint [
	^ (self nearLeftPoint + self nearRightPoint) / 2
]

{ #category : #accessing }
AABox >> nearRightPoint [
	^ (self nearBottomRight + self nearTopRight) / 2
]

{ #category : #accessing }
AABox >> nearTopLeft [
	^ Vector3 x: min x y: max y z: min z
]

{ #category : #accessing }
AABox >> nearTopPoint [
	^ (self nearTopLeft + self nearTopRight) / 2
]

{ #category : #accessing }
AABox >> nearTopRight [
	^ Vector3 x: max x y: max y z: min z
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

{ #category : #accessing }
AABox >> rightBottomPoint [
	^ (self nearBottomRight + self farBottomRight) / 2
]

{ #category : #accessing }
AABox >> rightPoint [
	^ (self rightBottomPoint + self rightTopPoint) / 2
]

{ #category : #accessing }
AABox >> rightTopPoint [
	^ (self nearTopRight + self farTopRight) / 2
]

{ #category : #support }
AABox >> supportFunction [
	^ [ :d | self supportInDirection: d ]
]

{ #category : #support }
AABox >> supportInDirection: direction [
	^ self positiveVertex: direction
]

{ #category : #accessing }
AABox >> topPoint [
	^ (self leftTopPoint + self rightTopPoint) / 2
]

{ #category : #transforming }
AABox >> transformedWith: aTransform [
	| result |
	result := self class empty.
	self cornersDo: [ :corner |
		result insertPoint: (aTransform transformPosition: corner)
	].
	^ result
]

{ #category : #transforming }
AABox >> translatedBy: translation [
	^ self class min: min + translation max: max + translation
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

{ #category : #accessing }
AABox >> width [
	^ max x - min x
]

{ #category : #'as yet unclassified' }
AABox >> withExpandedHalfExtent: extraHalfExtent [
	^ self class center: self center halfExtent: self halfExtent + extraHalfExtent
]

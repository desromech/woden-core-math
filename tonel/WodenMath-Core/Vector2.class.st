"
I am a 2D vector.
"
Class {
	#name : #Vector2,
	#superclass : #AbstractPrimitiveVector,
	#instVars : [
		'x',
		'y'
	],
	#category : #'WodenMath-Core-LinearAlgebra'
}

{ #category : #serialization }
Vector2 class >> loadFromJson: jsonData [
	^ self x: jsonData first asNumber y: jsonData second asNumber
]

{ #category : #'instance creation' }
Vector2 class >> withAll: element [
	^ self x: element y: element
]

{ #category : #'accessing structure variables' }
Vector2 class >> x: x [
	^ self x: x y: 0
]

{ #category : #'accessing structure variables' }
Vector2 class >> x: x y: y [
	^ self basicNew x: x; y: y
]

{ #category : #'accessing structure variables' }
Vector2 class >> y: y [
	^ self x: 0 y: y
]

{ #category : #comparing }
Vector2 >> <=> other [
	| coercedOther |
	coercedOther := other asVector2.
	x ~= coercedOther x ifTrue: [ ^ x <=> coercedOther x ].
	^ y <=> coercedOther y
]

{ #category : #comparing }
Vector2 >> = other [
	other isNumber ifTrue: [ ^ x = other and: [ y = other ] ].
	^ self class == other class and: [x = other x and: [ y = other y ]]
]

{ #category : #converting }
Vector2 >> asVector2 [
	^ self
]

{ #category : #converting }
Vector2 >> asWMComplex [
	^ WMComplex xy: self
]

{ #category : #comparing }
Vector2 >> closeTo: other [
	^ self class == other class and: [(x closeTo: other x) and: [ y closeTo: other y ]]
]

{ #category : #comparing }
Vector2 >> closeTo: other precision: precision [
	^ self class == other class and: [
	(x closeTo: other x precision: precision) and: [
	y closeTo: other y precision: precision ]]
]

{ #category : #enumerating }
Vector2 >> collect: aBlock [
	^ self class basicNew
		x: (aBlock value: x);
		y: (aBlock value: y);
		yourself
]

{ #category : #comparing }
Vector2 >> cross: other [
	| coercedOther |
	coercedOther := other asVector2.
	^ (x * other y) - (y * other x)
]

{ #category : #enumerating }
Vector2 >> do: aBlock [
	aBlock value: x.
	aBlock value: y.
]

{ #category : #arithmetic }
Vector2 >> dot: other [
	| coercedOther |
	coercedOther := other asVector2.
	^ (x * coercedOther x) + (y * coercedOther y)
]

{ #category : #serialization }
Vector2 >> encodeForJSON [
	^ { x . y }
]

{ #category : #comparing }
Vector2 >> hash [
	^ x hash hashMultiply + y hash
]

{ #category : #initialization }
Vector2 >> initialize [
	x := 0.
	y := 0.
]

{ #category : #testing }
Vector2 >> isOnes [
	^ x = 1 and: [ y = 1 ]
]

{ #category : #testing }
Vector2 >> isZeros [
	^ x = 0 and: [ y = 0 ]
]

{ #category : #arithmetic }
Vector2 >> max [
	^ x max: y
]

{ #category : #printing }
Vector2 >> printOn: aStream [
	aStream nextPut: $(; nextPutAll: self class name;
		nextPutAll:  ' x: '; print: x;
		nextPutAll:  ' y: '; print: y;
		nextPut: $)
]

{ #category : #noise }
Vector2 >> randomGradientVector [
	| gx gy |
	gx := self signedRandomNoise.
	gy := self signedRandomNoiseSecondComponent.
	^ self class x: gx y: gy
]

{ #category : #noise }
Vector2 >> randomNoise [
	| fx fy |
	fx := x floor.
	fy := y floor.
	
	^ ((fx randomNoiseHash * 27901) + (fy randomNoiseHash * 8537)) randomNoiseHashNormalized
]

{ #category : #noise }
Vector2 >> randomNoiseFourthComponent [
	| fx fy |
	fx := x floor.
	fy := y floor.
	
	^ ((fx randomNoiseHash * 13339) + (fy randomNoiseHash * 61099)) randomNoiseHashNormalized
]

{ #category : #noise }
Vector2 >> randomNoiseSecondComponent [
	| fx fy |
	fx := x floor.
	fy := y floor.
	
	^ ((fx randomNoiseHash * 6581) + (fy randomNoiseHash * 21881)) randomNoiseHashNormalized
]

{ #category : #noise }
Vector2 >> randomNoiseThirdComponent [
	| fx fy |
	fx := x floor.
	fy := y floor.
	
	^ ((fx randomNoiseHash * 45587) + (fy randomNoiseHash * 13049)) randomNoiseHashNormalized
]

{ #category : #noise }
Vector2 >> signedGradientNoise [
	| minX minY maxX maxY fx fy ix iy l t |
	minX := x floor.
	minY := y floor.
	maxX := minX + 1.0.
	maxY := minY + 1.0.	
	fx := x - minX.
	fy := y - minY.
	ix := fx cubicHemiteCurve.
	iy := fy cubicHemiteCurve.

	l := ((self class x: minX y: minY) randomGradientVector dot: (self class x: fx y: fy))
		interpolateTo: ((self class x: maxX y: minY) randomGradientVector dot: (self class x: (fx - 1.0) y: fy))
		at: ix.
	t := ((self class x: minX y: maxY) randomGradientVector dot: (self class x: fx y: (fy - 1.0)))
		interpolateTo: ((self class x: maxX y: maxY) randomGradientVector dot: (self class x: (fx - 1.0) y: (fy - 1.0)))
		at: ix.
	^ l interpolateTo: t at: iy
]

{ #category : #noise }
Vector2 >> signedGradientNoiseTiledWith: tilingPeriod [
	| minX minY maxX maxY fx fy ix iy l t |
	minX := x floor floorModule: tilingPeriod x.
	minY := y floor floorModule: tilingPeriod y.
	maxX := minX + 1.0 floorModule: tilingPeriod x.
	maxY := minY + 1.0 floorModule: tilingPeriod y.
	fx := x - x floor.
	fy := y - y floor.
	ix := fx cubicHemiteCurve.
	iy := fy cubicHemiteCurve.

	l := ((self class x: minX y: minY) randomGradientVector dot: (self class x: fx y: fy))
		interpolateTo: ((self class x: maxX y: minY) randomGradientVector dot: (self class x: (fx - 1.0) y: fy))
		at: ix.
	t := ((self class x: minX y: maxY) randomGradientVector dot: (self class x: fx y: (fy - 1.0)))
		interpolateTo: ((self class x: maxX y: maxY) randomGradientVector dot: (self class x: (fx - 1.0) y: (fy - 1.0)))
		at: ix.
	^ l interpolateTo: t at: iy
]

{ #category : #noise }
Vector2 >> valueNoise [
	| minX minY maxX maxY fx fy l t |
	minX := x floor.
	minY := y floor.
	maxX := minX + 1.0.
	maxY := minY + 1.0.
	fx := (x - minX) cubicHemiteCurve.
	fy := (y - minY) cubicHemiteCurve.

	l := (self class x: minX y: minY) randomNoise interpolateTo: (self class x: maxX y: minY) randomNoise at: fx.
	t := (self class x: minX y: maxY) randomNoise interpolateTo: (self class x: maxX y: maxY) randomNoise at: fx.
	^ l interpolateTo: t at: fy
]

{ #category : #noise }
Vector2 >> valueNoiseTiledWith: tilingPeriod [
	| minX minY maxX maxY fx fy l t |
	minX := x floor floorModule: tilingPeriod x.
	minY := y floor floorModule: tilingPeriod y.
	maxX := minX + 1.0 floorModule: tilingPeriod x.
	maxY := minY + 1.0 floorModule: tilingPeriod y.
	fx := (x - x floor) cubicHemiteCurve.
	fy := (y - y floor) cubicHemiteCurve.

	l := (self class x: minX y: minY) randomNoise interpolateTo: (self class x: maxX y: minY) randomNoise at: fx.
	t := (self class x: minX y: maxY) randomNoise interpolateTo: (self class x: maxX y: maxY) randomNoise at: fx.
	^ l interpolateTo: t at: fy
]

{ #category : #noise }
Vector2 >> voronoiNoiseComponents [
	| startCellX startCellY fx fy cellX cellY point dx dy f1 f2 value |
	startCellX := x floor.
	startCellY := y floor.
	fx := x - startCellX.
	fy := y - startCellY.
	
	f1 := Float infinity.
	f2 := Float infinity.
	-1 to: 1 do: [ :cdy |
		-1 to: 1 do: [ :cdx |
			cellX := startCellX + cdx.
			cellY := startCellY + cdy.
			point := (self class x: cellX y: cellY) randomNoiseVector2.

			dx := fx - (point x + cdx).
			dy := fy - (point y + cdy).
			value := (dx*dx) + (dy*dy).
			value < f1 ifTrue: [
				f2 := f1.
				f1 := value
			] ifFalse: [
				value < f2 ifTrue: [ 
					f2 := value
				]
			]
		]
	].

	^ {f1 sqrt min: 1.0. f2 sqrt min: 1.0}
]

{ #category : #noise }
Vector2 >> voronoiNoiseComponentsTiledWith: tilingPeriod [
	| startCellX startCellY fx fy cellX cellY point dx dy f1 f2 value |
	startCellX := x floor.
	startCellY := y floor.
	fx := x - startCellX.
	fy := y - startCellY.
	
	f1 := Float infinity.
	f2 := Float infinity.
	-1 to: 1 do: [ :cdy |
		-1 to: 1 do: [ :cdx |
			cellX := startCellX + cdx floorModule: tilingPeriod x.
			cellY := startCellY + cdy floorModule: tilingPeriod y.
			point := (self class x: cellX y: cellY) randomNoiseVector2.

			dx := fx - (point x + cdx).
			dy := fy - (point y + cdy).
			value := (dx*dx) + (dy*dy).
			value < f1 ifTrue: [
				f2 := f1.
				f1 := value
			] ifFalse: [
				value < f2 ifTrue: [ 
					f2 := value
				]
			]
		]
	].

	^ {f1 sqrt min: 1.0 . f2 sqrt min: 1.0}
]

{ #category : #enumerating }
Vector2 >> with: other collect: aBlock [
	| coercedOther |
	coercedOther := other asVector2.
	^ self class basicNew
		x: (aBlock value: x value: coercedOther x);
		y: (aBlock value: y value: coercedOther y);
		yourself
]

{ #category : #accessing }
Vector2 >> x [

	^ x
]

{ #category : #accessing }
Vector2 >> x: anObject [

	x := anObject
]

{ #category : #accessing }
Vector2 >> y [

	^ y
]

{ #category : #accessing }
Vector2 >> y: anObject [

	y := anObject
]

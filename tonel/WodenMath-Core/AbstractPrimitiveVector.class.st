"
I am an abstract primitive vector. I provide common methods for vectors up to 4 dimensions.
"
Class {
	#name : #AbstractPrimitiveVector,
	#superclass : #AbstractPrimitiveTensor,
	#category : #'WodenMath-Core-LinearAlgebra'
}

{ #category : #testing }
AbstractPrimitiveVector class >> isAbstract [
	^ self == AbstractPrimitiveVector
]

{ #category : #arithmetic }
AbstractPrimitiveVector >> * other [
	other isMatrix ifTrue: [ ^ other postMultiplyVector: self ].
	^ self with: other collect: [ :a :b | a * b ]
]

{ #category : #arithmetic }
AbstractPrimitiveVector >> / other [
	^ self with: other collect: [ :a :b |
		a / b
	]

]

{ #category : #arithmetic }
AbstractPrimitiveVector >> dot: other [
	self subclassResponsibility
]

{ #category : #noise }
AbstractPrimitiveVector >> gradientNoise [
	^ self signedGradientNoise * 0.5 + 0.5
]

{ #category : #noise }
AbstractPrimitiveVector >> gradientNoiseTiledWith: tilingPeriod [
	^ (self signedGradientNoiseTiledWith: tilingPeriod) * 0.5 + 0.5
]

{ #category : #testing }
AbstractPrimitiveVector >> isVector [
	^ true
]

{ #category : #comparing }
AbstractPrimitiveVector >> length [
	^ self length2 sqrt
]

{ #category : #comparing }
AbstractPrimitiveVector >> length2 [
	^ self dot: self
]

{ #category : #accessing }
AbstractPrimitiveVector >> normalized [
	| l |
	l := self length.
	l <= 0 ifTrue: [ ^ self class zeros ].
	^ self collect: [ :each | each / l ]
]

{ #category : #noise }
AbstractPrimitiveVector >> randomGradientVector [
	self subclassResponsibility
]

{ #category : #noise }
AbstractPrimitiveVector >> randomNoise [
	self subclassResponsibility
]

{ #category : #noise }
AbstractPrimitiveVector >> randomNoiseSecondComponent [
	self subclassResponsibility
]

{ #category : #noise }
AbstractPrimitiveVector >> randomNoiseVector2 [
	^ Vector2 x: self randomNoise y: self randomNoiseSecondComponent
]

{ #category : #rounding }
AbstractPrimitiveVector >> roundFloorWithQuantum: quantum [
	^ self collect: [ :each | each roundFloorWithQuantum: quantum ]
]

{ #category : #rounding }
AbstractPrimitiveVector >> roundWithQuantum: quantum [
	^ self collect: [ :each | each roundWithQuantum: quantum ]
]

{ #category : #noise }
AbstractPrimitiveVector >> signedGradientNoise [
	self subclassResponsibility
]

{ #category : #noise }
AbstractPrimitiveVector >> signedGradientNoiseTiledWith: tilingPeriod [
	self subclassResponsibility
]

{ #category : #noise }
AbstractPrimitiveVector >> signedRandomNoise [
	^ self randomNoise * 2.0 - 1.0

]

{ #category : #noise }
AbstractPrimitiveVector >> signedRandomNoiseSecondComponent [
	^ self randomNoiseSecondComponent * 2.0 - 1.0

]

{ #category : #noise }
AbstractPrimitiveVector >> signedValueNoise [
	^ self valueNoise * 2.0 - 1.0
]

{ #category : #noise }
AbstractPrimitiveVector >> signedValueNoiseTiledWith: tilingPeriod [
	^ (self valueNoiseTiledWith: tilingPeriod) * 2.0 - 1.0
]

{ #category : #noise }
AbstractPrimitiveVector >> signedVoronoiNoise [
	^ self voronoiNoise*2.0 - 1.0
]

{ #category : #noise }
AbstractPrimitiveVector >> signedVoronoiNoiseF1 [
	^ self voronoiNoiseF1*2.0 - 1.0
]

{ #category : #noise }
AbstractPrimitiveVector >> signedVoronoiNoiseF1TiledWith: tilingPeriod [
	^ (self voronoiNoiseF1TiledWith: tilingPeriod)*2.0 - 1.0
]

{ #category : #noise }
AbstractPrimitiveVector >> signedVoronoiNoiseF2 [
	^ self voronoiNoiseF2*2.0 - 1.0
]

{ #category : #noise }
AbstractPrimitiveVector >> signedVoronoiNoiseF2TiledWith: tilingPeriod [
	^ (self voronoiNoiseF2TiledWith: tilingPeriod)*2.0 - 1.0
]

{ #category : #noise }
AbstractPrimitiveVector >> signedVoronoiNoiseTiledWith: tilingPeriod [
	^ (self voronoiNoiseTiledWith: tilingPeriod)*2.0 - 1.0
]

{ #category : #noise }
AbstractPrimitiveVector >> signedWorleyNoise [
	^ self worleyNoise*2.0 - 1.0
]

{ #category : #noise }
AbstractPrimitiveVector >> signedWorleyNoiseTiledWith: tilingPeriod [
	^ (self worleyNoiseTiledWith: tilingPeriod)*2.0 - 1.0
]

{ #category : #noise }
AbstractPrimitiveVector >> turbulence [
	^ self turbulenceScales: 4
]

{ #category : #noise }
AbstractPrimitiveVector >> turbulenceScales: scale [
	| result currentCoord amplitude amplitudeSum |
	result := 0.0.
	currentCoord := self.
	amplitude := 0.5.
	amplitudeSum := 0.0.
	
	1 to: scale do: [ :i |
		result := result + (currentCoord signedGradientNoise * amplitude).
		currentCoord := currentCoord * 2.0.
		amplitudeSum := amplitudeSum + amplitude.
		amplitude := amplitude * 0.5
	].

	^ result / amplitudeSum

]

{ #category : #noise }
AbstractPrimitiveVector >> turbulenceScales: scale tiledWith: tilingPeriod [
	| result currentCoord amplitude amplitudeSum currentTilingPeriod |
	result := 0.0.
	currentCoord := self.
	amplitude := 0.5.
	amplitudeSum := 0.0.
	currentTilingPeriod := tilingPeriod.
	
	1 to: scale do: [ :i |
		result := result + ((currentCoord signedGradientNoiseTiledWith: currentTilingPeriod) * amplitude).
		currentCoord := currentCoord * 2.0.
		currentTilingPeriod := currentTilingPeriod * 2.0.
		amplitudeSum := amplitudeSum + amplitude.
		amplitude := amplitude * 0.5
	].

	^ result / amplitudeSum

]

{ #category : #noise }
AbstractPrimitiveVector >> turbulenceTiledWith: tilingPeriod [
	^ self turbulenceScales: 4 tiledWith: tilingPeriod
]

{ #category : #noise }
AbstractPrimitiveVector >> valueNoise [
	self subclassResponsibility
]

{ #category : #noise }
AbstractPrimitiveVector >> valueNoiseTiledWith: tilingPeriod [
	self subclassResponsibility
]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiNoise [
	^ self voronoiNoiseComponents first
]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiNoiseComponents [
	self subclassResponsibility
]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiNoiseComponentsTiledWith: tilingPeriod [
	self subclassResponsibility
]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiNoiseF1 [
	^ self voronoiNoiseComponents first
]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiNoiseF1TiledWith: tilingPeriod [
	^ (self voronoiNoiseComponentsTiledWith: tilingPeriod) first
]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiNoiseF2 [
	^ self voronoiNoiseComponents second
]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiNoiseF2TiledWith: tilingPeriod [
	^ (self voronoiNoiseComponentsTiledWith: tilingPeriod) second
]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiNoiseTiledWith: tilingPeriod [
	^ (self voronoiNoiseComponentsTiledWith: tilingPeriod) first
]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiTurbulence [
	^ self voronoiTurbulenceScales: 4
]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiTurbulenceScales: scale [
	| result currentCoord amplitude amplitudeSum |
	result := 0.0.
	currentCoord := self.
	amplitude := 0.5.
	amplitudeSum := 0.0.
	
	1 to: scale do: [ :i |
		result := result + (currentCoord voronoiNoise * amplitude).
		currentCoord := currentCoord * 2.0.
		amplitudeSum := amplitudeSum + amplitude.
		amplitude := amplitude * 0.5
	].

	^ result / amplitudeSum

]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiTurbulenceScales: scale tiledWith: tilingPeriod [
	| result currentCoord amplitude amplitudeSum currentTilingPeriod |
	result := 0.0.
	currentCoord := self.
	amplitude := 0.5.
	amplitudeSum := 0.0.
	currentTilingPeriod := tilingPeriod.
	
	1 to: scale do: [ :i |
		result := result + ((currentCoord voronoiNoiseTiledWith: currentTilingPeriod) * amplitude).
		currentCoord := currentCoord * 2.0.
		currentTilingPeriod := currentTilingPeriod * 2.0.
		amplitudeSum := amplitudeSum + amplitude.
		amplitude := amplitude * 0.5
	].

	^ result / amplitudeSum

]

{ #category : #noise }
AbstractPrimitiveVector >> voronoiTurbulenceTiledWith: tilingPeriod [
	^ self voronoiTurbulenceScales: 4 tiledWith: tilingPeriod
]

{ #category : #noise }
AbstractPrimitiveVector >> worleyNoise [
	| components |
	components := self voronoiNoiseComponents.
	^ components second - components first
]

{ #category : #noise }
AbstractPrimitiveVector >> worleyNoiseTiledWith: tilingPeriod [
	| components |
	components := self voronoiNoiseComponentsTiledWith: tilingPeriod.
	^ components second - components first
]

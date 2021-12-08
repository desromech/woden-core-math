Extension { #name : #Number }

{ #category : #'*WodenMath-Core' }
Number >> <=> other [
	^ (self - other) sign
]

{ #category : #'*WodenMath-Core' }
Number >> asVector2 [
	^ Vector2 x: self y: self
]

{ #category : #'*WodenMath-Core' }
Number >> asVector3 [
	^ Vector3 x: self y: self z: self
]

{ #category : #'*WodenMath-Core' }
Number >> asVector4 [
	^ Vector4 x: self y: self z: self w: self
]

{ #category : #'*WodenMath-Core' }
Number >> cubicHemiteCurve [
	^ self * self * (3.0 - (2.0*self))
]

{ #category : #'*WodenMath-Core' }
Number >> decodeSRGBComponent [
	"
	From: https://en.wikipedia.org/wiki/SRGB
	"
	| a |
	a := 0.055.
	^ self <= 0.04045 ifTrue: [ self / 12.92 ] ifFalse: [ ((self + a) / (1.0 + a)) raisedTo: 2.4 ]
]

{ #category : #'*WodenMath-Core' }
Number >> encodeSRGBComponent [
	"
	From: https://en.wikipedia.org/wiki/SRGB
	"
	| a |
	a := 0.055.
	^ self <= 0.0031308 ifTrue: [ self * 12.92 ] ifFalse: [ ((1.0 + a) * (self raisedTo: 1.0 / 2.4)) - a ]
]

{ #category : #'*WodenMath-Core' }
Number >> floorFract [
	^ self - self floor
]

{ #category : #'*WodenMath-Core' }
Number >> floorModule: period [
	^ self - ((self / period) floor * period)
]

{ #category : #'*WodenMath-Core' }
Number >> gradientNoise [
	^ self signedGradientNoise * 0.5 + 0.5
]

{ #category : #'*WodenMath-Core' }
Number >> linearStepFrom: leftEdge to: rightEdge [
	self <= leftEdge ifTrue: [ ^ 0.0 ].
	self >= rightEdge ifTrue: [ ^ 1.0 ].
	
	^ ((self - leftEdge) / (rightEdge - leftEdge))
]

{ #category : #'*WodenMath-Core' }
Number >> randomNoise [
	^ self floor randomNoiseHashNormalized
	
]

{ #category : #'*WodenMath-Core' }
Number >> safeReciprocal [
	self isZero ifTrue: [ 
		^ self = 0 ifTrue: [ Float nan ]
			ifFalse: [ self positive
					ifTrue: [ Float infinity ]
					ifFalse: [ Float negativeInfinity ]]
	].

	^ self reciprocal
]

{ #category : #'*WodenMath-Core' }
Number >> signedGradientNoise [
	| l f |
	l := self floor.
	f := self - l.
	^ (l signedRandomNoise * f) smoothInterpolateTo: ((l+1.0) signedRandomNoise * (f-1.0)) at: f
]

{ #category : #'*WodenMath-Core' }
Number >> signedRandomNoise [
	^ self randomNoise * 2.0 - 1.0

]

{ #category : #'*WodenMath-Core' }
Number >> signedValueNoise [
	^ self valueNoise * 2.0 - 1.0
]

{ #category : #'*WodenMath-Core' }
Number >> smoothInterpolateTo: aNumber at: param [
	^ self interpolateTo: aNumber at: param cubicHemiteCurve
]

{ #category : #'*WodenMath-Core' }
Number >> smoothStepFrom: leftEdge to: rightEdge [
	self <= leftEdge ifTrue: [ ^ 0.0 ].
	self >= rightEdge ifTrue: [ ^ 1.0 ].
	
	^ ((self - leftEdge) / (rightEdge - leftEdge)) cubicHemiteCurve
]

{ #category : #'*WodenMath-Core' }
Number >> stepEdge: edge [
	^ self < edge ifTrue: [0.0] ifFalse: [ 1.0 ]
]

{ #category : #'*WodenMath-Core' }
Number >> turbulence [
	^ self turbulenceScales: 4
]

{ #category : #'*WodenMath-Core' }
Number >> turbulenceScales: scale [
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

{ #category : #'*WodenMath-Core' }
Number >> valueNoise [
	| lower |
	lower := self floor.
	^ lower randomNoise interpolateTo: (lower + 1.0) randomNoise at: (self - lower) cubicHemiteCurve
]

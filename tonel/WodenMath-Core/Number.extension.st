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
Number >> safeReciprocal [
	self isZero ifTrue: [ 
		^ self = 0 ifTrue: [ Float nan ]
			ifFalse: [ self positive
					ifTrue: [ Float infinity ]
					ifFalse: [ Float negativeInfinity ]]
	].

	^ self reciprocal
]

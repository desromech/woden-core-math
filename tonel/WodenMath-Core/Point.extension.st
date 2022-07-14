Extension { #name : #Point }

{ #category : #'*WodenMath-Core' }
Point >> asVector2 [
	^ Vector2 x: x y: y
]

{ #category : #'*WodenMath-Core' }
Point >> asWMComplex [
	^ WMComplex xy: self
]

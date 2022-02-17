Extension { #name : #Point }

{ #category : #'*WodenMath-Core' }
Point >> asComplex [
	^ Complex xy: self
]

{ #category : #'*WodenMath-Core' }
Point >> asVector2 [
	^ Vector2 x: x y: y
]

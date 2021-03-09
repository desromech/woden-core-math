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

Extension { #name : #Color }

{ #category : #'*WodenMath-Core' }
Color >> asVector3 [
	^ Vector3 x: self red decodeSRGBComponent y: self green decodeSRGBComponent z: self blue decodeSRGBComponent
]

{ #category : #'*WodenMath-Core' }
Color >> asVector4 [
	^ Vector4 x: self red decodeSRGBComponent y: self green decodeSRGBComponent z: self blue decodeSRGBComponent w: self alpha
]

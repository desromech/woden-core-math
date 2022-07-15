Extension { #name : #Color }

{ #category : #'*WodenMath-SqueakCompatibility' }
Color class >> fromHexString: aColorHex [
	"Returns a color instance from HEX (6 element elements)."

	"(Color fromHexString: 'FFFFFF')>>> (Color white) "

	| green red blue alpha hexString |
	hexString := aColorHex withoutPrefix: '#'.
	red := (Integer readFrom: (hexString first: 2) base: 16) / 255.
	green := (Integer readFrom: (hexString copyFrom: 3 to: 4) base: 16) / 255.
	blue := (Integer readFrom: (hexString copyFrom: 5 to: 6) base: 16) / 255.
	
	alpha := hexString size = 8 
		ifFalse: [ 1.0 ]
		ifTrue: [ (Integer readFrom: (hexString copyFrom: 7 to: 8) base: 16) / 255 ].
	
	^ self r: red g: green b: blue alpha: alpha
]

{ #category : #'*WodenMath-SqueakCompatibility' }
Color >> interpolateTo: anObject at: t [
	| start stop |
	anObject isColor ifFalse: [ ^ anObject interpolateTo: self at: 1 - t  ].
	start := self.
	stop := anObject.
	^ self class
		r: start red + ((stop red - start red) * t)
		g: start green + ((stop green - start green)  * t)
		b: start blue + ((stop blue - start blue) * t)
		alpha: start alpha + ((stop alpha - start alpha) * t)
]

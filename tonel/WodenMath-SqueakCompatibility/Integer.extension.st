Extension { #name : #Integer }

{ #category : #'*WodenMath-SqueakCompatibility' }
Integer >> & aNumber [
	^ self bitAnd: aNumber
]

{ #category : #'*WodenMath-SqueakCompatibility' }
Integer >> | anInteger [
	^self bitOr: anInteger
]

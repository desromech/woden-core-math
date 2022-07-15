Extension { #name : #Integer }

{ #category : #'*WodenMath-SqueakCompatiblity' }
Integer >> & aNumber [
	^ self bitAnd: aNumber
]

{ #category : #'*WodenMath-SqueakCompatiblity' }
Integer >> | anInteger [
	^self bitOr: anInteger
]

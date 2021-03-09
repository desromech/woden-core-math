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

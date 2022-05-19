"
I am an abstract primitive tensor. I provide common methods for small primitive vectors and matrices that are typically used in 3D graphics.
"
Class {
	#name : #AbstractPrimitiveTensor,
	#superclass : #Object,
	#category : #'WodenMath-Core-LinearAlgebra'
}

{ #category : #constants }
AbstractPrimitiveTensor class >> infinity [
	^ self withAll: Float infinity
]

{ #category : #testing }
AbstractPrimitiveTensor class >> isAbstract [
	^ self == AbstractPrimitiveTensor
]

{ #category : #constants }
AbstractPrimitiveTensor class >> negativeInfinity [
	^ self withAll: Float negativeInfinity
]

{ #category : #'accessing structure variables' }
AbstractPrimitiveTensor class >> ones [
	^ self withAll: 1
]

{ #category : #'instance creation' }
AbstractPrimitiveTensor class >> withAll: element [
	self subclassResponsibility
]

{ #category : #'accessing structure variables' }
AbstractPrimitiveTensor class >> zeros [
	^ self withAll: 0
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> + other [
	^ self with: other collect: [ :a :b | a + b ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> - other [
	^ self with: other collect: [ :a :b | a - b ]
]

{ #category : #comparing }
AbstractPrimitiveTensor >> < other [
	^ (self <=> other) < 0
]

{ #category : #comparing }
AbstractPrimitiveTensor >> <= other [
	^ (self <=> other) <= 0
]

{ #category : #comparing }
AbstractPrimitiveTensor >> <=> other [
	self subclassResponsibility
]

{ #category : #comparing }
AbstractPrimitiveTensor >> > other [
	^ (self <=> other) > 0
]

{ #category : #comparing }
AbstractPrimitiveTensor >> >= other [
	^ (self <=> other) >= 0
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> abs [
	^ self collect: [ :each | each abs ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> adaptToNumber: receiver andSend: selector [
	^ (self class withAll: receiver) perform: selector with: self
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> asFloat [
	^ self collect: [ :each | each asFloat ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> ceiling [
	^ self collect: [ :each | each ceiling ]
]

{ #category : #enumerating }
AbstractPrimitiveTensor >> collect: aBlock [
	self subclassResponsibility
]

{ #category : #enumerating }
AbstractPrimitiveTensor >> do: aBlock [
	self subclassResponsibility
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> floor [
	^ self collect: [ :each | each floor ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> infiniteNorm [
	^ self inject: 0 into: [ :sum :each | sum max: each abs ]
]

{ #category : #enumerating }
AbstractPrimitiveTensor >> inject: aValue into: aBlock [
	| nextValue |
	nextValue := aValue.
	self do: [ :each | nextValue := aBlock value: nextValue value: each ].
	^ nextValue
]

{ #category : #transforming }
AbstractPrimitiveTensor >> interpolateTo: other at: param [
    ^  self * (1 - param) + (other * param)
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> length [
	^ self length2 sqrt
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> length2 [
	^ self inject: 0 into: [ :sum :each | sum + (each *each) ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> max: other [
	^ self with: other collect: [ :a :b | a max: b ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> min: other [
	^ self with: other collect: [ :a :b | a min: b ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> negated [
	^ self collect: [ :each | each negated ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> nonZeroSign [
	^ self collect: [ :each | each < 0 ifTrue: [ -1 ] ifFalse: [ 1 ] ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> numberedNorm: number [
	^ (self inject: 0 into: [ :sum :each | sum + (each abs raisedTo: number) ]) raisedTo: 1/number
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> pseudoInverse [
	^ self pseudoReciprocal
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> pseudoReciprocal [
	^ self collect: [ :each | each pseudoReciprocal ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> reciprocal [
	^ self collect: [ :each | each reciprocal ]
]

{ #category : #rounding }
AbstractPrimitiveTensor >> roundFloorWithQuantum: quantum [
	^ self collect: [ :each | each roundFloorWithQuantum: quantum ]
]

{ #category : #rounding }
AbstractPrimitiveTensor >> roundTo: quantum [
	^ self collect: [ :each | each roundTo: quantum ]
]

{ #category : #rounding }
AbstractPrimitiveTensor >> roundWithQuantum: quantum [
	^ self collect: [ :each | each roundWithQuantum: quantum ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> safeReciprocal [
	^ self collect: [ :each | each safeReciprocal ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> sign [
	^ self collect: [ :each | each sign ]
]

{ #category : #arithmetic }
AbstractPrimitiveTensor >> sqrt [
	^ self collect: [ :each | each sqrt ]
]

{ #category : #enumerating }
AbstractPrimitiveTensor >> with: other collect: aBlock [
	self subclassResponsibility
]

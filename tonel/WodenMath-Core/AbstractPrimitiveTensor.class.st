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

{ #category : #arithmetic }
AbstractPrimitiveTensor >> floor [
	^ self collect: [ :each | each floor ]
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
AbstractPrimitiveTensor >> reciprocal [
	^ self collect: [ :each | each reciprocal ]
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

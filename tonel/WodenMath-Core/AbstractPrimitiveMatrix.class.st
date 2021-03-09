"
I am an abstract small primitive matrix. I provide common methods for matrices up to 4x4.
"
Class {
	#name : #AbstractPrimitiveMatrix,
	#superclass : #AbstractPrimitiveTensor,
	#category : #'WodenMath-Core-LinearAlgebra'
}

{ #category : #accessing }
AbstractPrimitiveMatrix class >> columns [
	self subclassResponsibility
]

{ #category : #accessing }
AbstractPrimitiveMatrix class >> identity [
	^ self basicNew setIdentity
]

{ #category : #testing }
AbstractPrimitiveMatrix class >> isAbstract [
	^ self == AbstractPrimitiveMatrix
]

{ #category : #accessing }
AbstractPrimitiveMatrix class >> rows [
	self subclassResponsibility
]

{ #category : #arithmetic }
AbstractPrimitiveMatrix >> * other [
	other isNumber ifTrue: [
		^ self collect: [ :each | each * other ]
	].
	other isVector ifTrue: [
		^ self preMultiplyVector: other
	].

	self assert: other isMatrix.
	self class columns = other class rows ifFalse: [
		self error: 'Mismatching matrix rank for multiplication.'
	].
	^ self multiplyWithMatrix: other
]

{ #category : #testing }
AbstractPrimitiveMatrix >> isMatrix [
	^ true
]

{ #category : #arithmetic }
AbstractPrimitiveMatrix >> multiplyWithMatrix: vector [
	self subclassResponsibility
]

{ #category : #arithmetic }
AbstractPrimitiveMatrix >> postMultiplyVector: vector [
	self subclassResponsibility
]

{ #category : #arithmetic }
AbstractPrimitiveMatrix >> preMultiplyVector: vector [
	self subclassResponsibility
]

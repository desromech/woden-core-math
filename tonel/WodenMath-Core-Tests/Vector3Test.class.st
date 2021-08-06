"
A Vector3Test is a test class for testing the behavior of Vector3
"
Class {
	#name : #Vector3Test,
	#superclass : #WodenMathTestCase,
	#category : #'WodenMath-Core-Tests-LinearAlgebra'
}

{ #category : #tests }
Vector3Test >> testAddition [
	self assert: (Vector3 x: 0 y: 0 z: 0) + (Vector3 x: 0 y: 0 z: 0) equals: (Vector3 x: 0 y: 0 z: 0).
	self assert: (Vector3 x: 1 y: 2 z: 3) + (Vector3 x: 0 y: 0 z: 0) equals: (Vector3 x: 1 y: 2 z: 3).
	self assert: (Vector3 x: 1 y: 2 z: 3) + (Vector3 x: 4 y: 5 z: 6) equals: (Vector3 x: 5 y: 7 z: 9).
	self assert: (Vector3 x: 4 y: 5 z: 6) + (Vector3 x: 1 y: 2 z: 3) equals: (Vector3 x: 5 y: 7 z: 9).
]

{ #category : #tests }
Vector3Test >> testCloseTo [
	| a b c |
	a := Vector3 x: 1 y: 2 z: 4.
	b := Vector3 x: 3 y: 4 z: 5.
	c := Vector3 x: 3 y: 4 z: 5.

	self assert: b closeTo: c.
	self deny: (a closeTo: b).
	self assert: a notCloseTo:  b.

	self deny: (a closeTo: c).
	self assert: a notCloseTo: c.
]

{ #category : #tests }
Vector3Test >> testCross [
	self assert: ((Vector3 x: 2 y: 0 z: 0) cross: (Vector3 x: 2 y: 0 z: 0)) equals: Vector3 zeros.
	self assert: ((Vector3 x: 0 y: 2 z: 0) cross: (Vector3 x: 0 y: 2 z: 0)) equals: Vector3 zeros.
	self assert: ((Vector3 x: 0 y: 0 z: 2) cross: (Vector3 x: 0 y: 0 z: 2)) equals: Vector3 zeros.

	self assert: ((Vector3 x: 2 y: 0 z: 0) cross: (Vector3 x: 0 y: 3 z: 0)) equals: (Vector3 x: 0 y: 0 z: 6).
	self assert: ((Vector3 x: 0 y: 2 z: 0) cross: (Vector3 x: 0 y: 0 z: 3)) equals: (Vector3 x: 6 y: 0 z: 0).
	self assert: ((Vector3 x: 0 y: 0 z: 2) cross: (Vector3 x: 3 y: 0 z: 0)) equals: (Vector3 x: 0 y: 6 z: 0).
]

{ #category : #tests }
Vector3Test >> testDivision [
	self assert: (Vector3 x: 1 y: 2 z: 3) / (Vector3 x: 1 y: 1 z: 1) equals: (Vector3 x: 1 y: 2 z: 3).
	self assert: (Vector3 x: 20 y: 9 z: 50) / (Vector3 x: 5 y: 3 z: 10) equals: (Vector3 x: 4 y: 3 z: 5).
]

{ #category : #tests }
Vector3Test >> testDot [
	self assert: ((Vector3 x: 1 y: 2 z: 3) dot: (Vector3 x: 4 y: 7 z: 8)) equals: "4 + 14 + 24" 42.
]

{ #category : #tests }
Vector3Test >> testEquals [
	| a b c |
	a := Vector3 x: 1 y: 2 z: 4.
	b := Vector3 x: 3 y: 4 z: 5.
	c := Vector3 x: 3 y: 4 z: 5.

	self assert: b equals:  c.
	self deny: a = b.
	self deny: a = c.
]

{ #category : #tests }
Vector3Test >> testHash [
	| b c |
	b := Vector3 x: 3 y: 4 z: 5.
	c := Vector3 x: 3 y: 4 z: 5.
	self assert: b hash equals: c hash.
]

{ #category : #tests }
Vector3Test >> testLength [
	self assert: (Vector3 x: 1 y: 2 z: 2) length equals: 3.
]

{ #category : #tests }
Vector3Test >> testLength2 [
	self assert: (Vector3 x: 3 y: 4 z: 5) length2 equals: 50.
]

{ #category : #tests }
Vector3Test >> testMultiplication [
	self assert: (Vector3 x: 0 y: 0 z: 0) * (Vector3 x: 0 y: 0 z: 0) equals: (Vector3 x: 0 y: 0 z: 0).
	self assert: (Vector3 x: 1 y: 2 z: 3) * (Vector3 x: 0 y: 0 z: 0) equals: (Vector3 x: 0 y: 0 z: 0).
	self assert: (Vector3 x: 1 y: 2 z: 3) * (Vector3 x: 1 y: 1 z: 1) equals: (Vector3 x: 1 y: 2 z: 3).
	self assert: (Vector3 x: 2 y: 3 z: 4) * (Vector3 x: 3 y: 5 z: 7) equals: (Vector3 x: 6 y: 15 z: 28).
]

{ #category : #tests }
Vector3Test >> testNegated [
	self assert: (Vector3 x: 1 y: 2 z: 3) negated equals: (Vector3 x: -1 y: -2 z: -3).
]

{ #category : #tests }
Vector3Test >> testNotEquals [
	| a b c |
	a := Vector3 x: 1 y: 2 z: 4.
	b := Vector3 x: 3 y: 4 z: 5.
	c := Vector3 x: 3 y: 4 z: 5.

	self deny: (b ~=  c).
	self assert: a ~= b.
	self assert: a ~= c.
]

{ #category : #tests }
Vector3Test >> testOnes [
	self assert: Vector3 ones equals: (Vector3 x: 1 y: 1 z: 1).
	self deny: Vector3 zeros isOnes.
	self assert: Vector3 ones isOnes.
]

{ #category : #tests }
Vector3Test >> testReciprocal [
	self assert: (Vector3 x: 2 y: 3 z: 4) reciprocal  equals: (Vector3 x: 1/2 y: 1/3 z: 1/4).
	self should: [ (Vector3 x: 0 y: 1 z: 1) reciprocal ] raise: Error.
	self should: [ (Vector3 x: 1 y: 0 z: 1) reciprocal ] raise: Error.
	self should: [ (Vector3 x: 1 y: 1 z: 0) reciprocal ] raise: Error.
]

{ #category : #tests }
Vector3Test >> testSubtraction [
	self assert: (Vector3 x: 0 y: 0 z: 0) - (Vector3 x: 0 y: 0 z: 0) equals: (Vector3 x: 0 y: 0 z: 0).
	self assert: (Vector3 x: 1 y: 2 z: 3) - (Vector3 x: 0 y: 0 z: 0) equals: (Vector3 x: 1 y: 2 z: 3).
	self assert: (Vector3 x: 1 y: 2 z: 3) - (Vector3 x: 4 y: 6 z: 8) equals: (Vector3 x: -3 y: -4 z: -5).
]

{ #category : #tests }
Vector3Test >> testZeros [
	self assert: Vector3 zeros equals: (Vector3 x: 0 y: 0 z: 0).
	self assert: Vector3 zeros isZeros.
	self deny: Vector3 ones isZeros.
]

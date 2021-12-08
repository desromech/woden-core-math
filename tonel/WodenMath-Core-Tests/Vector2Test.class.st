"
A Vector2Test is a test class for testing the behavior of Vector2
"
Class {
	#name : #Vector2Test,
	#superclass : #WodenMathTestCase,
	#category : #'WodenMath-Core-Tests-LinearAlgebra'
}

{ #category : #tests }
Vector2Test >> testAbsolute [
	self assert: (Vector2 x: 0 y: 1) abs equals: (Vector2 x: 0 y: 1).
	self assert: (Vector2 x: 0 y: -1) abs equals: (Vector2 x: 0 y: 1).
	self assert: (Vector2 x: 1 y: 0) abs equals: (Vector2 x: 1 y: 0).
	self assert: (Vector2 x: -1 y: 0) abs equals: (Vector2 x: 1 y: 0).
	self assert: (Vector2 x: 2 y: 3) abs equals: (Vector2 x: 2 y: 3).
	self assert: (Vector2 x: -2 y: 3) abs equals: (Vector2 x: 2 y: 3).
	self assert: (Vector2 x: 2 y: -3) abs equals: (Vector2 x: 2 y: 3).
	self assert: (Vector2 x: -2 y: -3) abs equals: (Vector2 x: 2 y: 3).
]

{ #category : #tests }
Vector2Test >> testAddition [
	self assert: (Vector2 x: 0 y: 0) + (Vector2 x: 0 y: 0) equals: (Vector2 x: 0 y: 0).
	self assert: (Vector2 x: 1 y: 2) + (Vector2 x: 0 y: 0) equals: (Vector2 x: 1 y: 2).
	self assert: (Vector2 x: 1 y: 2) + (Vector2 x: 3 y: 4) equals: (Vector2 x: 4 y: 6).
	self assert: (Vector2 x: 3 y: 4) + (Vector2 x: 1 y: 2) equals: (Vector2 x: 4 y: 6).
]

{ #category : #tests }
Vector2Test >> testCloseTo [
	| a b c |
	a := Vector2 x: 1 y: 2.
	b := Vector2 x: 3 y: 4.
	c := Vector2 x: 3 y: 4.

	self assert: b closeTo:  c.
 	self deny: (a closeTo: b).
	self assert: a notCloseTo: b.

	self deny: (a closeTo: c).
	self assert: a notCloseTo: c.
]

{ #category : #tests }
Vector2Test >> testConstruction [
	| vector |
	vector := Vector2 x: 2 y: 3.
	self assert: vector x equals: 2.
	self assert: vector y equals: 3.
	self assert: vector equals: (Vector2 x: 2 y: 3).
]

{ #category : #tests }
Vector2Test >> testCross [
	self assert: ((Vector2 x: 1 y: 2) cross: (Vector2 x: 3 y: 7)) equals: "7 - 6" 1.
]

{ #category : #tests }
Vector2Test >> testDivision [
	self assert: (Vector2 x: 1 y: 2) / (Vector2 x: 1 y: 1) equals: (Vector2 x: 1 y: 2).
	self assert: (Vector2 x: 20 y: 9) / (Vector2 x: 5 y: 3) equals: (Vector2 x: 4 y: 3).
]

{ #category : #tests }
Vector2Test >> testDot [
	self assert: ((Vector2 x: 1 y: 2) dot: (Vector2 x: 4 y: 7)) equals: "4 + 14" 18.
]

{ #category : #tests }
Vector2Test >> testEquals [
	| a b c |
	a := Vector2 x: 1 y: 2.
	b := Vector2 x: 3 y: 4.
	c := Vector2 x: 3 y: 4.

	self assert: b equals: c.
	self deny: a = b.
	self deny: a = c.
]

{ #category : #tests }
Vector2Test >> testGreaterOrEqual [
	self assert: (Vector2 x: 0 y: 0) >= (Vector2 x: 0 y: 0).
	self deny: (Vector2 x: 0 y: 0) >= (Vector2 x: 1 y: 0).
	self assert: (Vector2 x: 1 y: 0) >= (Vector2 x: 0 y: 0).

	self deny: (Vector2 x: 0 y: 0) >= (Vector2 x: 0 y: 1).
	self assert: (Vector2 x: 0 y: 1) >= (Vector2 x: 0 y: 0).
	self assert: (Vector2 x: 0 y: 1) >= (Vector2 x: 0 y: 1).
]

{ #category : #tests }
Vector2Test >> testGreaterThan [
	self deny: (Vector2 x: 0 y: 0) > (Vector2 x: 0 y: 0).
	self deny: (Vector2 x: 0 y: 0) > (Vector2 x: 1 y: 0).
	self assert: (Vector2 x: 1 y: 0) > (Vector2 x: 0 y: 0).

	self deny: (Vector2 x: 0 y: 0) > (Vector2 x: 0 y: 1).
	self assert: (Vector2 x: 0 y: 1) > (Vector2 x: 0 y: 0).
	self deny: (Vector2 x: 0 y: 1) > (Vector2 x: 0 y: 1).
]

{ #category : #tests }
Vector2Test >> testHash [
	| b c |
	b := Vector2 x: 3 y: 4.
	c := Vector2 x: 3 y: 4.
	self assert: b hash equals: c hash.
]

{ #category : #tests }
Vector2Test >> testInfiniteNorm [
	self assert: (Vector3 x: 1 y: 0) infiniteNorm equals: 1.
	self assert: (Vector3 x: -1 y: 0) infiniteNorm equals: 1.
	self assert: (Vector3 x: 1 y: 3) infiniteNorm equals: 3.
	self assert: (Vector3 x: -2 y: 1) infiniteNorm equals: 2.
]

{ #category : #tests }
Vector2Test >> testLength [
	self assert: (Vector2 x: 3 y: 4) length equals: 5.
	self assert: ((Vector2 x: 3 y: 4) numberedNorm: 2) equals: 5.
]

{ #category : #tests }
Vector2Test >> testLength2 [
	self assert: (Vector2 x: 3 y: 4) length2 equals: 25.
]

{ #category : #tests }
Vector2Test >> testLessOrEqual [
	self assert: (Vector2 x: 0 y: 0) <= (Vector2 x: 0 y: 0).
	self assert: (Vector2 x: 0 y: 0) <= (Vector2 x: 1 y: 0).
	self deny: (Vector2 x: 1 y: 0) <= (Vector2 x: 0 y: 0).

	self assert: (Vector2 x: 0 y: 0) <= (Vector2 x: 0 y: 1).
	self deny: (Vector2 x: 0 y: 1) <= (Vector2 x: 0 y: 0).
	self assert: (Vector2 x: 0 y: 1) <= (Vector2 x: 0 y: 1).
]

{ #category : #tests }
Vector2Test >> testLessThan [
	self deny: (Vector2 x: 0 y: 0) < (Vector2 x: 0 y: 0).
	self assert: (Vector2 x: 0 y: 0) < (Vector2 x: 1 y: 0).
	self deny: (Vector2 x: 1 y: 0) < (Vector2 x: 0 y: 0).

	self assert: (Vector2 x: 0 y: 0) < (Vector2 x: 0 y: 1).
	self deny: (Vector2 x: 0 y: 1) < (Vector2 x: 0 y: 0).
	self deny: (Vector2 x: 0 y: 1) < (Vector2 x: 0 y: 1).
]

{ #category : #tests }
Vector2Test >> testMultiplication [
	self assert: (Vector2 x: 0 y: 0) * (Vector2 x: 0 y: 0) equals: (Vector2 x: 0 y: 0).
	self assert: (Vector2 x: 1 y: 2) * (Vector2 x: 0 y: 0) equals: (Vector2 x: 0 y: 0).
	self assert: (Vector2 x: 1 y: 2) * (Vector2 x: 1 y: 1) equals: (Vector2 x: 1 y: 2).
	self assert: (Vector2 x: 2 y: 3) * (Vector2 x: 3 y: 5) equals: (Vector2 x: 6 y: 15).
]

{ #category : #tests }
Vector2Test >> testNegated [
	self assert: (Vector2 x: 1 y: 2) negated equals: (Vector2 x: -1 y: -2).
]

{ #category : #tests }
Vector2Test >> testNotEquals [
	| a b c |
	a := Vector2 x: 1 y: 2.
	b := Vector2 x: 3 y: 4.
	c := Vector2 x: 3 y: 4.

	self deny: (b ~=  c).
	self assert: a ~= b.
	self assert: a ~= c.
]

{ #category : #tests }
Vector2Test >> testOnes [
	self assert: Vector2 ones equals: (Vector2 x: 1 y: 1).
	self deny: Vector2 zeros isOnes.
	self assert: Vector2 ones isOnes.
]

{ #category : #tests }
Vector2Test >> testReciprocal [
	self assert: (Vector2 x: 2 y: 3) reciprocal  equals: (Vector2 x: 1/2 y: 1/3).
	self should: [ (Vector2 x: 0 y: 1) reciprocal ] raise: Error.
	self should: [ (Vector2 x: 1 y: 0) reciprocal ] raise: Error.
]

{ #category : #tests }
Vector2Test >> testSubtraction [
	self assert: (Vector2 x: 0 y: 0) - (Vector2 x: 0 y: 0) equals: (Vector2 x: 0 y: 0).
	self assert: (Vector2 x: 1 y: 2) - (Vector2 x: 0 y: 0) equals: (Vector2 x: 1 y: 2).
	self assert: (Vector2 x: 1 y: 2) - (Vector2 x: 3 y: 5) equals: (Vector2 x: -2 y: -3).
]

{ #category : #tests }
Vector2Test >> testZeros [
	self assert: Vector2 zeros equals: (Vector2 x: 0 y: 0).
	self assert: Vector2 zeros isZeros.
	self deny: Vector2 ones isZeros.
]

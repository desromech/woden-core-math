"
A ComplexTest is a test class for testing the behavior of Complex
"
Class {
	#name : #ComplexTest,
	#superclass : #WodenMathTestCase,
	#category : #'WodenMath-Core-Tests-Complex'
}

{ #category : #tests }
ComplexTest >> testAbsolute [
	self assert: (Complex r: 0 i: 1) abs equals: 1.
	self assert: (Complex r: 0 i: -1) abs equals: 1.
	self assert: (Complex r: 1 i: 0) abs equals: 1.
	self assert: (Complex r: -1 i: 0) abs equals: 1.
	self assert: (Complex r: 3 i: 4) abs equals: 5.
	self assert: (Complex r: -3 i: 4) abs equals: 5.
	self assert: (Complex r: 3 i: -4) abs equals: 5.
	self assert: (Complex r: -3 i: -4) abs equals: 5.
]

{ #category : #tests }
ComplexTest >> testAddition [
	self assert: (Complex r: 0 i: 0) + (Complex r: 0 i: 0) equals: (Complex r: 0 i: 0).
	self assert: (Complex r: 0 i: 0) + 0 equals: (Complex r: 0 i: 0).
	self assert: (Complex r: 0 i: 0) + 2 equals: (Complex r: 2 i: 0).
	self assert: (Complex r: 1 i: 2) + (Complex r: 0 i: 0) equals: (Complex r: 1 i: 2).
	self assert: (Complex r: 1 i: 2) + (Complex r: 3 i: 4) equals: (Complex r: 4 i: 6).
	self assert: (Complex r: 3 i: 4) + (Complex r: 1 i: 2) equals: (Complex r: 4 i: 6).
]

{ #category : #tests }
ComplexTest >> testAngle [
	self assert: (Complex r: 1 i: 0) angle closeTo: 0.
	self assert: (Complex r: 0 i: 1) angle closeTo: Float halfPi.
	self assert: (((Complex r: -1 i: 0) angle closeTo: Float pi) or: [(Complex r: -1 i: 0) angle closeTo: Float pi negated]).
	self assert: (Complex r: 0 i: -1) angle closeTo: Float halfPi negated.
]

{ #category : #tests }
ComplexTest >> testArgument [
	self assert: (Complex r: 1 i: 0) arg closeTo: 0.
	self assert: (Complex r: 0 i: 1) arg closeTo: Float halfPi.
	self assert: (((Complex r: -1 i: 0) arg closeTo: Float pi) or: [(Complex r: -1 i: 0) arg closeTo: Float pi negated]).
	self assert: (Complex r: 0 i: -1) arg closeTo: Float halfPi negated.
]

{ #category : #tests }
ComplexTest >> testAsMatrix2x2 [
	self assert: Complex zero asMatrix2x2 equals: Matrix2x2 zeros.
	self assert: Complex identity asMatrix2x2 equals: Matrix2x2 identity.
	self assert: (Complex angle: Float halfPi) asMatrix2x2 closeTo: (Matrix2x2 rotation: Float halfPi).
	self assert: (Complex angle: Float halfPi negated) asMatrix2x2 closeTo: (Matrix2x2 rotation: Float halfPi negated).
	self assert: (Complex angle: Float pi) asMatrix2x2 closeTo: (Matrix2x2 rotation: Float pi).
]

{ #category : #tests }
ComplexTest >> testCloseTo [
	| a b c |
	a := Complex r: 1 i: 2.
	b := Complex r: 3 i: 4.
	c := Complex r: 3 i: 4.

	self assert: b closeTo:  c.
	self deny: (a closeTo: b).
	self assert: a notCloseTo:  b.

	self deny: (a closeTo: c).
	self deny: a closeTo: c.

]

{ #category : #tests }
ComplexTest >> testConjugated [
	self assert: (Complex r: 1 i: 2) conjugated equals: (Complex r: 1 i: -2).
]

{ #category : #tests }
ComplexTest >> testConstruction [
	| complex |
	complex := Complex x: 2 y: 3.
	self assert: complex x equals: 2.
	self assert: complex y equals: 3.
	self assert: complex equals: (Complex r: 2 i: 3).
]

{ #category : #tests }
ComplexTest >> testConstruction2 [
	| complex |
	complex := Complex r: 2 i: 3.
	self assert: complex x equals: 2.
	self assert: complex y equals: 3.
	self assert: complex equals: (Complex r: 2 i: 3).
]

{ #category : #tests }
ComplexTest >> testDivision [
	self assert: (Complex r: 1 i: 2) / (Complex r: 1 i: 0) equals: (Complex r: 1 i: 2).
	self assert: (Complex r: 20 i: 25) / (Complex r: 5 i: 0) equals: (Complex r: 4 i: 5).
	self assert: (Complex r: 4 i: 89) / (Complex r: 4 i: 89) closeTo: (Complex r: 1 i: 0).
]

{ #category : #tests }
ComplexTest >> testDot [
	self assert: ((Complex r: 1 i: 2) dot: (Complex r: 4 i: 7)) equals: "4 + 14" 18.
]

{ #category : #tests }
ComplexTest >> testEquals [
	| a b c |
	a := Complex r: 1 i: 2.
	b := Complex r: 3 i: 4.
	c := Complex r: 3 i: 4.

	self assert: b equals:  c.
	self deny: a = b.
	self deny: a = c.

]

{ #category : #tests }
ComplexTest >> testGreaterOrEqual [
	self assert: (Complex r: 0 i: 0) >= (Complex r: 0 i: 0).
	self deny: (Complex r: 0 i: 0) >= (Complex r: 1 i: 0).
	self assert: (Complex r: 1 i: 0) >= (Complex r: 0 i: 0).

	self deny: (Complex r: 0 i: 0) >= (Complex r: 0 i: 1).
	self assert: (Complex r: 0 i: 1) >= (Complex r: 0 i: 0).
	self assert: (Complex r: 0 i: 1) >= (Complex r: 0 i: 1).
]

{ #category : #tests }
ComplexTest >> testGreaterThan [
	self deny: (Complex r: 0 i: 0) > (Complex r: 0 i: 0).
	self deny: (Complex r: 0 i: 0) > (Complex r: 1 i: 0).
	self assert: (Complex r: 1 i: 0) > (Complex r: 0 i: 0).

	self deny: (Complex r: 0 i: 0) > (Complex r: 0 i: 1).
	self assert: (Complex r: 0 i: 1) > (Complex r: 0 i: 0).
	self deny: (Complex r: 0 i: 1) > (Complex r: 0 i: 1).
]

{ #category : #tests }
ComplexTest >> testHash [
	| b c |
	b := Complex r: 3 i: 4.
	c := Complex r: 3 i: 4.
	self assert: b hash equals: c hash.
]

{ #category : #tests }
ComplexTest >> testIdentity [
	self assert: Complex identity equals: (Complex r: 1 i: 0).
]

{ #category : #tests }
ComplexTest >> testInverse [
	self assert: (Complex r: 1 i: 0) inverse equals: (Complex r: 1 i: 0).
	self assert: Complex one inverse equals: Complex one.
]

{ #category : #tests }
ComplexTest >> testLength [
	self assert: (Complex r: 3 i: 4) length equals: 5.
]

{ #category : #tests }
ComplexTest >> testLength2 [
	self assert: (Complex r: 3 i: 4) length2 equals: 25.
]

{ #category : #tests }
ComplexTest >> testLessOrEqual [
	self assert: (Complex r: 0 i: 0) <= (Complex r: 0 i: 0).
	self assert: (Complex r: 0 i: 0) <= (Complex r: 1 i: 0).
	self deny: (Complex r: 1 i: 0) <= (Complex r: 0 i: 0).

	self assert: (Complex r: 0 i: 0) <= (Complex r: 0 i: 1).
	self deny: (Complex r: 0 i: 1) <= (Complex r: 0 i: 0).
	self assert: (Complex r: 0 i: 1) <= (Complex r: 0 i: 1).
]

{ #category : #tests }
ComplexTest >> testLessThan [
	self deny: (Complex r: 0 i: 0) < (Complex r: 0 i: 0).
	self assert: (Complex r: 0 i: 0) < (Complex r: 1 i: 0).
	self deny: (Complex r: 1 i: 0) < (Complex r: 0 i: 0).

	self assert: (Complex r: 0 i: 0) < (Complex r: 0 i: 1).
	self deny: (Complex r: 0 i: 1) < (Complex r: 0 i: 0).
	self deny: (Complex r: 0 i: 1) < (Complex r: 0 i: 1).
]

{ #category : #tests }
ComplexTest >> testMultiplication [
	self assert: (Complex r: 2 i: 3) * (Complex r: 4 i: 5) equals: (Complex r: -7 i: 22).
]

{ #category : #tests }
ComplexTest >> testMultiplicationScalar [
	self assert: (Complex r: 0 i: 0) * (Complex r: 0 i: 0) equals: (Complex r: 0 i: 0).
	self assert: (Complex r: 1 i: 2) * (Complex r: 0 i: 0) equals: (Complex r: 0 i: 0).
	self assert: (Complex r: 1 i: 2) * 0 equals: (Complex r: 0 i: 0).

	self assert: (Complex r: 0 i: 0) * (Complex r: 1 i: 0) equals: (Complex r: 0 i: 0).
	self assert: (Complex r: 1 i: 2) * (Complex r: 1 i: 0) equals: (Complex r: 1 i: 2).
	self assert: (Complex r: 1 i: 2) * 1 equals: (Complex r: 1 i: 2).

	self assert: (Complex r: 0 i: 0) * (Complex r: 3 i: 0) equals: (Complex r: 0 i: 0).
	self assert: (Complex r: 1 i: 2) * (Complex r: 3 i: 0) equals: (Complex r: 3 i: 6).
	self assert: (Complex r: 1 i: 2) * 3 equals: (Complex r: 3 i: 6).
]

{ #category : #tests }
ComplexTest >> testNegated [
	self assert: (Complex r: 1 i: 2) negated equals: (Complex r: -1 i: -2).
]

{ #category : #tests }
ComplexTest >> testNotEquals [
	| a b c |
	a := Complex r: 1 i: 2.
	b := Complex r: 3 i: 4.
	c := Complex r: 3 i: 4.

	self deny: (b ~=  c).
	self assert: a ~= b.
	self assert: a ~= c.

]

{ #category : #tests }
ComplexTest >> testOne [
	self assert: Complex one equals: (Complex r: 1 i: 0).
]

{ #category : #tests }
ComplexTest >> testSubtraction [
	self assert: (Complex r: 0 i: 0) - (Complex r: 0 i: 0) equals: (Complex r: 0 i: 0).
	self assert: (Complex r: 0 i: 0) - 0 equals: (Complex r: 0 i: 0).
	self assert: (Complex r: 0 i: 0) - 2 equals: (Complex r: -2 i: 0).
	self assert: (Complex r: 1 i: 2) - (Complex r: 0 i: 0) equals: (Complex r: 1 i: 2).
	self assert: (Complex r: 1 i: 2) - (Complex r: 3 i: 5) equals: (Complex r: -2 i: -3).
]

{ #category : #tests }
ComplexTest >> testZero [
	self assert: Complex zero equals: (Complex r: 0 i: 0).
]

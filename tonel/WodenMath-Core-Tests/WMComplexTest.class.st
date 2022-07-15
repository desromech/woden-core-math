"
A ComplexTest is a test class for testing the behavior of Complex
"
Class {
	#name : #WMComplexTest,
	#superclass : #WodenMathTestCase,
	#category : #'WodenMath-Core-Tests-Complex'
}

{ #category : #tests }
WMComplexTest >> testAbsolute [
	self assert: (WMComplex r: 0 i: 1) abs equals: 1.
	self assert: (WMComplex r: 0 i: -1) abs equals: 1.
	self assert: (WMComplex r: 1 i: 0) abs equals: 1.
	self assert: (WMComplex r: -1 i: 0) abs equals: 1.
	self assert: (WMComplex r: 3 i: 4) abs equals: 5.
	self assert: (WMComplex r: -3 i: 4) abs equals: 5.
	self assert: (WMComplex r: 3 i: -4) abs equals: 5.
	self assert: (WMComplex r: -3 i: -4) abs equals: 5.
]

{ #category : #tests }
WMComplexTest >> testAddition [
	self assert: (WMComplex r: 0 i: 0) + (WMComplex r: 0 i: 0) equals: (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 0 i: 0) + 0 equals: (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 0 i: 0) + 2 equals: (WMComplex r: 2 i: 0).
	self assert: (WMComplex r: 1 i: 2) + (WMComplex r: 0 i: 0) equals: (WMComplex r: 1 i: 2).
	self assert: (WMComplex r: 1 i: 2) + (WMComplex r: 3 i: 4) equals: (WMComplex r: 4 i: 6).
	self assert: (WMComplex r: 3 i: 4) + (WMComplex r: 1 i: 2) equals: (WMComplex r: 4 i: 6).
]

{ #category : #tests }
WMComplexTest >> testAngle [
	self assert: (WMComplex r: 1 i: 0) angle closeTo: 0.
	self assert: (WMComplex r: 0 i: 1) angle closeTo: Float halfPi.
	self assert: (((WMComplex r: -1 i: 0) angle closeTo: Float pi) or: [(WMComplex r: -1 i: 0) angle closeTo: Float pi negated]).
	self assert: (WMComplex r: 0 i: -1) angle closeTo: Float halfPi negated.
]

{ #category : #tests }
WMComplexTest >> testArgument [
	self assert: (WMComplex r: 1 i: 0) arg closeTo: 0.
	self assert: (WMComplex r: 0 i: 1) arg closeTo: Float halfPi.
	self assert: (((WMComplex r: -1 i: 0) arg closeTo: Float pi) or: [(WMComplex r: -1 i: 0) arg closeTo: Float pi negated]).
	self assert: (WMComplex r: 0 i: -1) arg closeTo: Float halfPi negated.
]

{ #category : #tests }
WMComplexTest >> testAsMatrix2x2 [
	self assert: WMComplex zero asMatrix2x2 equals: Matrix2x2 zeros.
	self assert: WMComplex identity asMatrix2x2 equals: Matrix2x2 identity.
	self assert: (WMComplex angle: Float halfPi) asMatrix2x2 closeTo: (Matrix2x2 rotation: Float halfPi).
	self assert: (WMComplex angle: Float halfPi negated) asMatrix2x2 closeTo: (Matrix2x2 rotation: Float halfPi negated).
	self assert: (WMComplex angle: Float pi) asMatrix2x2 closeTo: (Matrix2x2 rotation: Float pi).
]

{ #category : #tests }
WMComplexTest >> testCloseTo [
	| a b c |
	a := WMComplex r: 1 i: 2.
	b := WMComplex r: 3 i: 4.
	c := WMComplex r: 3 i: 4.

	self assert: b closeTo:  c.
	self deny: (a closeTo: b).
	self assert: a notCloseTo:  b.

	self deny: (a closeTo: c).

]

{ #category : #tests }
WMComplexTest >> testConjugated [
	self assert: (WMComplex r: 1 i: 2) conjugated equals: (WMComplex r: 1 i: -2).
]

{ #category : #tests }
WMComplexTest >> testConstruction [
	| complex |
	complex := WMComplex x: 2 y: 3.
	self assert: complex x equals: 2.
	self assert: complex y equals: 3.
	self assert: complex equals: (WMComplex r: 2 i: 3).
]

{ #category : #tests }
WMComplexTest >> testConstruction2 [
	| complex |
	complex := WMComplex r: 2 i: 3.
	self assert: complex x equals: 2.
	self assert: complex y equals: 3.
	self assert: complex equals: (WMComplex r: 2 i: 3).
]

{ #category : #tests }
WMComplexTest >> testDivision [
	self assert: (WMComplex r: 1 i: 2) / (WMComplex r: 1 i: 0) equals: (WMComplex r: 1 i: 2).
	self assert: (WMComplex r: 20 i: 25) / (WMComplex r: 5 i: 0) equals: (WMComplex r: 4 i: 5).
	self assert: (WMComplex r: 4 i: 89) / (WMComplex r: 4 i: 89) closeTo: (WMComplex r: 1 i: 0).
]

{ #category : #tests }
WMComplexTest >> testDot [
	self assert: ((WMComplex r: 1 i: 2) dot: (WMComplex r: 4 i: 7)) equals: "4 + 14" 18.
]

{ #category : #tests }
WMComplexTest >> testEquals [
	| a b c |
	a := WMComplex r: 1 i: 2.
	b := WMComplex r: 3 i: 4.
	c := WMComplex r: 3 i: 4.

	self assert: b equals:  c.
	self deny: a = b.
	self deny: a = c.

]

{ #category : #tests }
WMComplexTest >> testGreaterOrEqual [
	self assert: (WMComplex r: 0 i: 0) >= (WMComplex r: 0 i: 0).
	self deny: (WMComplex r: 0 i: 0) >= (WMComplex r: 1 i: 0).
	self assert: (WMComplex r: 1 i: 0) >= (WMComplex r: 0 i: 0).

	self deny: (WMComplex r: 0 i: 0) >= (WMComplex r: 0 i: 1).
	self assert: (WMComplex r: 0 i: 1) >= (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 0 i: 1) >= (WMComplex r: 0 i: 1).
]

{ #category : #tests }
WMComplexTest >> testGreaterThan [
	self deny: (WMComplex r: 0 i: 0) > (WMComplex r: 0 i: 0).
	self deny: (WMComplex r: 0 i: 0) > (WMComplex r: 1 i: 0).
	self assert: (WMComplex r: 1 i: 0) > (WMComplex r: 0 i: 0).

	self deny: (WMComplex r: 0 i: 0) > (WMComplex r: 0 i: 1).
	self assert: (WMComplex r: 0 i: 1) > (WMComplex r: 0 i: 0).
	self deny: (WMComplex r: 0 i: 1) > (WMComplex r: 0 i: 1).
]

{ #category : #tests }
WMComplexTest >> testHash [
	| b c |
	b := WMComplex r: 3 i: 4.
	c := WMComplex r: 3 i: 4.
	self assert: b hash equals: c hash.
]

{ #category : #tests }
WMComplexTest >> testIdentity [
	self assert: WMComplex identity equals: (WMComplex r: 1 i: 0).
]

{ #category : #tests }
WMComplexTest >> testInverse [
	self assert: (WMComplex r: 1 i: 0) inverse equals: (WMComplex r: 1 i: 0).
	self assert: WMComplex one inverse equals: WMComplex one.
]

{ #category : #tests }
WMComplexTest >> testLength [
	self assert: (WMComplex r: 3 i: 4) length equals: 5.
]

{ #category : #tests }
WMComplexTest >> testLength2 [
	self assert: (WMComplex r: 3 i: 4) length2 equals: 25.
]

{ #category : #tests }
WMComplexTest >> testLessOrEqual [
	self assert: (WMComplex r: 0 i: 0) <= (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 0 i: 0) <= (WMComplex r: 1 i: 0).
	self deny: (WMComplex r: 1 i: 0) <= (WMComplex r: 0 i: 0).

	self assert: (WMComplex r: 0 i: 0) <= (WMComplex r: 0 i: 1).
	self deny: (WMComplex r: 0 i: 1) <= (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 0 i: 1) <= (WMComplex r: 0 i: 1).
]

{ #category : #tests }
WMComplexTest >> testLessThan [
	self deny: (WMComplex r: 0 i: 0) < (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 0 i: 0) < (WMComplex r: 1 i: 0).
	self deny: (WMComplex r: 1 i: 0) < (WMComplex r: 0 i: 0).

	self assert: (WMComplex r: 0 i: 0) < (WMComplex r: 0 i: 1).
	self deny: (WMComplex r: 0 i: 1) < (WMComplex r: 0 i: 0).
	self deny: (WMComplex r: 0 i: 1) < (WMComplex r: 0 i: 1).
]

{ #category : #tests }
WMComplexTest >> testMultiplication [
	self assert: (WMComplex r: 2 i: 3) * (WMComplex r: 4 i: 5) equals: (WMComplex r: -7 i: 22).
]

{ #category : #tests }
WMComplexTest >> testMultiplicationScalar [
	self assert: (WMComplex r: 0 i: 0) * (WMComplex r: 0 i: 0) equals: (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 1 i: 2) * (WMComplex r: 0 i: 0) equals: (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 1 i: 2) * 0 equals: (WMComplex r: 0 i: 0).

	self assert: (WMComplex r: 0 i: 0) * (WMComplex r: 1 i: 0) equals: (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 1 i: 2) * (WMComplex r: 1 i: 0) equals: (WMComplex r: 1 i: 2).
	self assert: (WMComplex r: 1 i: 2) * 1 equals: (WMComplex r: 1 i: 2).

	self assert: (WMComplex r: 0 i: 0) * (WMComplex r: 3 i: 0) equals: (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 1 i: 2) * (WMComplex r: 3 i: 0) equals: (WMComplex r: 3 i: 6).
	self assert: (WMComplex r: 1 i: 2) * 3 equals: (WMComplex r: 3 i: 6).
]

{ #category : #tests }
WMComplexTest >> testNegated [
	self assert: (WMComplex r: 1 i: 2) negated equals: (WMComplex r: -1 i: -2).
]

{ #category : #tests }
WMComplexTest >> testNotEquals [
	| a b c |
	a := WMComplex r: 1 i: 2.
	b := WMComplex r: 3 i: 4.
	c := WMComplex r: 3 i: 4.

	self deny: (b ~=  c).
	self assert: a ~= b.
	self assert: a ~= c.

]

{ #category : #tests }
WMComplexTest >> testOne [
	self assert: WMComplex one equals: (WMComplex r: 1 i: 0).
]

{ #category : #tests }
WMComplexTest >> testSubtraction [
	self assert: (WMComplex r: 0 i: 0) - (WMComplex r: 0 i: 0) equals: (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 0 i: 0) - 0 equals: (WMComplex r: 0 i: 0).
	self assert: (WMComplex r: 0 i: 0) - 2 equals: (WMComplex r: -2 i: 0).
	self assert: (WMComplex r: 1 i: 2) - (WMComplex r: 0 i: 0) equals: (WMComplex r: 1 i: 2).
	self assert: (WMComplex r: 1 i: 2) - (WMComplex r: 3 i: 5) equals: (WMComplex r: -2 i: -3).
]

{ #category : #tests }
WMComplexTest >> testZero [
	self assert: WMComplex zero equals: (WMComplex r: 0 i: 0).
]

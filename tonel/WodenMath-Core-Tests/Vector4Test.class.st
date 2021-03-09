"
A Vector4Test is a test class for testing the behavior of Vector4
"
Class {
	#name : #Vector4Test,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-LinearAlgebra'
}

{ #category : #tests }
Vector4Test >> testAddition [
	self assert: (Vector4 x: 0 y: 0 z: 0 w: 0) + (Vector4 x: 0 y: 0 z: 0 w: 0) equals: (Vector4 x: 0 y: 0 z: 0 w: 0).
	self assert: (Vector4 x: 1 y: 2 z: 3 w: 4) + (Vector4 x: 0 y: 0 z: 0 w: 0) equals: (Vector4 x: 1 y: 2 z: 3 w: 4).
	self assert: (Vector4 x: 1 y: 2 z: 3 w: 4) + (Vector4 x: 5 y: 6 z: 7 w: 8) equals: (Vector4 x: 6 y: 8 z: 10 w: 12).
	self assert: (Vector4 x: 5 y: 6 z: 7 w: 8) + (Vector4 x: 1 y: 2 z: 3 w: 4) equals: (Vector4 x: 6 y: 8 z: 10 w: 12).
]

{ #category : #tests }
Vector4Test >> testCloseTo [
	| a b c |
	a := Vector4 x: 1 y: 2 z: 4 w: 5.
	b := Vector4 x: 3 y: 4 z: 5 w: 6.
	c := Vector4 x: 3 y: 4 z: 5 w: 6.

	self assert: b closeTo: c.
	self deny: (a closeTo: b).
	self assert: a notCloseTo:  b.

	self deny: (a closeTo: c).
	self assert: a notCloseTo: c.
]

{ #category : #tests }
Vector4Test >> testDivision [
	self assert: (Vector4 x: 1 y: 2 z: 3 w: 4) / (Vector4 x: 1 y: 1 z: 1 w: 1) equals: (Vector4 x: 1 y: 2 z: 3 w: 4).
	self assert: (Vector4 x: 20 y: 9 z: 50 w: 49) / (Vector4 x: 5 y: 3 z: 10 w: 7) equals: (Vector4 x: 4 y: 3 z: 5 w: 7).
]

{ #category : #tests }
Vector4Test >> testDot [
	self assert: ((Vector4 x: 1 y: 2 z: 3 w: 4) dot: (Vector4 x: 4 y: 7 z: 8 w: 9)) equals: "4 + 14 + 24 + 36" 78.
]

{ #category : #tests }
Vector4Test >> testEquals [
	| a b c |
	a := Vector4 x: 1 y: 2 z: 4 w: 5.
	b := Vector4 x: 3 y: 4 z: 5 w: 6.
	c := Vector4 x: 3 y: 4 z: 5 w: 6.

	self assert: b equals:  c.
	self deny: a = b.
	self deny: a = c.
]

{ #category : #tests }
Vector4Test >> testHash [
	| b c |
	b := Vector4 x: 3 y: 4 z: 5 w: 6.
	c := Vector4 x: 3 y: 4 z: 5 w: 6.
	self assert: b hash equals: c hash.
]

{ #category : #tests }
Vector4Test >> testLength [
	self assert: (Vector4 x: 2 y: 2 z: 2 w: 2) length equals: 4.
]

{ #category : #tests }
Vector4Test >> testLength2 [
	self assert: (Vector4 x: 2 y: 2 z: 2 w: 2) length2 equals: 16.
]

{ #category : #tests }
Vector4Test >> testMultiplication [
	self assert: (Vector4 x: 0 y: 0 z: 0 w: 0) * (Vector4 x: 0 y: 0 z: 0 w: 0) equals: (Vector4 x: 0 y: 0 z: 0 w: 0).
	self assert: (Vector4 x: 1 y: 2 z: 3 w: 4) * (Vector4 x: 0 y: 0 z: 0 w: 0) equals: (Vector4 x: 0 y: 0 z: 0 w: 0).
	self assert: (Vector4 x: 1 y: 2 z: 3 w: 4) * (Vector4 x: 1 y: 1 z: 1 w: 1) equals: (Vector4 x: 1 y: 2 z: 3 w: 4).
	self assert: (Vector4 x: 2 y: 3 z: 4 w: 5) * (Vector4 x: 3 y: 5 z: 7 w: 9) equals: (Vector4 x: 6 y: 15 z: 28 w: 45).
]

{ #category : #tests }
Vector4Test >> testNegated [
	self assert: (Vector4 x: 1 y: 2 z: 3 w: 4) negated equals: (Vector4 x: -1 y: -2 z: -3 w: -4).
]

{ #category : #tests }
Vector4Test >> testNotEquals [
	| a b c |
	a := Vector4 x: 1 y: 2 z: 4 w: 5.
	b := Vector4 x: 3 y: 4 z: 5 w: 6.
	c := Vector4 x: 3 y: 4 z: 5 w: 6.

	self deny: (b ~= c).
	self assert: a ~= b.
	self assert: a ~= c.
]

{ #category : #tests }
Vector4Test >> testSubtraction [
	self assert: (Vector4 x: 0 y: 0 z: 0 w: 0) - (Vector4 x: 0 y: 0 z: 0 w: 0) equals: (Vector4 x: 0 y: 0 z: 0 w: 0).
	self assert: (Vector4 x: 1 y: 2 z: 3 w: 4) - (Vector4 x: 0 y: 0 z: 0 w: 0) equals: (Vector4 x: 1 y: 2 z: 3 w: 4).
	self assert: (Vector4 x: 1 y: 2 z: 3 w: 4) - (Vector4 x: 10 y: 12 z: 14 w: 20) equals: (Vector4 x: -9 y: -10 z: -11 w: -16).
]

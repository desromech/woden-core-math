"
I am a complex number.
"
Class {
	#name : #Complex,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'WodenMath-Core-Complex'
}

{ #category : #'accessing structure variables' }
Complex class >> angle: theta [
	^ self basicNew
		r: theta cos; i: theta sin
		yourself
]

{ #category : #'accessing structure variables' }
Complex class >> identity [
	^ self r: 1 i: 0
]

{ #category : #'accessing structure variables' }
Complex class >> one [
	^ self r: 1 i: 0
]

{ #category : #'accessing structure variables' }
Complex class >> r: r i: i [
	^ self basicNew
		r: r;
		i: i
]

{ #category : #'accessing structure variables' }
Complex class >> radius: radius angle: theta [
	^ self basicNew
		r: radius * theta cos; i: radius * theta sin
		yourself
]

{ #category : #'accessing structure variables' }
Complex class >> x: x y: y [
	^ self basicNew
		x: x;
		y: y
]

{ #category : #'accessing structure variables' }
Complex class >> xy: xy [
	^ self basicNew
		xy: xy
]

{ #category : #'accessing structure variables' }
Complex class >> zero [
	^ self r: 0 i: 0
]

{ #category : #arithmetic }
Complex >> * other [
	other isNumber ifTrue: [ ^ self class x: x * other y: y * other ].
	^ self class
		x: (x * other x) - (y * other y)
		y: (x * other y) + (y * other x)
]

{ #category : #arithmetic }
Complex >> + other [
	other isNumber ifTrue: [ ^ self class x: x + other y: y ].
	^ self class x: x + other x y: y + other y
]

{ #category : #arithmetic }
Complex >> - other [
	other isNumber ifTrue: [ ^ self class x: x - other y: y ].
	^ self class x: x - other x y: y - other y
]

{ #category : #arithmetic }
Complex >> / other [
	other isNumber ifTrue: [ ^ self class x: x / other y: y / other ].
	^ self * other inverse
]

{ #category : #comparing }
Complex >> < other [
	^ self <=> other < 0
]

{ #category : #comparing }
Complex >> <= other [
	^ self <=> other <= 0
]

{ #category : #comparing }
Complex >> <=> other [
	x ~= other x ifTrue: [ ^ x <=> other x ].
	^ y <=> other y
]

{ #category : #comparing }
Complex >> = other [
	^ self class == other class and: [ x = other x and: [ y = other y ] ]
]

{ #category : #comparing }
Complex >> > other [
	^ self <=> other > 0
]

{ #category : #comparing }
Complex >> >= other [
	^ self <=> other >= 0
]

{ #category : #arithmetic }
Complex >> abs [
	^ self length
]

{ #category : #accessing }
Complex >> angle [
	^ y arcTan: x
]

{ #category : #accessing }
Complex >> arg [
	^ y arcTan: x
]

{ #category : #converting }
Complex >> asComplex [
	^ self
]

{ #category : #converting }
Complex >> asMatrix2x2 [
	^ Matrix2x2 columns: {
		x . y.
		y negated . x
	}
]

{ #category : #converting }
Complex >> asVector2 [
	^ Vector2 x: x y: y
]

{ #category : #comparing }
Complex >> closeTo: other [
	^ (x closeTo: other x) and: [ y closeTo: other y ]
]

{ #category : #comparing }
Complex >> closeTo: other precision: precision [
	^ (x closeTo: other x precision: precision) and: [ y closeTo: other y precision: precision ]
]

{ #category : #arithmetic }
Complex >> conjugated [
	^ self class x: x y: y negated
]

{ #category : #arithmetic }
Complex >> dot: other [
	^ (x*other x) + (y *other y)
]

{ #category : #comparing }
Complex >> hash [
	^ x hash hashMultiply + y hash
]

{ #category : #accessing }
Complex >> i [
	^ y
]

{ #category : #accessing }
Complex >> i: imaginaryPart [
	y := imaginaryPart
]

{ #category : #arithmetic }
Complex >> inverse [
	| l2 |
	l2 := self length2.
	^ self class x: x / l2 y: y negated / l2
]

{ #category : #accessing }
Complex >> length [
	^ self length2 sqrt
]

{ #category : #accessing }
Complex >> length2 [
	^ self dot: self
]

{ #category : #arithmetic }
Complex >> negated [
	^ self class x: x negated y: y negated
]

{ #category : #accessing }
Complex >> normalized [
	^ self / self length
]

{ #category : #printing }
Complex >> printOn: aStream [
	aStream nextPutAll: self class name; space; print: x; space; print: y
]

{ #category : #accessing }
Complex >> r [
	^ x
]

{ #category : #accessing }
Complex >> r: realPart [
	x := realPart
]

{ #category : #accessing }
Complex >> x [

	^ x
]

{ #category : #accessing }
Complex >> x: anObject [

	x := anObject
]

{ #category : #accessing }
Complex >> xy [
	^ Vector2 x: x y: y
]

{ #category : #accessing }
Complex >> xy: aVector2 [
	x := aVector2 x.
	y := aVector2 y.
]

{ #category : #accessing }
Complex >> y [

	^ y
]

{ #category : #accessing }
Complex >> y: anObject [

	y := anObject
]

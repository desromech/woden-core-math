"
I am a complex number.
"
Class {
	#name : #WMComplex,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'WodenMath-Core-Complex'
}

{ #category : #'accessing structure variables' }
WMComplex class >> angle: theta [
	^ self basicNew
		r: theta cos; i: theta sin
		yourself
]

{ #category : #'accessing structure variables' }
WMComplex class >> identity [
	^ self r: 1 i: 0
]

{ #category : #'accessing structure variables' }
WMComplex class >> one [
	^ self r: 1 i: 0
]

{ #category : #'accessing structure variables' }
WMComplex class >> r: r i: i [
	^ self basicNew
		r: r;
		i: i
]

{ #category : #'accessing structure variables' }
WMComplex class >> radius: radius angle: theta [
	^ self basicNew
		r: radius * theta cos; i: radius * theta sin
		yourself
]

{ #category : #'accessing structure variables' }
WMComplex class >> x: x y: y [
	^ self basicNew
		x: x;
		y: y
]

{ #category : #'accessing structure variables' }
WMComplex class >> xy: xy [
	^ self basicNew
		xy: xy
]

{ #category : #'accessing structure variables' }
WMComplex class >> zero [
	^ self r: 0 i: 0
]

{ #category : #arithmetic }
WMComplex >> * other [
	other isNumber ifTrue: [ ^ self class x: x * other y: y * other ].
	^ self class
		x: (x * other x) - (y * other y)
		y: (x * other y) + (y * other x)
]

{ #category : #arithmetic }
WMComplex >> + other [
	other isNumber ifTrue: [ ^ self class x: x + other y: y ].
	^ self class x: x + other x y: y + other y
]

{ #category : #arithmetic }
WMComplex >> - other [
	other isNumber ifTrue: [ ^ self class x: x - other y: y ].
	^ self class x: x - other x y: y - other y
]

{ #category : #arithmetic }
WMComplex >> / other [
	other isNumber ifTrue: [ ^ self class x: x / other y: y / other ].
	^ self * other inverse
]

{ #category : #comparing }
WMComplex >> < other [
	^ self <=> other < 0
]

{ #category : #comparing }
WMComplex >> <= other [
	^ self <=> other <= 0
]

{ #category : #comparing }
WMComplex >> <=> other [
	x ~= other x ifTrue: [ ^ x <=> other x ].
	^ y <=> other y
]

{ #category : #comparing }
WMComplex >> = other [
	^ self class == other class and: [ x = other x and: [ y = other y ] ]
]

{ #category : #comparing }
WMComplex >> > other [
	^ self <=> other > 0
]

{ #category : #comparing }
WMComplex >> >= other [
	^ self <=> other >= 0
]

{ #category : #arithmetic }
WMComplex >> abs [
	^ self length
]

{ #category : #accessing }
WMComplex >> angle [
	^ y arcTan: x
]

{ #category : #accessing }
WMComplex >> arg [
	^ y arcTan: x
]

{ #category : #converting }
WMComplex >> asMatrix2x2 [
	^ Matrix2x2 columns: {
		x . y.
		y negated . x
	}
]

{ #category : #converting }
WMComplex >> asVector2 [
	^ Vector2 x: x y: y
]

{ #category : #converting }
WMComplex >> asWMComplex [
	^ self
]

{ #category : #comparing }
WMComplex >> closeTo: other [
	^ (x closeTo: other x) and: [ y closeTo: other y ]
]

{ #category : #comparing }
WMComplex >> closeTo: other precision: precision [
	^ (x closeTo: other x precision: precision) and: [ y closeTo: other y precision: precision ]
]

{ #category : #arithmetic }
WMComplex >> conjugated [
	^ self class x: x y: y negated
]

{ #category : #arithmetic }
WMComplex >> dot: other [
	^ (x*other x) + (y *other y)
]

{ #category : #comparing }
WMComplex >> hash [
	^ x hash hashMultiply + y hash
]

{ #category : #accessing }
WMComplex >> i [
	^ y
]

{ #category : #accessing }
WMComplex >> i: imaginaryPart [
	y := imaginaryPart
]

{ #category : #arithmetic }
WMComplex >> inverse [
	| l2 |
	l2 := self length2.
	^ self class x: x / l2 y: y negated / l2
]

{ #category : #accessing }
WMComplex >> length [
	^ self length2 sqrt
]

{ #category : #accessing }
WMComplex >> length2 [
	^ self dot: self
]

{ #category : #arithmetic }
WMComplex >> negated [
	^ self class x: x negated y: y negated
]

{ #category : #accessing }
WMComplex >> normalized [
	^ self / self length
]

{ #category : #printing }
WMComplex >> printOn: aStream [
	aStream nextPutAll: self class name; space; print: x; space; print: y
]

{ #category : #accessing }
WMComplex >> r [
	^ x
]

{ #category : #accessing }
WMComplex >> r: realPart [
	x := realPart
]

{ #category : #accessing }
WMComplex >> x [

	^ x
]

{ #category : #accessing }
WMComplex >> x: anObject [

	x := anObject
]

{ #category : #accessing }
WMComplex >> xy [
	^ Vector2 x: x y: y
]

{ #category : #accessing }
WMComplex >> xy: aVector2 [
	x := aVector2 x.
	y := aVector2 y.
]

{ #category : #accessing }
WMComplex >> y [

	^ y
]

{ #category : #accessing }
WMComplex >> y: anObject [

	y := anObject
]

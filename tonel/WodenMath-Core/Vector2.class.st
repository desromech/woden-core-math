"
I am a 2D vector.
"
Class {
	#name : #Vector2,
	#superclass : #AbstractPrimitiveVector,
	#instVars : [
		'x',
		'y'
	],
	#category : #'WodenMath-Core-LinearAlgebra'
}

{ #category : #'instance creation' }
Vector2 class >> withAll: element [
	^ self x: element y: element
]

{ #category : #'accessing structure variables' }
Vector2 class >> x: x [
	^ self x: x y: 0
]

{ #category : #'accessing structure variables' }
Vector2 class >> x: x y: y [
	^ self basicNew x: x; y: y
]

{ #category : #'accessing structure variables' }
Vector2 class >> y: y [
	^ self x: 0 y: y
]

{ #category : #comparing }
Vector2 >> <=> other [
	| coercedOther |
	coercedOther := other asVector2.
	x ~= coercedOther x ifTrue: [ ^ x <=> coercedOther x ].
	^ y <=> coercedOther y
]

{ #category : #comparing }
Vector2 >> = other [
	other isNumber ifTrue: [ ^ x = other and: [ y = other ] ].
	^ self class == other class and: [x = other x and: [ y = other y ]]
]

{ #category : #converting }
Vector2 >> asComplex [
	^ Complex xy: self
]

{ #category : #converting }
Vector2 >> asVector2 [
	^ self
]

{ #category : #comparing }
Vector2 >> closeTo: other [
	^ self class == other class and: [(x closeTo: other x) and: [ y closeTo: other y ]]
]

{ #category : #comparing }
Vector2 >> closeTo: other precision: precision [
	^ self class == other class and: [
	(x closeTo: other x precision: precision) and: [
	y closeTo: other y precision: precision ]]
]

{ #category : #enumerating }
Vector2 >> collect: aBlock [
	^ self class basicNew
		x: (aBlock value: x);
		y: (aBlock value: y);
		yourself
]

{ #category : #comparing }
Vector2 >> cross: other [
	| coercedOther |
	coercedOther := other asVector2.
	^ (x * other y) - (y * other x)
]

{ #category : #arithmetic }
Vector2 >> dot: other [
	| coercedOther |
	coercedOther := other asVector2.
	^ (x * coercedOther x) + (y * coercedOther y)
]

{ #category : #comparing }
Vector2 >> hash [
	^ x hash hashMultiply + y hash
]

{ #category : #initialization }
Vector2 >> initialize [
	x := 0.
	y := 0.
]

{ #category : #printing }
Vector2 >> printOn: aStream [
	aStream nextPut: $(; nextPutAll: self class name;
		nextPutAll:  ' x: '; print: x;
		nextPutAll:  ' y: '; print: y;
		nextPut: $)
]

{ #category : #enumerating }
Vector2 >> with: other collect: aBlock [
	| coercedOther |
	coercedOther := other asVector2.
	^ self class basicNew
		x: (aBlock value: x value: coercedOther x);
		y: (aBlock value: y value: coercedOther y);
		yourself
]

{ #category : #accessing }
Vector2 >> x [

	^ x
]

{ #category : #accessing }
Vector2 >> x: anObject [

	x := anObject
]

{ #category : #accessing }
Vector2 >> y [

	^ y
]

{ #category : #accessing }
Vector2 >> y: anObject [

	y := anObject
]

"
I am a 3D vector.
"
Class {
	#name : #Vector3,
	#superclass : #AbstractPrimitiveVector,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #'WodenMath-Core-LinearAlgebra'
}

{ #category : #'instance creation' }
Vector3 class >> withAll: element [
	^ self x: element y: element z: element
]

{ #category : #'accessing structure variables' }
Vector3 class >> x: x [
	^ self x: x y: 0 z: 0
]

{ #category : #'accessing structure variables' }
Vector3 class >> x: x y: y [
	^ self x: x y: y z: 0
]

{ #category : #construction }
Vector3 class >> x: x y: y z: z [
	^ self basicNew
		x: x;
		y: y;
		z: z
]

{ #category : #'accessing structure variables' }
Vector3 class >> xy: xy z: z [
	^ self x: xy x y: xy y z: z
]

{ #category : #'accessing structure variables' }
Vector3 class >> y: y [
	^ self x: 0 y: y z: 0
]

{ #category : #'accessing structure variables' }
Vector3 class >> z: z [
	^ self x: 0 y: 0 z: z
]

{ #category : #comparing }
Vector3 >> <=> other [
	| coercedOther |
	coercedOther := other asVector3.
	x ~= coercedOther x ifTrue: [ ^ x <=> coercedOther x ].
	y ~= coercedOther y ifTrue: [ ^ y <=> coercedOther y ].
	^ z <=> coercedOther z
]

{ #category : #comparing }
Vector3 >> = other [
	other isNumber ifTrue: [ ^ x = other and: [ y = other and: [ z = other]]].
	^ self class == other class and: [x = other x and: [ y = other y and: [ z = other z ]]]
]

{ #category : #converting }
Vector3 >> asVector3 [
	^ self
]

{ #category : #comparing }
Vector3 >> closeTo: other [
	^ self class == other class and: [
	(x closeTo: other x) and: [
	(y closeTo: other y) and: [
	z closeTo: other z ]]]
]

{ #category : #comparing }
Vector3 >> closeTo: other precision: precision [
	^ self class == other class and: [
	(x closeTo: other x precision: precision) and: [
	(y closeTo: other y precision: precision) and: [
	z closeTo: other z precision: precision ]]]
]

{ #category : #enumerating }
Vector3 >> collect: aBlock [
	^ self class basicNew
		x: (aBlock value: x);
		y: (aBlock value: y);
		z: (aBlock value: z);
		yourself
]

{ #category : #comparing }
Vector3 >> cross: other [
	| coercedOther |
	coercedOther := other asVector3.
	^ self class basicNew
		x: (y*coercedOther z) - (z * coercedOther y);
		y: (z*coercedOther x) - (x * coercedOther z);
		z: (x*coercedOther y) - (y * coercedOther x);
		yourself
]

{ #category : #enumerating }
Vector3 >> do: aBlock [
	aBlock value: x.
	aBlock value: y.
	aBlock value: z.
]

{ #category : #arithmetic }
Vector3 >> dot: other [
	| coercedOther |
	coercedOther := other asVector3.
	^ (x * coercedOther x) + (y * coercedOther y) + (z * coercedOther z)
]

{ #category : #comparing }
Vector3 >> hash [
	^ (x hash hashMultiply + y hash) hashMultiply + z hash
]

{ #category : #testing }
Vector3 >> isOnes [
	^ x = 1 and: [ y = 1 and: [ z = 1 ] ]
]

{ #category : #testing }
Vector3 >> isZeros [
	^ x = 0 and: [ y = 0 and: [ z = 0 ] ]
]

{ #category : #printing }
Vector3 >> printOn: aStream [
	aStream nextPut: $(; nextPutAll: self class name;
		nextPutAll:  ' x: '; print: x;
		nextPutAll:  ' y: '; print: y;
		nextPutAll:  ' z: '; print: z;
		nextPut: $)
]

{ #category : #enumerating }
Vector3 >> with: other collect: aBlock [
	| coercedOther |
	coercedOther := other asVector3.
	^ self class basicNew
		x: (aBlock value: x value: coercedOther x);
		y: (aBlock value: y value: coercedOther y);
		z: (aBlock value: z value: coercedOther z);
		yourself
]

{ #category : #accessing }
Vector3 >> x [

	^ x
]

{ #category : #accessing }
Vector3 >> x: anObject [

	x := anObject
]

{ #category : #accessing }
Vector3 >> y [

	^ y
]

{ #category : #accessing }
Vector3 >> y: anObject [

	y := anObject
]

{ #category : #accessing }
Vector3 >> z [

	^ z
]

{ #category : #accessing }
Vector3 >> z: anObject [

	z := anObject
]

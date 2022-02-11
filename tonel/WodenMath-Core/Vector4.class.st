"
I am a 4D vector.
"
Class {
	#name : #Vector4,
	#superclass : #AbstractPrimitiveVector,
	#instVars : [
		'x',
		'y',
		'z',
		'w'
	],
	#category : #'WodenMath-Core-LinearAlgebra'
}

{ #category : #serialization }
Vector4 class >> loadFromJson: jsonData [
	^ self x: jsonData first asNumber y: jsonData second asNumber z: jsonData third asNumber w: jsonData fourth asNumber
]

{ #category : #'instance creation' }
Vector4 class >> withAll: element [
	^ self x: element y: element z: element w: element
]

{ #category : #construction }
Vector4 class >> x: x y: y z: z w: w [
	^ self basicNew
		x: x;
		y: y;
		z: z;
		w: w
]

{ #category : #construction }
Vector4 class >> xyz: xyz w: w [
	^ self basicNew
		x: xyz x;
		y: xyz y;
		z: xyz z;
		w: w
]

{ #category : #comparing }
Vector4 >> <=> other [
	| coercedOther |
	coercedOther := other asVector4.
	x ~= coercedOther x ifTrue: [ ^ x <=> coercedOther x ].
	y ~= coercedOther y ifTrue: [ ^ y <=> coercedOther y ].
	z ~= coercedOther z ifTrue: [ ^ z <=> coercedOther z ].
	^ w <=> coercedOther w
]

{ #category : #comparing }
Vector4 >> = other [
	other isNumber ifTrue: [ ^ x = other and: [ y = other and: [ z = other and: [ w = other ] ]]].
	^ self class == other class and: [x = other x and: [ y = other y and: [ z = other z and: [w = other w ]]]]
]

{ #category : #converting }
Vector4 >> asColor [
	^ Color r: x encodeSRGBComponent g: y encodeSRGBComponent b: z encodeSRGBComponent alpha: w
]

{ #category : #converting }
Vector4 >> asVector4 [
	^ self
]

{ #category : #comparing }
Vector4 >> closeTo: other [
	^ self class == other class and: [
	(x closeTo: other x) and: [
	(y closeTo: other y) and: [
	(z closeTo: other z) and: [
	w closeTo: other w ]]]]
]

{ #category : #comparing }
Vector4 >> closeTo: other precision: precision [
	^ self class == other class and: [
	(x closeTo: other x precision: precision) and: [
	(y closeTo: other y precision: precision) and: [
	(z closeTo: other z precision: precision) and: [
	w closeTo: other w precision: precision ]]]]
]

{ #category : #enumerating }
Vector4 >> collect: aBlock [
	^ self class basicNew
		x: (aBlock value: x);
		y: (aBlock value: y);
		z: (aBlock value: z);
		w: (aBlock value: w);
		yourself
]

{ #category : #enumerating }
Vector4 >> do: aBlock [
	aBlock value: x.
	aBlock value: y.
	aBlock value: z.
	aBlock value: w.
]

{ #category : #arithmetic }
Vector4 >> dot: other [
	| coercedOther |
	coercedOther := other asVector4.
	^ (x * coercedOther x) + (y * coercedOther y) + (z * coercedOther z) + (w * coercedOther w)
]

{ #category : #serialization }
Vector4 >> encodeForJSON [
	^ { x . y . z . w }
]

{ #category : #comparing }
Vector4 >> hash [
	^ ((x hash hashMultiply + y hash) hashMultiply + z hash) hashMultiply hash
]

{ #category : #testing }
Vector4 >> isOnes [
	^ x = 1 and: [ y = 1 and: [ z = 1 and: [ w = 1 ] ] ]
]

{ #category : #testing }
Vector4 >> isZeros [
	^ x = 0 and: [ y = 0 and: [ z = 0 and: [ w = 0 ] ] ]
]

{ #category : #arithmetic }
Vector4 >> max [
	^ (x max: y) max: (z max: w)
]

{ #category : #arithmetic }
Vector4 >> minorAt: index [
	index = 1 ifTrue: [ ^ Vector3 x: y y: z z: w ].
	index = 2 ifTrue: [ ^ Vector3 x: x y: z z: w ].
	index = 3 ifTrue: [ ^ Vector3 x: x y: y z: w ].
	index = 4 ifTrue: [ ^ Vector3 x: x y: y z: z ].
	self error
]

{ #category : #printing }
Vector4 >> printOn: aStream [
	aStream nextPut: $(; nextPutAll: self class name;
		nextPutAll:  ' x: '; print: x;
		nextPutAll:  ' y: '; print: y;
		nextPutAll:  ' z: '; print: z;
		nextPutAll:  ' w: '; print: w;
		nextPut: $)
]

{ #category : #accessing }
Vector4 >> w [

	^ w
]

{ #category : #accessing }
Vector4 >> w: anObject [

	w := anObject
]

{ #category : #enumerating }
Vector4 >> with: other collect: aBlock [
	| coercedOther |
	coercedOther := other asVector4.
	^ self class basicNew
		x: (aBlock value: x value: coercedOther x);
		y: (aBlock value: y value: coercedOther y);
		z: (aBlock value: z value: coercedOther z);
		w: (aBlock value: w value: coercedOther w);
		yourself
]

{ #category : #accessing }
Vector4 >> x [

	^ x
]

{ #category : #accessing }
Vector4 >> x: anObject [

	x := anObject
]

{ #category : #accessing }
Vector4 >> xyz [
	^ Vector3 x: x y: y z: z
]

{ #category : #accessing }
Vector4 >> y [

	^ y
]

{ #category : #accessing }
Vector4 >> y: anObject [

	y := anObject
]

{ #category : #accessing }
Vector4 >> z [

	^ z
]

{ #category : #accessing }
Vector4 >> z: anObject [

	z := anObject
]

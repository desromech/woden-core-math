"
I am a quaterion, an extension of the complex number that is used for representing rotations in 3D that are easy to interpolate without causing a gimbal lock.
"
Class {
	#name : #Quaternion,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z',
		'w'
	],
	#category : #'WodenMath-Core-Complex'
}

{ #category : #'instance creation' }
Quaternion class >> axis: axis angle: angle [
	| halfAngle c s |
	halfAngle := angle / 2.
	c := halfAngle cos.
	s := halfAngle sin.
	^ self xyz: axis*s w: c
]

{ #category : #'instance creation' }
Quaternion class >> identity [
	^ self x: 0 y: 0 z: 0 w: 1
]

{ #category : #'special matrices' }
Quaternion class >> lookAtBack [
	^ self yRotation: Float pi
]

{ #category : #'special matrices' }
Quaternion class >> lookAtBottom [
	^ self xRotation: Float halfPi negated
]

{ #category : #'special matrices' }
Quaternion class >> lookAtFront [
	^ self identity
]

{ #category : #'special matrices' }
Quaternion class >> lookAtLeft [
	^ self yRotation: Float halfPi
]

{ #category : #'special matrices' }
Quaternion class >> lookAtRight [
	^ self yRotation: Float halfPi negated
]

{ #category : #'special matrices' }
Quaternion class >> lookAtTop [
	^ self yRotation: Float halfPi
]

{ #category : #'instance creation' }
Quaternion class >> one [
	^ self x: 0 y: 0 z: 0 w: 1
]

{ #category : #'accessing structure variables' }
Quaternion class >> r: r [
	^ self x: 0 y: 0 z: 0 w: r
]

{ #category : #'accessing structure variables' }
Quaternion class >> r: r i: i j: j k: k [
	^ self basicNew
		r: r; i: i; j: j; k: k
]

{ #category : #'accessing structure variables' }
Quaternion class >> x: x y: y z: z w: w [
	^ self basicNew
		x: x; y: y; z: z; w: w
]

{ #category : #'special matrices' }
Quaternion class >> xRotation: angle [
	| halfAngle c s |
	halfAngle := angle / 2.
	c := halfAngle cos.
	s := halfAngle sin.
	^ self x: s y: 0 z: 0 w: c
]

{ #category : #'special matrices' }
Quaternion class >> xyzRotation: angles [
	^ (self xRotation: angles x) * (self yRotation: angles y) * (self zRotation: angles z)
]

{ #category : #'special matrices' }
Quaternion class >> yRotation: angle [
	| halfAngle c s |
	halfAngle := angle / 2.
	c := halfAngle cos.
	s := halfAngle sin.
	^ self x: 0 y: s z: 0 w: c
]

{ #category : #'special matrices' }
Quaternion class >> zRotation: angle [
	| halfAngle c s |
	halfAngle := angle / 2.
	c := halfAngle cos.
	s := halfAngle sin.
	^ self x: 0 y: 0 z: s w: c
]

{ #category : #'instance creation' }
Quaternion class >> zero [
	^ self x: 0 y: 0 z: 0 w: 0
]

{ #category : #'special quaternions' }
Quaternion class >> zyxRotation: angles [
	^ (self zRotation: angles z) * (self yRotation: angles y) * (self xRotation: angles x)
]

{ #category : #arithmetic }
Quaternion >> * other [
	other isNumber ifTrue: [ ^ self class basicNew
		x: x * other;
		y: y * other;
		z: z * other;
		w: w * other
	].
	^ self class
		r: (self r * other r) - (self i * other i) - (self j * other j) - (self k * other k)
		i: (self r * other i) + (self i * other r) + (self j * other k) - (self k * other j)
		j: (self r * other j) - (self i * other k) + (self j * other r) + (self k * other i)
		k: (self r * other k) + (self i * other j) - (self j * other i) + (self k * other r)
]

{ #category : #arithmetic }
Quaternion >> + other [
	other isNumber ifTrue: [
		^ self class basicNew
			x: x + other;
			y: y + other;
			z: z + other;
			w: w + other
	].

	^ self class basicNew
		x: x + other x;
		y: y + other y;
		z: z + other z;
		w: w + other w
]

{ #category : #arithmetic }
Quaternion >> - other [
	other isNumber ifTrue: [
		^ self class basicNew
			x: x - other;
			y: y - other;
			z: z - other;
			w: w - other
	].

	^ self class basicNew
		x: x - other x;
		y: y - other y;
		z: z - other z;
		w: w - other w
]

{ #category : #arithmetic }
Quaternion >> / other [
	other isNumber ifTrue: [ ^ self class basicNew
		x: x / other;
		y: y / other;
		z: z / other;
		w: w * other
	].
	^ self * other inverse
]

{ #category : #comparing }
Quaternion >> < other [
	^ self <=> other < 0
]

{ #category : #comparing }
Quaternion >> <= other [
	^ self <=> other <= 0
]

{ #category : #comparing }
Quaternion >> <=> other [
	x ~= other x ifTrue: [ ^ x <=> other x ].
	y ~= other y ifTrue: [ ^ y <=> other y ].
	z ~= other z ifTrue: [ ^ z <=> other z ].
	^ w <=> other w
]

{ #category : #comparing }
Quaternion >> = other [
	^ self class == other class and: [ x = other x and: [ y = other y and: [ z = other z and: [ w = other w ] ] ] ]
]

{ #category : #comparing }
Quaternion >> > other [
	^ self <=> other > 0
]

{ #category : #comparing }
Quaternion >> >= other [
	^ self <=> other >= 0
]

{ #category : #arithmetic }
Quaternion >> abs [
	^ self length2 sqrt
]

{ #category : #converting }
Quaternion >> asMatrix3x3 [
	| r i j k |
	r := self r.
	i := self i.
	j := self j.
	k := self k.
	^ Matrix3x3 rows: {
		1.0 - (2.0*j*j) - (2.0*k*k).
		(2.0*i*j) - (2.0*k*r).
		(2.0*i*k) + (2.0*j*r).

		(2.0*i*j) + (2.0*k*r).
		1.0 - (2.0*i*i) - (2.0*k*k).
		(2.0*j*k) - (2.0*i*r).

		(2.0*i*k) - (2.0*j*r).
		(2.0*j*k) + (2.0*i*r).
		1.0 - (2.0*i*i) - (2.0*j*j)
	}
]

{ #category : #converting }
Quaternion >> asQuaternion [
	^ self
]

{ #category : #converting }
Quaternion >> asVector4 [
	^ Vector4 x: x y: y z: z w: w
]

{ #category : #comparing }
Quaternion >> closeTo: other [
	^ (x closeTo: other x) and: [ (y closeTo: other y) and: [(z closeTo: other z) and: [ w closeTo: other w ]]]
]

{ #category : #comparing }
Quaternion >> closeTo: other precision: precision [
	^ (x closeTo: other x precision: precision) and: [
	(y closeTo: other y precision: precision) and: [
	(z closeTo: other z precision: precision) and: [
	w closeTo: other w precision: precision ]]]
]

{ #category : #arithmetic }
Quaternion >> conjugated [
	^ self class x: x negated y: y negated z: z negated w: w
]

{ #category : #arithmetic }
Quaternion >> dot: other [
	^ (x* other x) + (y * other y) + (z * other z) + (w * other w)
]

{ #category : #comparing }
Quaternion >> hash [
	^ ((x hash hashMultiply + y hash) hashMultiply + z hash) hashMultiply + w hash
]

{ #category : #accessing }
Quaternion >> i [
	^ x
]

{ #category : #accessing }
Quaternion >> i: i [
	x := i
]

{ #category : #arithmetic }
Quaternion >> inverse [
	| l2 |
	l2 := self length2.
	^ self class x: x negated / l2 y: y negated / l2 z: z negated / l2 w: w / l2
]

{ #category : #accessing }
Quaternion >> j [
	^ y
]

{ #category : #accessing }
Quaternion >> j: j [
	y := j
]

{ #category : #accessing }
Quaternion >> k [
	^ z
]

{ #category : #accessing }
Quaternion >> k: k [
	z := k
]

{ #category : #arithmetic }
Quaternion >> length [
	^ self length2 sqrt
]

{ #category : #arithmetic }
Quaternion >> length2 [
	^ self dot: self
]

{ #category : #arithmetic }
Quaternion >> negated [
	^ self class x: x negated y: y negated z: z negated w: w negated
]

{ #category : #accessing }
Quaternion >> r [
	^ w
]

{ #category : #accessing }
Quaternion >> r: r [
	w := r
]

{ #category : #accessing }
Quaternion >> w [

	^ w
]

{ #category : #accessing }
Quaternion >> w: anObject [

	w := anObject
]

{ #category : #accessing }
Quaternion >> x [

	^ x
]

{ #category : #accessing }
Quaternion >> x: anObject [

	x := anObject
]

{ #category : #accessing }
Quaternion >> xyzw [
	^ Vector4 x: x y: y z: z w: w
]

{ #category : #accessing }
Quaternion >> y [

	^ y
]

{ #category : #accessing }
Quaternion >> y: anObject [

	y := anObject
]

{ #category : #accessing }
Quaternion >> z [

	^ z
]

{ #category : #accessing }
Quaternion >> z: anObject [

	z := anObject
]

"
I describe a rotation in terms of successive X (pitch) Y (yaw) Z (roll) rotations.
"
Class {
	#name : #EulerAnglesZYX,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #'WodenMath-Core-Complex'
}

{ #category : #accessing }
EulerAnglesZYX >> asMatrix [
	^ Matrix3x3 zyxRotation: self
]

{ #category : #accessing }
EulerAnglesZYX >> asQuaternion [
	^ Quaternion zyxRotation: self
]

{ #category : #accessing }
EulerAnglesZYX >> pitch [
	^ x
]

{ #category : #accessing }
EulerAnglesZYX >> pitch: anAngle [
	x := anAngle
]

{ #category : #printing }
EulerAnglesZYX >> printOn: aStream [
	aStream nextPutAll: self class name;
		space; nextPutAll: ' x: '; print: x;
		space; nextPutAll: ' y: '; print: y;
		space; nextPutAll: ' z: '; print: z.
]

{ #category : #accessing }
EulerAnglesZYX >> roll [
	^ z
]

{ #category : #accessing }
EulerAnglesZYX >> roll: anAngle [
	z := anAngle
]

{ #category : #accessing }
EulerAnglesZYX >> x [

	^ x
]

{ #category : #accessing }
EulerAnglesZYX >> x: anObject [

	x := anObject
]

{ #category : #accessing }
EulerAnglesZYX >> y [

	^ y
]

{ #category : #accessing }
EulerAnglesZYX >> y: anObject [

	y := anObject
]

{ #category : #accessing }
EulerAnglesZYX >> yaw [
	^ y
]

{ #category : #accessing }
EulerAnglesZYX >> yaw: anAngle [
	y := anAngle
]

{ #category : #accessing }
EulerAnglesZYX >> z [

	^ z
]

{ #category : #accessing }
EulerAnglesZYX >> z: anObject [

	z := anObject
]

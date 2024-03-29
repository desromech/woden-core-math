"
I describe a rotation in terms of successive Z (roll) Y (yaw) X (pitch) rotations.
"
Class {
	#name : #EulerAnglesXYZ,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #'WodenMath-Core-Complex'
}

{ #category : #accessing }
EulerAnglesXYZ >> asMatrix [
	^ Matrix3x3 xyzRotation: self
]

{ #category : #accessing }
EulerAnglesXYZ >> asQuaternion [
	^ Quaternion xyzRotation: self
]

{ #category : #accessing }
EulerAnglesXYZ >> pitch [
	^ x
]

{ #category : #accessing }
EulerAnglesXYZ >> pitch: anAngle [
	x := anAngle
]

{ #category : #printing }
EulerAnglesXYZ >> printOn: aStream [
	aStream nextPutAll: self class name;
		space; nextPutAll: ' x: '; print: x;
		space; nextPutAll: ' y: '; print: y;
		space; nextPutAll: ' z: '; print: z.
]

{ #category : #accessing }
EulerAnglesXYZ >> roll [
	^ z
]

{ #category : #accessing }
EulerAnglesXYZ >> roll: anAngle [
	z := anAngle
]

{ #category : #accessing }
EulerAnglesXYZ >> x [

	^ x
]

{ #category : #accessing }
EulerAnglesXYZ >> x: anObject [

	x := anObject
]

{ #category : #accessing }
EulerAnglesXYZ >> y [

	^ y
]

{ #category : #accessing }
EulerAnglesXYZ >> y: anObject [

	y := anObject
]

{ #category : #accessing }
EulerAnglesXYZ >> yaw [
	^ y
]

{ #category : #accessing }
EulerAnglesXYZ >> yaw: anAngle [
	y := anAngle
]

{ #category : #accessing }
EulerAnglesXYZ >> z [

	^ z
]

{ #category : #accessing }
EulerAnglesXYZ >> z: anObject [

	z := anObject
]

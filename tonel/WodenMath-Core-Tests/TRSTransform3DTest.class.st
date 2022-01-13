"
A DecomposedTransform3DTest is a test class for testing the behavior of DecomposedTransform3D
"
Class {
	#name : #TRSTransform3DTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Transform'
}

{ #category : #tests }
TRSTransform3DTest >> testInverse [
	| transform |
	self assert: TRSTransform3D identity inverse equals: TRSTransform3D identity.
	self assert: (TRSTransform3D scale: (Vector3 x: 1 y: 2 z: 3)) inverse equals: (TRSTransform3D scale: (Vector3 x: 1 y: 1/2 z: 1/3)).
	
	transform := TRSTransform3D rotation: (Quaternion x: 1 y: 0 z: 0 w: 0).
	self assert: (transform transformTransform: transform inverse) equals: TRSTransform3D identity.
	transform := TRSTransform3D rotation: (Quaternion x: 0 y: 1 z: 0 w: 0).
	self assert: (transform transformTransform: transform inverse) equals: TRSTransform3D identity.
	transform := TRSTransform3D rotation: (Quaternion x: 0 y: 0 z: 1 w: 0).
	self assert: (transform transformTransform: transform inverse) equals: TRSTransform3D identity.

	transform := TRSTransform3D rotation: Quaternion lookAtBottom.
	self assert: (transform transformTransform: transform inverse) closeTo: TRSTransform3D identity.
	
	transform := TRSTransform3D new
		scale: (Vector3 x: 1 y: 2 z: 3);
		rotation: Quaternion lookAtBottom;
		translation: (Vector3 x: 1 y: 2 z: 3);
		yourself.
	self assert: (transform transformTransform: transform inverse) closeTo: TRSTransform3D identity.
]

{ #category : #tests }
TRSTransform3DTest >> testNew [
	| transform |
	transform := TRSTransform3D new.
	self assert: transform isIdentity.
	self assert: transform scale equals: Vector3 ones.
	self assert: transform rotation equals: Quaternion one.
	self assert: transform translation equals: Vector3 zeros.
]

{ #category : #tests }
TRSTransform3DTest >> testSetIdentity [
	| transform |
	transform := TRSTransform3D new setIdentity.
	self assert: transform isIdentity.
	self assert: transform scale equals: Vector3 ones.
	self assert: transform rotation equals: Quaternion one.
	self assert: transform translation equals: Vector3 zeros.
]

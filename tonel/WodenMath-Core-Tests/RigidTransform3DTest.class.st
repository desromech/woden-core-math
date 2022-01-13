Class {
	#name : #RigidTransform3DTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Transform'
}

{ #category : #tests }
RigidTransform3DTest >> testInverse [
	| transform |
	self assert: RigidTransform3D identity inverse equals: RigidTransform3D identity.
	
	transform := RigidTransform3D rotation: (Quaternion x: 1 y: 0 z: 0 w: 0).
	self assert: (transform transformTransform: transform inverse) equals: RigidTransform3D identity.
	transform := RigidTransform3D rotation: (Quaternion x: 0 y: 1 z: 0 w: 0).
	self assert: (transform transformTransform: transform inverse) equals: RigidTransform3D identity.
	transform := RigidTransform3D rotation: (Quaternion x: 0 y: 0 z: 1 w: 0).
	self assert: (transform transformTransform: transform inverse) equals: RigidTransform3D identity.

	transform := RigidTransform3D rotation: Quaternion lookAtBottom.
	self assert: (transform transformTransform: transform inverse) closeTo: RigidTransform3D identity.
]

{ #category : #tests }
RigidTransform3DTest >> testNew [
	| transform |
	transform := TRSTransform3D new.
	self assert: transform isIdentity.
	self assert: transform scale equals: Vector3 ones.
	self assert: transform rotation equals: Quaternion one.
	self assert: transform translation equals: Vector3 zeros.
]

{ #category : #tests }
RigidTransform3DTest >> testSetIdentity [
	| transform |
	transform := TRSTransform3D new setIdentity.
	self assert: transform isIdentity.
	self assert: transform scale equals: Vector3 ones.
	self assert: transform rotation equals: Quaternion one.
	self assert: transform translation equals: Vector3 zeros.
]

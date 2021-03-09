"
A ReversibleAffineTransform3dTest is a test class for testing the behavior of ReversibleAffineTransform3d
"
Class {
	#name : #ReversibleAffineTransform3dTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Transform'
}

{ #category : #tests }
ReversibleAffineTransform3dTest >> testIdentity [
	| transform |
	transform := ReversibleAffineTransform3d identity.
	self assert: transform matrix4 equals: Matrix4x4 identity.
	self assert: transform matrix equals: Matrix3x3 identity.
	self assert: transform translation equals: Vector3 zeros.

	self assert: transform inverseMatrix4 equals: Matrix4x4 identity.
	self assert: transform inverseMatrix equals: Matrix3x3 identity.
	self assert: transform inverseTranslation equals: Vector3 zeros.

	self assert: transform isIdentity.
]

{ #category : #tests }
ReversibleAffineTransform3dTest >> testSetIdentity [
	| transform |
	transform := ReversibleAffineTransform3d new setIdentity; yourself.
	self assert: transform matrix4 equals: Matrix4x4 identity.
	self assert: transform translation equals: Vector3 zeros.

	self assert: transform inverseMatrix4 equals: Matrix4x4 identity.
	self assert: transform inverseTranslation equals: Vector3 zeros.

	self assert: transform isIdentity.
]

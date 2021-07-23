"
A ReversibleAffineTransform3dTest is a test class for testing the behavior of ReversibleAffineTransform3d
"
Class {
	#name : #ReversibleAffineTransform3DTest,
	#superclass : #WodenMathTestCase,
	#category : #'WodenMath-Core-Tests-Transform'
}

{ #category : #tests }
ReversibleAffineTransform3DTest >> testIdentity [
	| transform |
	transform := ReversibleAffineTransform3D identity.
	self assert: transform matrix4 equals: Matrix4x4 identity.
	self assert: transform matrix equals: Matrix3x3 identity.
	self assert: transform translation equals: Vector3 zeros.

	self assert: transform inverseMatrix4 equals: Matrix4x4 identity.
	self assert: transform inverseMatrix equals: Matrix3x3 identity.
	self assert: transform inverseTranslation equals: Vector3 zeros.

	self assert: transform isIdentity.
]

{ #category : #tests }
ReversibleAffineTransform3DTest >> testSetIdentity [
	| transform |
	transform := ReversibleAffineTransform3D new setIdentity; yourself.
	self assert: transform matrix4 equals: Matrix4x4 identity.
	self assert: transform translation equals: Vector3 zeros.

	self assert: transform inverseMatrix4 equals: Matrix4x4 identity.
	self assert: transform inverseTranslation equals: Vector3 zeros.

	self assert: transform isIdentity.
]

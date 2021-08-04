"
A DecomposedTransform3DTest is a test class for testing the behavior of DecomposedTransform3D
"
Class {
	#name : #DecomposedTransform3DTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Transform'
}

{ #category : #tests }
DecomposedTransform3DTest >> testNew [
	| transform |
	transform := DecomposedTransform3D new.
	self assert: transform isIdentity.
	self assert: transform scale equals: Vector3 ones.
	self assert: transform rotation equals: Quaternion one.
	self assert: transform translation equals: Vector3 zeros.
]

{ #category : #tests }
DecomposedTransform3DTest >> testSetIdentity [
	| transform |
	transform := DecomposedTransform3D new setIdentity.
	self assert: transform isIdentity.
	self assert: transform scale equals: Vector3 ones.
	self assert: transform rotation equals: Quaternion one.
	self assert: transform translation equals: Vector3 zeros.
]

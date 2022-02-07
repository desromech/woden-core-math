"
A DecomposedTransform3DTest is a test class for testing the behavior of DecomposedTransform3D
"
Class {
	#name : #TRSTransform3DTest,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Transform'
}

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

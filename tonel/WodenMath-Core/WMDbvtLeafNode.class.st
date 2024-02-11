"
I am a leaf node in the dynamic bounding volume tree.
"
Class {
	#name : #WMDbvtLeafNode,
	#superclass : #WMDbvtAbstractNode,
	#instVars : [
		'parent',
		'boundingBox',
		'value'
	],
	#category : #'WodenMath-Core-DataStructures'
}

{ #category : #updating }
WMDbvtLeafNode >> balanceFactor [
	^ 0
]

{ #category : #accessing }
WMDbvtLeafNode >> boundingBox [

	^ boundingBox
]

{ #category : #accessing }
WMDbvtLeafNode >> boundingBox: anObject [

	boundingBox := anObject
]

{ #category : #accessing }
WMDbvtLeafNode >> height [
	^ 0
]

{ #category : #iteration }
WMDbvtLeafNode >> leavesIntersectingBox: boxToTest do: aBlock [
	(boundingBox hasIntersectionWithBox: boxToTest) ifFalse: [ ^ self ].

	aBlock value: self
]

{ #category : #iteration }
WMDbvtLeafNode >> leavesIntersectingRay: rayToTest do: aBlock [
	(boundingBox hasIntersectionWithRay: rayToTest) ifFalse: [ ^ self ].

	aBlock value: self
]

{ #category : #iteration }
WMDbvtLeafNode >> leavesIntersectingSphere: sphereToTest do: aBlock [
	(boundingBox hasIntersectionWithSphere: sphereToTest) ifFalse: [ ^ self ].

	aBlock value: self
]

{ #category : #accessing }
WMDbvtLeafNode >> parent [

	^ parent
]

{ #category : #accessing }
WMDbvtLeafNode >> parent: anObject [

	parent := anObject
]

{ #category : #updating }
WMDbvtLeafNode >> updateAndRebalanceBoundingBox: newBoundingBox [
	boundingBox := newBoundingBox.
	parent ifNil: [ ^ self ].
	
	^ parent updateAndRebalanceChildBoundingBox: self
]

{ #category : #accessing }
WMDbvtLeafNode >> value [
	^ value
]

{ #category : #accessing }
WMDbvtLeafNode >> value: anObject [

	value := anObject
]

"
I am an abstract dynamic bounding volume hierarchy tree node.
"
Class {
	#name : #WMDbvtAbstractNode,
	#superclass : #Object,
	#category : #'WodenMath-Core-DataStructures'
}

{ #category : #accessing }
WMDbvtAbstractNode >> boundingBox [
	^ self subclassResponsibility
]

{ #category : #accessing }
WMDbvtAbstractNode >> height [
	^ self subclassResponsibility
]

{ #category : #testing }
WMDbvtAbstractNode >> isInnerNode [
	^ false
]

{ #category : #iteration }
WMDbvtAbstractNode >> leavesIntersectingBox: boxToTest do: aBlock [
	self subclassResponsibility.
]

{ #category : #iteration }
WMDbvtAbstractNode >> leavesIntersectingFrustum: frustumToTest do: aBlock [
	self subclassResponsibility.
]

{ #category : #iteration }
WMDbvtAbstractNode >> leavesIntersectingRay: rayToTest do: aBlock [
	self subclassResponsibility.
]

{ #category : #iteration }
WMDbvtAbstractNode >> leavesIntersectingSphere: sphereToTest do: aBlock [
	self subclassResponsibility.
]

{ #category : #updating }
WMDbvtAbstractNode >> rebalanceBubblingUp [
	^ self
]

{ #category : #accessing }
WMDbvtAbstractNode >> root [
	^ self
]

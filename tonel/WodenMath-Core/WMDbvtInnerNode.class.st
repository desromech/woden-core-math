"
I am a dynamic bounding volume tree inner node.
"
Class {
	#name : #WMDbvtInnerNode,
	#superclass : #WMDbvtAbstractNode,
	#instVars : [
		'parent',
		'left',
		'right',
		'height',
		'boundingBox'
	],
	#category : #'WodenMath-Core-DataStructures'
}

{ #category : #accessing }
WMDbvtInnerNode >> boundingBox [

	^ boundingBox
]

{ #category : #accessing }
WMDbvtInnerNode >> boundingBox: anObject [

	boundingBox := anObject
]

{ #category : #accessing }
WMDbvtInnerNode >> height [

	^ height
]

{ #category : #accessing }
WMDbvtInnerNode >> height: anObject [

	height := anObject
]

{ #category : #iteration }
WMDbvtInnerNode >> leavesIntersectingBox: boxToTest do: aBlock [
	(boundingBox hasIntersectionWithBox: boxToTest) ifFalse: [ ^ self ].

	left leavesIntersectingBox: boxToTest do: aBlock.
	right leavesIntersectingBox: boxToTest do: aBlock.
]

{ #category : #iteration }
WMDbvtInnerNode >> leavesIntersectingRay: rayToTest do: aBlock [
	(boundingBox hasIntersectionWithRay: rayToTest) ifFalse: [ ^ self ].

	left leavesIntersectingRay: rayToTest do: aBlock.
	right leavesIntersectingRay: rayToTest do: aBlock.
]

{ #category : #iteration }
WMDbvtInnerNode >> leavesIntersectingSphere: sphereToTest do: aBlock [
	(boundingBox hasIntersectionWithSphere: sphereToTest) ifFalse: [ ^ self ].

	left leavesIntersectingSphere: sphereToTest do: aBlock.
	right leavesIntersectingSphere: sphereToTest do: aBlock.
]

{ #category : #accessing }
WMDbvtInnerNode >> left [

	^ left
]

{ #category : #accessing }
WMDbvtInnerNode >> left: anObject [

	left := anObject
]

{ #category : #accessing }
WMDbvtInnerNode >> parent [

	^ parent
]

{ #category : #accessing }
WMDbvtInnerNode >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
WMDbvtInnerNode >> right [

	^ right
]

{ #category : #accessing }
WMDbvtInnerNode >> right: anObject [

	right := anObject
]

{ #category : #accessing }
WMDbvtInnerNode >> root [
	^ parent ifNil: self ifNotNil: [ parent root ]
]

{ #category : #updating }
WMDbvtInnerNode >> updateAndRebalanceChildBoundingBox: child [
	(boundingBox includesBox: child boundingBox) ifTrue: [
		^ self root
	].

	boundingBox := left boundingBox unionWithBox: right boundingBox.
	^ parent
		ifNil: [ self ]
		ifNotNil: [ parent updateAndRebalanceChildBoundingBox: self ]
]

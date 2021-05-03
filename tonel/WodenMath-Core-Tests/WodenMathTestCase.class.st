Class {
	#name : #WodenMathTestCase,
	#superclass : #TestCase,
	#category : #'WodenMath-Core-Tests-Common'
}

{ #category : #testing }
WodenMathTestCase class >> isAbstract [
	^ self == WodenMathTestCase
]

{ #category : #asserting }
WodenMathTestCase >> assert: actualNumber notCloseTo: expectedNumber [
	^ self
		deny: (actualNumber closeTo: expectedNumber)
		description: [self comparingStringBetween: actualNumber and: expectedNumber]
]

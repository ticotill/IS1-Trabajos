!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'DB 10/5/2020 21:15:47'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinderByPrefix exampleSentences sentencesWithSamePrefix sentencesWithDifferentsPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'DB 10/7/2020 21:08:56'!
setUp

	sentenceFinderByPrefix := SentenceFinderByPrefix  new.
	sentencesWithSamePrefix := #('winter is coming' 'winning is everything' 'winds of Winter' 'winter is here' ).
	sentencesWithDifferentsPrefix := #('winter is coming' 'Winning is everything' 'The winds of Winter' 'winter is here' ).
	
	

	
	

	
! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'DB 10/7/2020 21:39:57'!
test01AddASentece
	
	sentenceFinderByPrefix add: 'Winter is here'.
	
	self assert: 1 = (sentenceFinderByPrefix sentences).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'DB 10/7/2020 22:10:07'!
test02AddMultipleSentences

	sentenceFinderByPrefix addSentences: sentencesWithDifferentsPrefix.
	
	self assert: (sentencesWithDifferentsPrefix size) = (sentenceFinderByPrefix sentences).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'DB 10/7/2020 21:30:51'!
test03PrefixCanNotBeEmpty

	|  aEmptyPrefix |
	aEmptyPrefix := ''.

	self
		should: [ sentenceFinderByPrefix find: aEmptyPrefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCanNotBeEmptyErrorMessage ]
	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'DB 10/7/2020 21:30:56'!
test04PrefixCanNotContainEmptySpaces

	| aPrefixWithEmptySpaces |
	aPrefixWithEmptySpaces := 'Winter is '.

	self
		should: [ sentenceFinderByPrefix find: aPrefixWithEmptySpaces ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCanNotContainEmptySpacesErrorMessage ]
	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'DB 10/7/2020 22:05:04'!
test05FinderReturnsOneSentence

	| aPrefix aSentenceToBeFound sentencesFound expected |

	aPrefix := 'The'.
	aSentenceToBeFound := 'The winds of Winter'.
	
	sentenceFinderByPrefix addSentences: sentencesWithDifferentsPrefix.
	
	sentencesFound := sentenceFinderByPrefix find: aPrefix.
	
	expected := OrderedCollection new.
	expected add: aSentenceToBeFound.

	self should: expected actual: sentencesFound.
	
	

	
	
	

	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'DB 10/7/2020 21:13:46'!
test06FinderReturnsEmptyWhenThereIsNoResult

	| aPrefix sentencesFound |

	aPrefix := 'Unfindable'.
	sentenceFinderByPrefix addSentences: sentencesWithDifferentsPrefix.
	sentencesFound := sentenceFinderByPrefix find: aPrefix.
	
	self assert: 0 equals: (sentencesFound size).
	

	
	

	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'DB 10/7/2020 22:06:04'!
test07AllSentencesAreMatches

	| aPrefix sentencesFound  |

	aPrefix := 'win'.
	sentenceFinderByPrefix addSentences: sentencesWithSamePrefix.
	
	sentencesFound := sentenceFinderByPrefix find: aPrefix.
	
	self should: sentencesWithSamePrefix actual: sentencesFound.
	
	
	
	
	

	
	

	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'DB 10/7/2020 22:06:47'!
test08ExecuteFinderMoreThanOneTime

	| aPrefix  sentencesFound  |
	aPrefix := 'win'.
	sentenceFinderByPrefix addSentences: sentencesWithSamePrefix .
	
	sentencesFound := sentenceFinderByPrefix find: aPrefix.
	
	self should: sentencesWithSamePrefix actual: sentencesFound.
	
	sentencesFound := sentenceFinderByPrefix find: aPrefix.
	
	self should: sentencesWithSamePrefix actual: sentencesFound.
	
	

	
	

	
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'DB 10/7/2020 22:07:54'!
test09FinderWithoutSentencesShouldReturnsEmptyResult

	| aPrefix sentencesFound  |

	aPrefix := 'win'.
	sentencesFound := sentenceFinderByPrefix find: aPrefix.
	
	self assert: sentencesFound isEmpty 	

	
	

	
! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'DB 10/7/2020 22:03:33'!
should: sentencesExpected actual: sentencesFound

	| size |
	size := (sentencesExpected size) + 1.
	self assert: (sentencesExpected size) equals: (sentencesFound size). 
	1 to: sentencesFound size do: [ :index |
		self assert: ((sentencesFound at: index) = (sentencesExpected at: size-index))
	]
	
	
	
	
	
	

	
	

	
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'head size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'DB 10/6/2020 20:40:51'!
initialize
	size := 0.
	head := OONullNode new.! !


!OOStack methodsFor: 'operations' stamp: 'DB 10/7/2020 20:27:10'!
pop

	| value |
	value := head pop.
	size := size - 1.	
	head := head next.
	^value
! !

!OOStack methodsFor: 'operations' stamp: 'DB 10/7/2020 20:26:17'!
push: aValue

	| newHead |
	newHead := OONotNullNode new with: aValue.
	head push: newHead.
	head := newHead.	
	size := size + 1.! !

!OOStack methodsFor: 'operations' stamp: 'DB 10/7/2020 20:27:18'!
size 

	^size.! !

!OOStack methodsFor: 'operations' stamp: 'DB 10/7/2020 20:27:21'!
top

	^head top! !


!OOStack methodsFor: 'results' stamp: 'DB 10/7/2020 20:27:26'!
isEmpty

	^size = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #OOStackNode category: #'Stack-Exercise'!
Object subclass: #OOStackNode
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNode methodsFor: 'accesing' stamp: 'DB 10/5/2020 17:38:14'!
next
	^next! !

!OOStackNode methodsFor: 'accesing' stamp: 'DB 10/5/2020 17:43:22'!
next: aNode
	next := aNode ! !


!OOStackNode methodsFor: 'initialization' stamp: 'DB 10/7/2020 20:24:48'!
with: aValue
	value := aValue.
! !


!OOStackNode methodsFor: 'operations' stamp: 'DB 10/6/2020 20:39:44'!
pop
	self subclassResponsibility ! !

!OOStackNode methodsFor: 'operations' stamp: 'DB 10/6/2020 20:39:41'!
push
	self subclassResponsibility ! !

!OOStackNode methodsFor: 'operations' stamp: 'DB 10/7/2020 20:23:09'!
value
	^value! !


!classDefinition: #OONotNullNode category: #'Stack-Exercise'!
OOStackNode subclass: #OONotNullNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONotNullNode methodsFor: 'operations' stamp: 'DB 10/7/2020 20:22:42'!
pop
	^value
	
		
	! !

!OONotNullNode methodsFor: 'operations' stamp: 'DB 10/5/2020 21:08:04'!
push: aNode

	aNode next: self! !

!OONotNullNode methodsFor: 'operations' stamp: 'DB 10/7/2020 20:22:49'!
top
	^value! !


!classDefinition: #OONullNode category: #'Stack-Exercise'!
OOStackNode subclass: #OONullNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONullNode methodsFor: 'operations' stamp: 'DB 10/5/2020 20:57:14'!
pop

	self error: OOStack stackEmptyErrorDescription.! !

!OONullNode methodsFor: 'operations' stamp: 'DB 10/5/2020 20:49:20'!
push: aNode
	
	aNode next: self.! !

!OONullNode methodsFor: 'operations' stamp: 'DB 10/5/2020 21:11:41'!
top

	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private operations' stamp: 'DB 10/7/2020 10:48:54'!
restoreStackFrom: aBackup

	[aBackup isEmpty] whileFalse: [
		stack push: (aBackup pop)
	]
	
	

! !

!SentenceFinderByPrefix methodsFor: 'private operations' stamp: 'DB 10/7/2020 22:12:31'!
save: aData in: aBackup

	aBackup push: aData
	
	

! !

!SentenceFinderByPrefix methodsFor: 'private operations' stamp: 'DB 10/7/2020 21:30:08'!
validatePrefix: aPrefix

	aPrefix isEmpty ifTrue: [self error: self class prefixCanNotBeEmptyErrorMessage ].
	((aPrefix findString: ' ') = 0) ifFalse: [self error: self class prefixCanNotContainEmptySpacesErrorMessage ].! !


!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'DB 10/6/2020 20:03:21'!
sentences
	^stack size! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'DB 10/5/2020 21:23:10'!
add: aSentence

	stack push: aSentence! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'DB 10/7/2020 22:14:10'!
addSentences: theSentences

	theSentences do: [:each | self add: each].! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'DB 10/7/2020 21:30:30'!
find: aPrefix

	| sentence backup answer  |	
	
	self validatePrefix: aPrefix.

	backup := OOStack new.
	answer := OrderedCollection new.
	
	[stack isEmpty] whileFalse: [
		sentence := stack pop.
		(sentence beginsWith: aPrefix) ifTrue: [answer add: sentence].
		self save: sentence in: backup
	].

	self restoreStackFrom: backup.

	^answer 

	
	

! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'DB 10/5/2020 21:23:33'!
initialize

	stack := OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'DB 10/7/2020 21:29:30'!
prefixCanNotBeEmptyErrorMessage
	^'prefix cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'DB 10/7/2020 21:29:36'!
prefixCanNotContainEmptySpacesErrorMessage
	^'prefix can not contain empty spaces'! !

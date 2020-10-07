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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:04:41'!
test01AddASentece

	| aSentence  finder |
	aSentence := 'Winter is here'.
	
	finder := SentenceFinderByPrefix  new.
	finder add: aSentence.
	
	self assert: 1 = (finder sentences).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:07:42'!
test02AddMultipleSentences

	| finder aSentences |
	aSentences := #('winter is coming' 'winning is everything' 'The winds of Winter' 'Winter is here' ).
	
	finder := SentenceFinderByPrefix  new.
	finder addSentences: aSentences.
	
	self assert: 4 = (finder sentences).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:19:02'!
test03PrefixCanNotBeEmpty

	| aSentence aPrefix finder |
	aSentence := 'Winter is here'.
	aPrefix := ''.
	
	finder := SentenceFinderByPrefix  new.
	finder add: aSentence.

	self
		should: [ finder find: aPrefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCanNotBeEmpty]
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:19:19'!
test04PrefixCanNotContainEmptySpaces

	| aPrefix finder |

	aPrefix := 'Winter is'.
	
	finder := SentenceFinderByPrefix  new.

	self
		should: [ finder find: aPrefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCanNotContainEmptySpaces]
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:19:38'!
test05FinderReturnOneSentence

	| aPrefix finder aSentence sentencesFound |

	aPrefix := 'Wint'.
	aSentence := 'Winter is here'.
	
	finder := SentenceFinderByPrefix  new.
	finder add: aSentence.
	
	sentencesFound := finder find: aPrefix .
	
	self assert: 1 equals: (sentencesFound size).
	self assert: (aSentence = (sentencesFound at: 1))
	

	
	

	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:29:53'!
test06FinderReturnsEmptyWhenThereIsNoResult

	| aPrefix finder sentencesFound sentences |

	aPrefix := 'Unfindable'.
	sentences := #('winter is coming' 'winning is everything' 'winds of Winter' 'winter is here' ).
	
	finder := SentenceFinderByPrefix  new.
	finder addSentences: sentences.
	
	sentencesFound := finder find: aPrefix.
	
	self assert: 0 equals: (sentencesFound size).
	

	
	

	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:45:21'!
test07AllSentencesAreMatches

	| aPrefix finder sentencesFound  sentences |

	aPrefix := 'win'.
	sentences := #('winter is coming' 'winning is everything' 'winds of Winter' 'winter is here' ).
	
	finder := SentenceFinderByPrefix  new.
	finder addSentences: sentences.
	
	sentencesFound := finder find: aPrefix.
	
	self assert: 4 equals: (sentencesFound size). 
	1 to: sentencesFound size do: [ :index |
		self assert: ((sentencesFound at: index) = (sentences at: 5-index))
	]
	
	
	
	
	
	

	
	

	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:31:37'!
test08FinderReturnsUniqueResultWhenThereIsMoreThanOneSentence

	| aPrefix finder aSentenceToBeFound sentencesFound sentences |

	aPrefix := 'Wint'.
	aSentenceToBeFound := 'Winter is here'.
	
	sentences := #('winter is coming' 'winning is everything' 'winds of Winter' 'Winter is here' ).
	
	finder := SentenceFinderByPrefix  new.
	finder addSentences: sentences.
	
	sentencesFound := finder find: aPrefix .
	
	self assert: 1 equals: (sentencesFound size).
	self assert: (aSentenceToBeFound = (sentencesFound at: 1))
	

	
	

	
! !


!classDefinition: #OONode category: #'Stack-Exercise'!
Object subclass: #OONode
	instanceVariableNames: 'data next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONode methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:52:38'!
data
	^data! !

!OONode methodsFor: 'as yet unclassified' stamp: 'DB 10/5/2020 17:38:14'!
next
	^next! !

!OONode methodsFor: 'as yet unclassified' stamp: 'DB 10/5/2020 17:43:22'!
next: aNode
	next := aNode ! !

!OONode methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:39:44'!
pop
	self subclassResponsibility ! !

!OONode methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:39:41'!
push
	self subclassResponsibility ! !

!OONode methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:53:04'!
with: aData
	data := aData.
! !


!classDefinition: #OONotNullNode category: #'Stack-Exercise'!
OONode subclass: #OONotNullNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONotNullNode methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:53:11'!
pop
	^data
	
		
	! !

!OONotNullNode methodsFor: 'as yet unclassified' stamp: 'DB 10/5/2020 21:08:04'!
push: aNode

	aNode next: self! !

!OONotNullNode methodsFor: 'as yet unclassified' stamp: 'DB 10/6/2020 20:53:18'!
top
	^data! !


!classDefinition: #OONullNode category: #'Stack-Exercise'!
OONode subclass: #OONullNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONullNode methodsFor: 'as yet unclassified' stamp: 'DB 10/5/2020 20:57:14'!
pop

	self error: OOStack stackEmptyErrorDescription.! !

!OONullNode methodsFor: 'as yet unclassified' stamp: 'DB 10/5/2020 20:49:20'!
push: aNode
	
	aNode next: self.! !

!OONullNode methodsFor: 'as yet unclassified' stamp: 'DB 10/5/2020 21:11:41'!
top

	self error: OOStack stackEmptyErrorDescription.! !


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


!OOStack methodsFor: 'operations' stamp: 'DB 10/6/2020 20:54:05'!
pop
	| data |
	data := head pop.
	size := size - 1.	
	head := head next.
	^data
! !

!OOStack methodsFor: 'operations' stamp: 'DB 10/6/2020 20:54:41'!
push: aData

	| newHead |
	newHead := OONotNullNode new with: aData.
	
	head push: newHead.
	head := newHead.	
	size := size + 1.! !

!OOStack methodsFor: 'operations' stamp: 'DB 10/5/2020 17:48:29'!
size 
	^size.! !

!OOStack methodsFor: 'operations' stamp: 'DB 10/5/2020 21:16:54'!
top
	^head top! !


!OOStack methodsFor: 'results' stamp: 'DB 10/4/2020 22:10:12'!
isEmpty
	^size = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'DB 10/5/2020 21:23:10'!
add: aSentence

	stack push: aSentence! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'DB 10/6/2020 20:02:30'!
addSentences: aSentences

	aSentences do: [:each | self add: each].! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'DB 10/6/2020 20:37:07'!
find: aPrefix

	| sentence cache withAPrefix  |
	
	aPrefix isEmpty ifTrue: [self error: self class prefixCanNotBeEmpty].
	((aPrefix findString: ' ') = 0) ifFalse: [self error: self class prefixCanNotContainEmptySpaces].
	
	cache := OOStack new.
	withAPrefix := OrderedCollection new.
	
	[stack isEmpty] whileFalse: [
		sentence := stack pop.
		(sentence beginsWith: aPrefix) ifTrue: [withAPrefix  add: sentence].
		cache push: sentence.
	].

	[cache isEmpty] whileFalse: [
		stack push: (cache pop).
	].

	^withAPrefix 

	
	

! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'DB 10/6/2020 20:03:21'!
sentences
	^stack size! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'DB 10/5/2020 21:23:33'!
initialize

	stack := OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'DB 10/5/2020 21:33:13'!
prefixCanNotBeEmpty
	^'prefix can not be empty'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'DB 10/5/2020 21:42:11'!
prefixCanNotContainEmptySpaces
	^'prefix can not contain empty spaces'! !

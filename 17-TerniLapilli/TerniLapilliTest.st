!classDefinition: #TerniLapilliTest category: 'TerniLapilliTest'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliTest'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:27:44'!
test01assertOnStartItsPlayerXTurn
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	self assert: newTerniLapilliGame  isEmpty.
	self assert: newTerniLapilliGame isPlayingX.
	self deny: newTerniLapilliGame isPlayingO.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:31:14'!
test02assertAfterXTurnGoesO
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	self assert: newTerniLapilliGame isPlayingO.
	self deny: newTerniLapilliGame isPlayingX.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:31:21'!
test03assertPlayerCantPutChipIfItIsntItsTurn
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	
	self   should: [newTerniLapilliGame putOAt: (1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorInvalidMoveNotYourTurn .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:31:30'!
test04assertPlayerCantPutChipOnAnOccupiedSlot
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	self   should: [newTerniLapilliGame putOAt: (1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorInvalidMoveCantPutChipOnOccupiedSlot .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:31:45'!
test05assertPlayerCantPutChipWhenAllChipsHaveBeenPut
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (1@2).
	newTerniLapilliGame putXAt: (1@3).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (2@3).
	self   should: [newTerniLapilliGame putXAt: (3@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorInvalidMoveCantPutChipWhenAllChipsHaveBeenPut.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:30:55'!
test06assertAfterGameIsOverThereIsAWinner
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@2).
	newTerniLapilliGame putXAt: (1@2).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (1@3).
	self assert: newTerniLapilliGame isOver.
	
	self   should: [newTerniLapilliGame putOAt: (2@3).] 
		 raise: Error 
		 withMessageText: TerniLapilli errorInvalidMoveCantPutChipWhenGameIsOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:36:47'!
test06assertPlayerXWonHorizontally
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@2).
	newTerniLapilliGame putXAt: (1@2).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (1@3).
	self assert: newTerniLapilliGame hasPlayerXWon .
	
	"self   should: [newTerniLapilliGame putOAt: (2@3).] 
		 raise: Error 
		 withMessageText: TerniLapilli errorInvalidMoveCantPutChipWhenGameIsOver."! !


!classDefinition: #TerniLapilli category: 'TerniLapilliTest'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentTurn chipsX chipsO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliTest'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:23:24'!
hasPlayerOWon
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:37:44'!
hasPlayerXWon
	
		! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:01:50'!
initialize
	currentTurn := #X.
	board:= OrderedCollection  new.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:03:46'!
isBoardFull

	^board size  = 6! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 18:25:56'!
isPlayingO
	^currentTurn = #O! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 18:26:18'!
isPlayingX
	^currentTurn = #X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:40:08'!
putOAt: aPoint 
	
	self isBoardFull ifTrue:[^self class signalErrorInvalidMoveCantPutChipWhenAllChipsHaveBeenPut ].
	self isPlayingX ifTrue: [^	self class signalErrorInvalidMoveNotYourTurn ].
	((chipsX includes: aPoint )or: (chipsO includes: aPoint)) ifTrue: 	[^self class signalErrorInvalidMoveCantPutChipOnOccupiedSlot ].
	chipsO add: aPoint.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:41:09'!
putXAt: aPoint 
	
	currentTurn := #O.
	self isBoardFull ifTrue:[^self class signalErrorInvalidMoveCantPutChipWhenAllChipsHaveBeenPut ].
	((chipsX includes: aPoint )or: (chipsO includes: aPoint)) ifTrue: [^self class signalErrorInvalidMoveCantPutChipOnOccupiedSlot ].
	chipsX add: aPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilliTest'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 18:45:21'!
errorInvalidMoveCantPutChipOnOccupiedSlot
	^'Cant put chip in an occupied slot'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:00:45'!
errorInvalidMoveCantPutChipWhenAllChipsHaveBeenPut

	^'All 6 chips have been put on the board'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:19:03'!
errorInvalidMoveCantPutChipWhenGameIsOver

	^'Cant put chip because the game is already over'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 18:36:31'!
errorInvalidMoveNotYourTurn

	^'It must be your turn to be able to put down a chip'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 18:44:56'!
signalErrorInvalidMoveCantPutChipOnOccupiedSlot

	self error: self errorInvalidMoveCantPutChipOnOccupiedSlot .! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:00:16'!
signalErrorInvalidMoveCantPutChipWhenAllChipsHaveBeenPut

	self error: self errorInvalidMoveCantPutChipWhenAllChipsHaveBeenPut.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:18:37'!
signalErrorInvalidMoveCantPutChipWhenGameIsOver

	self error: self errorInvalidMoveCantPutChipWhenGameIsOver .! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 18:40:19'!
signalErrorInvalidMoveNotYourTurn

	self error: self errorInvalidMoveNotYourTurn .! !

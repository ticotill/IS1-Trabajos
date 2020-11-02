!classDefinition: #TerniLapilliTest category: 'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 23:51:40'!
test01assertOnStartItsPlayerXTurn
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	self assert: newTerniLapilliGame isEmpty.
	self assert: newTerniLapilliGame isPlayingX.
	self deny: newTerniLapilliGame isPlayingO.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:31:14'!
test02assertAfterXTurnGoesO
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	self assert: newTerniLapilliGame isPlayingO.
	self deny: newTerniLapilliGame isPlayingX.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 10/29/2020 20:39:23'!
test03assertPlayerOCantPutChipIfItIsntItsTurn
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	
	self   should: [newTerniLapilliGame putOAt: (1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorInvalidMoveNotYourTurn .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 10/29/2020 20:50:41'!
test04assertPlayerOCantPutChipOnAnOccupiedSlot
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	self   should: [newTerniLapilliGame putOAt: (1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorInvalidMoveCantPutChipOnOccupiedSlot .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 19:28:08'!
test05CantPutChipOutOfBound
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	
	self should: [newTerniLapilliGame putXAt: (3@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveOrPutChipOutOfBounds .
		
	self should: [newTerniLapilliGame putXAt: (-1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveOrPutChipOutOfBounds.
		
	self should: [newTerniLapilliGame putXAt: (0@3)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveOrPutChipOutOfBounds.
		
	self should: [newTerniLapilliGame putXAt: (1@-1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveOrPutChipOutOfBounds.
		! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 23:27:12'!
test06assertPlayerXCantPutChipWhenAllChipsHaveBeenPut
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (1@2).
	newTerniLapilliGame putXAt: (0@2).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (0@1).
	self   should: [newTerniLapilliGame putXAt: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantPutIfInMovingPhase .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 23:27:32'!
test07assertPlayerOCantPutChipWhenAllChipsHaveBeenPut
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (1@2).
	newTerniLapilliGame putXAt: (0@2).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (0@1).

	self   should: [newTerniLapilliGame putOAt: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantPutIfInMovingPhase .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 18:10:05'!
test08assertPlayerXCantPutChipIfItIsntItsTurn
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	
	newTerniLapilliGame putXAt: (2@1).
	
	self   should: [newTerniLapilliGame putXAt: (1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorInvalidMoveNotYourTurn .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 18:12:01'!
test09assertPlayerXCantPutChipOnAnOccupiedSlot
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@0).
	newTerniLapilliGame putOAt: (1@1).
	self   should: [newTerniLapilliGame putXAt: (1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorInvalidMoveCantPutChipOnOccupiedSlot .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 18:23:23'!
test10assertCantMoveMoreThanOnePositionAtATime
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (1@2).
	newTerniLapilliGame putXAt: (0@2).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (0@0).
	self   should: [newTerniLapilliGame move: (0@0) to: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveMoreThanOnePositionAtATime.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 20:28:36'!
test11assertCantDoInvalidDiagonalMovement
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (0@2).
	"(0@1) no me puedo mover para (1@0) o (1@2)"
	self   should: [newTerniLapilliGame move: (0@1) to: (1@2)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantDoInvalidDiagonalMovement.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 19:41:26'!
test12assertCantMoveAnEmptyPosition
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (0@2).
	
	self   should: [newTerniLapilliGame move: (1@0) to: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveAnEmptyPosition.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 20:45:14'!
test13assertCantMoveOutOfBounds
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (0@2).
	
	self   should: [newTerniLapilliGame move: (0@2) to: (-1@2)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveOrPutChipOutOfBounds.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 20:45:30'!
test14OCantPutChipOutOfBound
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	
	self should: [newTerniLapilliGame putOAt: (3@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveOrPutChipOutOfBounds.
		
	self should: [newTerniLapilliGame putOAt: (-1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveOrPutChipOutOfBounds.
		
	self should: [newTerniLapilliGame putOAt: (0@3)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveOrPutChipOutOfBounds.
		
	self should: [newTerniLapilliGame putOAt: (1@-1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantMoveOrPutChipOutOfBounds.
		! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 20:46:53'!
test15CantMoveIfIsNotYourTurn
	
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (0@2).
	
	self   should: [newTerniLapilliGame move: (2@1) to: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorInvalidMoveNotYourTurn.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 01:49:22'!
test16CantMoveIfNotAllChipHaveBeenPutDown
	
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@1).
	
	self assert: newTerniLapilliGame isPuttingPhase.
	
	self   should: [newTerniLapilliGame move: (1@1) to: (2@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantPutIfInMovingPhase .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 23:11:04'!
test17InMovementPhasePlayerXStartsThenItIsPlayerOTurn
	
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (0@2).
	
	newTerniLapilliGame move: (1@1) to: (1@2).
	
	self assert: newTerniLapilliGame isPlayingO.
	
	newTerniLapilliGame move: (0@0) to: (1@0).
	
	self assert: newTerniLapilliGame isPlayingX.
	
	
	
	
	 ! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 21:18:34'!
test18assertCorrectVerticalAndHorizontalMovementAsWellAsCorrectlyPassingTurn
	
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (0@2).
	
	newTerniLapilliGame move: (1@1) to: (1@2).
	
	self assert: (newTerniLapilliGame chipXIsInPosition: (1@2)).
	self assert: (newTerniLapilliGame isAnEmptyPosition: (1@1)).
	self assert: newTerniLapilliGame isPlayingO.
	
	newTerniLapilliGame move: (0@0) to: (1@0).
	
	self assert: (newTerniLapilliGame chipOIsInPosition: (1@0)).
	self assert: (newTerniLapilliGame isAnEmptyPosition: (0@0)).
	self assert: newTerniLapilliGame isPlayingX.
	
	
	
	
	 ! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 21:20:02'!
test19assertPlayerXWonHorizontally
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@0).
	newTerniLapilliGame putOAt: (1@2).
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (0@2).
	self assert: (newTerniLapilliGame hasPlayerXWon).
	self deny: newTerniLapilliGame hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 21:24:39'!
test20assertPlayerOWonHorizontally
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@0).
	newTerniLapilliGame putOAt: (1@1).
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (1@0).
	newTerniLapilliGame putXAt: (2@0).
	newTerniLapilliGame putOAt: (1@2).	
	
	self assert: newTerniLapilliGame hasPlayerOWon.
	self deny: newTerniLapilliGame hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 21:39:08'!
test21CantWinHorizontalWithLessThanThreeChips
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@0).
	newTerniLapilliGame putOAt: (1@1).
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (1@0).
	
	self deny: newTerniLapilliGame hasPlayerOWon.
	self deny: newTerniLapilliGame hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 21:47:08'!
test22CantWinVerticalWithLessThanThreeChips
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@0).
	newTerniLapilliGame putOAt: (1@1).
	newTerniLapilliGame putXAt: (1@0).
	newTerniLapilliGame putOAt: (2@0).
	
	self deny: newTerniLapilliGame hasPlayerOWon.
	self deny: newTerniLapilliGame hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 21:47:01'!
test23assertPlayerXWonVertically
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@0).
	newTerniLapilliGame putOAt: (1@2).
	newTerniLapilliGame putXAt: (1@0).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@0).
	self assert: (newTerniLapilliGame hasPlayerXWon).
	self deny: newTerniLapilliGame hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 21:46:52'!
test24assertPlayerOWonVertically
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@2).
	newTerniLapilliGame putOAt: (1@0).
	newTerniLapilliGame putXAt: (2@1).
	newTerniLapilliGame putOAt: (2@0).
	self assert: (newTerniLapilliGame hasPlayerOWon).
	self deny: newTerniLapilliGame hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 22:14:33'!
test25XWinsDiagonally
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (2@0).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (1@0).
	newTerniLapilliGame putXAt: (0@2).
	self assert: (newTerniLapilliGame hasPlayerXWon).
	self deny: newTerniLapilliGame hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 22:16:19'!
test26OWinsDiagonally
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (2@0).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (2@1).
	newTerniLapilliGame putOAt: (1@1).
	newTerniLapilliGame putXAt: (0@2).
	newTerniLapilliGame putOAt: (2@2).
	self assert: (newTerniLapilliGame hasPlayerOWon).
	self deny: newTerniLapilliGame hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 22:35:47'!
test27GameDoesNotContinueAfterWinningInPutingPhase
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (2@0).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (2@1).
	newTerniLapilliGame putOAt: (1@1).
	newTerniLapilliGame putXAt: (2@2).
	
	self   should: [newTerniLapilliGame putOAt: (1@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorGameOver.
	
	self assert: (newTerniLapilliGame hasPlayerXWon).
	self deny: newTerniLapilliGame hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 23:17:59'!
test28CantPutWhileMovingPhase
	
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@2).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@2).
	
	newTerniLapilliGame move: (1@1) to: (1@0).
	
	self assert: newTerniLapilliGame isMovingPhase.
			
	self   should: [newTerniLapilliGame putOAt: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli errorCantPutIfInMovingPhase.
		
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 01:18:26'!
test29AfterMovingWin
	
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (2@0).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@2).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@2).
	
	self assert: newTerniLapilliGame isMovingPhase.
	
	newTerniLapilliGame move: (2@0) to: (1@0).
	
	self assert: newTerniLapilliGame isGameOver.
! !


!classDefinition: #TerniLapilli category: 'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentTurn chipsX chipsO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'movement' stamp: 'DB 11/1/2020 23:08:47'!
move: aSourcePoint to: aDestinationPoint
	
	self validateMovementFrom: aSourcePoint to: aDestinationPoint.
	
	self moveAndChangeTurnFrom: aSourcePoint to: aDestinationPoint.

	
	
	
	! !

!TerniLapilli methodsFor: 'movement' stamp: 'DB 11/2/2020 01:38:49'!
moveAndChangeTurnFrom: aSourcePoint to: aDestinationPoint

	currentTurn = #X ifTrue: [
		chipsX remove: aSourcePoint.
		chipsX add: aDestinationPoint.
		currentTurn := #O
	]
	 ifFalse: [
		chipsO remove: aSourcePoint.
		chipsO add: aDestinationPoint.
		currentTurn := #X
	].


	
	
	
	! !

!TerniLapilli methodsFor: 'movement' stamp: 'DB 11/2/2020 01:30:10'!
putOAt: aPoint 
	
	self assertPositionAndState: aPoint.
	
	self isPlayingX ifTrue: [^	self class signalErrorInvalidMoveNotYourTurn ].
	chipsO add: aPoint.
	
	currentTurn := #X.
	
	! !

!TerniLapilli methodsFor: 'movement' stamp: 'DB 11/2/2020 01:30:16'!
putXAt: aPoint 
	
	self assertPositionAndState: aPoint.
	
	self isPlayingO ifTrue: [^self class signalErrorInvalidMoveNotYourTurn ].
	chipsX add: aPoint.
	
	currentTurn := #O.! !


!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/2/2020 01:49:06'!
assertBoardFull
	self isBoardFull ifFalse: [^self class signalCantPutIfInMovingPhase ].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/1/2020 23:02:45'!
assertCorrectTurn: aSourcePoint 

	(chipsX includes: aSourcePoint) ifTrue: [
		currentTurn = #X ifFalse: [^self class signalInvalidMoveNotYourTurn ]	
	].

	(chipsO includes: aSourcePoint) ifTrue: [
		currentTurn = #O ifFalse: [^self class signalInvalidMoveNotYourTurn ]	
	].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/1/2020 23:56:11'!
assertInBounds: aPoint 

	((aPoint x < 0) or: (aPoint y < 0) or: (aPoint x > 2) or: (aPoint y > 2)) ifTrue: [^self class signalCantMoveOrPutChipOutOfBounds ].
	
	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/1/2020 23:00:28'!
assertLengthOfMovementFrom: aSourcePoint to: aDestinationPoint 
	((aSourcePoint x - aDestinationPoint x) abs) > 1 ifTrue: [^self class signalCantMoveMoreThanOnePositionAtATime.].
	((aSourcePoint y - aDestinationPoint y) abs) > 1 ifTrue: [^self class signalCantMoveMoreThanOnePositionAtATime.].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/1/2020 23:04:34'!
assertNotEmptyPosition: aPoint 
	(self isAnEmptyPosition: aPoint)  ifTrue: [^self class signalCantMoveAnEmptyPosition].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/2/2020 01:29:59'!
assertPositionAndState: aPoint 
	
	self state assertPut: aPoint.
	
	self assertInBounds: aPoint.
	
	(self isAnEmptyPosition: aPoint) ifFalse: 	[^self class signalErrorInvalidMoveCantPutChipOnOccupiedSlot ].
	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/1/2020 22:50:10'!
checkDiagonalMovementFrom: aSourcePoint to: aDestinationPoint

	"(0@1) no me puedo mover para (1@0) o (1@2)"
	aSourcePoint = (0@1) ifTrue: [
		(aDestinationPoint = (1@0) or:aDestinationPoint = (1@2)) ifTrue: [^self class signalCantDoInvalidDiagonalMovement.]
	].

	"(1@0) no me puedo mover para (0@1) o (2@1)"
	aSourcePoint =(1@0) ifTrue: [
		(aDestinationPoint = (0@1) or:aDestinationPoint = (2@1)) ifTrue: [^self class signalCantDoInvalidDiagonalMovement.]
	].

	"(1@2) no me puedo mover para (0@1) o (2@1)  "
	aSourcePoint = (1@2) ifTrue: [
		(aDestinationPoint = (0@1)  or:aDestinationPoint = (2@1)) ifTrue: [^self class signalCantDoInvalidDiagonalMovement.]
	].

	"(2@1) no me puedo mover en la (1@2) o (1@0)  "
	aSourcePoint = (2@1) ifTrue: [
		(aDestinationPoint =(1@2) or:aDestinationPoint = (1@0)) ifTrue: [^self class signalCantDoInvalidDiagonalMovement.]
	].

	
	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/2/2020 01:53:13'!
validateMovementFrom: aSourcePoint to: aDestinationPoint
	
	self assertBoardFull.
	
	self assertLengthOfMovementFrom: aSourcePoint to: aDestinationPoint .
	
	self assertInBounds: aDestinationPoint.	
	
	self assertNotEmptyPosition: aSourcePoint.
	
	self assertCorrectTurn: aSourcePoint.
	
	self checkDiagonalMovementFrom: aSourcePoint to: aDestinationPoint.
	
	

	
	
	
	! !


!TerniLapilli methodsFor: 'initialization' stamp: 'DB 11/2/2020 00:43:59'!
initialize
	currentTurn := #X.
	chipsX := OrderedCollection new.
	chipsO := OrderedCollection new.
	state := TerniLapilliPuttingPhase for: self! !


!TerniLapilli methodsFor: 'phases' stamp: 'DB 11/2/2020 00:14:13'!
isGameOver
	^(self hasPlayerOWon) or: (self hasPlayerXWon)! !

!TerniLapilli methodsFor: 'phases' stamp: 'DB 11/2/2020 01:33:04'!
isMovingPhase
	 ^(self hasPlayerOWon not) and: (self hasPlayerXWon not) and: (self isBoardFull)! !

!TerniLapilli methodsFor: 'phases' stamp: 'DB 11/2/2020 01:33:15'!
isPuttingPhase
	^(self hasPlayerOWon not) and: (self hasPlayerXWon not) and: ((chipsX size) + (chipsO size) < 6)! !

!TerniLapilli methodsFor: 'phases' stamp: 'DB 11/2/2020 01:29:18'!
state
	^TerniLapilliPhase stateFor: self
! !


!TerniLapilli methodsFor: 'testing' stamp: 'DB 11/1/2020 21:03:56'!
chipOIsInPosition: aPosition

	^chipsO includes: aPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'DB 11/1/2020 21:03:47'!
chipXIsInPosition: aPosition

	^chipsX includes: aPosition.! !


!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 22:12:18'!
hasPlayerOWon
	^(self wonHorizontal: chipsO) or: (self wonVertical: chipsO) or: (self wonDiagonal: chipsO)! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 21:51:39'!
hasPlayerXWon
	^(self wonHorizontal: chipsX) or: (self wonVertical: chipsX) or: (self wonDiagonal: chipsX)
	
		! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 21:55:33'!
wonDiagonal: Positions
	^(self wonFallingDiagonal: Positions) or: (self wonUpwardsDiagonal: Positions ).! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 22:11:28'!
wonFallingDiagonal: Positions

	| fallingDiagonal |
	fallingDiagonal := OrderedCollection with: (0@0) with: (1@1) with: (2@2).

	^Positions includesAllOf: fallingDiagonal.
	! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 21:38:39'!
wonHorizontal: positions
	^(positions size = 3) and: (positions allSatisfy: [:aPosition | (aPosition x) = ((positions first) x)]).
	
	
	! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 22:13:34'!
wonUpwardsDiagonal: Positions
 
	| upwardsDiagonal |
	upwardsDiagonal := OrderedCollection with: (2@0) with: (1@1) with: (0@2).
	
	^Positions includesAllOf: upwardsDiagonal .! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 21:46:33'!
wonVertical: positions

	^(positions size = 3) and: (positions allSatisfy: [:aPosition | (aPosition y) = ((positions first) y)]).
	
	! !


!TerniLapilli methodsFor: 'comparing' stamp: 'DB 11/1/2020 21:14:18'!
isAnEmptyPosition: aPoint 
	^ ((chipsX includes: aPoint) or: (chipsO includes: aPoint)) not
! !

!TerniLapilli methodsFor: 'comparing' stamp: 'DB 11/1/2020 20:44:37'!
isBoardFull

	^(chipsX size = 3) and: (chipsO size = 3)! !

!TerniLapilli methodsFor: 'comparing' stamp: 'DB 10/29/2020 20:28:51'!
isEmpty
	^(chipsX isEmpty) and: (chipsO isEmpty)! !

!TerniLapilli methodsFor: 'comparing' stamp: 'ad 10/29/2020 18:25:56'!
isPlayingO
	^currentTurn = #O! !

!TerniLapilli methodsFor: 'comparing' stamp: 'ad 10/29/2020 18:26:18'!
isPlayingX
	^currentTurn = #X.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 18:45:33'!
errorCantDoInvalidDiagonalMovement
	^'You cant do invalidad diagonal movement'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 19:41:57'!
errorCantMoveAnEmptyPosition
	^'You cant move an empty position'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 18:24:56'!
errorCantMoveMoreThanOnePositionAtATime
	^'You cant move more than one position at a time'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 19:26:20'!
errorCantMoveOrPutChipOutOfBounds
	^'You cant move or put a chip out of bounds'
! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 23:21:35'!
errorCantPutIfInMovingPhase
	^'you cant put if in Moving phase'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 22:36:49'!
errorGameOver
	^'Cant continue playing because the game is over!!!!!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 18:45:21'!
errorInvalidMoveCantPutChipOnOccupiedSlot
	^'Cant put chip in an occupied slot'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:19:03'!
errorInvalidMoveCantPutChipWhenGameIsOver

	^'Cant put chip because the game is already over'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 19:49:38'!
errorInvalidMoveNotYourTurn

	^'It must be your turn to be able to move or put down a chip'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 18:46:12'!
signalCantDoInvalidDiagonalMovement

	self error: self errorCantDoInvalidDiagonalMovement.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 19:42:07'!
signalCantMoveAnEmptyPosition

	self error: self errorCantMoveAnEmptyPosition.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 18:32:40'!
signalCantMoveMoreThanOnePositionAtATime

	self error: self errorCantMoveMoreThanOnePositionAtATime.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 19:26:36'!
signalCantMoveOrPutChipOutOfBounds

	self error: self 	errorCantMoveOrPutChipOutOfBounds.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 23:26:40'!
signalCantPutIfInMovingPhase

	self error: self errorCantPutIfInMovingPhase .! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 18:44:56'!
signalErrorInvalidMoveCantPutChipOnOccupiedSlot

	self error: self errorInvalidMoveCantPutChipOnOccupiedSlot .! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 19:18:37'!
signalErrorInvalidMoveCantPutChipWhenGameIsOver

	self error: self errorInvalidMoveCantPutChipWhenGameIsOver .! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ad 10/29/2020 18:40:19'!
signalErrorInvalidMoveNotYourTurn

	self error: self errorInvalidMoveNotYourTurn .! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 22:37:35'!
signalGameOver

	self error: self errorGameOver.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'DB 11/1/2020 20:33:54'!
signalInvalidMoveNotYourTurn

	self error: self errorInvalidMoveNotYourTurn ! !



!classDefinition: #TerniLapilliPhase category: 'Terni Lapilli'!
Object subclass: #TerniLapilliPhase
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:35:30'!
assertPut: aPosition

	self subclassResponsibility ! !

!TerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:06:14'!
initializeFor: aTerniLapilliGame
	terniLapilliGame := aTerniLapilliGame 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPhase class' category: 'Terni Lapilli'!
TerniLapilliPhase class
	instanceVariableNames: ''!

!TerniLapilliPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:03:19'!
canHandle: aTerniLapilliGame
	self subclassResponsibility ! !

!TerniLapilliPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:03:44'!
for: aTerniLapilliGame
	^self new initializeFor: aTerniLapilliGame ! !

!TerniLapilliPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:04:57'!
stateFor: aTerniLapilliGame
	^(self subclasses detect: [:aTerniLapilliPhaseClass | aTerniLapilliPhaseClass canHandle: aTerniLapilliGame ]) for: aTerniLapilliGame.! !


!classDefinition: #TerniLapilliGameOverPhase category: 'Terni Lapilli'!
TerniLapilliPhase subclass: #TerniLapilliGameOverPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameOverPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:35:44'!
assertPut: aPosition
	^terniLapilliGame class signalGameOver ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameOverPhase class' category: 'Terni Lapilli'!
TerniLapilliGameOverPhase class
	instanceVariableNames: ''!

!TerniLapilliGameOverPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:07:17'!
canHandle: aTerniLapilliGame
	^aTerniLapilliGame isGameOver ! !


!classDefinition: #TerniLapilliMovingPhase category: 'Terni Lapilli'!
TerniLapilliPhase subclass: #TerniLapilliMovingPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliMovingPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 01:11:56'!
assertPut: aPosition
	^terniLapilliGame class signalCantPutIfInMovingPhase 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliMovingPhase class' category: 'Terni Lapilli'!
TerniLapilliMovingPhase class
	instanceVariableNames: ''!

!TerniLapilliMovingPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:08:00'!
canHandle: aTerniLapilliGame
	^aTerniLapilliGame isMovingPhase ! !


!classDefinition: #TerniLapilliPuttingPhase category: 'Terni Lapilli'!
TerniLapilliPhase subclass: #TerniLapilliPuttingPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPuttingPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 01:07:41'!
assertPut: aPosition
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPuttingPhase class' category: 'Terni Lapilli'!
TerniLapilliPuttingPhase class
	instanceVariableNames: ''!

!TerniLapilliPuttingPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:08:15'!
canHandle: aTerniLapilliGame
	^aTerniLapilliGame isPuttingPhase ! !


!classDefinition: #TerniLapilliPlayer category: 'Terni Lapilli'!
Object subclass: #TerniLapilliPlayer
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!


!classDefinition: #TerniLapilliPlayerO category: 'Terni Lapilli'!
TerniLapilliPlayer subclass: #TerniLapilliPlayerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!


!classDefinition: #TerniLapilliPlayerX category: 'Terni Lapilli'!
TerniLapilliPlayer subclass: #TerniLapilliPlayerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

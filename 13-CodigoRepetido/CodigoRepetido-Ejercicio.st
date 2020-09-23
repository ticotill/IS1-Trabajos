!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'performance' stamp: 'DB 9/23/2020 20:00:26'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook  |
	
	customerBook := CustomerBook new.
	
	self canBeExecuteThis: [ customerBook addCustomerNamed: 'Jonh Lennon'.]  lessThan: 50*millisecond 

	
! !

!CustomerBookTest methodsFor: 'performance' stamp: 'DB 9/23/2020 19:59:57'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook  paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.

	self canBeExecuteThis:[customerBook removeCustomerNamed: paulMcCartney.]  lessThan: 100*millisecond 
	
! !


!CustomerBookTest methodsFor: 'Invalid instance checker' stamp: 'DB 9/23/2020 19:54:58'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''. 
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'Invalid instance checker' stamp: 'DB 9/23/2020 19:55:43'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'Invalid instance checker' stamp: 'DB 9/23/2020 20:07:45'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.

	self isSuspendedIn: customerBook customer: 'George Harrison' include:  johnLennon.! !

!CustomerBookTest methodsFor: 'Invalid instance checker' stamp: 'DB 9/23/2020 20:03:55'!
test08CanNotSuspendAnAlreadySuspendedCustomer

	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
		
	self addAndSuspend: customerBook customer: johnLennon.
	
	self isSuspendedIn: customerBook customer: johnLennon include: johnLennon.
! !


!CustomerBookTest methodsFor: 'helper methods' stamp: 'DB 9/21/2020 18:50:15'!
addAndSuspend: aCustomerBook customer: aCustomer
	
	aCustomerBook addCustomerNamed: aCustomer.
	aCustomerBook suspendCustomerNamed: aCustomer.
	
	

! !

!CustomerBookTest methodsFor: 'helper methods' stamp: 'DB 9/18/2020 18:53:56'!
canBeExecuteThis: aBlock lessThan: aLimit
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aLimit
	
! !

!CustomerBookTest methodsFor: 'helper methods' stamp: 'DB 9/21/2020 18:41:55'!
checkEqualSize: aCustomerBook numberOfSuspended: suspended numberOfCustomers: customers
	
	self assert: 0               equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspended equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: customers  equals: aCustomerBook numberOfCustomers.
	
	

! !

!CustomerBookTest methodsFor: 'helper methods' stamp: 'DB 9/21/2020 20:03:27'!
isSuspendedIn: aCustomerBook customer: aCustomer include: aCustomerInclude

	[ aCustomerBook suspendCustomerNamed: aCustomer.
	self fail ]
		on: CantSuspend 
		do: [ self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: aCustomerInclude) ]! !


!CustomerBookTest methodsFor: 'suspending' stamp: 'DB 9/23/2020 20:02:59'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspend: customerBook customer: paulMcCartney.	
	
	self checkEqualSize: customerBook numberOfSuspended: 1 numberOfCustomers: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	
	
	

	
! !

!CustomerBookTest methodsFor: 'suspending' stamp: 'DB 9/23/2020 20:03:17'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	self addAndSuspend: customerBook customer: paulMcCartney.	

	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkEqualSize: customerBook numberOfSuspended: 0 numberOfCustomers: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'numbers' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'numbers' stamp: 'DB 9/23/2020 20:10:31'!
numberOfCustomers
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers
	! !

!CustomerBook methodsFor: 'numbers' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'signals' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signals' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'customer management' stamp: 'DB 9/21/2020 19:08:15'!
addCustomerNamed: aCustomerName

	aCustomerName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	
	(self includesCustomerNamed: aCustomerName)  ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aCustomerName! !

!CustomerBook methodsFor: 'customer management' stamp: 'DB 9/21/2020 19:05:38'!
removeCustomerNamed: aCustomerName

	[ ^self remove: aCustomerName from: active ]
		on: NotFound 
		do: [ ^self remove: aCustomerName from: suspended ]

! !

!CustomerBook methodsFor: 'customer management' stamp: 'DB 9/23/2020 20:14:58'!
suspendCustomerNamed: aCustomerName 
	
	(active includes: aCustomerName) ifFalse: [^CantSuspend signal].
	
	active remove: aCustomerName.
	
	suspended add: aCustomerName
! !


!CustomerBook methodsFor: 'helper methods' stamp: 'DB 9/21/2020 19:06:37'!
remove: aCustomerName from: aCollection
 
	1 to: aCollection size do: 
	[ :index |
		aCustomerName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ aCustomerName 
			] 
	].

	^ NotFound signal.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !

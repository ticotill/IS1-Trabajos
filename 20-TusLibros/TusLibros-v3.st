!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InternalApiTest category: 'TusLibros'!
TestCase subclass: #InternalApiTest
	instanceVariableNames: 'testObjectFactory authenticatedClients merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalApiTest methodsFor: 'doubles methods' stamp: 'db 11/30/2020 23:30:24'!
authenticate: aClientID withPassword: aPassword

	| password |
	[password := authenticatedClients at: aClientID] on: Error do: [:anError | ^false].
	^password = aPassword .! !


!InternalApiTest methodsFor: 'setUp/tearDown' stamp: 'db 12/1/2020 01:34:55'!
setUp

	testObjectFactory := StoreTestObjectsFactory new.
	
	authenticatedClients := Dictionary new.
	authenticatedClients at: testObjectFactory defaultClientID put: testObjectFactory defaultPassword.
	
	merchantProcessor := MerchantProcessorSimulator new.! !



!InternalApiTest methodsFor: 'testing' stamp: 'db 12/1/2020 01:35:13'!
test01CannotCreateACartWithAnInvalidUserID

	| apiCaller |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog.

	self 
		should: [apiCaller 
			createCartFor: testObjectFactory invalidClientID  
			withPassword: testObjectFactory invalidPassword.] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [:anError | 
			self assert: anError messageText = InternalApi nonAuthenticatedClientErrorDescription ]
	! !

!InternalApiTest methodsFor: 'testing' stamp: 'db 12/1/2020 01:35:17'!
test02CannotCreateACartWithAnInvalidPassword

	| apiCaller |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog.

	self 
		should: [apiCaller 
			createCartFor: testObjectFactory defaultClientID  
			withPassword: testObjectFactory invalidPassword.] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [:anError | 
			self assert: anError messageText = InternalApi nonAuthenticatedClientErrorDescription ]
	! !

!InternalApiTest methodsFor: 'testing' stamp: 'db 12/1/2020 01:35:25'!
test03NewCartsAreCreatedEmpty

	| apiCaller cartID |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword .
	
	self assert: (apiCaller listCart: cartID) isEmpty.
	
	! !

!InternalApiTest methodsFor: 'testing' stamp: 'db 12/1/2020 01:35:29'!
test04AfterRequestingToAddAnItemTheCartIsNotEmptyAnymore

|	 apiCaller cartID items |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword .
	
	apiCaller add: 2 to: cartID of: testObjectFactory itemSellByTheStore .
	items := apiCaller listCart: cartID.
	
	self deny: items isEmpty.
	self assert: items includes: testObjectFactory itemSellByTheStore.! !

!InternalApiTest methodsFor: 'testing' stamp: 'db 12/1/2020 01:35:32'!
test05CannotAddItemsToAnInvalidCartID

	| apiCaller |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog.
	
	self 
		should: [apiCaller add: 4 to: testObjectFactory invalidCartID of: testObjectFactory itemSellByTheStore ] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [:anError | 
			self assert: anError messageText = InternalApi cartNotFoundErrorDescription]
	! !

!InternalApiTest methodsFor: 'testing' stamp: 'db 12/1/2020 01:35:35'!
test06CannotCheckoutACartWithAnInvalidCartID

	| apiCaller |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog.
	
	self 
		should: [apiCaller 
			checkout: testObjectFactory invalidCartID 
			withCreditCardNumber: testObjectFactory defaultCreditCardNumber
			andCreditCardExpirationDate: testObjectFactory notExpiredDate
			andCreditCardOwner: testObjectFactory defaultCreditCardOwner] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [:anError | 
			self assert: anError messageText = InternalApi cartNotFoundErrorDescription]
	! !

!InternalApiTest methodsFor: 'testing' stamp: 'db 12/1/2020 01:35:38'!
test07AfterSucessfulCheckoutThePurchaseIsSaved

	| apiCaller cartID |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword.
	
	apiCaller add: 5 to: cartID of: testObjectFactory itemSellByTheStore.
	
	apiCaller 
		checkout: cartID 
		withCreditCardNumber: testObjectFactory defaultCreditCardNumber 
		andCreditCardExpirationDate: testObjectFactory notExpiredDate
		andCreditCardOwner: testObjectFactory defaultCreditCardOwner.
	
	self deny: (apiCaller listPurchasesOf: testObjectFactory defaultClientID) isEmpty 
	
	! !


!classDefinition: #UserInterfaceTest category: 'TusLibros'!
TestCase subclass: #UserInterfaceTest
	instanceVariableNames: 'testObjectsFactory validUsers aValidClientID aValidPassword debitBehavior today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!UserInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'db 11/29/2020 13:31:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	
	validUsers := Dictionary new.

	validUsers at: testObjectsFactory defaultClientID put: testObjectsFactory defaultPassword .
	
	debitBehavior := [ :anAmount :aCreditCard | ]
	
	! !


!UserInterfaceTest methodsFor: 'simulators' stamp: 'db 11/29/2020 13:30:39'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!UserInterfaceTest methodsFor: 'simulators' stamp: 'db 11/30/2020 18:18:48'!
today

	^today! !

!UserInterfaceTest methodsFor: 'simulators' stamp: 'db 11/29/2020 11:58:30'!
validate: anUser password: aPassword

	|  validPassword |

	[validPassword := validUsers at: anUser] on: Error do: [:anError | ^false].
	
	^validPassword = aPassword ! !


!UserInterfaceTest methodsFor: 'time limit testing' stamp: 'db 11/30/2020 23:32:19'!
test10CannotAddToCartToAnExpiredCart

	| ui cartID todaySimulator |
	
	todaySimulator := DateSimulator new.
	todaySimulator now: GregorianDateTime now. 
	
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: todaySimulator.
	
	cartID := ui createCartFor: testObjectsFactory defaultClientID withPassword:  testObjectsFactory defaultPassword.
	
	todaySimulator now: ( (todaySimulator now) next: (TimeUnits minute with: 35) ).
	
	self 
	should: [ui addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 5.] raise: Error - MessageNotUnderstood
	 withExceptionDo: 
		[:anError | self assert: anError messageText = UserInterface operationOnExpiredCartErrorDescription.].
	
	" 10:00    10:05    "
	"   |----------|--------------------------------------------------|"
	
	
	
	
	
! !

!UserInterfaceTest methodsFor: 'time limit testing' stamp: 'db 11/30/2020 23:32:27'!
test11CannotListCartToAnExpiredCart

	| ui cartID todaySimulator |
	
	todaySimulator := DateSimulator new.
	todaySimulator now: GregorianDateTime now. 
	
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: todaySimulator.
	
	cartID := ui createCartFor: testObjectsFactory defaultClientID withPassword:  testObjectsFactory defaultPassword.
	
	todaySimulator now: ( (todaySimulator now) next: (TimeUnits minute with: 35) ).
	
	
	self 
	should: [ui listCart: cartID.] raise: Error - MessageNotUnderstood
	 withExceptionDo: 
		[:anError | self assert: anError messageText = UserInterface operationOnExpiredCartErrorDescription.].
	
	" 10:00    10:05    "
	"   |----------|--------------------------------------------------|"
	
	
	
	
	
! !

!UserInterfaceTest methodsFor: 'time limit testing' stamp: 'db 11/30/2020 23:32:35'!
test12CannotCheckoutToAnExpiredCart

	| ui cartID todaySimulator creditCard |
	
	todaySimulator := DateSimulator new.
	todaySimulator now: GregorianDateTime now. 
	creditCard := testObjectsFactory notExpiredCreditCard.
	
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: todaySimulator.
	
	cartID := ui createCartFor: testObjectsFactory defaultClientID withPassword:  testObjectsFactory defaultPassword.
	
	ui addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 5.
	
	todaySimulator now: ( (todaySimulator now) next: (TimeUnits minute with: 35) ).
	
	self 
	should: [ ui checkout: cartID charging: creditCard.] raise: Error - MessageNotUnderstood
	 withExceptionDo: 
		[:anError | self assert: anError messageText = UserInterface operationOnExpiredCartErrorDescription.].
	
	" 10:00    10:05    "
	"   |----------|--------------------------------------------------|"
	
	
	
	
	
! !


!UserInterfaceTest methodsFor: 'testing' stamp: 'db 11/30/2020 18:47:36'!
test01CannotCreateACartWithAnInvalidUserID

	| ui aClientID aPassword |
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: timeService .
	
	aClientID := 'qwerty3'.
	aPassword := '123oweE'.
	
	self 
	should: [ui createCartFor: aClientID withPassword: aPassword] raise: Error - MessageNotUnderstood
	 withExceptionDo: 
		[
		:anError | 
		self assert: anError messageText = UserInterface invalidClientErrorMessage.]! !

!UserInterfaceTest methodsFor: 'testing' stamp: 'db 11/30/2020 18:47:36'!
test02CannotCreateACartWithAnInvalidPassword

	| ui aClientID aPassword |
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: timeService .
	aClientID := 'qwerty'.
	aPassword := '123owrE'.
	
	self 
	should: [ ui createCartFor: aClientID withPassword: aPassword ] raise: Error - MessageNotUnderstood
	 withExceptionDo: 
		[
		:anError | 
		self assert: anError messageText = UserInterface invalidClientErrorMessage.]
	! !

!UserInterfaceTest methodsFor: 'testing' stamp: 'db 11/30/2020 18:47:36'!
test03NewCartsAreCreatedEmpty

	| ui cartID items |
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: timeService.

	cartID := ui createCartFor: testObjectsFactory defaultClientID withPassword:  testObjectsFactory defaultPassword .
	
	items := ui listCart: cartID.
	
	self assert: 0 equals: items size.! !

!UserInterfaceTest methodsFor: 'testing' stamp: 'db 11/30/2020 18:47:36'!
test04AfterRequestingToAddAnItemTheCartIsNotEmptyAnymore

	| ui cartID items |
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: timeService.

	cartID := ui createCartFor: testObjectsFactory defaultClientID withPassword:  testObjectsFactory defaultPassword .

	ui addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 1. 
	
	items := ui listCart: cartID.
	
	self assert: 1 equals: items size.
	self assert: testObjectsFactory itemSellByTheStore equals: (items at: 1).! !

!UserInterfaceTest methodsFor: 'testing' stamp: 'db 11/30/2020 18:47:36'!
test05AfterRequestingToAddMoreThanOneItemTheCartDisplaysTheCorrectAmountOfItems

	| ui cartID items |
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: timeService .
	"Pasar el merchant processor y el authenticator..."

	cartID := ui createCartFor: testObjectsFactory defaultClientID withPassword:  testObjectsFactory defaultPassword .

	ui addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 3. 
	
	items := ui listCart: cartID.
	
	self assert: 3 equals: items size.
	self assert: testObjectsFactory itemSellByTheStore equals: (items at: 1).! !

!UserInterfaceTest methodsFor: 'testing' stamp: 'db 11/30/2020 18:47:36'!
test06

	| ui cartID creditCard transactionID purchases |
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: timeService.
	creditCard := testObjectsFactory notExpiredCreditCard.

	cartID := ui createCartFor: testObjectsFactory defaultClientID withPassword:  testObjectsFactory defaultPassword.
	ui addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 5.
	
	transactionID := ui checkout: cartID charging: creditCard.
	
	purchases := ui listPurchases: testObjectsFactory defaultClientID password: testObjectsFactory defaultPassword.
	
	

! !

!UserInterfaceTest methodsFor: 'testing' stamp: 'db 11/30/2020 18:47:36'!
test06Many

	| ui cartID creditCard transactionID purchases |
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: timeService.
	creditCard := testObjectsFactory notExpiredCreditCard.

	cartID := ui createCartFor: testObjectsFactory defaultClientID withPassword:  testObjectsFactory defaultPassword.
	ui addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 5.
	
	transactionID := ui checkout: cartID charging: creditCard.
	
	
	cartID := ui createCartFor: testObjectsFactory defaultClientID withPassword:  testObjectsFactory defaultPassword.
	ui addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 5.
	transactionID := ui checkout: cartID charging: creditCard.
	
	
	purchases := ui listPurchases: testObjectsFactory defaultClientID password: testObjectsFactory defaultPassword.
	
	

! !

!UserInterfaceTest methodsFor: 'testing' stamp: 'db 11/30/2020 18:47:36'!
test06One

	| ui cartID creditCard transactionID purchases |
	ui := UserInterface with: self catalog: testObjectsFactory defaultCatalog throught: self on: testObjectsFactory today timeService: timeService.
	creditCard := testObjectsFactory notExpiredCreditCard.

	cartID := ui createCartFor: testObjectsFactory defaultClientID withPassword:  testObjectsFactory defaultPassword.
	ui addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 5.
	
	transactionID := ui checkout: cartID charging: creditCard.
	
	purchases := ui listPurchases: testObjectsFactory defaultClientID password: testObjectsFactory defaultPassword.
	
	
	"cardID:1 --> 0|ISBN_1|QUANTITY_1|ISBN_2|QUANTITY_2|....|ISBN_N|QUANTITY_N"
	"cardID:2 --> 0|ISBN_1|QUANTITY_1|ISBN_2|QUANTITY_2|....|ISBN_N|QUANTITY_N"
	"cardID:3 --> 0|ISBN_1|QUANTITY_1|ISBN_2|QUANTITY_2|....|ISBN_N|QUANTITY_N"
	
	"key: clientID value: ordercollection: carts"
	
	"listPurchase (clientID) -> " 
	

! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'db 11/29/2020 12:29:45'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'db 11/29/2020 12:23:35'!
items

	^ items! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartContainer category: 'TusLibros'!
Object subclass: #CartContainer
	instanceVariableNames: 'cart clientID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartContainer methodsFor: 'initialization' stamp: 'db 12/1/2020 01:30:12'!
cartStored
	^cart ! !

!CartContainer methodsFor: 'initialization' stamp: 'db 12/1/2020 01:15:13'!
clientAssociated
	^clientID ! !

!CartContainer methodsFor: 'initialization' stamp: 'db 12/1/2020 01:30:23'!
initializeWith: aCart associatedTo: aClientID
	clientID := aClientID.
	cart := aCart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartContainer class' category: 'TusLibros'!
CartContainer class
	instanceVariableNames: ''!

!CartContainer class methodsFor: 'as yet unclassified' stamp: 'db 12/1/2020 01:11:18'!
with: aCart associatedTo: aClientID
	^CartContainer new initializeWith: aCart associatedTo: aClientID.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #DateSimulator category: 'TusLibros'!
Object subclass: #DateSimulator
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!DateSimulator methodsFor: 'as yet unclassified' stamp: 'db 11/30/2020 19:59:14'!
now
	^now! !

!DateSimulator methodsFor: 'as yet unclassified' stamp: 'db 11/30/2020 19:59:30'!
now: aDate
	now := aDate ! !


!classDefinition: #InternalApi category: 'TusLibros'!
Object subclass: #InternalApi
	instanceVariableNames: 'authenticator merchantProcessor catalog carts sequence salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalApi methodsFor: 'initialization' stamp: 'db 12/1/2020 01:13:21'!
initializeWithAuthenticator: anAuthenticator throught: aMerchantProcessor withCatalog: aCatalog  
	authenticator := anAuthenticator.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor. 
	sequence := 1.
	carts := Dictionary new.
	salesBook := Dictionary new.! !


!InternalApi methodsFor: 'privates' stamp: 'db 11/30/2020 23:48:32'!
nextID
	sequence := sequence +1.
	^sequence.! !


!InternalApi methodsFor: 'interface' stamp: 'db 12/1/2020 01:31:04'!
add: aQuantity to: aCartID of: anItem
	
	| cartContainer |
	
	cartContainer := carts at: aCartID ifAbsent: [self class signalCartNotFound ].
	
	cartContainer cartStored add: aQuantity of: anItem.
	
	 
! !

!InternalApi methodsFor: 'interface' stamp: 'db 12/1/2020 01:31:43'!
checkout: aCartID withCreditCardNumber: aCCN andCreditCardExpirationDate: aCCED andCreditCardOwner: aCCO 
	
	| cartContiner clientID clientSalesBook creditCard cashier |
	cartContiner := carts at: aCartID ifAbsent: [self class signalCartNotFound ].
	clientID := cartContiner clientAssociated.
	clientSalesBook := salesBook at:	 clientID ifAbsent: [clientSalesBook := OrderedCollection new.].
	
	creditCard := CreditCard expiringOn: aCCED. 
	
	cashier := Cashier 
		toCheckout: cartContiner cartStored 
		charging: creditCard
		throught: merchantProcessor 
		on: Date today
		registeringOn: clientSalesBook.
		
	cashier checkOut.
		
	

	salesBook at: clientID put: clientSalesBook.
	"Lasy initialization para el salesbook"
		
	
	"Create a cashier"
	
	"Necesito la asociacion entre carrito y clientID"
	! !

!InternalApi methodsFor: 'interface' stamp: 'db 12/1/2020 01:12:46'!
createCartFor: aClientID withPassword: aPassword

	| cart cartID |
	(authenticator authenticate: aClientID withPassword: aPassword) ifFalse: [self class signalNonAuthenticatedClient].	
	
	" Duda: un cliente puede tener más de un carrito activo? "
	cart := Cart acceptingItemsOf: catalog.
	cartID := self nextID.
	carts at: cartID put: (CartContainer with: cart associatedTo: aClientID) .
	
	"Guardo el cart en el dictionary de salesbook"
	
	
	^cartID.! !

!InternalApi methodsFor: 'interface' stamp: 'db 12/1/2020 01:30:12'!
listCart: aCartID 
	| cartContiner |
	cartContiner := carts at: aCartID ifAbsent: [self class signalCartNotFound ].
	
	^cartContiner cartStored items asBag.! !

!InternalApi methodsFor: 'interface' stamp: 'db 12/1/2020 00:58:20'!
listPurchasesOf: aClientID 
	^salesBook at: aClientID ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalApi class' category: 'TusLibros'!
InternalApi class
	instanceVariableNames: ''!

!InternalApi class methodsFor: 'instance creation' stamp: 'db 12/1/2020 00:45:39'!
withAuthenticator: anAuthenticator throught: aMerchantProcessor withCatalog: aCatalog  
	
	^self new initializeWithAuthenticator: anAuthenticator throught: aMerchantProcessor withCatalog: aCatalog.! !


!InternalApi class methodsFor: 'error messages' stamp: 'db 12/1/2020 00:11:05'!
cartNotFoundErrorDescription
	^'cartID not found'! !

!InternalApi class methodsFor: 'error messages' stamp: 'db 11/30/2020 22:32:22'!
nonAuthenticatedClientErrorDescription
	^'Non authenticated client'! !


!InternalApi class methodsFor: 'signals' stamp: 'db 12/1/2020 00:13:37'!
signalCartNotFound
	
	^self error: self cartNotFoundErrorDescription ! !

!InternalApi class methodsFor: 'signals' stamp: 'db 11/30/2020 22:32:03'!
signalNonAuthenticatedClient
	
	^self error: self nonAuthenticatedClientErrorDescription! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'db 12/1/2020 01:33:11'!
debit: anAmount from: aCreditCard 

	self subclassResponsibility ! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessor subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'db 12/1/2020 01:33:16'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'db 12/1/2020 01:34:05'!
initialize
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'client items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'client' stamp: 'db 11/26/2020 20:57:28'!
defaultClientID
	^1
	
	! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'db 11/26/2020 20:58:14'!
defaultPassword
	^'miviejamula'
	
	! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'db 11/30/2020 23:19:35'!
invalidClientID
	^Object new.
	
	! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'db 11/30/2020 23:19:45'!
invalidPassword
	^Object new.
	
	! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'db 12/1/2020 00:10:21'!
invalidCartID
	
	^Object new.! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'db 12/1/2020 00:29:54'!
defaultCreditCardNumber
	
	^'454678977878789'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'db 12/1/2020 00:30:58'!
defaultCreditCardOwner
	
	^'milhouse'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'db 12/1/2020 00:52:50'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredDate ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'db 12/1/2020 00:30:29'!
notExpiredDate
	
	^(Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #UserInterface category: 'TusLibros'!
Object subclass: #UserInterface
	instanceVariableNames: 'authenticator carts catalog salesBook merchantProcessor cashier today clock maxTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!UserInterface methodsFor: 'private' stamp: 'db 11/30/2020 19:25:18'!
cart: aCartContainer
	^aCartContainer at: 1! !

!UserInterface methodsFor: 'private' stamp: 'db 11/30/2020 19:40:18'!
isExpired: aCartID
	^(self activeDuration: aCartID) > maxTime.
! !

!UserInterface methodsFor: 'private' stamp: 'db 11/30/2020 19:24:47'!
lastTimeMarkOf: aCartContainer
	^aCartContainer at: 2! !

!UserInterface methodsFor: 'private' stamp: 'db 11/30/2020 19:58:48'!
markLastUsed: aCartID

	| cartContainer |
	cartContainer := carts at: aCartID.
	(cartContainer at: 2 put: clock now).
	! !


!UserInterface methodsFor: 'operations' stamp: 'db 11/30/2020 20:07:44'!
activeDuration: aCartID

	| cartContainer |
	cartContainer := carts at: aCartID.
	
	^ ((self lastTimeMarkOf: cartContainer) distanceTo: clock now) convertTo: minute.
! !

!UserInterface methodsFor: 'operations' stamp: 'db 11/30/2020 19:42:14'!
addToCart: aCartID item: anItem quantity: aQuantity 

	| cartContainer |
	cartContainer := carts at: aCartID.
	
	self assertExpiredCart: aCartID .
	self markLastUsed: aCartID.
	
.	(cartContainer at: 1) add: aQuantity of: anItem.
	! !

!UserInterface methodsFor: 'operations' stamp: 'db 11/29/2020 14:01:51'!
checkout: aCartID charging: aCreditCard 
	
	| cart  |
	cart := carts at: aCartID.
	
	cashier := Cashier 
		toCheckout: cart 
		charging: aCreditCard
		throught: merchantProcessor 
		on:  today
		registeringOn: salesBook.
		
	cashier checkOut.
	
	^1
	
	
	! !

!UserInterface methodsFor: 'operations' stamp: 'db 11/30/2020 19:57:50'!
createCartFor: aClientID withPassword: aPassword 

	| cart |
	(authenticator validate: aClientID password: aPassword) ifFalse: [^self class signalInvalidClient ].
	" Duda: un cliente puede tener más de un carrito? "
	cart := Cart acceptingItemsOf: catalog.
	carts at: 1 put: (Array with: cart with: clock now).
	
	"salesBook at: aClientID put: cart."
	^1
	
	
	! !

!UserInterface methodsFor: 'operations' stamp: 'db 11/30/2020 19:42:29'!
listCart: aCartID 

	self assertExpiredCart: aCartID.
	
	^(carts at: aCartID) items! !

!UserInterface methodsFor: 'operations' stamp: 'db 11/29/2020 14:06:02'!
listPurchases: aClientID password: aPassword

	"validar clientID y password"
	
	^(salesBook at: aClientID) items 
! !


!UserInterface methodsFor: 'initialization' stamp: 'db 11/30/2020 20:07:14'!
initalizeWith: anAuthenticator catalog: aCatalog throught: aMerchantProcessor on: aDate timeService: aTimeService

	authenticator := anAuthenticator.
	merchantProcessor := aMerchantProcessor.
	catalog := aCatalog.
	carts := Dictionary new.
	today := aDate .
	salesBook := Dictionary new.
	clock := aTimeService.
	maxTime := (SimpleMeasure amount: 30 unit: minute).
! !


!UserInterface methodsFor: 'asserts' stamp: 'db 11/30/2020 19:39:27'!
assertExpiredCart: aCartID

	(self isExpired: aCartID) ifTrue: [^self class signalOperationOnExpiredCart].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UserInterface class' category: 'TusLibros'!
UserInterface class
	instanceVariableNames: ''!

!UserInterface class methodsFor: 'as yet unclassified' stamp: 'db 11/30/2020 18:48:07'!
with: anAuthenticator catalog: aCatalog throught: aMerchantProcessor on: aDate timeService: aTimeService    
	"assertions"
	
	^self new initalizeWith: anAuthenticator catalog: aCatalog throught: aMerchantProcessor on: aDate timeService: aTimeService! !


!UserInterface class methodsFor: 'accessing' stamp: 'db 11/26/2020 21:02:37'!
invalidClientErrorMessage
	^'Invalid client ID or Password!!!!!!'! !

!UserInterface class methodsFor: 'accessing' stamp: 'db 11/30/2020 19:20:54'!
operationOnExpiredCartErrorDescription
	^'Operation on expired cart!!!!!!'! !

!UserInterface class methodsFor: 'accessing' stamp: 'db 11/26/2020 21:03:00'!
signalInvalidClient
	self error: self invalidClientErrorMessage ! !

!UserInterface class methodsFor: 'accessing' stamp: 'db 11/30/2020 19:21:05'!
signalOperationOnExpiredCart
	^self error: self operationOnExpiredCartErrorDescription! !

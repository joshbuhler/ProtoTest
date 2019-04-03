# ProtoTest

Small project that illustrates a build issue encountered when moving from Xcode 10.1 to Xcode 10.2. Our project was using Swift 4.2. This is just a smaller project that isolates and illustrates the issue we ran into.

We found that when using protocol composition, in combination with generics, we would get the following build errors:

> Instance method 'addNotificationBlockForId(_:withNotificationBlock:)' requires that 'Object' conform to 'Identifiable'

In this sample project, the `DataServiceProtocol` defines the following method:

```
func addNotificationBlockForId<T: Object & Identifiable>(_ forId: Int,
		withNotificationBlock: @escaping(RealmCollectionChange<Results<T>>) -> Void) -> Int?
```

This method uses a generic type that needs to implement both the `Object` and `Identifiable` protocols. `Object` is defined, in Realm, while `Identifiable` is part of this project. When the ViewController creates an instance of `DataService`, it attempts to setup a notification block to watch changes to collections of `InfinityStone` objects. `InfinityStone` objects meet the requirements of both `Object` and `Identifiable`.

When a Realm collection change occurs, these changes would be sent to the ViewController's `handleChanges` method, which prior to Xcode 10.2, had a signature of:

```
func handleChanges<T: InfinityStone>(changes: RealmCollectionChange<Results<T>>)
```

This would compile and work just fine under Xcode 10.1, but in Xcode 10.2 with the new Swift 5 compiler, would give us the following error:

> Instance method 'addNotificationBlockForId(_:withNotificationBlock:)' requires that 'Object' conform to 'Identifiable'

We found that by updating the `handleChanges` method to accept a concrete class rather than a generic, the compiler was happy, and would no longer generate the errors. In our case, this is fine, as in the larger project, our code would be expecting a type of `InfinityStone`, so there wasn't much of a need for the generic with the protocol requirement in the first place.

## Building the project

This project depends on Realm, specifically v3.14.0. Using [Carthage](https://github.com/Carthage/Carthage), run `carthage bootstrap --no-build` from the root directory of this project to fetch the Realm dependency.
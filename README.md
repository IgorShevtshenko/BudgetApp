# BudgetApp


##Architecture

The app uses a Redux-like approach to manage screen state and handle user interactions.
View sends Action to ViewModel → ViewModel fetches the required data and sends internal events to modify the state using the Reducer → Reducer applies changes to the state → View produces new UI with the updated state.


Due to separation of responsibilities:

- The reduce function is the only place where the state can be changed.
- ViewModel.send() is the place where feature-specific (usually presentation) logic is performed.
- View is a pure function that receives State and produces the new UI.

We achieve the following benefits:

1. Easy to debug, fix, and maintain.
2. Easy to test, and tests are cheap.
3. Easy to mock/use preview.
4. Easy to read and understand.
5. Easy to reuse, extend, and scale.
6. Easy to develop the same feature in parallel by 2 or more devs.

Things that I would do in a real project but were not done here due to the nature of the task assignment:

1. ViewModels and other dependencies are initialized and stored in App, which is fine for this small project, but later could lead to memory issues and unwanted side effects — one of the best solutions would be using a Composition Root.
2. To unleash the full potential of a modular app architecture, I would prefer using Tuist to be able to:
- Run separate targets to increase development speed.
- Run tests only in changed targets to increase the speed of CI.
3. Here, more emphasis is placed on the screen architecture, but for overall app architecture I would prefer to use Clean Architecture to ensure good testability, maintainability, and scalablility.

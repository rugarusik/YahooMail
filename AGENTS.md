# Agents - iOS Architecture Guide

This document defines the mandatory architectural rules for iOS development in this project.

## 1. Core Principles (Mandatory)

### SOLID Compliance
- **SRP** — One type, one responsibility.
- **OCP** — Extend via protocols and composition, not by modifying stable code.
- **LSP** — Depend on contracts; implementations must not break expectations.
- **ISP** — Prefer small, focused protocols over large "god protocols."
- **DIP** — UI depends on abstractions, not concrete implementations.

### Unidirectional Data Flow
Events → Business Logic → State Mutation → UI Rendering.

### Testability by Default
Business logic must not depend on SwiftUI, singletons, or concrete infrastructure.

### Concurrency-First Approach
- Use `async/await`.
- Use actors for shared mutable state.
- Avoid completion handlers unless interoperability is required.

## 2. Project Structure (ISO-Style Layered Architecture)

Prefer modularization (ideally via Swift Packages).

### Modules / Folders

#### App
- Entry point
- Dependency Injection container
- App-wide routing
- Feature assembly

#### Features/ (Feature-based structure)
Each feature must contain:
```
FeatureName/
 ├── UI/
 ├── Presentation/
 ├── Domain/
 ├── Data/
 └── Resources/
```

##### UI/
- SwiftUI Views only
- No business logic
- No networking
- No persistence

##### Presentation/
- ViewModels or Store
- State management
- Input → Output transformation
- Depends only on Domain

##### Domain/
- Entities
- UseCases
- Repository protocols
- Pure business logic
- No framework dependencies (except Foundation)

##### Data/
- Repository implementations
- DTOs
- Mappers
- Networking / persistence calls
- Depends on Core infrastructure

#### Core/
Shared infrastructure:
- Networking
- Persistence
- Logging
- Analytics
- DesignSystem (UI components, tokens)
- Utilities (small reusable helpers)

## 3. Dependency Rules (Strict)

- **UI** → depends on **Presentation** + **DesignSystem**
- **Presentation** → depends on **Domain**
- **Domain** → depends on nothing (except Foundation)
- **Data** → depends on **Domain** + **Core**
- **Cross-feature dependencies are not allowed**
- Features communicate only via public Domain contracts

## 4. State Management Rules

- Use `@StateObject` for owning ViewModels.
- Use `@ObservedObject` only when injected.
- Prefer immutable state models.
- Mutations happen only inside Presentation layer.
- Avoid business logic inside SwiftUI Views.

### Recommended Pattern

```swift
struct ViewState {
    var items: [Item]
    var isLoading: Bool
    var error: String?
}
```

**ViewModel:**
```swift
@MainActor
final class FeatureViewModel: ObservableObject {
    @Published private(set) var state: ViewState
}
```

## 5. Dependency Injection

- No singletons.
- Use constructor injection.
- Composition root exists in App.
- Protocol-based dependencies only.

**Example:**
```swift
protocol UserRepository {
    func fetchUser() async throws -> User
}
```

## 6. Networking Rules

- Use `async/await`.
- Centralized `APIClient`.
- No networking inside ViewModels.
- Map DTO → Domain models in Data layer.
- Handle errors explicitly (no silent failures).

## 7. Concurrency Rules

- Use `Task {}` only at UI boundary.
- Avoid detached tasks unless required.
- Mark ViewModels as `@MainActor`.
- Use `actor` for shared services (e.g. caching).

## 8. Design System Rules

- No hardcoded fonts/colors in Views.
- Use design tokens.
- Reusable components live in `Core/DesignSystem`.

## 9. Testing Requirements

- Domain layer must have unit tests.
- Presentation layer must be testable via protocol mocks.
- No UI testing for business logic.
- Use dependency injection for all test doubles.

## 10. Naming Conventions

- `SomethingView`
- `SomethingViewModel`
- `SomethingUseCase`
- `SomethingRepository`
- `SomethingDTO`
- `SomethingMapper`
- Protocols should be nouns, not suffixed with `Protocol`.

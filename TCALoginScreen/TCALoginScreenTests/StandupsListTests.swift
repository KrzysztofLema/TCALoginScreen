//
//  StandupsListTests.swift
//  TCALoginScreenTests
//
//  Created by Krzysztof Lema on 21/01/2024.
//

import ComposableArchitecture
import XCTest
@testable import TCALoginScreen

@MainActor
final class StandupsListTests: XCTestCase {
    func testAddStandups() async {
        let store = TestStore(initialState: StandupsListFeature.State()) {
            StandupsListFeature()
        }   withDependencies: {
            $0.uuid = .incrementing
        }
        var standup = Standup(id: UUID(0), attendees: [Attendee(id: UUID(1))])
        await store.send(.addButtonTapped) {
            $0.addStandup = StandupFormFeature.State(standup: standup)
        }
        standup.title = "Point-Free Morning Sync"
        await store.send(.addStandup(.presented(.set(\.$standup, standup)))) {
            $0.addStandup?.standup.title = "Point-Free Morning Sync"
        }
        await store.send(.saveStandupButtonTapped) {
            $0.addStandup = nil
            $0.standups[0] = Standup(
                id: UUID(0),
                attendees: [Attendee(id: UUID(1))],
                title: "Point-Free Morning Sync")
        }
    }
    func testAddStandups_NonExhaustive() async {
        let store = TestStore(initialState: StandupsListFeature.State()) {
            StandupsListFeature()
        }   withDependencies: {
            $0.uuid = .incrementing
        }
        
        store.exhaustivity = .off(showSkippedAssertions: true)
        
        var standup = Standup(id: UUID(0), attendees: [Attendee(id: UUID(1))])
        await store.send(.addButtonTapped) {
            _ = $0
        }
        standup.title = "Point-Free Morning Sync"
        await store.send(.addStandup(.presented(.set(\.$standup, standup)))) {
            $0.addStandup?.standup.title = "Point-Free Morning Sync"
        }
        await store.send(.saveStandupButtonTapped) {
            $0.addStandup = nil
            $0.standups[0] = Standup(
                id: UUID(0),
                attendees: [Attendee(id: UUID(1))],
                title: "Point-Free Morning Sync")
        }
    }
}

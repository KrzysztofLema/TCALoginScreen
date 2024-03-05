//
//  CounterTests.swift
//  TCALoginScreenTests
//
//  Created by Krzysztof Lema on 17/01/2024.
//

import ComposableArchitecture
import XCTest
@testable import TCALoginScreen


@MainActor
final class CounterTests: XCTestCase {
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
    }
    
    func testTimer() async throws {
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerOn = true
        }
        
        await clock.advance(by: .seconds(1))
        
        await store.receive(.timerTicked) {
            $0.count = 1
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerOn = false
        }
    }
    
    func testGetFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is great number!" }
        }
        
        await store.send(.getFactButtonTapped) {
            $0.isFactLoading = true
        }
        
        await store.receive(.factResponse("0 is great number!")) {
            $0.fact = "0 is great number!"
            $0.isFactLoading = false
        }
    }
    
    func testGetFact_Failure() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { _ in
                struct SomeError: Error {}
                throw SomeError()
            }
        }
        
        
//        XCTExpectedFailure()
        await store.send(.getFactButtonTapped) {
            $0.isFactLoading = true
        }
    }
}

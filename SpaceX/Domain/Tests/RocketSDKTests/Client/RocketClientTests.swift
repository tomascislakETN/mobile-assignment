import CoreToolkit
import CustomDump
import Dependencies
import Foundation
@testable import Motion
@testable import Networking
@testable import RocketSDK
import XCTest

final class RocketClientTests: XCTestCase {
  var rocketDTO: RocketDTO {
    RocketDTO(
      id: 1,
      active: true,
      stages: 2,
      boosters: 0,
      costPerLaunch: 62000000,
      successRatePct: 94,
      firstFlight: Date(timeIntervalSince1970: 0),
      country: "USA",
      company: "SpaceX",
      height: .init(meters: 70.0, feet: 229.66),
      diameter: .init(meters: 12.2, feet: 229.66),
      mass: MassDTO(kg: 549054, lb: 1210000),
      payloadWeights: [
        PayloadWeightDTO(id: "leo", name: "Low Earth Orbit", kg: 22800, lb: 50265)
      ],
      firstStage: .init(
        reusable: true,
        engines: 9,
        fuelAmountTons: 385.0,
        burnTimeSEC: 162,
        thrustSeaLevel: ThrustDTO(kN: 7607, lbf: 171000),
        thrustVacuum: ThrustDTO(kN: 7607, lbf: 171000),
        cores: 1
      ),
      secondStage: .init(
        reusable: true,
        engines: 1,
        fuelAmountTons: 90.0,
        burnTimeSEC: 397,
        thrust: ThrustDTO(kN: 7607, lbf: 171000),
        payloads: PayloadsDTO(
          option1: "Satellites",
          compositeFairing: CompositeFairingDTO(
            height: DiameterDTO(meters: 70.0, feet: 229.66),
            diameter: DiameterDTO(meters: 70.0, feet: 229.66)
          ),
          option2: nil
        )
      ),
      engines: .init(
        number: 27,
        type: "Merlin",
        version: "1D+",
        layout: "octaweb",
        isp: ISPDTO(seaLevel: 310, vacuum: 348),
        engineLossMax: 2,
        propellant1: "RP-1",
        propellant2: "Liquid Oxygen",
        thrustSeaLevel: ThrustDTO(kN: 7607, lbf: 171000),
        thrustVacuum: ThrustDTO(kN: 7607, lbf: 171000),
        thrustToWeight: 180.1
      ),
      landingLegs: .init(
        number: 4,
        material: "carbon fiber"
      ),
      flickrImages: [
        "https://example.com/photo1.jpg",
        "https://example.com/photo2.jpg"
      ],
      wikipedia: "https://en.wikipedia.org/wiki/Falcon_Heavy",
      description: "A heavy-lift launch vehicle designed by SpaceX.",
      rocketID: "falconHeavy",
      rocketName: "Falcon Heavy",
      rocketType: "Heavy"
    )
  }

  private var rocketData: Data {
    guard let encoder = try? JSONEncoder.encoder.encode([rocketDTO]) else {
      fatalError("could not create data")
    }

    return encoder
  }

  var expectedRocket: Rocket {
    Rocket(
      rocketName: "Falcon Heavy",
      description: "A heavy-lift launch vehicle designed by SpaceX.",
      heightInMeters: 70.0,
      diameterInMeters: 12.2,
      massInKilograms: 549054,
      firstFlight: Date(timeIntervalSince1970: 0),
      stages: [
        .init(
          type: .first,
          isReusable: true,
          numberOfEngines: 9,
          fuelAmountInTons: 385,
          burnTimeInSec: 162
        ),
        .init(
          type: .second,
          isReusable: true,
          numberOfEngines: 1,
          fuelAmountInTons: 90,
          burnTimeInSec: 397
        )
      ],
      photos: [
        "https://example.com/photo1.jpg",
        "https://example.com/photo2.jpg"
      ]
    )
  }

  // MARK: - fetchAllRockets

  func test_sut_should_receive_data() async {
    let rocketClient = withDependencies {
      $0.networkingClient.request = { _ in self.rocketData }
    } operation: {
      return RocketClient.liveValue
    }

    do {
      let rockets = try await withDependencies {
        $0.jsonDecoder = .decoder
      } operation: {
        try await rocketClient.fetchAllRockets()
      }

      XCTAssertNoDifference(rockets, [expectedRocket])
    } catch {
      XCTFail(error.localizedDescription)
    }
  }

  func test_sut_should_receive_error() async {
    let rocketClient = withDependencies {
      $0.networkingClient.request = { _ in throw DomainError.createAndLog(cause: .networking(.clientError)) }
    } operation: {
      RocketClient.liveValue
    }

    do {
      _ = try await rocketClient.fetchAllRockets()
    } catch {
      if let error = error as? DomainError {
        XCTAssertEqual(error.cause, .networking(.clientError))
      } else {
        XCTFail(error.localizedDescription)
      }
    }
  }

  func test_sut_should_receive_motion_data() async throws {
    let rocketClient = withDependencies {
      $0.motionClient.startAccelerometerUpdates = {
        .just(.init(x: 1, y: 1, z: 1))
      }
    } operation: {
      RocketClient.liveValue
    }

    for try await data in await rocketClient.rocketState() {
      XCTAssertEqual(data, .ready)
    }
  }
}

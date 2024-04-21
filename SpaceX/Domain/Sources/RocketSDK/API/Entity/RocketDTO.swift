import Foundation

struct RocketDTO: Codable {
  let id: Int
  let active: Bool
  let stages, boosters, costPerLaunch, successRatePct: Int
  let firstFlight: Date
  let country, company: String
  let height, diameter: DiameterDTO
  let mass: MassDTO
  let payloadWeights: [PayloadWeightDTO]
  let firstStage: FirstStageDTO
  let secondStage: SecondStageDTO
  let engines: EnginesDTO
  let landingLegs: LandingLegsDTO
  let flickrImages: [String]
  let wikipedia: String
  let description, rocketID, rocketName, rocketType: String

  enum CodingKeys: String, CodingKey {
    case id, active, stages, boosters
    case costPerLaunch = "cost_per_launch"
    case successRatePct = "success_rate_pct"
    case firstFlight = "first_flight"
    case country, company, height, diameter, mass
    case payloadWeights = "payload_weights"
    case firstStage = "first_stage"
    case secondStage = "second_stage"
    case engines
    case landingLegs = "landing_legs"
    case flickrImages = "flickr_images"
    case wikipedia, description
    case rocketID = "rocket_id"
    case rocketName = "rocket_name"
    case rocketType = "rocket_type"
  }
}

// MARK: - Diameter
struct DiameterDTO: Codable {
  let meters, feet: Double?
}

// MARK: - Engines
struct EnginesDTO: Codable {
  let number: Int
  let type, version: String
  let layout: String?
  let isp: ISPDTO
  let engineLossMax: Int?
  let propellant1, propellant2: String
  let thrustSeaLevel, thrustVacuum: ThrustDTO
  let thrustToWeight: Double

  enum CodingKeys: String, CodingKey {
    case number, type, version, layout, isp
    case engineLossMax = "engine_loss_max"
    case propellant1 = "propellant_1"
    case propellant2 = "propellant_2"
    case thrustSeaLevel = "thrust_sea_level"
    case thrustVacuum = "thrust_vacuum"
    case thrustToWeight = "thrust_to_weight"
  }
}

// MARK: - ISP
struct ISPDTO: Codable {
  let seaLevel, vacuum: Int

  enum CodingKeys: String, CodingKey {
    case seaLevel = "sea_level"
    case vacuum
  }
}

// MARK: - Thrust
struct ThrustDTO: Codable {
  let kN, lbf: Int
}

// MARK: - FirstStage
struct FirstStageDTO: Codable {
  let reusable: Bool
  let engines: Int
  let fuelAmountTons: Double
  let burnTimeSEC: Int?
  let thrustSeaLevel, thrustVacuum: ThrustDTO
  let cores: Int?

  enum CodingKeys: String, CodingKey {
    case reusable, engines
    case fuelAmountTons = "fuel_amount_tons"
    case burnTimeSEC = "burn_time_sec"
    case thrustSeaLevel = "thrust_sea_level"
    case thrustVacuum = "thrust_vacuum"
    case cores
  }
}

// MARK: - LandingLegs
struct LandingLegsDTO: Codable {
  let number: Int
  let material: String?
}

// MARK: - Mass
struct MassDTO: Codable {
  let kg, lb: Int
}

// MARK: - PayloadWeight
struct PayloadWeightDTO: Codable {
  let id, name: String
  let kg, lb: Int
}

// MARK: - SecondStage
struct SecondStageDTO: Codable {
  let reusable: Bool
  let engines: Int
  let fuelAmountTons: Double
  let burnTimeSEC: Int?
  let thrust: ThrustDTO
  let payloads: PayloadsDTO

  enum CodingKeys: String, CodingKey {
    case reusable, engines
    case fuelAmountTons = "fuel_amount_tons"
    case burnTimeSEC = "burn_time_sec"
    case thrust, payloads
  }
}

// MARK: - Payloads
struct PayloadsDTO: Codable {
  let option1: String
  let compositeFairing: CompositeFairingDTO
  let option2: String?

  enum CodingKeys: String, CodingKey {
    case option1 = "option_1"
    case compositeFairing = "composite_fairing"
    case option2 = "option_2"
  }
}

// MARK: - CompositeFairing
struct CompositeFairingDTO: Codable {
  let height, diameter: DiameterDTO
}

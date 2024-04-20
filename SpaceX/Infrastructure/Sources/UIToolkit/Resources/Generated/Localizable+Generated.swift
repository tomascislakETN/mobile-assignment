// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Localizable {
  public enum Rocket {
    public enum Detail {
      public enum Parameter {
        public enum Diameter {
          /// diameter
          public static let title = Localizable.tr("Localizable", "rocket_detail_parameter_diameter_title", fallback: "diameter")
        }
        public enum Height {
          /// height
          public static let title = Localizable.tr("Localizable", "rocket_detail_parameter_height_title", fallback: "height")
        }
        public enum Mass {
          /// mass
          public static let title = Localizable.tr("Localizable", "rocket_detail_parameter_mass_title", fallback: "mass")
        }
      }
      public enum Section {
        public enum First {
          public enum Stage {
            /// First Stage
            public static let title = Localizable.tr("Localizable", "rocket_detail_section_first_stage_title", fallback: "First Stage")
          }
        }
        public enum Overview {
          /// Overview
          public static let title = Localizable.tr("Localizable", "rocket_detail_section_overview_title", fallback: "Overview")
        }
        public enum Parameters {
          /// Parameters
          public static let title = Localizable.tr("Localizable", "rocket_detail_section_parameters_title", fallback: "Parameters")
        }
        public enum Photos {
          /// Photos
          public static let title = Localizable.tr("Localizable", "rocket_detail_section_photos_title", fallback: "Photos")
        }
        public enum Second {
          public enum Stage {
            /// Second Stage
            public static let title = Localizable.tr("Localizable", "rocket_detail_section_second_stage_title", fallback: "Second Stage")
          }
        }
      }
      public enum Stage {
        /// %@ burn time
        public static func burn(_ p1: Any) -> String {
          return Localizable.tr("Localizable", "rocket_detail_stage_burn", String(describing: p1), fallback: "%@ burn time")
        }
        /// Plural format key: "%#@localized_format_key@"
        public static func engine(_ p1: Int) -> String {
          return Localizable.tr("Localizable", "rocket_detail_stage_engine", p1, fallback: "Plural format key: \"%#@localized_format_key@\"")
        }
        /// %@ of fuel
        public static func fuel(_ p1: Any) -> String {
          return Localizable.tr("Localizable", "rocket_detail_stage_fuel", String(describing: p1), fallback: "%@ of fuel")
        }
        /// reusable
        public static let reusable = Localizable.tr("Localizable", "rocket_detail_stage_reusable", fallback: "reusable")
        public enum Not {
          /// not reusable
          public static let reusable = Localizable.tr("Localizable", "rocket_detail_stage_not_reusable", fallback: "not reusable")
        }
      }
    }
    public enum List {
      public enum Cell {
        /// First flight: %@
        public static func description(_ p1: Any) -> String {
          return Localizable.tr("Localizable", "rocket_list_cell_description", String(describing: p1), fallback: "First flight: %@")
        }
      }
      public enum Navigation {
        /// Rockets
        public static let title = Localizable.tr("Localizable", "rocket_list_navigation_title", fallback: "Rockets")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localizable {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

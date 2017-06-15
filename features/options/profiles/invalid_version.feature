Feature: Invalid profile API versions

    Background:
        Given a grid size of 100 meters

    Scenario: Undefined API version
        Given the profile file
          """
          function way_function(way, result)
            result.forward_mode = mode.driving
            result.forward_speed = 1
          end
          """
        And the node map
          """
            ab
          """
        And the ways
            | nodes  |
            | ab     |
        And the data has been saved to disk

        When I try to run "osrm-extract --profile {profile_file} {osm_file}"
        Then it should exit with an error
        And stderr should contain "Profile API version must defined"

    Scenario: Profile API version too low
        Given the profile file
          """
          api_version = 0
          """
        And the node map
          """
            ab
          """
        And the ways
            | nodes  |
            | ab     |
        And the data has been saved to disk

        When I try to run "osrm-extract --profile {profile_file} {osm_file}"
        Then it should exit with an error
        And stderr should contain "Invalid profile API version"

    Scenario: Profile API version too high
        Given the profile file
          """
          api_version = 3
          """
        And the node map
          """
            ab
          """
        And the ways
            | nodes  |
            | ab     |
        And the data has been saved to disk

        When I try to run "osrm-extract --profile {profile_file} {osm_file}"
        Then it should exit with an error
        And stderr should contain "Invalid profile API version"

@nine
Feature: Frontpage test
  In order to verify our branding site is working as expeced
  As a headhunter
  I want to verify that my page has valuable info

  
  Scenario: test frontpage
    Given I go to the frontpage
    Then I should see "Erhvervsstyrelsen"


  Scenario: Search
    * I go to the frontpage
    * I fill in "s" with "strange"
    * I press "Søg"
    * I should see 9 elements kind of "li" within ul.results
    
  

  Scenario: Team members
    * I go to the frontpage
    * I click "Team"
    * I log the network traffic for the page
    * I should see "Her kan du få et overblik over konsulenterne i NineConsult."
    * I should see the following employees:
      | Jacob Strange Direktør/partner                |
      | Christian Hoffmann Direktør/partner           |
      | Finn Peder Hove Direktør/partner              |
      | Anders Rudkjær Nørgaard Senior Consultant     |
      | Christian Landbo Senior Consultant            |
      | Christian Huusom Senior Consultant            |
      | Claus Nordahl Principal Consultant            |
      | Daniel Larsen Senior Consultant               |
      | Elisabet Linnet Senior Consultant             |
      | Erik W. Rasmussen Principal Consultant        |
      | Esben Birkebæk Larsen Senior Consultant       |
      | Henrik Stig Langli Senior Consultant          |
      | Henrik S. Nielsen Account Manager             |
      | Jannie Lykke Rasmussen Principal Consultant   |
      | Jens Grønborg Andersen Senior Consultant      |
      | Jens Christian Christiansen Senior Consultant |
      | Jens Karlsmose Principal Consultant           |
      | Jens Lohmann Senior Consultant                |
      | Jesper Gørtz Principal Consultant             |
      | Jesper Halskov Principal Consultant           |
      | Jesper Rugård Jensen Managing Consultant      |
      | Jesper Rønn Jensen Senior Consultant          |
      | Jesper Steen Møller Principal Consultant      |
      | Jørgen Skov-Pedersen Managing Consultant      |
      | Kent Damgaard Senior Consultant               |
      | Kristjan Wager Senior Consultant              |
      | Lotte Jensen Managing Consultant              |
      | Louis Steinthal Principal Consultant          |
      | Martin Glob Senior Consultant                 |
      | Mette Bie Senior Consultant                   |
      | Michael Foldbjerg Principal Consultant        |
      | Mikael Jørgensen Principal Consultant         |
      | Mikkel Gybel Lindgren Senior Consultant       |
      | Morten Holm Søby Senior Consultant            |
      | Niels Bech Nielsen Principal Consultant       |
      | Niels Jørgen Bagger Senior Consultant         |
      | Niels Peter Strandberg Managing Consultant    |
      | Nikolaj Brinch Jørgensen Principal Consultant |
      | Nikolaj S. Jørgensen Principal Consultant     |
      | Patrick Fust Senior Consultant                |
      | Per Agerbæk Principal Consultant              |
      | Pernille Møller Krog Senior Consultant        |
      | Peter Falk Managing Consultant                |
      | Peter Qviller Managing Consultant             |
      | Poul Bildsøe Principal Consultant             |
      | Rasmus Rask Andersen Senior Consultant        |
      | Sebastian Vilstrup Senior Consultant          |
      | Søren Hartvig Principal Consultant            |
      | Søren Peter Nielsen Managing Consultant       |
      | Søren Stuhde Senior Consultant                |
      | Thomas Lefèvre Consultant                     |
      | Tim Marcher Senior Consultant                 |
      | Tobias Michaelsen Senior Consultant           |
      | Torben Petersen Senior Consultant             |
      | Uffe Hansen Principal Consultant              |
  
  
  
  


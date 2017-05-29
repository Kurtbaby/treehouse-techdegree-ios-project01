//    Project: Soccer League Coordinator
// Created By: Kurt D. Gengenbach
//  Copyright: 2017 JuniFly - All Rights Reserved

import Foundation

// Define an array of dictionaries to represent our source player database.
// Note: We were told not to use Tubles, even though we did cover them in this section.  We were also told not
//  to use Structs and Classes, which would have made this much easier and more professional.  Dictionaries
//  are not really the best option here because all objects in the dictionary must be the same type.  I chose
//  String and then plan to convert as needed.  Also, a future option would be to load a CSV file of the players
//  into the internal DB structure rather than hard coding them as below.  And to avoid a "Magic Number," I
//  calculate the sort score value based on supplied attributes.

var players = [[String: String]]()

// Load our source player database into our array of dictionaries.
players.append(["Name": "Joe Smith", "Height": "42", "Experience": "YES", "Guardian": "Jim and Jan Smith", "Score": "", "Assigned": "0"])
players.append(["Name": "Jill Tanner", "Height": "36", "Experience": "YES", "Guardian": "Clara Tanner", "Score": "", "Assigned": "0"])
players.append(["Name": "Bill Bon", "Height": "43", "Experience": "YES", "Guardian": "Sara and Jenny Bon", "Score": "", "Assigned": "0"])
players.append(["Name": "Eva Gordon", "Height": "45", "Experience": "NO", "Guardian": "Wendy and Mike Gordon", "Score": "", "Assigned": "0"])
players.append(["Name": "Matt Gill", "Height": "40", "Experience": "NO", "Guardian": "Charles and Sylvia Gill", "Score": "", "Assigned": "0"])
players.append(["Name": "Kimmy Stein", "Height": "41", "Experience": "NO", "Guardian": "Bill and Hillary Stein", "Score": "", "Assigned": "0"])
players.append(["Name": "Sammy Adams", "Height": "45", "Experience": "NO", "Guardian": "Jeff Adams", "Score": "", "Assigned": "0"])
players.append(["Name": "Karl Saygan", "Height": "42", "Experience": "YES", "Guardian": "Heather Bledsoe", "Score": "", "Assigned": "0"])
players.append(["Name": "Suzane Greenberg", "Height": "44", "Experience": "YES", "Guardian": "Henrietta Dumas", "Score": "", "Assigned": "0"])
players.append(["Name": "Sal Dali", "Height": "41", "Experience": "NO", "Guardian": "Gala Dali", "Score": "", "Assigned": "0"])
players.append(["Name": "Joe Kavalier", "Height": "39", "Experience": "NO", "Guardian": "Sam and Elaine Kavalier", "Score": "", "Assigned": "0"])
players.append(["Name": "Ben Finkelstein", "Height": "44", "Experience": "NO", "Guardian": "Aaron and Jill Finkelstein", "Score": "", "Assigned": "0"])
players.append(["Name": "Diego Soto", "Height": "41", "Experience": "YES", "Guardian": "Robin and Sarika Soto", "Score": "", "Assigned": "0"])
players.append(["Name": "Chloe Alaska", "Height": "47", "Experience": "NO", "Guardian": "David and Jamie Alaska", "Score": "", "Assigned": "0"])
players.append(["Name": "Arnold Willis", "Height": "43", "Experience": "NO", "Guardian": "Claire Willis", "Score": "", "Assigned": "0"])
players.append(["Name": "Philip Helm", "Height": "44", "Experience": "YES", "Guardian": "Thomas Helm and Eva Jones", "Score": "", "Assigned": "0"])
players.append(["Name": "Les Clay", "Height": "42", "Experience": "YES", "Guardian": "Wynonna Brown", "Score": "", "Assigned": "0"])
players.append(["Name": "Herschel Krustofski", "Height": "45", "Experience": "YES", "Guardian": "Hyman and Rachel Krustofski", "Score": "", "Assigned": "0"])

let totalPlayers = players.count

// Calculate each player's score based on experience first, than height.  I took a little liberty here because I coach two youth
//  soccer teams and experience matters a great deal more than the player's height.  So, experience adds 100 to the player's height,
//  while no experience adds 0.  In other words, a player with experience who is 42" high would have a score of 142.  A player without
//  experience who is 48" high would score 048.  The following code balances all of the players based on this score.

// Note: This could have been simplified using a ternary operator, but I am not sure that we've covered this yet.
for index in 0...totalPlayers - 1
{
    if players[index]["Experience"] == "YES"
    {
        players[index]["Score"] = "1" + players[index]["Height"]!
    }
    else
    {
        players[index]["Score"] = "0" + players[index]["Height"]!
    }
}

// Create variables to hold our three teams.
//  Note: I would really have liked to use a class here that would have represented a team, with team name, team player score,
//  the array of players, etc., and then put these team objects into an array themselves, but we haven't covered classes yet.
let numberOfTeams: Int = 3

// An array to hold the players for each team.
var teams = [[[String: String]]]()
// And an array to hold the team scores.
var teamScores = [Int]()

for i in 1...numberOfTeams
{
    teams.append([[String: String]]())
    teamScores.append(0)
}

// Note: Here we could sort the array of dictionaries using the calculated sort score, but again,
//  not sure we've covered this so I opted to use a repeated scan.

// Initialize the variables used in the loop and for score balancing the teams.
var highestPlayerScore: Int =  0
var highestPlayerIndex: Int = -1
var playersAssigned:    Int =  0
var lowestTeamScore:    Int =  0
var lowestTeamIndex:    Int = -1

// Loop through the players and assign to the three teams as evenly as possible.
while playersAssigned < totalPlayers
{
    // Figure out which team has the lowest score to assign the next player to.
    // Note: This could be improved using a random number generator as a tie-breaker
    //  for any teams that have the same score, for example, arc4random_uniform(numberOfTeams) + 1
    //  could be used here but was this was not covered yet so I didn't use it.
    
    // Initialize the score to the ceiling so loop functions properly.
    lowestTeamScore = 999
    for index in 0...numberOfTeams - 1
    {
        if teamScores[index] < lowestTeamScore
        {
            lowestTeamIndex = index
            lowestTeamScore = teamScores[index]
        }
    }
    
    // Iterate through the players to find the next highest scoring, unassigned player.
    highestPlayerScore = 0
    for index in 0...totalPlayers - 1
    {
        // Extract and convert the player's score.
        let thisScore: Int = Int(players[index]["Score"]!)!
        
        // If the player hasn't been assigned and their score is now the highest,
        //  remember their score and who they are (via index).
        if players[index]["Assigned"] == "0" && highestPlayerScore < thisScore
        {
            highestPlayerIndex = index
            highestPlayerScore = thisScore
        }
    }
    
    // This section assigns the next highest scoring player to the team with the
    //  lowest score.
    teams[lowestTeamIndex].append(players[highestPlayerIndex])
    teamScores[lowestTeamIndex] += highestPlayerScore
    
    // Flag this player has having been assigned and increment our loop counter.
    players[highestPlayerIndex]["Assigned"] = "1"
    playersAssigned += 1
    
}

// Next print out each team, the team's overall score, and a list of the players on each team.
//  Note how balanced the teams are using the experience/height scoring concept.
print("\n\n")
print("TEAMS")
for index in 0...numberOfTeams - 1
{
    var totalHeight: Int = 0
    print("\n===================")
    print("Team \(index + 1) - Score: \(teamScores[index])")
    print("-------------------")
    for player in teams[index]
    {
        print(player["Score"]! + " - " + player["Name"]!)
        totalHeight += (Int)(player["Height"]!)!
        
    }
    print("----------------------")
    print("Total Team Height: \(totalHeight)")
    print("======================")
}

// A function that prints the welcome letters.
func printWelcomeLetter(playerName: String, teamNumber: Int)
{
    print("Dear \(playerName),\n")
    print("Congratulations on being accepted on Team #\(teamNumber).  Please report to")
    print("Three Rivers Field for your first practice this Saturday at 10:00 AM")
    print("to meet your coach, your team, and receive your soccer jersey.\n")
    print("Looking forward to a fun and rewarding season. Go Team #\(teamNumber)!\n\n")
}

// Finally, print out the team welcome letters.
print("\n\n")
print("Team Welcome Letters")
print("--------------------")
for index in 0...numberOfTeams - 1
{
    for player in teams[index]
    {
        printWelcomeLetter(playerName: player["Name"]!, teamNumber: index + 1)
    }
}


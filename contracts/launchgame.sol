pragma solidity >=0.4.16 <0.9.0;

//@title keeps track of information for active games
contract GameManager {
    
    //@dev represents people playing game
    struct Player {
        address playerAddress;
        uint8 playerNum;
        string name;
    }

    //@dev represents a game being played
    struct Game {
        uint gameCode;
        Player player1;
        Player player2;
        uint8 winner;
    }

    //stores all games being played
    Game[] storage activeGames; 
}
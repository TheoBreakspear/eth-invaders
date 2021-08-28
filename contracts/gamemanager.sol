pragma solidity >=0.4.16 <0.9.0;

//@title keeps track of information for active games
contract GameManager {

    event NewGame(uint gameId, address player1);
    event gameConfirmed(uint gameId)

    //@dev represents a game being played
    struct Game {
        address player1;
        address player2;
        bool bothReady;
        uint8 winner;
    }

    //@dev maps game ID to game
    mapping (uint => Game) public activeGames; 
    
    //@dev launches new game and sets player 1 and gameCode
    function createGame(address _player1, address _player2) external {
        require(msg.sender == _player1);
        uint _gameId = uint(keccak256(abi.encodePacked(_player1, _player2)));
        activeGames[_gameId] = Game(_player1, _player2, false, 0);
        emit NewGame(_gameId, _player1);
    } 

    //@dev player 2 calls to confirm game
    function confirmGame(_gameId) external {
        require(activeGames[_gameId].player2 == msg.sender);
        activeGames[_gameId].bothReady = true;
        emit gameConfirmed(_gameId) //triggers start of game
    }
}


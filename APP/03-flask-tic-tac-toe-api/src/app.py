from flask import Flask, jsonify
import uuid
from di.container import Container
from web.route.game_routes import init_routes
from domain.model.game import Game

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False


container = Container()


game_blueprint = init_routes(container.game_service)
app.register_blueprint(game_blueprint)


@app.route('/game/new', methods=['POST'])
def create_new_game():
   
    new_game = Game()
    
    
    container.game_repository.save_game(new_game)
    
    return jsonify({
        "id": str(new_game.id),
        "board": new_game.board.get_matrix(),
        "status": "PLAYING"
    }), 201

if __name__ == '__main__':

    app.run(host='127.0.0.1', port=5000, debug=True)
from flask import Flask
from flask_cors import CORS  # Импортируем CORS
from di.container import Container
from web.route.game_routes import init_game_routes
from web.route.auth_routes import init_auth_routes

app = Flask(__name__)

# Разрешаем браузерам отправлять запросы к нашему REST API
CORS(app)

# Заставляем Flask отдавать кириллицу как нормальный текст
app.json.ensure_ascii = False

container = Container()

auth_blueprint = init_auth_routes(container.auth_service, container.user_repository)
app.register_blueprint(auth_blueprint)

game_blueprint = init_game_routes(container.game_service, container.authenticator)
app.register_blueprint(game_blueprint)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=True)
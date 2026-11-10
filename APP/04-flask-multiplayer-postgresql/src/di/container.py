from datasource.database.db_config import SessionLocal, engine, Base
from datasource.repository.game_repository_impl import GameRepositoryImpl
from datasource.repository.user_repository_impl import UserRepositoryImpl
from domain.service.game_service_impl import GameServiceImpl
from domain.service.auth_service_impl import AuthServiceImpl
from web.middleware.authenticator import UserAuthenticator

class Container:
    def __init__(self):
        # Автоматически создаем таблицы в PostgreSQL при старте приложения
        Base.metadata.create_all(bind=engine)
        
        # Создаем единую сессию для репозиториев
        self._db = SessionLocal()
        
        # Репозитории 
        self._user_repository = UserRepositoryImpl(self._db)
        self._game_repository = GameRepositoryImpl(self._db)
        
        # Сервисы
        self._auth_service = AuthServiceImpl(self._user_repository)
        self._game_service = GameServiceImpl(self._game_repository)
        
        # Аутентификатор для веб-слоя 
        self._authenticator = UserAuthenticator(self._auth_service)

    @property
    def game_service(self):
        return self._game_service
        
    @property
    def game_repository(self):
        return self._game_repository

    @property
    def auth_service(self):
        return self._auth_service

    @property
    def user_repository(self):
        return self._user_repository

    @property
    def authenticator(self):
        return self._authenticator
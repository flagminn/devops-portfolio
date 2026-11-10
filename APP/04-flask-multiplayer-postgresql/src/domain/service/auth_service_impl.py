import hashlib
import uuid
from domain.service.auth_service_interface import AuthServiceInterface
from domain.model.user import User

class AuthServiceImpl(AuthServiceInterface):
    def __init__(self, user_repository):
        self.user_repository = user_repository

    def _hash_password(self, password: str) -> str:
        return hashlib.sha256(password.encode('utf-8')).hexdigest()

    def register_user(self, login: str, password_raw: str) -> bool:
        # Проверяем уникальность логина
        if self.user_repository.get_by_login(login) is not None:
            return False
        
        hashed_password = self._hash_password(password_raw)
        # передаем хэш в параметр password
        new_user = User(login=login, password=hashed_password)
        self.user_repository.save_user(new_user)
        return True

    def authenticate_user(self, login: str, password_raw: str) -> uuid.UUID | None:
        user = self.user_repository.get_by_login(login)
        if user is None:
            return None
        
        if user.password == self._hash_password(password_raw):
            return user.id
        return None
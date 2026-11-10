from abc import ABC, abstractmethod
import uuid
from domain.model.user import User

class UserRepositoryInterface(ABC):
    @abstractmethod
    def save_user(self, user: User) -> None: pass

    @abstractmethod
    def get_user(self, user_id: uuid.UUID) -> User | None: pass

    @abstractmethod
    def get_by_login(self, login: str) -> User | None: pass
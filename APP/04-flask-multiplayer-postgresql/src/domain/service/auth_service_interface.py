from abc import ABC, abstractmethod
import uuid

class AuthServiceInterface(ABC):
    @abstractmethod
    def register_user(self, login: str, password_raw: str) -> bool: pass

    @abstractmethod
    def authenticate_user(self, login: str, password_raw: str) -> uuid.UUID | None: pass
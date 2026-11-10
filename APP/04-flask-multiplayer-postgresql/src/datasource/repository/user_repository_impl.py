import uuid
from sqlalchemy.orm import Session
from datasource.repository.user_repository_interface import UserRepositoryInterface
from datasource.model.db_models import UserEntity
from datasource.mapper.storage_mapper import StorageMapper
from domain.model.user import User

class UserRepositoryImpl(UserRepositoryInterface):
    def __init__(self, db_session: Session):
        self.db = db_session

    def save_user(self, user: User) -> None:
        entity = StorageMapper.to_user_entity(user)
        # Ищем, вдруг такой уже есть (апдейт), если нет — добавляем
        existing = self.db.query(UserEntity).filter(UserEntity.id == entity.id).first()
        if existing:
            existing.login = entity.login
            existing.password = entity.password
        else:
            self.db.add(entity)
        self.db.commit()

    def get_user(self, user_id: uuid.UUID) -> User | None:
        entity = self.db.query(UserEntity).filter(UserEntity.id == str(user_id)).first()
        return StorageMapper.to_user_domain(entity)

    def get_by_login(self, login: str) -> User | None:
        entity = self.db.query(UserEntity).filter(UserEntity.login == login).first()
        return StorageMapper.to_user_domain(entity)
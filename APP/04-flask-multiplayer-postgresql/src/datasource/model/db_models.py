import uuid
from sqlalchemy import Column, String, Boolean, ForeignKey
from datasource.database.db_config import Base

class UserEntity(Base):
    __tablename__ = "users"

    id = Column(String, primary_key=True, index=True)
    login = Column(String, unique=True, index=True, nullable=False)
    password = Column(String, nullable=False)

class GameEntity(Base):
    __tablename__ = "games"

    id = Column(String, primary_key=True, index=True)
    board_str = Column(String, default="0,0,0,0,0,0,0,0,0") # Поле 3х3 в виде строки
    status = Column(String, nullable=False)
    player_x_id = Column(String, nullable=True)
    player_o_id = Column(String, nullable=True)
    current_turn_id = Column(String, nullable=True)
    is_vs_bot = Column(Boolean, default=False)
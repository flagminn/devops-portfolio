import uuid

class User:
    def __init__(self, user_id: uuid.UUID = None, login: str = "", password: str = ""):
        self.id = user_id if user_id is not None else uuid.uuid4()
        self.login = login
        self.password = password  # Тут будет лежать хэш пароля
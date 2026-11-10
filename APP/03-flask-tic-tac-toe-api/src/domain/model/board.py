class Board:
    def __init__(self, matrix: list[list[int]] = None):
        if matrix is None:
            self.matrix = [[0 for _ in range(3)] for _ in range(3)]
        else:
            self.matrix = [row[:] for row in matrix]

    def get_matrix(self) -> list[list[int]]:
        return self.matrix
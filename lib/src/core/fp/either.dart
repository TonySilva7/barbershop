/// Na programação funcional, é uma classe que representa um valor com duas posições (Left, Right),
/// que pode ser um erro (left) ou um sucesso (right)
sealed class Either<E extends Exception, S> {}

class Failure<E extends Exception, S> extends Either<E, S> {
  final E error;

  Failure(this.error);
}

class Success<E extends Exception, S> extends Either<E, S> {
  final S value;

  Success(this.value);
}

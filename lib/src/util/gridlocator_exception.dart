/// An exception thrown when there was a problem in the gridlocator library.
class GridlocatorException extends FormatException {
  GridlocatorException(super.message, [super.source, super.offset]);
}

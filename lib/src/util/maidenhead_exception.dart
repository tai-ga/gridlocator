/// An exception thrown when there was a problem in the maidenhead library.
class MaidenheadException extends FormatException {
  MaidenheadException(super.message, [super.source, super.offset]);
}

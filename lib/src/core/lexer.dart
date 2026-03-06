import 'token.dart';

/// Lexer for tokenizing mathematical expressions
/// 
/// Converts infix notation strings into token streams.
class Lexer {
  static final Map<String, TokenType> _keywords = {
    '+': TokenType.plus,
    '-': TokenType.minus,
    '*': TokenType.multiply,
    '/': TokenType.divide,
    '%': TokenType.modulo,
    '^': TokenType.power,
    '(': TokenType.leftParen,
    ')': TokenType.rightParen,
    ',': TokenType.comma,
    'sin': TokenType.sin,
    'cos': TokenType.cos,
    'tan': TokenType.tan,
    'asin': TokenType.asin,
    'acos': TokenType.acos,
    'atan': TokenType.atan,
    'arcsin': TokenType.asin,
    'arccos': TokenType.acos,
    'arctan': TokenType.atan,
    'ln': TokenType.ln,
    'log': TokenType.log,
    'sqrt': TokenType.sqrt,
    'abs': TokenType.abs,
    'ceil': TokenType.ceil,
    'floor': TokenType.floor,
    'exp': TokenType.exp,
  };
  
  /// Tokenize an input string into a list of tokens
  List<Token> tokenize(String input) {
    if (input.isEmpty) {
      throw ArgumentError('Input string is empty');
    }
    
    final tokens = <Token>[];
    final cleaned = input.replaceAll(' ', '').trim();
    
    int i = 0;
    while (i < cleaned.length) {
      final char = cleaned[i];
      
      // Check for numbers
      if (_isDigit(char) || char == '.') {
        final numberEnd = _scanNumber(cleaned, i);
        final numberText = cleaned.substring(i, numberEnd);
        tokens.add(Token(TokenType.number, numberText));
        i = numberEnd;
        continue;
      }
      
      // Check for single-character operators/delimiters
      if (_keywords.containsKey(char)) {
        tokens.add(Token(_keywords[char]!, char));
        i++;
        continue;
      }
      
      // Check for multi-character keywords (functions, variables)
      if (_isLetter(char)) {
        final wordEnd = _scanWord(cleaned, i);
        final word = cleaned.substring(i, wordEnd);
        
        if (_keywords.containsKey(word)) {
          tokens.add(Token(_keywords[word]!, word));
        } else {
          // It's a variable
          tokens.add(Token(TokenType.variable, word));
        }
        i = wordEnd;
        continue;
      }
      
      throw ArgumentError('Unexpected character: $char at position $i');
    }
    
    return tokens;
  }
  
  /// Scan a number starting at position i
  int _scanNumber(String input, int start) {
    int i = start;
    bool hasDecimal = false;
    
    while (i < input.length) {
      final char = input[i];
      
      if (_isDigit(char)) {
        i++;
      } else if (char == '.' && !hasDecimal) {
        hasDecimal = true;
        i++;
      } else {
        break;
      }
    }
    
    return i;
  }
  
  /// Scan a word (function name or variable) starting at position i
  int _scanWord(String input, int start) {
    int i = start;
    
    while (i < input.length && (_isLetter(input[i]) || _isDigit(input[i]))) {
      i++;
    }
    
    return i;
  }
  
  /// Check if character is a digit
  bool _isDigit(String char) {
    final code = char.codeUnitAt(0);
    return code >= 48 && code <= 57; // '0' to '9'
  }
  
  /// Check if character is a letter
  bool _isLetter(String char) {
    final code = char.codeUnitAt(0);
    return (code >= 65 && code <= 90) || // 'A' to 'Z'
           (code >= 97 && code <= 122);  // 'a' to 'z'
  }
}

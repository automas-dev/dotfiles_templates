from unittest.mock import patch

from foo import foo


@patch('foo.print')
def test_first(mock_print):
    foo()

    mock_print.assert_called_once_with('Hello World')

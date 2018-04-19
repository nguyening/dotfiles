"""Configuration file for ptpython REPL tool."""

from ptpython.layout import CompletionVisualisation


__all__ = (
    'configure',
)


def configure(repl):
    """Configure ptpython during start-up.

    Params:
        repl (PythonRepl): instance of the REPL

    """
    repl.show_signature = True
    repl.show_docstring = True
    repl.show_line_numbers = True
    repl.show_status_bar = True
    repl.highlight_matching_parenthesis = True
    repl.wrap_lines = True
    repl.complete_while_typing = True
    repl.vi_mode = True
    repl.insert_blank_line_after_output = False

    repl.completion_visualisation = CompletionVisualisation.POP_UP
    repl.completion_menu_scroll_offset = 0

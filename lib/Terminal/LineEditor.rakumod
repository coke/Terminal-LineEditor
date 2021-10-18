unit class Terminal::LineEditor:auth<zef:japhb>:api<0>:ver<0.0.1>;


=begin pod

=head1 NAME

Terminal::LineEditor - Generalized terminal line editing


=head1 SYNOPSIS

=begin code :lang<raku>

use Terminal::LineEditor;


=end code

=head1 DESCRIPTION

C<Terminal::LineEditor> is a terminal line editing package similar to
C<Linenoise> or C<Readline>, but B<not> a drop-in replacement for either of
them.  C<Terminal::LineEditor> has a few key design differences:

=item Implemented in pure Raku; C<Linenoise> and C<Readline> are NativeCall
      wrappers.

=item Features strong separation of concerns; all components are exposed and
      replaceable.

=item Useable both directly for simple CLI apps and embedded in TUI interfaces.


=head2 Edge Cases

There are a few edge cases for which C<Terminal::LineEditor> chose one of
several possible behaviors.  Here's the reasoning for each of these otherwise
arbitrary decisions:

=item Attempting to apply an edit operation or create a new cursor outside the
      buffer contents throws an exception, because these indicate a logic error
      elsewhere.

=item Attempting to move a previously correct cursor outside the buffer
      contents silently clips the new cursor position to the buffer endpoints,
      because users frequently hold down cursor movement keys (and thus
      repeatedly try to move past an endpoint).

=item Undo'ing a delete operation, where one or more cursors were within the
      deleted region, results in all such cursors moving to the end of the
      undo; this is consistent with the behavior of an insert operation at the
      same position as the delete undo.

=item For the same reason as for delete operations, replace operations that
      overlap cursor locations will move them to the end of the replaced text.


=head2 Unmapped Functionality

Some of the functionality supported by lower layers of C<Terminal::LineEditor>
is not exposed in the default keymap of C<Terminal::LineEditor::KeyMappable>.
This is generally because no commonly-agreed shell keys in the basic control
code range (codes 0 through 31) map to this functionality.

For example, C<Terminal::LineEditor::SingleLineTextBuffer> can treat replace as
an atomic operation, but basic POSIX shells generally don't; they instead
expect the user to delete and insert as separate operations.

That said, if I've missed a commonly-supported key sequence for any of the
unmapped functionality, please open an issue for this repository with a link to
the relevant docs so I can expand the default keymap.


=head1 AUTHOR

Geoffrey Broadwell <gjb@sonic.net>


=head1 COPYRIGHT AND LICENSE

Copyright 2021 Geoffrey Broadwell

This library is free software; you can redistribute it and/or modify it under
the Artistic License 2.0.

=end pod

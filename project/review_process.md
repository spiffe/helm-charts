<!-- vim: filetype=markdown colorcolumn=80
-->

# Helm Charts Review Process

While no process can completley cover every detail of a review, the review
process does have minimum standards.

All previously existing unit tests must pass or be updated.  Reviewser should
take a dim view on the following actions to achieve this goal:

- Mass removal of unit tests without replacing them with modern counterparts.

## Unit Testing of Pull Requests

We recommend that each reviewer has a directory dedicated for each specific
pull request being reviewed.  The directory can be populated from helm-chart
repository with the command

```
git clone https://github.com/spiffe/helm-charts.git review_name_directory
```

After changing into the newly created directory, a reviewer needs to grab the
changes in the pull request.  This is achieved with the command.

```
git fetch origin pull/${PULL_REQUEST_NUMBER}/head:MASTER
```

From this point, one should be able to run the unit tests from the top level
Makefile, with the command

```
make unit-test; if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi
```

Note the output of the makefile for errors or warnings; and, act on them
accordingly.  No pull request should fail a "make unit-test" run.

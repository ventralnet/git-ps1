. ../src/git-util.sh

CWD=`pwd`

setUp() {
  mkdir ${SHUNIT_TMPDIR}/git-utils
  cd ${SHUNIT_TMPDIR}/git-utils
}

tearDown() {
  rm -rf ${SHUNIT_TMPDIR}/git-utils
  cd $CWD
}

test_currentBranchShouldDisplayCurrentBranch() {
  git init
  git checkout -b my_branch
  local r=`__current_branch`
  assertEquals '__current_branch should be my_branch' $r 'my_branch'
}

test_currentBranchIsBlankIfNotAGitRepository() {
  local r=`__current_branch`
  assertEquals '__current_branch should be empty when not in a git repo' "${r}" "" 
}

test__has_staged_returnsEmptyStringIfNoStagedFiles() {
  git init
  touch a
  local r=`__has_staged`
  assertEquals '__has_staged should return an empty string if no staged files' "${r}" ""
}

test__has_staged_returnsTrueStringIfStagedFiles() {
  git init
  touch a
  git add a
  local r=`__has_staged`
  assertEquals '__has_staged should return an empty string if no staged files' "${r}" ""
}

test__has_untracked_returnsEmptyStringIfBranchIsClean() {
  git init
  local r=`__has_untracked`
  assertEquals '__has_untracked should return empty string if branch has no untracked' "${r}" ""
}

test__has_untracked_returnsEmptyStringIfBranchHasStaged() {
  git init
  touch a
  git add a
  local r=`__has_untracked`
  assertEquals '__has_untracked should return empty string if branch has staged' "${r}" ""
}

test__has_untracked_returnsTrueStringIfUntracked() {
  git init
  touch a
  local r=`__has_untracked`
  assertEquals '__has_untracked should return true string if branch untracked' "${r}" "true"
}

test__is_dirty_returnsEmptyStringIfBranchIsClean() {
  git init
  local r=`__is_dirty`
  assertEquals '__is_dirty should return empty string if branch is not dirty' "${r}" ""
}

test__is_dirty_returnsTrueStringIfBranchHasStagedFiles() {
  git init
  touch a
  git add a
  local r=`__is_dirty`
  assertEquals '__is_dirty should return true string if branch has staged' "true" ${r}
}

test__is_dirty_returnsTrueStringIfBranchHasChangedFiles() {
  git init
  touch a
  git add a
  git commit -m 'tmp' 2>&1 > /dev/null
  echo 'hello' > a
  local r=`__is_dirty`
  assertEquals '__is_dirty should return true string if branch has staged' "true" ${r}
}

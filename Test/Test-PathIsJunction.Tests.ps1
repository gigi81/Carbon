# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function Start-TestFixture
{
    & (Join-Path -Path $PSScriptRoot -ChildPath '..\Import-CarbonForTest.ps1' -Resolve)
}

function Invoke-TestPathIsJunction($path)
{
    return Test-PathIsJunction $path
}

function Test-ShouldKnowFilesAreNotReparsePoints
{
    $result = Test-PathIsJunction $TestScript
    Assert-False $result 'Detected a file as being a reparse point'
}

function Test-ShouldKnowDirectoriesAreNotReparsePoints
{
    $result = Invoke-TestPathIsJunction $PSScriptRoot
    Assert-False $result 'Detected a directory as being a reparse point'
}

function Test-ShouldDetectAReparsePoint
{
    $reparsePath = Join-Path $env:Temp ([IO.Path]::GetRandomFileName())
    New-Junction $reparsePath $PSScriptRoot
    $result = Invoke-TestPathIsJunction $reparsePath
    Assert-True $result 'junction not detected'
    Remove-Junction $reparsePath
}

function Test-ShouldHandleNonExistentPath
{
    $result = Invoke-TestPathIsJunction ([IO.Path]::GetRandomFileName())
    Assert-False $result 'detected a non-existent junction'
    Assert-Equal 0 $error.Count 'there were errors detecting a non-existent junction'
}

function Test-ShouldHandleHiddenFile
{
    $tempDir = New-TempDir -Prefix (Split-Path -Leaf -Path $PSCommandPath)
    $tempDir.Attributes = $tempDir.Attributes -bor [IO.FileAttributes]::Hidden
    $result = Invoke-TestPathIsJunction $tempDir
    Assert-False $result
    Assert-NoError
}

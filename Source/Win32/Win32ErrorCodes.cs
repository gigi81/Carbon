// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//  
//    http://www.apache.org/licenses/LICENSE-2.0
//   
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

namespace Carbon.Win32
{
    internal static class Win32ErrorCodes
    {
        internal const int AccessDenied             = 0x005;
        internal const int InvalidHandle            = 0x006;
        internal const int InvalidParameter         = 0x057;
        internal const int InsufficientBuffer       = 0x07A;
        internal const int InvalidFlags             = 0x3EC;
        internal const int ServiceMarkedForDelete   = 0x430;
        internal const int NoneMapped               = 0x534;
    }
}


// Copyright (C) 2019-2023 Aleo Systems Inc.
// This file is part of the Leo library.

// The Leo library is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// The Leo library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with the Leo library. If not, see <https://www.gnu.org/licenses/>.

mod cli;
pub use cli::*;

mod commands;
pub use commands::*;

mod helpers;
pub use helpers::*;

mod query_commands;
pub use query_commands::*;

pub(crate) type CurrentNetwork = snarkvm::prelude::MainnetV0;
pub(crate) const SNARKVM_COMMAND: &str = "snarkvm";

#[cfg(test)]
mod tests;

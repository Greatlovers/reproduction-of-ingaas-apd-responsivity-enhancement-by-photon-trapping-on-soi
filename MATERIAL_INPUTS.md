# Material inputs intentionally omitted

This snapshot excludes every `*.par` file, `optical_inputs.json` n/k tables and material-input generation scripts. The same exclusion applies to the Release backup. Inputs have not been embedded in replacement scripts or renamed data files.

The EMW projects reference `emw.par`; the electrical projects reference `sdevice.par` and use `DefaultParametersFromFile`. The originals used the locally installed X-2025.06 database plus project overrides. Neither the proprietary database nor the project override cards are distributed. The scripts therefore cannot independently reproduce the numerical results from the public files alone. Supply legally obtained, compatible material inputs and audit them before running. The recorded parameter-file hashes identify the historical inputs; hashes do not reconstruct them.

The methods describe assumptions such as SRH lifetime, interface recombination and a single common avalanche calibration factor so that readers can assess the study. They are not a complete material card. Public `model_basis.json` files omit the explicit literature ionization-coefficient dictionaries. Reference: Chen et al., 2017, Table 1, https://pmc.ncbi.nlm.nih.gov/articles/PMC5236056/ .

Native TDR/PLT files in the Release are solver outputs, not replacement material parameter files. CSV plotting works without Sentaurus or material inputs. A full byte-for-byte copy of the private simulation workspace is not claimed: excluded inputs, logs, paper references and local runner files remain in the original workspace.

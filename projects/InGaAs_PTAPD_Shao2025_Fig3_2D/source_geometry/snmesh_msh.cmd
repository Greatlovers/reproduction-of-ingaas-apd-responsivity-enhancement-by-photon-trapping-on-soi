#setdep @previous@
IOControls {
  EnableSections
  EnableEMW
  inputFile = "@tdrboundary@"
  outputFile = "@tdr/o@"
}
Tensor {
  Mesh {
    maxCellSize = @<Mesh_nm*0.001>@
    minCellSize = @<Mesh_nm*0.0002>@
    maxBndCellSize = @<Mesh_nm*0.001>@
    minBndCellSize = @<Mesh_nm*0.0002>@
    grading off
  }
  EMW {
    parameter filename = "emw.par"
    wavelength = 1.520
    ComplexRefractiveIndex WavelengthDep Real Imag
    NPW = 12
    grading off
  }
}

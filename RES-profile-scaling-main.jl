## Step 0: Activate environment - ensure consistency accross computers
using Pkg
Pkg.activate(@__DIR__) # @__DIR__ = directory this script is in
Pkg.instantiate() # Download and install this environments packages
Pkg.precompile() # Precompiles all packages in environemt

using DataFrames
using Dates
using CSV
using JuMP
using Plots
using Statistics
using AmplNLWriter, Bonmin_jll
using TOML
using Pipe

printstyled("Including the external scripts", color=Base.info_color(), bold=true)
include("constants.jl") # Include the constants script
include("functions.jl") # Include the functions script

print_message("Reading the data", level=1)
print_message("Activating the environment", level=2)

# Parse the input data configuration file
@time begin
    print_message("Parsing the config file")
    
    data = TOML.parsefile(CONFIG_FILE_NAME)
    inputs     = data[INPUTS_CONFIG_KEY]
    outputs    = data[OUTPUT_CONFIG_KEY]
    
    print_message("Elapsed time parsing input data", level=2)
end

# Scale the list of profile files
@time begin
    scale_list_of_profile_files(inputs, outputs)
end
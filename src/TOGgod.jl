module TOGgod

export TOGAPI, update

using Pkg, StaticArrays, RemoteREPL, Serialization
using LoopOS, TOGLearning, TOGZMQClient, TOGREPL, TOGCommunicationClient
using TOGOctahedron: Octahedron
using TOG: T, ○

const TOGAPI = Ref("")
const OCTAHEDRON = Ref{Octahedron}()

CONFIG = Dict{String,Any}()
function awaken(; name::String, router::String, pub::String, tog::String, replport::Integer)
    CONFIG["name"] = name
    CONFIG["router"] = router
    CONFIG["pub"] = pub
    CONFIG["tog"] = tog
    CONFIG["replport"] = replport
    # cd(name)
    Pkg.activate(joinpath(DEPOT_PATH[1], "dev", name))
    @show pwd(), name
    @show Base.active_project()
    @show Pkg.status()
    TOGCommunicationClient.awaken(name=name, router=router, pub=pub)
    @show "TOGCommunicationClient.start"
    TOGZMQClient.awaken(tog)
    @show "TOGZMQClient.start"
    TOGAPI[] = String(TOGZMQClient.call(:api))
    # @show collect(keys(LoopOSTOGZMQClient.LoopOSZMQAPIClient.FUNCTIONS))
    # @show togtime()
    @show "TOGAPI", TOGAPI[]
    invϕ = one(T) / MathConstants.golden
    OCTAHEDRON[] = Octahedron(
        t=togtime(),
        d=SA[invϕ, invϕ^2, invϕ^3, invϕ^4],
        ẑeroμ=SA[zero(T), ○, ○, ○],
        ôneμ=SA[zero(T), ○, ○, ○],
        ρ=SA[typemin(T), typemin(T), typemin(T), typemin(T)],
        ♯=(10^3, 10^3))
    @show OCTAHEDRON[]
    @eval using $(Symbol(name))
    @show "using Symbol(name)"
    LoopOS.awaken(getfield(name, intelligence))
    @show "LoopOS.awaken"
    @async serve_repl(replport)
    @show "serve_repl", replport
    TOGREPL.awaken()
    0
end

# function awaken(; name, group, router, pub, tog)
#     currentdir = pwd()
#     while basename(pwd()) ≠ TOGInstall.TOG
#         cd("..")
#     end
#     TOGInstall.awaken(name=name, group=group, router=router, pub=pub, tog=tog)
#     cd(currentdir)
# end

function learn(; name::String, files=String[], pkgs=String[], rmfiles=String[], rmpkgs=String[], mvfiles=false, githubuser=get(ENV, "GITHUB_USER", ""), githubauth=get(ENV, "GITHUB_AUTH", ""))
    updatepkg(name=name, files=files, pkgs=pkgs, rmfiles=rmfiles, rmpkgs=rmpkgs, mvfiles=mvfiles, githubuser=githubuser, githubauth=githubauth)
    Pkg.update()
    serialize(".short", LoopOS.short())
    TOGInstall.awakengod(name=CONFIG["name"], group=CONFIG["group"], router=CONFIG["router"], pub=CONFIG["pub"], tog=CONFIG["tog"])
    exit(0)
end

# function parse_commandline()
#     s = ArgParseSettings()
#     @add_arg_table s begin
#         # "--update"
#         # action = :store_true
#         # "names"
#         # nargs = '*'
#         # arg_type = String
#         # default = ["i", "Dona", "Janet"]
#         # default = ["i"]
#     end
#     return parse_args(s)
# end
# checkdir() = (basename(pwd()) == TOG && isdir(TOGDIR)) || error("Run tog in a $TOG folder. Run $TOGINSTALLSCRIPT to create a new $TOG folder.")
# function (@main)(universe)
    # config = parse_commandline()
    # checkdir()
    # julia(
    #     dir=".",
    #     code="""using $(@__MODULE__);$(@__MODULE__).awakenGOD($(config["names"]))"""
    # )
    # TOGOmega.awaken(name="i", router, pub, tog, replport)
# end

end

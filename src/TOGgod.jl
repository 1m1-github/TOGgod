module TOGgod

export TOGAPI, learn, LoopOS, T

using Pkg, StaticArrays, Serialization
using LoopOS, TOGLearning, TOGZMQClient, TOGCommunicationClient, TOGAwaken
using TOGREPL
using TOGOctahedron: Octahedron
using TOGOmega: t, T
using TOG: ○

const TOGAPI = Ref("")
const OCTAHEDRON = Ref{Octahedron}()
# const CONFIG = Dict{String,Any}()

function __init__()
    atexit(_ -> begin
        # serialize(".short", LoopOS.short())
        TOGAwaken.rmpid()
    end)
end

function awaken(; intelligence::Function, name="i", universe="..")
    TOGAwaken.isrunning() && error("TOGgod $name is already running.")
    TOGAwaken.writepid()
    # CONFIG["name"] = name
    # CONFIG["universe"] = universe
    # Pkg.activate(joinpath(DEPOT_PATH[1], "dev", name))
    TOGZMQClient.awaken(TOGAwaken.tog(path=universe))
    TOGCommunicationClient.awaken(name=name, dealer=TOGAwaken.router(path=universe), sub=TOGAwaken.pub(path=universe))
    TOGAPI[] = String(TOGZMQClient.call(:api))
    ϕ = MathConstants.golden
    OCTAHEDRON[] = Octahedron(
        t=t(),
        d=SA[ϕ^-1, ϕ^-2, ϕ^-3, ϕ^-4],
        ẑeroμ=SA[zero(T), ○, ○, ○],
        ôneμ=SA[zero(T), ○, ○, ○],
        ρ=SA[T(0.01), T(0.01), T(0.01), T(0.01)],
        ♯=(10^3, 10^3))
    # Pkg.add(name)
    # Pkg.resolve()
    # Pkg.instantiate()
    # @eval using $(Symbol(name))
    # @show "using Symbol(name)"
    # LoopOS.awaken(getfield(name, intelligence))
    LoopOS.awaken(intelligence)
    # @show "LoopOS.awaken"
    # @async serve_repl(replport)
    # @show "serve_repl", replport
    TOGREPL.awaken()
    # 0
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
    # todo start new god
    # TOGInstall.awakengod(name=CONFIG["name"], group=CONFIG["group"], router=CONFIG["router"], pub=CONFIG["pub"], tog=CONFIG["tog"])
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

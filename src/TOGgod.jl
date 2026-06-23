module TOGgod

export learn, LoopOS

using Pkg, StaticArrays, Serialization
using LoopOS, TOGObserveClient, TOGCreateClient, TOGLearning, TOGCommunicationClient, TOGAwaken, TOGLogging, TOGREPL
using TOGOctahedron: Octahedron
using TOG: ○

const T = Ref{DataType}()
const OCTAHEDRON = Ref{Octahedron}()
# const CONFIG = Dict{String,Any}()

__init__() = atexit(sleep)
function sleep()
    TOGAwaken.sleep()
end
function awaken(; intelligence::Function, name="i", universe="..")
    TOGLogging.awaken()
    TOGAwaken.awaken()
    # CONFIG["name"] = name
    # CONFIG["universe"] = universe
    TOGObserverClient.awaken(TOGAwaken.togobserve(path=universe))
    TOGObserverClient.awaken(TOGAwaken.togcreate(path=universe))
    # TOGCommunicationClient.awaken(name=name, dealer=TOGAwaken.router(path=universe), sub=TOGAwaken.pub(path=universe))
    T[] = TOGObserveClient.togtype()
    ϕ = MathConstants.golden
    OCTAHEDRON[] = Octahedron(
        t=TOGObserveClient.togtime(),
        d=SA[ϕ^-1, ϕ^-2, ϕ^-3, ϕ^-4],
        ẑeroμ=SA[zero(T[]), ○(T[]), ○(T[]), ○(T[])],
        ôneμ=SA[zero(T[]), ○(T[]), ○(T[]), ○(T[])+T[](0.1)],
        ρ=[zero(T[]), T[](0.1), T[](0.1), zero(T[])],
        ♯=(1, 1))
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
    serialize(".tog/short", LoopOS.short())
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

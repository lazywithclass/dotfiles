import os, socket
import ycm_core

def FindRoot(curdir):
    while '.git' not in os.listdir(curdir) and curdir != '/':
        curdir = os.path.relpath(os.path.join(curdir, os.pardir))

    return os.path.realpath(curdir) if curdir != '/' else os.getcwd()

def FindAllDirs(root):
    cpproot = os.path.join(root, 'code', 'cpp', 'src')
    dirs = []
    for d in os.listdir(cpproot):
        if d.startswith('n2os'):
            dirs.append(d)
        elif d == 'deps':
            dirs += [os.path.join(d, dep) for dep in os.listdir(os.path.join(cpproot, d))]
            dirs += [os.path.join(d, dep, 'include') for dep in os.listdir(os.path.join(cpproot, d))
                     if os.path.isdir(os.path.join(d, dep, 'include'))]
        elif d == 'test':
            dirs.append(d)

    return tuple(['-I' + os.path.join(cpproot, d) for d in dirs])

root = FindRoot(os.getcwd())

global_flags = (
    '-std=c++14',
    '-Wall',
    '-Wextra',
    '-Wno-unused-parameter',
    '-pedantic',
    '-DRAPIDJSON_HAS_STDSTRING'
) + FindAllDirs(root)

def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
    if not working_directory:
        return list( flags )
    new_flags = []
    make_next_absolute = False
    path_flags = ( '-isystem', '-I', '-iquote', '--sysroot=' )

    for flag in flags:
        new_flag = flag
        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith( '/' ):
                new_flag = os.path.join( working_directory, flag )

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith( path_flag ):
                path = flag[ len( path_flag ): ]
                new_flag = path_flag + os.path.join( working_directory, path )
                break

        if new_flag:
            new_flags.append( new_flag )

    return new_flags

def FlagsForFile( filename, **kwargs ):
    relative_to = os.path.dirname( os.path.abspath( __file__ ) )
    flags = MakeRelativePathsInFlagsAbsolute(global_flags, relative_to)

    return {
            'flags': flags,
            'do_cache': True
        }

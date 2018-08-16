# catkin_export_true_pythonpath

This package is used to populate the `PYTHONPATH` with the true path of all python packages in catkin workspaces.

## Problem
Many completion tools rely on `PYTHONPATH` to find the modules for auto-completion.
With the catkin workspace, the `PYTHONPATH` is set to `<workspace>/devel/python<xx>/dist-packages`.
This folder contains all your python packages as sub-folders.
Each folder does **not** have the actually source code, but only has an `__init__.py` inside,
which is used to locate the true path with the source code (under the `src` folder).
Unfortunately, most completion tools do not handle this well ([example](https://answers.ros.org/question/195058/autocomplete-in-eclipse-with-catkin-and-python-packages/)): 
since no source code can be found under `dist-packages`, no auto-completion can be done.

## How it works
This package reads `.catkin` under the `devel` folder of **all** the sourced workspace (extracted from `CMAKE_PREFIX_PATH`).
This file contains the paths of all packages inside the workspace (`<workspace>/src/<package>`).
Then each package path is used to construct the python source code path (`<workspace>/src/<package>/src`) as if it is a python package.
Finally, the constructed paths are prepended to the existing `PYTHONPATH`.

This is done by the [environment hook](http://docs.ros.org/jade/api/catkin/html/dev_guide/generated_cmake_api.html#catkin_add_env_hooks) provided by catkin.

## Usage
Simply copy it into your workspace. After your workspace is built, the `PYTHONPATH` will get populated every time you source your workspace.

# python function to generate ROS package path for python autocompletion based on all workspaces
PYTHON_CODE_BUILD_ROS_PACKAGE_PATH=$(cat <<EOF
from __future__ import print_function
import os
env_name = 'CMAKE_PREFIX_PATH'
paths = [path for path in os.environ[env_name].split(os.pathsep)] if env_name in os.environ and os.environ[env_name] != '' else []
workspaces = [path for path in paths if os.path.exists(os.path.join(path, '.catkin'))]
paths = []
for workspace in workspaces:
    filename = os.path.join(workspace, '.catkin')
    data = ''
    with open(filename) as f:
        data = f.read()
    if data == '':
        paths.append(os.path.join(workspace, 'share'))
        paths.append(os.path.join(workspace, 'stacks'))
    else:
        for source_path in data.split(';'):
            paths.append(os.path.join(source_path, 'src'))
print(os.pathsep.join(paths))
EOF
)
export PYTHONPATH="`/usr/bin/python -c \"$PYTHON_CODE_BUILD_ROS_PACKAGE_PATH\"`":$PYTHONPATH

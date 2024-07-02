from os import PathLike
import datetime
from typing import Union
from pathlib import Path


def get_gpu_info():
    try:
        import GPUtil
        gpus = GPUtil.getGPUs()
        return gpus[0].name if len(gpus) > 0 else 'NO GPU detected'
    except:
        return 'NO GPUtil installed'


def get_cpu_info():
    try:
        import cpuinfo
        info = cpuinfo.get_cpu_info()
        return info['brand_raw']
    except:
        return 'NO cpuinfo installed'


def get_device_info():
    return get_cpu_info(), get_gpu_info()


def prepend_timestamp_to_path(path: Union[PathLike, str]) -> str:
    path = Path(path)
    path = path.parent / f"{create_timestamp()}-{path.stem}"
    return str(path)


def create_timestamp() -> str:
    now = datetime.datetime.now()
    timestamp = now.strftime('%y%m%d-%H%M')
    return timestamp

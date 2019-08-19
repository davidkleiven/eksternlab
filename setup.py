from setuptools import setup, find_packages

setup(
    name='eksternlab',
    description='Useful scripts for NTNU lab for engineers',
    version=1.0,
    author='David Kleiven',
    url='https://github.com/davidkleiven/eksternlab',
    download_url='https://github.com/davidkleiven/eksternlab/archive/v1.0.tar.gz',
    author_email='david.kleiven@ntnu.no',
    packages=find_packages(),
    classifiers=[
        'Development Stats :: 4 - Beta',
        'Intended Audience :: Students',
        'Topic :: Data analysis :: Post processing Tools',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 2.7'
    ]
)

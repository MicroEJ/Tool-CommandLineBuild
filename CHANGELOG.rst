..
	Copyright 2020-2021 MicroEJ Corp. All rights reserved.
	Use of this source code is governed by a BSD-style license that can be found with this software.

=========
Changelog
=========

All notable changes to this project will be documented in this file.

The format is based on `Keep a Changelog <https://keepachangelog.com/en/1.0.0/>`_, and this project adheres to `Semantic Versioning <https://semver.org/spec/v2.0.0.html>`_.

------------------
2.2.0 - 2021-05-26
------------------

Deprecated
==========

- This project is deprecated starting from MicroEJ SDK ``5.4.0``. 

Added
=====

- Fallback to ``JAVA_HOME`` if ``MICROEJ_BUILD_JDK_HOME`` is not defined.

Changed
=======

- Determine script path from ``%~dp0`` instead of ``%cd%``.  This allows the script to be called from any directory.

Fixed
=====

- Force the use of JDT Compiler.  This is for MICROEJ SDK version lower than 5.2.0.
- Set default value of microej.buildtypes.repository.dir to avoid cyclic variable definition error.

------------------
2.1.1 - 2020-12-10
------------------

Fixed
=====

- Forward the `microej.buildtypes.repository.dir` in forked mode.

------------------
2.1.0 - 2020-10-30
------------------

Added
=====

- New shell script ``build_module_local.sh`` for building modules on GNU/Linux.

Fixed
=====

- Fix the printed usage in Windows batch file, since the ``BUILD_MODE`` argument is optional.

Changed
=======

- Rewrite the ``README.rst`` to add GNU/Linux support.

------------------
2.0.1 - 2020-09-16
------------------

Fixed
=====

- ``ivysettings-artifactory.xml`` repository names with the ones used in `tutorials <https://docs.microej.com/en/latest/Tutorials/index.html>`_  

------------------
2.0.0 - 2020-09-11
------------------

Initial Github version, derived from the formerly called *MicroEJ CI Bundle* version ``1.3.2``.

Added
=====

- MicroEJ SDK ``5.2.0`` compliance.
- Minimal Ant entrypoints for building modules.
- Settings files for local and Artifactory environments.
- ``README.rst`` document on how to setup the MicroEJ build kit to build a module using the command line.


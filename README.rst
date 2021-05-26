..
	Copyright 2018-2021 MicroEJ Corp. All rights reserved.
	Use of this source code is governed by a BSD-style license that can be found with this software.

**WARNING**: this project is deprecated starting from MicroEJ SDK ``5.4.0``. 
Please use the `MicroEJ Module Manager Build Kit <https://docs.microej.com/en/latest/ApplicationDeveloperGuide/mmm.html#build-kit>`_ instead.

Description
-----------

This project details how to setup a local environment for building MicroEJ modules from the command line. 

It focuses on running on Windows operating system and can be adapted for other operating systems supported by MicroEJ SDK (Linux and MacOS).

Requirements
------------

*  Windows OS ``7`` or higher.
*  Java Development Kit (JDK) ``1.8.x``.
*  MicroEJ SDK ``4.1.5`` to ``5.3.1``. 

The latest MicroEJ SDK version can be downloaded at https://developer.microej.com/get-started/.

Prerequisites
-------------

#. Locate your JDK installation directory (typically something like ``C:\Program Files\Java\jdk1.8.0_[version]`` on Windows or ``/usr/lib/jvm/java-[version]-openjdk-amd64/jre`` on GNU/Linux)
#. Set the environment variable ``MICROEJ_BUILD_JDK_HOME`` to point to this directory.
#. Clone this repository with ``git clone --recursive https://github.com/MicroEJ/Tool-CommandLineBuild``.


Extract MicroEJ Build Kit
-------------------------

MicroEJ SDK comes with its own toolkit for building modules. 

Depending on your MicroEJ SDK version, extracting the build kit from the SDK will differ.
Please consult https://docs.microej.com/en/latest/overview/editions.html#get-sdk-version to determine your MicroEJ SDK version.

MicroEJ SDK ``5.2.0`` or higher
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
#. Create a directory named ``buildKit`` in the same directory as this ``README`` file.
#. In the SDK, go to ``Window`` > ``Preferences`` > ``MicroEJ`` > ``Module Manager``.
#. In subsection ``Build repository``, click on ``Export Build Kit``.
#. As ``Target directory``, choose the ``buildKit`` directory, then click on ``Finish``.
#. Go to directory ``buildKit`` and extract the content of the file ``microej-build-repository.zip`` to a directory named ``microej-build-repository``. 


MicroEJ SDK ``5.1.0`` or lower
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Create a directory named ``buildKit`` in the same directory as this ``README`` file.
#. Create a sub-directory ``ant`` in the ``buildKit`` directory.
#. Locate your SDK installation directory (by default, ``C:/Program Files/MicroEJ/MicroEJ SDK-[version]``).
#. Within the SDK installation directory, go to the bundled RCP plugins directory (``/rcp/plugins/``).
#. Extract the toolkit runtime:
    #. Open the file ``com.is2t.eclipse.plugin.easyant4e_[version].jar`` with an archive manager.
    #. Extract the directory ``lib`` to the ``buildKit/ant/`` directory.
#. Extract the toolkit repositories:
    #. Open the file ``com.is2t.eclipse.plugin.easyant4e.offlinerepo_[version].jar`` with an archive manager
    #. Navigate to directory ``repositories``
    #. Extract the file ``microej-build-repository.zip`` (or ``is2t_repo.zip`` for MicroEJ SDK ``4.1.x``) to the ``buildKit`` directory.
    #. Go to directory ``buildKit`` and extract the content of the file ``microej-build-repository.zip`` (or ``is2t_repo.zip``) to a directory named ``microej-build-repository``.


At this point, the content of the directory ``buildKit`` should look like the following:
   ::

    buildKit
    ├── ant
    │   └── lib
    │        ├── ant.jar
    │        ├── ant-launcher.jar
    │        └── ...
    ├── microej-build-repository
    │   ├── ant-contrib
    │   ├── be
    │   └── ...


Configure the Module Repository
-------------------------------

A Module Repository is a portable ZIP file that bundles a set of modules for extending the MicroEJ development environment. For more information about Module Repositories, please refer to the `Application Developer Guide <https://docs.microej.com/en/latest/ApplicationDeveloperGuide/repository.html>`_.

In the following, we will use the MicroEJ Central Repository, which is the Module Repository used by MicroEJ SDK to fetch dependencies when starting an empty workspace.
It bundles Foundation Library APIs and numerous Add-On Libraries.

Import the MicroEJ Central Repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Next step is to import a local copy of this repository:

#. Visit the `Central Repository <https://developer.microej.com/central-repository/>`_ on the MicroEJ Developer website.
#. Navigate to the ``Working Offline`` section.
#. Click on the ``offline repository`` link. This will download the Central Repository as a zip file.
#. Unzip this file.
#. Open the file ``local-build.properties`` located in the same directory as this README.
#. Set the value of the property ``microej.central.repository.dir`` to be the absolute path to the extracted directory. **Important note**: ensure that the path uses Unix directory separator (``/``).


Set the Build Repository Location
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Personal builds will be published to ``~/.ivy2/repository/`` by default. For Release and Snapshot builds, the repositories location needs to be set manually.

#. Open the file ``local-build.properties``.
#. Set the value of the property ``snapshot.repository.dir`` to be the absolute path to a directory where ``snapshot`` builds will be published. **Important note**: ensure that the path uses Unix directory separator (``/``).
#. Set the value of the property ``release.repository.dir`` to be the absolute path to a directory where ``release`` builds will be published. **Important note**: ensure that the path uses Unix directory separator (``/``).


Create a New MicroEJ Module
---------------------------

In this example, we will create a very simple module using the Sandbox Application buildtype (``build-application``).

#. Start MicroEJ SDK.
#. Go to ``File`` > ``New`` > ``MicroEJ Sandboxed Application Project``.
#. Fill in the template fields and click ``Finish``. This will create the project files and structure.
#. In the ``Package Explorer`` view, right-click on the project and select ``Properties``.
#. In the ``Resources`` entry, copy the absolute path to your module (field ``Location``), it will be used in the next section.

For more details about MicroEJ applications development, refer to the `Application Developer Guide <https://docs.microej.com/en/latest/ApplicationDeveloperGuide/index.html>`_.


Build the Module
----------------

#.  Open a terminal from the directory of this README.
#.  Type the following command (on Windows):

- on Windows:

   ``.\build_module_local.bat \path\to\module snapshot``

- on GNU/Linux:

   ``./build_module_local.sh /path/to/module snapshot``

The build starts.
On successful build, the module is published to ``[snapshot.repository.dir]/[organization]/[module]/[M.m.p-RCYYYYMMDDHHmm]``.

Please note that executing the command ``build_module_local.[bat|sh]`` with no arguments will print the usage description.


Available Build Modes
~~~~~~~~~~~~~~~~~~~~~

* ``personal``: Fetches module dependencies in the personal, snapshot and release repositories and publish the module in the user's personal repository.
* ``snapshot``: Fetches module dependencies in the snapshot and release repositories and publish the module in the snapshot repository.
* ``fetchRelease``: Fetches module dependencies in the release repositories and publish the module in the snapshot repository.
* ``release``: Fetches module dependencies in the release repositories and publish the module in the release repository.


Build Options
~~~~~~~~~~~~~

Providing custom build options is possible by specifying an additional properties file. 
Create a file listing all the custom properties prefixed with ``easyant.inject.``. 
Then build the module with the following command:

- on Windows

    ``.\build_module_local.bat \path\to\module snapshot \path\to\custom\build.properties``

- on GNU/Linux

    ``./build_module_local.sh /path/to/module snapshot /path/to/custom/build.properties``

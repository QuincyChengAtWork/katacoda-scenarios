
# Setup OpenShift

The OpenShift environment is prepared for you.
Once the prompt is shown, you can verify it by executing:

`oc version`{{execute}}


# Logging in to the Cluster
When the OpenShift playground is created you will be logged in initially as a cluster admin on the command line. This will allow you to perform operations which would normally be performed by a cluster admin.

Before creating any applications, it is recommended you login as a distinct user. This will be required if you want to log in to the web console and use it.

To login to the OpenShift cluster from the Terminal run:

`oc login -u developer -p developer [[HOST_SUBDOMAIN]]-8443-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

Use insecure connections? (y/n): `y`{{execute}}

This will log you in using the credentials:

Username: `developer`

Password: `developer`

Use the same credentials to log into the web console.

In order that you can still run commands from the command line as a cluster admin, the sudoer role has been enabled for the developer account. To execute a command as a cluster admin use the --as system:admin option to the command. For example:


# Running Images as a Defined User
By default OpenShift prohibits images from running as the root user or as a specified user. Instead, each project is assigned its own unique range of user IDs that application images have to run as.

If you attempt to run an arbitrary image from an external image registry such a Docker Hub, which is not built to best practices, or requires that it be run as root, it may not work as a result.

In order to run such an image, you will need to grant additional privileges to the project you create to allow it to run an application image as any user ID. This can be done by running the command:

`oc adm policy add-scc-to-user anyuid -z default -n myproject --as system:admin`{{execute}}

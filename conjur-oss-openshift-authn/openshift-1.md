
# Setup OpenShift

The OpenShift environment is prepared for you.
Once the prompt is shown, you can verify it by executing:

`oc version`{{execute}}


# Running Images as a Defined User
By default OpenShift prohibits images from running as the root user or as a specified user. Instead, each project is assigned its own unique range of user IDs that application images have to run as.

If you attempt to run an arbitrary image from an external image registry such a Docker Hub, which is not built to best practices, or requires that it be run as root, it may not work as a result.

In order to run such an image, you will need to grant additional privileges to the project you create to allow it to run an application image as any user ID. This can be done by running the command:

`oc adm policy add-scc-to-user anyuid -z default -n myproject --as system:admin`{{execute}}

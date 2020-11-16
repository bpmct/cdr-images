# hackazon-project
A custom Coder image with [Hackazon](https://github.com/rapid7/hackazon), a vulnerable web app. Users can just launch a hackazon environment and begin finding and resolving security vulnerabilities, no need to set up anything!

## Coder features used
- ✅  Multi-editor (PhpStorm IDE in the web browser)
- ✅  Services (sidecar containers)
- ✅  Dev URLs (access Hackazon and share)
- ✅  Custom images (Configure once, use in many environments)

## Adding hackazon to your Coder deployment
These are steps that an admin would have to do to make Hackazon avalible for all users in the organization. After this, anyone can simply create a hackazon environment.

If you don't have a license, you can get [one for free](https://info.coder.com/coder-sign-up) for up to 10 users. That is great for testing projects like this!

### Step 1: Add hackazon image
Environments are based off Docker images. You can use the one hosted on the Docker Hub [Docker Hub](https://hub.docker.com/r/bencdr/hackazon-project), or customize the [Dockerfile](Dockerfile) and add it to your own registry.
![Coder add image screen with bencdr/hackazon as an image](https://user-images.githubusercontent.com/22407953/99199967-ac91f880-2770-11eb-8abf-df3a4e2498a0.png)

### Step 2: Add MySQL 5.6 image
Hackazon requires an older version of MySQL, Coder to the rescue! With containers+cloud workspaces, dealing with dependencies is no longer a problem!
![Coder adding MySQL image](https://user-images.githubusercontent.com/22407953/99200160-b49e6800-2771-11eb-824d-9e6b79b5ed6d.png)

### Step 3: Add the MySQL service
Configure a service so that mysql can be attached to hackazon environments. 
![Coder new service screen](https://user-images.githubusercontent.com/22407953/99200960-88d1b100-2776-11eb-8c27-d6f91965fe06.png)

### Step 4: Add the XSStrike service (optional)
Allow users to add XSStrike, a vulnerability detection tool, to their environments. Simply terminal into the service and type `python xsstrike.py` to use the tool. I am using[femtopixel/xsstrike](https://hub.docker.com/r/femtopixel/xsstrike) from the Docker Hub.

The entrypoint for the service is `/bin/sh` so the user can run XSStrike at will, it does not need to be running in the background.

![Coder service config for XSStrike](https://user-images.githubusercontent.com/22407953/99201398-cd5e4c00-2778-11eb-8545-3082f09a11b6.png)

### Step 5: Create your first hackazon environment 🚀
All of the Coder users in your organization can now create environments and start hacking! Don't forget to attach the MySQL service you added.

---

![Create hackazon environment GIF](https://user-images.githubusercontent.com/22407953/99202732-1c5ab000-277e-11eb-8cdb-4a2f0b77ab4f.gif)

---

Feel free to contribute, or [reach out on Slack](https://cdr.co/join-community) if you have any questions.

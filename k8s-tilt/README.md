# k8s-tilt

A Coder image that includes [Tilt](https://tilt.dev) + a local Kind cluster. Simply use this image and run `tilt up` in a project folder to start developing with Tilt. Create a Dev URL on port 10350 or set up SSH tunneling to access the Tilt Ui.

Image name: `bencdr/k8s-tilt:latest`

## Extending
To add more dependencies for your project, create another image. See the [k8t-tilt-example-java](../k8t-tilt-example-java/Dockerfile) Dockerfile as an example.
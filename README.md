<h3 align="center">fullstack-demo</H3>
<p align="center">Demonstration of a Spring Boot + ReactJS application, with environments managed by terraform</p>

## Disclaimer

Note that this demonstration does not necessarily follow best practices - it is intended to demonstrate a full stack application consisting of a Spring Boot backend and a ReactJS frontend, with environments managed by Terraform.

If you have feedback or suggestions, please feel free to open an issue or a pull request.


## Project structure

```
├───apps
│   ├───backend
│   └───frontend
└───infrastructure
```

## Releasing a new version

1. Change the backend version in the [build.gradle](apps/backend/build.gradle) file

2. Change the frontend version in the [package.json](apps/frontend/package.json) file

3. Stage and commit the changes to git

4. Tag the previous commit with a version number (e.g. `v1.0.0`)

```
git tag -a v1.0.0 -m "Release version v1.0.0"
```

5. Push the changes to GitHub, including tags using:

```bash
git push
git push --tags
```

## Creating a new environment

The terraform code is split into two modules, in which the `core` module is expected to be run manually as it involves creating a namespace for the environment and a workflow service account to use for pipelines. The Service Account role is rather permissive, and could probably be reduced to only the required permissions. 

You can create a new environment by running the following command: 

```bash
terraform apply -target=module.core -var="environment_name=<env_name>"
```

Terraform uses the current context in your `~/.kube/config` file to determine which cluster to make changes to, make sure it's the correct one and that you have the necessary permissions. 


The `app` module is expected to be run automatically by a pipeline, and will create the remaining resources for the environment. 
In this demonstration that includes: a Spring Boot app and a React App.

## License

Distributed under the [MIT License](LICENSE).

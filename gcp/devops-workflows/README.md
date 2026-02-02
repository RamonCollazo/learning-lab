# Implement DevOps Workflows in Google Cloud: Challenge Lab | GSP330

This is my step by step on the lab [Implement DevOps Workflows in Google Cloud: Challenge Lab](https://partner.skills.google/paths/83/course_templates/716/labs/598755)

This lab is a challenge lab, meaning that instead of following a step-by-step instruction, it must be figured out with the skills learned to be able to complete the tasks.

Tasks include the following:

- Creating a GKE cluster based on a set of configurations provided.
- Creating a GitHub Repository to host your Go application code.
- Creating Cloud Build Triggers that deploy a production and development application.
- Pushing updates to the app and creating new builds.
- Rolling back the production application to a previous version.

Overall, create a simple CI/CD pipeline using GitHub Repositories, Artifact Registry, and Cloud Build.

## Setup and requirements

```bash
export CLUSTER_NAME=hello-cluster
export ZONE=$(gcloud compute project-info describe \
  --format="value(commonInstanceMetadata.items[google-compute-default-zone])")
export REGION=$(gcloud compute project-info describe \
  --format="value(commonInstanceMetadata.items[google-compute-default-region])")
export REPO=my-repository
export PROJECT_ID=$(gcloud config get-value project)
```


## Task 1. Create the lab resources

1. Enable the APIs for GKE, Cloud Build, and GitHub Repositories:

```bash
gcloud services enable container.googleapis.com \
    cloudbuild.googleapis.com
    sourcerepo.googleapis.com

```

2. Add the Kubernetes Developer role for the Cloud Build service account:

```bash
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$(gcloud projects describe $PROJECT_ID \
  --format="value(projectNumber)")@cloudbuild.gserviceaccount.com --role="roles/container.developer"
```

3. Configure Git and GitHub:

```bash
curl -sS https://webi.sh/gh | sh
gh auth login
gh api user -q ".login"
GITHUB_USERNAME=$(gh api user -q ".login")
git config --global user.name "${GITHUB_USERNAME}"
git config --global user.email "${USER_EMAIL}"
echo ${GITHUB_USERNAME}
echo ${USER_EMAIL}
```

4. Create an Artifact Registry Docker repository

```bash
gcloud artifacts repositories create $REPO \
  --repository-format=docker \
  --location=$REGION
```

5. Create a GKE Standard cluster

```bash
gcloud container clusters create hello-cluster \
  --zone=$ZONE \
  --release-channel=regular \
  --cluster-version=latest \
  --enable-autoscaling \
  --num-nodes=3 \
  --max-nodes=6 \
  --min-nodes=2
```

6. Create the prod and dev namespaces

```bash
gcloud container clusters get-credentials hello-cluster \
  --zone=$ZONE
```

```bash
kubectl create ns dev
kubectl create ns prod
```

## Task 2. Create a repository in GitHub Repositories

1. Create an empty repository in GitHub

```bash
gh repo create  sample-app --private
```

2. Clone the repository

```bash
git clone https://github.com/${GITHUB_USERNAME}/sample-app.git
```

3. Copy the sample code into the sample-app directory:

```bash
cd ~
gsutil cp -r gs://spls/gsp330/sample-app/* sample-app
```

4. Replace the <your-region> and <your-zone> placeholders in the cloudbuild-dev.yaml and cloudbuild.yaml files:

```bash
for file in ~/sample-app/cloudbuild-dev.yaml ~/sample-app/cloudbuild.yaml; do
    sed -i "s/<your-region>/${REGION}/g" "$file"
    sed -i "s/<your-zone>/${ZONE}/g" "$file"
done
```

5. Make your first commit:

```bash
git init
cd ~/sample-app/
git checkout -b master
git add .
git commit -m "first commit"
git push -u origin master
```

5. Create a **dev** branch and make a commit:

```bash
git add .
git commit -m "first commit with sample code"
git push origin master
git checkout -b dev
git commit -m "first commit for dev"
git push origin dev
```

## Task 3. Create the Cloud Build Triggers

1. Create a Cloud Build Trigger for production

Use cloud console on **Cloud Build / Triggers**

#### **Production Deployment Trigger:**

| **Property**                 | **Value**        |  
| :--------------------------: | :--------------: |  
| **Name**                     | sample-app-prod-deploy |  
| **Branch Pattern**           | ^master$       |  
| **Build Configuration File** | cloudbuild.yaml |  


2. Create a Cloud Build Trigger for development

Use cloud console on **Cloud Build / Triggers**

#### **Development Deployment Trigger:**
| **Property**                 | **Value**        |  
| :--------------------------: | :--------------: |  
| **Name**                     | sample-app-dev-deploy |  
| **Branch Pattern**           | ^dev$          |  
| **Build Configuration File** | cloudbuild-dev.yaml |

## Task 4. Deploy the first versions of the application

### Build the first development deployment

1. Build and push Docker image

```bash
cd ~/sample-app
COMMIT_ID="$(git rev-parse --short=7 HEAD)"
gcloud builds submit --tag="${REGION}-docker.pkg.dev/${PROJECT_ID}/$REPO/hello-cloudbuild:${COMMIT_ID}" .
EXPORTED_IMAGE="$(gcloud builds submit --tag="${REGION}-docker.pkg.dev/${PROJECT_ID}/$REPO/hello-cloudbuild:${COMMIT_ID}" . | grep IMAGES | awk '{print $2}')"
```

2. Replace `<version>` with `v1.0` on file `cloudbuild-dev.yaml`

```bash
git checkout dev
sed -i "9c\    args: ['build', '-t', '$REGION-docker.pkg.dev/$PROJECT_ID/my-repository/hello-cloudbuild-dev:v1.0', '.']" cloudbuild-dev.yaml
sed -i "13c\    args: ['push', '$REGION-docker.pkg.dev/$PROJECT_ID/my-repository/hello-cloudbuild-dev:v1.0']" cloudbuild-dev.yaml
```

3. Replace `<todo>` with the correct container image name on `dev/deployment.yaml`

```bash
sed -i "17s|        image: <todo>|        image: $REGION-docker.pkg.dev/$PROJECT_ID/my-repository/hello-cloudbuild-dev:v1.0|" dev/deployment.yaml
```

4. Make commit and push to **dev** branch

```bash
git add .
git commit -m "sample-app v1.0"
git push -u origin dev
```

> [!NOTE]
> Wait for trigger to be completed

5. Expose development-deployment

```bash
kubectl -n dev expose deployment development-deployment --name dev-deployment-service --type LoadBalancer --port 8080 --target-port 8080
```

### Build the first production deployment

1. Replace `<version>` with `v1.0` on file `cloudbuild.yaml`

```bash
git checkout master
sed -i "11c\    args: ['build', '-t', '$REGION-docker.pkg.dev/\$PROJECT_ID/my-repository/hello-cloudbuild:v1.0', '.']" cloudbuild.yaml
sed -i "16c\    args: ['push', '$REGION-docker.pkg.dev/\$PROJECT_ID/my-repository/hello-cloudbuild:v1.0']" cloudbuild.yaml
```

2. Replace `<todo>` with the correct container image name on `prod/deployment.yaml`

```bash
sed -i "17c\        image:  $REGION-docker.pkg.dev/$PROJECT_ID/my-repository/hello-cloudbuild:v1.0" prod/deployment.yaml
```

3. Make commit and push to **master** branch

```bash
git add .
git commit -m "sample-app v1.0"
git push -u origin master
```

> [!NOTE]
> Wait for trigger to be completed

4. Expose development-deployment

```bash
kubectl -n prod expose deployment production-deployment --name prod-deployment-service --type LoadBalancer --port 8080 --target-port 8080
```

## Task 5. Deploy the second versions of the application

### Build the second development deployment

1. Switch back to the dev branch.

```bash
git checkout dev
```

2. In the `main.go` file, update the `main()`

```bash
sed -i '28a\	http.HandleFunc("/red", redHandler)' ~/sample-app/main.go
```

3. Add function inside `main.go`

```bash
sed -i '32a\
func redHandler(w http.ResponseWriter, r *http.Request) { \
	img := image.NewRGBA(image.Rect(0, 0, 100, 100)) \
	draw.Draw(img, img.Bounds(), &image.Uniform{color.RGBA{255, 0, 0, 255}}, image.ZP, draw.Src) \
	w.Header().Set("Content-Type", "image/png") \
	png.Encode(w, img) \
}' ~/sample-app/main.go
```

4. Update docker version to `v2.0` in `cloudbuild-dev.yaml`

```bash
sed -i "9c\    args: ['build', '-t', '$REGION-docker.pkg.dev/\$PROJECT_ID/my-repository/hello-cloudbuild-dev:v2.0', '.']" cloudbuild-dev.yaml
sed -i "13c\    args: ['push', '$REGION-docker.pkg.dev/\$PROJECT_ID/my-repository/hello-cloudbuild-dev:v2.0']" cloudbuild-dev.yaml
```

5. On `dev/deployment.yaml`, update the image version

```bash
sed -i "17c\        image: $REGION-docker.pkg.dev/$PROJECT_ID/my-repository/hello-cloudbuild:v2.0" dev/deployment.yaml
```

6. Make commit and push to **dev** branch

```bash
git add .
git commit -m "sample-app v2.0"
git push -u origin dev
```

> [!NOTE]
> Wait for trigger to be completed

### Build the second production deployment

1. Switch to **master** branch


```bash
git checkout master
```

2. In the `main.go` file, update the `main()`

```bash
sed -i '28a\	http.HandleFunc("/red", redHandler)' ~/sample-app/main.go
```

3. Add function inside `main.go`

```bash
sed -i '32a\
func redHandler(w http.ResponseWriter, r *http.Request) { \
	img := image.NewRGBA(image.Rect(0, 0, 100, 100)) \
	draw.Draw(img, img.Bounds(), &image.Uniform{color.RGBA{255, 0, 0, 255}}, image.ZP, draw.Src) \
	w.Header().Set("Content-Type", "image/png") \
	png.Encode(w, img) \
}' ~/sample-app/main.go
```

4. Update docker version to `v2.0` in `cloudbuild.yaml`

```bash
sed -i "11c\    args: ['build', '-t', '$REGION-docker.pkg.dev/\$PROJECT_ID/my-repository/hello-cloudbuild:v2.0', '.']" cloudbuild.yaml
sed -i "16c\    args: ['push', '$REGION-docker.pkg.dev/\$PROJECT_ID/my-repository/hello-cloudbuild:v2.0']" cloudbuild.yaml
```

5. On `prod/deployment.yaml`, update the image version

```bash
sed -i "17c\        image: $REGION-docker.pkg.dev/$PROJECT_ID/my-repository/hello-cloudbuild:v2.0" prod/deployment.yaml
```

6. Make commit and push to **master** branch

```bash
git add .
git commit -m "sample-app v2.0"
git push -u origin master
```

> [!NOTE]
> Wait for trigger to be completed

## Task 6. Roll back the production deployment

1. Roll back the production-deployment to version `v1.0`

```bash
kubectl -n prod rollout undo deployment/production-deployment
```

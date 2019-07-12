This is scenario, we will guide you on how to secure the secrets used by your application on Kubernetes, using Conjur OSS.
We will use Minikube as the base platform, and deploy Conjur OSS on it.
An simple REST API application will be deployed, and we will review its risk of having embedding password.
Last but not least, we will remove the embedded secrets and secret it using Conjur OSS.

### Agenda:
- **Setup Minikube**
  - Start Minikube
  - Review Cluster Info
  - Enabling Dashboard
  - Enabling Tunnel  
  
- **Insecure App**
  - Build 
  - Deploy
  - Usage
  - Risk of embedded secrets

- **Setup Conjur**
  - Deploy Conjur
  - Initalize Conjur
  - Change Admin Password
  - Load Policies
  - Initalize CA

- **Secure App**
  - Build
  - Deploy
  - Usage
  - No more embedded secrets

- **Secretless App**
  - Deploy Database
  - Update Conjur for secretless
  - Deploy Add with Secretless
  - Test it!

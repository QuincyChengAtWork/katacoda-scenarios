This is scenario, we will guide you on how to secure the secrets used by your application on OpenShift, using Conjur OSS.

An simple REST API application will be deployed, and we will review its risk of having embedding password.
Last but not least, we will remove the embedded secrets and secret it using Conjur OSS.

### Agenda:
- **Setup OpenShift **
  
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

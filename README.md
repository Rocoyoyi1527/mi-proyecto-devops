# mi-proyecto-devops

Proyecto de práctica DevOps — Actividad 1.  
Flujo de trabajo con **Git + GitHub + AWS S3** dentro de AWS Learner Lab.

---

## Estructura del repositorio

```
mi-proyecto-devops/
├── src/
│   ├── index.html   # Página principal del sitio estático
│   └── styles.css   # Estilos del sitio
├── deploy.sh        # Script de despliegue manual a S3
├── .gitignore
└── README.md
```

---

## Configuración inicial

### 1. Git
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tuemail@example.com"
```

### 2. AWS CLI (CloudShell / EC2 Amazon Linux 2)
```bash
aws configure
# AWS Access Key ID:     [usar credenciales de LabRole en Learner Lab]
# AWS Secret Access Key: [usar credenciales de LabRole]
# Default region:        us-east-1
# Output format:         json
```

---

## Configuración del bucket S3

```bash
# Crear bucket
aws s3 mb s3://mi-bucket-devops --region us-east-1

# Habilitar alojamiento estático
aws s3 website s3://mi-bucket-devops \
    --index-document index.html \
    --error-document index.html

# Subida inicial
aws s3 sync src/ s3://mi-bucket-devops --acl public-read
```

**URL del sitio:**  
`http://mi-bucket-devops.s3-website-us-east-1.amazonaws.com`

---

## Despliegue manual

```bash
chmod +x deploy.sh
./deploy.sh
```

El script sincroniza `src/` con el bucket, eliminando archivos obsoletos (`--delete`).

---

## Flujo de trabajo con ramas

```bash
# Crear rama para nueva funcionalidad
git checkout -b feature-update

# Hacer cambios, luego:
git add .
git commit -m "Nueva sección agregada"
git push origin feature-update

# Crear Pull Request en GitHub → revisar → merge a main
# Luego volver a desplegar:
git checkout main
git pull origin main
./deploy.sh
```

---

## Comandos útiles

| Acción | Comando |
|---|---|
| Ver estado del repo | `git status` |
| Ver ramas | `git branch -a` |
| Ver historial | `git log --oneline` |
| Listar bucket | `aws s3 ls s3://mi-bucket-devops` |
| Vaciar bucket | `aws s3 rm s3://mi-bucket-devops --recursive` |

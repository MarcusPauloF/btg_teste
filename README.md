# Empiricus Teste

Aplicativo Flutter para teste de admição do frupo BTG Pactual.

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter as seguintes ferramentas instaladas:

### 1. Flutter SDK
- **Download**: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- Selecione seu sistema operacional (Windows, macOS ou Linux)
- Siga as instruções de instalação completas

### 2. Git
- **Download**: [https://git-scm.com/](https://git-scm.com/)
- Necessário para clonar o repositório

### 3. Android Studio (para desenvolvimento Android)
- **Download**: [https://developer.android.com/studio](https://developer.android.com/studio)
- Inclui Android SDK e emulador

### 5. Um dispositivo físico ou emulador
- **Android**: Use o Android Emulator do Android Studio

## 🚀 Guia de Instalação e Execução

### Passo 1: Clonar o repositório

```bash
git clone https://github.com/MarcusPauloF/btg_teste.git
cd empiricus_teste
```

### Passo 2: Verificar instalação do Flutter

```bash
flutter doctor
```

Este comando verifica se todas as dependências estão instaladas corretamente. Resolva qualquer aviso ou erro antes de continuar.

### Passo 3: Instalar dependências do projeto

```bash
flutter pub get
```

Este comando baixará todas as dependências necessárias listadas no arquivo `pubspec.yaml`.

### Passo 4: Executar o aplicativo

**No Android Emulator:**
```bash
flutter run -d 
```

**Em um dispositivo físico conectado:**
```bash
flutter run
```

## 🔐 Credenciais de Acesso

Para acessar o aplicativo, utilize as seguintes credenciais:

| Campo | Valor |
|-------|-------|
| **Email** | `teste@empiricus.com.br` |
| **Senha** | `123456` |


## 🏗️ Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── core/
│   ├── routes/             # Definição de rotas
│   └── theme/              # Tema e estilos
└── features/
    ├── auth/               # Feature de autenticação
    └── subscriptions/      # Feature de subscrições

test/                        # Testes unitários e de widget
```



# Documentação do Projeto

## Nome do Projeto: **BdayNotify**

### Resumo do Projeto
O "BdayNotify" é um aplicativo para registrar e lembrar aniversários de contatos. O objetivo é permitir que o usuário armazene informações básicas sobre aniversários e receba lembretes para cada aniversário registrado.

### Índice
1. [Introdução](#introdução)
2. [Configuração do Ambiente](#configuração-do-ambiente)
3. [Instalação](#instalação)
4. [Estrutura do Projeto](#estrutura-do-projeto)
5. [Funcionalidades](#funcionalidades)
6. [Padrões de Código](#padrões-de-código)
7. [Dependências](#dependências)
8. [Testes](#testes)
9. [Deployment](#deployment)
10. [Manutenção e Atualizações](#manutenção-e-atualizações)
11. [Contribuição](#contribuição)
12. [Licença](#licença)

---

## Introdução
O "BdayNotify" ajuda os usuários a organizar aniversários de amigos e familiares. As funcionalidades incluem:
- Adicionar, editar e excluir aniversários.
- Visualização em listas.
- Notificações de lembrete para aniversários próximos.
  
O projeto é feito usando Flutter e pode ser facilmente adaptado para dispositivos Android e iOS.

## Configuração do Ambiente

### Pré-requisitos
1. **Flutter SDK**: Versão 3.12.0 ou superior.
2. **Dart**: Versão 2.18 ou superior.
3. **Android Studio** ou **Xcode** para testes em dispositivos.
4. Emulador ou dispositivo físico para testes.


## Instalação

1. Clone o repositório:
    ```bash
    git clone https://github.com/seu-usuario/gestor-de-aniversarios.git
    cd bdaynotify
    ```

2. Instale as dependências:
    ```bash
    flutter pub get
    ```

3. Execute o projeto em um emulador ou dispositivo:
    ```bash
    flutter run
    ```

## Estrutura do Projeto

```plaintext
gestor-de-aniversarios/
├── lib/
│   ├── main.dart                 # Arquivo principal do aplicativo
│   ├── screens/                  # Contém todas as telas do aplicativo
│   ├── models/                   # Modelos de dados do aplicativo
│   ├── services/                 # Serviços de backend e APIs
│   ├── utils/                    # Utilitários e helpers
│   └── widgets/                  # Widgets reutilizáveis
├── assets/                       # Assets do projeto (imagens, ícones, etc.)
├── pubspec.yaml                  # Arquivo de dependências do Flutter
└── README.md                     # Documentação do projeto
```

## Funcionalidades

### 1. Tela Principal
- Lista todos os aniversários.
- Opções para filtrar por mês e visualizar detalhes.

### 2. Adicionar Aniversário
- Permite adicionar nome, data e foto.
- Validação para evitar datas duplicadas.

### 3. Editar Aniversário
- Permite a edição de dados de aniversário já cadastrado.
- Possui opções de atualização e cancelamento.

### 4. Notificações
- Notifica o usuário com lembretes automáticos.

## Padrões de Código
O projeto segue os padrões da [Guia de Estilo do Flutter](https://dart.dev/guides/language/effective-dart) com as seguintes práticas adicionais:
- **Naming Convention**: CamelCase para variáveis e PascalCase para classes.
- **Arquitetura**: Utilizamos o padrão MVVM (Model-View-ViewModel) para organizar o código.
- **Widgets Reutilizáveis**: Widgets comuns são armazenados em `widgets/` para reutilização e simplificação do código.

## Dependências

Abaixo estão as principais dependências usadas:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0       # Gerenciamento de estado
  firebase_core: ^2.3.0  # Integração com Firebase
  flutter_local_notifications: ^9.5.0  # Notificações locais
  intl: ^0.18.0          # Formatação de datas

dev_dependencies:
  flutter_test:
    sdk: flutter
```

## Testes

### Tipos de Testes
- **Unitários**: Testam funções e classes isoladamente.
- **Widgets**: Validam a interface gráfica dos componentes.
- **Integração**: Testam fluxos completos.

### Executando Testes
Execute todos os testes do projeto com o comando:
```bash
flutter test
```

### Exemplo de Teste Unitário

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_de_aniversarios/models/aniversario.dart';

void main() {
  test('Deve calcular o próximo aniversário corretamente', () {
    final aniversario = Aniversario(nome: "Maria", data: DateTime(2020, 5, 14));
    expect(aniversario.proximoAniversario(), DateTime(DateTime.now().year, 5, 14));
  });
}
```

## Deployment

1. **iOS**:
    - Configurar `Xcode` com `flutter build ios`.
    - Arquivar o app no Xcode e seguir o fluxo de publicação para a App Store.

2. **Android**:
    - Configurar `gradle` com `flutter build apk --release`.
    - Subir o APK para a Google Play Store.

## Manutenção e Atualizações

### Bugs Conhecidos
- Delay ao carregar aniversários em listas longas.
- A funcionalidade de busca não diferencia maiúsculas/minúsculas.

### Próximas Atualizações
- Integração com rede social para importação de contatos.
- Melhorias na interface de notificações.

## Contribuição

### Regras de Contribuição
1. Crie uma nova branch para cada feature ou bug fix.
2. Abra uma Pull Request com as alterações detalhadas.
3. Certifique-se de que todas as alterações seguem o padrão de código.

### Rodando um Branch de Contribuição
```bash
git checkout -b minha-feature
# Faça as alterações e commit
git push origin minha-feature
```

## Licença
Este projeto está licenciado sob a MIT License - consulte o arquivo `LICENSE` para mais detalhes.

---


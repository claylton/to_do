# shared_prefenres (persistência da dados simples):
#### Conceito na documentação:
##### Envolve NSUserDefaults (no iOS) e SharedPreferences (no Android), fornecendo um armazenamento persistente para dados simples. Os dados são mantidos no disco de forma assíncrona. Nenhuma plataforma pode garantir que as gravações serão mantidas no disco após o retorno e esse plug-in não deve ser usado para armazenar dados críticos.
#### Minhas conciderações:
##### Serve para salvar pequenas coisas, se sua lista for crescer muito o ideal é usar outra forma de persistência de dados
##### Para não ocorrer erros o ideal é parar a aplicação antes de instalar o pacote dele no pubspec.yaml já que o shared_preferes instala algumas coisas quando a aplicação é iniciada pela primeira vez
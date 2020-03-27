# Quiz COVID-19

Quiz sobre COVID-10 desenvolvimento para a disciplina de Programação Mobile, por Kleber de Oliveira Andrade.

Tutorial de criação deste app [clique aqui](https://medium.com/@kleberandrade/desenvolvendo-um-quiz-com-flutter-e-google-sheets-414656cb89a2?sk=384abfba5e71c0e9bdb50e205358f761).

## Arquitetura

<p align="center">
    <img src="https://miro.medium.com/max/700/1*D2JRAjhaZu13e-vKXidObw.png" width="740" />
</p>

## Screenshots

<p align="center">
    <img src="https://cdn-images-1.medium.com/max/1200/1*YK7Lq0v7AwL1lI5asHEUIw.png" width="250"/>
    <img src="https://cdn-images-1.medium.com/max/1200/1*G7C9CVYGEBF-2QCbRserHQ.png" width="250"/>
    <img src="https://cdn-images-1.medium.com/max/1200/1*0C_udoJc62aoJUhrjP24kw.png" width="250"/>
</p>

<p align="center">
    <img src="https://cdn-images-1.medium.com/max/1200/1*bgBSVu-EHAIFQcnYW2L7UA.png" width="250"/>
    <img src="https://cdn-images-1.medium.com/max/1200/1*i4JjNPZ0EL1yRjcPBchhog.png" width="250"/>
    <img src="https://cdn-images-1.medium.com/max/1200/1*5Cp4au8kj0Hedp46LwuiMw.png" width="250"/>
</p>


## Como clonar e importar

*   Faça um fork do projeto (precisa ter uma conta no github)
*   Abra o terminal do Visual Studio Code
*   Acesse a pasta onde deseja salvar o aplicativo e digite: git clone *link_do_projeto_no_seu_github* **quiz_covid19**
*   Clique em File -> Open e abra o projeto (pasta)
*   Não se esqueça de abrir o arquivo *pubspec.yaml* e salvar (CTRL + S) o arquivo para que os plugins sejam baixados 

## Desafio para aula

*   [ ] Defina um tema para o seu Quiz e monte um Google Sheets para ele com pelo menos 20 questões.
*   [ ] Trocar os ícones tradicionais pelos ícones da biblioteca FontAwesom (plugin [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter));
*   [ ] Crie um Widget na pasta components referente a área da Pergunta (QuestionContainer); Trocar o método _buildQuestion pelo Widget que você criou. Dicar, utilize CTRL + . para refatorar o método e criar um Widget.
*   [ ] Crie um Widget na pasta components referente ao botão de resposta (AnswerButton). Trocar o método _buildAnswerButton pelo Widget que você criou. Dicar, utilize CTRL + . para refatorar o método e criar um Widget.
*   [ ] Adicionar animações no AlertDialog de resultado (ResultDialog) e no AlertDialog final (FinishDialog)para deixar o Quiz mais dinâmico ([tutorial](https://medium.com/flutter-community/how-to-animate-dialogs-in-flutter-here-is-answer-492ea3a7262f));

## Licença

    Copyright 2020 Kleber de Oliveira Andrade
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

<br />
<p align="center">

  <h3 align="center">SuperBank</h3>

  <p align="center">
    Banco digital
  </p>
</p>

<details open="open">
  <summary>Índice</summary>
    <ol>
    <li>
      <a href="#sobre-o-projeto">Sobre o projeto</a>
      <ul>
        <li><a href="#funcionalidades">Funcionalidades</a></li>
        <li><a href="#construido-com">Construido com</a></li>
      </ul>
    </li>
    <li><a href="#contato">Contato</a></li>
  </ol>
</details>

## Sobre o projeto

Esse projeto consiste na criação de um banco digital, com a intenção de reunir diversos conhecimentos, design pattern e boas práticas em um único projeto para possíveis consultas.

### Funcionalidades

  * Abrir conta

    Na criação de conta é solicitado ao cliente algumas informações necessárias e durante esse processo algumas informações são consultadas para validar se já existe algum cliente com os mesmos dados, como por exemplo o CPF ou o email.

    <img src=".github/AbrirConta.gif" width="300" />

  * Login
  
    No Login o cliente insere seu número de conta, onde será validado, caso o número seja válido será solicitado ao cliente sua senha e após inseri-lá, o cliente receberá acesso a sua conta.

    <img src=".github/Login.gif" width="300" />

### Construído com

Na construção do projeto está sendo utilizado uma arquitetura modular, que traz como benefício o isolamento de alterações, a capacidade de trabalhar em partes isoladas e um menor tempo de compilação.

![Modular architecture](.github/modularArchitecture.png)

Também é utilizado o Coodinator Pattern, que fornece um encapsulamento da lógica de navegação e ajuda a combater as famosas Massive View Controller.

![Coordinator pattern](.github/CoordinatorPattern.png)

No projeto é utilizado o Firestore do [Firebase](https://firebase.google.com/), para armazenar as informações utilizadas no aplicativo, como informações de cliente, contas, login…

Também está sendo utilizado algumas bibliotecas, como [RxSwift](https://github.com/ReactiveX/RxSwift). Alguns design arquitetônico, como MVC e MVVM. E alguns padrões criacionais, como o Singleton.

## Contato

William James - william.james.pj@gmail.com

Link do projeto: [https://github.com/william-james-pj/SuperBankSwift](https://github.com/william-james-pj/SuperBankSwift)

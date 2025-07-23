# Módulos Terraform para AWS

Este repositório contém uma coleção de módulos Terraform reutilizáveis para provisionar vários recursos na Amazon Web Services (AWS). Cada módulo é projetado para ser autônomo e facilmente integrado em diferentes projetos Terraform, promovendo a reutilização de código e as melhores práticas de IaC (Infrastructure as Code).

## Pré-requisitos

Antes de utilizar estes módulos, garanta que você tenha:

-   **Terraform** instalado (versão 1.0.0 ou superior).
-   Uma **Conta AWS** ativa.
-   **AWS CLI** configurado com as credenciais apropriadas.

## Módulos Disponíveis

Abaixo está a lista de módulos atualmente disponíveis neste repositório. Para adicionar um novo módulo, crie um novo diretório em `modules/` e atualize esta tabela.

| Módulo | Descrição |
| :--- | :--- |
| `alb` | Provisiona um Application Load Balancer (ALB), com listeners e target groups. |
| `autoscaling-group` | Cria um Auto Scaling Group para instâncias EC2, garantindo escalabilidade e resiliência. |
| `bck` | Gerencia um remote backend com bucket S3 + DynamonDB com configurações personalizáveis. |
| `security-group` | Define e gerencia Security Groups para controlar o tráfego de entrada e saída. |
| `vpc` | Cria uma Virtual Private Cloud (VPC) completa, com sub-redes, tabelas de rotas e gateways. |

## Como Usar

Para utilizar um módulo em seu projeto Terraform, adicione um bloco `module` ao seu código, apontando para o diretório do módulo desejado.

**Exemplo: Utilizando o módulo VPC**

```hcl
module "minha_vpc" {
  source = "./modules/vpc"

  # Variáveis específicas do módulo
  nome_da_vpc    = "vpc-producao"
  cidr_block     = "10.0.0.0/16"
  tags = {
    Ambiente = "Producao"
    Projeto  = "Meu App"
  }
}
```

## Como Contribuir

Contribuições são bem-vindas! Se você deseja adicionar um novo módulo ou melhorar um existente, siga os passos abaixo:

1.  Faça um **Fork** deste repositório.
2.  Crie uma nova **Branch** para sua feature (`git checkout -b feature/novo-modulo-rds`).
3.  Adicione seu módulo dentro do diretório `modules/`.
4.  **Atualize a tabela** na seção "Módulos Disponíveis" deste README com as informações do novo módulo.
5.  Abra um **Pull Request**.

---


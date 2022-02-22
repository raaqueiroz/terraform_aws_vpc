<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<h1 align="center"> Módulo de provisionamento de VPC AWS </h1>

<p>
Módulo para provisionamento de infra de uma VPC na AWS com 4 subnets <br/><br/>
Sendo 2 Subnets privadas e 2 públicas em 2 AZs distintas, para permitir o MultiAZ tanto na "rede" privada como na pública. <br/>
É provisionado um internet gateway e atachada à VPC, e um NAT Gateway para permitir a saída de internet da subnet privada, 
provisionadas 2 tabelas de roteamento para ambas redes com as devidas rotas padrão de saída e associadas às respectivas subnets
</p>
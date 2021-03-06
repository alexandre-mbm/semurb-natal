O programa está funcional mas [o código precisa de refatoração](https://github.com/alexandre-mbm/semurb-natal/issues/1) antes de se atender a novas _issues_.

---

# Objetivos do projeto

1. Facilitar mapeamento com dados oficiais em [Natal, RN](https://pt.wikipedia.org/wiki/Natal_%28Rio_Grande_do_Norte%29)

 [SEMURB](https://www.natal.rn.gov.br/semurb/paginas/ctd-106.html) é a "Secretaria de Meio Ambiente e Urbanismo" do município.

1. Servir de modelo simples para trabalho com outras fontes de documentos e imagens que possam ser úteis em mapeamento OpenStreetMap. _Clone e fork!_<br>

 Interesses assemelhados:
 - nighto/[calibracao-plantas-digitais-ipp](https://github.com/nighto/calibracao-plantas-digitais-ipp)
 - nighto/[calibracao-mapas-ibge](https://github.com/nighto/calibracao-mapas-ibge)

# Dependências

```bash
sudo apt-get install inkscape
sudo apt-get install poppler-utils
```

O `convert` tinha aprensentado alguns _bugs_, por isso optou-se pelo `inkscape`.

# Trabalhe dentro do repositório clonado

```bash
git clone https://github.com/alexandre-mbm/semurb-natal
cd semurb-natal
```

O _Help_ do pequeno programa mostra a sequência do fluxo de trabalho:

```bash
$ ./semurb-pdf.sh

Help

 semurb-pdf list
 semurb-pdf info [n]
 semurb-pdf download <n>
 semurb-pdf convert <n>
```

1. Lista-se os documentos disponíveis
1. Exibibe-se informação "somente" sobre documentos já baixados
1. Faz-se download de novos documentos
1. Converte-se em imagens algum documento já baixado

_Pull requests_ facilmente serão bem vindos. ~~Especialmente de arquivos de [calibração PicLayer](https://www.youtube.com/watch?v=Jn-2awm3bYU) `*.cal`~~. → **Leia sobre dados na seção [#Licença](#licença)** (abaixo).

Atenção! Nesta primeira versão, [no caso de um documento multipáginas](https://github.com/alexandre-mbm/semurb-natal/issues/2), somente é considerada e convertida a primeira página.

# Licença

O semurb-natal é disponibilizado sob a [Expat License](LICENSE), também conhecida ambiguamente como "[MIT License](https://en.wikipedia.org/wiki/Expat_License)" — existe mais de uma "licença do MIT".

Os dados externos são colhidos da SEMURB pelo próprio usuário. Ele deve solicitar permissão para a utilização deles em seu projeto particular. Está **pendente** a solicitação e o recebimento de permissão para o aproveitamento dos dados em mapeamento OpenStreetMap. Por enquanto, você não deve usá-los no OpenStreetMap. Então não estão sendo aceitos _pull requests_ de arquivos `*.cal` ou `*.osm`.

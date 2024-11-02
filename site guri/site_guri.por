programa
{
	inclua biblioteca Texto --> tx
	inclua biblioteca Teclado --> tc
	inclua biblioteca Util --> u
	inclua biblioteca Arquivos --> a
	inclua biblioteca Mouse --> m
	inclua biblioteca Sons --> s
	inclua biblioteca Tipos --> tp
	inclua biblioteca Graficos --> g
	
	// telas
	const inteiro tela_login = 1, tela_cadastro = 2, tela_cadastro_f = 3, tela_cadastro_u = 4, tela_inicio = 5
	inteiro tela_atual = tela_login
	inteiro largura_janela = 500, altura_janela = 775
	cadeia email_log = "", senha_log = "", nome_sing = "", email_sing = "", senha_sing = "", endereco_sing = ""

	// inputs
	inteiro posicaoy_inputs[] = { 220, 300, 380, 460 }, altura_input = 30
	//inteiro posicaoy_inputs[0] = 240, posicaoy_inputs[1] = 320, posicaoy_input3 = 400, posicaoy_input4 = 0, altura_input = 30
	real posicaox_input = (largura_janela / 2) - (largura_janela * 0.8 / 2), largura_input = largura_janela * 0.8

	// links
	inteiro posicaox_link = 0, posicaoy_link = 0, largura_link = 0, altura_link = 0

	// botões opcao funcinarios, clientes e entrar
	inteiro altura_botoes = 120, posicaoy_clientes = 200, posicaoy_funcionarios = posicaoy_clientes + 200, posicaoy_entrar = 550
	real posicaox_botoes = (largura_janela / 2) - (largura_janela * 0.8 / 2), largura_botoes = largura_janela * 0.8
	
	// texto
	real tamanho_titulo = 36.0
	
	// imagens
	inteiro entrar1, entrar2, hank, funcionarios1, funcionarios2, clientes1, clientes2, criar_conta1, criar_conta2

	funcao logico hoverBotao(inteiro posicaoy_botao) {
		se (m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_botao e m.posicao_y() <= posicaoy_botao + altura_botoes) {
			retorne verdadeiro
		} senao {
			retorne falso	
		}
	}

	funcao logico clicouInput(inteiro posicaoy_input) {
		se (m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input e m.posicao_x() <= posicaox_input + largura_input e m.posicao_y() >= posicaoy_input e m.posicao_y() <= posicaoy_input + altura_input) {
			retorne verdadeiro
		} senao {
			retorne falso	
		}
	}

	funcao logico clicouLink() {
		se (m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_link e m.posicao_x() <= posicaox_link + largura_link e m.posicao_y() >= posicaoy_link e m.posicao_y() <= posicaoy_link + altura_link) {
			retorne verdadeiro
		} senao {
			retorne falso	
		}
	}

	funcao digitar_texto(cadeia &campo, inteiro posicaoy_input) {
		enquanto(verdadeiro) {
			// se apertar fora do input desativa as teclas no input previamente selecionado
			se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() <= posicaox_input ou m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input + largura_input ou m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_y() <= posicaoy_input ou m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_y() >= posicaoy_input + altura_input) {
				retorne
			}
			
			se(tc.alguma_tecla_pressionada()) {
				inteiro temp = tc.ler_tecla()
				logico tamanhoMax = g.largura_texto(campo) >= largura_input - 20
				
				se (temp == tc.TECLA_BACKSPACE) {
					inteiro tamanho = tx.numero_caracteres(campo)
					se (tamanho >= 1) {			
						campo = tx.extrair_subtexto(campo, 0, tamanho - 1)
					}
				} senao se (nao tamanhoMax) {
					caracter car = tc.caracter_tecla(temp)
					campo += tx.caixa_baixa(tp.caracter_para_cadeia(car))	
				}
			}
			// chama a função para ficar renderizando a janela e ir mostrando oq está sendo escrito
			desenhar_pag_auth()	
		}
	}
	
	funcao inicio() {
 		inicializar()
		
		enquanto(verdadeiro) {
			escolha(tela_atual) {
				caso tela_login:
					pagina_login() 
					pare
				caso tela_cadastro:
					pagina_cadastro()
					pare
				caso tela_cadastro_f:
					pagina_cadastrar()
					pare
				caso tela_cadastro_u:
					pagina_cadastrar()
					pare
				caso tela_inicio:
					pagina_inicio()
					pare
			}
		}
	}

	funcao inicializar() {
		entrar1 = g.carregar_imagem("entrar1.JPEG")
		entrar1 = g.redimensionar_imagem(entrar1, largura_botoes, altura_botoes, verdadeiro)
		entrar2 = g.carregar_imagem("entrar2.JPEG")
		entrar2 = g.redimensionar_imagem(entrar2, largura_botoes, altura_botoes, verdadeiro)
		hank = g.carregar_imagem("hank.JPG")
		hank = g.redimensionar_imagem(hank, 1200, 775, verdadeiro)
		funcionarios1 = g.carregar_imagem("funcionarios1.jpeg")
		funcionarios1 = g.redimensionar_imagem(funcionarios1, largura_botoes, altura_botoes, verdadeiro)
		funcionarios2 = g.carregar_imagem("funcionarios2.jpeg")
		funcionarios2 = g.redimensionar_imagem(funcionarios2, largura_botoes, altura_botoes, verdadeiro)
		clientes1 = g.carregar_imagem("clientes1.jpeg")
		clientes1 = g.redimensionar_imagem(clientes1, largura_botoes, altura_botoes, verdadeiro)
		clientes2 = g.carregar_imagem("clientes2.jpeg")
		clientes2 = g.redimensionar_imagem(clientes2, largura_botoes, altura_botoes, verdadeiro)
		criar_conta1 = g.carregar_imagem("criar_conta1.jpeg")
		criar_conta1 = g.redimensionar_imagem(criar_conta1, largura_botoes, altura_botoes, verdadeiro)
		criar_conta2 = g.carregar_imagem("criar_conta2.jpeg")
		criar_conta2 = g.redimensionar_imagem(criar_conta2, largura_botoes, altura_botoes, verdadeiro)
		g.iniciar_modo_grafico(falso)
		g.definir_dimensoes_janela(largura_janela, altura_janela)
		g.definir_titulo_janela("Guri")
	}
	
	funcao pagina_login() {
		limpa()
		escreva("cu do cassio é preto")
		desenhar_pag_auth()
		// começa a atribuir valores no input clicado
	 	se(clicouInput(posicaoy_inputs[0])) {
	 		digitar_texto(email_log, posicaoy_inputs[0])
	 	} senao se (clicouInput(posicaoy_inputs[1])) {
	 		digitar_texto(senha_log, posicaoy_inputs[1])
	 	}
		// redireciona para a tela cadastro ao clicar no link cadastre-se
	 	se(clicouLink()) {
	 		tela_atual = tela_cadastro
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	 	// vai para tela inicio ao apertar no botão login caso a senha e email estejam válidos
	 	se(senha_log != "" e email_log != "" e m.botao_pressionado(m.BOTAO_ESQUERDO) e hoverBotao(posicaoy_entrar)) {
			se(senha_log != "" e email_log != ""){
	 			tela_atual = tela_inicio
	 			g.definir_dimensoes_janela(1200, 775)
			}
	 	}
	}
	
	funcao desenhar_pag_auth() {
		g.definir_cor(g.COR_BRANCO)
		g.limpar()
		// título
		g.definir_tamanho_texto(tamanho_titulo)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.definir_cor(g.COR_PRETO)
		cadeia titulo
		se (tela_atual == tela_login) {
			titulo = "LOGIN"
		} senao {
			titulo = "CADASTRE-SE"
		}
    		g.desenhar_texto((largura_janela / 2) - (g.largura_texto(titulo) / 2), 100, titulo)
    		
		g.definir_tamanho_texto(17.0)
		g.definir_estilo_texto(falso, falso, falso)
		se (tela_atual == tela_cadastro) {
			// desenhar batão clientes
			se(hoverBotao(posicaoy_clientes)) {
				g.desenhar_imagem(posicaox_botoes, posicaoy_clientes, clientes1)
			}
			senao{
				g.desenhar_imagem(posicaox_botoes, posicaoy_clientes, clientes2)
			}
			// desenhar botão funcionarios
			se(hoverBotao(posicaoy_funcionarios)) {
				g.desenhar_imagem(posicaox_botoes, posicaoy_funcionarios, funcionarios1)
			}
			senao{
				g.desenhar_imagem(posicaox_botoes, posicaoy_funcionarios, funcionarios2)
			}
		} senao {
			inteiro n = 0
			cadeia campos[] = { email_log, senha_log, senha_sing, endereco_sing }
			se(tela_atual == tela_cadastro_f ou tela_atual == tela_cadastro_u) {
				campos[0] = nome_sing
				campos[1] = email_sing
				g.desenhar_texto(posicaox_input, posicaoy_inputs[n] - 20, "Nome")
				g.desenhar_retangulo(posicaox_input, posicaoy_inputs[n], largura_input, altura_input, verdadeiro, falso)
				g.desenhar_texto(posicaox_input + 10, posicaoy_inputs[n] + (g.altura_texto(campos[n]) / 2), campos[n])
				n++
			}
			g.desenhar_texto(posicaox_input, posicaoy_inputs[n] - 20, "Email")
			g.desenhar_retangulo(posicaox_input, posicaoy_inputs[n], largura_input, altura_input, verdadeiro, falso)
			g.desenhar_texto(posicaox_input + 10, posicaoy_inputs[n] + (g.altura_texto(campos[n]) / 2), campos[n])
			n++
			g.desenhar_texto(posicaox_input, posicaoy_inputs[n] - 20, "Senha")
			g.desenhar_retangulo(posicaox_input, posicaoy_inputs[n], largura_input, altura_input, verdadeiro, falso)
			g.desenhar_texto(posicaox_input + 10, posicaoy_inputs[n] + (g.altura_texto(campos[n]) / 2), campos[n])	
			se(tela_atual == tela_cadastro_u) {
				n++
				g.desenhar_texto(posicaox_input, posicaoy_inputs[n] - 20, "Endereço")
				g.desenhar_retangulo(posicaox_input, posicaoy_inputs[n], largura_input, altura_input, verdadeiro, falso)
				g.desenhar_texto(posicaox_input + 10, posicaoy_inputs[n] + (g.altura_texto(campos[n]) / 2), campos[n])		
			}
		}

		cadeia texto_link 
		inteiro n = 1
		se (tela_atual == tela_login) {
			texto_link = "Cadastre-se"
		} senao {
			texto_link = "Voltar"
			n++
			se (tela_atual == tela_cadastro_u) {
				n++	
			}
		}
		se (tela_atual == tela_cadastro) {
			posicaox_link = (largura_botoes + posicaox_botoes) - (g.largura_texto(texto_link))
			posicaoy_link = posicaoy_funcionarios + altura_botoes + 20
		} senao {
			posicaox_link = (largura_input + posicaox_input) - (g.largura_texto(texto_link)) 
			posicaoy_link = posicaoy_inputs[n] + altura_input + 20
		}
		g.desenhar_texto(posicaox_link, posicaoy_link, texto_link)
		largura_link = g.largura_texto(texto_link)
		altura_link = g.altura_texto(texto_link)

		// desenhar botão entrar
		se (tela_atual == tela_login) {
			se (hoverBotao(posicaoy_entrar)) {
				g.desenhar_imagem(posicaox_botoes, posicaoy_entrar, entrar1)
			} senao {
				g.desenhar_imagem(posicaox_botoes, posicaoy_entrar, entrar2)
			}
		}
		// desenhar botão criar conta
		se(tela_atual == tela_cadastro_f ou tela_atual == tela_cadastro_u) {
			se(hoverBotao(posicaoy_entrar)) {
				g.desenhar_imagem(posicaox_botoes, posicaoy_entrar, criar_conta1)
			} senao {
				g.desenhar_imagem(posicaox_botoes, posicaoy_entrar, criar_conta2)
			}
		}
		g.renderizar()	
	}
	
	funcao pagina_cadastro() {
		limpa()
		escreva("cadastro")
		desenhar_pag_auth()
		
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e hoverBotao(posicaoy_clientes)) {
	 		tela_atual = tela_cadastro_u
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e hoverBotao(posicaoy_funcionarios)) {
	 		tela_atual = tela_cadastro_f
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	 	se(clicouLink()) {
	 		tela_atual = tela_login
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	}
	
	funcao pagina_cadastrar() {
		limpa()
		escreva("cadastrar funcionario ou cliente")
		desenhar_pag_auth()

		se (clicouInput(posicaoy_inputs[0])) {
			digitar_texto(nome_sing, posicaoy_inputs[0])
		} senao se (clicouInput(posicaoy_inputs[1])) {
	 		digitar_texto(email_sing, posicaoy_inputs[1])
	 	} senao se (clicouInput(posicaoy_inputs[2])) {
	 		digitar_texto(senha_sing, posicaoy_inputs[2])
	 	}
	 	se (tela_atual == tela_cadastro_u) {
	 		se (clicouInput(posicaoy_inputs[3])) {
	 			digitar_texto(endereco_sing, posicaoy_inputs[3])
	 		}	
	 	}

		
		se(clicouLink()) {
	 		tela_atual = tela_login
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e hoverBotao(posicaoy_entrar)) {
			se(nome_sing != "" e senha_sing != "" e email_sing != ""){
	 			tela_atual = tela_inicio
	 			g.definir_dimensoes_janela(1200, 775)
			} senao {
				escreva("num foi")
			}
	 	}
	}
	
	funcao pagina_inicio() {
		limpa()
		escreva("inicio")
		g.desenhar_imagem(0, 0, hank)
		g.renderizar()
	}

	funcao salvar_usuario (){
		
	}
} 
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 3037; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
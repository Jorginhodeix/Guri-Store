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
	const inteiro tela_login = 1, tela_cadastro = 2, tela_cadastro_c = 3, tela_cadastro_f = 4, tela_inicio = 5
	inteiro tela_atual = tela_login
	inteiro largura_janela = 500, altura_janela = 775

	// dados
	cadeia email_log = "", senha_log = "", nome_sing = "", email_sing = "", senha_sing = "", endereco_sing = ""
	inteiro id_usuario

	// inputs
	inteiro posicaoy_inputs[] = { 220, 300, 380, 460 }, altura_input = 30, inputSelecionado = -1
	real posicaox_input = (largura_janela / 2) - (largura_janela * 0.8 / 2), largura_input = largura_janela * 0.8

	// links
	inteiro posicaox_link = 0, posicaoy_link = 0, largura_link = 0, altura_link = 0

	// botões opcao funcinarios, clientes e entrar
	inteiro altura_botoes = 120, posicaoy_clientes = 200, posicaoy_funcionarios = posicaoy_clientes + 200, posicaoy_entrar = 550
	real posicaox_botoes = (largura_janela / 2) - (largura_janela * 0.8 / 2), largura_botoes = largura_janela * 0.8
	
	// texto
	real tamanho_titulo = 36.0
	
	// imagens
	inteiro entrar1 = 0, entrar2 = 0, hank = 0, funcionarios1 = 0, funcionarios2 = 0, clientes1 = 0, clientes2 = 0, criar_conta1 = 0, criar_conta2 = 0

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
				inputSelecionado = -1
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
				} senao se (tc.tecla_pressionada(tc.TECLA_SHIFT) e temp == tc.TECLA_2) {
	                	campo += "@"
	            	} senao se (nao tamanhoMax) {
					caracter car = tc.caracter_tecla(temp)
					campo += tx.caixa_baixa(tp.caracter_para_cadeia(car))			
				}
			}
			// chama a função para ficar renderizando a janela e ir mostrando oq está sendo escrito
			desenhar_pag_auth()	
		}
	}

	funcao desenharInput(cadeia label, inteiro posicaoy_input, cadeia value, logico inputEstaSelecionado) {
		g.desenhar_texto(posicaox_input, posicaoy_input - 20, label)
		g.desenhar_retangulo(posicaox_input, posicaoy_input, largura_input, altura_input, verdadeiro, falso)
		g.desenhar_texto(posicaox_input + 10, posicaoy_input + (g.altura_texto(value) / 2), value)
		se (inputEstaSelecionado) {
			g.desenhar_retangulo(posicaox_input + 1, posicaoy_input + 1, largura_input, altura_input, verdadeiro, falso)
		}
	}

	funcao carregarImagem(inteiro &imagem, cadeia url, inteiro largura, inteiro altura) {
		imagem = g.carregar_imagem("/imagens/" + url)
		imagem = g.redimensionar_imagem(imagem, largura, altura, verdadeiro)
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
				caso tela_cadastro_c:
					pagina_cadastrar()
					pare
				caso tela_inicio:
					pagina_inicio()
					pare
			}
		}
	}

	funcao inicializar() {
		carregarImagem(entrar1, "entrar1.jpeg", largura_botoes, altura_botoes)
		carregarImagem(entrar2, "entrar2.jpeg", largura_botoes, altura_botoes)
		carregarImagem(clientes1, "clientes1.jpeg", largura_botoes, altura_botoes)
		carregarImagem(clientes2, "clientes2.jpeg", largura_botoes, altura_botoes)
		carregarImagem(funcionarios1, "funcionarios1.jpeg", largura_botoes, altura_botoes)
		carregarImagem(funcionarios2, "funcionarios2.jpeg", largura_botoes, altura_botoes)
		carregarImagem(criar_conta1, "criar_conta1.jpeg", largura_botoes, altura_botoes)
		carregarImagem(criar_conta2, "criar_conta2.jpeg", largura_botoes, altura_botoes)
		carregarImagem(hank, "hank.jpg", 1200, 775)

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
	 		inputSelecionado = 0
	 		digitar_texto(email_log, posicaoy_inputs[0])
	 	} senao se (clicouInput(posicaoy_inputs[1])) {
	 		inputSelecionado = 1
	 		digitar_texto(senha_log, posicaoy_inputs[1])
	 	}
		// redireciona para a tela cadastro ao clicar no link cadastre-se
	 	se(clicouLink()) {
	 		tela_atual = tela_cadastro
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}

	 	// vai para tela inicio ao apertar no botão login caso a senha e email estejam válidos
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e hoverBotao(posicaoy_entrar)) {
			se(email_log != "" e senha_log != "") {
				se(email_existe()) {
					se(senha_esta_correta()) {
			 			tela_atual = tela_inicio
			 			g.definir_dimensoes_janela(1200, 775)
					} senao {
						escreva("\nSenha incorreta")
					}
				} senao {
					escreva("\nEmail inválido")
				}
			} senao {
				escreva("\nPreencha todos os campos")
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
			} senao {
				g.desenhar_imagem(posicaox_botoes, posicaoy_clientes, clientes2)
			}
			// desenhar botão funcionarios
			se(hoverBotao(posicaoy_funcionarios)) {
				g.desenhar_imagem(posicaox_botoes, posicaoy_funcionarios, funcionarios1)
			} senao {
				g.desenhar_imagem(posicaox_botoes, posicaoy_funcionarios, funcionarios2)
			}
		} senao {
			inteiro n = 0
			cadeia campos[] = { email_log, senha_log, senha_sing, endereco_sing }
			se(tela_atual == tela_cadastro_f ou tela_atual == tela_cadastro_c) {
				campos[0] = nome_sing
				campos[1] = email_sing
				desenharInput("Nome", posicaoy_inputs[n], campos[n], inputSelecionado == n)
				n++
			}
			desenharInput("Email", posicaoy_inputs[n], campos[n], inputSelecionado == n)
			n++
			desenharInput("Senha", posicaoy_inputs[n], campos[n], inputSelecionado == n)
			se(tela_atual == tela_cadastro_c) {
				n++
				desenharInput("Endereço", posicaoy_inputs[n], campos[n], inputSelecionado == n)
			}
		}

		cadeia texto_link 
		inteiro n = 1
		se (tela_atual == tela_login) {
			texto_link = "Cadastre-se"
		} senao {
			texto_link = "Voltar"
			n++
			se (tela_atual == tela_cadastro_c) {
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
		se(tela_atual == tela_cadastro_f ou tela_atual == tela_cadastro_c) {
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
	 		tela_atual = tela_cadastro_c
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
			inputSelecionado = 0
			digitar_texto(nome_sing, posicaoy_inputs[0])
		} senao se (clicouInput(posicaoy_inputs[1])) {
			inputSelecionado = 1
	 		digitar_texto(email_sing, posicaoy_inputs[1])
	 	} senao se (clicouInput(posicaoy_inputs[2])) {
	 		inputSelecionado = 2
	 		digitar_texto(senha_sing, posicaoy_inputs[2])
	 	}
	 	se (tela_atual == tela_cadastro_c) {
	 		se (clicouInput(posicaoy_inputs[3])) {
	 			inputSelecionado = 3
	 			digitar_texto(endereco_sing, posicaoy_inputs[3])
	 		}	
	 	}
		
		se(clicouLink()) {
	 		tela_atual = tela_cadastro
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	 	
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e hoverBotao(posicaoy_entrar)) {
	 		inteiro estrutura_email = tx.posicao_texto("@gmail.com", email_sing, 0), numero_caracteres_senha = tx.numero_caracteres(senha_sing)
			logico todos_campos_preenchidos

			se (tela_atual == tela_cadastro_c e nome_sing != "" e email_sing != "" e senha_sing != "" e endereco_sing != "") {
				todos_campos_preenchidos = verdadeiro
			} senao se (tela_atual == tela_cadastro_f e nome_sing != "" e email_sing != "" e senha_sing != "") {
				todos_campos_preenchidos = verdadeiro
			} senao {
				todos_campos_preenchidos = falso
			}

	 		se (todos_campos_preenchidos) {
	 			se (estrutura_email != -1 e numero_caracteres_senha >= 6){
					se (nao email_existe()){
						salvar_usuario()
			 			tela_atual = tela_inicio
			 			g.definir_dimensoes_janela(1200, 775)
					} senao {
						escreva("\nEmail já está em uso")
					}
				} 
				se (estrutura_email == -1) {
					escreva("\nEmail Inválido. Exemplo: seu_nome@gmail.com")
				} 
				se (numero_caracteres_senha < 6) {
					escreva("\nDigite uma senha maior ou igual à 6 caracteres")
				}	
	 		} senao {
	 			escreva("\nPreencha todos os campos")
	 		}
		} 
	}
	
	funcao pagina_inicio() {
		limpa()
		escreva("inicio")
		g.desenhar_imagem(0, 0, hank)
		g.renderizar()
	}

	funcao logico email_existe() {
		inteiro usuarios = a.abrir_arquivo("usuarios.txt", a.MODO_LEITURA), linha = 0
		logico x = falso
		cadeia conteudoLinha = "", email = ""
		enquanto(x == falso){
			conteudoLinha = a.ler_linha(usuarios)
			x = a.fim_arquivo(usuarios)
			se(conteudoLinha != ""){
				inteiro p1 = 0, p2 = 0	
				para(inteiro i = 1; i < 5; i++){
					p1 = tx.posicao_texto("|", conteudoLinha, p2)
					p2 = tx.posicao_texto("|", conteudoLinha, p1+1)
				}				
				email = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
				se(email == email_log){
					id_usuario = linha
					a.fechar_arquivo(usuarios)
					retorne verdadeiro
				}
			}
			linha++
		}
		a.fechar_arquivo(usuarios)
		retorne falso
	}
    
	funcao logico senha_esta_correta() {
		inteiro usuarios = a.abrir_arquivo("usuarios.txt", a.MODO_LEITURA), p1 = 0, p2 = 0
		cadeia conteudoLinha = "", senha = ""
		para(inteiro i = 1; i <= id_usuario + 1; i++){
			conteudoLinha = a.ler_linha(usuarios)
		}
		para(inteiro i = 1; i < 7; i++){
			p1 = tx.posicao_texto("|", conteudoLinha, p2)
			p2 = tx.posicao_texto("|", conteudoLinha, p1+1)
		}
		senha = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
		a.fechar_arquivo(usuarios)
		se (senha == senha_log){
			retorne verdadeiro
		} senao {
			retorne falso
		}
	}

	funcao salvar_usuario() {
		inteiro usuarios = a.abrir_arquivo("usuarios.txt", a.MODO_LEITURA), linha = 0
		logico x = falso
		enquanto(x == falso){
			a.ler_linha(usuarios)
			x = a.fim_arquivo(usuarios)
			se (x != verdadeiro) {
				linha++	
			}
		}
		a.fechar_arquivo(usuarios) 
		usuarios = a.abrir_arquivo("usuarios.txt", a.MODO_ACRESCENTAR)
		se (tela_atual == tela_cadastro_c) {
			a.escrever_linha("\n" + linha + "|\t|" + nome_sing + "|\t|" + email_sing + "|\t|" + senha_sing + "|\t|" + endereco_sing + "|", usuarios)	
		} senao {
			a.escrever_linha("\n" + linha + "|\t|" + nome_sing + "|\t|" + email_sing + "|\t|" + senha_sing + "|", usuarios)
		}
		a.fechar_arquivo(usuarios)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 13978; 
 * @DOBRAMENTO-CODIGO = [37, 45, 53, 61, 103, 143, 269, 289, 357, 383];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
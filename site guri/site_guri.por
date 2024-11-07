// LAIS AVISA SE FOR MEXER

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
	inteiro largura_janela = 600, altura_janela = 775

	// dados
	cadeia email_log = "", senha_log = "", nome_sing = "", email_sing = "", senha_sing = "", endereco_sing = " "
	inteiro id_usuario
	logico email_existe = falso

	// inputs
	inteiro posicaoy_input1 = 240, posicaoy_input2 = 320, posicaoy_input3 = 400, posicaoy_input4 = 480, altura_input = 30
	real posicaox_input = (largura_janela / 2) - (largura_janela * 0.8 / 2), largura_input = largura_janela * 0.8

	// botão cadastre-se
	inteiro posicaox_signup = 0, posicaoy_signup = 0, largura_signup = 0, altura_signup = 0

	// botão login
	inteiro posicaox_login = 0, posicaoy_login = 0, largura_login = 0, altura_login = 0

	// botões opcao funcinarios, clientes e entrar
	inteiro posicaoy_funcionarios = 400, posicaoy_clientes = 200, posicaoy_entrar = 600, posicaox_botoes = 75, largura_botoes = 450, altura_botoes = 120 
	
	// texto
	real tamanho_titulo = 36.0
	
	// imagens
	inteiro entrar1, entrar2, hank, funcionarios1, funcionarios2, clientes1, clientes2, criar_conta1, criar_conta2
	
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
				caso tela_cadastro_c:
					pagina_cadastro_c()
					pare
					caso tela_cadastro_f:
					pagina_cadastro_f()
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
		g.definir_titulo_janela("Guri Store")
	}
	
	funcao pagina_login() {
		limpa()
		escreva("cu do cassio é preto")
		desenhar_pag_login()

		// começa a atribuir valores no input clicado
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input e m.posicao_x() <= posicaox_input + largura_input e m.posicao_y() >= posicaoy_input1 e m.posicao_y() <= posicaoy_input1 + altura_input) {
	 		digitar_texto(email_log, posicaoy_input1)
	 	} senao se (m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input e m.posicao_x() <= posicaox_input + largura_input e m.posicao_y() >= posicaoy_input2 e m.posicao_y() <= posicaoy_input2 + altura_input) {
	 		digitar_texto(senha_log, posicaoy_input2)
	 	}
	 	

	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_signup e m.posicao_x() <= posicaox_signup + largura_signup e m.posicao_y() >= posicaoy_signup e m.posicao_y() <= posicaoy_signup + altura_signup) {
	 		tela_atual = tela_cadastro
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_entrar e m.posicao_y() <= posicaoy_entrar + altura_botoes) {
			se(email_log != "" e senha_log != ""){
				verificar_email_existente ()
				se(email_existe == verdadeiro){
				logico x = verificar_senha()
				se(x == verdadeiro){
	 			tela_atual = tela_inicio
	 			g.definir_dimensoes_janela(1200, 775)
				}
				senao{
					escreva("num foi, mesmo")
				}
			}
			
				senao{
					escreva("num foi, não")
				}
		}
				senao{
					escreva("num foi")
			}
	 	}
	}
	
	funcao desenhar_pag_login() {
		g.definir_cor(g.COR_BRANCO)
		g.limpar()
		
		g.definir_tamanho_texto(tamanho_titulo)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.definir_cor(g.COR_PRETO)
		cadeia titulo = "LOGIN"
    		g.desenhar_texto((largura_janela / 2) - (g.largura_texto(titulo) / 2), 100, titulo)
    		
		g.definir_tamanho_texto(17.0)
		g.definir_estilo_texto(falso, falso, falso)
		g.desenhar_texto(posicaox_input, posicaoy_input1 - 20, "Email")
		g.desenhar_retangulo(posicaox_input, posicaoy_input1, largura_input, altura_input, verdadeiro, falso)
		g.desenhar_texto(posicaox_input + 10, posicaoy_input1 + (g.altura_texto(email_log) / 2), email_log)
		g.desenhar_texto(posicaox_input, posicaoy_input2 - 20, "Senha")
		g.desenhar_retangulo(posicaox_input, posicaoy_input2, largura_input, altura_input, verdadeiro, falso)
		g.desenhar_texto(posicaox_input + 10, posicaoy_input2 + (g.altura_texto(senha_log) / 2), senha_log)

		cadeia texto_signup = "Cadastre-se"
		posicaox_signup = (largura_input + posicaox_input) - (g.largura_texto(texto_signup)) 
		posicaoy_signup = posicaoy_input2 + altura_input + 20
		g.desenhar_texto(posicaox_signup, posicaoy_signup, texto_signup)
		largura_signup = g.largura_texto(texto_signup)
		altura_signup = g.altura_texto(texto_signup)
		
		se(m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_entrar e m.posicao_y() <= posicaoy_entrar + altura_botoes) {
		g.desenhar_imagem(posicaox_botoes, posicaoy_entrar, entrar2)
		}
		senao{
		g.desenhar_imagem(posicaox_botoes, posicaoy_entrar, entrar1)
		}
		g.renderizar()	
	}
	funcao pagina_cadastro() {
		limpa()
		escreva("cadastro")
		desenhar_pag_cadastro()

		
		se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_login e m.posicao_x() <= posicaox_login + largura_login e m.posicao_y() >= posicaoy_login e m.posicao_y() <= posicaoy_login + altura_login) {
	 		tela_atual = tela_login
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_clientes e m.posicao_y() <= posicaoy_clientes + altura_botoes) {
	 		tela_atual = tela_cadastro_c
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_funcionarios e m.posicao_y() <= posicaoy_funcionarios + altura_botoes) {
	 		tela_atual = tela_cadastro_f
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	}
	funcao desenhar_pag_cadastro() {
		g.definir_cor(g.COR_BRANCO)
		g.limpar()
		
		g.definir_tamanho_texto(tamanho_titulo)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.definir_cor(g.COR_PRETO)
		cadeia titulo = "CADASTRE-SE"
		g.desenhar_texto((largura_janela / 2) - (g.largura_texto(titulo) / 2), 100, titulo)
		//desenhar botão funcionarios
		se(m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_funcionarios e m.posicao_y() <= posicaoy_funcionarios + altura_botoes) {
		g.desenhar_imagem(posicaox_botoes, posicaoy_funcionarios, funcionarios2)
		}
		senao{
		g.desenhar_imagem(posicaox_botoes, posicaoy_funcionarios, funcionarios1)
		}
		//desenhar batão clientes
		se(m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_clientes e m.posicao_y() <= posicaoy_clientes + altura_botoes) {
		g.desenhar_imagem(posicaox_botoes, posicaoy_clientes, clientes2)
		}
		senao{
		g.desenhar_imagem(posicaox_botoes, posicaoy_clientes, clientes1)
		}
		g.definir_tamanho_texto(17.0)
		g.definir_estilo_texto(falso, falso, falso)
		cadeia texto_login = "Voltar"
		posicaox_login = (largura_botoes + posicaox_botoes) - (g.largura_texto(texto_login)) 
		posicaoy_login = posicaoy_funcionarios + altura_botoes + 20
		g.desenhar_texto(posicaox_login , posicaoy_login, texto_login)
		largura_login = g.largura_texto(texto_login)
		altura_login = g.altura_texto(texto_login)
		
		g.renderizar()
		
	}
	funcao pagina_cadastro_c() {
		inteiro x, y, z
		limpa()
		escreva("SHOPEE")
		desenhar_pag_cadastro_c()
		
		se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input e m.posicao_x() <= posicaox_input + largura_input e m.posicao_y() >= posicaoy_input1 e m.posicao_y() <= posicaoy_input1 + altura_input) {
	 		digitar_texto(nome_sing, posicaoy_input1)
	 	} senao se (m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input e m.posicao_x() <= posicaox_input + largura_input e m.posicao_y() >= posicaoy_input2 e m.posicao_y() <= posicaoy_input2 + altura_input) {
	 		digitar_texto(email_sing, posicaoy_input2)
	 	}
	 	senao se (m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input e m.posicao_x() <= posicaox_input + largura_input e m.posicao_y() >= posicaoy_input3 e m.posicao_y() <= posicaoy_input3 + altura_input) {
	 		digitar_texto(senha_sing, posicaoy_input3)
	 	}
	 	senao se (m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input e m.posicao_x() <= posicaox_input + largura_input e m.posicao_y() >= posicaoy_input4 e m.posicao_y() <= posicaoy_input4 + altura_input) {
	 		digitar_texto(endereco_sing, posicaoy_input4)
	 	}
		
		se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_signup - 20 e m.posicao_x() <= posicaox_signup + largura_signup - 22 e m.posicao_y() >= posicaoy_signup e m.posicao_y() <= posicaoy_signup + altura_signup) {
	 		tela_atual = tela_cadastro
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
		}
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_entrar e m.posicao_y() <= posicaoy_entrar + altura_botoes) {
				x = tx.posicao_texto(email_sing, "@gmail.com", 0)
				y = tx.numero_caracteres(senha_sing)
			se (x != -1 e y >= 8){
				verificar_email_existente()
				se (email_existe == falso){
				salvar_usuario()
	 			tela_atual = tela_inicio
	 			g.definir_dimensoes_janela(1200, 775)
				}
				}
				senao{
					escreva("num foi")
				}
			}
				senao{
					escreva("num foi")
			}
	}
	funcao desenhar_pag_cadastro_c() {
		g.definir_cor(g.COR_BRANCO)
		g.limpar()
		
		g.definir_tamanho_texto(tamanho_titulo)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.definir_cor(g.COR_PRETO)
		cadeia titulo = "CADASTRE-SE"
		g.desenhar_texto((largura_janela / 2) - (g.largura_texto(titulo) / 2), 100, titulo)
		
		g.definir_tamanho_texto(17.0)
		g.definir_estilo_texto(falso, falso, falso)
		g.desenhar_texto(posicaox_input, posicaoy_input1 - 20, "Nome")
		g.desenhar_retangulo(posicaox_input, posicaoy_input1, largura_input, altura_input, verdadeiro, falso)
		g.desenhar_texto(posicaox_input + 10, posicaoy_input1 + (g.altura_texto(nome_sing) / 2), nome_sing)
		g.desenhar_texto(posicaox_input, posicaoy_input2 - 20, "Email")
		g.desenhar_retangulo(posicaox_input, posicaoy_input2, largura_input, altura_input, verdadeiro, falso)
		g.desenhar_texto(posicaox_input + 10, posicaoy_input2 + (g.altura_texto(email_sing) / 2), email_sing)
		g.desenhar_texto(posicaox_input, posicaoy_input3 - 20, "Senha")
		g.desenhar_retangulo(posicaox_input, posicaoy_input3, largura_input, altura_input, verdadeiro, falso)
		g.desenhar_texto(posicaox_input + 10, posicaoy_input3 + (g.altura_texto(senha_sing) / 2), senha_sing)
		g.desenhar_texto(posicaox_input, posicaoy_input4 - 20, "Endereço")
		g.desenhar_retangulo(posicaox_input, posicaoy_input4, largura_input, altura_input, verdadeiro, falso)
		g.desenhar_texto(posicaox_input + 10, posicaoy_input4 + (g.altura_texto(endereco_sing) / 2), endereco_sing)

		cadeia texto_signup = "Voltar"
		posicaox_signup = (largura_input + posicaox_input) - (g.largura_texto(texto_signup)) 
		posicaoy_signup = posicaoy_input4 + altura_input + 20
		g.desenhar_texto(posicaox_signup - 20 , posicaoy_signup, texto_signup)
		largura_signup = g.largura_texto(texto_signup)
		altura_signup = g.altura_texto(texto_signup)

		se(m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_entrar e m.posicao_y() <= posicaoy_entrar + altura_botoes) {
		g.desenhar_imagem(posicaox_botoes, posicaoy_entrar, criar_conta2)
		}
		senao{
		g.desenhar_imagem(posicaox_botoes, posicaoy_entrar, criar_conta1)
		}
		
		g.renderizar()
		
	}
	funcao pagina_cadastro_f() {
		inteiro x, y, z
		limpa()
		escreva("CLT")
		desenhar_pag_cadastro_f()
		
		se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input e m.posicao_x() <= posicaox_input + largura_input e m.posicao_y() >= posicaoy_input1 e m.posicao_y() <= posicaoy_input1 + altura_input) {
	 		digitar_texto(nome_sing, posicaoy_input1)
	 	} senao se (m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input e m.posicao_x() <= posicaox_input + largura_input e m.posicao_y() >= posicaoy_input2 e m.posicao_y() <= posicaoy_input2 + altura_input) {
	 		digitar_texto(email_sing, posicaoy_input2)
	 	}
	 	senao se (m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input e m.posicao_x() <= posicaox_input + largura_input e m.posicao_y() >= posicaoy_input3 e m.posicao_y() <= posicaoy_input3 + altura_input) {
	 		digitar_texto(senha_sing, posicaoy_input3)
	 	}
		
		se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_signup - 20 e m.posicao_x() <= posicaox_signup + largura_signup - 22 e m.posicao_y() >= posicaoy_signup e m.posicao_y() <= posicaoy_signup + altura_signup) {
	 		tela_atual = tela_cadastro
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
		}
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_entrar e m.posicao_y() <= posicaoy_entrar + altura_botoes) {
			se(nome_sing != "" e senha_sing != "" e email_sing != ""){
				x = tx.posicao_texto(email_sing, "@gmail.com", 0)
				y = tx.numero_caracteres(senha_sing)
			se (x != -1 e y >= 8){
				verificar_email_existente()
				se (email_existe == falso){
				salvar_usuario()
	 			tela_atual = tela_inicio
	 			g.definir_dimensoes_janela(1200, 775)
				}
				}
				senao{
					escreva("num foi")
				}
			}
				senao{
					escreva("num foi")
			}
	 	}
	}
	funcao desenhar_pag_cadastro_f() {
		g.definir_cor(g.COR_BRANCO)
		g.limpar()
		
		g.definir_tamanho_texto(tamanho_titulo)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.definir_cor(g.COR_PRETO)
		cadeia titulo = "CADASTRE-SE"
		g.desenhar_texto((largura_janela / 2) - (g.largura_texto(titulo) / 2), 100, titulo)
		
		g.definir_tamanho_texto(17.0)
		g.definir_estilo_texto(falso, falso, falso)
		g.desenhar_texto(posicaox_input, posicaoy_input1 - 20, "Nome")
		g.desenhar_retangulo(posicaox_input, posicaoy_input1, largura_input, altura_input, verdadeiro, falso)
		g.desenhar_texto(posicaox_input + 10, posicaoy_input1 + (g.altura_texto(nome_sing) / 2), nome_sing)
		g.desenhar_texto(posicaox_input, posicaoy_input2 - 20, "Email")
		g.desenhar_retangulo(posicaox_input, posicaoy_input2, largura_input, altura_input, verdadeiro, falso)
		g.desenhar_texto(posicaox_input + 10, posicaoy_input2 + (g.altura_texto(email_sing) / 2), email_sing)
		g.desenhar_texto(posicaox_input, posicaoy_input3 - 20, "Senha")
		g.desenhar_retangulo(posicaox_input, posicaoy_input3, largura_input, altura_input, verdadeiro, falso)
		g.desenhar_texto(posicaox_input + 10, posicaoy_input3 + (g.altura_texto(senha_sing) / 2), senha_sing)

		cadeia texto_signup = "Voltar"
		posicaox_signup = (largura_input + posicaox_input) - (g.largura_texto(texto_signup)) 
		posicaoy_signup = posicaoy_input3 + altura_input + 20
		g.desenhar_texto(posicaox_signup - 20 , posicaoy_signup, texto_signup)
		largura_signup = g.largura_texto(texto_signup)
		altura_signup = g.altura_texto(texto_signup)

		se(m.posicao_x() >= posicaox_botoes e m.posicao_x() <= posicaox_botoes + largura_botoes e m.posicao_y() >= posicaoy_entrar e m.posicao_y() <= posicaoy_entrar + altura_botoes) {
		g.desenhar_imagem(posicaox_botoes, posicaoy_entrar, criar_conta2)
		}
		senao{
		g.desenhar_imagem(posicaox_botoes, posicaoy_entrar, criar_conta1)
		}
		
		g.renderizar()
		
	}
	funcao pagina_inicio() {
		limpa()
		escreva("inicio")
		g.desenhar_imagem(0, 0, hank)
		g.renderizar()
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
			
			se(tela_atual == tela_login) {
				desenhar_pag_login()	
			}
			senao se(tela_atual == tela_cadastro_f) {
			desenhar_pag_cadastro_f()
			}
			senao se(tela_atual == tela_cadastro_c) {
			desenhar_pag_cadastro_c()
			}
		}
	} 
	funcao verificar_email_existente (){
		inteiro usuarios = a.abrir_arquivo("usuarios.txt", a.MODO_LEITURA), i, linha = 0, p1, p2
		logico x = falso
		cadeia t = "", email = ""
		enquanto(x == falso){
			t = a.ler_linha(usuarios)
			x = a.fim_arquivo(usuarios)
			se(t != ""){
				p1 = 0
				p2 = 0
				para(i = 1; i < 5; i++){
				p1 = tx.posicao_texto("|", t, p2)
				p2 = tx.posicao_texto("|", t, p1+1)
				}
			email = tx.extrair_subtexto(t, p1+1, p2)
			se(email == email_log){
				email_existe = verdadeiro
				id_usuario = linha+1
				x = verdadeiro
			}
			senao{
				x = falso
			}
			}
			linha++
			}
			a.fechar_arquivo(usuarios)
		}
	funcao logico verificar_senha (){
			inteiro usuarios = a.abrir_arquivo("usuarios.txt", a.MODO_LEITURA), i, p1, p2
			cadeia t = "", senha = ""
			para(i = 1; i <= id_usuario; i++){
			t = a.ler_linha(usuarios)
			}
			p1 = 0
			p2 = 0
			para(i = 1; i < 7; i++){
			p1 = tx.posicao_texto("|", t, p2)
			p2 = tx.posicao_texto("|", t, p1+1)
			}
			senha = tx.extrair_subtexto(t, p1+1, p2)
			a.fechar_arquivo(usuarios)
			se(senha == senha_log){
				retorne verdadeiro
			}
			senao{
				retorne falso
			}
	}
	funcao salvar_usuario (){
		inteiro usuarios = a.abrir_arquivo("usuarios.txt", a.MODO_LEITURA), linha = 0
		logico x = falso
		enquanto(x == falso){
			a.ler_linha(usuarios)
			x = a.fim_arquivo(usuarios)
			linha++
		}
		a.fechar_arquivo(usuarios) 
		usuarios = a.abrir_arquivo("usuarios.txt", a.MODO_ACRESCENTAR)
		linha--
		a.escrever_linha(linha+"|\t|"+nome_sing+"|\t|"+email_sing+"|\t|"+senha_sing+"|\t|"+endereco_sing+"|", usuarios)
		a.fechar_arquivo(usuarios)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 9168; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
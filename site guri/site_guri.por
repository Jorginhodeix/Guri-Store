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
	inteiro tela_atual = tela_inicio
	inteiro largura_janela_auth = 500, altura_janela_auth = 775, largura_janela_inicio = 1000, altura_janela_inicio = 755

	// dados
	// campos_usuario[] = {nome, email, senha, endereço/código}, campos_produto[] = {nome, estoque, preço, desconto}
	cadeia codigo = "eu amo gatos", campos_usuario[] = {"", "", "", ""}, campos_produto[] = {"", "", "", ""}
	const inteiro limite_produtos = 99
	inteiro id_usuario, qtd_produtos[limite_produtos], produtos_carrinho[limite_produtos]
	logico ehFuncionario = verdadeiro, estaVisualizandoCarrinho = falso, estaModificandoProdutos = falso

	// inputs
	inteiro posicaoy_inputs[] = { 220, 300, 380, 460 }, altura_input = 30, inputSelecionado = -1
	real posicaox_input = (largura_janela_auth / 2) - (largura_janela_auth * 0.8 / 2), largura_input = largura_janela_auth * 0.8

	// links
	inteiro posicaox_link = 0, posicaoy_link = 0, largura_link = 0, altura_link = 0

	// botões 
	inteiro altura_botoes = 120, posicaoy_clientes = 200, posicaoy_funcionarios = posicaoy_clientes + 200, posicaoy_entrar = 550, margin = 30, altura_btn_add_to_cart = 30, largura_btn_add_to_cart = 150, altura_btn_quantidade = 30, largura_btn_mais_menos = 30, largura_btn_contador = 45, posicaox_carrinho = largura_janela_inicio - 50 - margin, posicaoy_carrinho = 30, altura_crud_btn = 30, largura_crud_btn = 70, largura_btn_confirmar = 200, altura_btn_confirmar = 50, tamanho_crud_btn = 30
	real posicaox_botoes = (largura_janela_auth / 2) - (largura_janela_auth * 0.8 / 2), largura_botoes = largura_janela_auth * 0.8
	
	// texto
	inteiro posicaox_cbc_quantidade = largura_janela_inicio - margin - largura_btn_add_to_cart - 180, posicaox_cbc_preco = posicaox_cbc_quantidade - 250, posicaox_cbc_estoque = posicaox_cbc_preco - 180
	real tamanho_titulo = 36.0
	
	// imagens
	inteiro logo = 0, entrar1 = 0, entrar2 = 0, hank = 0, funcionarios1 = 0, funcionarios2 = 0, clientes1 = 0, clientes2 = 0, criar_conta1 = 0, criar_conta2 = 0, carrinho = 0, add_to_cart1 = 0, add_to_cart2 = 0, sem_estoque = 0, botao_mais = 0, botao_menos = 0, contador_box = 0, btn_confirmar = 0, edit_icon = 0, delete_icon = 0

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

	funcao digitar_texto(inteiro campo, inteiro posicaoy_input) {
		enquanto(verdadeiro) {
			// se apertar fora do input desativa as teclas no input previamente selecionado
			se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() <= posicaox_input ou m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_input + largura_input ou m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_y() <= posicaoy_input ou m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_y() >= posicaoy_input + altura_input) {
				inputSelecionado = -1
				retorne
			}
			
			se(tc.alguma_tecla_pressionada()) {
				inteiro temp = tc.ler_tecla()
				logico tamanhoMax
				se(tela_atual == tela_inicio) {
					tamanhoMax = g.largura_texto(campos_produto[campo]) >= largura_input - 20
					se (temp == tc.TECLA_BACKSPACE) {
						inteiro tamanho = tx.numero_caracteres(campos_produto[campo])
						se (tamanho >= 1) {			
							campos_produto[campo] = tx.extrair_subtexto(campos_produto[campo], 0, tamanho - 1)
						}
					} senao se (tc.tecla_pressionada(tc.TECLA_SHIFT) e temp == tc.TECLA_2) {
		                	campos_produto[campo] += "@"
		            	} senao se (nao tamanhoMax) {
						caracter car = tc.caracter_tecla(temp)
						campos_produto[campo] += tx.caixa_baixa(tp.caracter_para_cadeia(car))			
					}	
				} senao {
					tamanhoMax = g.largura_texto(campos_usuario[campo]) >= largura_input - 20
					se (temp == tc.TECLA_BACKSPACE) {
						inteiro tamanho = tx.numero_caracteres(campos_usuario[campo])
						se (tamanho >= 1) {			
							campos_usuario[campo] = tx.extrair_subtexto(campos_usuario[campo], 0, tamanho - 1)
						}
					} senao se (tc.tecla_pressionada(tc.TECLA_SHIFT) e temp == tc.TECLA_2) {
		                	campos_usuario[campo] += "@"
		            	} senao se (nao tamanhoMax) {
						caracter car = tc.caracter_tecla(temp)
						campos_usuario[campo] += tx.caixa_baixa(tp.caracter_para_cadeia(car))			
					}	
				}
				
			}
			// chama a função para ficar renderizando a janela e ir mostrando oq está sendo escrito
			se(tela_atual == tela_inicio) {
				desenhar_pag_inicio()		
			} senao {
				desenhar_pag_auth()		
			}
		}
	}

	funcao desenharInput(cadeia label, inteiro posicaoy_input, inteiro campo, logico inputEstaSelecionado) {
		se(tela_atual == tela_inicio) {
			posicaox_input = (largura_janela_inicio / 2) - (largura_input / 2)
		}
		g.desenhar_texto(posicaox_input, posicaoy_input - 20, label)
		g.desenhar_retangulo(posicaox_input, posicaoy_input, largura_input, altura_input, verdadeiro, falso)
		se(tela_atual == tela_login) {
			campo++
		}
		se(tela_atual == tela_inicio) {
			g.desenhar_texto(posicaox_input + 10, posicaoy_input + (g.altura_texto(campos_produto[campo]) / 2), campos_produto[campo])
		} senao {
			g.desenhar_texto(posicaox_input + 10, posicaoy_input + (g.altura_texto(campos_usuario[campo]) / 2), campos_usuario[campo])	
		}
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
		carregarImagem(carrinho, "carrinho.jpeg", 50, 50)
		carregarImagem(logo, "logo.jpg", 300, 100)
		carregarImagem(add_to_cart1, "add-to-cart1.jpeg", largura_btn_add_to_cart, altura_btn_add_to_cart)
		carregarImagem(add_to_cart2, "add-to-cart2.jpeg", largura_btn_add_to_cart, altura_btn_add_to_cart)
		carregarImagem(sem_estoque, "sem-estoque.jpg", largura_btn_add_to_cart, altura_btn_add_to_cart)
		carregarImagem(botao_mais, "botao-mais.jpg", largura_btn_mais_menos, altura_btn_quantidade)
		carregarImagem(botao_menos, "botao-menos.jpg", largura_btn_mais_menos, altura_btn_quantidade)
		carregarImagem(contador_box, "contador-box.jpg", largura_btn_contador, altura_btn_quantidade)
		carregarImagem(btn_confirmar, "botao-confirmar.jpeg", largura_btn_confirmar, altura_btn_confirmar)
		carregarImagem(edit_icon, "edit-icon.jpeg", tamanho_crud_btn, tamanho_crud_btn)
		carregarImagem(delete_icon, "delete-icon.jpg", tamanho_crud_btn, tamanho_crud_btn)

		para(inteiro i = 0; i < limite_produtos; i++) {
			qtd_produtos[i] = 1 // colocar antes de entrar na tela inicio
			produtos_carrinho[i] = 0
		}
		
		g.iniciar_modo_grafico(falso)
		//g.definir_dimensoes_janela(largura_janela_auth, altura_janela_auth) MUDAR DEPOIS 
		g.definir_dimensoes_janela(largura_janela_inicio, altura_janela_inicio)
		g.definir_titulo_janela("Guri")
		g.definir_icone_janela(logo)
	}
	
	funcao pagina_login() {
		limpa()
		escreva("cu do cassio é preto")
		desenhar_pag_auth()
		// começa a atribuir valores no input clicado
	 	se(clicouInput(posicaoy_inputs[0])) {
	 		inputSelecionado = 0
	 		digitar_texto(1, posicaoy_inputs[0])
	 	} senao se (clicouInput(posicaoy_inputs[1])) {
	 		inputSelecionado = 1
	 		digitar_texto(2, posicaoy_inputs[1])
	 	}
		// redireciona para a tela cadastro ao clicar no link cadastre-se
	 	se(clicouLink()) {
	 		tela_atual = tela_cadastro
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}

	 	// vai para tela inicio ao apertar no botão login caso a senha e email estejam válidos
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e hoverBotao(posicaoy_entrar)) {
			se(campos_usuario[1] != "" e campos_usuario[2] != "") {
				se(email_existe()) {
					se(senha_esta_correta()) {
						verificarSeEhFuncionario()
			 			tela_atual = tela_inicio
			 			g.definir_dimensoes_janela(largura_janela_inicio, altura_janela_inicio)
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
    		g.desenhar_texto((largura_janela_auth / 2) - (g.largura_texto(titulo) / 2), 100, titulo)
    		
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
			cadeia labels[] = {"Nome", "Email", "Senha", "Endereço"}
			inteiro label = 0
			// desenhar inputs
			para(inteiro i = 0; i < 4; i++) {
				se(i == 0 e tela_atual == tela_login) {
					label++
				}
				se(i == 2 e tela_atual == tela_login) {
					pare				
				}
				se(i == 3 e tela_atual == tela_cadastro_f) {
					labels[i] = "Código"
				}
				desenharInput(labels[label], posicaoy_inputs[i], i, inputSelecionado == i)
				label++
			}
		}
		cadeia texto_link 
		inteiro n = 1
		se (tela_atual == tela_login) {
			texto_link = "Cadastre-se"
		} senao {
			texto_link = "Voltar"
			n = 3
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
		
		se(m.botao_pressionado(m.BOTAO_ESQUERDO) e hoverBotao(posicaoy_clientes) ou m.botao_pressionado(m.BOTAO_ESQUERDO) e hoverBotao(posicaoy_funcionarios) ou clicouLink()) {
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
		 	para (inteiro i = 0; i < u.numero_elementos(campos_usuario); i++) {
				campos_usuario[i] = ""
			}
		}
	}
	
	funcao pagina_cadastrar() {
		limpa()
		escreva("cadastrar funcionario ou cliente")
		desenhar_pag_auth()

		se (clicouInput(posicaoy_inputs[0])) {
			inputSelecionado = 0
			digitar_texto(0, posicaoy_inputs[0])
		} senao se (clicouInput(posicaoy_inputs[1])) {
			inputSelecionado = 1
	 		digitar_texto(1, posicaoy_inputs[1])
	 	} senao se (clicouInput(posicaoy_inputs[2])) {
	 		inputSelecionado = 2
	 		digitar_texto(2, posicaoy_inputs[2])
	 	} senao se (clicouInput(posicaoy_inputs[3])) {
 			inputSelecionado = 3
 			digitar_texto(3, posicaoy_inputs[3])
 		}	
		
		se(clicouLink()) {
	 		tela_atual = tela_cadastro
	 		enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
	 	}
	 	
	 	se(m.botao_pressionado(m.BOTAO_ESQUERDO) e hoverBotao(posicaoy_entrar)) {
	 		inteiro estrutura_email = tx.posicao_texto("@gmail.com", campos_usuario[1], 0), numero_caracteres_senha = tx.numero_caracteres(campos_usuario[2])
			logico todos_campos_preenchidos

			se (campos_usuario[0] != "" e campos_usuario[1] != "" e campos_usuario[2] != "" e campos_usuario[3] != "") { 
				todos_campos_preenchidos = verdadeiro
			} senao {
				todos_campos_preenchidos = falso
			}

	 		se (todos_campos_preenchidos) {
	 			se (estrutura_email != -1 e numero_caracteres_senha >= 6){
					se (nao email_existe()){
						logico codigo_esta_correto = falso
						se(tela_atual == tela_cadastro_f) {
							se(campos_usuario[3] == codigo) {
								codigo_esta_correto = verdadeiro
								ehFuncionario = verdadeiro
							} senao {
								escreva("\nCódigo está incorreto")
							}
						}
						se(tela_atual == tela_cadastro_f e codigo_esta_correto ou tela_atual == tela_cadastro_c) {
							salvar_usuario()
				 			tela_atual = tela_inicio
				 			g.definir_dimensoes_janela(largura_janela_inicio, altura_janela_inicio)	
						}
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
		desenhar_pag_inicio()

		se(clicouInput(posicaoy_inputs[0])) {
	 		inputSelecionado = 0
	 		digitar_texto(0, posicaoy_inputs[0])
	 	} senao se (clicouInput(posicaoy_inputs[1])) {
	 		inputSelecionado = 1
	 		digitar_texto(1, posicaoy_inputs[1])
	 	} senao se (clicouInput(posicaoy_inputs[2])) {
	 		inputSelecionado = 2
	 		digitar_texto(2, posicaoy_inputs[2])
	 	} senao se (clicouInput(posicaoy_inputs[3])) {
	 		inputSelecionado = 3
	 		digitar_texto(3, posicaoy_inputs[3])
	 	}
	}

	funcao desenhar_pag_inicio() {	
		inteiro qtd_produtos_carrinho = 0		
		g.definir_cor(g.COR_BRANCO)
		g.limpar()
		g.desenhar_imagem(margin, margin - 20, logo)
		se(nao ehFuncionario) {
			inteiro posicaox_popup = posicaox_carrinho + g.largura_imagem(carrinho) - 15, posicaoy_popup = posicaoy_carrinho + 5
			g.desenhar_imagem(posicaox_carrinho, posicaoy_carrinho, carrinho)
			para(inteiro i = 0; i < limite_produtos; i++) {
				se(produtos_carrinho[i] > 0) {
					qtd_produtos_carrinho++
				}
			}
			se(qtd_produtos_carrinho > 0) {
				g.definir_cor(g.COR_VERMELHO)
				g.desenhar_elipse(posicaox_popup, posicaoy_popup, 15, 15, verdadeiro)
				g.definir_cor(g.COR_BRANCO)
				g.definir_tamanho_texto(10.0)
				g.desenhar_texto(posicaox_popup + (15 / 2) - (g.largura_texto(tp.inteiro_para_cadeia(qtd_produtos_carrinho, 10)) / 2), posicaoy_popup + (15 / 2) - (g.altura_texto(tp.inteiro_para_cadeia(qtd_produtos_carrinho, 10)) / 2) + 1, tp.inteiro_para_cadeia(qtd_produtos_carrinho, 10))	
			}
			se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_carrinho e m.posicao_x() <= posicaox_carrinho + g.largura_imagem(carrinho) e m.posicao_y() >= posicaoy_carrinho e m.posicao_y() <= posicaoy_carrinho + g.altura_imagem(carrinho)) {
				se(estaVisualizandoCarrinho) {
					estaVisualizandoCarrinho = falso
				} senao {
					estaVisualizandoCarrinho = verdadeiro
				}
				enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
			}
		} senao {
			inteiro largura_adicionar = 100, altura_adicionar = 35, posicaox_adicionar = largura_janela_inicio - largura_adicionar - margin, posicaoy_adicionar = margin
			g.definir_cor(g.COR_VERDE)
			g.desenhar_retangulo(posicaox_adicionar, posicaoy_adicionar, largura_adicionar, altura_adicionar, verdadeiro, verdadeiro)
			g.definir_estilo_texto(falso, verdadeiro, falso)
			g.definir_tamanho_texto(18.0)
			g.definir_cor(g.COR_BRANCO)
			cadeia texto = "Adicionar"
			g.desenhar_texto(posicaox_adicionar + (largura_adicionar / 2) - (g.largura_texto(texto) / 2), posicaoy_adicionar + (altura_adicionar / 2) - (g.altura_texto(texto) / 2), texto)
			se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_adicionar e m.posicao_x() <= posicaox_adicionar + largura_adicionar e m.posicao_y() >= posicaoy_adicionar e m.posicao_y() <= posicaoy_adicionar + altura_adicionar) {
				se(estaModificandoProdutos) {
					estaModificandoProdutos = falso
				} senao {
					estaModificandoProdutos = verdadeiro	
				}
				enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
			}
			se(estaModificandoProdutos) {
				adicionarProduto()
			}
		}
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.definir_tamanho_texto(30.0)
		g.definir_cor(g.COR_PRETO)
		g.desenhar_texto(margin, 115, "Produtos")
		g.definir_tamanho_texto(20.0)
		g.desenhar_texto(margin, 115 + g.altura_texto("Produtos") + margin, "Nome")
		se(nao ehFuncionario) {
			g.desenhar_texto(posicaox_cbc_estoque, 115 + g.altura_texto("Produtos") + margin, "Estoque")
			g.desenhar_texto(posicaox_cbc_preco, 115 + g.altura_texto("Produtos") + margin, "Preço")
			g.desenhar_texto(posicaox_cbc_quantidade, 115 + g.altura_texto("Produtos") + margin, "Quantidade")
		} senao {
			g.desenhar_texto(posicaox_cbc_preco, 115 + g.altura_texto("Produtos") + margin, "Estoque")
			g.desenhar_texto(posicaox_cbc_quantidade, 115 + g.altura_texto("Produtos") + margin, "Preço")
		}
		g.desenhar_linha(margin, 195, largura_janela_inicio - margin, 195)
		g.definir_estilo_texto(falso, falso, falso)
		listarProdutos()
		se(estaVisualizandoCarrinho) {
			visualizarCarrinho(qtd_produtos_carrinho)
		}
		
		g.renderizar()
	}

	funcao lerDadoLinha(inteiro n, inteiro &p1, inteiro &p2, cadeia conteudoLinha) {
		p1 = 0
		p2 = 0
		para(inteiro i = 1; i < n; i++) {
			p1 = tx.posicao_texto("|", conteudoLinha, p2)
			p2 = tx.posicao_texto("|", conteudoLinha, p1+1)
		}
	}

	funcao adicionarProduto() {
		inteiro largura_janela = 450, altura_janela = 600, posicaox_janela = (largura_janela_inicio / 2) - (largura_janela / 2), posicaoy_janela = (altura_janela_inicio / 2) - (altura_janela / 2), margin_janela = posicaox_janela + margin, posicaoy_title = posicaoy_janela + 30, posicaox_cbc_carrinho_preco = posicaox_janela + margin + 120, posicaox_cbc_carrinho_quantidade = posicaox_janela + largura_janela - g.largura_texto("CARRINHO") - margin - 10
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_retangulo(posicaox_janela, posicaoy_janela, largura_janela, altura_janela, falso, verdadeiro)	
		g.definir_cor(g.COR_PRETO)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.definir_tamanho_texto(25.0)
		cadeia texto = "ADICIONAR"
		g.desenhar_texto(posicaox_janela + (largura_janela / 2) - (g.largura_texto(texto) / 2), posicaoy_title, texto)
		g.definir_estilo_texto(falso, falso, falso)
		g.definir_tamanho_texto(17.0)
		cadeia labels[] = {"Nome", "Estoque", "Preço", "Desconto (%)"}
		inteiro label = 0
		// desenhar inputs
		para(inteiro i = 0; i < 4; i++) {
			se(i == 0 e tela_atual == tela_login) {
				label++
			}
			se(i == 2 e tela_atual == tela_login) {
				pare				
			}
			se(i == 3 e tela_atual == tela_cadastro_f) {
				labels[i] = "Código"
			}
			desenharInput(labels[label], posicaoy_inputs[i], i, inputSelecionado == i)
			label++
		}
	}
	
	funcao visualizarCarrinho(inteiro qtd_produtos_carrinho) {
		inteiro largura_janela = 450, altura_janela = 600, posicaox_janela = (largura_janela_inicio / 2) - (largura_janela / 2), posicaoy_janela = (altura_janela_inicio / 2) - (altura_janela / 2), margin_janela = posicaox_janela + margin, posicaoy_title = posicaoy_janela + 30, posicaox_cbc_carrinho_preco = posicaox_janela + margin + 120, posicaox_cbc_carrinho_quantidade = posicaox_janela + largura_janela - g.largura_texto("CARRINHO") - margin - 10
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_retangulo(posicaox_janela, posicaoy_janela, largura_janela, altura_janela, falso, verdadeiro)	
		g.definir_cor(g.COR_PRETO)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.definir_tamanho_texto(25.0)
		g.desenhar_texto(posicaox_janela + (largura_janela / 2) - (g.largura_texto("CARRINHO") / 2), posicaoy_title, "CARRINHO")
		g.definir_tamanho_texto(18.0)
		g.desenhar_texto(margin_janela, posicaoy_title + 50, "Produto")
		g.desenhar_texto(posicaox_cbc_carrinho_preco, posicaoy_title + 50, "Preço")
		g.desenhar_texto(posicaox_cbc_carrinho_quantidade, posicaoy_title + 50, "Qtd")
		
		g.definir_estilo_texto(falso, falso, falso)
		g.desenhar_linha(posicaox_janela + margin, posicaoy_title + 75, posicaox_janela + largura_janela - margin, posicaoy_title + 75)

		inteiro produtos = a.abrir_arquivo("produtos.txt", a.MODO_LEITURA), linha = 0, posicaoY = 200
		logico x = falso
		cadeia conteudoLinha = "", id_produto, nome_produto, estoque_produto, desconto_produto, preco_produto
		real preco_final = 0.0, preco_total = 0.0
		enquanto(x == falso) {
			inteiro quantidade_produto = 0
			conteudoLinha = a.ler_linha(produtos)
			x = a.fim_arquivo(produtos)
			se(conteudoLinha != "" e linha != 0) {
				inteiro p1 = 0, p2 = 0	
				p1 = tx.posicao_texto("|", conteudoLinha, p2)
				id_produto = tx.extrair_subtexto(conteudoLinha, p2, p1)
				para(inteiro i = 0; i < limite_produtos; i++) {
					se(produtos_carrinho[i] == tp.cadeia_para_inteiro(id_produto, 10)) {
						quantidade_produto++
					}
				}
				se(quantidade_produto > 0) {
					p1 = 0
					lerDadoLinha(3, p1, p2, conteudoLinha)	
					nome_produto = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
					lerDadoLinha(5, p1, p2, conteudoLinha)	
					estoque_produto = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
					lerDadoLinha(7, p1, p2, conteudoLinha)	
					preco_produto = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
					lerDadoLinha(9, p1, p2, conteudoLinha)	
					desconto_produto = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
					// valores: nome, estoque e preço
					g.desenhar_texto(margin_janela, posicaoY, nome_produto)
					se(desconto_produto != "0") {
						preco_final = tp.cadeia_para_real(preco_produto) - tp.cadeia_para_real(preco_produto) * tp.cadeia_para_real(desconto_produto) / 100	
						g.desenhar_texto(posicaox_cbc_carrinho_preco, posicaoY, "R$" + tp.real_para_cadeia(preco_final))
						g.definir_estilo_texto(falso, falso, falso)
						g.definir_cor(12300)
						g.definir_estilo_texto(verdadeiro, falso, falso)
						g.desenhar_texto(posicaox_cbc_carrinho_preco + g.largura_texto("R$" + tp.real_para_cadeia(preco_final)) + 10, posicaoY, "~R$" + preco_produto + "~")
						g.definir_cor(g.COR_PRETO)
						g.definir_estilo_texto(falso, falso, falso)
					} senao {
						preco_final = tp.cadeia_para_real(preco_produto)
						g.desenhar_texto(posicaox_cbc_carrinho_preco, posicaoY, "R$" + preco_produto)
					}
					g.desenhar_texto(posicaox_cbc_carrinho_quantidade, posicaoY, tp.inteiro_para_cadeia(quantidade_produto, 10))
					
					// botao remover
					inteiro posicaox_btn_remover = posicaox_janela + largura_janela - largura_crud_btn - margin, posicaoy_btn_remover = posicaoY - 5
					g.definir_cor(g.COR_VERMELHO)
					g.desenhar_retangulo(posicaox_btn_remover, posicaoy_btn_remover, largura_crud_btn, altura_crud_btn, verdadeiro, verdadeiro)
					g.definir_cor(g.COR_BRANCO)
					g.definir_tamanho_texto(13.0)
					g.definir_estilo_texto(falso, verdadeiro, falso)
					g.desenhar_texto(posicaox_btn_remover + (largura_crud_btn / 2) - (g.largura_texto("Remover") / 2), posicaoy_btn_remover + (altura_crud_btn / 2) - (g.altura_texto("Remover") / 2), "Remover")
					g.definir_cor(g.COR_PRETO)
					g.definir_tamanho_texto(18.0)
					g.definir_estilo_texto(falso, falso, falso)
					se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_btn_remover e m.posicao_x() <= posicaox_btn_remover + largura_crud_btn e m.posicao_y() >= posicaoy_btn_remover e m.posicao_y() <= posicaoy_btn_remover + altura_crud_btn) {
						para(inteiro i = 0; i < limite_produtos; i++) {
							se(produtos_carrinho[i] == tp.cadeia_para_inteiro(id_produto, 10)) {
								produtos_carrinho[i] = 0
								pare
							}
						}
						enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
					}
	
					tp.cadeia_para_real(preco_produto)
					preco_total += preco_final * quantidade_produto
					g.desenhar_linha(posicaox_janela + margin, posicaoY + 35, posicaox_janela + largura_janela - margin, posicaoY + 35)

					// botao finalizar compra
					inteiro posicaox_btn_confirmar = posicaox_janela + (largura_janela / 2) - (largura_btn_confirmar / 2), posicaoy_btn_confirmar = posicaoy_janela + altura_janela - (altura_btn_confirmar / 2) - margin
					g.desenhar_imagem(posicaox_btn_confirmar, posicaoy_btn_confirmar, btn_confirmar)
					se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_btn_confirmar e m.posicao_x() <= posicaox_btn_confirmar + largura_btn_confirmar e m.posicao_y() >= posicaoy_btn_confirmar e m.posicao_y() <= posicaoy_btn_confirmar + altura_btn_confirmar) {
						/*inteiro novo_estoque = tp.cadeia_para_inteiro(estoque_produto, 10) - quantidade_produto
						a.substituir_texto("produtos.txt", "|" + nome_produto + "|\t|" + estoque_produto + "|", "|" + nome_produto + "|\t|" + tp.inteiro_para_cadeia(novo_estoque, 10) + "|", verdadeiro)
						para(inteiro i = 0; i < limite_produtos; i++) {
							produtos_carrinho[i] = 0
						}*/
						enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
					}
		
					posicaoY += 50
				}
			}
			se(x e qtd_produtos_carrinho > 0) {
				g.desenhar_texto(posicaox_janela + largura_janela - g.largura_texto("Total: R$" + tp.real_para_cadeia(preco_total)) - margin, posicaoY, "Total: R$" + tp.real_para_cadeia(preco_total))
			} senao se (x e qtd_produtos_carrinho == 0) {
				cadeia texto = "Nenhum produto adicionado no carrinho :/"
				g.desenhar_texto(posicaox_janela + (largura_janela / 2) - (g.largura_texto(texto) / 2), posicaoy_janela + (altura_janela / 2) - (g.altura_texto(texto) / 2) - 50, texto)
			}
			linha++
		}
		a.fechar_arquivo(produtos)
	}

	funcao adicionarAoCarrinho(inteiro linha) {
		para(inteiro i = 0; i < qtd_produtos[linha]; i++) {
			para(inteiro j = 0; j < limite_produtos; j++) {
				se(produtos_carrinho[j] == 0) {
					produtos_carrinho[j] = linha
					pare
				} 
			}	
		}
	}

	funcao listarProdutos() {
		inteiro produtos = a.abrir_arquivo("produtos.txt", a.MODO_LEITURA), posicaoY = 210, linha = 0
		cadeia conteudoLinha = "", nome_produto, estoque_produto, desconto_produto, preco_produto
		logico x = falso
		enquanto(x == falso){
			conteudoLinha = a.ler_linha(produtos)
			x = a.fim_arquivo(produtos)
			se(conteudoLinha != "" e linha != 0) {
				inteiro p1 = 0, p2 = 0	
				lerDadoLinha(3, p1, p2, conteudoLinha)	
				nome_produto = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
				lerDadoLinha(5, p1, p2, conteudoLinha)	
				estoque_produto = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
				lerDadoLinha(7, p1, p2, conteudoLinha)	
				preco_produto = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
				lerDadoLinha(9, p1, p2, conteudoLinha)	
				desconto_produto = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
				// valores: nome, estoque e preço
				g.desenhar_texto(margin, posicaoY, nome_produto)
				se(ehFuncionario) {
					g.desenhar_texto(posicaox_cbc_preco, posicaoY, estoque_produto)		
				} senao {
					g.desenhar_texto(posicaox_cbc_estoque, posicaoY, estoque_produto)		
				}
				se(desconto_produto != "0") {
					real preco_final = tp.cadeia_para_real(preco_produto) - tp.cadeia_para_real(preco_produto) * tp.cadeia_para_real(desconto_produto) / 100	
					se(ehFuncionario) {
						g.desenhar_texto(posicaox_cbc_quantidade, posicaoY, "R$" + tp.real_para_cadeia(preco_final))	
					} senao {
						g.desenhar_texto(posicaox_cbc_preco, posicaoY, "R$" + tp.real_para_cadeia(preco_final))	
					}
					g.definir_estilo_texto(falso, falso, falso)
					g.definir_cor(12300)
					g.definir_estilo_texto(verdadeiro, falso, falso)
					se(ehFuncionario) {
						g.desenhar_texto(posicaox_cbc_quantidade + g.largura_texto("R$" + tp.real_para_cadeia(preco_final)) + 10, posicaoY, "~R$" + preco_produto + "~")
					} senao {
						g.desenhar_texto(posicaox_cbc_preco + g.largura_texto("R$" + tp.real_para_cadeia(preco_final)) + 10, posicaoY, "~R$" + preco_produto + "~")	
					}
					g.definir_cor(g.COR_PRETO)
					g.definir_estilo_texto(falso, falso, falso)
				} senao {
					se(ehFuncionario) {
						g.desenhar_texto(posicaox_cbc_quantidade, posicaoY, "R$" + preco_produto)
					} senao {
						g.desenhar_texto(posicaox_cbc_preco, posicaoY, "R$" + preco_produto)	
					}
				}
				se(nao ehFuncionario) {
					// botao quantidade
					inteiro posicaoy_btn_qtd = posicaoY - 5, posicaox_btn_contador = posicaox_cbc_quantidade + largura_btn_mais_menos + 5
					g.desenhar_imagem(posicaox_cbc_quantidade, posicaoy_btn_qtd, botao_menos)
					g.desenhar_imagem(posicaox_btn_contador, posicaoy_btn_qtd, contador_box)
					g.desenhar_imagem(posicaox_btn_contador + largura_btn_contador + 5, posicaoy_btn_qtd, botao_mais)
					se(estoque_produto == "0") {
						qtd_produtos[linha] = 0
					}
					g.desenhar_texto(posicaox_btn_contador + (largura_btn_contador / 2) - (g.largura_texto(tp.inteiro_para_cadeia(qtd_produtos[linha], 10)) / 2), posicaoy_btn_qtd + (altura_btn_quantidade / 2) - (g.altura_texto(tp.inteiro_para_cadeia(qtd_produtos[linha], 10)) / 2), tp.inteiro_para_cadeia(qtd_produtos[linha], 10))
					se(nao estaVisualizandoCarrinho e m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_cbc_quantidade e m.posicao_x() <= posicaox_cbc_quantidade + largura_btn_mais_menos e m.posicao_y() >= posicaoy_btn_qtd e m.posicao_y() <= posicaoy_btn_qtd + altura_btn_quantidade) {
						se(qtd_produtos[linha] == 1) {
							qtd_produtos[linha] = tp.cadeia_para_inteiro(estoque_produto, 10)
						} senao {
							qtd_produtos[linha]--	
						}
						enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
					}
					se(nao estaVisualizandoCarrinho e m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_btn_contador + largura_btn_contador + 5 e m.posicao_x() <= posicaox_btn_contador + largura_btn_contador + 5 + largura_btn_mais_menos e m.posicao_y() >= posicaoy_btn_qtd e m.posicao_y() <= posicaoy_btn_qtd + altura_btn_quantidade) {
						se(qtd_produtos[linha] == tp.cadeia_para_inteiro(estoque_produto, 10)) {
							qtd_produtos[linha] = 1
						} senao {
							qtd_produtos[linha]++
						}
						enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
					}	
					// botao adicionar ao carrinho
					inteiro posicaox_addToCart = largura_janela_inicio - largura_btn_add_to_cart - margin, posicaoy_addToCart = posicaoY - 5
					se(estoque_produto == "0") {
						g.desenhar_imagem(posicaox_addToCart, posicaoy_addToCart, sem_estoque)
					} senao {
						se(m.posicao_x() >= posicaox_addToCart e m.posicao_x() <= posicaox_addToCart + largura_btn_add_to_cart e m.posicao_y() >= posicaoy_addToCart e m.posicao_y() <= posicaoy_addToCart + altura_btn_add_to_cart) {
							g.desenhar_imagem(posicaox_addToCart, posicaoy_addToCart, add_to_cart2)
						} senao {
							g.desenhar_imagem(posicaox_addToCart, posicaoy_addToCart, add_to_cart1)	
						}
						se(m.botao_pressionado(m.BOTAO_ESQUERDO) e m.posicao_x() >= posicaox_addToCart e m.posicao_x() <= posicaox_addToCart + largura_btn_add_to_cart e m.posicao_y() >= posicaoy_addToCart e m.posicao_y() <= posicaoy_addToCart + altura_btn_add_to_cart) {
							inteiro qtd_que_falta = tp.cadeia_para_inteiro(estoque_produto, 10)
							para(inteiro i = 0; i < limite_produtos; i++) {
								se(produtos_carrinho[i] == linha) {
									qtd_que_falta--
								} 
							}	
							se(qtd_produtos[linha] <= qtd_que_falta) {
								adicionarAoCarrinho(linha)
							} senao {
								se(qtd_que_falta != 0) {
									inteiro temp = qtd_produtos[linha]
									qtd_produtos[linha] = qtd_que_falta
									adicionarAoCarrinho(linha)
									qtd_produtos[linha] = temp
								}
							}
							enquanto (m.botao_pressionado(m.BOTAO_ESQUERDO)) {}
						}	
					}
				} senao {
					// botoes editar e excluir
					inteiro posicaox_delete = largura_janela_inicio - tamanho_crud_btn - margin, posicaox_edit = largura_janela_inicio - tamanho_crud_btn * 2 - margin - 20, posicaoy_btn = posicaoY - 5
					g.desenhar_imagem(posicaox_delete, posicaoy_btn, delete_icon)
					g.desenhar_imagem(posicaox_edit, posicaoy_btn, edit_icon)
				}
				g.desenhar_linha(margin, posicaoY + 35, largura_janela_inicio - margin, posicaoY + 35)
				posicaoY += 50
			}
			linha++
		}
		a.fechar_arquivo(produtos)
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
				lerDadoLinha(5, p1, p2, conteudoLinha)	
				email = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
				se(email == campos_usuario[1]){
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
		lerDadoLinha(7, p1, p2, conteudoLinha)	
		senha = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
		a.fechar_arquivo(usuarios)
		se (senha == campos_usuario[2]){
			retorne verdadeiro
		} senao {
			retorne falso
		}
	}

	funcao verificarSeEhFuncionario() {
		inteiro usuarios = a.abrir_arquivo("usuarios.txt", a.MODO_LEITURA), p1 = 0, p2 = 0
		cadeia conteudoLinha = "", endereco = ""
		para(inteiro i = 1; i <= id_usuario + 1; i++){
			conteudoLinha = a.ler_linha(usuarios)
		}
		lerDadoLinha(9, p1, p2, conteudoLinha)					
		endereco = tx.extrair_subtexto(conteudoLinha, p1+1, p2)
		a.fechar_arquivo(usuarios)
		se(endereco != "Null") {
			ehFuncionario = falso
		} senao {
			ehFuncionario = verdadeiro
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
			a.escrever_linha("\n" + linha + "|\t|" + campos_usuario[0] + "|\t|" + campos_usuario[1] + "|\t|" + campos_usuario[2] + "|\t|" + campos_usuario[3] + "|", usuarios)	
		} senao {
			a.escrever_linha("\n" + linha + "|\t|" + campos_usuario[0] + "|\t|" + campos_usuario[1] + "|\t|" + campos_usuario[2] + "|\t|" + "Null" + "|", usuarios)
		}
		a.fechar_arquivo(usuarios)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 3508; 
 * @DOBRAMENTO-CODIGO = [41, 49, 57, 65, 114, 133, 138, 162, 319, 343, 503, 652, 781, 804, 820, 836];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
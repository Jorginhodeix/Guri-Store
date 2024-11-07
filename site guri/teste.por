programa
{
	inclua biblioteca Arquivos --> a
	inclua biblioteca Texto --> tx
	inteiro id_usuario
	cadeia email_log = "luis2gmail.com", senha_log = "12332190"
	logico email_existe = falso, xitos = falso
	funcao inicio()
	{
		verificar_email_existente()
	 	xitos = verificar_senha()
	 	verificar_email_existente()
		se(xitos == verdadeiro){
			escreva("Olá Mundo")
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
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 158; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors());

// Ligação ao MongoDB Atlas usando a variável de ambiente do Render
mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log('Ligado ao MongoDB Atlas com sucesso!'))
  .catch((err) => console.log('Erro ao ligar ao MongoDB:', err));

// Esquema e Modelo do Prato da Ementa
const pratoSchema = new mongoose.Schema({
  nome: { type: String, required: true },
  descricao: String,
  preco: { type: Number, required: true },
  categoria: String, // ex: 'Entradas', 'Pratos Principais', 'Sobremesas'
  disponivel: { type: Boolean, default: true }
});

const Prato = mongoose.model('Prato', pratoSchema);

// --- ROTAS DA EMENTA (Para o painel de admin consumir) ---

// 1. Obter todos os pratos (para mostrar no site e no admin)
app.get('/api/ementa', async (req, res) => {
  try {
    const pratos = await Prato.find();
    res.json(pratos);
  } catch (error) {
    res.status(500).json({ erro: 'Erro ao buscar ementa' });
  }
});

// 2. Adicionar novo prato (usado pelo painel de admin)
app.post('/api/ementa', async (req, res) => {
  try {
    const novoPrato = new Prato(req.body);
    await novoPrato.save();
    res.status(201).json(novoPrato);
  } catch (error) {
    res.status(400).json({ erro: 'Erro ao criar prato' });
  }
});

// 3. Apagar um prato pelo ID (usado pelo painel de admin)
app.delete('/api/ementa/:id', async (req, res) => {
  try {
    await Prato.findByIdAndDelete(req.params.id);
    res.json({ mensagem: 'Prato removido com sucesso' });
  } catch (error) {
    res.status(500).json({ erro: 'Erro ao apagar prato' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor a correr na porta ${PORT}`);
});

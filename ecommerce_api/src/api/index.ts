import express from 'express';
import MessageResponse from '../interfaces/MessageResponse';
import emojis from './emojis';
import Todos from './todos/todos.model';


const router = express.Router();

router.get<{}, MessageResponse>('/', (req, res) => {
  res.json({
    message: 'API - 👋🌎🌍🌏',
  });
});


router.use('/emojis', emojis);
router.use('/todos', Todos);


export default router;

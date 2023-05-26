import express from 'express';
import MessageResponse from '../interfaces/MessageResponse';
// import emojis from './emojis';
import supportChat from '././support_chat/supportChat';

const router = express.Router();

router.get<{}, MessageResponse>('/', (req, res) => {
  res.json({
    message: 'API - 👋🌎🌍🌏',
  });
});


// router.use('/emojis', emojis);
router.use('/support_chat', supportChat);


export default router;

import express from 'express';
import Todo from './todos.model';

const router = express.Router();

type TodoResponse = Todo[];

router.get<{}, TodoResponse>('/', (req, res) => {
    res.json(
        [{
            content: 'Learn TypeScript',
            done: false
        },
        {
            content: 'Buy Milk',
            done: false
        },
        ],
    );
});

export default router;
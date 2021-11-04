import * as express from 'express';
import { createDoc, getRecentUpdatedDoc, getTopViewedDoc } from '../sql/documents-query';

const router = express.Router();
router.get('/recents', async (req: express.Request, res: express.Response) => {
  const defaultCount = 20;
  let count = parseInt(req.query.count.toString()) || defaultCount;
  let result = await getRecentUpdatedDoc({ count: count });
  res.status(200);
  res.json({ msg: 'OK', result: result });
});

router.get('/ranks', async (req: express.Request, res: express.Response) => {
  const defaultCount = 20;
  const count = parseInt(req.query.count.toString()) || defaultCount;
  let result = await getTopViewedDoc({ count: count });
  res.status(200);
  res.json({ msg: 'OK', result: result });
});

router.post('/', async (req: express.Request, res: express.Response) => {
  console.log(req.body);
  let result = await createDoc(req.body);
  res.status(200);
  res.json({ msg: 'OK', result: result });
});

export default router;

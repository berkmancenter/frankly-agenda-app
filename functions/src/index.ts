
import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions/v2";
import {generateEventPlan} from "frankly-agenda-builder";

export const agendaBuildEventPlan = functions.https.onCall(
  async (data) => {
    const eventPlan = await generateEventPlan(JSON.stringify(data.data));
    logger.info("Recieved an event plan: " + eventPlan);
    return {eventPlan};
  });

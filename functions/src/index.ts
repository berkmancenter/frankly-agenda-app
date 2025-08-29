
import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions";
import {generateEventPlan} from "frankly-agenda-builder";

export const createEventPlan = functions.https.onCall(async (data, context) => {
  const eventPlan = await generateEventPlan(JSON.stringify(data.data));
  logger.info("Recieved an event plan: " + eventPlan);
  return {eventPlan};
});


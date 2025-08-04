
import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions";
import {generateEventPlan} from "frankly-agenda-builder";

export const createEventPlan = functions.https.onCall((data, context) => {
  // const eventPlan = generateEventPlan(JSON.stringify(data.data));
  const eventPlan = generateEventPlan(JSON.stringify("very bad data"));

  logger.info("Recieved an event plan: " + eventPlan);
  return {eventPlan};
});



import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions";
import {generateEventPlan} from "frankly-agenda-builder";

export const createEventPlan = functions.https.onCall((data, context) => {
  console.log(data.data);
  logger.info("hi test update there logs! " + data.data);

  const eventPlan = generateEventPlan(JSON.stringify(data.data));
  logger.info("hi test update there logs! " + eventPlan);
  return {eventPlan};
});


function(doc) {
  emit(doc['tweet_id'], null);
}

function(doc) {
  emit(doc['from_user'], 1);
}

function(key, value, rereduce) {
  return sum(v);
}

function(doc) {
  emit(doc['from_user'], doc);
}
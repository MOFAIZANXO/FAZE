// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetJournalEntryCollection on Isar {
  IsarCollection<JournalEntry> get journalEntrys => this.collection();
}

const JournalEntrySchema = CollectionSchema(
  name: r'JournalEntry',
  id: -8443410721192565146,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dailyRating': PropertySchema(
      id: 1,
      name: r'dailyRating',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 2,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'energyLevel': PropertySchema(
      id: 3,
      name: r'energyLevel',
      type: IsarType.long,
    ),
    r'gratitudeList': PropertySchema(
      id: 4,
      name: r'gratitudeList',
      type: IsarType.stringList,
    ),
    r'isComplete': PropertySchema(
      id: 5,
      name: r'isComplete',
      type: IsarType.bool,
    ),
    r'lessonLearned': PropertySchema(
      id: 6,
      name: r'lessonLearned',
      type: IsarType.string,
    ),
    r'mentalActivity': PropertySchema(
      id: 7,
      name: r'mentalActivity',
      type: IsarType.string,
    ),
    r'mentalActivityType': PropertySchema(
      id: 8,
      name: r'mentalActivityType',
      type: IsarType.string,
    ),
    r'mentalRating': PropertySchema(
      id: 9,
      name: r'mentalRating',
      type: IsarType.long,
    ),
    r'physicalActivities': PropertySchema(
      id: 10,
      name: r'physicalActivities',
      type: IsarType.stringList,
    ),
    r'prayersCompleted': PropertySchema(
      id: 11,
      name: r'prayersCompleted',
      type: IsarType.bool,
    ),
    r'spiritualActivities': PropertySchema(
      id: 12,
      name: r'spiritualActivities',
      type: IsarType.stringList,
    ),
    r'strengthDemonstrated': PropertySchema(
      id: 13,
      name: r'strengthDemonstrated',
      type: IsarType.string,
    ),
    r'tomorrowIntention': PropertySchema(
      id: 14,
      name: r'tomorrowIntention',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 15,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _journalEntryEstimateSize,
  serialize: _journalEntrySerialize,
  deserialize: _journalEntryDeserialize,
  deserializeProp: _journalEntryDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _journalEntryGetId,
  getLinks: _journalEntryGetLinks,
  attach: _journalEntryAttach,
  version: '3.1.0+1',
);

int _journalEntryEstimateSize(
  JournalEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.gratitudeList.length * 3;
  {
    for (var i = 0; i < object.gratitudeList.length; i++) {
      final value = object.gratitudeList[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.lessonLearned;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mentalActivity;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mentalActivityType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.physicalActivities.length * 3;
  {
    for (var i = 0; i < object.physicalActivities.length; i++) {
      final value = object.physicalActivities[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.spiritualActivities.length * 3;
  {
    for (var i = 0; i < object.spiritualActivities.length; i++) {
      final value = object.spiritualActivities[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.strengthDemonstrated;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tomorrowIntention;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _journalEntrySerialize(
  JournalEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeLong(offsets[1], object.dailyRating);
  writer.writeDateTime(offsets[2], object.date);
  writer.writeLong(offsets[3], object.energyLevel);
  writer.writeStringList(offsets[4], object.gratitudeList);
  writer.writeBool(offsets[5], object.isComplete);
  writer.writeString(offsets[6], object.lessonLearned);
  writer.writeString(offsets[7], object.mentalActivity);
  writer.writeString(offsets[8], object.mentalActivityType);
  writer.writeLong(offsets[9], object.mentalRating);
  writer.writeStringList(offsets[10], object.physicalActivities);
  writer.writeBool(offsets[11], object.prayersCompleted);
  writer.writeStringList(offsets[12], object.spiritualActivities);
  writer.writeString(offsets[13], object.strengthDemonstrated);
  writer.writeString(offsets[14], object.tomorrowIntention);
  writer.writeDateTime(offsets[15], object.updatedAt);
}

JournalEntry _journalEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = JournalEntry();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.dailyRating = reader.readLong(offsets[1]);
  object.date = reader.readDateTime(offsets[2]);
  object.energyLevel = reader.readLong(offsets[3]);
  object.gratitudeList = reader.readStringList(offsets[4]) ?? [];
  object.id = id;
  object.lessonLearned = reader.readStringOrNull(offsets[6]);
  object.mentalActivity = reader.readStringOrNull(offsets[7]);
  object.mentalActivityType = reader.readStringOrNull(offsets[8]);
  object.mentalRating = reader.readLong(offsets[9]);
  object.physicalActivities = reader.readStringList(offsets[10]) ?? [];
  object.prayersCompleted = reader.readBool(offsets[11]);
  object.spiritualActivities = reader.readStringList(offsets[12]) ?? [];
  object.strengthDemonstrated = reader.readStringOrNull(offsets[13]);
  object.tomorrowIntention = reader.readStringOrNull(offsets[14]);
  object.updatedAt = reader.readDateTime(offsets[15]);
  return object;
}

P _journalEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readStringList(offset) ?? []) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readStringList(offset) ?? []) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _journalEntryGetId(JournalEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _journalEntryGetLinks(JournalEntry object) {
  return [];
}

void _journalEntryAttach(
    IsarCollection<dynamic> col, Id id, JournalEntry object) {
  object.id = id;
}

extension JournalEntryQueryWhereSort
    on QueryBuilder<JournalEntry, JournalEntry, QWhere> {
  QueryBuilder<JournalEntry, JournalEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension JournalEntryQueryWhere
    on QueryBuilder<JournalEntry, JournalEntry, QWhereClause> {
  QueryBuilder<JournalEntry, JournalEntry, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterWhereClause> dateNotEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension JournalEntryQueryFilter
    on QueryBuilder<JournalEntry, JournalEntry, QFilterCondition> {
  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      dailyRatingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyRating',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      dailyRatingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailyRating',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      dailyRatingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailyRating',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      dailyRatingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailyRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      energyLevelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'energyLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      energyLevelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'energyLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      energyLevelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'energyLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      energyLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'energyLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gratitudeList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gratitudeList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gratitudeList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gratitudeList',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gratitudeList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gratitudeList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gratitudeList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gratitudeList',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gratitudeList',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gratitudeList',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gratitudeList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gratitudeList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gratitudeList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gratitudeList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gratitudeList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      gratitudeListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gratitudeList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      isCompleteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isComplete',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lessonLearned',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lessonLearned',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lessonLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lessonLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lessonLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lessonLearned',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lessonLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lessonLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lessonLearned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lessonLearned',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lessonLearned',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      lessonLearnedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lessonLearned',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mentalActivity',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mentalActivity',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentalActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mentalActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mentalActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mentalActivity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mentalActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mentalActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mentalActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mentalActivity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentalActivity',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentalActivity',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mentalActivityType',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mentalActivityType',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentalActivityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mentalActivityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mentalActivityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mentalActivityType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mentalActivityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mentalActivityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mentalActivityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mentalActivityType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentalActivityType',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalActivityTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentalActivityType',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalRatingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentalRating',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalRatingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mentalRating',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalRatingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mentalRating',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      mentalRatingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mentalRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'physicalActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'physicalActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'physicalActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'physicalActivities',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'physicalActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'physicalActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'physicalActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'physicalActivities',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'physicalActivities',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'physicalActivities',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'physicalActivities',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'physicalActivities',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'physicalActivities',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'physicalActivities',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'physicalActivities',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      physicalActivitiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'physicalActivities',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      prayersCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prayersCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spiritualActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spiritualActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spiritualActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spiritualActivities',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'spiritualActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'spiritualActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'spiritualActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'spiritualActivities',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spiritualActivities',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'spiritualActivities',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'spiritualActivities',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'spiritualActivities',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'spiritualActivities',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'spiritualActivities',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'spiritualActivities',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      spiritualActivitiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'spiritualActivities',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'strengthDemonstrated',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'strengthDemonstrated',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strengthDemonstrated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'strengthDemonstrated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'strengthDemonstrated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'strengthDemonstrated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'strengthDemonstrated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'strengthDemonstrated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'strengthDemonstrated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'strengthDemonstrated',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strengthDemonstrated',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      strengthDemonstratedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'strengthDemonstrated',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tomorrowIntention',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tomorrowIntention',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tomorrowIntention',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tomorrowIntention',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tomorrowIntention',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tomorrowIntention',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tomorrowIntention',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tomorrowIntention',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tomorrowIntention',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tomorrowIntention',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tomorrowIntention',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      tomorrowIntentionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tomorrowIntention',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension JournalEntryQueryObject
    on QueryBuilder<JournalEntry, JournalEntry, QFilterCondition> {}

extension JournalEntryQueryLinks
    on QueryBuilder<JournalEntry, JournalEntry, QFilterCondition> {}

extension JournalEntryQuerySortBy
    on QueryBuilder<JournalEntry, JournalEntry, QSortBy> {
  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByDailyRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyRating', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByDailyRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyRating', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByEnergyLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByEnergyLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByIsComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByIsCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByLessonLearned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonLearned', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByLessonLearnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonLearned', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByMentalActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalActivity', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByMentalActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalActivity', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByMentalActivityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalActivityType', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByMentalActivityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalActivityType', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByMentalRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalRating', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByMentalRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalRating', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByPrayersCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prayersCompleted', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByPrayersCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prayersCompleted', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByStrengthDemonstrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthDemonstrated', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByStrengthDemonstratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthDemonstrated', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByTomorrowIntention() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tomorrowIntention', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      sortByTomorrowIntentionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tomorrowIntention', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension JournalEntryQuerySortThenBy
    on QueryBuilder<JournalEntry, JournalEntry, QSortThenBy> {
  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByDailyRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyRating', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByDailyRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyRating', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByEnergyLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByEnergyLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByIsComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByIsCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplete', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByLessonLearned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonLearned', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByLessonLearnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lessonLearned', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByMentalActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalActivity', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByMentalActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalActivity', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByMentalActivityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalActivityType', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByMentalActivityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalActivityType', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByMentalRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalRating', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByMentalRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentalRating', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByPrayersCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prayersCompleted', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByPrayersCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prayersCompleted', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByStrengthDemonstrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthDemonstrated', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByStrengthDemonstratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strengthDemonstrated', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByTomorrowIntention() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tomorrowIntention', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy>
      thenByTomorrowIntentionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tomorrowIntention', Sort.desc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension JournalEntryQueryWhereDistinct
    on QueryBuilder<JournalEntry, JournalEntry, QDistinct> {
  QueryBuilder<JournalEntry, JournalEntry, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct> distinctByDailyRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyRating');
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct> distinctByEnergyLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'energyLevel');
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct>
      distinctByGratitudeList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gratitudeList');
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct> distinctByIsComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isComplete');
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct> distinctByLessonLearned(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lessonLearned',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct> distinctByMentalActivity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentalActivity',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct>
      distinctByMentalActivityType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentalActivityType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct> distinctByMentalRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentalRating');
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct>
      distinctByPhysicalActivities() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'physicalActivities');
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct>
      distinctByPrayersCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prayersCompleted');
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct>
      distinctBySpiritualActivities() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spiritualActivities');
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct>
      distinctByStrengthDemonstrated({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strengthDemonstrated',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct>
      distinctByTomorrowIntention({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tomorrowIntention',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JournalEntry, JournalEntry, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension JournalEntryQueryProperty
    on QueryBuilder<JournalEntry, JournalEntry, QQueryProperty> {
  QueryBuilder<JournalEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<JournalEntry, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<JournalEntry, int, QQueryOperations> dailyRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyRating');
    });
  }

  QueryBuilder<JournalEntry, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<JournalEntry, int, QQueryOperations> energyLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'energyLevel');
    });
  }

  QueryBuilder<JournalEntry, List<String>, QQueryOperations>
      gratitudeListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gratitudeList');
    });
  }

  QueryBuilder<JournalEntry, bool, QQueryOperations> isCompleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isComplete');
    });
  }

  QueryBuilder<JournalEntry, String?, QQueryOperations>
      lessonLearnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lessonLearned');
    });
  }

  QueryBuilder<JournalEntry, String?, QQueryOperations>
      mentalActivityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentalActivity');
    });
  }

  QueryBuilder<JournalEntry, String?, QQueryOperations>
      mentalActivityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentalActivityType');
    });
  }

  QueryBuilder<JournalEntry, int, QQueryOperations> mentalRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentalRating');
    });
  }

  QueryBuilder<JournalEntry, List<String>, QQueryOperations>
      physicalActivitiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'physicalActivities');
    });
  }

  QueryBuilder<JournalEntry, bool, QQueryOperations>
      prayersCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prayersCompleted');
    });
  }

  QueryBuilder<JournalEntry, List<String>, QQueryOperations>
      spiritualActivitiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spiritualActivities');
    });
  }

  QueryBuilder<JournalEntry, String?, QQueryOperations>
      strengthDemonstratedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strengthDemonstrated');
    });
  }

  QueryBuilder<JournalEntry, String?, QQueryOperations>
      tomorrowIntentionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tomorrowIntention');
    });
  }

  QueryBuilder<JournalEntry, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPrayerLogCollection on Isar {
  IsarCollection<PrayerLog> get prayerLogs => this.collection();
}

const PrayerLogSchema = CollectionSchema(
  name: r'PrayerLog',
  id: 4935317163683802781,
  properties: {
    r'completed': PropertySchema(
      id: 0,
      name: r'completed',
      type: IsarType.bool,
    ),
    r'completedAt': PropertySchema(
      id: 1,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'date': PropertySchema(
      id: 2,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'onTime': PropertySchema(
      id: 3,
      name: r'onTime',
      type: IsarType.bool,
    ),
    r'prayerType': PropertySchema(
      id: 4,
      name: r'prayerType',
      type: IsarType.string,
      enumMap: _PrayerLogprayerTypeEnumValueMap,
    ),
    r'scheduledTime': PropertySchema(
      id: 5,
      name: r'scheduledTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _prayerLogEstimateSize,
  serialize: _prayerLogSerialize,
  deserialize: _prayerLogDeserialize,
  deserializeProp: _prayerLogDeserializeProp,
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
  getId: _prayerLogGetId,
  getLinks: _prayerLogGetLinks,
  attach: _prayerLogAttach,
  version: '3.1.0+1',
);

int _prayerLogEstimateSize(
  PrayerLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.prayerType.name.length * 3;
  return bytesCount;
}

void _prayerLogSerialize(
  PrayerLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.completed);
  writer.writeDateTime(offsets[1], object.completedAt);
  writer.writeDateTime(offsets[2], object.date);
  writer.writeBool(offsets[3], object.onTime);
  writer.writeString(offsets[4], object.prayerType.name);
  writer.writeDateTime(offsets[5], object.scheduledTime);
}

PrayerLog _prayerLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PrayerLog();
  object.completedAt = reader.readDateTimeOrNull(offsets[1]);
  object.date = reader.readDateTime(offsets[2]);
  object.id = id;
  object.prayerType =
      _PrayerLogprayerTypeValueEnumMap[reader.readStringOrNull(offsets[4])] ??
          PrayerType.fajr;
  object.scheduledTime = reader.readDateTime(offsets[5]);
  return object;
}

P _prayerLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (_PrayerLogprayerTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          PrayerType.fajr) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PrayerLogprayerTypeEnumValueMap = {
  r'fajr': r'fajr',
  r'dhuhr': r'dhuhr',
  r'asr': r'asr',
  r'maghrib': r'maghrib',
  r'isha': r'isha',
};
const _PrayerLogprayerTypeValueEnumMap = {
  r'fajr': PrayerType.fajr,
  r'dhuhr': PrayerType.dhuhr,
  r'asr': PrayerType.asr,
  r'maghrib': PrayerType.maghrib,
  r'isha': PrayerType.isha,
};

Id _prayerLogGetId(PrayerLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _prayerLogGetLinks(PrayerLog object) {
  return [];
}

void _prayerLogAttach(IsarCollection<dynamic> col, Id id, PrayerLog object) {
  object.id = id;
}

extension PrayerLogQueryWhereSort
    on QueryBuilder<PrayerLog, PrayerLog, QWhere> {
  QueryBuilder<PrayerLog, PrayerLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension PrayerLogQueryWhere
    on QueryBuilder<PrayerLog, PrayerLog, QWhereClause> {
  QueryBuilder<PrayerLog, PrayerLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterWhereClause> idBetween(
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterWhereClause> dateNotEqualTo(
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterWhereClause> dateGreaterThan(
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterWhereClause> dateLessThan(
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterWhereClause> dateBetween(
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

extension PrayerLogQueryFilter
    on QueryBuilder<PrayerLog, PrayerLog, QFilterCondition> {
  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> completedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completed',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      completedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      completedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> completedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> completedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> completedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> onTimeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> prayerTypeEqualTo(
    PrayerType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prayerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      prayerTypeGreaterThan(
    PrayerType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prayerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> prayerTypeLessThan(
    PrayerType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prayerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> prayerTypeBetween(
    PrayerType lower,
    PrayerType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prayerType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      prayerTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'prayerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> prayerTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'prayerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> prayerTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'prayerType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition> prayerTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'prayerType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      prayerTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prayerType',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      prayerTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'prayerType',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      scheduledTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduledTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      scheduledTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduledTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      scheduledTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduledTime',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterFilterCondition>
      scheduledTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduledTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PrayerLogQueryObject
    on QueryBuilder<PrayerLog, PrayerLog, QFilterCondition> {}

extension PrayerLogQueryLinks
    on QueryBuilder<PrayerLog, PrayerLog, QFilterCondition> {}

extension PrayerLogQuerySortBy on QueryBuilder<PrayerLog, PrayerLog, QSortBy> {
  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByOnTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onTime', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByOnTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onTime', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByPrayerType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prayerType', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByPrayerTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prayerType', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> sortByScheduledTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.desc);
    });
  }
}

extension PrayerLogQuerySortThenBy
    on QueryBuilder<PrayerLog, PrayerLog, QSortThenBy> {
  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByOnTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onTime', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByOnTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onTime', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByPrayerType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prayerType', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByPrayerTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prayerType', Sort.desc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.asc);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QAfterSortBy> thenByScheduledTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledTime', Sort.desc);
    });
  }
}

extension PrayerLogQueryWhereDistinct
    on QueryBuilder<PrayerLog, PrayerLog, QDistinct> {
  QueryBuilder<PrayerLog, PrayerLog, QDistinct> distinctByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completed');
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QDistinct> distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QDistinct> distinctByOnTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onTime');
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QDistinct> distinctByPrayerType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prayerType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrayerLog, PrayerLog, QDistinct> distinctByScheduledTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledTime');
    });
  }
}

extension PrayerLogQueryProperty
    on QueryBuilder<PrayerLog, PrayerLog, QQueryProperty> {
  QueryBuilder<PrayerLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PrayerLog, bool, QQueryOperations> completedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completed');
    });
  }

  QueryBuilder<PrayerLog, DateTime?, QQueryOperations> completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<PrayerLog, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<PrayerLog, bool, QQueryOperations> onTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onTime');
    });
  }

  QueryBuilder<PrayerLog, PrayerType, QQueryOperations> prayerTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prayerType');
    });
  }

  QueryBuilder<PrayerLog, DateTime, QQueryOperations> scheduledTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledTime');
    });
  }
}

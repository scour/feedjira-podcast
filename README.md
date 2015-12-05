# Feedjira::Podcast

[![Gem Version](http://img.shields.io/gem/v/feedjira-podcast.svg)](https://rubygems.org/gems/feedjira-podcast)
[![Dependency Status](https://gemnasium.com/scour/feedjira-podcast.svg)](https://gemnasium.com/scour/feedjira-podcast)
[![Build Status](https://travis-ci.org/scour/feedjira-podcast.svg)](https://travis-ci.org/scour/feedjira-podcast)
[![Code Climate](https://codeclimate.com/github/scour/feedjira-podcast/badges/gpa.svg)](https://codeclimate.com/github/scour/feedjira-podcast)
[![Coverage Status](https://coveralls.io/repos/scour/feedjira-podcast/badge.svg?branch=master)](https://coveralls.io/r/scour/feedjira-podcast?branch=master)

This is a highly opinionated RSS parser designed for working with podcast feeds. It is built on top of [Feedjira](http://feedjira.com/), but is not compatible with the parsers that ship with Feedjira and are normalized across a variety of feed formats. Feedjira::Podcast provides a number of features beyond basic feed parsing, including analysis of podcast feed best practices.

## Usage

The Feedjira::Podcast gem tries to strike a balance between standard Ruby idioms, the RSS and podcast specs, and needing to deal with real-world feeds that may not behave as expected. For the most part, interacting with a parsed podcast feed should be straight forward.

This gem registers the podcast parser class with Feedjira, so `Feedjira::Feed.parse` and the other standard fetch/parse methods are generally the easiest ways to ingest feeds. For more information, see Feedjira's documentation.

### Common Behaviors

#### Grouping

In nearly all cases, items, properties, etc can be accessed in a predictable way, according to familiar Ruby patterns. Any logical groupings (namespaces, multiple attributes on a single element, etc) that exist within the feeds are abstracted by the parser.

The parser creates nested `Struct` objects whenever necessary, allowing application code to read attributes at any depth without having to check for the existence of objects at each level.

**Examples**

```ruby
@feed.itunes.image.href
@feed.feedburner.info.uri
@item.enclosure.type
```

*(One exception to this is the `<atom:link rel="self">` element. Standard access would be `atom.link.self.href`, for example. In order to avoid using `self`, this can be accessed through `atom.link[:self].href`. This may be unnecessary, but it's an option if you would like to use it.)*

Regardless of the inclusion of those specific attributes, or even their parent elements, you can safely access those properties without needing `&&` or `.try`. This is true for all values that are exposed by the parser.

#### Naming

Most names either match their counterpart in the feed exactly (e.g. `description`, `author`), convert camel case to snake case (e.g. `pubDate` becomes `pub_date`), or transpose boolean attributes to question-mark-notation (e.g. `isPermaLink` becomes `perma_link?`, and `itunes:block` becomes `itunes.block?`).

In cases where an element can repeat in a given context, the accessor will be pluralized (e.g. `<category>` becomes `categories`) and the value is an array, even if only a single element exists in a given feed.

#### Typecasting

In nearly all cases the value types of podcast feed data is predictable. As such, the parser will cast values appropriately. In cases where a feed is malformed, the result of the type cast may be somewhat unpredictable, but no more so than the original data was. A bad value should never prevent parsing of the rest of the document, but it could bust a specific value (e.g. a date that is human-readable but not parseable will end up as `nil` rather than fallback to an ambiguous `String` value).

Date values are parsed as `Time` objects, number values become `Float` objects, hrefs, URIs and URLs are parsed using [Addressable](https://github.com/sporkmonger/addressable), and boolean values will return `true` or `false`.

In the case of the `<itunes:explicit>` tag, there are three mutually exclusive options, `"yes"`, `"clean"`, and any other value (representing `"no"`). This element gets expanded to two properties through parsing, `explicit?` and `clean?`, allowing both to be simple boolean values.

The spec for the item `<guid>` indicates that the default value if no value is given for the `isPermaLink` attribute is `true`. It also states that when `isPermaLink` is true, the value of `<guid>` represents a URI (and that the client can choose to treat it that way or not). As such, whenever a `<guid>` is acting as a `permaLink`, whether implicitly or explicitly, the `guid` value will return an `Addressable::URI`. Only if `isPermaLink` has a value of `"false"` with `guid` return a string.

#### Validation

The parser will try its best to parse whatever data it has available, with a strong preference for data that meets the specs commonly used for podcast feeds. The library will provide additional information that you can use to decide how to handle the data produced by the parser, but the parser itself will never refuse a document based on deficiencies or invalid data.

Besides standard typecasting, the parser won't try to clean up any data. For example, many elements (such as `<description>`) explicitly allow only plaintext, but it is common for them to include markup in the wild. The parser will assume that markup to be plaintext, according to the spec. If you want to sanitize those parts of feeds, you should handle that on your end.

#### Parsing

During parsing, some aspects of the original feed will not be maintained in such a way that a functionally identical feed could be generated from the result. For example. `CDATA` declarations in XML elements are lost, as the parser converts them (correctly) to strings. If the resulting data is being used to generate feeds, wrapping values in CDATA would be the responsibility of the whatever is constructing the feed, based on the values of the strings. Similarly, Apple expects iTunes category tag values to include encoded ampersands, eg `TV &amp; Film`. Parsing the feed will decode those values (to `TV & Film`), so they would have to be re-encoded before being used somewhere that iTunes would be reading from.

### More Information

For more detailed information about specific aspects of feeds, how they are spec'd, and how they are handled by the parser, see the [wiki](https://github.com/scour/feedjira-podcast/wiki).

## In Progress

Coverage of RSS, iTunes, and the other common constituents of podcast feeds is very high, but there are some bits that need to be addressed. More esoteric elements, such a host-specific tags, or various parts of Dublin Core, are added based on their prevalence in real world feeds.

Experimental feed elements may be added over time, but they should be used with caution until they reach a critical mass or become standardized.

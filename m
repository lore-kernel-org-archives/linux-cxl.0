Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439B8C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Nov 2022 21:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKIVae (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIVae (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Nov 2022 16:30:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DF07659
        for <linux-cxl@vger.kernel.org>; Wed,  9 Nov 2022 13:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668029433; x=1699565433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qeNQDZl0q0BMW+6KELrOp0rWK5Vp94dexQZBnQFauW0=;
  b=Y/L1s5PnrUFMGjo8YMJ3gn9tsyR7pyPlSv+NmpVvy1cnUxfSv/qWao0B
   ioU8x20bYhsf8DvMgoX5PD7LY51NRgnUYFNYMd7svvBtpQn1A103kOn2m
   MloThxFaAJgi/G4x3RhM6/2GTzivWsIVOa8lqGn+ht5wmR8tnsUyAJ7D5
   zX75gNmvWw96XU5cpPNWiiIkkNOQ0jYtJxanfULkmCBsKrIe4k7p7wKCd
   SicN6j7Nl84lYqoYXVIOYfFA53dAzbp9WzKjqZi1d+LiE0dMJ0waOUkMc
   C7DqTJGS4VwTURQhFQzviAEyiN9a8CV2lXz17AjEvT+2jGdD21g8RsojS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309831631"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="309831631"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 13:30:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="670107700"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="670107700"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.115.29]) ([10.212.115.29])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 13:30:32 -0800
Message-ID: <ef5e1842-b7a2-d8a5-ef9d-b7568c9ceb37@intel.com>
Date:   Wed, 9 Nov 2022 14:30:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v4 02/10] cxl: add helper to parse through all current
 events
Content-Language: en-US
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
 <166793219956.3768752.10060411389279195687.stgit@djiang5-desk3.ch.intel.com>
 <6e0d8c9cfb2adb2c0039d1bbe42cc8a0dbc0a9ec.camel@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6e0d8c9cfb2adb2c0039d1bbe42cc8a0dbc0a9ec.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/8/2022 3:45 PM, Verma, Vishal L wrote:
> On Tue, 2022-11-08 at 11:29 -0700, Dave Jiang wrote:
>> Add common function to iterate through and extract the events in the
>> current trace buffer. The function uses tracefs_iterate_raw_events() from
>> libtracefs to go through all the events loaded into a tep_handle. A
>> callback is provided to the API call in order to parse the event. For cxl
>> monitor, an array of interested "systems" is provided in order to filter
> 
> I couldn't tell what a 'system' means here - maybe clarify that?

It's an trace event term. In this case, the system would be "cxl". I'll 
clarify. It's trace event's category.

> 
>> for the interested events.
> 
> s/interested events/events of interest/ ?
> 
>>
>> Tested-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   cxl/event_trace.c |   36 ++++++++++++++++++++++++++++++++++++
>>   cxl/event_trace.h |   10 ++++++++++
>>   cxl/meson.build   |    1 +
>>   meson.build       |    2 ++
>>   4 files changed, 49 insertions(+)
>>
>> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
>> index 1b1b037e48bf..4667044e4a66 100644
>> --- a/cxl/event_trace.c
>> +++ b/cxl/event_trace.c
>> @@ -16,6 +16,7 @@
>>   #include <libcxl.h>
>>   #include <uuid/uuid.h>
>>   #include <traceevent/event-parse.h>
>> +#include <tracefs/tracefs.h>
>>   #include "json.h"
>>   #include "event_trace.h"
>>   
>> @@ -199,3 +200,38 @@ err_jevent:
>>          free(jnode);
>>          return rc;
>>   }
>> +
>> +static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record,
>> +               int cpu, void *ctx)
> 
> What does the _cb mean? I couldn't tell from what it's parsing what it
> stands for - might be better to expand it?

callback. I can just drop that.

> 
>> +{
>> +       struct event_ctx *event_ctx = (struct event_ctx *)ctx;
>> +
>> +       /* Filter out all the events that the caller isn't interested in. */
>> +       if (strcmp(event->system, event_ctx->system) != 0)
>> +               return 0;
>> +
>> +       if (event_ctx->event_name) {
>> +               if (strcmp(event->name, event_ctx->event_name) != 0)
>> +                       return 0;
>> +       }
>> +
>> +       if (event_ctx->parse_event)
>> +               return event_ctx->parse_event(event, record, &event_ctx->jlist_head);
>> +
>> +       return cxl_event_to_json_callback(event, record, &event_ctx->jlist_head);
>> +}
>> +
>> +int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx)
>> +{
>> +       struct tep_handle *tep;
>> +       int rc;
>> +
>> +       tep = tracefs_local_events(NULL);
>> +       if (!tep)
>> +               return -ENOMEM;
>> +
>> +       rc = tracefs_iterate_raw_events(tep, inst, NULL, 0,
>> +                       cxl_event_parse_cb, ectx);
>> +       tep_free(tep);
>> +       return rc;
>> +}
>> diff --git a/cxl/event_trace.h b/cxl/event_trace.h
>> index 00975a0b5680..582882c1eb35 100644
>> --- a/cxl/event_trace.h
>> +++ b/cxl/event_trace.h
>> @@ -11,4 +11,14 @@ struct jlist_node {
>>          struct list_node list;
>>   };
>>   
>> +struct event_ctx {
>> +       const char *system;
>> +       struct list_head jlist_head;
>> +       const char *event_name;                                 /* optional */
>> +       int (*parse_event)(struct tep_event *event, struct tep_record *record,
>> +                          struct list_head *jlist_head);       /* optional */
>> +};
>> +
>> +int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
>> +
>>   #endif
>> diff --git a/cxl/meson.build b/cxl/meson.build
>> index 8c7733431613..c59876262e76 100644
>> --- a/cxl/meson.build
>> +++ b/cxl/meson.build
>> @@ -21,6 +21,7 @@ cxl_tool = executable('cxl',
>>       json,
>>       versiondep,
>>       traceevent,
>> +    tracefs,
>>     ],
>>     install : true,
>>     install_dir : rootbindir,
>> diff --git a/meson.build b/meson.build
>> index f611e0bdd7f3..c204c8ac52de 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -143,6 +143,8 @@ libudev = dependency('libudev')
>>   uuid = dependency('uuid')
>>   json = dependency('json-c')
>>   traceevent = dependency('libtraceevent')
>> +tracefs = dependency('libtracefs')
>> +
>>   if get_option('docs').enabled()
>>     if get_option('asciidoctor').enabled()
>>       asciidoc = find_program('asciidoctor', required : true)
>>
>>
> 

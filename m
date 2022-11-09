Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CDDC4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Nov 2022 23:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiKIXBv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiKIXBY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Nov 2022 18:01:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E603E31FBD
        for <linux-cxl@vger.kernel.org>; Wed,  9 Nov 2022 15:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668034858; x=1699570858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dvLozgdK2yC0JYQldz8QPvOo3Tr3cNqnlXeLIl7c5SY=;
  b=BGupLPmkl1pmGkvS/I44YSLAaW08yeYraBVi0TwqCREKbK1+WBLxnNGE
   hDHqxISa3IP7i6lzecyNKB0nLkn2FJhaIhjlHwnOj8dvLOJ8AMkdXUWrZ
   Vh25JZzOJitn/RLe5WMDO4B6WJPbsfW1yhoofL9u4i22OTNfdee/8Ib4+
   3baocInuSo3R+G6qlfkPc4xNicLqWpnB+zzA+5TLyMIhv6BW1dGDZCI63
   BwFPhSa480VA8AEa4IUgRAIIEQdqHweOIrDaBD5tVfkA4hY+Z6i53QJFe
   927hnIR+qF2vuvKIl5uRj2HHt5WeOy8LTIYdOhvbPJxRcjKInq0usrgjG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312269138"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312269138"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 14:44:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="587940244"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="587940244"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.115.29]) ([10.212.115.29])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 14:44:45 -0800
Message-ID: <1db1628e-247a-4d84-ae29-45e4d0d2654a@intel.com>
Date:   Wed, 9 Nov 2022 15:44:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v4 08/10] cxl: add an optional pid check to event parsing
Content-Language: en-US
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
 <166793223408.3768752.4466685754838805704.stgit@djiang5-desk3.ch.intel.com>
 <7668b03a0b6fd5b92128446654833f643ada90ce.camel@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <7668b03a0b6fd5b92128446654833f643ada90ce.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/8/2022 4:48 PM, Verma, Vishal L wrote:
> On Tue, 2022-11-08 at 11:30 -0700, Dave Jiang wrote:
>> From: Alison Schofield <alison.schofield@intel.com>
>>
>> When parsing CXL events, callers may only be interested in events
>> that originate from the current process. Introduce an optional
>> argument to the event trace context: event_pid. When event_pid is
>> present, only include events with a matching pid in the returned
>> JSON list. It is not a failure to see other, non matching results.
>> Simply skip those.
>>
>> The initial use case for this is the listing of media errors,
>> where only the media-errors requested by this process are wanted.
>>
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   cxl/event_trace.c |    5 +++++
>>   cxl/event_trace.h |    1 +
>>   2 files changed, 6 insertions(+)
> 
> I might be missing something - but this patch is added at then end,
> without subsequently using the event_pid in cxl-monitor? So why not
> leave this to be part of the media errors patches?

Alison, you want to move this to your series?

> 
>>
>> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
>> index 490c30e1dbfc..89c9c2db26a3 100644
>> --- a/cxl/event_trace.c
>> +++ b/cxl/event_trace.c
>> @@ -215,6 +215,11 @@ static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record
>>                          return 0;
>>          }
>>   
>> +       if (event_ctx->event_pid) {
>> +               if (event_ctx->event_pid != tep_data_pid(event->tep, record))
>> +                       return 0;
>> +       }
>> +
>>          if (event_ctx->parse_event)
>>                  return event_ctx->parse_event(event, record, &event_ctx->jlist_head);
>>   
>> diff --git a/cxl/event_trace.h b/cxl/event_trace.h
>> index 89e98cafb320..e72b4347175e 100644
>> --- a/cxl/event_trace.h
>> +++ b/cxl/event_trace.h
>> @@ -15,6 +15,7 @@ struct event_ctx {
>>          const char *system;
>>          struct list_head jlist_head;
>>          const char *event_name;                                 /* optional */
>> +       int event_pid;                                          /* optional */
>>          int (*parse_event)(struct tep_event *event, struct tep_record *record,
>>                             struct list_head *jlist_head);       /* optional */
>>   };
>>
>>
> 

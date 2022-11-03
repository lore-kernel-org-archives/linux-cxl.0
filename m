Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6289BC4321E
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 16:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiKCQav (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiKCQat (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 12:30:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C071BEB0
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667493032; x=1699029032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FCTP7Cd4re5CxUgAW7gUoEv7ewc3cXXYWgqL+6zOWP0=;
  b=EmHOjxSmQP5SXYgGRj4gxJqLFpyRrfCJ+xr4ky8MKNN8LpjDxeUq4WpX
   zJZGZY0glsixLzf9TNn6GAt1rWK4rvz+IlLLwVsXyp5+xfe1Yw/qUbQTL
   6lEw5l/SqqQgf9avmLvJkaHbzZrWiqlprHOPoD4Bt1bM5ZuoA3cjTgT0P
   +WIqafqOkasls2JZDXZG57br7ZaeEXuUP7OsYPz2Gp7vt+ZJMfv+GA0Ll
   elP0XeWq10lVZpL6Uq17qhz2hFn3qzDuCfzS5LgyCzHiGlqioIUeSQYFY
   ot+fWvvlRNOddN6o7FSoGYHr25MUA/Xk51ivQmVQ/DehOShSctMQSpQ/1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="307351018"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="307351018"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:30:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="740256435"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="740256435"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.56.14]) ([10.212.56.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:30:30 -0700
Message-ID: <98ad856c-1671-7ae8-652f-1ce9b2ed7c68@intel.com>
Date:   Thu, 3 Nov 2022 09:30:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 04/10] cxl: add common function to disable event trace
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
 <166742402697.2654617.15955710715103932892.stgit@djiang5-desk3.ch.intel.com>
 <20221103020234.63fd7ab2@rorschach.local.home>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221103020234.63fd7ab2@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/2/2022 11:02 PM, Steven Rostedt wrote:
> On Wed, 02 Nov 2022 14:20:26 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add a common function for cxl command that disables the event trace for the
>> instance created.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   cxl/event_trace.c |    8 ++++++++
>>   cxl/event_trace.h |    1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
>> index d59e54c33df6..bcd4f8b2968e 100644
>> --- a/cxl/event_trace.c
>> +++ b/cxl/event_trace.c
>> @@ -221,3 +221,11 @@ int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system)
>>   	tracefs_trace_on(inst);
>>   	return 0;
>>   }
>> +
>> +int cxl_event_tracing_disable(struct tracefs_instance *inst)
>> +{
>> +	if (!tracefs_trace_is_on(inst))
>> +		return 0;
> 
> Why bother checking if tracing is on or not. It's not any more
> efficient. You're not eliminating a system call. You are actually
> adding another one.

Ok, will remove.
> 
> -- Steve
> 
> 
>> +
>> +	return tracefs_trace_off(inst);
>> +}
>> diff --git a/cxl/event_trace.h b/cxl/event_trace.h
>> index 0258b8dc65a3..17d922f922c1 100644
>> --- a/cxl/event_trace.h
>> +++ b/cxl/event_trace.h
>> @@ -21,5 +21,6 @@ struct event_ctx {
>>   
>>   int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
>>   int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system);
>> +int cxl_event_tracing_disable(struct tracefs_instance *inst);
>>   
>>   #endif
>>
> 

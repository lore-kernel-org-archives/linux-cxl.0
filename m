Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBFEC43219
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 16:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKCQWE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiKCQWC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 12:22:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445731ADB3
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667492522; x=1699028522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LZ276zq3+c0DOeZUupbq4QkESeiWIYfu69H13blWtC4=;
  b=RV+YlbPqtAiRe5+FAyxAeH2utfyHsTSRs7bIfZoMXU+UAZtiJT7V8cgN
   1emtgzrZjdzZIWG83Ktj7iKyEZtm1jhomKfxHySy6Hp7qVE7nuzPvbmcG
   xXrQTROjT/FgctlGnq8ufBI0wvn/arnDs8sRPEb7M0dn+7AADr+EbkC7X
   Ouq+1Mz5QyT7Af5F/RbwLWLOP416L+iEsGNBsX/N6QYVmRpKKDXh0XEOH
   lJ1NCSNdG5ZFnFocMDCwADJmQI/ec5s1f7mdRTr4KJfYW9tM3b3pxb4LR
   00NVo5OrnxyX7XO4iCDenB542xsRjR9Xe2j/ttiRzgdOMgXhDEimWcv87
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="371834385"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="371834385"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:21:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="879944572"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="879944572"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.56.14]) ([10.212.56.14])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:21:53 -0700
Message-ID: <f84551dc-73e6-c1b2-eba7-2718e0472318@intel.com>
Date:   Thu, 3 Nov 2022 09:21:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 03/10] cxl: add common function to enable event trace
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
 <166742402130.2654617.9308255604215496136.stgit@djiang5-desk3.ch.intel.com>
 <20221103020032.47cb3da7@rorschach.local.home>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221103020032.47cb3da7@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/2/2022 11:00 PM, Steven Rostedt wrote:
> On Wed, 02 Nov 2022 14:20:21 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add a common function for cxl command to enable event tracing for the
>> instance created. The interested "systems" will be enabled for tracing
>> as well.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   cxl/event_trace.c |   21 +++++++++++++++++++++
>>   cxl/event_trace.h |    1 +
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
>> index cf63d2346f6e..d59e54c33df6 100644
>> --- a/cxl/event_trace.c
>> +++ b/cxl/event_trace.c
>> @@ -200,3 +200,24 @@ int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx)
>>   	tep_free(tep);
>>   	return rc;
>>   }
>> +
>> +int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system)
>> +{
>> +	int rc;
>> +	char *path;
>> +
>> +	rc = asprintf(&path, "events/%s/enable", system);
>> +	if (rc == -1)
>> +		return -errno;
>> +
>> +	rc = tracefs_instance_file_write(inst, path, "1");
>> +	free(path);
>> +	if (rc == -1)
>> +		return -errno;
> 
> Latest libtracefs has:
> 
> 	tracefs_event_enable(inst, system, NULL);
> 
> That enables all events for a system in the instance "inst".

Great. Thanks! I will switch to that.

> 
> -- Steve
> 
> 
>> +
>> +	if (tracefs_trace_is_on(inst))
>> +		return 0;
>> +
>> +	tracefs_trace_on(inst);
>> +	return 0;
>> +}
>> diff --git a/cxl/event_trace.h b/cxl/event_trace.h
>> index 582882c1eb35..0258b8dc65a3 100644
>> --- a/cxl/event_trace.h
>> +++ b/cxl/event_trace.h
>> @@ -20,5 +20,6 @@ struct event_ctx {
>>   };
>>   
>>   int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
>> +int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system);
>>   
>>   #endif
>>
> 

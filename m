Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F31C32793
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 15:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjARPWx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 10:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjARPWe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 10:22:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F0443914
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 07:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674055166; x=1705591166;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2emRiNaFO30eUqDcwsuMhfUqteJw1RfgABgnE0SZMCU=;
  b=gsocPY0yNE3K7+Iw09RwYi8uVpvfZjNAENtrBA4c+wHwreL/igK/NOlc
   Khfa/A0fLvgz3mliXcorM2PEDJBresBv4EIyJXhPs7/T6XcMF2SMwTdP6
   SlBDoN97G3W+oy8NtTOxBOUf/KXC0i4+8bk3lMjQnOwJ7/NtYhnhwe37B
   8ZkzJKGOg53p+mFtaX9+BuBJPN6+4sR+qHtbq2ukzsp6/yF/TapYx8Vjf
   1cH605iDxlo0OFED4dnbgfpT+t7E0yJCAnoSnqbTFeGbkVNMvQTDL5npJ
   Ac7CgR7S4oYl+y6jqn3q737jsMc500dM20h0/fugu4UdzlZsVjrRQGKq+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="323690770"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323690770"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:19:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="783711937"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="783711937"
Received: from scolem2-mobl1.amr.corp.intel.com (HELO [10.213.179.103]) ([10.213.179.103])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:19:25 -0800
Message-ID: <55f58b00-6845-a763-5f26-ec5eabcf1e11@intel.com>
Date:   Wed, 18 Jan 2023 08:19:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 2/2] cxl: Add tprintk support for header log hex dump
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        linuxarm@huawei.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <20230113154058.16227-1-Jonathan.Cameron@huawei.com>
 <20230113154058.16227-3-Jonathan.Cameron@huawei.com>
 <0907017b-a620-0089-8d10-b3dc92e145ed@intel.com>
 <20230118094309.0000008c@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230118094309.0000008c@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/18/23 2:43 AM, Jonathan Cameron wrote:
> On Tue, 17 Jan 2023 11:08:26 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 1/13/23 8:40 AM, Jonathan Cameron wrote:
>>> May not make sense in general, but very helpful when writing multiple
>>> header logging support.
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> The user logging software would be retrieving from the log data directly
>> instead of parsing the trace output right? Will people visually inspect
>> the formatted trace output? Useful for debugging?
> 
> Rather depends on the use case and rate of expected errors + if you are
> trying to debug errors before your logging infrastructure is up.
> 
> Sure in production, likely these tracepoints would just get stored to a DB for later
> querying.  But in debug, I often just use the kernel parameter
> to directly dump them in the main kernel log, or perf's own decoding of a trace.
> 
> The nearest equivalent to this is AER which does print the log.
> https://elixir.bootlin.com/linux/v6.2-rc4/source/include/ras/ras_event.h#L337
> 
> though that uses __print_array so maybe that's a better choice.
> Don't get the nice offsets though if we do that though...
> 
> I'm not fussed about this patch going upstream or not, it just makes testing
> patch 1 a lot easier :)

Thanks for the explanation.
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> Jonathan
> 
> 
>>
>>> ---
>>>    drivers/cxl/core/trace.h | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>>> index 20ca2fe2ca8e..64f6ad13529d 100644
>>> --- a/drivers/cxl/core/trace.h
>>> +++ b/drivers/cxl/core/trace.h
>>> @@ -62,10 +62,13 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>>    		 */
>>>    		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>>>    	),
>>> -	TP_printk("%s: status: '%s' first_error: '%s'",
>>> +	TP_printk("%s: status: '%s' first_error: '%s' header_log: %s",
>>>    		  __get_str(dev_name),
>>>    		  show_uc_errs(__entry->status),
>>> -		  show_uc_errs(__entry->first_error)
>>> +		  show_uc_errs(__entry->first_error),
>>> +		__print_hex_dump("", DUMP_PREFIX_OFFSET, 32, 4,
>>> +				(char *)__entry->header_log,
>>> +				CXL_HEADERLOG_SIZE_U32, false)
>>>    	)
>>>    );
>>>      
> 

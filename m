Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C1C54E76
	for <linux-cxl@archiver.kernel.org>; Tue, 17 Jan 2023 21:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjAQV4n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjAQVvg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 17 Jan 2023 16:51:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC27259E6C
        for <linux-cxl@vger.kernel.org>; Tue, 17 Jan 2023 12:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673986365; x=1705522365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=llwPfRvDzwvVSIYByuLETYanEwRv4qOSx1MdF5akCX4=;
  b=bfufTTbFGJMFSM9sCWcSjeJt7HmxWp13pg5tTx920R1ANFnVR1OU8OsZ
   4QJ9Uw2YpqlmuFGwX4LPhf9C5uMRPAsU2pys/AcuEOBLkR7Wt8hD0dz6h
   jQ0M5eHbqJv+m1XO9krXiuNEmoaT2HpXq+jQBIAr1HAhyGcJu14tjKxh5
   xwfLCGlgfQPssM2M+q70yzpKxz2d9XVnAMmYKX54BZd8nngQ0TFod+m5Z
   r0pdEggNfNrc896F4WlCrvoTb4UcSBqgE7HM+RvYMBjuRKNlTaGhZ6Eq8
   DsqHiZVoIq+Wo2sVo2X3yq0WkSx0csl0Py6H/vsPjwQanqeLVBnH5AuPy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="326879482"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326879482"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 12:12:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="748161570"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="748161570"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.41.87]) ([10.212.41.87])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 12:12:35 -0800
Message-ID: <ad5e7143-7236-6508-4881-899884d3b5f1@intel.com>
Date:   Tue, 17 Jan 2023 13:12:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/8] cxl: break out range register decoding from
 cxl_hdm_decode_init()
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
 <167330058797.975161.6614835520451455277.stgit@djiang5-mobl3.local>
 <20230113133634.000057ee@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230113133634.000057ee@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/13/23 6:36 AM, Jonathan Cameron wrote:
> On Mon, 09 Jan 2023 14:43:09 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> There are 2 scenarios that requires additional handling. 1. A device that
>> has active ranges in DVSEC range registers (RR) but no HDM decoder register
>> block. 2. A device that has both RR active and HDM, but the HDM decoders
>> are not programmed. The goal is to create emulated decoder software structs
>> based on the RR.
>>
>> Move the CXL DVSEC range register decoding code block from
>> cxl_hdm_decode_init() to its own function. Refactor code in preparation for
>> the HDM decoder emulation.  There is no functionality change to the code.
>> Name the new function to cxl_dvsec_rr_decode().
>>
>> The only change is to set range->start and range->end to CXL_RESOURCE_NONE
>> and skipping the reading of base registers if the range size is 0, which
>> equates to range not active.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>>
>> v2:
>> - Refactor to return when size is 0. (Jonathan)
> I think you continue rather than return when size is 0 unless I'm looking in the
> wrong place.

Yes. I think I was looking at the wrong place.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>   drivers/cxl/core/pci.c |   63 ++++++++++++++++++++++++++++++------------------
>>   1 file changed, 40 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 57764e9cd19d..a8ecc6ddb3d7 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -141,11 +141,10 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
>>   

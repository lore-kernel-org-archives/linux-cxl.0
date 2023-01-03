Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A492C3DA7D
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 23:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjACXUJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 18:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjACXUI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 18:20:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B415FD8
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 15:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672788006; x=1704324006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ohn4LLPLYdLBLwOS2VBfWYV0l1RBWdKYHwao5ZzOTcI=;
  b=VcgCGnVXMc4q138RzmQ7eqEE42awBCoeK3GMdzEjOEki+wAF7FO6l01W
   I6g5kuMPKfjC+DjnUNj6kL/sDwFxYdKJ0cBue14qM8/sHt8JWmlEmNpFB
   gn3gwqf11SsmQksh6ei3mIc9+QV8hPX+3mIL5FvgAZkzJTgYnlwvaalzx
   0gMtJMIaCUO3QQXnn3Sw7wcgrKk35J5VwhtQShWTjGZz2JyyWftN1AkqF
   3y/8ZNLNP8mQ+fKrtLQE6OfNBNGegKF1FMSWP/0PMQU6ad3L7J2UGcEL9
   BrqFzhzCOawbG48SYbRsArdOjP4IYlBMbAudKmok9GulIJtKqhOD65HwK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="319489783"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="319489783"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 15:20:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="648377997"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="648377997"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.96.127]) ([10.212.96.127])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 15:20:05 -0800
Message-ID: <81b02689-93dc-3b11-a1c1-fd7d55552d32@intel.com>
Date:   Tue, 3 Jan 2023 16:20:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 4/8] cxl: emulate HDM decoder from DVSEC range
 registers
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rrichter@amd.com, terry.bowman@amd.com
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
 <166984995817.2805382.13166060288973761642.stgit@djiang5-desk3.ch.intel.com>
 <20221219164231.000002c0@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221219164231.000002c0@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/19/22 9:42 AM, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 16:12:38 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> In the case where HDM decoder register block exists but is not programmed
>> and at the same time the DVSEC range register range is active, populate the
>> CXL decoder object 'cxl_decoder' with info from DVSEC range registers.
> 
> I may be overthinking this...
> 
> So I think this results in us enabling hdm decoder registers on
> a device that the BIOS already set the range registers for?

The code don't actually program and enable an unprogrammed HDM decoder. 
It creates a locked HDM decoder structure that's filled with info from 
DVSEC. The interested info will show up in sysfs but there should not be 
any changes WRT existing HDM decoder. The DVSEC range register 
exclusively controls this memory range.

> 
> I'm not sure the spec guarantees that is a safe operation if accesses are
> in flight.
> You can imagine a device which goes through an unsafe intermediate state
> when switching over from range registers to HDM decoders.  That wouldn't
> normally be a problem as we'd not expect traffic in flight, but if the
> BIOS already set up a mapping the OS might see that as normal memory which
> it is using when this transition occurs.
> 
> If just feels like a transition no one will test that might bite us in
> future in really hard to detect ways.
> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/hdm.c |   33 ++++++++++++++++++++++++++++++---
>>   drivers/cxl/core/pci.c |   12 ------------
>>   drivers/cxl/cxl.h      |    3 ++-
>>   drivers/cxl/port.c     |    2 +-
>>   4 files changed, 33 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index d1d2caea5c62..9773a5efaefd 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -674,9 +674,31 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>>   	return 0;
>>   }
>>   
>> +static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>> +					    struct cxl_decoder *cxld, int which,
>> +					    struct cxl_endpoint_dvsec_info *info)
>> +{
>> +	if (!is_cxl_endpoint(port))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (info->dvsec_range[which].start == CXL_RESOURCE_NONE)
>> +		return -ENXIO;
>> +
>> +	cxld->target_type = CXL_DECODER_ACCELERATOR;
> 
> Why chose type 2 target type?  Definitely needs a comment.

There are only 2 defines for decoder type. I picked the one that is not 
EXPANDER.

> Also would be good to have a precursor patch that moves these
> over to the CXL 3.0 naming to incorportate the fun difference
> between HDM-DB and HDM-H type 3 devices
> 
> CXL_DEVICE_COHERENT_ADDRESS_RANGE
> CXL_HOST_ONLY_COHERENT_ADDRESS_RANGE

I'll take a look at the spec.
> 
> 
> 
>> +
>> +	cxld->hpa_range = (struct range) {
>> +		.start = info->dvsec_range[which].start,
>> +		.end = info->dvsec_range[which].end,
>> +	};
>> +
>> +	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
>> +	port->commit_end = cxld->id;
> 
> blank line before all simple returns like this makes the code
> slightly more readable.

ok
> 
>> +	return 0;
>> +}
>> +
> 
> ...
> 
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 385dbe9bd5f2..5e44fe23fa76 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -412,18 +412,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>   		info->mem_enabled = 0;
>>   	}
>>   
>> -	/*
>> -	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
>> -	 * [High,Low] when HDM operation is enabled the range register values
>> -	 * are ignored by the device, but the spec also recommends matching the
>> -	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
>> -	 * are expected even though Linux does not require or maintain that
>> -	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
>> -	 * Decoder Capability Enable.
>> -	 */
>> -	if (info->mem_enabled)
>> -		return -EBUSY;
>> -
> Dropping this condition is the bit I'm referring to at the top.  I think
> if (info->mem_enabled)
> 	return 0;
> 
> would avoid that transition.

ok
> 
>>   	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>>   	if (rc)
>>   		return rc;

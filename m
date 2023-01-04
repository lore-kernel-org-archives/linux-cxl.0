Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE4C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 16:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbjADQIJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbjADQIF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 11:08:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879DE1BEA1
        for <linux-cxl@vger.kernel.org>; Wed,  4 Jan 2023 08:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672848483; x=1704384483;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=kB1uC8g2x/TMsp8dc58V6VVV6BzxjmyiTrkl9tFZj6w=;
  b=NP1dhzBX9pFssLhuv4MWzkEX0wUFcXcPJ592bveMViQWhnnM587AXKlL
   ELUsn1N2BvcLhHeQpKd4MvJqxV33HxvQ7C2cX3XPR2qP6T/4Yl+pGHgwv
   +WtWZI/3TLA/zDpCV5+8iKNZ5ogcotUoHluxNpGOPxgT2INYIZS+PI1d4
   ybw6QmWOQRA+XdTO7+S4bHFgIAhZn8BM9BC76p7Ym74Zcm9D1wejYVDh3
   u9m7//xwCdWdr/cK+cQ5DXRQspk0TdV2TU5qjb1YTHRBBuCZ57yT2Koq0
   q7wSuLV6hvGboM4eCdOXrki8CzarkKtSi9FhyJea+rhbQAFMdX0j2+TDN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="323204087"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="323204087"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:07:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="685794684"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="685794684"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.80.232]) ([10.212.80.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:07:42 -0800
Message-ID: <7eba93fa-d037-c577-a287-992ff6c5cc76@intel.com>
Date:   Wed, 4 Jan 2023 09:07:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 4/8] cxl: emulate HDM decoder from DVSEC range
 registers
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rrichter@amd.com, terry.bowman@amd.com
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
 <166984995817.2805382.13166060288973761642.stgit@djiang5-desk3.ch.intel.com>
 <20221219164231.000002c0@Huawei.com>
 <81b02689-93dc-3b11-a1c1-fd7d55552d32@intel.com>
In-Reply-To: <81b02689-93dc-3b11-a1c1-fd7d55552d32@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/3/23 4:20 PM, Dave Jiang wrote:
> 
> 
> On 12/19/22 9:42 AM, Jonathan Cameron wrote:
>> On Wed, 30 Nov 2022 16:12:38 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> In the case where HDM decoder register block exists but is not 
>>> programmed
>>> and at the same time the DVSEC range register range is active, 
>>> populate the
>>> CXL decoder object 'cxl_decoder' with info from DVSEC range registers.
>>
>> I may be overthinking this...
>>
>> So I think this results in us enabling hdm decoder registers on
>> a device that the BIOS already set the range registers for?
> 
> The code don't actually program and enable an unprogrammed HDM decoder. 
> It creates a locked HDM decoder structure that's filled with info from 
> DVSEC. The interested info will show up in sysfs but there should not be 
> any changes WRT existing HDM decoder. The DVSEC range register 
> exclusively controls this memory range.
> 
>>
>> I'm not sure the spec guarantees that is a safe operation if accesses are
>> in flight.
>> You can imagine a device which goes through an unsafe intermediate state
>> when switching over from range registers to HDM decoders.  That wouldn't
>> normally be a problem as we'd not expect traffic in flight, but if the
>> BIOS already set up a mapping the OS might see that as normal memory 
>> which
>> it is using when this transition occurs.
>>
>> If just feels like a transition no one will test that might bite us in
>> future in really hard to detect ways.
>>
>>>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>>   drivers/cxl/core/hdm.c |   33 ++++++++++++++++++++++++++++++---
>>>   drivers/cxl/core/pci.c |   12 ------------
>>>   drivers/cxl/cxl.h      |    3 ++-
>>>   drivers/cxl/port.c     |    2 +-
>>>   4 files changed, 33 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>> index d1d2caea5c62..9773a5efaefd 100644
>>> --- a/drivers/cxl/core/hdm.c
>>> +++ b/drivers/cxl/core/hdm.c
>>> @@ -674,9 +674,31 @@ static int cxl_decoder_reset(struct cxl_decoder 
>>> *cxld)
>>>       return 0;
>>>   }
>>> +static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>>> +                        struct cxl_decoder *cxld, int which,
>>> +                        struct cxl_endpoint_dvsec_info *info)
>>> +{
>>> +    if (!is_cxl_endpoint(port))
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    if (info->dvsec_range[which].start == CXL_RESOURCE_NONE)
>>> +        return -ENXIO;
>>> +
>>> +    cxld->target_type = CXL_DECODER_ACCELERATOR;
>>
>> Why chose type 2 target type?  Definitely needs a comment.
> 
> There are only 2 defines for decoder type. I picked the one that is not 
> EXPANDER.

Looks like there were some confusion on my part. For purpose of 
emulation here it's sufficient to just set it to generic 
CXL_DECODER_EXPANDER (type 3)?

DJ

> 
>> Also would be good to have a precursor patch that moves these
>> over to the CXL 3.0 naming to incorportate the fun difference
>> between HDM-DB and HDM-H type 3 devices
>>
>> CXL_DEVICE_COHERENT_ADDRESS_RANGE
>> CXL_HOST_ONLY_COHERENT_ADDRESS_RANGE
> 
> I'll take a look at the spec.
>>
>>
>>
>>> +
>>> +    cxld->hpa_range = (struct range) {
>>> +        .start = info->dvsec_range[which].start,
>>> +        .end = info->dvsec_range[which].end,
>>> +    };
>>> +
>>> +    cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
>>> +    port->commit_end = cxld->id;
>>
>> blank line before all simple returns like this makes the code
>> slightly more readable.
> 
> ok
>>
>>> +    return 0;
>>> +}
>>> +
>>
>> ...
>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index 385dbe9bd5f2..5e44fe23fa76 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -412,18 +412,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state 
>>> *cxlds, struct cxl_hdm *cxlhdm,
>>>           info->mem_enabled = 0;
>>>       }
>>> -    /*
>>> -     * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 
>>> Base
>>> -     * [High,Low] when HDM operation is enabled the range register 
>>> values
>>> -     * are ignored by the device, but the spec also recommends 
>>> matching the
>>> -     * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero 
>>> info->ranges
>>> -     * are expected even though Linux does not require or maintain that
>>> -     * match. If at least one DVSEC range is enabled and allowed, 
>>> skip HDM
>>> -     * Decoder Capability Enable.
>>> -     */
>>> -    if (info->mem_enabled)
>>> -        return -EBUSY;
>>> -
>> Dropping this condition is the bit I'm referring to at the top.  I think
>> if (info->mem_enabled)
>>     return 0;
>>
>> would avoid that transition.
> 
> ok
>>
>>>       rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>>>       if (rc)
>>>           return rc;

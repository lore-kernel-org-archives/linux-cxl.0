Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD30C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 16:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJKQ7z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJKQ7x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 12:59:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA6FD38
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665507591; x=1697043591;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iyHMz6DqMAgyVmVW6+QV+hqQ+e095f/np/FbvAmYzZc=;
  b=PBlbh5RgEoj1tCrlY6foV/eEM3maiE13/QaJchsIpSgTxsB7qEfPPBxs
   bGi5MAhy7xXfJ1z3dNZZIXSUyaJOPXbqeYQl0Mlo/h4pldXv+9HIFyOTI
   GSH972nJQPfUESA9CAhN6eVK6Y0TxhZHNegGYsWWf04pBLlMZz132ji5p
   Rjc+0+6RsuuaajRUdimuNyFIhmduuJVUiIcBgsKHs3NbeRjTSA+lDTbmc
   5ulKMJ74iVMr2zqBorgY7fsBe9s2ssayG0qsZ2IeXsTk1FHJbZ2P8PW6D
   0XIgZg2EKfTnbNCUIl5JQ2SRSV3Ge2JhStpB0KZJRQ0GfqTjII/YIgF6k
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="291884122"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="291884122"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 09:56:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="626435314"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="626435314"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.213.164.137]) ([10.213.164.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 09:56:31 -0700
Message-ID: <c6b8121d-1936-acca-157a-d3d21f0b00fc@intel.com>
Date:   Tue, 11 Oct 2022 09:56:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH] cxl: check decoder count for end device
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com
References: <166326546707.3348078.8667496731861557941.stgit@djiang5-desk3.ch.intel.com>
 <20221011174534.000072bb@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221011174534.000072bb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/11/2022 9:45 AM, Jonathan Cameron wrote:
> On Thu, 15 Sep 2022 11:11:07 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
>> indicates that for devices, only 10 decoders should be advertised. Add
>> check on number of decoders greater than 10 for devices and reset to 10 to
>> force spec compliance.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Hi Dave
>
> Seems reasonable.  I'm a bit curious to whether there is an actual problem if
> a device is spec non compliant and advertises more decoders?
Not that I'm aware of. Just being cautious.
>
> Either way does no harm and might let us know something fishy is happening.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Thanks!
>
>> ---
>>   drivers/cxl/core/hdm.c |   16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index d1d2caea5c62..1919d99d157e 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -71,9 +71,23 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
>>   static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>>   {
>>   	u32 hdm_cap;
>> +	int decoder_count;
>> +	struct device *dev = &cxlhdm->port->dev;
>>   
>>   	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
>> -	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
>> +	decoder_count = cxl_hdm_decoder_count(hdm_cap);
>> +	/*
>> +	 * CXL spec rev3.0 8.2.4.19.1 indicates CXL devices shall not advertise
>> +	 * more than 10 decoders. Switches and Host Bridges may advertise up to
>> +	 * 32 decoders. Set the decoders to 10 for devices if more than 10 are
>> +	 * found.
>> +	 */
>> +	if (is_cxl_endpoint(cxlhdm->port) && decoder_count > 10) {
>> +		dev_warn(dev, "Reset decoders count (%d) to 10, spec violation!\n",
>> +			 decoder_count);
>> +		decoder_count = 10;
>> +	}
>> +	cxlhdm->decoder_count = decoder_count;
>>   	cxlhdm->target_count =
>>   		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
>>   	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
>>
>>

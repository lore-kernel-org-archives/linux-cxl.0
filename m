Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB33C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Oct 2022 21:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJUVYl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJUVYk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 17:24:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B44B32D84
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666387478; x=1697923478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x3ykxFGTYYUWTLAxJj97WePk3+HSZEodGxyXY84tdq0=;
  b=LgK/slY8C2lmAPi/zqwya6eyPQLQ00Z2VzUqdXp1xUFm2I5UgKjnM1Dk
   SmDi5n3vnY9Sg51SBz9EhbhLepJFi99T2+4Ua6r0bQmfk86+0Re+Z26J4
   IDFlDcs7YdLpdazcZUajJEqBuCwGnh1SENr2wAfBCvQG+SF9QK4ZtD0uu
   qGoJG52881d7COb6XjEMnQgJxshtB7/Mh7c0Gbgut/3by8/ulCw66xfI4
   eoWMFJlEmPcF/3DtFMKK+jxih4DoSucmRWW96vDo19QdbXw/scfgBguq8
   Ao6AQy+S6bjiSDmj1f6zzPHkemO+j2DADRNSlpO9PshSpOHbpxKo8NA29
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="304720079"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="304720079"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 14:24:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="959795086"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="959795086"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.30.144]) ([10.212.30.144])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 14:24:38 -0700
Message-ID: <ddebb917-eb3f-4bc5-8bcb-e0cba3e072c0@intel.com>
Date:   Fri, 21 Oct 2022 14:24:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [PATCH] cxl: check decoder count for end device
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org
References: <166326546707.3348078.8667496731861557941.stgit@djiang5-desk3.ch.intel.com>
 <63530c57381ff_4da3294d9@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <63530c57381ff_4da3294d9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/21/2022 2:17 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
>> indicates that for devices, only 10 decoders should be advertised. Add
>> check on number of decoders greater than 10 for devices and reset to 10 to
>> force spec compliance.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
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
> I agree with the reporting, but not the limitation. The Robustness
> Principle says if allowing it does no harm, then let it through.
Ok I'll remove the reassigment.

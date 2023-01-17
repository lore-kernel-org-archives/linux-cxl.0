Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0063C00A5A
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 00:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjARAHV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 17 Jan 2023 19:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjARAGu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 17 Jan 2023 19:06:50 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18384C79C7
        for <linux-cxl@vger.kernel.org>; Tue, 17 Jan 2023 15:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673997581; x=1705533581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QPiN+MDwlBakmWsnKC7MZoWUEeb2SrQ6+dZfNcAlEz8=;
  b=B0srErimzUILRqs9lQ1ij9VH2FV5LuNdZj+MVWICkb/cxusK+1nrt4v2
   jMFbp7Z8IVcKj1XE4Kd5Is8man1CxHp64QOE5xvPQUGVousWeuxA1itCx
   J0lS5e5Lo+DRIqejzb4vKit7Ckn8LGxFjTwgSun/INSerbDUEWoxjQruL
   pu6hJkmOYObDt+lYW3ilX6PLfboNpXBXbNvIangARH7NxDnxFYeo4c4M/
   evHgGOFr0zn4g9sXoQM3C2qOTE2E+Pznq2DelpU2vTDHqT5vOpWQzbEj0
   uFbGf07xRiTkJlKsjHfvbDt5zfhIajVfPRSV8nXdhOTSeSrDm4FrFTs5S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304532029"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304532029"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 15:19:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="767472813"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="767472813"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.41.87]) ([10.212.41.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 15:19:39 -0800
Message-ID: <25e66916-f05a-d97a-2879-13f08a0a43de@intel.com>
Date:   Tue, 17 Jan 2023 16:19:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2 7/8] cxl: Add emulation when HDM decoders are not
 committed
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
 <167330064247.975161.16867413974628215063.stgit@djiang5-mobl3.local>
 <20230113140712.00004f96@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230113140712.00004f96@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/13/23 7:07 AM, Jonathan Cameron wrote:
> On Mon, 09 Jan 2023 14:44:03 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> For the case where DVSEC range register(s) are active and HDM decoders are
>> not committed, use RR to provide emulation. A first pass is done to note
>> whether any decoders are committed. If there are no committed endpoint
>> decoders, then DVSEC ranges will be used for emulation.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Hi Dave
> 
> One trivial suggestion inline. With that tidied up
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>   drivers/cxl/core/hdm.c |   39 ++++++++++++++++++++++++++++++++-------
>>   drivers/cxl/cxl.h      |    1 +
>>   2 files changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index ed5e9ef3aa9b..40844ff2fe52 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -729,6 +729,33 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>>   	return 0;
>>   }
>>   
>> +static bool should_emulate_decoders(struct cxl_hdm *cxlhdm)
>> +{
>> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>> +	bool committed;
>> +	u32 ctrl;
>> +	int i;
>> +
>> +	if (!is_cxl_endpoint(cxlhdm->port))
>> +		return false;
>> +
>> +	if (!hdm)
>> +		return true;
>> +
>> +	/*
>> +	 * If any decoders are committed already, there should not be any
>> +	 * emulated DVSEC decoders.
>> +	 */
>> +	for (i = 0; i < cxlhdm->decoder_count; i++) {
>> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
>> +		committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> 
> FIELD_GET() is nicer than !! I think.
> 
> Also, local variable isn't useful so I'd get rid of it.
> 
> 		if (FIELD_GET(ctrl, CXL_HDM_DECODER0_CTRL_COMMITTED))
> 			return false;

Compiler does not seem to like single bit mask. How about
		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
			return false;
> 
> 
>> +		if (committed)
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
> 
>>
> 

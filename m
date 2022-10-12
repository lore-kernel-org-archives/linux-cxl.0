Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D1FC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 15:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJLPrY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLPrY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 11:47:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACA521E07
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665589643; x=1697125643;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2CmgepnuCNBzOWSRDd2V5fkF0YRM5t/WFdkdVGkKXgo=;
  b=hVr9Dsij5W36pU99OhaKhYKi13dPSN9/C1KK2Id+2uVIWeHHAxUBIqhT
   R4mJYSPRyxQf/LARcLSiAb7EywPb/imgswM61uRpw+iEpAHBIMqBQ3wk6
   1+yr5PsYPNtANFV4gkXjx0QBqp8d699Yb3N3qqdmYvFLDEICddk7Hvplc
   48ZR3888o2/jeLdrQH2snB7ICXBKjz5MC9+Jzo0OTVU8ZrYQfu5P52vWO
   Hi2A7MorLW0IkMCtUg+XBuF1d6ZQiTEcB3kTnIbroM91dOvTlrXEnXDCx
   v4XE19fGEDdR7V5efujhYc9a7N+KRX61tbWuwpDQNOF3a8/weG3wEMkBJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="292152172"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="292152172"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 08:47:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="659975274"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="659975274"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.71.30]) ([10.212.71.30])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 08:47:22 -0700
Message-ID: <753a60bc-cdf8-bdcb-1323-00d2a5e1115d@intel.com>
Date:   Wed, 12 Oct 2022 08:47:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH] cxl: update var names for interleave ways conversion
 macros
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com
References: <166552461397.1940763.17766745890158322847.stgit@djiang5-desk3.ch.intel.com>
 <Y0YVFqSAv4Pf10wi@aschofie-mobl2>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Y0YVFqSAv4Pf10wi@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/11/2022 6:15 PM, Alison Schofield wrote:
> On Tue, Oct 11, 2022 at 02:43:33PM -0700, Dave Jiang wrote:
>> Change var names for interleave ways macros to clearly indicate which
>> variable is encoded and which is the actual ways value.
>>
>> iw == interleave ways
>> eniw == encoded interleave ways
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/cxl.h |   22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 7a4f740d710c..c0d826084465 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -78,14 +78,14 @@ static inline int cxl_to_granularity(u16 enig, unsigned int *ig)
>>   }
>>   
>>   /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
>> -static inline int cxl_to_ways(u8 eniw, unsigned int *val)
>> +static inline int cxl_to_ways(u8 eniw, unsigned int *iw)
> How about -
> +static inline int cxl_eniw_to_ways(u8 eniw, unsigned int *ways)
> +static inline int cxl_ways_to_eniw(unsigned int ways, u8 *eniw)

Sure. I was trying to keep the patch small. But may as well get it all 
updated.


>
> and similarly for granularity.
>
> I think 'ways' (same with 'granularity') is used more in the drivers,
> although core/region.c uses iw often.
>
> What you have is certainly clearer, so just chiming in here.
>
> Alison
>
>>   {
>>   	switch (eniw) {
>>   	case 0 ... 4:
>> -		*val = 1 << eniw;
>> +		*iw = 1 << eniw;
>>   		break;
>>   	case 8 ... 10:
>> -		*val = 3 << (eniw - 8);
>> +		*iw = 3 << (eniw - 8);
>>   		break;
>>   	default:
>>   		return -EINVAL;
>> @@ -102,20 +102,20 @@ static inline int granularity_to_cxl(int ig, u16 *enig)
>>   	return 0;
>>   }
>>   
>> -static inline int ways_to_cxl(unsigned int ways, u8 *iw)
>> +static inline int ways_to_cxl(unsigned int iw, u8 *eniw)
>>   {
>> -	if (ways > 16)
>> +	if (iw > 16)
>>   		return -EINVAL;
>> -	if (is_power_of_2(ways)) {
>> -		*iw = ilog2(ways);
>> +	if (is_power_of_2(iw)) {
>> +		*eniw = ilog2(iw);
>>   		return 0;
>>   	}
>> -	if (ways % 3)
>> +	if (iw % 3)
>>   		return -EINVAL;
>> -	ways /= 3;
>> -	if (!is_power_of_2(ways))
>> +	iw /= 3;
>> +	if (!is_power_of_2(iw))
>>   		return -EINVAL;
>> -	*iw = ilog2(ways) + 8;
>> +	*eniw = ilog2(iw) + 8;
>>   	return 0;
>>   }
>>   
>>
>>

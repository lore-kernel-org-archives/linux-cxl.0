Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3FFC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 15:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJLPr6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLPr5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 11:47:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBC6F191C
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665589676; x=1697125676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OnEOEAbQddwFjD8hPGFgCJqTRJw9qwNVU2Wq7SVLoWc=;
  b=dvJI4Nfa3x5WyROvPhrefdEVQn21ZF1i1vWsNhhpCTd5a6wJ46Gfj2tx
   IUbBpxukkt7/ZUJFcpcJGljHm3Fi0Ne2hZ2DO7Lhu/CCRUhvMoh/lSz09
   uBfMIksNQHwRICcawYHrplvnAwlzKNL5ZMSDZ9piT7jaBh/fEBbIFHA/k
   DhHW97UxhXMgXC3aT0joujYMvrlAfH8/fVqrq+hKTYxuHr4krv5LixOAo
   G9lgXxdXgtNPY2M4sXOqXuAQDib3ORjAODnlTHAThJnq+MW87Umqdt5Ad
   8aNJHuajS899DGzYWu8VdNClraYzJUEHWDmNx8ccyZBKazh50ZYLi/z7w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="305885595"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="305885595"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 08:47:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="659975467"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="659975467"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.71.30]) ([10.212.71.30])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 08:47:53 -0700
Message-ID: <84ec8e7f-2db1-d366-f106-60cfec3c2710@intel.com>
Date:   Wed, 12 Oct 2022 08:47:53 -0700
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
 <Y0YV5G0TSG3zwKnB@aschofie-mobl2>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Y0YV5G0TSG3zwKnB@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/11/2022 6:18 PM, Alison Schofield wrote:
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
> Above comment can be updated:
> CXL 8.2.4.19.7 CXL HDM Decoder n Control Register
That probably needs to be a different patch.
>
>
>> -static inline int cxl_to_ways(u8 eniw, unsigned int *val)
>> +static inline int cxl_to_ways(u8 eniw, unsigned int *iw)
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

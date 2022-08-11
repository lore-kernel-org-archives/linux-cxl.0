Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D9BC25B0F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 23:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiHKXUE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbiHKXTs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 19:19:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE81CA1D08
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660259927; x=1691795927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u9VBWNDt1ohdrRg2iDkKLmTn3SaihBfMc5KpUlvOqzk=;
  b=jDruA4vWLNx4KkwuxzPxZolAt27EKbGKXB3sMFUF+3cd39sajSjPgJU0
   jmZy7JIYZQr7yPY+jxx/qzCghH+PgDi6OUGRkuWHQ6Bt93SBZxeYqWeAs
   hemc6dtTV9vz80kNSOjjlRl1ToDokc0WrJLylkHokKu4ZL4exTr7+SB0Z
   JYO/7oxicn1DfbjImyY/5YjAX5VI+3f8WYORh0lTG8mFUtUX6q1mQNauU
   U5vWLbRUVEeJKmrTkVYc14t5nptxaubFa7n+IRkGAx/ELqC25no8fA03Z
   0+XDXlEr0c7G8qkC7l2F0J9yrZlvwuxDLfumIbpoDlZCTVPEpqhOrCSUO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="355487144"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="355487144"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:18:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="933510355"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.81.242]) ([10.212.81.242])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:18:47 -0700
Message-ID: <685f101b-60d7-1b53-fa16-e89fd83163a2@intel.com>
Date:   Thu, 11 Aug 2022 16:18:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] cxl: Add check for result of interleave ways plus
 granularity combo
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
 <165999281717.493131.1159254270127915425.stgit@djiang5-desk4.jf.intel.com>
 <62f288f1cb88a_1f18b2943a@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <62f288f1cb88a_1f18b2943a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 8/9/2022 9:18 AM, Dan Williams wrote:
> Dave Jiang wrote:
>> Add a helper function to check the combination of interleave ways and
>> interleave granularity together is sane against the interleave mask from
>> the HDM decoder. Add the check to cxl_region_attach() to make sure the
>> region config is sane. Add the check to cxl_port_setup_targets() to make
>> sure the port setup config is also sane.
>>
>> Calculation refers to CXL spec v3 8.2.4.19.13 implementation note #3.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/region.c |   17 ++++++++++++++++-
>>   drivers/cxl/cxl.h         |   11 +++++++++++
>>   drivers/cxl/cxlmem.h      |   31 +++++++++++++++++++++++++++++++
>>   3 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index cf5d5811fe4c..a209a8de31fd 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1081,6 +1081,13 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>>   		return rc;
>>   	}
>>   
>> +	rc = cxl_interleave_verify(port, iw, ig);
> There are multiple "interleave verify" actions, this function is just
> handling the interleave address bit capability, so how about:
>
> s/cxl_interleave_verify/cxl_interleave_capable/
ok
>
>> +	if (rc) {
>> +		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave & granularity combo: %d\n",
> If this fires I would want to know the iw and ig settings, something
> like:
>
>      "%s:%s interleave (ig: %d iw: %d mask: %#x) exceeds capability (mask: %#x)\n"
>
> Likely that message would need to move internal to
> cxl_interleave_capable() where you have the address masks available.
Will move it internally
>
>
>> +			dev_name(port->uport), dev_name(&port->dev), rc);
>> +		return rc;
>> +	}
>> +
>>   	cxld->interleave_ways = iw;
>>   	cxld->interleave_granularity = ig;
>>   	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
>> @@ -1218,6 +1225,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>   		return -EBUSY;
>>   	}
>>   
>> +	ep_port = cxled_to_port(cxled);
>> +	rc = cxl_interleave_verify(ep_port, p->interleave_ways,
>> +				   p->interleave_granularity);
>> +	if (rc) {
>> +		dev_dbg(&cxlr->dev, "%s: invalid interleave & granularity combo: %d\n",
>> +			dev_name(&cxlmd->dev), rc);
> ...and then you don't need to duplicate the message if it is internal to
> cxl_interleave_capable().
>
>> +		return rc;
>> +	}
>> +
>>   	for (i = 0; i < p->interleave_ways; i++) {
>>   		struct cxl_endpoint_decoder *cxled_target;
>>   		struct cxl_memdev *cxlmd_target;
>> @@ -1236,7 +1252,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>   		}
>>   	}
>>   
>> -	ep_port = cxled_to_port(cxled);
>>   	root_port = cxlrd_to_port(cxlrd);
>>   	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
>>   	if (!dport) {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index bc604b7e44fb..275979fbd15a 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -61,6 +61,17 @@
>>   #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>>   #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>>   
>> +enum {
>> +	CXL_INTERLEAVE_1_WAY = 0,
>> +	CXL_INTERLEAVE_2_WAY,
>> +	CXL_INTERLEAVE_4_WAY,
>> +	CXL_INTERLEAVE_8_WAY,
>> +	CXL_INTERLEAVE_16_WAY,
>> +	CXL_INTERLEAVE_3_WAY = 8,
>> +	CXL_INTERLEAVE_6_WAY,
>> +	CXL_INTERLEAVE_12_WAY
> I'm not sure this new enum is worth it given only one of these will ever
> be used.
Will remove
>
>> +};
>> +
>>   static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>>   {
>>   	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 88e3a8e54b6a..d5f872ca62f9 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -401,6 +401,37 @@ struct cxl_hdm {
>>   	struct cxl_port *port;
>>   };
>>   
>> +static inline int cxl_interleave_verify(struct cxl_port *port,
>> +					int ways, int granularity)
>> +{
>> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>> +	unsigned int addr_mask;
>> +	u16 ig;
>> +	u8 iw;
>> +	int rc;
>> +
>> +	rc = granularity_to_cxl(granularity, &ig);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = ways_to_cxl(ways, &iw);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (iw == 0)
>> +		return 0;
>> +
>> +	if (iw < CXL_INTERLEAVE_3_WAY)
> ...just do "is_power_of_2(iw)" here instead.

ok

>
>> +		addr_mask = GENMASK(ig + 8 + iw - 1, ig + 8);
>> +	else
>> +		addr_mask = GENMASK((ig + iw) / 3 - 1, ig + 8);

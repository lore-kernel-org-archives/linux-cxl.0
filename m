Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC52C04AA5
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 21:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiHXVEj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbiHXVEi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Aug 2022 17:04:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01E8726A0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Aug 2022 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661375077; x=1692911077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U/Lk2bZtnhxHnc24ZcvYEBu9rrFxAY4nqn7yHCtcR5I=;
  b=Czd3xn8smM6ZRbdq5EcS+e83wTizMm1XYrBY/wFiJJ4VLHORM/+Cuc2d
   YamFb8Psk5uZe2pjM8Sc/QhotZCr8u15cZKkDsqkpfVUmfxPyNRPj6tNV
   x0nPnYSl2cUARsH4sOXWTQD0Q+GLtK7UUZY5qx2mRJleI49emu8XdLiEi
   odeqW3aSGww2z+E8DBVdu1DOW9jmQB0i/w/a+m6Hfr0o4EM9xusEBm5zq
   uxS/ESTnOqTi76nB8pZspzDW+pALHlFX/jBTSMwgcJh3kmbWpgolCi/hk
   TUJKqxjoqvoBFmclNoqouyJl8C4iYBwBsPClkp+H5EdUjQtYDLxfH4aw7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273829097"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="273829097"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:04:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="678196345"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.213.178.56]) ([10.213.178.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:04:37 -0700
Message-ID: <8e7c43b6-1fd2-8010-d64f-00c713f44212@intel.com>
Date:   Wed, 24 Aug 2022 14:04:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v4 2/6] cxl: Add CXL spec v3.0 interleave support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
 <166077130837.1743055.16772443540776610507.stgit@djiang5-desk4.jf.intel.com>
 <20220824155624.000079ea@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220824155624.000079ea@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 8/24/2022 7:56 AM, Jonathan Cameron wrote:
> On Wed, 17 Aug 2022 14:21:48 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> CXL spec v3.0 added 2 CAP bits to the CXL HDM Decoder Capability Register.
>> CXL spec v3.0 8.2.4.19.1. Bit 11 indicates that 3, 6, and 12 way interleave
>> is capable. Bit 12 indicates that 16 way interleave is capable.
>>
>> Add code to parse_hdm_decoder_caps() to cache those new bits. Add check in
>> cxl_interleave_verify() call to make sure those CAP bits matches the passed
> Whilst looking at mocking patch, I noticed there isn't a cxl_interleave_verify()
> renamed?  Looks like that was in v2 from your change log.
I need to fixup the commit headers all to cxl_interleave_capable(). 
Forgot about that.
>
>> in interleave value.
>>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/hdm.c    |    6 ++++++
>>   drivers/cxl/core/region.c |    3 +++
>>   drivers/cxl/cxl.h         |    2 ++
>>   drivers/cxl/cxlmem.h      |    5 +++++
>>   4 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index d1d2caea5c62..2f91ff9b0227 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -80,6 +80,12 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>>   		cxlhdm->interleave_mask |= GENMASK(11, 8);
>>   	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>>   		cxlhdm->interleave_mask |= GENMASK(14, 12);
>> +
>> +	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_DEFAULT;
>> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
>> +		cxlhdm->interleave_cap |= CXL_HDM_INTERLEAVE_CAP_3_6_12;
>> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
>> +		cxlhdm->interleave_cap |= CXL_HDM_INTERLEAVE_CAP_16;
>>   }
>>   
>>   static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 28272b0196e6..9851ab2782f2 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -960,6 +960,9 @@ static int cxl_interleave_capable(struct cxl_port *port, struct device *dev,
>>   	if (eiw == 0)
>>   		return 0;
>>   
>> +	if (!test_bit(ways, &cxlhdm->interleave_cap))
>> +		return -EINVAL;
>> +
>>   	if (is_power_of_2(eiw))
>>   		addr_mask = GENMASK(eig + 8 + eiw - 1, eig + 8);
>>   	else
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index f680450f0b16..11f2a14f42eb 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -42,6 +42,8 @@
>>   #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>>   #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>>   #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>>   #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>>   #define   CXL_HDM_DECODER_ENABLE BIT(1)
>>   #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 88e3a8e54b6a..4e65c9cc1d30 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -393,11 +393,16 @@ static inline void cxl_mem_active_dec(void)
>>   }
>>   #endif
>>   
>> +#define CXL_HDM_INTERLEAVE_CAP_DEFAULT BIT(1) | BIT(2) | BIT(4) | BIT(8)
>> +#define CXL_HDM_INTERLEAVE_CAP_3_6_12 BIT(3) | BIT(6) | BIT(12)
>> +#define CXL_HDM_INTERLEAVE_CAP_16 BIT(16)
>> +
>>   struct cxl_hdm {
>>   	struct cxl_component_regs regs;
>>   	unsigned int decoder_count;
>>   	unsigned int target_count;
>>   	unsigned int interleave_mask;
>> +	unsigned long interleave_cap;
>>   	struct cxl_port *port;
>>   };
>>   
>>
>>

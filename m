Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D23002DD
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521101; cv=none; b=tqtfCF+awGu6UkE/+pwiIOu9H9bSPJlQZ8udc3jL8O7USBYHgQaKQE3hO+bMSGIFTD4diCyHQ3p4dyH944dwzXCbbcL/akQpeVu3PZVgC7cbRNszU8tRv7c7QfTwEeIuiNnwkAYuXYRVGvWpO5SHI4uXpneI6NMW6+bHBQmROPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521101; c=relaxed/simple;
	bh=6ixNAalDzQrb/kd39z4fvTRj9/VF1CTYnG/r9GExsMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIgEQ85hweq3I3qWwX2zUftZ0KNyB7IV7CQNPv+E5DX/UhWnV5Fk9BGFnILg4uoTgkMcgbVobVT3z9HYOxbITD46fbKWmfsvoI0OytYeExlbgoYgcNBmsCjh/5YgYMZ6Zhl3fcSMxyTQt7LpAbneBez0ABPhaT6IFKPLanNp858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Vss5uTlV; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Vss5uTlV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786521095; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VKC9Lzx4ab+liJrqIgdI3Wv5GjLYP50gKwkFy7uDYQc=;
	b=Vss5uTlVYWzPtDQGGEmKpG7YwncvDta9EUDyZ2877dpsdIRTyzoYpzDdOJ1R/YL90KXEv6Net5hR7iCJahum7gw19zoSsjsQArXMc5Th6+TAgLHFUen3GY7ub70VlSAsjAKUfzsv0BQgXG9DtdTWXMhMu+KSXyerg7CYRN9EFVk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X8qsRwC_1786521093;
Received: from 30.178.83.207(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8qsRwC_1786521093 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 15:51:35 +0800
Message-ID: <6be8a860-a56f-4776-9017-d976571fbee7@linux.alibaba.com>
Date: Wed, 12 Aug 2026 15:51:33 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: Fix out of bounds read of the decoder target
 list
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20260812061017.56916-1-kanie@linux.alibaba.com>
 <20260812062605.610B61F000E9@smtp.kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260812062605.610B61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/12 14:26, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Endianness bug when decoding the HDM decoder Target List registers on big-endian architectures.
> - [High] Permanent port state corruption on decoder initialization failure due to un-reverted `port->commit_end`.
> --
>
> --- Patch [1]: [PATCH v2] cxl/hdm: Fix out of bounds read of the decoder target list ---
> commit c692efbe782398330e6841bfdd1146cdee44ef3b
> Author: Guixin Liu <kanie@linux.alibaba.com>
> Subject: cxl/hdm: Fix out of bounds read of the decoder target list
>
> This commit fixes an out-of-bounds read in the HDM decoder initialization. It
> adds a check to ensure the interleave ways do not exceed the size of the
> target list array when programming the target map.
>
> Link: https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 0c80b76a5f9b4..9d49b48a4456e 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -1084,6 +1084,18 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>   		cxld->interleave_ways, cxld->interleave_granularity);
>>   
>>   	if (!cxled) {
>> +		/*
>> +		 * The Target List register only holds
>> +		 * ARRAY_SIZE(target_list.target_id) entries, so a switch
>> +		 * decoder cannot interleave across more ports than that.
>> +		 */
>> +		if (cxld->interleave_ways > ARRAY_SIZE(target_list.target_id)) {
>> +			dev_warn(&port->dev,
>> +				 "decoder%d.%d: Interleave ways: %d exceeds target list size\n",
>> +				 port->id, cxld->id, cxld->interleave_ways);
>> +			return -ENXIO;
> [Severity: High]
> This is a pre-existing issue, but does returning here leave port->commit_end
> permanently advanced?
>
> Earlier in init_hdm_decoder(), port->commit_end is updated:
>
> 	if (committed) {
> 		...
> 		port->commit_end = cxld->id;
> 	}
>
> If we fail here and return -ENXIO, port->commit_end is not rolled back.  If
> initialization is retried, cxl_num_decoders_committed() will return an
> inflated count, which could cause the out of order commit check to fail.
> Could this permanently prevent the port from initializing?
Yes, this is another bug, I will send another patch to fix this.
>> +		}
>> +
>>   		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>>   		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>>   		target_list.value = (hi << 32) + lo;
> [Severity: High]
> This is a pre-existing issue, but does this code read the target IDs
> incorrectly on big-endian architectures?
>
> target_list.value is populated as a native 64-bit integer.  The subsequent loop
> reads it byte-by-byte via the target_id union:
>
> 		for (i = 0; i < cxld->interleave_ways; i++)
> 			cxld->target_map[i] = target_list.target_id[i];
>
> On big-endian hardware, accessing the native 64-bit integer byte-by-byte will
> read the most significant bytes first, which could scramble the port target
> routing.
There is no CXL big-endian architecture platform, should not change this 
currently. Best Regards, Guixin Liu


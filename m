Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F5435A9A
	for <linux-cxl@vger.kernel.org>; Mon,  6 Jul 2026 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356242; cv=none; b=SR9Dvug0RfwfOyI+i0jl0MmylcpNH5CdYiTkIB0bqTMC4o30udJNyT3x+CkY2rqAL6YZKgXqQNs6QXkiP4IHVwaVU3jfMwocTqPGNYbjtiCMrCsHhvfY4P8J5w+4JFkXlKVoAbdjgaSWYJ62Ev+7U9OzvtOlCUefRoPV7oopdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356242; c=relaxed/simple;
	bh=5hI5aor9mHNLyEiPJarivTohIuglmhzsTfc4LukwmuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9fvviF5/cBhJYAVd25+u91oTksVprlqDxKz/iqsUnnG4efJNyubLxnd8+cpJl6RnrnI7gqAR8gesqeker1c0+X3T7ry7Tg2X8FIuHHFyQXnTaofPjJCL7HK6mGzYOK0k0TmAlRWhKwVJaSjFWio12UA97CfPcCM8xY0mHwRWck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJTQD2rX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJTQD2rX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783356239; x=1814892239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5hI5aor9mHNLyEiPJarivTohIuglmhzsTfc4LukwmuM=;
  b=RJTQD2rX6mG6XJNimOnBgkKlIx1Ys5El0xSnIu0uV96/rU+lbBUlAoLC
   3F8M4JUJQKBO7c7tEKN3v0YKYSQHVB8RlrSOzrKlrBUCkXDFze4L/Byy5
   mVKy0biTdK1uTDGYEl3ipb/K18ibIlSEyPZ2Zx8ZIRzq+S5GwgzpDzSIu
   1LR11wwp0xLTUvs8J9t3xIY11CGGSNBPCGQm4hcAKaxnYMBINUz3Zanv7
   t57NC80yROo6nD7LjcU5fJJqVYPws44hNuuRGCMnwNVO5d2SAfS/epz/N
   z8HobpXJucDvBT3J6NBmwMB9a7MRfZu+81Xtm2fzpTN1+6SVrWsZmEPfO
   w==;
X-CSE-ConnectionGUID: OTj1m0CvRYqpzXD8YXmEmg==
X-CSE-MsgGUID: GbY+JpqkRa28OJqHQmmTyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="101540566"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="101540566"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:43:59 -0700
X-CSE-ConnectionGUID: xpXAu6F1T2qrRafK6R14jg==
X-CSE-MsgGUID: FzR+uzXmTmG3Hf83VlLFxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="253855460"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:43:58 -0700
Message-ID: <9ba9c5c6-fdb5-48f3-863c-00df9d7ac22b@intel.com>
Date: Mon, 6 Jul 2026 09:43:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] tools/testing/cxl: Enable zero sized decoders
 under hb0
To: Richard Cheng <icheng@nvidia.com>, sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20260625092857.41139-1-icheng@nvidia.com>
 <20260625092857.41139-3-icheng@nvidia.com>
 <20260625094602.8DB0E1F00A3A@smtp.kernel.org> <akYTPc5texS6oUo9@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <akYTPc5texS6oUo9@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/2/26 12:31 AM, Richard Cheng wrote:
> On Thu, Jun 25, 2026 at 09:46:01AM +0800, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] Incorrect HPA base for zero-sized mock decoders causes them to overlap the start of decoder[0].
>> --
>>
>> commit e4836660bfdfee0da74cc6f18fe1e3c9826c4c04
>> Author: Richard Cheng <icheng@nvidia.com>
>>
>> tools/testing/cxl: Enable zero sized decoders under hb0
>>
>> This commit introduces a mock_zero_size_decoders module parameter to cxl_test.
>> It is intended to exercise zero-size DPA reservations by mocking committed,
>> empty decoders above the auto-region under host-bridge0.
>>
>>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>>> index 418669927fb00..117691b3c62f5 100644
>>> --- a/tools/testing/cxl/test/cxl.c
>>> +++ b/tools/testing/cxl/test/cxl.c
>> [ ... ]
>>> @@ -1145,6 +1178,20 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>>>  	base = window->base_hpa;
>>>  	if (extended_linear_cache)
>>>  		base += mock_auto_region_size;
>>> +
>>> +	/*
>>> +	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
>>> +	 * endpoints mock committed, locked, empty decoders above the
>>> +	 * decoder[0] auto-region (CXL r4.0 8.2.4.20.12). commit_end then
>>> +	 * points at a zero-size decoder, exercising the zero-size
>>> +	 * reservation and poison-by-endpoint code paths.
>>> +	 */
>>> +	if (cxld->id == 1 || cxld->id == 2) {
>>> +		size_zero_mock_decoder_ep(cxld, base);
>>
>> [Severity: Medium]
>> Since the comment indicates these decoders are mocked above the decoder[0]
>> auto-region, should base + mock_auto_region_size be passed here instead
>> of base?
>>
>> Passing base appears to set the zero-sized decoder's HPA to the start of the
>> region, causing it to overlap with decoder[0].
>>
>>> +		port->commit_end = cxld->id;
>>> +		WARN_ON_ONCE(!cxld_registry_new(cxld));
>>> +		return false;
>>> +	}
>> [ ... ]
>>> @@ -1214,6 +1263,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>>>  
>>>  		cxld_registry_update(cxld);
>>>  		put_device(dev);
>>> +
>>> +		if (!mock_zero_size_decoders)
>>> +			continue;
>>> +
>>> +		/*
>>> +		 * Mirror the endpoint: commit the next two switch decoders
>>> +		 * as zero-size + locked so the empty-decoder layout extends
>>> +		 * end-to-end through the switch and host bridge.
>>> +		 */
>>> +		for (id = 1; id <= 2; id++) {
>>> +			dev = device_find_child(&iter->dev, &id,
>>> +						match_decoder_by_index);
>>> +			if (WARN_ON(!dev))
>>> +				continue;
>>> +			cxld = to_cxl_decoder(dev);
>>> +			size_zero_mock_decoder_sw(cxld, base, i);
>>
>> [Severity: Medium]
>> Similarly, does this incorrectly place the switch zero-sized mock decoders
>> at the start of decoder[0]'s HPA range instead of above it?
>>
>>> +			iter->commit_end = id;
>>> +			cxld_registry_update(cxld);
>>> +			put_device(dev);
>>> +		}
>>>  	}
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260625092857.41139-1-icheng@nvidia.com?part=2
> 
> 
> This doesn't stand neither, [base, base-1] is an empty range, it decodes nothing and can't
> overlap decoder[0]. Region assembly never sees it, endpoint empty decoder are skipped via cxled_empty(), and
> the switch matching predicates compare range ends, which an empty range can never satisfy.

sashiko is 0/2 in v6 looks like. Thanks for verifying.
 
> 
> --Richard
> 


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3331E4BE;
	Mon, 15 Sep 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953959; cv=none; b=Do13NNGpuWIcqNDLZ+Vl0GbryNnnswVOZ91T5oV+2siYqDhQXHGmsTY1smiDQOddIZ5TuM4+WiJs3vdHTiD015fU8112GgW7sRBBbjR8SxmSxTtwWg0xIoZNCwoStqLAw/bIxZv+PioN9bkrYEPpbu04spaUb8FdUgfy7hD5Ek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953959; c=relaxed/simple;
	bh=3+ZlQv/jfvFTl+C5mY+rjGvsR861gGiFG7xrpxhH+64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqV6sf3St4wi8W5TI4NlcZk13110Q+XpIIwoBQ6Me1NS9ceeVFvTZ4Nex7LRXB2dzIuVcQ3X7pVkIf+IR9KP1Hu2w0wVq/AZz+BRuNJ57ntQ8SSkOyhwG0YFDI6RJ930fH5kVvlhyZdSOlxaFZ3sn7efLJujyOQPbCGdMoMHi/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSNs4aVn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSNs4aVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757953958; x=1789489958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3+ZlQv/jfvFTl+C5mY+rjGvsR861gGiFG7xrpxhH+64=;
  b=CSNs4aVnl08xwGHopbRXT3jUMb7DjQBk7QJpQhLEUDwUWfSQEj4rTaic
   7Q0HDdU1t3RLFYjUcjk6Yo1wPhtOYXjzKorbKShfpdbx7bI8qjMjU0YMi
   JjTZLUeew9jBVzR+LyaRXrahzgdaU8vSh2EWT2ybNJXNIX5bMo9ojoSiz
   FcZcBCEnXQo7x5oXrEJMcjHhwuSSpN+4KZx/m3jd0OHsX02orIF5oY5Pn
   WKOsSlz8vvRqtXHOZdq0HPQsLerzT7/aooxjbChMQfWRGx629ZL8IHR/k
   0/LDIdrLK5XqB+8o4qO65SJmQY9Cfeg3dHDUrkqNOtepFWIQWs9W3L14a
   Q==;
X-CSE-ConnectionGUID: 08T75SM6RQWrObIXzN6CQw==
X-CSE-MsgGUID: 5otYYZz3R3COlQTiAeaFlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60323867"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="60323867"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:32:37 -0700
X-CSE-ConnectionGUID: XW/FHGt5T3esrhxbyHzotA==
X-CSE-MsgGUID: KYXAoV61T1uwfHu8slToHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="198370954"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.129]) ([10.125.111.129])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:32:36 -0700
Message-ID: <3a125d7f-7139-4a97-a38c-dfb79c138007@intel.com>
Date: Mon, 15 Sep 2025 09:32:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] cxl: Introduce callback to translate a decoder's
 HPA to the next parent port
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-8-rrichter@amd.com>
 <7c132aed-e10e-499f-9442-aa8df110390d@intel.com>
 <aMfGgKqVp1Ue0eQa@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aMfGgKqVp1Ue0eQa@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/15/25 12:55 AM, Robert Richter wrote:
> On 12.09.25 14:21:16, Dave Jiang wrote:
>>
>>
>> On 9/12/25 7:45 AM, Robert Richter wrote:
>>> To enable address translation, the endpoint decoder's HPA range must
>>> be translated when crossing memory domains to the next parent port's
>>> address ranges up to the root port. The root port's HPA range is
>>> equivalent to the system's SPA range.
>>>
>>> Introduce a callback to translate an address of the decoder's HPA
>>> range to the address range of the parent port. The callback can be set
>>> for ports that need to handle address translation.
>>>
>>> Reviewed-by: Gregory Price <gourry@gourry.net>
>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>> ---
>>>  drivers/cxl/cxl.h | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index f182982f1c14..eb837867d932 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -429,6 +429,17 @@ struct cxl_rd_ops {
>>>  	u64 (*spa_to_hpa)(struct cxl_root_decoder *cxlrd, u64 spa);
>>>  };
>>>  
>>> +/**
>>> + * cxl_to_hpa_fn - type of a callback function to translate an HPA
>>> + * @cxld: cxl_decoder to translate from
>>> + * @hpa: HPA of the @cxld decoder's address range
>>> + *
>>> + * The callback translates a decoder's HPA to the address range of the
>>> + * decoder's parent port. The return value is the translated HPA on
>>> + * success or ULLONG_MAX otherwise.
>>> + */
>>> +typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
>>
>> cxl_to_parent_hpa_fn()?
> 
> It is actually a translation from the decoder's address space to the
> address space of the port this callback is attached to. Parent port
> might be confusing here and maybe the comment needs a rework too.
> Though, finally it is used in the context where the decoder's port is
> child to the port with this callback.
> 
> Comment should be more precise, ok?

All I can say is naming is hard. But cxl_to_hpa_fn() doesn't exactly convey what it does, and we need something that provides a clearer intent preferably. Maybe someone else can have a better suggestion. 
 
DJ

> 
> -Robert
> 
>>
>> DJ 


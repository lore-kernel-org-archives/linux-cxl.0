Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25D4657E2;
	Thu, 30 Apr 2026 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564826; cv=none; b=cE2Oh0xEeFV0mGcGQjcq+m95ho/OZVXapbf90wTdlVP0TbtT4WdZSIc3qSt4KE6lFEgMFB+f73Ny6829IdJ/8JPparRqYLi6s41Zom0MoSEiryp4cc2ZjPgHsW2NoWHvSau8411fjxjQrE4qtzlSDiFFVaMqRKJsRFVLUHNpM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564826; c=relaxed/simple;
	bh=n6G/xOWzuV6pY4CedkM5NIcdJr47D/2uHYawH4dHv2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n24+jICM7tdhfo9yVxMb6zgpSZrcgKathx6wtcoL4Nj6/hGiU/0F/fSvljX5/x61W/D2/HIp+AM0hNRZpi+urX7ARMDJqJHxA0hcKz+xaVFrjF13JJKwpwRzjeYPegwp3nxYynjPSI0utyZgnZdRslZFTXf/IixmBnaTitlr34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxSKN2/E; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxSKN2/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777564824; x=1809100824;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n6G/xOWzuV6pY4CedkM5NIcdJr47D/2uHYawH4dHv2w=;
  b=lxSKN2/EqhoPnqntva1tZbKGw+odCcNBfSuK3GiFYvpxi+iDPdTPKh64
   l+3j5r2bZ3C1WvOXxyaaPq8WTVRi/p6QLP8FdS+E7GcKsR9QwvOBORXI+
   tr2Dlo5/XXS4EyQ1vpcm3E4YfA4KjfT8Ld6ckmvm6XOEuWM4xYRqQntv0
   PqKcfAOj0mjsM9PmA8C8qqlqBOFYzzfm3SDPKdSs5F3+KpcjaRe6mDWe6
   Q/Iw7DigNdt1EGCoGeY+85FK6V3Z5S5fC4/lDKKwFGb+Xqlgqt1QbVfgW
   50xt9fXdRBd62pDMyf2mzaSnKSeLRHQDLKqsgzw+jlZ7r8/1GbE/LjQC7
   Q==;
X-CSE-ConnectionGUID: fKXDgOOASOeS/S+tswNoFQ==
X-CSE-MsgGUID: E5MBtmHZQxKZ/lHazf51fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78232209"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78232209"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:00:22 -0700
X-CSE-ConnectionGUID: RDZ6yspqQfSrawlQ/VDC6w==
X-CSE-MsgGUID: Sch427l6QzyXIttwOczDWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="239615201"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.99]) ([10.125.109.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:00:21 -0700
Message-ID: <a893e485-470f-40ed-b26f-598c94c86814@intel.com>
Date: Thu, 30 Apr 2026 09:00:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cxl/region: Fix race conditions in cxl region
 unregistration.
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Robert Richter <rrichter@amd.com>,
 Li Ming <ming.li@zohomail.com>, Gregory Price <gourry@gourry.net>,
 Ben Widawsky <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260427032010.916681-2-iam@sung-woo.kim>
 <5b46d2ca-7821-4245-92fc-7169ea7435ae@intel.com>
 <CAJNyHpKMMwGnf7+2yzNnSbzozm2ROzfWmWg4xj8gROha+ncQeA@mail.gmail.com>
 <4a20f390-a49d-4a9f-911f-21c36449b990@intel.com>
 <CAJNyHpJjXCRitQykyNTseGGstP2XbRXroZ+YzkQxMLECj32BUw@mail.gmail.com>
 <7e023076-6603-4a02-8e90-47bdad562b5e@intel.com>
 <CAJNyHpLFGxu3u7GHLsmL+U0Q3U7hNY3UzYVQmBFSxUuZDzU-wA@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJNyHpLFGxu3u7GHLsmL+U0Q3U7hNY3UzYVQmBFSxUuZDzU-wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/29/26 9:39 PM, Sungwoo Kim wrote:
> On Tue, Apr 28, 2026 at 6:33 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 4/28/26 1:28 PM, Sungwoo Kim wrote:
>>> Dear Dave, thank you for sharing the patch that doesn't use the workqueue.
>>>
>>> Claude suggests not using wq, since it's simpler. I agree that it's
>>> simple, but it's overly tailored to fix a specific bug.
>>> Actually, v1[1] proposed a similar patch. So let me bring a patch and
>>> discussion from v1:
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 08fa3deef70ab..7ade9aa2aeecc 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -2745,12 +2745,19 @@ static ssize_t delete_region_store(struct device *dev,
>>>   struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>>>   struct cxl_port *port = to_cxl_port(dev->parent);
>>>   struct cxl_region *cxlr;
>>> + int err;
>>>
>>>   cxlr = cxl_find_region_by_name(cxlrd, buf);
>>>   if (IS_ERR(cxlr))
>>>   return PTR_ERR(cxlr);
>>>
>>> - devm_release_action(port->uport_dev, unregister_region, cxlr);
>>> + err = devm_remove_action_nowarn(port->uport_dev, unregister_region,
>>> +       cxlr);
>>> + if (err) {
>>> + put_device(&cxlr->dev);
>>> + return err;
>>> + }
>>> + unregister_region(cxlr);
>>>   put_device(&cxlr->dev);
>>>
>>>   return len;
>>>
>>> However, v1 has not been merged. Dan[2] commented that "No, that is
>>> not an acceptable or comprehensive fix. A subsystem should never try
>>> to double unregister a device." Also in the following thread[3], "The
>>> patch was technically correct but it relies on a design that requires
>>> depending on a double free semantic."
>>>
>>> I respect this design decision. Then, I need to execute
>>> devm_release_[action|all]() only once, which requires a device lock,
>>> guard(device)(port->uport_dev). Under a lock, I can check a flag to
>>> execute devm_release_[action|all]() only once.
>>> To use the lock, a clean work without a prior lock is required. That's
>>> a reason this patch ended up in wq.
>>>
>>> I hope I've explained the rationale for using wq. What do you think?
>>
>> Right I went back and also read what Dan proposed. I just wonder if we are over complicating things now and introducing more issues on top by doing that. Obviously we have to address the issues sachiko brought up in v3. Below is what claude suggested to fix the Sashiko issues in v3 patches. Some of the comments may be excessive but help reading through the changes.
> 
> I (and Claude) don't have a better solution than using wq, although I
> agree that not using wq is simpler.
> Also, I'm not yet experienced enough to decide which is better for
> CXL, so I'm happy with both directions. Would you prefer the version
> without wq?

Looks like Dan is working on something [1]. So maybe we wait and see what he comes up with.

[1]: https://lore.kernel.org/linux-cxl/c65851c1-4fca-46ba-8dde-fa10b7cb9cd3@amd.com/T/#mdd1ab49c012321fcd3dc34bd0cb7c0846cf1d1f9

DJ

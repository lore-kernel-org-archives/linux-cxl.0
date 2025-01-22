Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB71F78E8
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563837; cv=none; b=IctI0jYZAgDzutnREmRK82wu10T8iDoYwLNZF9ch/59WWiwzVJcvnhzyCLMK7XjZvpht+9s7Y03eJh1E4iCgybvfUMlqIDZSEihsrQpm07hQjFPhr6XGZPiO4MYnrkkdpbqPJ/TCWP6ztq4MTUfhb7q1ytuhy24bLHBVNEq0258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563837; c=relaxed/simple;
	bh=hFCTHXQ4UDWe3WDx26ofRj8/Nosg1tPp7MX1vSAOF7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQk4bv58CNtglDkkrFjxSHq8RexR0AsvdHdD8WyuDXELhUzbZ8iTgSHGo5M1V/nodkzuVZ3GeLYLFdMs/VDhSR4IIzZAo36juKcwjonrR5CT9A2SNVTBKLSK7bHiudK5afUbkAFmca3V23A8wa1HvCBwV1I/8DtJDToE8UjPR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZmr+Ms4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZmr+Ms4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737563836; x=1769099836;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hFCTHXQ4UDWe3WDx26ofRj8/Nosg1tPp7MX1vSAOF7k=;
  b=IZmr+Ms45KB1OeGVUsMK8KUvs9YrHRCqsB+gap2SrbQNDOnnXzNxvVsH
   7cKxalDrbCfNT1so1nwRecr0iliicMUdYjB25Wggu8b/9leOijboJDDBT
   yytePICV41WGhFDTJHWQM4CRxyYJKYqTL3HC8Fomj8/BbH3vU0v+j7fBQ
   NrsFW1NKvyfEMYbEUjnQNCfpMhHpbVbPNpHaAnLpQVEAx1hNrAahpxBgU
   iqH7w0xD2eLs9k25Agqj9/zYWgvricL+C+3nF9tQVm+098Fh+V9i5KvMC
   iG74d3JFsV8k/bkI6BJCpI5fyGR8zM6wOisKv6y8nb/h0BuFsKGiyKDcT
   w==;
X-CSE-ConnectionGUID: tTq8N3M+RRGSnuMXhh+kpA==
X-CSE-MsgGUID: NFpX+ggPRbKT8sKbw/LvLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="63380402"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="63380402"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 08:37:14 -0800
X-CSE-ConnectionGUID: cJOBphZbRNKuJLJ0jDpvFg==
X-CSE-MsgGUID: VzhjVB0BQiKBBEti87dk4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112167952"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.110.138]) ([10.125.110.138])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 08:37:14 -0800
Message-ID: <b508b82c-5a0f-437f-8318-99cc92374b2c@intel.com>
Date: Wed, 22 Jan 2025 09:37:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] cxl/core/regs: Refactor out functions to count
 regblocks of given type
To: Dan Williams <dan.j.williams@intel.com>,
 Huaisheng Ye <huaisheng.ye@intel.com>, Jonathan.Cameron@huawei.com,
 ming.li@zohomail.com
Cc: pei.p.jia@intel.com, linux-cxl@vger.kernel.org
References: <20250115152600.26482-1-huaisheng.ye@intel.com>
 <20250115152600.26482-2-huaisheng.ye@intel.com>
 <6790b6e5817bf_20fa2942c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6790b6e5817bf_20fa2942c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/25 2:14 AM, Dan Williams wrote:
> Some minor comments that Dave can fixup:
> 
> Huaisheng Ye wrote:
>> In commit d717d7f3df18494baafd9595fb4bcb9c380d7389, cxl_count_regblock was
> 
> When referencing a commit the typical form is 
> 
> d717d7f3df18 ("cxl: Add functions to get an instance of / count regblocks of a given type")
> 
> ...however in this case the commit history does not matter. Typically
> commit history is useful for fixes to identify what kernels are
> suspectible to the problem. In this case it is just a cleanup.
> 
> Also, for what this patch is I think the commit message can afford to be
> more concise and just say:
> 
> ---
> cxl_find_regblock_instance() counts the number of instances of a register
> block as a side effect of searching through all available register blocks.
> cxl_count_regblock() throws away that work and recounts all the register
> blocks by asking cxl_find_regblock_instance() to redo work it has
> already done until it finally returns an error, that is needlessly wasteful.
> 
> Let cxl_count_regblock() leverage the counting that
> cxl_find_regblock_instance() already does by passing in a sentinel value
> (CXL_INSTANCES_COUNT) that triggers the count to be returned.
> ---
> 
> Otherwise, patch looks good.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Applied with the suggested commit log replacement

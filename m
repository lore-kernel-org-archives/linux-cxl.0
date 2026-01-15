Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC426D4C7
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511307; cv=none; b=ZiarlZAgCJyA1H/y5atOI29kCadtngbky3d096H3U9NSt2Yynb02+SnVYpClI3+CBeGmLgAJL/8Ir26jQX6/fCeUytPCvuj6MGcB0Un0ZQCzG6n1naICsVwgvK/yzN7DbJFC9IG7mek7SjJUbZ3c9ywgFjUbr6YfVKMOBVfXB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511307; c=relaxed/simple;
	bh=1BAev6mnSYWGXL5MwS/oVOhoEVQz9Z9AH9rol8ZrLJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuohtjJAjfkQq+Tlg+A1W00mlRysuQMRyfvxbC5jAfuoKrE4UeUccHJT1eW3tglW2esFbvAioUlFsI9S+MP0TocwryQtwYMHD4gbKOUZSLN/VKvFRaM/bOnIZ/A5MCZO+802xRmTYggsn5c2253KJDy/DpFYy5sgcs56b4soRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNdiFWgH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNdiFWgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768511306; x=1800047306;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1BAev6mnSYWGXL5MwS/oVOhoEVQz9Z9AH9rol8ZrLJI=;
  b=WNdiFWgHsLPZHQH/zcD1Z8LJHTyjL8ul1k14h/8jwC6eHNtAR6b/mzWe
   9tKDrOP5rcd7p68+D/BiGtDew8+XVeF59EpvuAKp06h7EcWbuNo/XWvht
   Yk55Iebfe5F86kKQy7mQEvhiT4phAPdK4twudca6v/UvNF1vmBmOKP3Fk
   lBwYyNr/tlkd7YDq5jj8pKh5lai2Moc7WjLj0WQrvNpiz0O7IH7wpRqPC
   V+mcU68DzbAJ2XcwZRMe80dYFnaSfUHDzPjgNoEumfrxoh0Xbutiq7X/z
   vVXbQQ2E+3zoKGqunU15cxp/ErgpbqUbH4WQz9YetWk7iffUTAF1AWWVB
   g==;
X-CSE-ConnectionGUID: H8PtIOd8S6ac9acZiRz5cg==
X-CSE-MsgGUID: /aDaywUFR/SttsZPCsc+Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="81192322"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="81192322"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 13:08:25 -0800
X-CSE-ConnectionGUID: Lo8CL3AtRe2wU2l0/ufo4A==
X-CSE-MsgGUID: cRMbz2GRR720xOWPoLwh5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="209539283"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.80]) ([10.125.111.80])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 13:08:24 -0800
Message-ID: <e28a9863-2307-4ea8-93c0-f9a50a24334b@intel.com>
Date: Thu, 15 Jan 2026 14:08:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] cxl/region: Support unaligned address translations
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1768504636.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <cover.1768504636.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 1:08 PM, Alison Schofield wrote:
> Changes in v5:
> - s/reg_ways/region_ways in decode_pos (DaveJ)
> - Add comments in decode_pos
> - Update the CXL spec references to 4.0
> - Unit test at https://lore.kernel.org/nvdimm/20260115200241.522809-1-alison.schofield@intel.com/
> 
> Changes in v4:
> - Rebased Patch 1 onto 6.19-rc4 with minimal conflict.
> - Added Patch 2 because 6.19 introduced poison by region offset
>   meaning that too needed support for unaligned regions.
> 
> Changes in v3:
> - Add bracketing to avert possibly uninitialized usage (lkp)
> - Remove excessive narration in decode_pos()  (Jonathan)
> - Calculate devices_per_hb only once after switch in decode_pos() (Jonathan)
> - Reduce scope of hpa and shifted in unaligned_dpa_to_hpa() (Jonathan)
> - Unmix non- and assignment declarations in unaligned_dpa_to_hpa()  (Jonathan)
> - Add blank line after return ULLONG_MAX in unaligned_dpa_to_hpa() (Jonathan)
> - s/index/position in for loop in unaligned_dpa_to_hpa() (Jonathan)
> - Initialize bool aligned true
> - Comment that restore_parent() math relies on power-of-2 granularity
> - Tidy-up the restore_parent() comment block
> 
> Changes in v2:
> - Add 6 and 12 Host Bridge interleaves to decode_pos() (Jonathan)
> - Limit the unalignment check to MOD3 regions
> - Move the cache_size increment to a single place 
> - Updated some in code comments
> - Rebase on v6.18-rc1 
> 
> Changes in v1 (was RFC):
> - Replace "/" with do_div() to quiet i386 build warning (lkp)
> - Replace 'cxld->interleave_ways' with 'hbiw' for clarity
> - Use div64_u64_rem() for alignment alignment
> - Fix up a printk format specifier (lkp)
> - Update code comments and commit log
> - Rebase on v6.17-rc7
> 
> 
> Begin Cover Letter: 
> With the introduction of MOD3 interleave way support, platforms may
> create regions at starting addresses that are not power-of-2 aligned.
> This allows platforms to avoid gaps in the memory map, but addresses
> within those regions cannot be translated using the existing bit
> manipulation method.
> 
> Introduce support for translating these unaligned addresses.
> 
> Alison Schofield (2):
>   cxl/region: Translate DPA->HPA in unaligned MOD3 regions
>   cxl/region: Translate HPA to DPA and memdev in unaligned regions
> 
>  drivers/cxl/core/region.c | 212 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 204 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb

Series applied to cxl/next
7af987b3f875
9582b6a47ef8



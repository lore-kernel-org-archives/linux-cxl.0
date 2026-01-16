Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2431533ADB2
	for <linux-cxl@vger.kernel.org>; Fri, 16 Jan 2026 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579180; cv=none; b=XwQwS71D9Zy9HpClW/I295xbc+/S51PvHPuSYJ8Tf17T5a9budhZT2p9HEKFDQ4acrQLgYZpqYjnNESEvuHLzgJSvh1jjcpAKk4wpl9pTMGUHoiIY0Fo8c7RTCa5Jr2ly43YrbUWh24bcYZWfAhksJhEOf9PhVzN3xhjNcNkEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579180; c=relaxed/simple;
	bh=mV1SSNisYv2X2fCKVonZQk8Bt0JGbccCeWYbH8f9m1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XigSB9TEuBtl6VWriTaL6PgbTMudlSmZ+WKSf35JoCgttvTSidy01L52Z4X6NP7r2JfT2/5RLatc4AvIyeLmB+OY0FCTqkAkFMxVwIKdxTBkv3IJoGFPyZPfrtK9drwYK+9vxy8OhtqonMjiO0UbPxE9DIWcWrzGKtfXEERDhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OReK3jmN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OReK3jmN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768579179; x=1800115179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mV1SSNisYv2X2fCKVonZQk8Bt0JGbccCeWYbH8f9m1g=;
  b=OReK3jmNo1hvhxJVzun9n1DJpU1BIgMuKqV9X8pzusJDQ5HKX8sGCY1M
   8CnbuHYAZKYPtHmrQGiRj/HR9NxbndapaYN8v5XQOZtIvruNcX8n+OCVd
   3ztuC4+6MSGIkuPFS3DwHV46lFUxd0Lmsc2H8l9zI2QejOuuAkMBTdYYM
   6IMVo1jWiHDY/E+5Fsqr/hg9znZRFngVMbz/TQRbBQhgbXtCp/IhL8IuK
   dFzQZL12DMVTkW0WUMe9eh73lGsJ480Sst43udx06jBqYZRTFGg5HyuXg
   h5TNAMpe/wvrTuJom8sJcoRJQwyn31myHy+MkDnTRYwW8YpyyMnwga4aa
   A==;
X-CSE-ConnectionGUID: 8IgkARW1RdicED81lVP4hQ==
X-CSE-MsgGUID: 9mV9/QdARqWh9kkl809Nsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69096634"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="69096634"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 07:59:38 -0800
X-CSE-ConnectionGUID: bDgbdEMTQw6b2QqinEE3mg==
X-CSE-MsgGUID: 9BxtXjRtTumMUJG4NZE//w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="204883081"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.140]) ([10.125.111.140])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 07:59:38 -0800
Message-ID: <d5009511-496f-4e82-8692-5307f468ca88@intel.com>
Date: Fri, 16 Jan 2026 08:59:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] cxl/region: Support unaligned address translations
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1768538962.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <cover.1768538962.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 9:58 PM, Alison Schofield wrote:
> Changes in v6: 
> - Replace 64-bit division operators with div64_u64() helpers (lkp)
> 
> Changes in v5:
> - s/reg_ways/region_ways in decode_pos (DaveJ)
> - Add comments in decode_pos
> - Update the CXL spec references to 4.0
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

Reapplied to cxl/next
19885bd10755b9f737742fef8a14cbf554cd84e8
78b50b5984629d362f826e9615ce4599f429716e



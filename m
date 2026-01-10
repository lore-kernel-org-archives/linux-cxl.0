Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3BE54B
	for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768004051; cv=none; b=tiNgKDAXdQiGUxqFFIWtXZusDyc4PHQznuc/++qWmRiGFegkmeQFgPW+FTwIktqaf38FGQeSc9PqW07LZCKK1jGhvOdvWFtbeXUzMThfgj11XMtN6ildkEt6eC32iDITZ+lC1z6RjPxTHqS7Qtx8LD+df6J3QJXxglEa3CLtK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768004051; c=relaxed/simple;
	bh=qpMhx8hS0YMNZyIVRDM0PF59fwB90B5wyHfkGF+3i7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSJuGWGeVx/8R7zm0Pfw+rxRiT51BnHbFovXcYq3bDtcFBd3wk8A3NFnlxGRUPcPWjF8husYqV5NSX3RRWyPSSCd2ZKN8yO5X6ezPmEnYXpWpb5mSc8nDXtaNWahGactPoPXvDzxnGbR+TdBvRxlEmrkeLdhO5R4CyKhW+IqJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5n82BvE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5n82BvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768004050; x=1799540050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qpMhx8hS0YMNZyIVRDM0PF59fwB90B5wyHfkGF+3i7A=;
  b=i5n82BvE5ljbXxKS09TkN0dfWwMqEqiiF8pAEHXY0/tuAINFO5iXgdwO
   iVuM2CH8bXSzORFVvYQmytHo2t2cfUoK8sCYmJfF8OpIhXVxb8ypMzQkU
   QRgMkqG3zAB0AY7SOorz3dUc3Yvi3UwdO9jiRvLZX/t4kqc5uZc2366PS
   CnVwN1Ns1rY35RqSqtrUzEp3808Z0xdoqPXAZVJpqSgFVHR1aACQDZGDC
   ofzo7tPXlENmyBErpM3lR9DgxJjqRUm94Mromre2TFUupg0aA0zJPlQek
   lHvslLS38bCum3+RCPqzZBnXKMSW5EehX7KSCc2mpD9eLQ+ySQh5YQtWq
   w==;
X-CSE-ConnectionGUID: 8+4uIuKERmiCjguLrvPlkQ==
X-CSE-MsgGUID: zZoXySQHRt2WSCkYcc3wgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="80837763"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="80837763"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 16:14:10 -0800
X-CSE-ConnectionGUID: Z/YCqilQRTebMXzEOhnt7g==
X-CSE-MsgGUID: DpN6O6NWQnitffWDz7tRmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="234796593"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.37]) ([10.125.110.37])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 16:14:08 -0800
Message-ID: <538dacbb-97c8-4907-b97b-024bcf5b2694@intel.com>
Date: Fri, 9 Jan 2026 17:14:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: Restore HBIW check before dereferencing
 platform_data
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20260109194946.431083-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260109194946.431083-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 12:49 PM, Alison Schofield wrote:
> Commit 4fe516d2ad1a ("cxl/acpi: Make the XOR calculations available
> for testing") split xormap handling code to create a reusable helper
> function but inadvertently dropped the check of HBIW values before
> dereferencing cxlrd->platform_data. When HBIW is 1 or 3, no xormaps
> are needed and platform_data may be NULL, leading to a potential NULL
> pointer dereference.
> 
> Affects platform configs using XOR Arithmetic with HBIWs of 1 or 3,
> when performing DPA->HPA address translation for CXL events. Those
> events would be any of poison ops, general media, or dram.
> 
> Restore the early return check for HBIW values of 1 and 3 before
> dereferencing platform_data.
> 
> Fixes: 4fe516d2ad1a ("cxl/acpi: Make the XOR calculations available for testing")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/fixes
49d106347913201b6bc6d810c964b90781db8343

Changes small enough and looks reasonable. Would like to get the fixes PR sent in time for rc6 next week.

> ---
> 
> This bug was introduced in 6.19-rc1 and found while rebasing this
> work: cxl/region: Translate DPA->HPA in unaligned MOD3 regions.
> Adding coverage for this to cxl-test suite is on my todo list.
> 
>  drivers/cxl/acpi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 77ac940e3013..49bba2b9a3c4 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -75,9 +75,16 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_do_xormap_calc, "cxl_translate");
>  
>  static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
>  {
> -	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> +	int hbiw = cxlrd->cxlsd.nr_targets;
> +	struct cxl_cxims_data *cximsd;
>  
> -	return cxl_do_xormap_calc(cximsd, addr, cxlrd->cxlsd.nr_targets);
> +	/* No xormaps for host bridge interleave ways of 1 or 3 */
> +	if (hbiw == 1 || hbiw == 3)
> +		return addr;
> +
> +	cximsd = cxlrd->platform_data;
> +
> +	return cxl_do_xormap_calc(cximsd, addr, hbiw);
>  }
>  
>  struct cxl_cxims_context {
> 
> base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb


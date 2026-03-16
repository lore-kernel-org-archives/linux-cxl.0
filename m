Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF218DF80;
	Mon, 16 Mar 2026 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684684; cv=none; b=PcvDXsNnhMlTEkmylJDIZ3+a6nVcfqJa6iKxLayz3cAIW1TCUu3SbKzTTmmiXIBNWLzEU7g4lXverku7lY+/fKRAuV8u2bOtJsOIs+oSRavOQ2XRM6qniZDryWWEJrp/t63D1RldOzNris73GnF/rfNHN0j4M7NnAunvsvO+3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684684; c=relaxed/simple;
	bh=8+44uTrQ/29p3/qLO8+PYa00EGkhNU+tpwb+3NXcZkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0H/O1Rp7HVYGgpkVjWVaWpBEVDouigsFyx0yLpjs5kzk7wyG858OZ8Xi8GrPoJrxvoS5vWklMmmNjN5yTJNmQolt+SUMx9YV8vuWvQKQmYABJO8UjD4VdW3Vxun2MGZpB2pPHV0VYizGsRyKhrFBNZz0r93F/a8d00UGGTsEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDQezc0I; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDQezc0I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773684683; x=1805220683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8+44uTrQ/29p3/qLO8+PYa00EGkhNU+tpwb+3NXcZkY=;
  b=BDQezc0IOwp9tAUG6jtf7pj3UwOOZ4sT8E/wCG74FtamDy3V2ycYHnJE
   Www5vRiFj2mM70SkxWLo8vrFrLxHc6vi0aHoDv4mUj/voI5B3VED7nrtq
   gVF1+tZSvkKVGlmBXR0rw1YAVjx3imp4PcwiBQSoB2ACmDDALtMdXEQ2j
   iUQDihQNPd2rYx23GBQCfLJvTPAhwX9GQZKvsLIXg1XedfKysCb+4poSN
   q/6iylIltVxWVoIQu9+P9+M4Nm5XEM48l6jKShh1p5khWXCbzSIs+fVai
   i5U+AiR95k3SH99EkToupHjjagU0wWMXL4I1AstWgutnnOuAyfDgAQMXA
   A==;
X-CSE-ConnectionGUID: BzpMdsMtTSqG8OpWHEWYbw==
X-CSE-MsgGUID: mSx0DWCWQS+adACH4shH8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74682284"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74682284"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:11:22 -0700
X-CSE-ConnectionGUID: jDrCcEmZSQ+dhyKK0eIG2w==
X-CSE-MsgGUID: pOUoKrK+SRefxNck8RT8+A==
X-ExtLoop1: 1
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.124.223.96]) ([10.124.223.96])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:11:21 -0700
Message-ID: <9f941964-446b-4563-957b-7cc5f69a004b@intel.com>
Date: Mon, 16 Mar 2026 11:11:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is
 on
To: Kai Huang <kai.huang@intel.com>, rafael@kernel.org, lenb@kernel.org,
 dan.j.williams@intel.com, alison.schofield@intel.com
Cc: akpm@linux-foundation.org, nunodasneves@linux.microsoft.com,
 xueshuai@linux.alibaba.com, thorsten.blum@linux.dev, gourry@gourry.net,
 wangyuquan1236@phytium.com.cn, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260308222313.14014-1-kai.huang@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260308222313.14014-1-kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/8/26 3:23 PM, Kai Huang wrote:
> On CXL platforms, the Static Resource Affinity Table (SRAT) may not
> cover memory affinity information for all the CXL memory regions.  Since
> each CXL memory region is enumerated via a CXL Fixed Memory Window
> Structure (CFMWS), during early boot the kernel parses the CFMWS tables
> to find all CXL memory regions and sets a NUMA node for each of them.
> This memory affinity information of CXL memory regions is later used by
> the CXL ACPI driver.
> 
> The CFMWS table doesn't provide the memory affinity information either.
> Currently the kernel assigns a 'faked' NUMA node for each CXL memory
> region, starting from the next node of the highest node that is
> enumerated via the SRAT.  This can potentially increase the maximum NUMA
> node ID of the platform ('nr_node_ids') a lot.  E.g., on a GNR platform
> with 4 NUMA nodes and 18 CFMWS tables, this bumps the 'nr_node_ids' to
> 22.
> 
> Increasing the 'nr_node_ids' has side effects.  For instance, it is
> widely used by the kernel for "highest possible NUMA node" based memory
> allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
> related system calls such as 'get_mempolicy' which requires 'maxnode'
> not being smaller than the 'nr_node_ids'.
> 
> Currently parsing CFMWS tables and assigning faked NUMA node at boot is
> done unconditionally.  However, if the CXL ACPI driver is not enabled,
> there will be no user of such memory affinity information of CXL memory
> regions.
> 
> Change to only parsing the CFMWS tables at boot when CXL_ACPI is enabled
> in Kconfig to avoid the unnecessary cost of bumping up 'nr_node_ids'.
> 
> E.g., on the aforementioned GNR platform, the "Slab" in /proc/meminfo is
> reduced with this change (when CXL_ACPI is off):
> 
> 	w/ this change		w/o
> 
> Slab	900488 kB		923660 kB
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Applied to cxl/next
1e1cd49ded59 ("ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on")

> ---
> 
> v1 -> v2:
> 
>  - Use Dan's suggestion to simplify the diff:
> 
>  https://lore.kernel.org/linux-cxl/69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch/
> 
> Hi Alison, Gregory,
> 
> I didn't add your RB since the code now is different from that you
> reviewed.  Appreciate if you can take a look again and provide the tag
> if the patch looks good to you.
> 
> ---
>  drivers/acpi/numa/srat.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index aa87ee1583a4..62d4a8df0b8c 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -654,8 +654,11 @@ int __init acpi_numa_init(void)
>  	}
>  	last_real_pxm = fake_pxm;
>  	fake_pxm++;
> -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> -			      &fake_pxm);
> +
> +	/* No need to expand numa nodes if CXL is disabled */
> +	if (IS_ENABLED(CONFIG_CXL_ACPI))
> +		acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> +				      &fake_pxm);
>  
>  	if (cnt < 0)
>  		return cnt;
> 
> base-commit: 084f843093bee5563b179fd4b630122ba820e0c7


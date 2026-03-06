Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1E36A02E
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810609; cv=none; b=GsqAFbm9verWNH0/W5Y2Tg2dh9dxUH4uQcALc+H63gTV1VRSXe4A4cQ2c+VR/dbXkB4Lzy1dwsHDS/9EQnP1NIi+AlS0PX25UYdyyiyN4tVf3hbg2cagiLL/9gfCAPYNQ1Pfb+YTUKlWThlT/cX8095eiBG5+OqnFz2PFYCfC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810609; c=relaxed/simple;
	bh=aj0/ilNPb+B+dBUatXVCMfhxcYfIkgGmm2EtSElfs7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2h/phXJkwKuCsJPvVAWWxGRy2X0T7oG/sF+2M+/l0S4As3G6KYtlxtoYuZ7makQrZWWAXRitwnSYm1AjJ4J3zZnpf0KI4OTxmClTEDdzI+CkjUUDyifwbOc/1CU2zm92D9dnli5pBWAARZeJB+cdiPX9QPIM1viwF2+VmLH61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjtLCFUR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjtLCFUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772810604; x=1804346604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aj0/ilNPb+B+dBUatXVCMfhxcYfIkgGmm2EtSElfs7U=;
  b=TjtLCFURML5UXhFamKdTdTHhOVjYFi7ucADVcvcOwA8Lj+vvUbirTXf+
   yYJNBSqyhgBrpsik03zasOf4ZKmpoOU8vaCVAYbE+ZUvPUheZVMKZHk1A
   +eUtvk72ey+RsOtaG4UWfWcNFRNDQG81AiXu19G90+i5+GxRg6qSLNYzy
   C7f1TsjNY2S+h1k3U27uCsGKH1TzMvcWahd1cA3CCvVkidxv2AZ7NOXCd
   t6x3Ef9cKYdK/kM4iam2HPsBNSQGxWz7gYhogxWmGbwOLNcx1/kzNoFfs
   XxcN8eL3d/59Ku+6oz4h2Iaee+4galFyxDnfwTw95ZDOYpWouyd5RZ6a9
   Q==;
X-CSE-ConnectionGUID: Q1bNWe1AT/Ow7N899KQicA==
X-CSE-MsgGUID: 0JyS99z5RbSXBw402RHZLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73115149"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73115149"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 07:23:23 -0800
X-CSE-ConnectionGUID: BNng22yYSJG+Vh25yrmXfQ==
X-CSE-MsgGUID: YmLlSk/6TJy54XS9lmej3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="223736362"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.87]) ([10.125.109.87])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 07:23:23 -0800
Message-ID: <2445a38e-4936-4489-91e0-47c26079f4bf@intel.com>
Date: Fri, 6 Mar 2026 08:23:21 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate
 mismatch
To: Keith Busch <kbusch@meta.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, gourry@gourry.net,
 Keith Busch <kbusch@kernel.org>
References: <20260305204057.1516948-1-kbusch@meta.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260305204057.1516948-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/26 1:40 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Commit e7e222ad73d9 moves devm_cxl_add_nvdimm_bridge() into the cxl_pmem
> file, which has independent config compile options for built-in or
> module. The call from cxl_acpi_probe() is guarded by
> IS_ENABLED(CONFIG_CXL_PMEM), which evaluates to true for both =y and =m.
> 
> When CONFIG_CXL_PMEM=m, a built-in cxl_acpi attempts to reference a
> symbol exported by a module, which fails to link. CXL_PMEM cannot simply
> be promoted to =y in this configuration because it depends on LIBNVDIMM,
> which may itself be =m.
> 
> Add a Kconfig dependency to prevent CXL_ACPI from being built-in when
> CXL_PMEM is a module. This contrains CXL_ACPI to =m when CXL_PMEM=m,
> while still allowing CXL_ACPI to be freely configured when CXL_PMEM is
> either built-in or disabled.
> 
> Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Applied to cxl/fixes
93d0fcdddc9e7be9d4f42acbe57bc90dbb0fe75d

> ---
>  drivers/cxl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 4589bf11d3fe0..80aeb0d556bd7 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -59,6 +59,7 @@ config CXL_ACPI
>  	tristate "CXL ACPI: Platform Support"
>  	depends on ACPI
>  	depends on ACPI_NUMA
> +	depends on CXL_PMEM || !CXL_PMEM
>  	default CXL_BUS
>  	select ACPI_TABLE_LIB
>  	select ACPI_HMAT


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB92417D9;
	Mon,  3 Nov 2025 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212884; cv=none; b=EZii9nAi+97AkQr4eFDDxzYM+GKZndjgetW5J4U34bQC3gm8st/WaerGwL+rwnIMZzjCU5BjXVWodBZaxfzQLPHAtXjUooMEem3ApH7dVQTe02xrClfEhjP0JvcS+jLSKZUP+2NsuifsHcfZ9YUlyFEEjVMvS/WRtQuiwemEJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212884; c=relaxed/simple;
	bh=IhpxRbrczZDx4iR7wevjPZO+hVuDM7MnIM31bqzk/Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqJdeXApkSn0mjo5Ll73nS7vIKyemPDfu6dq6sz0+ObIioSWClxegjcRtB143fWhtJfGDNfpcIRHaa0SsEybHAnSO3ZNaCBzq5petvzxjb1nhnq6PIVVTE55F720nmnhLNFWR5Lvigz4Vp2CalLybNSG7eCOe3PIIIVddr5jAqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsbjfGAo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsbjfGAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762212883; x=1793748883;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IhpxRbrczZDx4iR7wevjPZO+hVuDM7MnIM31bqzk/Mo=;
  b=HsbjfGAox1MzGVQp85bwFsBYfcZ7SbBQJwX7qr+1qDJWWVMkp02XOtdH
   StihCcjgRO/MezgPMFNXQ2b7RjJ8sCNB5+4Q1KwclT1tJGeqyj5q7R2a9
   jq7mZ7tPi/LmSHMreUENn5bbInUjRWae5FlNAHfv0rgTHIj3NVyNubGn7
   T069+ypTnEbNRLmbiGS2YRf/SZNjDaLV8snwtuID9vtOOhDbaT6/YPrHI
   5YPu/eT3FF0RUTEM1rg2JMQhsnskSWG5Lr1se1GW79a/CLedtu5iSbT38
   Qw3BpQBrgEmtMlWHSX2lLTKMbIwE/XSt5FJip0Rb924uNY5Fxi21I/fRG
   Q==;
X-CSE-ConnectionGUID: Vp8jCxagQ1CG0VWsD3QDdQ==
X-CSE-MsgGUID: E/hEI1GwRS+q79o8Ar8VTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="68159161"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="68159161"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:34:42 -0800
X-CSE-ConnectionGUID: C0Y+4Dz+TxGVzu+8ZdDUQg==
X-CSE-MsgGUID: 8d6c9c99Rsyx8YdbfFw6zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186677042"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:34:41 -0800
Message-ID: <20123ac5-62a2-4073-bcd5-64634ca564e9@intel.com>
Date: Mon, 3 Nov 2025 16:34:40 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] cxl/acpi: Prepare use of EFI runtime services
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-10-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251103184804.509762-10-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 11:47 AM, Robert Richter wrote:
> In order to use EFI runtime services, esp. ACPI PRM which uses the
> efi_rts_wq workqueue, initialize EFI before CXL ACPI.
> 
> There is a subsys_initcall order dependency if driver is builtin:
> 
>  subsys_initcall(cxl_acpi_init);
>  subsys_initcall(efisubsys_init);
> 
> Prevent the efi_rts_wq workqueue being used by cxl_acpi_init() before
> its allocation. Use subsys_initcall_sync(cxl_acpi_init) to always run
> efisubsys_init() first.
> 
> Reported-by: Gregory Price <gourry@gourry.net>
> Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/acpi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 1ab780edf141..a54d56376787 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -996,8 +996,12 @@ static void __exit cxl_acpi_exit(void)
>  	cxl_bus_drain();
>  }
>  
> -/* load before dax_hmem sees 'Soft Reserved' CXL ranges */
> -subsys_initcall(cxl_acpi_init);
> +/*
> + * Load before dax_hmem sees 'Soft Reserved' CXL ranges. Use
> + * subsys_initcall_sync() since there is an order dependency with
> + * subsys_initcall(efisubsys_init), which must run first.
> + */
> +subsys_initcall_sync(cxl_acpi_init);
>  
>  /*
>   * Arrange for host-bridge ports to be active synchronous with


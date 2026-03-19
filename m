Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F138758C;
	Thu, 19 Mar 2026 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958894; cv=none; b=NVAsXM8xDfp4B4BdaEPHT9g5sfoujg1lpYZ1nqfLILChacKWOElkQ+saFq/VjKwYiZzUHQLhaDJYHaSEhRuymg/taQxiRKnP9OIa3ZuU/Gg2wPi2xeVoph3luyWaS+ptct1K7lnKtth5ZT0XTk9dCE+x5sqKcAgyi0lcnnEwVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958894; c=relaxed/simple;
	bh=3DS+zC2KjBd0iOWOb7mIM4EW3IED9aT88du9+vbDKlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTkO/N8C9LUzLzDOose4PrJybPHAb542HS3bzJcMrnLnRG5g8rKt8BZKdadaMeIAkHQRiEm/OGNCn4JQxdMu9Get3wBYROcLe+HGXOiwdBIHQzbbuXkuLpHJKJ29DXeg+H9gO8LOLsneGQqpuQiStdd2muY1LhJ8wuFYBcdBuuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoYkmYZy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoYkmYZy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773958892; x=1805494892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3DS+zC2KjBd0iOWOb7mIM4EW3IED9aT88du9+vbDKlA=;
  b=SoYkmYZy2p8kiw83qzio6Zli9wtStG5YL7C3qCGDHmVrj3JgQspzFzqt
   ZDMc/2d3+c9PVM9NhGd+5yH/trDwJ//ANOIVuEGJQVEwzf2wnTs+wabpQ
   1TJ3V8i2e1PwxFprFSnkRGMt6Oxck2g5vd9dz9VYH61YmDW1KMwdBPP7k
   RAh2g7hNlfjCIkbiwUpJXziy9sBrzFx7UW7YE7aFfFKsqkCjFdU03lr6b
   6gzJqN1TY6rSZsK4Ym5P0plMSvwhaGizI6BqHUfY3I7NHrX6hy+1Pq8uT
   7FIrhjH6jVPByHKDPLcI84xluOZOm6wu/ZT1BGuv0tKIOpu1FyrlzhWAx
   w==;
X-CSE-ConnectionGUID: F2lw6RdcRU6a4E2AYKcG3w==
X-CSE-MsgGUID: NQAOhaslRh2j3iU359Dqlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="92426996"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="92426996"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 15:21:31 -0700
X-CSE-ConnectionGUID: Xbp/1TUrRHqV9z2PtHIHew==
X-CSE-MsgGUID: sieDk0WuSvKWWRJqbSom2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227232903"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.49]) ([10.125.109.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 15:21:30 -0700
Message-ID: <9584a54c-0776-4b69-836d-92b231529422@intel.com>
Date: Thu, 19 Mar 2026 15:21:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Adjust the startup priority of cxl_pmem to be higher
 than that of cxl_acpi
To: Dan Williams <dan.j.williams@intel.com>,
 Cui Chao <cuichao1753@phytium.com.cn>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wang Yinfeng <wangyinfeng@phytium.com.cn>
References: <20260319074535.1709250-1-cuichao1753@phytium.com.cn>
 <69bc5f248b90f_7ee310023@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <69bc5f248b90f_7ee310023@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/26 1:40 PM, Dan Williams wrote:
> Cui Chao wrote:
> 
> Hi Cui, this looks good, a few notes below.
> 
>> During the cxl_acpi probe process, it checks whether the cxl_nvb device
>> and driver have been attached. Currently, the startup priority of the
>> cxl_pmem driver is lower than that of the cxl_acpi driver. At this point,
>> the cxl_nvb driver has not yet been registered on the cxl_bus, causing
>> the attachment check to fail. This results in a failure to add the root
>> nvdimm bridge, leading to a cxl_acpi probe failure and ultimately
>> affecting the subsequent loading of cxl drivers. As a consequence, only
>> one mem device object exists on the cxl_bus, while the cxl_port device
>> objects and decoder device objects are missing.
>>
>> The solution is to raise the startup priority of cxl_pmem to be higher
>> than that of cxl_acpi, ensuring that the cxl_pmem driver is registered
>> before the aforementioned attachment check occurs.
> 
> Missing:
> 
> Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
> 
>> Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
>> Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
>> Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
>> ---
>>  drivers/cxl/pmem.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
>> index 082ec0f1c3a0..261dff7ced9f 100644
>> --- a/drivers/cxl/pmem.c
>> +++ b/drivers/cxl/pmem.c
>> @@ -554,7 +554,7 @@ static __exit void cxl_pmem_exit(void)
>>  
>>  MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");
>>  MODULE_LICENSE("GPL v2");
>> -module_init(cxl_pmem_init);
>> +subsys_initcall(cxl_pmem_init);
> 
> Yes, this is a problem, but longer term I do not think we want to get
> into this game of different initcall levels for different modules, and
> dispersing the documentation for all these concerns.
> 
> So I want to match the initcall level of cxl_acpi and move the init
> order management to the Makefile to disambiguate which initialization
> happens first for the same level. There is already some documentation in
> the Makefile about this case.
> 
> This matches what happens with all the other CXL modules that share
> "module_init()", but fallback to Makefile order when built-in.
> 
> Specifically what I am proposing is a patch like below. However, my
> change change is not suitable for v7.0-rc which can take your one-line
> fix. So, for that you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Applied to cxl/fixes
be5c5280cf2b ("cxl: Adjust the startup priority of cxl_pmem to be higher than that of cxl_acpi")

Do you want to submit the patch below for 7.1 cxl/next?

DJ


> 
> ...and then I will follow up to move it to the new proposed scheme:
> 
> -- 8< --
> Subject: cxl: Introduce cxl_subsys_initcall
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Create a single definition of the early initcall expectation
> of the CXL subsystem. Use that single definition to collect all the
> documentation about how to order dependencies both within the subsystem
> (drivers/cxl/Makefile order) and outside the subsystem (producer / consumer
> dependencies).
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/Makefile    |    4 +++-
>  drivers/cxl/acpi.c      |    7 +------
>  drivers/cxl/core/port.c |    2 +-
>  drivers/cxl/cxl.h       |   10 ++++++++++
>  drivers/cxl/pmem.c      |    2 +-
>  drivers/cxl/port.c      |    6 +-----
>  6 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 2caa90fa4bf2..d449bffde205 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -7,6 +7,8 @@
>  # - 'mem' and 'pmem' before endpoint drivers so that memdevs are
>  #   immediately enabled
>  # - 'pci' last, also mirrors the hardware enumeration hierarchy
> +# - 'pmem' before 'acpi' because acpi wants to create cxl_nvdimm_bridge
> +#   devices
>  obj-y += core/
>  obj-$(CONFIG_CXL_PORT) += cxl_port.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> @@ -15,7 +17,7 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>  obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>  
>  cxl_port-y := port.o
> -cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
> +cxl_acpi-y := acpi.o
>  cxl_mem-y := mem.o
>  cxl_pci-y := pci.o
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..6d158c7b6ca7 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -995,12 +995,7 @@ static void __exit cxl_acpi_exit(void)
>  	cxl_bus_drain();
>  }
>  
> -/*
> - * Load before dax_hmem sees 'Soft Reserved' CXL ranges. Use
> - * subsys_initcall_sync() since there is an order dependency with
> - * subsys_initcall(efisubsys_init), which must run first.
> - */
> -subsys_initcall_sync(cxl_acpi_init);
> +cxl_subsys_initcall(cxl_acpi_init);
>  
>  /*
>   * Arrange for host-bridge ports to be active synchronous with
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0c5957d1d329..aca31cdbc5a3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2549,7 +2549,7 @@ static void cxl_core_exit(void)
>  	debugfs_remove_recursive(cxl_debugfs);
>  }
>  
> -subsys_initcall(cxl_core_init);
> +cxl_subsys_initcall(cxl_core_init);
>  module_exit(cxl_core_exit);
>  MODULE_DESCRIPTION("CXL: Core Compute Express Link support");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9b947286eb9b..53086757cc56 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -909,6 +909,16 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>  #define module_cxl_driver(__cxl_driver) \
>  	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
>  
> +/*
> + * When built-in, some CXL modules need to load before others, see
> + * drivers/cxl/Makefile for that order.
> + *
> + * CXL has init dependencies with other subsystems. It consumes EFI runtime
> + * services (subsys_initcall), it produces IORES_DESC_CXL for dax_hmem to
> + * consume (device_initcall)
> + */
> +#define cxl_subsys_initcall subsys_initcall_sync
> +
>  #define CXL_DEVICE_NVDIMM_BRIDGE	1
>  #define CXL_DEVICE_NVDIMM		2
>  #define CXL_DEVICE_PORT			3
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 082ec0f1c3a0..d5c5ffc72e17 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -554,7 +554,7 @@ static __exit void cxl_pmem_exit(void)
>  
>  MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");
>  MODULE_LICENSE("GPL v2");
> -module_init(cxl_pmem_init);
> +cxl_subsys_initcall(cxl_pmem_init);
>  module_exit(cxl_pmem_exit);
>  MODULE_IMPORT_NS("CXL");
>  MODULE_ALIAS_CXL(CXL_DEVICE_NVDIMM_BRIDGE);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ada51948d52f..4c1385953801 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -326,11 +326,7 @@ static int __init cxl_port_init(void)
>  {
>  	return cxl_driver_register(&cxl_port_driver);
>  }
> -/*
> - * Be ready to immediately enable ports emitted by the platform CXL root
> - * (e.g. cxl_acpi) when CONFIG_CXL_PORT=y.
> - */
> -subsys_initcall(cxl_port_init);
> +cxl_subsys_initcall(cxl_port_init);
>  
>  static void __exit cxl_port_exit(void)
>  {


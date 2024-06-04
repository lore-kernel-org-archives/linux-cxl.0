Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE201474BE;
	Tue,  4 Jun 2024 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517092; cv=none; b=pwrwXC1GN2SV+PT+aTTYzMVIDlK6nx+u23blofwvDOku8GYkCbmJUcdJRJzgapTIOZaIwPJrNpFvwTpBJ1bFn/qIdDV2oj1akmNWRM3HDBGaR9uF7JPX7CyCWNT2H3bnmTgbxMdMRVNKAio4PARChPDuBUEx9neiMTIxr7lMS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517092; c=relaxed/simple;
	bh=uSwYhDRrOAl/s39iwUUiNHqv2jXHckCtaGmDOi8+Ec4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j88pajpYOe/3KMo4aBjSAtpbYBg1hNHF/DJO+9h5waG4jMqQbtfjpTdTO2TRemqER9Kn+oUP9eKNzYGAzTgExb0hw23l0/fSSnxDLA6QPZtB1dFpLShjjD5QyBErUgY8hKFRS/LlW9WR39dj3ISEV+iQdaBYEiE+0ixLO05HVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VtwKS6f85z6K6Q9;
	Wed,  5 Jun 2024 00:00:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 39A801400D9;
	Wed,  5 Jun 2024 00:04:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 17:04:45 +0100
Date: Tue, 4 Jun 2024 17:04:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] cxl: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240604170445.00005c67@Huawei.com>
In-Reply-To: <20240603-md-drivers-cxl-v1-1-f2940f5c0836@quicinc.com>
References: <20240603-md-drivers-cxl-v1-1-f2940f5c0836@quicinc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 3 Jun 2024 21:48:53 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/core/cxl_core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_mem.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_acpi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pmem.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_port.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

This has been irritating me as well.  Need to do
drivers/perf/cxl_pmu.c at somepoint as well but given that goes through
a different maintainer makes sense to do separately.

Only comment I have is that we should probably strive for more consistency
than you currently have.  Always expand CXL or never do, use
colons consistently, use Support everywhere or nowhere.



> ---
>  drivers/cxl/acpi.c      | 1 +
>  drivers/cxl/core/port.c | 1 +
>  drivers/cxl/mem.c       | 1 +
>  drivers/cxl/pci.c       | 1 +
>  drivers/cxl/pmem.c      | 1 +
>  drivers/cxl/port.c      | 1 +
>  6 files changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 571069863c62..e51315ea4a6a 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -921,6 +921,7 @@ static void __exit cxl_acpi_exit(void)
>  /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
>  subsys_initcall(cxl_acpi_init);
>  module_exit(cxl_acpi_exit);
> +MODULE_DESCRIPTION("CXL ACPI: Platform Support");
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
>  MODULE_IMPORT_NS(ACPI);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 887ed6e358fb..ccaa00cd0321 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2356,5 +2356,6 @@ static void cxl_core_exit(void)
>  
>  subsys_initcall(cxl_core_init);
>  module_exit(cxl_core_exit);
> +MODULE_DESCRIPTION("CXL (Compute Express Link) Devices Support");

Why the expanded version for this one?

I'm not sure Devices really makes sense here, particularly as it
likely a range of other driver will make some use of this core
functionality over time.  Maybe "CXL core" is sufficient?

>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 0c79d9ce877c..1afb0e78082b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -252,6 +252,7 @@ static struct cxl_driver cxl_mem_driver = {
>  
>  module_cxl_driver(cxl_mem_driver);
>  
> +MODULE_DESCRIPTION("CXL: Memory Expansion");

Why does this one get a colon? Also no Support at the end?

>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
>  MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e53646e9f2fb..2c17fcb1b4ee 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1066,5 +1066,6 @@ static void __exit cxl_pci_driver_exit(void)
>  
>  module_init(cxl_pci_driver_init);
>  module_exit(cxl_pci_driver_exit);
> +MODULE_DESCRIPTION("CXL PCI manageability");
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 2ecdaee63021..4ef93da22335 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -453,6 +453,7 @@ static __exit void cxl_pmem_exit(void)
>  	cxl_driver_unregister(&cxl_nvdimm_bridge_driver);
>  }
>  
> +MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");
>  MODULE_LICENSE("GPL v2");
>  module_init(cxl_pmem_init);
>  module_exit(cxl_pmem_exit);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 97c21566677a..5ceff1df60db 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -209,6 +209,7 @@ static struct cxl_driver cxl_port_driver = {
>  };
>  
>  module_cxl_driver(cxl_port_driver);
> +MODULE_DESCRIPTION("CXL Port Support");
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
>  MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240603-md-drivers-cxl-85ac807b9618
> 


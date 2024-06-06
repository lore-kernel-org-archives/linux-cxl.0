Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCA1AD9CD;
	Thu,  6 Jun 2024 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683338; cv=none; b=XEo82gBpmcHgExr2CQT8gJhVs/3XjPQDQqbfekoP/K1uyyswtZftN/L28qCahPLMnPE7lrblH2lqzkKN2CKeDzdEZWmIScXg2KS+AYyyfMo7SY6Qh9Bo2X9R6nI3XcXyyKIke+KaRF6Vxiou+cL0rueiuFEsuxFRdr4L3nOdvx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683338; c=relaxed/simple;
	bh=BrBTZ77UoeB+OHe4E6Sd25A/0q2z7NYbR6O/Hqx1lPs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vp0KCjxAap5md8NKoZjxYOXOtj1TCyOkKYhOE4R9StJbpA8X1MZiZltitJq6wMH8fFTmcaSY8ut+JQcEEbK7lAwkcCjkFIWCXOKdbxXwcpjz8t9QzGzwqonRVxe55N/DJTzrt8ZfDd2CLPcwrXgWrALIvT3jWsd7BvGl8R6lvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vw5pP4gqMz6K6TJ;
	Thu,  6 Jun 2024 22:10:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B434140DB0;
	Thu,  6 Jun 2024 22:15:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 15:15:22 +0100
Date: Thu, 6 Jun 2024 15:15:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] cxl: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240606151521.000018fd@Huawei.com>
In-Reply-To: <362fccea-707f-4430-8da3-8acc6ac5fbe9@quicinc.com>
References: <20240603-md-drivers-cxl-v1-1-f2940f5c0836@quicinc.com>
	<20240604170445.00005c67@Huawei.com>
	<362fccea-707f-4430-8da3-8acc6ac5fbe9@quicinc.com>
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

On Tue, 4 Jun 2024 13:21:52 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> On 6/4/2024 9:04 AM, Jonathan Cameron wrote:
> > On Mon, 3 Jun 2024 21:48:53 -0700
> > Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> >   
> >> make allmodconfig && make W=1 C=1 reports:
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/core/cxl_core.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_mem.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_acpi.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pmem.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_port.o
> >>
> >> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> >>
> >> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>  
> > 
> > This has been irritating me as well.  Need to do
> > drivers/perf/cxl_pmu.c at somepoint as well but given that goes through
> > a different maintainer makes sense to do separately.
> > 
> > Only comment I have is that we should probably strive for more consistency
> > than you currently have.  Always expand CXL or never do, use
> > colons consistently, use Support everywhere or nowhere.  
> 
> I'm going through a bunch of these tree-wide, and usually just copy/paste
> either from existing comments in the .c file or the description of any
> associated Kconfig item.
> 
> >> ---
> >>  drivers/cxl/acpi.c      | 1 +
> >>  drivers/cxl/core/port.c | 1 +
> >>  drivers/cxl/mem.c       | 1 +
> >>  drivers/cxl/pci.c       | 1 +
> >>  drivers/cxl/pmem.c      | 1 +
> >>  drivers/cxl/port.c      | 1 +
> >>  6 files changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> >> index 571069863c62..e51315ea4a6a 100644
> >> --- a/drivers/cxl/acpi.c
> >> +++ b/drivers/cxl/acpi.c
> >> @@ -921,6 +921,7 @@ static void __exit cxl_acpi_exit(void)
> >>  /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
> >>  subsys_initcall(cxl_acpi_init);
> >>  module_exit(cxl_acpi_exit);
> >> +MODULE_DESCRIPTION("CXL ACPI: Platform Support");  
> 
> From Kconfig:
> config CXL_ACPI
>         tristate "CXL ACPI: Platform Support"
OK
> 
> >>  MODULE_LICENSE("GPL v2");
> >>  MODULE_IMPORT_NS(CXL);
> >>  MODULE_IMPORT_NS(ACPI);
> >> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> >> index 887ed6e358fb..ccaa00cd0321 100644
> >> --- a/drivers/cxl/core/port.c
> >> +++ b/drivers/cxl/core/port.c
> >> @@ -2356,5 +2356,6 @@ static void cxl_core_exit(void)
> >>  
> >>  subsys_initcall(cxl_core_init);
> >>  module_exit(cxl_core_exit);
> >> +MODULE_DESCRIPTION("CXL (Compute Express Link) Devices Support");  
> > 
> > Why the expanded version for this one?
> > 
> > I'm not sure Devices really makes sense here, particularly as it
> > likely a range of other driver will make some use of this core
> > functionality over time.  Maybe "CXL core" is sufficient?
> >   
> 
> From Kconfig:
> menuconfig CXL_BUS
>         tristate "CXL (Compute Express Link) Devices Support"

Understood, but that is expanded because it's the first use of
CXL in the make file. Here we have no ordering as across many
files and resulting modules.

"CXL: Core Compute Express Link support"

Would work I think.

> 
> >>  MODULE_LICENSE("GPL v2");
> >>  MODULE_IMPORT_NS(CXL);
> >> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> >> index 0c79d9ce877c..1afb0e78082b 100644
> >> --- a/drivers/cxl/mem.c
> >> +++ b/drivers/cxl/mem.c
> >> @@ -252,6 +252,7 @@ static struct cxl_driver cxl_mem_driver = {
> >>  
> >>  module_cxl_driver(cxl_mem_driver);
> >>  
> >> +MODULE_DESCRIPTION("CXL: Memory Expansion");  
> > 
> > Why does this one get a colon? Also no Support at the end?  
> 
> From Kconfig:
> config CXL_MEM
>         tristate "CXL: Memory Expansion"

OK.  Could add Support but then all code is supporting something,
so fine to leave it without.


> 
> >   
> >>  MODULE_LICENSE("GPL v2");
> >>  MODULE_IMPORT_NS(CXL);
> >>  MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
> >> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> >> index e53646e9f2fb..2c17fcb1b4ee 100644
> >> --- a/drivers/cxl/pci.c
> >> +++ b/drivers/cxl/pci.c
> >> @@ -1066,5 +1066,6 @@ static void __exit cxl_pci_driver_exit(void)
> >>  
> >>  module_init(cxl_pci_driver_init);
> >>  module_exit(cxl_pci_driver_exit);
> >> +MODULE_DESCRIPTION("CXL PCI manageability");  
> 
> Kconfig just has:
> config CXL_PCI
>         tristate "PCI manageability"
> 
> I added CXL

CXL: PCI manageability


> 
> >>  MODULE_LICENSE("GPL v2");
> >>  MODULE_IMPORT_NS(CXL);
> >> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> >> index 2ecdaee63021..4ef93da22335 100644
> >> --- a/drivers/cxl/pmem.c
> >> +++ b/drivers/cxl/pmem.c
> >> @@ -453,6 +453,7 @@ static __exit void cxl_pmem_exit(void)
> >>  	cxl_driver_unregister(&cxl_nvdimm_bridge_driver);
> >>  }
> >>  
> >> +MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");  
> 
> From Kconfig:
> config CXL_PMEM
>         tristate "CXL PMEM: Persistent Memory Support"
OK
> 
> >>  MODULE_LICENSE("GPL v2");
> >>  module_init(cxl_pmem_init);
> >>  module_exit(cxl_pmem_exit);
> >> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> >> index 97c21566677a..5ceff1df60db 100644
> >> --- a/drivers/cxl/port.c
> >> +++ b/drivers/cxl/port.c
> >> @@ -209,6 +209,7 @@ static struct cxl_driver cxl_port_driver = {
> >>  };
> >>  
> >>  module_cxl_driver(cxl_port_driver);
> >> +MODULE_DESCRIPTION("CXL Port Support");  
> 
> This I just made up from the others since config CXL_PORT doesn't have a menu
> description or help text and the .c file begins with:
>  * DOC: cxl port

"CXL: Port Support"

Not that informative, but I can't immediately think of better text.

>
> 
> >>  MODULE_LICENSE("GPL v2");
> >>  MODULE_IMPORT_NS(CXL);
> >>  MODULE_ALIAS_CXL(CXL_DEVICE_PORT);  
> 
> If you have specific edits you'd like me to make, I'm happy to make them.
> I have no opinion on the content -- I just want to get rid of the warnings :)

With the suggestions above it would look more consistent I think.

Jonathan


> 
> /jeff
> 


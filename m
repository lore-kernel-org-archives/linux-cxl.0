Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F871A2390
	for <linux-cxl@vger.kernel.org>; Tue, 29 Jul 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805698; cv=none; b=Z9Xyqh8l5gEbk47x3rDbeCDL2zqEk+KWesn/Yaig94CoiyFI6Td883cBLVfQkJirJNfdVyPMXlKxWezObXnQvaj1TCQKoYv3CiXEgmKAGe7sS/bLBOmtsR3BOCCk/eQLEwWsL6XX9xRy2CwjHTaYJf84s0D/3LcUXu6e2ZeyGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805698; c=relaxed/simple;
	bh=C4LCX9essDK9OvWBFhl/YQU/CejILf0GuyDv17iLu1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcLKUE6fCdFOiTn2i+9v2HS4ApuEoMi9ibvmoqVdI2xtf80iEEthJCpllfblplvnr98+dSMnxlBdDlPCB9FMcjYk8DLCrce0TsZVx2xpTJvgBr+TiZiAwZ3c04Stkr2rgIDuOibRlf4gBgim3/jc5ZL3hEo1dbLU1hR3rQjdDx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrTPqNhY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrTPqNhY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753805697; x=1785341697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C4LCX9essDK9OvWBFhl/YQU/CejILf0GuyDv17iLu1k=;
  b=YrTPqNhYcxBjy+YQNYVez/r3l7u98lTW4/p8bwQt9F2/3KTIVVnhJzaP
   n0dQz+I6bo5WQclYU8c2W5jx95CE1XF8S1LuQdsIpHh/WgOMbjwkttwz2
   jd82igdrTyxpscDaOsRnXvH+wsF/zIhpWWBcWTFoM6K4a5nqlgawX78+q
   XA8D7r2LDUUMEOV5eTji4UrhZlMK1YyZnzdf5sPwTLttyiJAQZEzhGW8Q
   8Kou+1zbY9Uu10P5QjX/KYTUpUWI2/1TUk09oCeDPhhvu9zkP7mr6LN8u
   7SYKrLOqpA84n6saiS+v+BJVX8H8dcs69Nb++D1Knu2baKJO36ocIHzkG
   Q==;
X-CSE-ConnectionGUID: DE9I/JAiTPy/bBkJurTMUw==
X-CSE-MsgGUID: Sztk7pQFR+WBAOL52KsosQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56174348"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56174348"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 09:14:57 -0700
X-CSE-ConnectionGUID: BarYePNBSNCPWsr2HBPcuA==
X-CSE-MsgGUID: ql+4u/nGQX2NVw2BiAFKaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162455040"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.118.247]) ([10.247.118.247])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 09:14:51 -0700
Message-ID: <ab55d537-c873-4997-9cb0-c24f10363565@intel.com>
Date: Tue, 29 Jul 2025 09:14:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 Robert Richter <rrichter@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250725171928.3398136-1-dave.jiang@intel.com>
 <6883e86ff1e44_134cc710062@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6883e86ff1e44_134cc710062@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/25 1:26 PM, dan.j.williams@intel.com wrote:
> Dave Jiang wrote:
>> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
>> the config. The config will depend on CPER or PCIE AER to build.
>> Move the related RAS code from core/pci.c to core/ras.c.
>>
>> Cc: Robert Richter <rrichter@amd.com>
>> Cc: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Gate everything behind CONFIG_CXL_RAS and move to core/ras.c (Dan)
>> - Move the PCI AER handlers to ras.c as well. (Terry)
>> ---
>>  drivers/cxl/Kconfig       |   4 +
>>  drivers/cxl/core/Makefile |   2 +-
>>  drivers/cxl/core/core.h   |   9 ++
>>  drivers/cxl/core/pci.c    | 319 --------------------------------------
>>  drivers/cxl/core/ras.c    | 313 +++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h         |   8 -
>>  drivers/cxl/cxlpci.h      |  16 ++
>>  tools/testing/cxl/Kbuild  |   1 +
>>  8 files changed, 344 insertions(+), 328 deletions(-)
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 48b7314afdb8..6a3895440163 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -233,4 +233,8 @@ config CXL_MCE
>>  	def_bool y
>>  	depends on X86_MCE && MEMORY_FAILURE
>>  
>> +config CXL_RAS
>> +	def_bool y
>> +	depends on ACPI_APEI_GHES || PCIEAER || PCIEAER_CXL
> 
> No need for "|| PCIEAER" because PCIEAER_CXL has "depends on PCIEAER".

ok

> 
>> +
>>  endif
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 79e2ef81fde8..1c652e575aaa 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -14,10 +14,10 @@ cxl_core-y += pci.o
>>  cxl_core-y += hdm.o
>>  cxl_core-y += pmu.o
>>  cxl_core-y += cdat.o
>> -cxl_core-y += ras.o
>>  cxl_core-y += acpi.o
>>  cxl_core-$(CONFIG_TRACING) += trace.o
>>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>> +cxl_core-$(CONFIG_CXL_RAS) += ras.o
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 29b61828a847..ff1a478e690f 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -136,4 +136,13 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>>  		    u16 *return_code);
>>  #endif
>>  
>> +#ifdef CONFIG_CXL_RAS
>> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
>> +#else
>> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) {}
>> +#endif
>> +
>> +void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
>> +bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> 
> No need for any of this, all of these functions can now be marked
> static. Now, it does mean that some of these need to be reordered in the
> file before their first use, but with this patch already doing code
> movement might as well move the code to the right order in the file and
> skip the need to do forward declarations.

ok I'll move those around.

> 
> [..]
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 54e219b0049e..9063134c85d9 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -132,7 +132,23 @@ struct cxl_dev_state;
>>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>  			struct cxl_endpoint_dvsec_info *info);
>>  void read_cdat_data(struct cxl_port *port);
>> +
>> +#ifdef CONFIG_CXL_RAS
>>  void cxl_cor_error_detected(struct pci_dev *pdev);
>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  				    pci_channel_state_t state);
>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>> +#else
>> +static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>> +
>> +static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> +						  pci_channel_state_t state)
>> +{
>> +	return PCI_ERS_RESULT_NO_AER_DRIVER;
> 
> I would have expected PCI_ERS_RESULT_NONE. Not that it matters much. The
> only way this is possible is if AER is turned off, and if AER is turned
> off, this will never be called.

Just figure that if it gets called (not that it will), it would be reasonable to return no driver since the driver is disabled.

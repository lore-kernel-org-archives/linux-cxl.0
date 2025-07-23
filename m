Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF526E714
	for <linux-cxl@vger.kernel.org>; Wed, 23 Jul 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283659; cv=none; b=Xqoe3TDbsA5vfCVroO3Pee2ENS2/pYuAyA4gfYJWzfWvmthM6ISUOofTPoVkmOjn5qj8CCTaq2i3BTLt+J4vzYSlo1/I/DkTEN7YPz0aibxr58ALgnds+R1ZJd0vkMx6TXeaJMkZdG9i+rJephK3nGbXJlODJhQf8CFBRZKR8tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283659; c=relaxed/simple;
	bh=I3QvXWHBRlYe/Ke90soZGyXvwAkojo76Nj+F7oDUKcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrAUAiMo6oqSPd77x89hoVRL/7tDxAuJZd+7I5kTbjKeOHzh7lDSZmr/MMULW4J5Ka5/yKAazQqzD7RRacZpO/nrXhVXZgXuZqYMtaJ2vRNuPqZ0bs/0ZTRaWXzFBg+W0ab6pWWlQF9PrxHsDIsWPtEDTpvEX/9COWJxATwiDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHAeClDv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHAeClDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753283658; x=1784819658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I3QvXWHBRlYe/Ke90soZGyXvwAkojo76Nj+F7oDUKcA=;
  b=gHAeClDvTEHEqYjFLb0JE82JVKGhJAyL015FQ622kfjuka2ynWwEz9cU
   0vJuFDbRU0ii+jU5PXiP4THYBRLczuvTuBp/bniDc224VAO5CuHUygoAf
   7KQbas9Oj6HPiGzAadMJNep4zYCVzafOfJwBUWtpPhKukj6dM293wH0g5
   tmwUnHLrjGPWzyNfKJRqpptWuVXfJrQLwkcMUY7CsBnpbZHaDUSwbtVU5
   xIRXOdomZynJYKo8GALEJpJGjw34TE0KLKpF02dw8DYAkJJv0GG8t8wzs
   eOTbsOCK/AYyuI99jGxEY4GPztjx4vOJqeQ/ZI6gaYmPnKf4436XxU6+P
   Q==;
X-CSE-ConnectionGUID: mlVsu51YQN+ayNU1AlzxPQ==
X-CSE-MsgGUID: 8ES3gmE/SqeqVbfiIrdGxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59374270"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59374270"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:14:16 -0700
X-CSE-ConnectionGUID: 9Kg4M58XTCOdTewJTKoHUA==
X-CSE-MsgGUID: IKqc/lKrRf+ov9Uvy2tcZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="164030545"
Received: from dustinle-mobl1.gar.corp.intel.com (HELO [10.247.118.179]) ([10.247.118.179])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:14:10 -0700
Message-ID: <f1ddcc99-56d1-4887-ad91-714d59b9e9a3@intel.com>
Date: Wed, 23 Jul 2025 08:14:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: "Bowman, Terry" <terry.bowman@amd.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>
References: <20250721170415.285961-1-dave.jiang@intel.com>
 <12646336-9be3-4bc2-adf9-bfd59c589251@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <12646336-9be3-4bc2-adf9-bfd59c589251@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/25 7:55 AM, Bowman, Terry wrote:
> On 7/21/2025 12:04 PM, Dave Jiang wrote:
>> Remove from core/pci_aer.c and move the CONFIG_PCIEAER_CXL ifdef to
>> cxlpci.h to deal with the exported symbols as needed. There is enough
>> AER handling code (and more to come) to move the AER code to its own
>> C file.
>>
>> Cc: Robert Richter <rrichter@amd.com>
>> Cc: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Address 0-day reprot of cxl_handle_rdport_errors symbol undefined
>> ---
>>  drivers/cxl/core/Makefile  |   1 +
>>  drivers/cxl/core/core.h    |   9 ++
>>  drivers/cxl/core/pci.c     | 171 +------------------------------------
>>  drivers/cxl/core/pci_aer.c | 168 ++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h          |   8 --
>>  drivers/cxl/cxlpci.h       |   8 ++
>>  tools/testing/cxl/Kbuild   |   1 +
>>  7 files changed, 189 insertions(+), 177 deletions(-)
>>  create mode 100644 drivers/cxl/core/pci_aer.c
>>
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 79e2ef81fde8..bcea856157af 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
>>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>> +cxl_core-$(CONFIG_PCIEAER_CXL) += pci_aer.o
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 29b61828a847..96c319c66a48 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -136,4 +136,13 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>>  		    u16 *return_code);
>>  #endif
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
>> +#else
>> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) {}
>> +#endif
>> +
>> +void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
>> +bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
>> +
>>  #endif /* __CXL_CORE_H__ */
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index b50551601c2e..bd78369bc3f4 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -664,8 +664,7 @@ void read_cdat_data(struct cxl_port *port)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>>  
>> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>> -				 void __iomem *ras_base)
>> +void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>>  {
>>  	void __iomem *addr;
>>  	u32 status;
>> @@ -707,8 +706,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   * Log the state of the RAS status registers and prepare them to log the
>>   * next error status. Return 1 if reset needed.
>>   */
>> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>> -				  void __iomem *ras_base)
>> +bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>>  {
>>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>  	void __iomem *addr;
>> @@ -746,171 +744,6 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>>  	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
>>  }
>>  
>> -#ifdef CONFIG_PCIEAER_CXL
>> -
>> -static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>> -{
>> -	resource_size_t aer_phys;
>> -	struct device *host;
>> -	u16 aer_cap;
>> -
>> -	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
>> -	if (aer_cap) {
>> -		host = dport->reg_map.host;
>> -		aer_phys = aer_cap + dport->rcrb.base;
>> -		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
>> -						sizeof(struct aer_capability_regs));
>> -	}
>> -}
>> -
>> -static void cxl_dport_map_ras(struct cxl_dport *dport)
>> -{
>> -	struct cxl_register_map *map = &dport->reg_map;
>> -	struct device *dev = dport->dport_dev;
>> -
>> -	if (!map->component_map.ras.valid)
>> -		dev_dbg(dev, "RAS registers not found\n");
>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> -		dev_dbg(dev, "Failed to map RAS capability.\n");
>> -}
>> -
>> -static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>> -{
>> -	void __iomem *aer_base = dport->regs.dport_aer;
>> -	u32 aer_cmd_mask, aer_cmd;
>> -
>> -	if (!aer_base)
>> -		return;
>> -
>> -	/*
>> -	 * Disable RCH root port command interrupts.
>> -	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>> -	 *
>> -	 * This sequence may not be necessary. CXL spec states disabling
>> -	 * the root cmd register's interrupts is required. But, PCI spec
>> -	 * shows these are disabled by default on reset.
>> -	 */
>> -	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>> -			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>> -			PCI_ERR_ROOT_CMD_FATAL_EN);
>> -	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>> -	aer_cmd &= ~aer_cmd_mask;
>> -	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>> -}
>> -
>> -/**
>> - * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>> - * @dport: the cxl_dport that needs to be initialized
>> - * @host: host device for devm operations
>> - */
>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>> -{
>> -	dport->reg_map.host = host;
>> -	cxl_dport_map_ras(dport);
>> -
>> -	if (dport->rch) {
>> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>> -
>> -		if (!host_bridge->native_aer)
>> -			return;
>> -
>> -		cxl_dport_map_rch_aer(dport);
>> -		cxl_disable_rch_root_ints(dport);
>> -	}
>> -}
>> -EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>> -
>> -static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>> -					  struct cxl_dport *dport)
>> -{
>> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
>> -}
>> -
>> -static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>> -				       struct cxl_dport *dport)
>> -{
>> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
>> -}
>> -
>> -/*
>> - * Copy the AER capability registers using 32 bit read accesses.
>> - * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>> - * status after copying.
>> - *
>> - * @aer_base: base address of AER capability block in RCRB
>> - * @aer_regs: destination for copying AER capability
>> - */
>> -static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>> -				 struct aer_capability_regs *aer_regs)
>> -{
>> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>> -	u32 *aer_regs_buf = (u32 *)aer_regs;
>> -	int n;
>> -
>> -	if (!aer_base)
>> -		return false;
>> -
>> -	/* Use readl() to guarantee 32-bit accesses */
>> -	for (n = 0; n < read_cnt; n++)
>> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>> -
>> -	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>> -	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>> -
>> -	return true;
>> -}
>> -
>> -/* Get AER severity. Return false if there is no error. */
>> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>> -				     int *severity)
>> -{
>> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>> -			*severity = AER_FATAL;
>> -		else
>> -			*severity = AER_NONFATAL;
>> -		return true;
>> -	}
>> -
>> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>> -		*severity = AER_CORRECTABLE;
>> -		return true;
>> -	}
>> -
>> -	return false;
>> -}
>> -
>> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>> -{
>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> -	struct aer_capability_regs aer_regs;
>> -	struct cxl_dport *dport;
>> -	int severity;
>> -
>> -	struct cxl_port *port __free(put_cxl_port) =
>> -		cxl_pci_find_port(pdev, &dport);
>> -	if (!port)
>> -		return;
>> -
>> -	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>> -		return;
>> -
>> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>> -		return;
>> -
>> -	pci_print_aer(pdev, severity, &aer_regs);
>> -
>> -	if (severity == AER_CORRECTABLE)
>> -		cxl_handle_rdport_cor_ras(cxlds, dport);
>> -	else
>> -		cxl_handle_rdport_ras(cxlds, dport);
>> -}
>> -
>> -#else
>> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>> -#endif
>> -
>>  void cxl_cor_error_detected(struct pci_dev *pdev)
>>  {
>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> diff --git a/drivers/cxl/core/pci_aer.c b/drivers/cxl/core/pci_aer.c
>> new file mode 100644
>> index 000000000000..cf1e9377752e
>> --- /dev/null
>> +++ b/drivers/cxl/core/pci_aer.c
> 
> 
> 
> Hi Dave,
> 
> While adding this into my series and looking closer, I believe that pci_aer.c filename does not accurately reflect its content. 
> The only AER-related code pertains to CX1.1, which is now a corner case. The AER driver, not CXL driver, logs AER errors for 
> all other scenarios. There is no AER processing in the CXL driver except for CXL1.1 dports.
> 
> Most of the code in this file is related to or will be directed towards CXL RAS. It's important to note that AER and 
> RAS are distinct and separate registers, with CXL RAS only utilizing the AER interrupt notification and UIE/CIE. 
> 
> I am concerned we are conflating AER and RAS, which may be misleading for others. We have other instances of this 
> confusion, such as in the cxl_aer_correctable_error() and cxl_aer_uncorrectable_error() functions, which log RAS instead of AER.
> 
> My series aims to clarify the distinction between AER and CXL errors, categorizing CXL errors as a separate error class. 
> At the least, can we add a documentation block at the top to indicate this source file provides functionality for 
> CXL RAS?

Sure we can do that. Also, we have a core/ras.c already. Any suggestions on how do we want improve this? Move things to ras.c? Rename cxl_aer.c to something else? Rename current ras.c to something else?

> 
> -Terry
> 
>> @@ -0,0 +1,168 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
>> +/* Copyright(c) 2025 Intel Corporation. All rights reserved. */
>> +#include <linux/pci.h>
>> +#include <linux/aer.h>
>> +#include <cxlpci.h>
>> +#include <cxlmem.h>
>> +#include <cxl.h>
>> +#include "core.h"
>> +
>> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>> +{
>> +	resource_size_t aer_phys;
>> +	struct device *host;
>> +	u16 aer_cap;
>> +
>> +	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
>> +	if (aer_cap) {
>> +		host = dport->reg_map.host;
>> +		aer_phys = aer_cap + dport->rcrb.base;
>> +		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
>> +						sizeof(struct aer_capability_regs));
>> +	}
>> +}
>> +
>> +static void cxl_dport_map_ras(struct cxl_dport *dport)
>> +{
>> +	struct cxl_register_map *map = &dport->reg_map;
>> +	struct device *dev = dport->dport_dev;
>> +
>> +	if (!map->component_map.ras.valid)
>> +		dev_dbg(dev, "RAS registers not found\n");
>> +	else if (cxl_map_component_regs(map, &dport->regs.component,
>> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +		dev_dbg(dev, "Failed to map RAS capability.\n");
>> +}
>> +
>> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>> +{
>> +	void __iomem *aer_base = dport->regs.dport_aer;
>> +	u32 aer_cmd_mask, aer_cmd;
>> +
>> +	if (!aer_base)
>> +		return;
>> +
>> +	/*
>> +	 * Disable RCH root port command interrupts.
>> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>> +	 *
>> +	 * This sequence may not be necessary. CXL spec states disabling
>> +	 * the root cmd register's interrupts is required. But, PCI spec
>> +	 * shows these are disabled by default on reset.
>> +	 */
>> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>> +			PCI_ERR_ROOT_CMD_FATAL_EN);
>> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>> +	aer_cmd &= ~aer_cmd_mask;
>> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>> +}
>> +
>> +/**
>> + * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>> + * @dport: the cxl_dport that needs to be initialized
>> + * @host: host device for devm operations
>> + */
>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>> +{
>> +	dport->reg_map.host = host;
>> +	cxl_dport_map_ras(dport);
>> +
>> +	if (dport->rch) {
>> +		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>> +
>> +		if (!host_bridge->native_aer)
>> +			return;
>> +
>> +		cxl_dport_map_rch_aer(dport);
>> +		cxl_disable_rch_root_ints(dport);
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>> +
>> +static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>> +					  struct cxl_dport *dport)
>> +{
>> +	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
>> +}
>> +
>> +static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>> +				       struct cxl_dport *dport)
>> +{
>> +	return __cxl_handle_ras(cxlds, dport->regs.ras);
>> +}
>> +
>> +/*
>> + * Copy the AER capability registers using 32 bit read accesses.
>> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>> + * status after copying.
>> + *
>> + * @aer_base: base address of AER capability block in RCRB
>> + * @aer_regs: destination for copying AER capability
>> + */
>> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>> +				 struct aer_capability_regs *aer_regs)
>> +{
>> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>> +	u32 *aer_regs_buf = (u32 *)aer_regs;
>> +	int n;
>> +
>> +	if (!aer_base)
>> +		return false;
>> +
>> +	/* Use readl() to guarantee 32-bit accesses */
>> +	for (n = 0; n < read_cnt; n++)
>> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>> +
>> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>> +
>> +	return true;
>> +}
>> +
>> +/* Get AER severity. Return false if there is no error. */
>> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>> +				     int *severity)
>> +{
>> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>> +			*severity = AER_FATAL;
>> +		else
>> +			*severity = AER_NONFATAL;
>> +		return true;
>> +	}
>> +
>> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>> +		*severity = AER_CORRECTABLE;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	struct aer_capability_regs aer_regs;
>> +	struct cxl_dport *dport;
>> +	int severity;
>> +
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>> +	if (!port)
>> +		return;
>> +
>> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>> +		return;
>> +
>> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>> +		return;
>> +
>> +	pci_print_aer(pdev, severity, &aer_regs);
>> +
>> +	if (severity == AER_CORRECTABLE)
>> +		cxl_handle_rdport_cor_ras(cxlds, dport);
>> +	else
>> +		cxl_handle_rdport_ras(cxlds, dport);
>> +}
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 3f1695c96abc..73397da7f970 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -759,14 +759,6 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>  					 struct device *dport_dev, int port_id,
>>  					 resource_size_t rcrb);
>>  
>> -#ifdef CONFIG_PCIEAER_CXL
>> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>> -#else
>> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>> -						struct device *host) { }
>> -#endif
>> -
>>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 54e219b0049e..5f73ce42a758 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -135,4 +135,12 @@ void read_cdat_data(struct cxl_port *port);
>>  void cxl_cor_error_detected(struct pci_dev *pdev);
>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  				    pci_channel_state_t state);
>> +
>> +#ifdef CONFIG_PCIEAER_CXL
>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>> +#else
>> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>> +						struct device *host) { }
>> +#endif
>> +
>>  #endif /* __CXL_PCI_H__ */
>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>> index 31a2d73c963f..54b49d8e6b40 100644
>> --- a/tools/testing/cxl/Kbuild
>> +++ b/tools/testing/cxl/Kbuild
>> @@ -68,6 +68,7 @@ cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
>> +cxl_core-$(CONFIG_PCIEAER_CXL) += $(CXL_CORE_SRC)/pci_aer.o
>>  cxl_core-y += config_check.o
>>  cxl_core-y += cxl_core_test.o
>>  cxl_core-y += cxl_core_exports.o
>>
>> base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
> 


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEEB29C351
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586507; cv=none; b=X3mTFeXovy1hcNMQZCmwBdc8/asLtBcZkPnpIppnHC1o6UAjURIWJP3CvxQ6aAEqtkhtgCyCEEwu5SlGJHOomVsNZyyuxT9WjG0skKB2T6pGc/hz17C1mpOodkcpUMqaEhotODswNL6Y+FpqWKu+jyMS72GIAk6TQS1Ez5HPqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586507; c=relaxed/simple;
	bh=PDF3n95eGqyBSfyHPTdME2ngqsMoKAxASyeWq3AoGRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ux21XaIbXdJXzMWCJm8XhagAnUpTR1RhhcynMHeF5hrbJx5ny/A+PCNrPLxFqHebpzuzscrcnaIvTb9J3+aIh/0G+e3wCA0g+wN2Q8RnM0qor/e47t+9qcAYagbVJEah/MpaULhmEiTCoXd0fSstD0IGqLm81+2pf7SG482sjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DL+Ne4gG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DL+Ne4gG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751586505; x=1783122505;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PDF3n95eGqyBSfyHPTdME2ngqsMoKAxASyeWq3AoGRY=;
  b=DL+Ne4gG8fRKXIQGMYRwjYrqU2sV4jzM0kFtRic3OrIXbULOXrgF1AMZ
   rc6Zt7wfh0K68MgCfG5UYVh+gaYCMPzqtNY5X+FadvnjOnSsxgFCgjaiC
   haM2H6t2KJSvHFvxOJKCGm1Nqu+AGHeIUDXSSgOQMvi5hRDnOK3i63X10
   JXWZC5mgy8Y54M92Xmf1hJERbOHRPRlAgHKmfpykkhisOt9UI9zaUBSxb
   aTPe+fUEV+D5BGYXA3vvdxY3hvUwItwzt3esGwwUKBqcLT3dZGGaSZioV
   K/BdMYJf/NDtHjlBHO0S0jdtZn+H8K58wUNKZD0oDkrJI0CgLArhAoBCt
   Q==;
X-CSE-ConnectionGUID: 5IU+giJdT/u0cHYPRv9UFg==
X-CSE-MsgGUID: 6NrOPIAQTauhXMrlOg+JOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="79362131"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="79362131"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 16:48:24 -0700
X-CSE-ConnectionGUID: K+mGyxffS2SGg/dZh6nO8w==
X-CSE-MsgGUID: rCj8pUJuSYKs3N0NYGY8EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="160021401"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.110.32]) ([10.125.110.32])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 16:48:24 -0700
Message-ID: <02deafde-3762-43ff-8eb3-1f32449c851c@intel.com>
Date: Thu, 3 Jul 2025 16:48:21 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl: Remove core/acpi.c and cxl core dependency on
 ACPI
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250610172938.139428-1-dave.jiang@intel.com>
 <aGWcNpaRup9MkFm7@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aGWcNpaRup9MkFm7@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/2/25 1:53 PM, Alison Schofield wrote:
> On Tue, Jun 10, 2025 at 10:29:38AM -0700, Dave Jiang wrote:
>> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
>> cxl_core when adding the extended linear cache support. Add a callback
>> in the cxl_root_decoder to retrieve the extended linear cache size from
>> ACPI via the cxl_acpi driver.
> 
> I see the introduction of struct cxl_rd_ops and am wondering why
> the other existing root decoder callback is not added to that
> new grouping...
> * @hpa_to_spa: translate CXL host-physical-address to Platform system-physical-address
> 
> Seems it can join that _ops group with some updates at the call site.
> BTW - another root decoder callback is in the works for the inverse
> spa_to_hpa, so that'll join your ops group too.

Will create a follow on patch for this.
DJ
> 
> If you don't want to do that now, or it's not a fit, you can add:
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> Otherwise, I'll review and tag a v4.
> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Remove commit log paragraph on adding extra dev parameter. (Jonathan)
>> - Add device ref put. (Jonathan)
>> - Adjust var declaration. (Jonathan)
>> - Move callback assignment to same group. (Jonathan)
>> ---
>>  drivers/cxl/acpi.c            | 13 +++++++++++-
>>  drivers/cxl/core/Makefile     |  1 -
>>  drivers/cxl/core/acpi.c       | 11 ----------
>>  drivers/cxl/core/core.h       |  2 --
>>  drivers/cxl/core/port.c       |  5 ++++-
>>  drivers/cxl/core/region.c     |  5 ++++-
>>  drivers/cxl/cxl.h             | 10 ++++++++-
>>  tools/testing/cxl/Kbuild      |  2 +-
>>  tools/testing/cxl/test/cxl.c  | 40 +++++++++++++++++++++++++++++++++++
>>  tools/testing/cxl/test/mock.c | 19 +++++++++++++++++
>>  tools/testing/cxl/test/mock.h |  3 +++
>>  11 files changed, 92 insertions(+), 19 deletions(-)
>>  delete mode 100644 drivers/cxl/core/acpi.c
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index a1a99ec3f12c..48478bc406ee 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -335,6 +335,17 @@ static int add_or_reset_cxl_resource(struct resource *parent, struct resource *r
>>  	return rc;
>>  }
>>  
>> +static int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>> +						   int nid,
>> +						   resource_size_t *size)
>> +{
>> +	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
>> +}
>> +
>> +static const struct cxl_rd_ops acpi_rd_ops = {
>> +	.get_extended_linear_cache_size = cxl_acpi_get_extended_linear_cache_size,
>> +};
>> +
>>  DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
>>  	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>>  DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
>> @@ -373,7 +384,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>>  		return rc;
>>  
>>  	struct cxl_root_decoder *cxlrd __free(put_cxlrd) =
>> -		cxl_root_decoder_alloc(root_port, ways);
>> +		cxl_root_decoder_alloc(root_port, ways, &acpi_rd_ops);
>>  
>>  	if (IS_ERR(cxlrd))
>>  		return PTR_ERR(cxlrd);
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 79e2ef81fde8..5ad8fef210b5 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -15,7 +15,6 @@ cxl_core-y += hdm.o
>>  cxl_core-y += pmu.o
>>  cxl_core-y += cdat.o
>>  cxl_core-y += ras.o
>> -cxl_core-y += acpi.o
>>  cxl_core-$(CONFIG_TRACING) += trace.o
>>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
>> deleted file mode 100644
>> index f13b4dae6ac5..000000000000
>> --- a/drivers/cxl/core/acpi.c
>> +++ /dev/null
>> @@ -1,11 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0-only
>> -/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>> -#include <linux/acpi.h>
>> -#include "cxl.h"
>> -#include "core.h"
>> -
>> -int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>> -					    int nid, resource_size_t *size)
>> -{
>> -	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
>> -}
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 29b61828a847..9462aea9ce9d 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -120,8 +120,6 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>>  int cxl_ras_init(void);
>>  void cxl_ras_exit(void);
>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>> -int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>> -					    int nid, resource_size_t *size);
>>  
>>  #ifdef CONFIG_CXL_FEATURES
>>  struct cxl_feat_entry *
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index eb46c6764d20..cbb9c5a3c309 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1793,6 +1793,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
>>   * cxl_root_decoder_alloc - Allocate a root level decoder
>>   * @port: owning CXL root of this decoder
>>   * @nr_targets: static number of downstream targets
>> + * @ops: root decoder callback operations
>>   *
>>   * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
>>   * 'CXL root' decoder is one that decodes from a top-level / static platform
>> @@ -1800,7 +1801,8 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
>>   * topology.
>>   */
>>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>> -						unsigned int nr_targets)
>> +						unsigned int nr_targets,
>> +						const struct cxl_rd_ops *ops)
>>  {
>>  	struct cxl_root_decoder *cxlrd;
>>  	struct cxl_switch_decoder *cxlsd;
>> @@ -1839,6 +1841,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>>  
>>  	atomic_set(&cxlrd->region_id, rc);
>>  	cxlrd->qos_class = CXL_QOS_CLASS_INVALID;
>> +	cxlrd->ops = ops;
>>  	return cxlrd;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, "CXL");
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 6e5e1460068d..0a5effbc0529 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3287,7 +3287,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>>  	resource_size_t cache_size, start;
>>  	int rc;
>>  
>> -	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
>> +	if (!cxlrd->ops || !cxlrd->ops->get_extended_linear_cache_size)
>> +		return -EOPNOTSUPP;
>> +
>> +	rc = cxlrd->ops->get_extended_linear_cache_size(res, nid, &cache_size);
>>  	if (rc)
>>  		return rc;
>>  
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 3f1695c96abc..9a17e8beca7a 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -420,6 +420,11 @@ struct cxl_switch_decoder {
>>  struct cxl_root_decoder;
>>  typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
>>  
>> +struct cxl_rd_ops {
>> +	int (*get_extended_linear_cache_size)(struct resource *backing_res,
>> +					      int nid, resource_size_t *size);
>> +};
>> +
>>  /**
>>   * struct cxl_root_decoder - Static platform CXL address decoder
>>   * @res: host / parent resource for region allocations
>> @@ -428,6 +433,7 @@ typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
>>   * @platform_data: platform specific configuration data
>>   * @range_lock: sync region autodiscovery by address range
>>   * @qos_class: QoS performance class cookie
>> + * @ops: root decoder specific operations
>>   * @cxlsd: base cxl switch decoder
>>   */
>>  struct cxl_root_decoder {
>> @@ -437,6 +443,7 @@ struct cxl_root_decoder {
>>  	void *platform_data;
>>  	struct mutex range_lock;
>>  	int qos_class;
>> +	const struct cxl_rd_ops *ops;
>>  	struct cxl_switch_decoder cxlsd;
>>  };
>>  
>> @@ -775,7 +782,8 @@ bool is_root_decoder(struct device *dev);
>>  bool is_switch_decoder(struct device *dev);
>>  bool is_endpoint_decoder(struct device *dev);
>>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>> -						unsigned int nr_targets);
>> +						unsigned int nr_targets,
>> +						const struct cxl_rd_ops *ops);
>>  struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
>>  						    unsigned int nr_targets);
>>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>> index 31a2d73c963f..c4fd68db41ba 100644
>> --- a/tools/testing/cxl/Kbuild
>> +++ b/tools/testing/cxl/Kbuild
>> @@ -15,6 +15,7 @@ ldflags-y += --wrap=devm_cxl_add_rch_dport
>>  ldflags-y += --wrap=cxl_rcd_component_reg_phys
>>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
>> +ldflags-y += --wrap=hmat_get_extended_linear_cache_size
>>  
>>  DRIVERS := ../../../drivers
>>  CXL_SRC := $(DRIVERS)/cxl
>> @@ -62,7 +63,6 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
>>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>>  cxl_core-y += $(CXL_CORE_SRC)/ras.o
>> -cxl_core-y += $(CXL_CORE_SRC)/acpi.o
>>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index 8a5815ca870d..c0eb95632062 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -470,6 +470,44 @@ struct cxl_cedt_context {
>>  	struct device *dev;
>>  };
>>  
>> +static int match_root_decoder_by_range(struct device *dev, const void *data)
>> +{
>> +	struct cxl_root_decoder *cxlrd;
>> +	const struct range *r2 = data;
>> +	const struct range *r1;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>> +	return range_contains(r1, r2);
>> +}
>> +
>> +static int mock_hmat_get_extended_linear_cache_size(struct resource *backing_res,
>> +						    int nid, resource_size_t *size)
>> +{
>> +	struct range backing_range = {
>> +		.start = backing_res->start,
>> +		.end = backing_res->end,
>> +	};
>> +	struct cxl_decoder *cxld;
>> +	struct cxl_port *port;
>> +
>> +	struct device *dev __free(put_device) =
>> +		bus_find_device(&cxl_bus_type, NULL, &backing_range,
>> +				match_root_decoder_by_range);
>> +	if (!dev)
>> +		return -ENODEV;
>> +
>> +	cxld = to_cxl_decoder(dev);
>> +	port = to_cxl_port(cxld->dev.parent);
>> +	if (is_mock_dev(port->uport_dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
>> +}
>> +
>>  static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
>>  				      acpi_tbl_entry_handler_arg handler_arg,
>>  				      void *arg)
>> @@ -1039,6 +1077,8 @@ static struct cxl_mock_ops cxl_mock_ops = {
>>  	.devm_cxl_add_passthrough_decoder = mock_cxl_add_passthrough_decoder,
>>  	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
>>  	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
>> +	.hmat_get_extended_linear_cache_size =
>> +		mock_hmat_get_extended_linear_cache_size,
>>  	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
>>  };
>>  
>> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
>> index 1989ae020df3..ec8fc4a44073 100644
>> --- a/tools/testing/cxl/test/mock.c
>> +++ b/tools/testing/cxl/test/mock.c
>> @@ -78,6 +78,25 @@ int __wrap_acpi_table_parse_cedt(enum acpi_cedt_type id,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(__wrap_acpi_table_parse_cedt, "ACPI");
>>  
>> +int __wrap_hmat_get_extended_linear_cache_size(struct resource *res,
>> +					       int nid,
>> +					       resource_size_t *size)
>> +{
>> +	int index;
>> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>> +	int rc;
>> +
>> +	if (ops)
>> +		rc = ops->hmat_get_extended_linear_cache_size(res, nid, size);
>> +	else
>> +		rc = hmat_get_extended_linear_cache_size(res, nid, size);
>> +
>> +	put_cxl_mock_ops(index);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(__wrap_hmat_get_extended_linear_cache_size, "CXL");
>> +
>>  acpi_status __wrap_acpi_evaluate_integer(acpi_handle handle,
>>  					 acpi_string pathname,
>>  					 struct acpi_object_list *arguments,
>> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
>> index d1b0271d2822..469a270ee245 100644
>> --- a/tools/testing/cxl/test/mock.h
>> +++ b/tools/testing/cxl/test/mock.h
>> @@ -26,6 +26,9 @@ struct cxl_mock_ops {
>>  	int (*devm_cxl_enumerate_decoders)(
>>  		struct cxl_hdm *hdm, struct cxl_endpoint_dvsec_info *info);
>>  	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);
>> +	int (*hmat_get_extended_linear_cache_size)(struct resource *backing_res,
>> +						   int nid,
>> +						   resource_size_t *size);
>>  };
>>  
>>  void register_cxl_mock_ops(struct cxl_mock_ops *ops);
>>
>> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
>> -- 
>> 2.49.0
>>


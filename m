Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AAA1A3179
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744268; cv=none; b=SzLf3MEgq/ilpbJD2NGCh5oXghIna15RDIBgd/rNXQX7TK3UpK5ECZckoeBPzuOuRkPGAvUpOO4xouc45wEZ7oT2EZuo9qIpGWaUJBbm2198QADyzIxaMbaZ1StiPbr2IhaCe7iCdH9UEXbWGCzo4L/+31c0jq7ct9yfHNLVnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744268; c=relaxed/simple;
	bh=6Pns5B4kXR+2VJsNcH3+T81kADZvJGdP5WdQs3NnXp0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzsnEZ60RonysOf5XO64eUngBZFz6KwM84dtFPu/YO59k8oqjXqpQ9uRINpE3THpFTrz5Z0OPIlTCaku62/wnjmDUWqDEObD9bLCKfWUyUtq+eCUERQQ3UxaxxvccsrMk95kn7qVGrGVLsWMSRjyimL1Jp9LlqWR/CpzfiZZwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1v5d1pYvz6L4sq;
	Tue, 20 May 2025 20:30:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F4ED140516;
	Tue, 20 May 2025 20:31:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 14:31:02 +0200
Date: Tue, 20 May 2025 13:31:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 06/10] cxl/test: Add workaround for cxl_test for
 cxl_core calling mocked functions
Message-ID: <20250520133101.00003ddd@huawei.com>
In-Reply-To: <20250507004310.3536991-7-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-7-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 6 May 2025 17:43:06 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> When cxl_core calls a cxl_core exported function and that function is
> mocked by cxl_test, the call chain causes a circular dependency issue. Dan
> provided a workaround to avoid this issue. Apply the method to changes from
> the late host bridge uport mapping update changes in order to enable
> cxl-test.
> 
> The following functions are being modified:
> devm_cxl_add_passthrough_decoder()
> devm_cxl_setup_hdm()
> devm_cxl_enumerate_decoders()
> 
> In cxl_core they are defined with "__" added in front of the function. A
> macro is used to define the original function names for when non-test
> version of the kernel is built. A bit of macros and typedefs are used to
> allow mocking of those functions in cxl_test.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hmm. I think I follow this and it seems ok + I assume you tested it extensively ;)


Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> - Reverse unregister order. (Jonathan)
> - Move the bits only needed by cxl_test to cxl_test. (Dan)
> - Add more comments in the commit log. (Jonathan)
> ---
>  drivers/cxl/core/hdm.c               | 27 ++++++++++++---------
>  drivers/cxl/cxl.h                    | 25 ++++++++++++++++++++
>  tools/testing/cxl/Kbuild             |  4 +---
>  tools/testing/cxl/cxl_core_exports.c | 31 ++++++++++++++++++++++++
>  tools/testing/cxl/exports.h          | 17 ++++++++++++++
>  tools/testing/cxl/test/mock.c        | 35 +++++++++++++++++++---------
>  6 files changed, 114 insertions(+), 25 deletions(-)
>  create mode 100644 tools/testing/cxl/exports.h
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d7ad92e191ba..76cb6cf22c62 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -39,14 +39,19 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	return 0;
>  }
>  
> -/*
> +/**
> + * __devm_cxl_add_passthrough_decoder - Add passthrough decoder
> + * @port: The cxl_port context
> + *
> + * Return 0 on success or errno on failure.
> + *
>   * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
>   * single ported host-bridges need not publish a decoder capability when a
>   * passthrough decode can be assumed, i.e. all transactions that the uport sees
>   * are claimed and passed to the single dport. Disable the range until the first
>   * CXL region is enumerated / activated.
>   */
> -int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> +int __devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  {
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_dport *dport = NULL;
> @@ -73,7 +78,7 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  
>  	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
>  }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, "CXL");
> +EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_passthrough_decoder, "CXL");
>  
>  static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  {
> @@ -139,12 +144,12 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  }
>  
>  /**
> - * devm_cxl_setup_hdm - map HDM decoder component registers
> + * __devm_cxl_setup_hdm - map HDM decoder component registers
>   * @port: cxl_port to map
>   * @info: cached DVSEC range register info
>   */
> -struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
> -				   struct cxl_endpoint_dvsec_info *info)
> +struct cxl_hdm *__devm_cxl_setup_hdm(struct cxl_port *port,
> +				     struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_register_map *reg_map = &port->reg_map;
>  	struct device *dev = &port->dev;
> @@ -199,7 +204,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  
>  	return cxlhdm;
>  }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, "CXL");
> +EXPORT_SYMBOL_NS_GPL(__devm_cxl_setup_hdm, "CXL");
>  
>  static void __cxl_dpa_debug(struct seq_file *file, struct resource *r, int depth)
>  {
> @@ -1150,12 +1155,12 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
>  }
>  
>  /**
> - * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
> + * __devm_cxl_enumerate_decoders - add decoder objects per HDM register set
>   * @cxlhdm: Structure to populate with HDM capabilities
>   * @info: cached DVSEC range register info
>   */
> -int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> -				struct cxl_endpoint_dvsec_info *info)
> +int __devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> +				  struct cxl_endpoint_dvsec_info *info)
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	struct cxl_port *port = cxlhdm->port;
> @@ -1212,4 +1217,4 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, "CXL");
> +EXPORT_SYMBOL_NS_GPL(__devm_cxl_enumerate_decoders, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6b85d5f23be0..4d0ddb506ec5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -810,9 +810,17 @@ struct cxl_endpoint_dvsec_info {
>  struct cxl_hdm;
>  struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  				   struct cxl_endpoint_dvsec_info *info);
> +struct cxl_hdm *__devm_cxl_setup_hdm(struct cxl_port *port,
> +				     struct cxl_endpoint_dvsec_info *info);
> +
>  int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  				struct cxl_endpoint_dvsec_info *info);
> +int __devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> +				  struct cxl_endpoint_dvsec_info *info);
> +
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> +int __devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> +
>  struct cxl_dev_state;
>  int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info);
> @@ -921,4 +929,21 @@ bool dev_is_cxl_root_child(struct device *dev);
>  
>  u16 cxl_gpf_get_dvsec(struct device *dev);
>  
> +/*
> + * Declaration for functions that are mocked by cxl_test that are called by
> + * cxl_core. The respective functions are defined as __foo() and called by
> + * cxl_core as foo(). The macros below ensures that those functions would
> + * exist as foo(). See tools/testing/cxl/cxl_core_exports.c and
> + * tools/testing/cxl/exports.h for setting up the mock functions. The dance
> + * is done to avoid a circular dependency where cxl_core calls a function that
> + * ends up being a mock function and goes to * cxl_test where it calls a
> + * cxl_core function.
> + */
> +#ifndef CXL_TEST_ENABLE
> +#define DECLARE_TESTABLE(x) __##x
> +#define devm_cxl_enumerate_decoders DECLARE_TESTABLE(devm_cxl_enumerate_decoders)
> +#define devm_cxl_setup_hdm DECLARE_TESTABLE(devm_cxl_setup_hdm)
> +#define devm_cxl_add_passthrough_decoder DECLARE_TESTABLE(devm_cxl_add_passthrough_decoder)
> +#endif
> +
>  #endif /* __CXL_H__ */
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 387f3df8b988..8bf786eef9f1 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -5,9 +5,6 @@ ldflags-y += --wrap=acpi_evaluate_integer
>  ldflags-y += --wrap=acpi_pci_find_root
>  ldflags-y += --wrap=nvdimm_bus_register
>  ldflags-y += --wrap=devm_cxl_port_enumerate_dports
> -ldflags-y += --wrap=devm_cxl_setup_hdm
> -ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
> -ldflags-y += --wrap=devm_cxl_enumerate_decoders
>  ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=cxl_hdm_decode_init
>  ldflags-y += --wrap=cxl_dvsec_rr_decode
> @@ -21,6 +18,7 @@ CXL_SRC := $(DRIVERS)/cxl
>  CXL_CORE_SRC := $(DRIVERS)/cxl/core
>  ccflags-y := -I$(srctree)/drivers/cxl/
>  ccflags-y += -D__mock=__weak
> +ccflags-y += -DCXL_TEST_ENABLE=1
>  ccflags-y += -DTRACE_INCLUDE_PATH=$(CXL_CORE_SRC) -I$(srctree)/drivers/cxl/core/
>  
>  obj-m += cxl_acpi.o
> diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
> index f088792a8925..9a5f2e641897 100644
> --- a/tools/testing/cxl/cxl_core_exports.c
> +++ b/tools/testing/cxl/cxl_core_exports.c
> @@ -2,6 +2,37 @@
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  
>  #include "cxl.h"
> +#include "exports.h"
>  
>  /* Exporting of cxl_core symbols that are only used by cxl_test */
>  EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
> +
> +cxl_add_pt_decoder_fn _devm_cxl_add_passthrough_decoder =
> +	__devm_cxl_add_passthrough_decoder;
> +EXPORT_SYMBOL_NS_GPL(_devm_cxl_add_passthrough_decoder, "CXL");
> +
> +int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> +{
> +	return _devm_cxl_add_passthrough_decoder(port);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, "CXL");
> +
> +cxl_setup_hdm_fn _devm_cxl_setup_hdm = __devm_cxl_setup_hdm;
> +EXPORT_SYMBOL_NS_GPL(_devm_cxl_setup_hdm, "CXL");
> +
> +struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
> +				   struct cxl_endpoint_dvsec_info *info)
> +{
> +	return _devm_cxl_setup_hdm(port, info);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, "CXL");
> +
> +cxl_enum_decoders_fn _devm_cxl_enumerate_decoders = __devm_cxl_enumerate_decoders;
> +EXPORT_SYMBOL_NS_GPL(_devm_cxl_enumerate_decoders, "CXL");
> +
> +int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> +				struct cxl_endpoint_dvsec_info *info)
> +{
> +	return _devm_cxl_enumerate_decoders(cxlhdm, info);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, "CXL");
> diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
> new file mode 100644
> index 000000000000..036fe85e1ad9
> --- /dev/null
> +++ b/tools/testing/cxl/exports.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2025 Intel Corporation */
> +#ifndef __MOCK_CXL_EXPORTS_H_
> +#define __MOCK_CXL_EXPORTS_H_
> +
> +typedef struct cxl_hdm *(*cxl_setup_hdm_fn)(struct cxl_port *port,
> +					    struct cxl_endpoint_dvsec_info *info);
> +extern cxl_setup_hdm_fn _devm_cxl_setup_hdm;
> +
> +typedef int (*cxl_enum_decoders_fn)(struct cxl_hdm *cxlhdm,
> +				    struct cxl_endpoint_dvsec_info *info);
> +extern cxl_enum_decoders_fn _devm_cxl_enumerate_decoders;
> +
> +typedef int (*cxl_add_pt_decoder_fn)(struct cxl_port *port);
> +extern cxl_add_pt_decoder_fn _devm_cxl_add_passthrough_decoder;
> +
> +#endif
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index d9e8940d9328..c4367c4b5278 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -10,12 +10,25 @@
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include "mock.h"
> +#include "../exports.h"
>  
>  static LIST_HEAD(mock);
>  
> +static struct cxl_hdm *
> +redirect_devm_cxl_setup_hdm(struct cxl_port *port,
> +			    struct cxl_endpoint_dvsec_info *info);
> +static int
> +redirect_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> +				     struct cxl_endpoint_dvsec_info *info);
> +static int redirect_devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> +
>  void register_cxl_mock_ops(struct cxl_mock_ops *ops)
>  {
>  	list_add_rcu(&ops->list, &mock);
> +	_devm_cxl_setup_hdm = redirect_devm_cxl_setup_hdm;
> +	_devm_cxl_enumerate_decoders = redirect_devm_cxl_enumerate_decoders;
> +	_devm_cxl_add_passthrough_decoder =
> +		redirect_devm_cxl_add_passthrough_decoder;
>  }
>  EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
>  
> @@ -23,6 +36,9 @@ DEFINE_STATIC_SRCU(cxl_mock_srcu);
>  
>  void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
>  {
> +	_devm_cxl_add_passthrough_decoder = __devm_cxl_add_passthrough_decoder;
> +	_devm_cxl_enumerate_decoders = __devm_cxl_enumerate_decoders;
> +	_devm_cxl_setup_hdm = __devm_cxl_setup_hdm;
>  	list_del_rcu(&ops->list);
>  	synchronize_srcu(&cxl_mock_srcu);
>  }
> @@ -131,8 +147,8 @@ __wrap_nvdimm_bus_register(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
>  
> -struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
> -					  struct cxl_endpoint_dvsec_info *info)
> +struct cxl_hdm *redirect_devm_cxl_setup_hdm(struct cxl_port *port,
> +					    struct cxl_endpoint_dvsec_info *info)
>  
>  {
>  	int index;
> @@ -142,14 +158,13 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
>  	if (ops && ops->is_mock_port(port->uport_dev))
>  		cxlhdm = ops->devm_cxl_setup_hdm(port, info);
>  	else
> -		cxlhdm = devm_cxl_setup_hdm(port, info);
> +		cxlhdm = __devm_cxl_setup_hdm(port, info);
>  	put_cxl_mock_ops(index);
>  
>  	return cxlhdm;
>  }
> -EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, "CXL");
>  
> -int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> +int redirect_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  {
>  	int rc, index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> @@ -157,15 +172,14 @@ int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  	if (ops && ops->is_mock_port(port->uport_dev))
>  		rc = ops->devm_cxl_add_passthrough_decoder(port);
>  	else
> -		rc = devm_cxl_add_passthrough_decoder(port);
> +		rc = __devm_cxl_add_passthrough_decoder(port);
>  	put_cxl_mock_ops(index);
>  
>  	return rc;
>  }
> -EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_passthrough_decoder, "CXL");
>  
> -int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> -				       struct cxl_endpoint_dvsec_info *info)
> +int redirect_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> +					 struct cxl_endpoint_dvsec_info *info)
>  {
>  	int rc, index;
>  	struct cxl_port *port = cxlhdm->port;
> @@ -174,12 +188,11 @@ int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  	if (ops && ops->is_mock_port(port->uport_dev))
>  		rc = ops->devm_cxl_enumerate_decoders(cxlhdm, info);
>  	else
> -		rc = devm_cxl_enumerate_decoders(cxlhdm, info);
> +		rc = __devm_cxl_enumerate_decoders(cxlhdm, info);
>  	put_cxl_mock_ops(index);
>  
>  	return rc;
>  }
> -EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enumerate_decoders, "CXL");
>  
>  int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
>  {


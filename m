Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA710F1
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531463; cv=none; b=XatBRClGM5Bc7xH3I6p/T+N0io5bZvw3GfyeviRVBEN/fQZw/Z4xBbpHwomv2U/ViZ7LOlW/1GwHrZmTqm2g8ul7JOR81FX1inqvg9fd4fIv3eEW3wW+ltYUs58osGHqFb43Juzs4rRC6aw2DH14916CfPdM3RWd/0sBGtqItgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531463; c=relaxed/simple;
	bh=szg1Gyc1GaY3s5k24Fha6h5bQ740hCKlneec0jsDI1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bw/GCQhEmOoMR4VtgiF/EEUyTnTMmj4BVJJuILmdWRbyVCYw2XeYmyk5ISGS1zYZwsLTJEshcLaZMdyyKVGwkIR6t/43q5EW0Dpuex8F7rT7dxbjOwUEjEIEt4OWoY+MfIg2ONQid9DIkFmI2y98idL3tLz8ZSxauD/Z8WdS250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAt4Td9h; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAt4Td9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780531462; x=1812067462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=szg1Gyc1GaY3s5k24Fha6h5bQ740hCKlneec0jsDI1I=;
  b=kAt4Td9hJk1/jYENd2CyZNFoWKsFEnEl3jqGoz31pU/HOZFuECy/qOw2
   0/j/V/vm/JC8d0XsbRVtcdxy013etjpMiaHNVnzq1/RUMyVeGi9fdWhGv
   LI9IMfLOaF88CdF0snmPIdDgQC1lzE8eDgJQKBaKVyBnQLZu4Hvitfdzr
   ufjsuBZWjJJv0QLhptrH8IG/WG8+JQn1dfj0LBKbLnX0yvPQETKFPkH4a
   SKjt4ffJqprUyLZtmRmCkukSTPRx1gSDtLmJ9D5NC+F44v93NNlvSpyZq
   WgaXtVR0n2vFtIfAREjLkWqkGIoO0lMwNmoHLIjpO5V3oSyMZVj3bA0Nu
   Q==;
X-CSE-ConnectionGUID: KowNcW/wQKm3RhJcLx2G8Q==
X-CSE-MsgGUID: yaZScrgHRp2LAvG2QhydkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80495658"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="80495658"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 17:04:21 -0700
X-CSE-ConnectionGUID: xSlByfF3Sdyg89r2TfTB+A==
X-CSE-MsgGUID: g4xtTF/bQAe/plxsrqU/Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="248719587"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.116]) ([10.125.108.116])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 17:04:20 -0700
Message-ID: <7532ffb1-fe3f-4033-bd38-79f5dee150ef@intel.com>
Date: Wed, 3 Jun 2026 17:04:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] cxl/test: Add a topology to test mixed-granularity
 regions
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1780095671.git.alison.schofield@intel.com>
 <2ab2466fafa96f07df65ee5f6b4f8511240f4c93.1780095671.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2ab2466fafa96f07df65ee5f6b4f8511240f4c93.1780095671.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/29/26 5:00 PM, Alison Schofield wrote:
> Add a cxl_test topology for mixed-granularity region coverage.
> 
> modprobe cxl_test mixed_gran_regions=1 creates three host bridges
> with two switch levels below each bridge and twelve endpoints total.
> The topology advertises one 2-way root CFMWS for power-of-2
> mixed-granularity tests and one 3-way root CFMWS for 3-way-family
> tests.
> 
> Leave the default and existing specialty topologies unchanged.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>


$ make -j `nproc` M=tools/testing/cxl
make[1]: Entering directory '/home/djiang5/git/kernel-review/tools/testing/cxl'
  CC [M]  test/cxl.o
test/cxl.c: In function ‘cxl_test_init’:
test/cxl.c:2358:17: error: label ‘err_rch’ used but not defined
 2358 |                 goto err_rch;
      |

Applied against 7.1-rc6.

> ---
>  tools/testing/cxl/test/cxl.c | 474 +++++++++++++++++++++++++++++++++--
>  1 file changed, 452 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..b44db749873f 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -17,6 +17,7 @@
>  static int interleave_arithmetic;
>  static bool extended_linear_cache;
>  static bool fail_autoassemble;
> +static bool mixed_gran_regions;
>  
>  #define FAKE_QTG_ID	42
>  
> @@ -26,7 +27,26 @@ static bool fail_autoassemble;
>  #define NR_CXL_ROOT_PORTS 2
>  #define NR_CXL_SWITCH_PORTS 2
>  #define NR_CXL_PORT_DECODERS 8
> -#define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
> +
> +/*
> + * mixed_gran_regions=1: three host bridges, two switch levels, and
> + * twelve endpoints for power-of-2 and 3-way-family region layouts.
> + */
> +#define NR_CXL_MIX_GRAN_HB 3
> +#define NR_CXL_MIX_GRAN_ROOT_PORTS NR_CXL_MIX_GRAN_HB	/* 1 per HB */
> +#define NR_CXL_MIX_GRAN_L1_DPORTS  (NR_CXL_MIX_GRAN_HB * 2)
> +#define NR_CXL_MIX_GRAN_L2_SWITCHES NR_CXL_MIX_GRAN_L1_DPORTS
> +#define NR_CXL_MIX_GRAN_L2_DPORTS  (NR_CXL_MIX_GRAN_L2_SWITCHES * 2)
> +
> +#define NR_DEFAULT_BRIDGES \
> +	(NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
> +#define NR_BRIDGES (NR_DEFAULT_BRIDGES + NR_CXL_MIX_GRAN_HB)
> +
> +/* CHBS index ranges within mock_cedt.chbs[] */
> +#define CHBS_DEFAULT_START 0
> +#define CHBS_DEFAULT_END (NR_DEFAULT_BRIDGES - 1)
> +#define CHBS_MIX_GRAN_START NR_DEFAULT_BRIDGES
> +#define CHBS_MIX_GRAN_END (NR_BRIDGES - 1)
>  
>  #define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
>  static int mock_auto_region_size = MOCK_AUTO_REGION_SIZE_DEFAULT;
> @@ -52,6 +72,15 @@ struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
>  static struct platform_device *cxl_rch[NR_CXL_RCH];
>  static struct platform_device *cxl_rcd[NR_CXL_RCH];
>  
> +/* Dedicated mixed-granularity topology */
> +static struct platform_device *cxl_mix_gran_hb[NR_CXL_MIX_GRAN_HB];
> +static struct platform_device *cxl_mix_gran_root_port[NR_CXL_MIX_GRAN_ROOT_PORTS];
> +static struct platform_device *cxl_mix_gran_l1_uport[NR_CXL_MIX_GRAN_ROOT_PORTS];
> +static struct platform_device *cxl_mix_gran_l1_dport[NR_CXL_MIX_GRAN_L1_DPORTS];
> +static struct platform_device *cxl_mix_gran_l2_uport[NR_CXL_MIX_GRAN_L2_SWITCHES];
> +static struct platform_device *cxl_mix_gran_l2_dport[NR_CXL_MIX_GRAN_L2_DPORTS];
> +static struct platform_device *cxl_mem_mix_gran[NR_CXL_MIX_GRAN_L2_DPORTS];
> +
>  /*
>   * Decoder registry
>   *
> @@ -115,6 +144,19 @@ static struct acpi_device host_bridge[NR_BRIDGES] = {
>  		.handle = &host_bridge[3],
>  		.pnp.unique_id = "3",
>  	},
> +	/* Dedicated mixed-granularity topology */
> +	[4] = {
> +		.handle = &host_bridge[4],
> +		.pnp.unique_id = "4",
> +	},
> +	[5] = {
> +		.handle = &host_bridge[5],
> +		.pnp.unique_id = "5",
> +	},
> +	[6] = {
> +		.handle = &host_bridge[6],
> +		.pnp.unique_id = "6",
> +	},
>  };
>  
>  static bool is_mock_dev(struct device *dev)
> @@ -130,6 +172,9 @@ static bool is_mock_dev(struct device *dev)
>  	for (i = 0; i < ARRAY_SIZE(cxl_rcd); i++)
>  		if (dev == &cxl_rcd[i]->dev)
>  			return true;
> +	for (i = 0; i < ARRAY_SIZE(cxl_mem_mix_gran); i++)
> +		if (cxl_mem_mix_gran[i] && dev == &cxl_mem_mix_gran[i]->dev)
> +			return true;
>  	if (dev == &cxl_acpi->dev)
>  		return true;
>  	return false;
> @@ -188,6 +233,14 @@ static struct {
>  		struct acpi_cedt_cfmws cfmws;
>  		u32 target[3];
>  	} cfmws8;
> +	struct {
> +		struct acpi_cedt_cfmws cfmws;
> +		u32 target[2];
> +	} cfmws9;
> +	struct {
> +		struct acpi_cedt_cfmws cfmws;
> +		u32 target[3];
> +	} cfmws10;
>  	struct {
>  		struct acpi_cedt_cxims cxims;
>  		u64 xormap_list[2];
> @@ -232,6 +285,31 @@ static struct {
>  		.uid = 3,
>  		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL11,
>  	},
> +	/* Dedicated mixed-granularity topology */
> +	.chbs[4] = {
> +		.header = {
> +			.type = ACPI_CEDT_TYPE_CHBS,
> +			.length = sizeof(mock_cedt.chbs[0]),
> +		},
> +		.uid = 4,
> +		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
> +	},
> +	.chbs[5] = {
> +		.header = {
> +			.type = ACPI_CEDT_TYPE_CHBS,
> +			.length = sizeof(mock_cedt.chbs[0]),
> +		},
> +		.uid = 5,
> +		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
> +	},
> +	.chbs[6] = {
> +		.header = {
> +			.type = ACPI_CEDT_TYPE_CHBS,
> +			.length = sizeof(mock_cedt.chbs[0]),
> +		},
> +		.uid = 6,
> +		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
> +	},
>  	.cfmws0 = {
>  		.cfmws = {
>  			.header = {
> @@ -371,6 +449,36 @@ static struct {
>  		},
>  		.target = { 0, 1, 2, },
>  	},
> +	.cfmws9 = {
> +		.cfmws = {
> +			.header = {
> +				.type = ACPI_CEDT_TYPE_CFMWS,
> +				.length = sizeof(mock_cedt.cfmws9),
> +			},
> +			.interleave_ways = 1,
> +			.granularity = 4,
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> +					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> +			.qtg_id = FAKE_QTG_ID,
> +			.window_size = SZ_512M * 4UL,
> +		},
> +		.target = { 4, 5, },
> +	},
> +	.cfmws10 = {
> +		.cfmws = {
> +			.header = {
> +				.type = ACPI_CEDT_TYPE_CFMWS,
> +				.length = sizeof(mock_cedt.cfmws10),
> +			},
> +			.interleave_ways = 8,
> +			.granularity = 1,
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> +					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> +			.qtg_id = FAKE_QTG_ID,
> +			.window_size = SZ_512M * 6UL,
> +		},
> +		.target = { 4, 5, 6, },
> +	},
>  	.cxims0 = {
>  		.cxims = {
>  			.header = {
> @@ -395,6 +503,9 @@ struct acpi_cedt_cfmws *mock_cfmws[] = {
>  	[6] = &mock_cedt.cfmws6.cfmws,
>  	[7] = &mock_cedt.cfmws7.cfmws,
>  	[8] = &mock_cedt.cfmws8.cfmws,
> +	/* Dedicated mixed-granularity topology */
> +	[9] = &mock_cedt.cfmws9.cfmws,
> +	[10] = &mock_cedt.cfmws10.cfmws,
>  };
>  
>  static int cfmws_start;
> @@ -403,6 +514,8 @@ static int cfmws_end;
>  #define CFMWS_MOD_ARRAY_END   5
>  #define CFMWS_XOR_ARRAY_START 6
>  #define CFMWS_XOR_ARRAY_END   8
> +#define CFMWS_MIX_GRAN_ARRAY_START 9
> +#define CFMWS_MIX_GRAN_ARRAY_END   10
>  
>  struct acpi_cedt_cxims *mock_cxims[1] = {
>  	[0] = &mock_cedt.cxims0.cxims,
> @@ -475,9 +588,18 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
>  static int populate_cedt(void)
>  {
>  	struct cxl_mock_res *res;
> +	int chbs_lo, chbs_hi;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(mock_cedt.chbs); i++) {
> +	if (mixed_gran_regions) {
> +		chbs_lo = CHBS_MIX_GRAN_START;
> +		chbs_hi = CHBS_MIX_GRAN_END;
> +	} else {
> +		chbs_lo = CHBS_DEFAULT_START;
> +		chbs_hi = CHBS_DEFAULT_END;
> +	}
> +
> +	for (i = chbs_lo; i <= chbs_hi; i++) {
>  		struct acpi_cedt_chbs *chbs = &mock_cedt.chbs[i];
>  		resource_size_t size;
>  
> @@ -531,12 +653,23 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
>  	if (!is_mock_port(dev) && !is_mock_dev(dev))
>  		return acpi_table_parse_cedt(id, handler_arg, arg);
>  
> -	if (id == ACPI_CEDT_TYPE_CHBS)
> -		for (i = 0; i < ARRAY_SIZE(mock_cedt.chbs); i++) {
> +	if (id == ACPI_CEDT_TYPE_CHBS) {
> +		int chbs_lo, chbs_hi;
> +
> +		if (mixed_gran_regions) {
> +			chbs_lo = CHBS_MIX_GRAN_START;
> +			chbs_hi = CHBS_MIX_GRAN_END;
> +		} else {
> +			chbs_lo = CHBS_DEFAULT_START;
> +			chbs_hi = CHBS_DEFAULT_END;
> +		}
> +
> +		for (i = chbs_lo; i <= chbs_hi; i++) {
>  			h = (union acpi_subtable_headers *)&mock_cedt.chbs[i];
>  			end = (unsigned long)&mock_cedt.chbs[i + 1];
>  			handler_arg(h, arg, end);
>  		}
> +	}
>  
>  	if (id == ACPI_CEDT_TYPE_CFMWS)
>  		for (i = cfmws_start; i <= cfmws_end; i++) {
> @@ -568,6 +701,9 @@ static bool is_mock_bridge(struct device *dev)
>  	for (i = 0; i < ARRAY_SIZE(cxl_rch); i++)
>  		if (dev == &cxl_rch[i]->dev)
>  			return true;
> +	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_hb); i++)
> +		if (cxl_mix_gran_hb[i] && dev == &cxl_mix_gran_hb[i]->dev)
> +			return true;
>  
>  	return false;
>  }
> @@ -603,6 +739,31 @@ static bool is_mock_port(struct device *dev)
>  		if (dev == &cxl_swd_single[i]->dev)
>  			return true;
>  
> +	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_root_port); i++)
> +		if (cxl_mix_gran_root_port[i] &&
> +		    dev == &cxl_mix_gran_root_port[i]->dev)
> +			return true;
> +
> +	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_l1_uport); i++)
> +		if (cxl_mix_gran_l1_uport[i] &&
> +		    dev == &cxl_mix_gran_l1_uport[i]->dev)
> +			return true;
> +
> +	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_l1_dport); i++)
> +		if (cxl_mix_gran_l1_dport[i] &&
> +		    dev == &cxl_mix_gran_l1_dport[i]->dev)
> +			return true;
> +
> +	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_l2_uport); i++)
> +		if (cxl_mix_gran_l2_uport[i] &&
> +		    dev == &cxl_mix_gran_l2_uport[i]->dev)
> +			return true;
> +
> +	for (i = 0; i < ARRAY_SIZE(cxl_mix_gran_l2_dport); i++)
> +		if (cxl_mix_gran_l2_dport[i] &&
> +		    dev == &cxl_mix_gran_l2_dport[i]->dev)
> +			return true;
> +
>  	if (is_cxl_memdev(dev))
>  		return is_mock_dev(dev->parent);
>  
> @@ -671,7 +832,15 @@ static struct acpi_pci_root mock_pci_root[ARRAY_SIZE(mock_pci_bus)] = {
>  	[3] = {
>  		.bus = &mock_pci_bus[3],
>  	},
> -
> +	[4] = {
> +		.bus = &mock_pci_bus[4],
> +	},
> +	[5] = {
> +		.bus = &mock_pci_bus[5],
> +	},
> +	[6] = {
> +		.bus = &mock_pci_bus[6],
> +	},
>  };
>  
>  static bool is_mock_bus(struct pci_bus *bus)
> @@ -1229,6 +1398,8 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  
>  	if (is_cxl_endpoint(port))
>  		target_count = 0;
> +	else if (mixed_gran_regions && is_cxl_root(parent_port))
> +		target_count = NR_CXL_MIX_GRAN_ROOT_PORTS / NR_CXL_MIX_GRAN_HB;
>  	else if (is_cxl_root(parent_port))
>  		target_count = NR_CXL_ROOT_PORTS;
>  	else
> @@ -1328,6 +1499,27 @@ static int get_port_array(struct cxl_port *port,
>  	struct platform_device **array;
>  	int array_size;
>  
> +	if (mixed_gran_regions) {
> +		if (port->depth == 1) {
> +			array_size = ARRAY_SIZE(cxl_mix_gran_root_port);
> +			array = cxl_mix_gran_root_port;
> +		} else if (port->depth == 2) {
> +			array_size = ARRAY_SIZE(cxl_mix_gran_l1_dport);
> +			array = cxl_mix_gran_l1_dport;
> +		} else if (port->depth == 3) {
> +			array_size = ARRAY_SIZE(cxl_mix_gran_l2_dport);
> +			array = cxl_mix_gran_l2_dport;
> +		} else {
> +			dev_WARN_ONCE(&port->dev, 1, "unexpected depth %d\n",
> +				      port->depth);
> +			return -ENXIO;
> +		}
> +
> +		*port_array = array;
> +		*port_array_size = array_size;
> +		return 0;
> +	}
> +
>  	if (port->depth == 1) {
>  		if (is_multi_bridge(port->uport_dev)) {
>  			array_size = ARRAY_SIZE(cxl_root_port);
> @@ -1709,10 +1901,190 @@ static void cxl_single_topo_exit(void)
>  	}
>  }
>  
> +#define MIX_GRAN_RP_ID_BASE	(NR_MULTI_ROOT + NR_CXL_SINGLE_HOST)
> +#define MIX_GRAN_L1U_ID_BASE	MIX_GRAN_RP_ID_BASE
> +#define MIX_GRAN_L1D_ID_BASE	(NR_MEM_MULTI + NR_MEM_SINGLE)
> +#define MIX_GRAN_L2U_ID_BASE	MIX_GRAN_L1D_ID_BASE
> +#define MIX_GRAN_L2D_ID_BASE	\
> +	(MIX_GRAN_L1D_ID_BASE + NR_CXL_MIX_GRAN_L1_DPORTS)
> +#define MIX_GRAN_MEM_ID_BASE	(NR_MEM_MULTI + NR_MEM_SINGLE + NR_CXL_RCH)
> +
> +static void cxl_mix_gran_topo_exit(void)
> +{
> +	int i;
> +
> +	for (i = NR_CXL_MIX_GRAN_L2_DPORTS - 1; i >= 0; i--)
> +		platform_device_unregister(cxl_mix_gran_l2_dport[i]);
> +	for (i = NR_CXL_MIX_GRAN_L2_SWITCHES - 1; i >= 0; i--)
> +		platform_device_unregister(cxl_mix_gran_l2_uport[i]);
> +	for (i = NR_CXL_MIX_GRAN_L1_DPORTS - 1; i >= 0; i--)
> +		platform_device_unregister(cxl_mix_gran_l1_dport[i]);
> +	for (i = NR_CXL_MIX_GRAN_ROOT_PORTS - 1; i >= 0; i--)
> +		platform_device_unregister(cxl_mix_gran_l1_uport[i]);
> +	for (i = NR_CXL_MIX_GRAN_ROOT_PORTS - 1; i >= 0; i--)
> +		platform_device_unregister(cxl_mix_gran_root_port[i]);
> +	for (i = NR_CXL_MIX_GRAN_HB - 1; i >= 0; i--) {
> +		struct platform_device *pdev = cxl_mix_gran_hb[i];
> +
> +		if (!pdev)
> +			continue;
> +		sysfs_remove_link(&pdev->dev.kobj, "physical_node");
> +		platform_device_unregister(pdev);
> +	}
> +}
> +
> +static __init int cxl_mix_gran_topo_init(void)
> +{
> +	int i, rc;
> +
> +	/* 3 host bridges */
> +	for (i = 0; i < NR_CXL_MIX_GRAN_HB; i++) {
> +		struct acpi_device *adev = &host_bridge[NR_DEFAULT_BRIDGES + i];
> +		struct platform_device *pdev;
> +
> +		pdev = platform_device_alloc("cxl_host_bridge",
> +					     NR_DEFAULT_BRIDGES + i);
> +		if (!pdev) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +
> +		mock_companion(adev, &pdev->dev);
> +		rc = platform_device_add(pdev);
> +		if (rc) {
> +			platform_device_put(pdev);
> +			goto err;
> +		}
> +
> +		cxl_mix_gran_hb[i] = pdev;
> +		mock_pci_bus[NR_DEFAULT_BRIDGES + i].bridge = &pdev->dev;
> +		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
> +				       "physical_node");
> +		if (rc)
> +			goto err;
> +	}
> +
> +	/* 1 root port per host bridge */
> +	for (i = 0; i < NR_CXL_MIX_GRAN_ROOT_PORTS; i++) {
> +		struct platform_device *bridge = cxl_mix_gran_hb[i];
> +		struct platform_device *pdev;
> +
> +		pdev = platform_device_alloc("cxl_root_port",
> +					     MIX_GRAN_RP_ID_BASE + i);
> +		if (!pdev) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		pdev->dev.parent = &bridge->dev;
> +
> +		rc = platform_device_add(pdev);
> +		if (rc) {
> +			platform_device_put(pdev);
> +			goto err;
> +		}
> +		cxl_mix_gran_root_port[i] = pdev;
> +	}
> +
> +	/* L1 switch uport under each root port */
> +	for (i = 0; i < NR_CXL_MIX_GRAN_ROOT_PORTS; i++) {
> +		struct platform_device *pdev;
> +
> +		pdev = platform_device_alloc("cxl_switch_uport",
> +					     MIX_GRAN_L1U_ID_BASE + i);
> +		if (!pdev) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		pdev->dev.parent = &cxl_mix_gran_root_port[i]->dev;
> +
> +		rc = platform_device_add(pdev);
> +		if (rc) {
> +			platform_device_put(pdev);
> +			goto err;
> +		}
> +		cxl_mix_gran_l1_uport[i] = pdev;
> +	}
> +
> +	/* 2 L1 dports per L1 switch */
> +	for (i = 0; i < NR_CXL_MIX_GRAN_L1_DPORTS; i++) {
> +		struct platform_device *uport =
> +			cxl_mix_gran_l1_uport[i / NR_CXL_SWITCH_PORTS];
> +		struct platform_device *pdev;
> +
> +		pdev = platform_device_alloc("cxl_switch_dport",
> +					     MIX_GRAN_L1D_ID_BASE + i);
> +		if (!pdev) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		pdev->dev.parent = &uport->dev;
> +
> +		rc = platform_device_add(pdev);
> +		if (rc) {
> +			platform_device_put(pdev);
> +			goto err;
> +		}
> +		cxl_mix_gran_l1_dport[i] = pdev;
> +	}
> +
> +	/* L2 switch uport under each L1 dport */
> +	for (i = 0; i < NR_CXL_MIX_GRAN_L2_SWITCHES; i++) {
> +		struct platform_device *pdev;
> +
> +		pdev = platform_device_alloc("cxl_switch_uport",
> +					     MIX_GRAN_L2U_ID_BASE + i);
> +		if (!pdev) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		pdev->dev.parent = &cxl_mix_gran_l1_dport[i]->dev;
> +
> +		rc = platform_device_add(pdev);
> +		if (rc) {
> +			platform_device_put(pdev);
> +			goto err;
> +		}
> +		cxl_mix_gran_l2_uport[i] = pdev;
> +	}
> +
> +	/* 2 L2 dports per L2 switch */
> +	for (i = 0; i < NR_CXL_MIX_GRAN_L2_DPORTS; i++) {
> +		struct platform_device *uport =
> +			cxl_mix_gran_l2_uport[i / NR_CXL_SWITCH_PORTS];
> +		struct platform_device *pdev;
> +
> +		pdev = platform_device_alloc("cxl_switch_dport",
> +					     MIX_GRAN_L2D_ID_BASE + i);
> +		if (!pdev) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		pdev->dev.parent = &uport->dev;
> +
> +		rc = platform_device_add(pdev);
> +		if (rc) {
> +			platform_device_put(pdev);
> +			goto err;
> +		}
> +		cxl_mix_gran_l2_dport[i] = pdev;
> +	}
> +
> +	return 0;
> +err:
> +	cxl_mix_gran_topo_exit();
> +	return rc;
> +}
> +
>  static void cxl_mem_exit(void)
>  {
>  	int i;
>  
> +	if (mixed_gran_regions) {
> +		for (i = NR_CXL_MIX_GRAN_L2_DPORTS - 1; i >= 0; i--)
> +			platform_device_unregister(cxl_mem_mix_gran[i]);
> +		return;
> +	}
> +
>  	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--)
>  		platform_device_unregister(cxl_rcd[i]);
>  	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
> @@ -1721,10 +2093,46 @@ static void cxl_mem_exit(void)
>  		platform_device_unregister(cxl_mem[i]);
>  }
>  
> +static int cxl_mem_mix_gran_init(void)
> +{
> +	int i, rc;
> +
> +	for (i = 0; i < NR_CXL_MIX_GRAN_L2_DPORTS; i++) {
> +		struct platform_device *dport = cxl_mix_gran_l2_dport[i];
> +		struct platform_device *pdev;
> +
> +		pdev = platform_device_alloc("cxl_mem",
> +					     MIX_GRAN_MEM_ID_BASE + i);
> +		if (!pdev) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		pdev->dev.parent = &dport->dev;
> +		set_dev_node(&pdev->dev, i % 2);
> +
> +		cxl_mem_mix_gran[i] = pdev;
> +		rc = platform_device_add(pdev);
> +		if (rc) {
> +			platform_device_put(pdev);
> +			cxl_mem_mix_gran[i] = NULL;
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +err:
> +	for (i = NR_CXL_MIX_GRAN_L2_DPORTS - 1; i >= 0; i--)
> +		platform_device_unregister(cxl_mem_mix_gran[i]);
> +	return rc;
> +}
> +
>  static int cxl_mem_init(void)
>  {
>  	int i, rc;
>  
> +	if (mixed_gran_regions)
> +		return cxl_mem_mix_gran_init();
> +
>  	for (i = 0; i < ARRAY_SIZE(cxl_mem); i++) {
>  		struct platform_device *dport = cxl_switch_dport[i];
>  		struct platform_device *pdev;
> @@ -1848,7 +2256,10 @@ static __init int cxl_test_init(void)
>  	if (rc)
>  		goto err_gen_pool_add;
>  
> -	if (interleave_arithmetic == 1) {
> +	if (mixed_gran_regions) {
> +		cfmws_start = CFMWS_MIX_GRAN_ARRAY_START;
> +		cfmws_end = CFMWS_MIX_GRAN_ARRAY_END;
> +	} else if (interleave_arithmetic == 1) {
>  		cfmws_start = CFMWS_XOR_ARRAY_START;
>  		cfmws_end = CFMWS_XOR_ARRAY_END;
>  	} else {
> @@ -1860,6 +2271,13 @@ static __init int cxl_test_init(void)
>  	if (rc)
>  		goto err_populate;
>  
> +	if (mixed_gran_regions) {
> +		rc = cxl_mix_gran_topo_init();
> +		if (rc)
> +			goto err_populate;
> +		goto topo_done;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(cxl_host_bridge); i++) {
>  		struct acpi_device *adev = &host_bridge[i];
>  		struct platform_device *pdev;
> @@ -1945,9 +2363,10 @@ static __init int cxl_test_init(void)
>  	if (rc)
>  		goto err_single;
>  
> +topo_done:
>  	cxl_acpi = platform_device_alloc("cxl_acpi", 0);
>  	if (!cxl_acpi)
> -		goto err_rch;
> +		goto err_topo;
>  
>  	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
>  	acpi0017_mock.dev.bus = &platform_bus_type;
> @@ -1971,7 +2390,11 @@ static __init int cxl_test_init(void)
>  	cxl_mem_exit();
>  err_root:
>  	platform_device_put(cxl_acpi);
> -err_rch:
> +err_topo:
> +	if (mixed_gran_regions) {
> +		cxl_mix_gran_topo_exit();
> +		goto err_populate;
> +	}
>  	cxl_rch_topo_exit();
>  err_single:
>  	cxl_single_topo_exit();
> @@ -2020,21 +2443,25 @@ static __exit void cxl_test_exit(void)
>  	hmem_test_exit();
>  	cxl_mem_exit();
>  	platform_device_unregister(cxl_acpi);
> -	cxl_rch_topo_exit();
> -	cxl_single_topo_exit();
> -	for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
> -		platform_device_unregister(cxl_switch_dport[i]);
> -	for (i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--)
> -		platform_device_unregister(cxl_switch_uport[i]);
> -	for (i = ARRAY_SIZE(cxl_root_port) - 1; i >= 0; i--)
> -		platform_device_unregister(cxl_root_port[i]);
> -	for (i = ARRAY_SIZE(cxl_host_bridge) - 1; i >= 0; i--) {
> -		struct platform_device *pdev = cxl_host_bridge[i];
> +	if (mixed_gran_regions) {
> +		cxl_mix_gran_topo_exit();
> +	} else {
> +		cxl_rch_topo_exit();
> +		cxl_single_topo_exit();
> +		for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
> +			platform_device_unregister(cxl_switch_dport[i]);
> +		for (i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--)
> +			platform_device_unregister(cxl_switch_uport[i]);
> +		for (i = ARRAY_SIZE(cxl_root_port) - 1; i >= 0; i--)
> +			platform_device_unregister(cxl_root_port[i]);
> +		for (i = ARRAY_SIZE(cxl_host_bridge) - 1; i >= 0; i--) {
> +			struct platform_device *pdev = cxl_host_bridge[i];
>  
> -		if (!pdev)
> -			continue;
> -		sysfs_remove_link(&pdev->dev.kobj, "physical_node");
> -		platform_device_unregister(cxl_host_bridge[i]);
> +			if (!pdev)
> +				continue;
> +			sysfs_remove_link(&pdev->dev.kobj, "physical_node");
> +			platform_device_unregister(cxl_host_bridge[i]);
> +		}
>  	}
>  	depopulate_all_mock_resources();
>  	gen_pool_destroy(cxl_mock_pool);
> @@ -2049,6 +2476,9 @@ module_param(extended_linear_cache, bool, 0444);
>  MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
>  module_param(fail_autoassemble, bool, 0444);
>  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
> +module_param(mixed_gran_regions, bool, 0444);
> +MODULE_PARM_DESC(mixed_gran_regions,
> +		 "Topology supporting mixed granularity regions");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737738229A
	for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303869; cv=none; b=Crgop76iJf0ApF0c04ynNtclRcqMYTKw6zN6pOX8qT0MU52enwIdiII3sVvf0Ibap1vt/NorV6WJVXV7MJNbyiaGFVS07lDOwRJ4YLuJP6efgDS6Q0/ue1m3n/63pq4XT/xtL8zcYPCWkd1tgM355YPShs60EApiA71vSA9Xfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303869; c=relaxed/simple;
	bh=nuA+wnziYzekv46cMdevbL6DnCYU+T/d8jmGYjqi73w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aho6Pmhc04gkG/Or4pnMzsaLTpdYut3AzpT88/u8v4zTQiOgnNqAsF3VX17CDy6oqd4acaZTJk9tHCb4HhJeM3HBWBNf854lZtK7Jc1TgbMzb45YDu9KMYlMvs7lE+WBNvkQxlASgAM9X2Zc6Osg1jmLnyfp53XlqF5qT7HF17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5QdObwS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5QdObwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774303867; x=1805839867;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nuA+wnziYzekv46cMdevbL6DnCYU+T/d8jmGYjqi73w=;
  b=b5QdObwSzGe4U/19Oe9sTR0/GkO4bpJrpiWwYE+krZ6RNzLOHHG3Q07r
   nwhhiWNN4TwyWtAdKgDsv1mxV0Ksk0aIVEAoFLL644aulEY1uUZofDAxx
   ZaKnFeR8F9FvkK5lqRpdzEtVaLgp0jKs6g+aXlsUgBYJKunXb6nn9NLBw
   ozOB6gdeaIdLR2WvPhMPxapzAgGpmd9SNtfrpUbr4N9rwYh3bruNwDnxZ
   W5wOTNBJB+nTi7LuT1u0eM/16lZDAtIRoY5NZtKmYb6sarXBQYP1rDZbn
   2TyHppQ6ITFvm+1MZOBF7bi3WrzwRWe3ds69LQEkHF/mK84P+zepEM2hx
   w==;
X-CSE-ConnectionGUID: srOcsMBDShKyAvN2KOU4Mg==
X-CSE-MsgGUID: lsRS0FTNSJ2RSOgeg4DM+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75221022"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75221022"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:11:07 -0700
X-CSE-ConnectionGUID: FyJYycp4SraVfUmGhXKY+A==
X-CSE-MsgGUID: 6J2QvAdVQj+eTjLzTTZ13A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247202727"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.216]) ([10.125.109.216])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:11:04 -0700
Message-ID: <7f6e9b89-8e25-40c3-a61c-aa8270cf1d69@intel.com>
Date: Mon, 23 Mar 2026 15:11:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] cxl: Add Back-Invalidate register definitions and
 structures
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, gourry@gourry.net, dongjoo.seo1@samsung.com,
 anisa.su@samsung.com, linux-cxl@vger.kernel.org
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-2-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260315202741.3264295-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/26 1:27 PM, Davidlohr Bueso wrote:
> Add CXL Back-Invalidate (BI) capability IDs, register definitions for
> the BI Route Table and BI Decoder capability structures, and associated
> fields. This includes HDM decoder coherency capability and control fields
> needed to support HDM-DB (device-managed coherency with back-invalidate).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/cxl.h    | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h |  2 ++
>  include/cxl/cxl.h    |  5 +++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 031846eab02c..efe06d60b364 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -42,6 +42,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_CM_CAP_CAP_ID_RAS 0x2
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
> +#define   CXL_CM_CAP_CAP_ID_BI_RT 0xB
> +#define   CXL_CM_CAP_CAP_ID_BI_DECODER 0xC
>  
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
> @@ -51,6 +53,10 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>  #define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>  #define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> +#define   CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK GENMASK(22, 21)
> +#define     CXL_HDM_DECODER_COHERENCY_DEV 0x1
> +#define     CXL_HDM_DECODER_COHERENCY_HOST 0x2
> +#define     CXL_HDM_DECODER_COHERENCY_BOTH 0x3
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> @@ -65,6 +71,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>  #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>  #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> +#define   CXL_HDM_DECODER0_CTRL_BI BIT(13)
>  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> @@ -152,6 +159,33 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_HEADERLOG_SIZE SZ_512
>  #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
>  
> +/* CXL 3.2 8.2.4.26 CXL BI Route Table Capability Structure */
> +#define CXL_BI_RT_CAPABILITY_LENGTH 0xC
> +#define CXL_BI_RT_CAPS_OFFSET 0x0
> +#define   CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ BIT(0)
> +#define CXL_BI_RT_CTRL_OFFSET 0x4
> +#define   CXL_BI_RT_CTRL_BI_COMMIT BIT(0)
> +#define CXL_BI_RT_STATUS_OFFSET 0x8
> +#define   CXL_BI_RT_STATUS_BI_COMMITTED BIT(0)
> +#define   CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED BIT(1)
> +#define   CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE GENMASK(11, 8)
> +#define   CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE GENMASK(15, 12)
> +
> +/* CXL 3.2 8.2.4.27 CXL BI Decoder Capability Structure */
> +#define CXL_BI_DECODER_CAPABILITY_LENGTH 0xC
> +#define CXL_BI_DECODER_CAPS_OFFSET 0x0
> +#define   CXL_BI_DECODER_CAPS_HDMD_CAP BIT(0)
> +#define   CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ BIT(1)
> +#define CXL_BI_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_BI_DECODER_CTRL_BI_FW BIT(0)
> +#define   CXL_BI_DECODER_CTRL_BI_ENABLE BIT(1)
> +#define   CXL_BI_DECODER_CTRL_BI_COMMIT BIT(2)
> +#define CXL_BI_DECODER_STATUS_OFFSET 0x8
> +#define   CXL_BI_DECODER_STATUS_BI_COMMITTED BIT(0)
> +#define   CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED BIT(1)
> +#define   CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE GENMASK(11, 8)
> +#define   CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE GENMASK(15, 12)
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -241,6 +275,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
> +#define CXL_DECODER_F_BI    BIT(7)
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> @@ -522,6 +557,7 @@ struct cxl_dax_region {
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
>   * @regs: mapped component registers
> + * @uport_regs: mapped upstream port component registers (BI RT)

Aren't port->regs upstream port registers? Why another entry?

DJ

>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -530,6 +566,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @nr_bi: number of BI-enabled endpoints below this port
>   * @component_reg_phys: Physical address of component register
>   */
>  struct cxl_port {
> @@ -544,6 +581,7 @@ struct cxl_port {
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
>  	struct cxl_component_regs regs;
> +	struct cxl_component_regs uport_regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -555,6 +593,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	int nr_bi;
>  	resource_size_t component_reg_phys;
>  };
>  
> @@ -875,6 +914,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_bi_setup(struct cxl_dev_state *cxlds);
> +int cxl_bi_dealloc(struct cxl_dev_state *cxlds);
>  struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  					    struct device *dport_dev);
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 281546de426e..efab65f68575 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -837,6 +837,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>   * @target_count: for switch decoders, max downstream port targets
>   * @interleave_mask: interleave granularity capability, see check_interleave_cap()
>   * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
> + * @supported_coherency: HDM Decoder Capability supported coherency mask
>   * @port: mapped cxl_port, see devm_cxl_setup_hdm()
>   */
>  struct cxl_hdm {
> @@ -845,6 +846,7 @@ struct cxl_hdm {
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
>  	unsigned long iw_cap_mask;
> +	unsigned int supported_coherency;
>  	struct cxl_port *port;
>  };
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index fa7269154620..74be940364e1 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -34,10 +34,12 @@ struct cxl_regs {
>  	 * Common set of CXL Component register block base pointers
>  	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
>  	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> +	 * @bi: CXL 3.2 8.2.4.26/27 CXL BI Capability Structure
>  	 */
>  	struct_group_tagged(cxl_component_regs, component,
>  		void __iomem *hdm_decoder;
>  		void __iomem *ras;
> +		void __iomem *bi;
>  	);
>  	/*
>  	 * Common set of CXL Device register block base pointers
> @@ -80,6 +82,7 @@ struct cxl_reg_map {
>  struct cxl_component_reg_map {
>  	struct cxl_reg_map hdm_decoder;
>  	struct cxl_reg_map ras;
> +	struct cxl_reg_map bi;
>  };
>  
>  struct cxl_device_reg_map {
> @@ -162,6 +165,7 @@ struct cxl_dpa_partition {
>   * @regs: Parsed register blocks
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @bi: device is BI (Back-Invalidate) enabled
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
>   * @part: DPA partition array
> @@ -181,6 +185,7 @@ struct cxl_dev_state {
>  	struct cxl_device_regs regs;
>  	int cxl_dvsec;
>  	bool rcd;
> +	bool bi;
>  	bool media_ready;
>  	struct resource dpa_res;
>  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];


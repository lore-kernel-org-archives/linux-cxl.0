Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329561D5159
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602854; cv=none; b=JfCWLWarPxtWqCRb1ep4h/bPlpjr9ekZMv/e588mBqX0fQ5G5JyP6ynheGpCWTV1Y67f3r63ye2PiC6oVfQMf1o6eubv0o3A1Tv8ai1o13ls+rVUVT3tHAVshzqxG0/MshH9SjbGriOFKzahsY550gdrQyIiQabIY1b+rmb6cBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602854; c=relaxed/simple;
	bh=ufx+/kSXHdOxL/LtsudpW3fYxy1kHI5RfOV/Xa2HRvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbj7c6PNbVYTsbKOIvBb5inuKP5LyvJj3gTaO+LLYDaspaHMZVNAzQ/11auxS/fUc5jHRS5KQ8PxNP5Kdw1947T5SKIrJi8JHemQGvRLD2q52xzGjjmdwaEeWy4dnypR3WxvukmpDaobGnILnBG3/tRmyfVYMrGXizONx6w1qnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUR9Rv3M; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUR9Rv3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738602852; x=1770138852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ufx+/kSXHdOxL/LtsudpW3fYxy1kHI5RfOV/Xa2HRvA=;
  b=JUR9Rv3MONQWO8G0kJF28/i1LiZq2STQXK3uu4nuiE0ArqFUY9nYJde6
   eqxa6m8TeXmT1+RMPs7HMW1dRTS/yRPb+C7vQFhZrIMJVOxjWpCjzKg94
   efPFtEkaV0Ry9ErLQsCq2aj5wn+F73WAVQyX85hEFG+0amCs+AoBOzPfg
   dx4+eVyhwyR/0oLd62Td2mqHnhG1WCDoGWW/XlPGN1MJqT7tjwIt5KLVd
   LT4Um0ZC5wQAZ9IE5NSEb/3xIaVcsRUDsYq0ciPhhzGTVPz9/e6N56SWM
   s1s31rDI+CvyMcvQPPlRHI2E431O/41NNNR3FXTLAHL66NWlEdFJireN9
   A==;
X-CSE-ConnectionGUID: gpaqHo2xTyWrvN1ZWOgD+g==
X-CSE-MsgGUID: 0CEsVoFzSoC/Inv6Bj1mkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39364867"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="39364867"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 09:14:11 -0800
X-CSE-ConnectionGUID: KK9S7veNTxambUcWdQu34w==
X-CSE-MsgGUID: xhx442ldRrqIGRwGZzMSOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="141222732"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.215]) ([10.125.109.215])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 09:14:10 -0800
Message-ID: <da4fb0dd-9770-4368-b047-ba877e67bbbc@intel.com>
Date: Mon, 3 Feb 2025 10:14:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cxl/pci: Support Global Persistent Flush (GPF)
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 hch@infradead.org, a.manzanares@samsung.com, fan.ni@samsung.com,
 anisa.su@samsung.com, linux-cxl@vger.kernel.org
References: <20250124233533.910535-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250124233533.910535-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/24/25 4:35 PM, Davidlohr Bueso wrote:
> Add support for GPF flows. It is found that the CXL specification
> around this to be a bit too involved from the driver side. And while
> this should really all handled by the hardware, this patch takes
> things with a grain of salt.
> 
> Upon respective port enumeration, both phase timeouts are set to
> a max of 20 seconds, which is the NMI watchdog default for lockup
> detection. The premise is that the kernel does not have enough
> information to set anything better than a max across the board
> and hope devices finish their GPF flows within the platform energy
> budget.
> 
> Timeout detection is based on dirty Shutdown semantics. The driver
> will mark it as dirty, expecting that the device clear it upon a
> successful GPF event. The admin may consult the device Health and
> check the dirty shutdown counter to see if there was a problem
> with data integrity.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Applied to cxl/next with some of Jonathan's change requests. Please check for accuracy.


> ---
> 
> Changes from v3:
>   - no rch checking (Dan)
>   - cache port dvsec (Dan)
>   - set dirty shutdown in pcxl_nvdimm_probe() (Dan)
> 
>  Documentation/driver-api/cxl/maturity-map.rst |  2 +-
>  drivers/cxl/core/core.h                       |  2 +
>  drivers/cxl/core/mbox.c                       | 18 ++++
>  drivers/cxl/core/pci.c                        | 86 +++++++++++++++++++
>  drivers/cxl/core/port.c                       |  2 +
>  drivers/cxl/cxl.h                             |  2 +
>  drivers/cxl/cxlmem.h                          |  5 ++
>  drivers/cxl/cxlpci.h                          |  6 ++
>  drivers/cxl/pmem.c                            |  8 ++
>  9 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index df8e2ac2a320..99dd2c841e69 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -130,7 +130,7 @@ Mailbox commands
>  * [0] Switch CCI
>  * [3] Timestamp
>  * [1] PMEM labels
> -* [0] PMEM GPF / Dirty Shutdown
> +* [1] PMEM GPF / Dirty Shutdown
>  * [0] Scan Media
>  
>  PMU
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 800466f96a68..8f2eb76a3c8c 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -115,4 +115,6 @@ bool cxl_need_node_perf_attrs_update(int nid);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
>  
> +int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..5b89ae5c5e28 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1308,6 +1308,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
>  
> +int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mbox_set_shutdown_state_in in = {
> +		.state = 1
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_SET_SHUTDOWN_STATE,
> +		.size_in = sizeof(in),
> +		.payload_in = &in,
> +	};
> +
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dirty_shutdown_state, "CXL");
> +
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b3aac9964e0d..b0a85f411e7d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1054,3 +1054,89 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  
>  	return 0;
>  }
> +
> +/*
> + * Set max timeout such that platforms will optimize GPF flow to avoid
> + * the implied worst-case scenario delays. On a sane platform, all
> + * devices should always complete GPF within the energy budget of
> + * the GPF flow. The kernel does not have enough information to pick
> + * anything better than "maximize timeouts and hope it works".
> + *
> + * A misbehaving device could block forward progress of GPF for all
> + * the other devices, exhausting the energy budget of the platform.
> + * However, the spec seems to assume that moving on from slow to respond
> + * devices is a virtue. It is not possible to know that, in actuality,
> + * the slow to respond device is *the* most critical device in the
> + * system to wait.
> + */
> +#define GPF_TIMEOUT_BASE_MAX 2
> +#define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
> +
> +static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
> +{
> +	u16 ctrl;
> +	int rc, offset, base, scale;
> +
> +	switch (phase) {
> +	case 1:
> +		offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
> +		base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
> +		scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
> +		break;
> +	case 2:
> +		offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
> +		base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
> +		scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rc = pci_read_config_word(pdev, dvsec + offset, &ctrl);
> +	if (rc)
> +		return rc;
> +
> +	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
> +	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
> +		return rc;
> +
> +	ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);
> +	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
> +
> +	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
> +	if (!rc)
> +		pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
> +			phase, GPF_TIMEOUT_BASE_MAX);
> +
> +	return rc;
> +}
> +
> +int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(dport_dev))
> +		return 0;
> +
> +	pdev = to_pci_dev(dport_dev);
> +	if (!pdev || !port)
> +		return -EINVAL;
> +
> +	if (!port->gpf_dvsec) {
> +		int dvsec;
> +
> +		dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +						  CXL_DVSEC_PORT_GPF);
> +		if (!dvsec) {
> +			pci_warn(pdev, "Port GPF DVSEC not present\n");
> +			return -EINVAL;
> +		}
> +
> +		port->gpf_dvsec = dvsec;
> +	}
> +
> +	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 1);
> +	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 2);
> +
> +	return 0;
> +}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 78a5c2c25982..95cd6f11bbfa 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1672,6 +1672,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  			if (rc && rc != -EBUSY)
>  				return rc;
>  
> +			cxl_gpf_port_setup(dport_dev, port);
> +
>  			/* Any more ports to add between this one and the root? */
>  			if (!dev_is_cxl_root_child(&port->dev))
>  				continue;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index fdac3ddb8635..d9c43a69f6f3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -609,6 +609,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @gpf_dvsec: Cached GPF port DVSEC
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -632,6 +633,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	int gpf_dvsec;
>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..17baced54b3b 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -693,6 +693,10 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +struct cxl_mbox_set_shutdown_state_in {
> +	u8 state;
> +} __packed;
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -829,6 +833,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
> +int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..54e219b0049e 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -40,6 +40,12 @@
>  
>  /* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
>  #define CXL_DVSEC_PORT_GPF					4
> +#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
> +#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
> +#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
> +#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
> +#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
> +#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
>  
>  /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
>  #define CXL_DVSEC_DEVICE_GPF					5
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index f9c95996e937..a39e2c52d7ab 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -85,6 +85,14 @@ static int cxl_nvdimm_probe(struct device *dev)
>  	if (!nvdimm)
>  		return -ENOMEM;
>  
> +	/*
> +	 * Set dirty shutdown now, with the expectation that the device
> +	 * clear it upon a successful GPF flow. The exception to this
> +	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
> +	 */
> +	if (cxl_dirty_shutdown_state(mds))
> +		dev_warn(dev, "GPF: could not dirty shutdown state\n");
> +
>  	dev_set_drvdata(dev, nvdimm);
>  	return devm_add_action_or_reset(dev, unregister_nvdimm, nvdimm);
>  }


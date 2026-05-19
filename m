Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A00258EF3
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151984; cv=none; b=SnmAWzUdx7g1T2m0k2JIduLEJHRYx732ssx8AL3E9FaI9hNR3/kXbUHAO2RkghHCjocq2XZNDcIsy4ROz1cdv+2teQ/pKQYq00VnsrPR3eD7fXyN0cpubP3nKpaYXxE2/WzET3Iabyvs1VSv6eEePLG7eVD61ezers+LXk9P6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151984; c=relaxed/simple;
	bh=IfvQ2xNK4H4z2s/UlyjNjyU/cfJE0SlDGuvilv+6qCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHmhahPkvC5bPlCYRot5dkq/aYptc9TLtxOAb3l5X1POJI2PxwpCCYs8xgHLvcqEPmzGA9F/SrvoaHJztV5XKTt+t1pIb7GM02HhmK318RsFscMkimcHnlL1uBFW5gZgr8NYoS8bZSUncYTKeesdc25yTW7FvhKn31sy8aW9yzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mALz2pLW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mALz2pLW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779151981; x=1810687981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IfvQ2xNK4H4z2s/UlyjNjyU/cfJE0SlDGuvilv+6qCc=;
  b=mALz2pLWrzfGx9p7hi2pMDgkhTUI4lJVz4DYuLbStBU+tvfE7EHNLxop
   WAqNYzhcdVcR6qrphpWexMKD/F1JB8t/KFdGpZJX8wdgdNhRPL8AFwU7Z
   onibslzYQlcM6iSxq5rNF+kWHNRORG8KCvoSez9Rn0H/Bf2Ud1PFzyfxv
   n1rUdWZqVgS0DJ1/zWpBFKgPiaotVhsloDZVPgXwaA5OApVBaELjOUb9R
   pDhahJC9Cmrgm6/rrvuSWX3Uf5iIBuXB1/KY6WsGtBtDgX4qJB0fZDTNL
   tm0Spl/rgfB1xkx/2O+dIhRbKmQNn5AS77QcuqOfbABsg1yEK1IJkwOC8
   w==;
X-CSE-ConnectionGUID: 6mTVFRFzRaCZxCdENQ6t3w==
X-CSE-MsgGUID: hc8Va4hpTe+0DBv18VFzyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="90716076"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="90716076"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 17:53:00 -0700
X-CSE-ConnectionGUID: C4lQqBO7SQKbEBDl8unFXQ==
X-CSE-MsgGUID: 0ve5INxbQQSkmYpveX8W+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233211602"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.65]) ([10.125.109.65])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 17:53:00 -0700
Message-ID: <e83cae66-8d61-45c3-b90a-93d1efe36cc0@intel.com>
Date: Mon, 18 May 2026 17:52:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] cxl/pci: Add BI topology enable/disable
To: Davidlohr Bueso <dave@stgolabs.net>, djbw@kernel.org
Cc: jic23@kernel.org, benjamin.cheatham@amd.com, alucerop@amd.com,
 alison.schofield@intel.com, ira.weiny@intel.com, gourry@gourry.net,
 dongjoo.seo1@samsung.com, anisa.su@samsung.com, linux-cxl@vger.kernel.org
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <20260516022037.1761453-3-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260516022037.1761453-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 7:20 PM, Davidlohr Bueso wrote:
> Implement cxl_bi_setup(), which walks the CXL port topology to enable
> BI flows on the device and every component in the path between the
> device and the root port. The walk is two-pass: first to verify each
> component advertises BI capability, then to write BI Enable on each
> dport's BI Decoder Control register and on the device. On failure
> during the enable pass, partially-enabled dports are rolled back.
> 
> The teardown counterpart, cxl_bi_dealloc(), runs automatically on
> cxl_mem unbind.
> 
> cxl_bi_setup() does not touch HDM decoder configuration -- the BI bit
> in each decoder is programmed separately at commit time. After a
> successful setup the device is BI-capable but not yet using BI for
> decode coherence.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/pci.c | 319 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  28 ++++
>  include/cxl/cxl.h      |   2 +
>  3 files changed, 349 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..7029055217c3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/string_choices.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -926,3 +927,321 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
> +{
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +

Maybe add a comment for this helper that that BI_RT is only for upstream ports?


> +/* limit any insane timeouts from hw */
> +#define CXL_BI_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
> +
> +static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
> +					     unsigned int scale,
> +					     unsigned int base)
> +{
> +	static const unsigned long scale_tbl[] = {
> +		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
> +	};
> +
> +	if (scale >= ARRAY_SIZE(scale_tbl)) {
> +		dev_dbg(dev, "Invalid BI commit timeout scale: %u\n", scale);
> +		return CXL_BI_COMMIT_MAXTMO_US;
> +	}
> +
> +	return scale_tbl[scale] * base;
> +}
> +
> +#define ___cxl_bi_commit(dev, bi, ctype)				\
> +do {									\
> +	u32 status, ctrl;						\
> +	unsigned int scale, base;					\
> +	ktime_t tmo, now, start;					\
> +	unsigned long poll_us, tmo_us;					\
> +									\
> +	ctrl = readl(bi + CXL_BI_##ctype##_CTRL_OFFSET);		\
> +	writel(ctrl & ~CXL_BI_##ctype##_CTRL_BI_COMMIT,			\
> +	       (bi) + CXL_BI_##ctype##_CTRL_OFFSET);			\
> +	writel(ctrl | CXL_BI_##ctype##_CTRL_BI_COMMIT,			\
> +	       (bi) + CXL_BI_##ctype##_CTRL_OFFSET);			\
> +									\
> +	status = readl((bi) + CXL_BI_##ctype##_STATUS_OFFSET);		\
> +	scale = FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMIT_TM_SCALE,	\
> +			  status);					\
> +	base = FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMIT_TM_BASE,	\
> +			 status);					\
> +									\
> +	/* ... and poll */						\
> +	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,		\
> +		       __cxl_bi_get_timeout_us((dev), scale, base));	\
> +	poll_us = tmo_us / 10; /* arbitrary 10% of timeout */		\

Any chance that poll_us end up being 0 because tmo_us is less than 10 and that creates a tight spin polling loop? Maybe
poll_us = max(poll_us, 1) to deal with a 0 value? Or some sane default min poll value.

> +	start = now = ktime_get();					\
> +	tmo = ktime_add_us(now, tmo_us);				\
> +	while (!FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMITTED, status) && \
> +	       !FIELD_GET(CXL_BI_##ctype##_STATUS_BI_ERR_NOT_COMMITTED,	\
> +			  status)) {					\
> +		if (ktime_after(now, tmo)) {				\
> +			dev_dbg((dev), "BI-ID commit timed out (%luus)\n", \
> +				tmo_us);				\
> +			return -ETIMEDOUT;				\
> +		}							\
> +									\
> +		fsleep(poll_us);					\
> +		now = ktime_get();					\
> +		status = readl((bi) + CXL_BI_##ctype##_STATUS_OFFSET);	\
> +	}								\
> +									\
> +	if (FIELD_GET(CXL_BI_##ctype##_STATUS_BI_ERR_NOT_COMMITTED, status)) \
> +		return -EIO;						\
> +									\
> +	dev_dbg((dev), "BI-ID commit wait took %lluus\n",		\
> +		ktime_to_us(ktime_sub(now, start)));			\
> +} while (0)

There has to be a cleaner way to do this instead of this huge macro? I think Ben mentioned this in v1. And I don't particularly like it either.


> +
> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)

I do wonder if 'struct cxl_component_regs *' would be better passed in than allowing arbitrary iomem addr.

> +{
> +	if (!bi)
> +		return 0;
> +
> +	if (FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
> +		      readl(bi + CXL_BI_RT_CAPS_OFFSET)))
> +		___cxl_bi_commit(dev, bi, RT);
> +
> +	return 0;
> +}
> +
> +static int __cxl_bi_commit(struct device *dev, void __iomem *bi)
> +{
> +	if (!bi)
> +		return -EINVAL;
> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
> +		return 0;
> +
> +	___cxl_bi_commit(dev, bi, DECODER);
> +	return 0;
> +}
> +
> +/* Enable or dealloc BI-ID changes in the given level of the topology. */
> +static int cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)

I don't particularly care for the bool for toggle. Please either use an enum for readability or use wrapper functions i.e.
cxl_bi_ctrl_dport_enable() / _disable().

> +{
> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
> +	void __iomem *bi = dport->regs.bi_decoder;
> +	struct cxl_port *port = dport->port;
> +	u32 ctrl, value;
> +	int rc;
> +
> +	guard(device)(&port->dev);
> +
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		if (enable) {
> +			/*
> +			 * There is no point of failure from here on,
> +			 * BI will be enabled on the endpoint device.
> +			 */
> +			port->nr_bi++;
> +
> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl))
> +				return 0;
> +
> +			value = ctrl | CXL_BI_DECODER_CTRL_BI_FW;
> +			value &= ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (WARN_ON_ONCE(port->nr_bi == 0))
> +				return -EINVAL;
> +			if (--port->nr_bi > 0)
> +				return 0;
> +
> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +		return 0;
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (enable) {
> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
> +			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
> +				return 0;
> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +		rc = __cxl_bi_commit(dport->dport_dev, bi);
> +		if (rc)
> +			return rc;
> +
> +		return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
> +{
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	void __iomem *bi = endpoint->regs.bi_decoder;
> +	u32 ctrl, val;
> +
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	if (enable) {
> +		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			WARN_ON_ONCE(!cxlds->bi);
> +			return 0;
> +		}
> +		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	} else {
> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			WARN_ON_ONCE(cxlds->bi);
> +			return 0;
> +		}
> +		val = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	}
> +
> +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	cxlds->bi = enable;
> +
> +	dev_dbg(cxlds->dev, "BI requests %s\n",
> +		str_enabled_disabled(enable));
> +
> +	return 0;
> +}
> +
> +/*
> + * devm teardown on cxl_mem unbind. Endpoint decoders may still be
> + * committed here (cxl_workqueue tears them down asynchronously), but
> + * memory access has been quiesced.
> + */
> +static void cxl_bi_dealloc(void *data)
> +{
> +	struct cxl_dev_state *cxlds = data;
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_dport *dport, *_dport;
> +	struct cxl_port *port;
> +
> +	struct cxl_port *_port __free(put_cxl_port) =
> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &_dport);
> +
> +	if (!_port || !cxlds->bi)
> +		return;
> +
> +	if (endpoint) {
> +		scoped_guard(rwsem_read, &cxl_rwsem.region)
> +			cxl_bi_ctrl_endpoint(cxlds, false);
> +	} else {
> +		/*
> +		 * Endpoint already removed: regions torn down and
> +		 * decoders uncommitted. Endpoint BI registers are no
> +		 * longer mapped; just clear the flag.
> +		 */
> +		cxlds->bi = false;
> +	}
> +
> +	port = _port;
> +	dport = _dport;
> +	while (!is_cxl_root(port)) {
> +		int rc = cxl_bi_ctrl_dport(dport, false);
> +
> +		/* best effort */
> +		if (rc)
> +			dev_dbg(&port->dev,
> +				"BI dport disable failed: %d\n", rc);
> +
> +		dport = port->parent_dport;
> +		port = dport->port;
> +	}
> +}
> +
> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	struct cxl_dport *dport, *_dport, *failed;
> +	struct cxl_port *port;
> +	int rc;
> +
> +	struct cxl_port *_port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &_dport);
> +
> +	if (!_port)
> +		return -EINVAL;
> +
> +	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi_decoder))
> +		return 0;
> +
> +	/* walkup the topology twice, first to check, then to enable */
> +	port = _port;
> +	dport = _dport;
> +	while (!is_cxl_root(port)) {
> +		/* check rp, dsp */
> +		if (!cxl_is_bi_capable(to_pci_dev(dport->dport_dev),
> +				       dport->regs.bi_decoder))
> +			return -EINVAL;
> +
> +		/* check usp */
> +		if (dev_is_pci(port->uport_dev) &&
> +		    pci_pcie_type(to_pci_dev(port->uport_dev)) ==
> +			    PCI_EXP_TYPE_UPSTREAM)
> +			if (!cxl_is_bi_capable(to_pci_dev(port->uport_dev),
> +					       port->regs.bi_rt))
> +				return -EINVAL;
> +
> +		dport = port->parent_dport;
> +		port = dport->port;
> +	}
> +
> +	port = _port;
> +	dport = _dport;
> +	while (!is_cxl_root(port)) {
> +		rc = cxl_bi_ctrl_dport(dport, true);
> +		if (rc)
> +			goto err_rollback;
> +
> +		dport = port->parent_dport;
> +		port = dport->port;
> +	}
> +
> +	/* finally, enable BI on the device */
> +	cxl_bi_ctrl_endpoint(cxlds, true);

ignoring returned error. if endpoint fail to enable, do you need to rollback and skip the dealloc registration?

DJ

> +
> +	return devm_add_action_or_reset(&cxlds->cxlmd->dev,
> +					cxl_bi_dealloc, cxlds);
> +
> +err_rollback:
> +	/*
> +	 * Undo all dports enabled so far, including the failed one.
> +	 */
> +	failed = dport;
> +	dport = _dport;
> +	port = _port;
> +	while (!is_cxl_root(port)) {
> +		cxl_bi_ctrl_dport(dport, false);
> +		if (dport == failed)
> +			break;
> +		dport = port->parent_dport;
> +		port = dport->port;
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 760f51b43891..564cdcd9409e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -167,6 +167,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_HEADERLOG_SIZE SZ_512
>  #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
>  
> +/* CXL 4.0 8.2.4.26 CXL BI Route Table Capability Structure */
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
> +/* CXL 4.0 8.2.4.27 CXL BI Decoder Capability Structure */
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
> @@ -553,6 +578,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @nr_bi: number of BI-enabled endpoints below this port
>   * @component_reg_phys: Physical address of component register
>   */
>  struct cxl_port {
> @@ -578,6 +604,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	int nr_bi;
>  	resource_size_t component_reg_phys;>  };
>  
> @@ -906,6 +933,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_bi_setup(struct cxl_dev_state *cxlds);
>  struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  					    struct device *dport_dev);
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 8ce9b4e9ca73..4938e93edb63 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -168,6 +168,7 @@ struct cxl_dpa_partition {
>   * @regs: Parsed register blocks
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @bi: device is BI (Back-Invalidate) enabled
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
>   * @part: DPA partition array
> @@ -187,6 +188,7 @@ struct cxl_dev_state {
>  	struct cxl_device_regs regs;
>  	int cxl_dvsec;
>  	bool rcd;
> +	bool bi;
>  	bool media_ready;
>  	struct resource dpa_res;
>  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];


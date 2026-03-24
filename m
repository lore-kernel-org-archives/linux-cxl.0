Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD215B0EC
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311682; cv=none; b=Vx5LYX5jVlXmEhi5nQVADoUiPDuL57QHkGmBT/Oodrx59GGUH+ktMACC3GOGFYNIqCgk09NasdDB+8vKnwtXeMA2E8hsjvk0rwaVDwYuwT5UMauI3caR6fFviSt2L75kF4SO98G2Dd+hKS7IYQJ/IbtA5C8eY9U6OtWDmesS+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311682; c=relaxed/simple;
	bh=cLs6HYKFMIZRCN/4nLo2tz/fa1Qx+to+y6S2x6B8K4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Au4GL3sU1BgDtgsxSNWH2h8SLarkJT5ez67agVWXCWw6Ok7sTbJhSpInzcYWqKoFR9jK7nbFnlbccxBDzncQhpKNTVcSkpqJv88f+7zq7o2t8GuPhuTMlUasZRQi8KtQicM5i6mIX0zaosy2FYMMNb7CmwfaqjPG3V5A21xux3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a76HSbrt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a76HSbrt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774311680; x=1805847680;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cLs6HYKFMIZRCN/4nLo2tz/fa1Qx+to+y6S2x6B8K4E=;
  b=a76HSbrtR3xXYjTNZD+HRqT5cjJP/AkOYD7SVKTQvmIcS2dXbGzj19k9
   6LMrjdSZip67xWmK/1lg+qf00QR1WjDpbLuw/c/xM2e9veCEt+Ojovdne
   izbVGlZ9sh669h6eC6G4F2hdUBwOICFgcTpbn9e6oOndfUkBKviNS86lm
   9I3/A3Ray/36/TuuETHRmkIuoh1/WaxuMPfFkML3rzct6lP00rPxFx9CH
   M0xGvrF1H85XY9Chzu5tqU1ZDXRjbuPmhW6MgMvy7libLvwAo2Wb7SZIy
   zAprb6u6PWO/1H3pthObW7MfEWBz9GJpYhbt9FVCVVAzel1p3yyqGkp30
   w==;
X-CSE-ConnectionGUID: mHSwr2K7RqahBzvhitGqkg==
X-CSE-MsgGUID: mve0GLPkQSKoMZ69XTmn1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="85631382"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="85631382"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:21:20 -0700
X-CSE-ConnectionGUID: PskX/rBET6WqkDgYMCYtkA==
X-CSE-MsgGUID: PJxj+fcMTq2V6u7RcaCE3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228928319"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.216]) ([10.125.109.216])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:21:18 -0700
Message-ID: <e9530037-9173-4c78-8a2b-69faae07d2a8@intel.com>
Date: Mon, 23 Mar 2026 17:21:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] cxl/pci: Add Back-Invalidate topology enable/disable
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, gourry@gourry.net, dongjoo.seo1@samsung.com,
 anisa.su@samsung.com, linux-cxl@vger.kernel.org
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-4-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260315202741.3264295-4-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/26 1:27 PM, Davidlohr Bueso wrote:
> Implement cxl_bi_setup() and cxl_bi_dealloc() which walk the CXL port
> topology to enable/disable BI flows on all components in the path.
> 
> Upon a successful setup, this enablement does not influence the current
> HDM decoder setup by enabling the BI bit, and therefore the device is left
> in a BI capable state, but not making use of it in the decode coherence.
> Upon a BI-ID removal event, it is expected for the device to be offline.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/pci.c | 339 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 339 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..5f0226397dfa 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -926,3 +926,342 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
> +{
> +	if (!cxl_pci_flit_256(pdev))
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* limit any insane timeouts from hw */
> +#define CXL_BI_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
> +
> +static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
> +					     int scale, int base)
> +{
> +	static const unsigned long scale_tbl[] = {
> +		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
> +	};
> +
> +	if (scale >= ARRAY_SIZE(scale_tbl)) {
> +		dev_dbg(dev, "Invalid BI commit timeout scale: %d\n", scale);
> +		return CXL_BI_COMMIT_MAXTMO_US;
> +	}
> +
> +	return scale_tbl[scale] * base;
> +}
> +
> +#define ___cxl_bi_commit(dev, bi, ctype)				\
> +do {									\
> +	u32 status, ctrl;						\
> +	int scale, base;						\
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

This is pretty ugly. Can you use a macro to do string subst within this function? Maybe something that spits back out the identifier that concats everything together like:

#define CONCAT_CXL_BI(ctype, suffix) CXL_BI_##ctype##_##suffix

DJ

> +
> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
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
> +	___cxl_bi_commit(dev, bi, DECODER);
> +	return 0;
> +}
> +
> +/* enable or dealloc BI-ID changes in the given level of the topology */
> +static int cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
> +{
> +	u32 ctrl, value;
> +	void __iomem *bi = dport->regs.bi;
> +	struct cxl_port *port = dport->port;
> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
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
> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
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
> +
> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +		if (FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +			      readl(bi + CXL_BI_DECODER_CAPS_OFFSET))) {
> +			int rc = __cxl_bi_commit(dport->dport_dev,
> +						 dport->regs.bi);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		return __cxl_bi_commit_rt(&port->dev, port->uport_regs.bi);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
> +{
> +	u32 ctrl, val;
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	void __iomem *bi = endpoint->regs.bi;
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
> +	dev_dbg(cxlds->dev, "device %scapable of issuing BI requests\n",
> +		enable ? "" : "in");
> +
> +	return 0;
> +}
> +
> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	struct cxl_dport *dport, *_dport, *failed;
> +	struct cxl_port *parent_port, *port;
> +	int rc;
> +
> +	struct cxl_port *_port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &_dport);
> +
> +	if (!_port)
> +		return -EINVAL;
> +
> +	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi))
> +		return 0;
> +
> +	/* walkup the topology twice, first to check, then to enable */
> +	port = _port;
> +	dport = _dport;
> +	while (1) {
> +		parent_port = to_cxl_port(port->dev.parent);
> +		/* check rp, dsp */
> +		if (!cxl_is_bi_capable(to_pci_dev(dport->dport_dev),
> +				       dport->regs.bi))
> +			return -EINVAL;
> +
> +		/* check usp */
> +		if (pci_pcie_type(to_pci_dev(dport->dport_dev)) ==
> +		    PCI_EXP_TYPE_DOWNSTREAM) {
> +			if (!cxl_is_bi_capable(to_pci_dev(port->uport_dev),
> +					       port->uport_regs.bi))
> +				return -EINVAL;
> +		}
> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		dport = port->parent_dport;
> +		port = parent_port;
> +	}
> +
> +	port = _port;
> +	dport = _dport;
> +	while (1) {
> +		parent_port = to_cxl_port(port->dev.parent);
> +
> +		rc = cxl_bi_ctrl_dport(dport, true);
> +		if (rc)
> +			goto err_rollback;
> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		dport = port->parent_dport;
> +		port = parent_port;
> +	}
> +
> +	/* finally, enable BI on the device */
> +	cxl_bi_ctrl_endpoint(cxlds, true);
> +	return 0;
> +
> +err_rollback:
> +	/*
> +	 * Undo all dports enabled so far by re-walking from the bottom
> +	 * up to (but not including) the failed dport.
> +	 */
> +	failed = dport;
> +	dport = _dport;
> +	port = _port;
> +	while (dport != failed) {
> +		parent_port = to_cxl_port(port->dev.parent);
> +
> +		cxl_bi_ctrl_dport(dport, false);
> +		if (is_cxl_root(parent_port))
> +			break;
> +		dport = port->parent_dport;
> +		port = parent_port;
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
> +
> +int cxl_bi_dealloc(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_port *parent_port, *port;
> +	struct cxl_dport *dport, *_dport;
> +
> +	struct cxl_port *_port __free(put_cxl_port) =
> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &_dport);
> +
> +	if (!_port)
> +		return -EINVAL;
> +
> +	if (!cxlds->bi)
> +		return 0;
> +
> +	if (endpoint) {
> +		/* ensure the device is offline and unmapped */
> +		scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +			if (cxl_num_decoders_committed(endpoint) > 0)
> +				return -EBUSY;
> +		}
> +
> +		/* first, disable BI on the device */
> +		cxl_bi_ctrl_endpoint(cxlds, false);
> +	} else {
> +		/*
> +		 * Teardown path: the endpoint was already removed, which
> +		 * tears down regions and uncommits decoders. The endpoint
> +		 * BI registers are no longer mapped so just clear the flag
> +		 * and walk the dports below.
> +		 */
> +		cxlds->bi = false;
> +	}
> +
> +	port = _port;
> +	dport = _dport;
> +	while (1) {
> +		int rc;
> +
> +		parent_port = to_cxl_port(port->dev.parent);
> +
> +		rc = cxl_bi_ctrl_dport(dport, false);
> +		if (rc)
> +			return rc;
> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		dport = port->parent_dport;
> +		port = parent_port;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_dealloc, "CXL");


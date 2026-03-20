Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9C194A6C
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024033; cv=none; b=p7kUz7now6Xa3DagxnHdmNxa98g5Fcyw4T1wsRIGqsgWlqNvnM2x6isyjzi2tT6TsSCQZb2a+WOfa30UZTyoJTKLrrWQxH24xwrR0IKX5ptc2GE5ejiKy56v1RAfirr9leFeL/VTzfO+zkSWvMuuM3SuetYNypynhw0zNt6mjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024033; c=relaxed/simple;
	bh=q3688lbr78iUbQljY+rnsI26SazckpYyK+HOYy6RcZ8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afih278s6Diun4iVjqbVqurjWB8k5FdkwUKYcyz8VloKRXaonk/GVbiHa4RQulG9fqOrsFolbiQhg66RjY+e2i8/gfdX4P3ZhHYeeXojyC0SESzrk0ZbqD307oExtiX0iMCWt3IQFgpvY0bYTrAtmSawwNtsUQz6El8ntaPzmgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fcnxT5HpYzJ467l;
	Sat, 21 Mar 2026 00:26:05 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 06AF440587;
	Sat, 21 Mar 2026 00:27:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 16:27:06 +0000
Date: Fri, 20 Mar 2026 16:27:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <gourry@gourry.net>,
	<dongjoo.seo1@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/6] cxl/pci: Add Back-Invalidate topology enable/disabl
Message-ID: <20260320162705.00004440@huawei.com>
In-Reply-To: <20260315202741.3264295-4-dave@stgolabs.net>
References: <20260315202741.3264295-1-dave@stgolabs.net>
	<20260315202741.3264295-4-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 15 Mar 2026 13:27:38 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Implement cxl_bi_setup() and cxl_bi_dealloc() which walk the CXL port
> topology to enable/disable BI flows on all components in the path.
> 
> Upon a successful setup, this enablement does not influence the current
> HDM decoder setup by enabling the BI bit, and therefore the device is left
> in a BI capable state, but not making use of it in the decode coherence.
> Upon a BI-ID removal event, it is expected for the device to be offline.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Various things inline.

> ---
>  drivers/cxl/core/pci.c | 339 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 339 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..5f0226397dfa 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

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
See below. I'd do
	if (FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
		      readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
		___cxl_bi_commit(dev, bi, DECODER);

and call this function unconditionally.

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

This stuff is odd enough that I'd throw a reference it for table 9-13
Downtstream Port Handling of BIsnp.  Confused me that we were turning
off forwarding, but we aren't. We are simply performing checks before
doing so!

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
Why check externally here internally in __cxl_bi_commit_rt?
I'd do same in both cases (proabbly move the check inside for this one)

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

Why check the type for the dport_dev rather than
checking the type of to_pci_dev(port->uport_dev) + if it's a pci dev
in the first place?

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

I wonder if we can construct an iterator macro to do this walk.

Something like (completely untested and maybe horribly broken)
#define for_cxl_port_to_root(port, dport) \
	for (struct cxl_port *parent_port = to_cxl_port(port->dev.parent); \
	     !is_cxl_root(parent_port); \
	     dport = port->parent_port, port = parent_port, parent_port = to_cxl_port(port->dev.parent))

used as
	port = _port;
	dport = _dport;
	for_cxl_port_to_root(port, dport) {
		if (!cxl_is_bi_capable(to_pci_dev(dport->dport_dev),
				       dport->regs.bi))
			return -EINVAL;

		if (pci_pcie_type(to_pci_dev(dport->dport_dev)) ==
		    PCI_EXP_TYPE_DOWNSTREAM)
			if (!cxl_is_bi_capable(to_pci_dev(port->uport_dev),
					       port->uport_regs.bi))
				return -EINVAL;
		}			
	}
	port = _port;
	dport = _dport;
	for_cxl_port_to_root(port, dport) {
		rc = cxl_bi_ctrl_dport(dport, true);
		if (rc)
			goto err_rollback;
	}

May not worth it if there aren't more instances of this already that
we can also use it for.

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

One time check enough?  I've not checked but are we holding
something else to prevent a race immediately after this before
cxl_bi_ctrl_endpoint() is called?

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

> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;

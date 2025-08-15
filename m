Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B651E51EB
	for <linux-cxl@vger.kernel.org>; Fri, 15 Aug 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271220; cv=none; b=eLOkHEP5CRDkpWGYK4HsWUD55RV5l12X3RC4ha2OA4bTBKQW+frdQGiY2aMljoSiXwdfQsdd9Xar4yjzjkWye3SXhPaDr0eWT6OvqjEvstn1QHUup+2UBN28JocOa7y8JWt7PtZ9/Uw54NkQJNDWqZj+HJPhWJdFVucdcNhqLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271220; c=relaxed/simple;
	bh=cMbQprP3STpUwYYw/mC2R0n5t8Xy6GdNfSJflOcKsyI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssl/mF8O6n970noA6JHuBqvGtJABdyp8m0XhUAbzaY7PN8hIdkLffHBXymi522fdI8VExlb7w4SOca+w16ecSpZaW90+vSjGVvkCwTKIVTbQC01bftnAbUH064wWjvbyfKN20u70Q6kzUaTAOQjFpQXYVWr4SKMTxNNMBtNBXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3Qdv0jBvz67GCQ;
	Fri, 15 Aug 2025 23:15:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AA3ED1404D8;
	Fri, 15 Aug 2025 23:20:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 17:20:13 +0200
Date: Fri, 15 Aug 2025 16:20:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/pci: Back-Invalidate device discovery and setup
Message-ID: <20250815162011.000005a6@huawei.com>
In-Reply-To: <20250812010228.2589787-2-dave@stgolabs.net>
References: <20250812010228.2589787-1-dave@stgolabs.net>
	<20250812010228.2589787-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 11 Aug 2025 18:02:26 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Introduce two calls to enable/setup and disable/dealloc BI flows,
> adding the general cachemem register plumbing.
> 
>   int cxl_bi_setup(struct cxl_dev_state *cxlds);
>   int cxl_bi_dealloc(struct cxl_dev_state *cxlds);
> 
> Both do the required hierarchy iteration ensuring it is safe to
> enable/disable BI for every component. Upon a successful setup,
> this enablement does not influence the current HDM decoder setup
> by enabling the BI bit, and therefore the device is left in a
> BI capable state, but not making use of it in the decode coherence.
> Upon a BI-ID removal event, it is expected for the device to
> be offline.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

This gets a little complex, so this is very much a first look review rather
than giving any feedback on the overall approach.

J
> ---
>  drivers/cxl/core/pci.c  | 318 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |   2 +
>  drivers/cxl/core/regs.c |  13 ++
>  drivers/cxl/cxl.h       |  40 +++++
>  drivers/cxl/cxlmem.h    |   2 +
>  drivers/cxl/mem.c       |   2 +
>  drivers/cxl/pci.c       |   5 +
>  drivers/cxl/port.c      |  67 +++++++++
>  8 files changed, 449 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b50551601c2e..d0218e240f0e 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

> +/* limit any insane timeouts from hw */
> +#define CXL_BI_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
> +
> +static unsigned long __cxl_bi_get_timeout_us(int scale, int base)
> +{
> +	unsigned long tmo;
> +
> +	switch (scale) {
> +	case 0: /* 1 us */
> +		tmo = 1;
Maybe a look up table and range check is more compact?
> +		break;
> +	case 1: /* 10 us */
> +		tmo = 10UL;
> +		break;
> +	case 2: /* 100 us */
> +		tmo = 100UL;
> +		break;
> +	case 3: /* 1 ms */
> +		tmo = 1000UL;
> +		break;
> +	case 4: /* 10 ms */
> +		tmo = 10000UL;
> +		break;
> +	case 5: /* 100 ms */
> +		tmo = 100000UL;
> +		break;
> +	case 6: /* 1 s */
> +		tmo = 1000000UL;
> +		break;
> +	case 7: /* 10 s */
> +		tmo = 10000000UL;
> +		break;
> +	default:
> +		tmo = 0;
> +		break;
> +	}
> +
> +	return tmo * base;
> +}

> +
> +/* enable or dealloc BI-ID changes in the given level of the topology */
> +static int cxl_bi_toggle_dport(struct cxl_dport *dport, bool enable)
> +{
> +	u32 cap, ctrl, value;
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
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
Maybe a switch?
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
> +			if (--port->nr_bi > 0)
> +				return 0;
> +
> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);

Unless more code is coming in later patches, I'd return here
so reviewer doesn't need to go see what else happens.


> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
with return above this can be just
	if (pci_pcie_type...

> +		int rc;
> +
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
> +		cap = readl(bi + CXL_BI_DECODER_CAPS_OFFSET);
> +		if (FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ, cap)) {
> +			rc = __cxl_bi_commit(dport->dport_dev, dport->regs.bi);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		/* ... and the routing table, if any */
> +		rc = __cxl_bi_commit_rt(&port->dev, port->uport_regs.bi);
> +		if (rc)
> +			return rc;
	I'd do
		return __cxl_bi_commit_rt()
	}
	return -EINVAL;
> +	} else
> +		return -EINVAL;
else {


}
> +
> +	return 0;
> +}
> +
> +static int cxl_bi_toggle_endpoint(struct cxl_dev_state *cxlds, bool enable)

Something called toggle would normally not take an enable - it would just switch
between two states ever time.  So maybe rename?

> +{
> +	u32 ctrl, val;
> +	void __iomem *bi = cxlds->regs.bi;
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
> +		enable ? "":"in");
> +
> +	return 0;
> +}
> +
> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_dport *dport, *_dport;
> +	struct cxl_port *parent_port, *port, *_port __free(put_cxl_port) =
> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &_dport);
That is horrible! Lines aren't that expensive.

	struct cxl_port *parent_port, *port;
	struct cxl_port *_port __free(put_cxl_port) =
		cxl_pci_find_port(to_pci_dev(cxlds->dev), &_dport);

> +
> +	if (!_port)
> +		return -EINVAL;
> +
> +	if (!cxl_is_bi_capable(pdev, cxlds->regs.bi))
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

Similar to below comment on __free() applying to a non obvious successiosn
of things without previous one being obvious released as we'd expect.

> +	}
> +
> +	port = _port;
> +	dport = _dport;
> +	while (1) {
> +		int rc;
> +
> +		parent_port = to_cxl_port(port->dev.parent);
> +
> +		rc = cxl_bi_toggle_dport(dport, true);
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
> +	/* finally, enable BI on the device */
> +	cxl_bi_toggle_endpoint(cxlds, true);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
> +
> +int cxl_bi_dealloc(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_dport *dport;
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_port *parent_port, *port __free(put_cxl_port) =
> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &dport);

As above, mixing free and non free in one line is not pretty.
Split them up.

> +
> +	if (!port)
> +		return -EINVAL;
> +
> +	/* ensure the device is offline and unmapped */
> +	if (!endpoint || cxl_num_decoders_committed(endpoint) > 0)
> +		return -EBUSY;
> +
> +	if (!cxlds->bi)
> +		return 0;
> +
> +	/* first, disable BI on the device */
> +	cxl_bi_toggle_endpoint(cxlds, false);
> +
> +	while (1) {
> +		int rc;
> +
> +		parent_port = to_cxl_port(port->dev.parent);
> +
> +		rc = cxl_bi_toggle_dport(dport, false);
> +		if (rc)
> +			return rc;
> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		dport = port->parent_dport;
> +		port = parent_port;

Reassigning port with a __free() in use on it looks complex at best.
I've lost track of what put_cxl_port() ends up being called on or where
we got a reference to that.

> +	}
> +
> +	cxlds->bi = false;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_dealloc, "CXL");
> +
>  /*
>   * Set max timeout such that platforms will optimize GPF flow to avoid
>   * the implied worst-case scenario delays. On a sane platform, all

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b7111e3568d0..6361365c5ce9 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h


>  /**
> @@ -905,6 +942,9 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_bi_setup(struct cxl_dev_state *cxlds);
> +int cxl_bi_dealloc(struct cxl_dev_state *cxlds);


> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index fe4b593331da..1c86198c190b 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c

> +static void cxl_switch_port_init_bi(struct cxl_port *port)
> +{
> +	struct cxl_dport *parent_dport = port->parent_dport;
> +
> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))

This is pretty common bit of code, maybe we should name it via
a #define.  I'm not entirely sure (as get lost in these)
but is it detecting whether we are on a host bridge?


> +		return;
> +
> +	if (dev_is_pci(&port->dev) && !cxl_pci_flit_256(to_pci_dev(&port->dev)))
> +		return;
> +
> +	if (parent_dport && dev_is_pci(parent_dport->dport_dev)) {
> +		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
> +
> +		switch (pci_pcie_type(pdev)) {
> +		case PCI_EXP_TYPE_ROOT_PORT:
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			cxl_dport_init_bi(parent_dport);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	cxl_uport_init_bi(port, &port->dev);
> +}



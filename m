Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E42F7EFF
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936834; cv=pass; b=sedQtf1jYr5TgS2vUNScntiaKJn9R3hfCA1tlOxm+pqD2NQOpOERzfZO1f6SQ2L/Mxpk3K8Ga+vyyzYa1r3uXQfTk5ZMts6pE3GI0X/WwuUVUGN607dv3lt32X54SItC8RpKsL8/eTexTCTPYZ+Nk4JyqPIYf3DAE1WJ4RekeuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936834; c=relaxed/simple;
	bh=oG98BkkOHotCn1hBlZ/6yg/vb6B3Nc34ays+GH1ojfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mr+kO6ArTrHg9+JmtolZ7Wcst4p8Z0z5LO4+HYlDUZjLfsHEAUUJxnOuLbUlRlG+mbqJttjeT17P05guu/ASZtWcRky3CKEnxABdR0e7gGqHo19orS+P7ebwuROa4qrOn9cWYypK4auQ2PBquNqGBKsmpu6ZoOaXT9eRNLE5eh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RDOPcN8p; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RDOPcN8p"
ARC-Seal: i=1; a=rsa-sha256; t=1785936818; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TmF2xlab0flQDbqgB62I2Du/VG2LUjdnNaB2SYscQC5QvLIseQ0uFiap6Z6ewOZtK1Q/nfa8YxQmL5EO1IBVw3KZxTiumgv3zkNxZidZKEJOHBb1SSuqxgntMfkMB7B7PYXFlB0etqKzrjsvZqamSdOCjeeiN1DDGWNTAtDvbGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785936818; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xb1tqnES7dUCwJdbqYxDurejTKs4KXOJGRt3fNnmvKA=; 
	b=jnyuKUYMOzhwhSDgyHzujCq+5Q6JpnVEjmcAiK1X7HNPZZfJV20r+uW9w+6N/0ozrzPFFNrNufQ8zhL5gh86Hhfc+9JRCUmYOIXiQBPVT1V8Ce5V4ZqwIRNurJA6FeqIkzcEuc1hwq1SA/Rublv7KOBRfxCfA++Dg/E+JCmckro=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785936818;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=xb1tqnES7dUCwJdbqYxDurejTKs4KXOJGRt3fNnmvKA=;
	b=RDOPcN8p0C8sTcAjiQ/WrqF+tWFYldxFSVpfU9PoOcj2kBeIKuR0CqRnlGMQOBO8
	yGfLKPQgPJOz1llqq7hiU/CvKlEj+Ikot08lQreh2o+YzVTTIkeZvu5zr8pS8na+lrG
	4erYh8fFagdnd/kmFPPigLDUe5XOcUU82f4w1odA=
Received: by mx.zohomail.com with SMTPS id 1785936815977464.95693075929694;
	Wed, 5 Aug 2026 06:33:35 -0700 (PDT)
Message-ID: <a417b52b-41a7-4f90-9231-6abf82ee22a6@zohomail.com>
Date: Wed, 5 Aug 2026 21:33:26 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/8] cxl/pci: Add BI topology enable/disable
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, dongjoo.seo1@samsung.com,
 linux-cxl@vger.kernel.org, dave.jiang@intel.com
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-3-dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260728144136.709882-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112272dc782136889d8165710b92f000040277e8fa295913fd82cbec1140a330042cd03db495051d1fe:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 7/28/2026 10:41 PM, Davidlohr Bueso wrote:
> Implement cxl_bi_setup() to enable BI flows on the device and every
> component in the path, and its teardown counterpart cxl_bi_dealloc().
> Both run from cxl_endpoint_port_probe(): the BI-ID and path
> enablement belong to the endpoint port's lifetime.
>
> Setup is safe in endpoint port probe context: the port probes
> synchronously from cxl_mem_probe(), pinning the memdev state the
> walk consumes, and the whole ancestor path already exists with BI
> registers mapped (dports at dport-add time, the switch USP RT at
> first-dport setup) because devm_cxl_enumerate_ports() completes
> before the endpoint is created.
>
> Dealloc is safe in endpoint devres context: both setup and dealloc
> walk the endpoint's parent_dport topology rather than getting the
> port by bus lookup - an ancestor teardown delists the parent port
> before the endpoint's devres runs.
>
> The topology walk is stable as parent_dport pointers are fixed at
> port creation; ancestors cannot be reaped while holding this
> memdev's cxl_ep; and their own teardown frees dports only after
> the endpoint is gone.
>
> The device state holds up as well: cxlmd->cxlds is nulled only
> after cxl_memdev_unregister() has torn the endpoint down, and
> delete_endpoint() clears cxlmd->endpoint only after the endpoint
> devres has run.
>
> With dealloc in the endpoint's devres, delete_endpoint() already
> holds the parent port's device lock, so to avoid deadlocking, add a
> per-port bi_lock, serializing only dports that share state (ie:
> sibling nr_bi on a root port, the switch USP's BI RT).
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/pci.c  | 379 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |   1 +
>  drivers/cxl/cxl.h       |  30 ++++
>  drivers/cxl/port.c      |   4 +
>  include/cxl/cxl.h       |   2 +
>  5 files changed, 416 insertions(+)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f82559d8a8c5..a87c2ad9ac53 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -2,11 +2,13 @@
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/units.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/iopoll.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/string_choices.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -964,3 +966,380 @@ void devm_cxl_dport_bi_setup(struct cxl_dport *dport)
>  		break;
>  	}
>  }
> +/*
> + * BI requires 256B Flit operation on the link. RP/DSP/endpoint must
> + * also have the BI Decoder cap mapped (@bi); for USPs the BI RT cap
> + * is optional per CXL 4.0 8.2.4.26, so absent @bi is allowed.
> + */
> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
> +{
> +	if (!cxl_pci_flit_256(pdev))
> +		return false;
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
> +		return false;
> +	}
> +	return true;
> +}
> +
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
> +	if (scale >= ARRAY_SIZE(scale_tbl) || !base) {
> +		dev_dbg(dev, "Invalid BI commit timeout: scale=%u base=%u\n",
> +			scale, base);
> +		return CXL_BI_COMMIT_MAXTMO_US;
> +	}
> +
> +	return scale_tbl[scale] * base;
> +}
> +
> +static int __cxl_bi_wait_commit(struct device *dev, void __iomem *status_reg,
> +				u32 committed_bit, u32 err_bit,
> +				unsigned int scale, unsigned int base)
> +{
> +	unsigned long tmo_us, poll_us;
> +	ktime_t start;
> +	u32 status;
> +	int rc;
> +
> +	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,
> +		       __cxl_bi_get_timeout_us(dev, scale, base));
> +	poll_us = max_t(unsigned long, tmo_us / 10, 1); /* ~10% */
> +	start = ktime_get();
> +
> +	rc = readx_poll_timeout(readl, status_reg, status,
> +				status & (committed_bit | err_bit),
> +				poll_us, tmo_us);
> +	if (rc) {
> +		dev_err(dev, "BI-ID commit timed out (%luus)\n", tmo_us);
> +		return rc; /* -ETIMEDOUT */
> +	}
> +
> +	if (status & err_bit) {
> +		dev_err(dev, "BI-ID commit rejected by hardware\n");
> +		return -EIO;
> +	}
> +
> +	dev_dbg(dev, "BI-ID commit wait took %lluus\n",
> +		ktime_to_us(ktime_sub(ktime_get(), start)));
> +	return 0;
> +}
> +
> +/* BI RT only exists on switch upstream ports. */
> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_RT_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_RT_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
> +
> +	status = readl(bi + CXL_BI_RT_STATUS_OFFSET);
> +	scale = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE, status);
> +	base = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE, status);
> +
> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_RT_STATUS_OFFSET,
> +				    CXL_BI_RT_STATUS_BI_COMMITTED,
> +				    CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED,
> +				    scale, base);
> +}
> +
> +static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	status = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
> +	scale = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE, status);
> +	base = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE, status);
> +
> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_DECODER_STATUS_OFFSET,
> +				    CXL_BI_DECODER_STATUS_BI_COMMITTED,
> +				    CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED,
> +				    scale, base);
> +}
> +
> +/* Enable or dealloc BI-ID changes in the given level of the topology. */
> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
> +	void __iomem *bi = dport->regs.bi_decoder;
> +	struct cxl_port *port = dport->port;
> +	u32 ctrl, value;
> +	int rc;
> +
> +	guard(mutex)(&port->bi_lock);
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
> +			dport->nr_bi++;
> +
> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
> +			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
> +				return 0;
> +
> +			value = ctrl | CXL_BI_DECODER_CTRL_BI_FW;
> +			value &= ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (WARN_ON_ONCE(dport->nr_bi == 0))
> +				return -EINVAL;
> +			if (--dport->nr_bi > 0)
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
> +		rc = __cxl_bi_commit_decoder(dport->dport_dev, bi);
> +		if (rc)
> +			return rc;
> +
> +		if (port->regs.bi_rt)
> +			return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
> +		return 0;

I think another issue here is:

Per CXL r4.0 8.2.4.27.2 Table 8-157. the description of BI  Enable and BI Forward fields.

My understanding is that if a DSP or RP connects to a BI-Capable device directly, the BI Enable field should be set.

Which means if a BI-Capable device is connected to a root port directly, the BI Enable filed of the root port should be set.

In multiple switch levels case, only the last level DSP should set BI Enable filed, other DSPs and root port should set BI Forward.

But current implementation will set BI Enable on all DSPs, and set BI Forward on root port whatever the root port connects to BI-Capable device directly.

If my understanding is incorrect, please let me know. thanks


Ming

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport)
> +{
> +	return __cxl_bi_ctrl_dport(dport, true);
> +}
> +
> +static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
> +{
> +	return __cxl_bi_ctrl_dport(dport, false);
> +}
> +
> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
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
> +			if (cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already enabled in hardware\n");
> +			return -EBUSY;
> +		}
> +		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	} else {
> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			if (!cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already disabled in hardware\n");
> +			return -EBUSY;
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
> +static int cxl_bi_ctrl_endpoint_enable(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_bi_ctrl_endpoint(cxlds, true);
> +}
> +
> +static int cxl_bi_ctrl_endpoint_disable(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_bi_ctrl_endpoint(cxlds, false);
> +}
> +
> +/*
> + * devm teardown on endpoint port destruction. Endpoint decoders may
> + * still be committed here (cxl_workqueue tears them down
> + * asynchronously), but memory access has been quiesced.
> + */
> +static void cxl_bi_dealloc(void *data)
> +{
> +	struct cxl_port *endpoint = data;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_dport *dport_iter;
> +	struct cxl_port *port_iter;
> +
> +	if (!cxlds->bi)
> +		return;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		cxl_bi_ctrl_endpoint_disable(cxlds);
> +
> +	/*
> +	 * Walk the same parent_dport chain that enabled the path. A bus
> +	 * lookup cannot stand in for it: an ancestor-driven teardown
> +	 * delists the parent port before this devres action runs.
> +	 */
> +	dport_iter = endpoint->parent_dport;
> +	port_iter = dport_iter->port;
> +	while (!is_cxl_root(port_iter)) {
> +		int rc = cxl_bi_ctrl_dport_disable(dport_iter);
> +
> +		/* best effort */
> +		if (rc)
> +			dev_dbg(&port_iter->dev,
> +				"BI dport disable failed: %d\n", rc);
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +}
> +
> +/*
> + * Enable BI on every dport in the path, then on the device itself.
> + * On failure, unwind only the dports that fully enabled.
> + */
> +static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
> +			      struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	struct cxl_dport *dport_iter, *failed;
> +	struct cxl_port *port_iter;
> +	int rc;
> +
> +	port_iter = port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		rc = cxl_bi_ctrl_dport_enable(dport_iter);
> +		if (rc)
> +			goto err_rollback;
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	/* finally, enable BI on the device */
> +	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
> +	if (rc)
> +		goto err_rollback;
> +
> +	return 0;
> +
> +err_rollback:
> +	failed = dport_iter;
> +	dport_iter = dport;
> +	port_iter = port;
> +	while (!is_cxl_root(port_iter) && dport_iter != failed) {
> +		cxl_bi_ctrl_dport_disable(dport_iter);
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +	return rc;
> +}
> +
> +int cxl_bi_setup(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_dport *dport = endpoint->parent_dport;
> +	struct cxl_dport *dport_iter;
> +	struct cxl_port *port_iter;
> +	int rc;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return 0;
> +
> +	/* BI is VH-only */
> +	if (cxlds->rcd)
> +		return 0;
> +
> +	if (!cxl_is_bi_capable(to_pci_dev(cxlds->dev),
> +			       endpoint->regs.bi_decoder))
> +		return 0;
> +
> +	/* walkup the topology twice, first to check, then to enable */
> +	port_iter = dport->port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		/* check rp, dsp */
> +		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
> +				       dport_iter->regs.bi_decoder)) {
> +			dev_dbg(cxlds->dev, "BI not supported by topology\n");
> +			return 0;
> +		}
> +
> +		/* check usp */
> +		if (dev_is_pci(port_iter->uport_dev) &&
> +		    pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
> +			    PCI_EXP_TYPE_UPSTREAM &&
> +		    !cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
> +				       port_iter->regs.bi_rt)) {
> +			dev_dbg(cxlds->dev, "BI not supported by USP\n");
> +			return 0;
> +		}
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(&endpoint->dev, cxl_bi_dealloc,
> +					endpoint);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b2f8fb9547d3..7817109026b1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -741,6 +741,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  	xa_init(&port->dports);
>  	xa_init(&port->endpoints);
>  	xa_init(&port->regions);
> +	mutex_init(&port->bi_lock);
>  	port->component_reg_phys = CXL_RESOURCE_NONE;
>  
>  	device_initialize(dev);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f9fcb6387fc8..d00b8b7b778a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -180,6 +180,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_HEADERLOG_TRACE_SIZE SZ_512
>  #define CXL_HEADERLOG_TRACE_SIZE_U32 (CXL_HEADERLOG_TRACE_SIZE / sizeof(u32))
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
> @@ -562,6 +587,7 @@ struct cxl_dax_region {
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
>   * @regs: mapped component registers
> + * @bi_lock: serializes BI Decoder/RT state of this port's dports
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -584,6 +610,7 @@ struct cxl_port {
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
>  	struct cxl_component_regs regs;
> +	struct mutex bi_lock;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -647,6 +674,7 @@ struct cxl_rcrb_info {
>   * @coord: access coordinates (bandwidth and latency performance attributes)
>   * @link_latency: calculated PCIe downstream latency
>   * @gpf_dvsec: Cached GPF port DVSEC
> + * @nr_bi: number of BI-enabled endpoints below this dport
>   */
>  struct cxl_dport {
>  	struct device *dport_dev;
> @@ -659,6 +687,7 @@ struct cxl_dport {
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>  	long link_latency;
>  	int gpf_dvsec;
> +	int nr_bi;
>  };
>  
>  /**
> @@ -923,6 +952,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_bi_setup(struct cxl_port *endpoint);
>  struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  					    struct device *dport_dev);
>  
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index a527dd13fb68..22bd4254ba8d 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -180,6 +180,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_bi_setup(port);
> +	if (rc)
> +		dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);
> +
>  	/*
>  	 * With VH (CXL Virtual Host) topology the cxl_port::add_dport() method
>  	 * handles RAS setup for downstream ports. With RCH (CXL Restricted CXL
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 2816954680b3..e507cb0f777f 100644
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



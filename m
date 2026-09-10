Received: from sender6-pp-o92.zoho.com (sender6-pp-o92.zoho.com [165.173.180.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408735C69C
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008070; cv=pass; b=n4/kgvYF9g/gIy8dRE2eB671l7KE/qjwDT4KB/EEvWn5992w9yWqcaZ52JE1EtIWkdVhdvEDyRIbDqvE80+j/G2ZD2v9bUx2ih8uQ7OKVNEz78Bb9HsLsrkcPoINt/lecIWm/E5blBPUWxBPyjkjZFOFDVaZB9nA1PYYSED78BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008070; c=relaxed/simple;
	bh=JO+noWLl4lP33G+7GPzNwzVqX+SlEfT+3kEt39p+HvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3nIiZzOyxR4ptcnyJBa16s+eQ5apan91sf4jeM969GaJ1tEFpz6VQRY5/U3hr7HsboV054HkQaiGOdc8j2FYPDO0k7UZ4GlwTa8Niyt6299HvR4j5+eMq8Onq6BG9kbOt5yS1Z02pWsy3fePOKrVJRMXp1hZ9t+PajkvTWe2fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=YL56uNA7; arc=pass smtp.client-ip=165.173.180.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="YL56uNA7"
ARC-Seal: i=1; a=rsa-sha256; t=1789008054; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jt5imrumPsIDOH1QSKJoapUBfGZbC9T+RAcmSWnQryVhpg9lIcOjksfTt63RhZr/rscnMzPBAFxi2ZuTn9Ekryh7fAzdgfdBrtb37VEsKmus+kXI90Ax0QvMSB7F/fUyfWEd8Zep3BGY+gG/wkQySLUpyT/MFxRJ6ETTyArt3u0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789008054; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5bRqTlB5XsKwrxpxfk07EIbdAS9IU+3sm9wuDmywM6E=; 
	b=UCX9pfvn9BWcOJaFO/0URPP5mlWchlvVZrZarVzhoMiYFbi5UxdD+RzQGKm+p9oeVy18vzNoQJzT0j0wIMgeWmlS5tk/F0T/xa/HrjSL0bGlzhgB8SSC31G15yiHaR6rpWDHj9bdOiNmEz/wVEcTxreK1EAvKoD/f/F4naaHRHs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789008054;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=5bRqTlB5XsKwrxpxfk07EIbdAS9IU+3sm9wuDmywM6E=;
	b=YL56uNA7PwTqcRht0yhuOnGNeUpzkeIq4M4Pd1vvt915LKxmlJmKujLDPymB9zEm
	onjFilObxmqtc95b3aDfucvFPKo6+D2M/nsZO34kdf1KbgQLjNU6TczFKIrjfYKoE57
	c4mziYw+4Tl9TMuHOmer7bmGT7bFAds0p5GsxVPU=
Received: by smtp.zohomail.com with SMTPS id 1789008047064161.6128951340471;
	Wed, 9 Sep 2026 19:40:47 -0700 (PDT)
Message-ID: <7501f4d8-2241-4bf6-8eb7-ca94318b08f4@zohomail.com>
Date: Thu, 10 Sep 2026 10:40:43 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/10] cxl/pci: Add BI topology enable/disable
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, linux-cxl@vger.kernel.org
References: <20260909170302.1550680-1-dave@stgolabs.net>
 <20260909170302.1550680-3-dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260909170302.1550680-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227d972ba7b248b397070170fba0000d17d5d4a57cc47c5c534328b173bd43e6cc95ffa409a598acd:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/9/10 01:02, Davidlohr Bueso 写道:
> Implement cxl_bi_setup() to enable BI flows on the device and every
> component in the path, and its teardown counterpart cxl_bi_dealloc().
> Setup runs from devm_cxl_endpoint_decoders_setup(), between the
> port's HDM state and its decoders: registered there, its devres
> teardown brings BI down after the decoders quiesce and before the
> HDM state is freed, and BI is settled before the decoders, and later
> the regions, are looked at. The BI-ID and path enablement belong to
> the endpoint port's lifetime.
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
> Likewise, the device state outlives the walk: cxlmd->cxlds is
> nulled only after cxl_memdev_unregister() has torn the endpoint
> down, and delete_endpoint() clears cxlmd->endpoint only after the
> endpoint devres has run.
>
> Each dport is programmed by its position: the one immediately above
> the device assigns the BI-ID and takes BI Enable, every dport above
> it takes BI Forward (Table 8-157, Table 9-13), at any switch depth
> (Table 7-97). Any level can be shared, so nr_bi refcounts endpoints
> at every dport: registers are written on the first and cleared on
> the last, but only downstream ports commit (Table 8-156), once per
> endpoint (Table 8-152), and a failed commit undoes its write and
> commits the undo. A USP advertising a BI Route Table that failed to
> map is refused rather than treated as absent. nr_bi counts only the
> endpoints this driver enabled, so a level can be cleared while
> firmware still has an unbound device on it.
>
> A reset may wipe the device's BI Enable, whose reset default is 0
> (Table 8-157). .reset_done reads the hardware rather than assume
> which reset ran, and invalidates cxlds->bi, failing closed with
> recovery by rebind as for decoder loss; dealloc unwinds the dport
> refcounts regardless. It also clears cxlds->bi unconditionally: the
> endpoint disable fails when the hardware already shows BI Enable
> clear, from a reset .reset_done never saw, and the flag must not
> outlive the BI Decoder mapping it describes, which the endpoint port
> releases moments later.
>
> With dealloc in the endpoint's devres, delete_endpoint() already
> holds the parent port's device lock, so to avoid deadlocking, add a
> per-port bi_lock, serializing the dports that share state (nr_bi and
> the control register at any shared level, the switch USP's BI RT).
>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>   drivers/cxl/core/hdm.c  |  10 +
>   drivers/cxl/core/pci.c  | 417 ++++++++++++++++++++++++++++++++++++++++
>   drivers/cxl/core/port.c |   1 +
>   drivers/cxl/cxl.h       |  31 +++
>   drivers/cxl/pci.c       |   8 +-
>   include/cxl/cxl.h       |   2 +
>   6 files changed, 467 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..0e9d652b568e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1274,6 +1274,16 @@ int devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
>   	if (rc)
>   		return rc;
>   
> +	/*
> +	 * Between the port's HDM state and its decoders: devres,
> +	 * unwinding in reverse, brings BI down only after the decoders
> +	 * quiesce, while its slow walk still precedes the HDM state
> +	 * free.
> +	 */
> +	rc = cxl_bi_setup(port);
> +	if (rc)
> +		dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);
> +
>   	return devm_cxl_enumerate_decoders(cxlhdm, &info);
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_endpoint_decoders_setup, "CXL");
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b8676a3d6ec9..8c3c00137849 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -2,12 +2,14 @@
>   /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>   #include <linux/units.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/iopoll.h>
>   #include <linux/device.h>
>   #include <linux/delay.h>
>   #include <linux/pci.h>
>   #include <linux/pci-doe.h>
>   #include <cxl/pci.h>
>   #include <linux/aer.h>
> +#include <linux/string_choices.h>
>   #include <cxlpci.h>
>   #include <cxlmem.h>
>   #include <cxl.h>
> @@ -965,3 +967,418 @@ void devm_cxl_dport_bi_setup(struct cxl_dport *dport)
>   		break;
>   	}
>   }
> +
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
> +static int cxl_bi_commit_dport(struct cxl_dport *dport)
> +{
> +	struct cxl_port *port = dport->port;
> +	int rc;
> +
> +	if (pci_pcie_type(to_pci_dev(dport->dport_dev)) !=
> +	    PCI_EXP_TYPE_DOWNSTREAM)
> +		return 0;
Missing check to confirm if the dport is a PCI_EXP_TYPE_ROOT_PORT here? 
I think the function is still used for rp.
> +
> +	rc = __cxl_bi_commit_decoder(dport->dport_dev, dport->regs.bi_decoder);
> +	if (!rc && port->regs.bi_rt)
> +		rc = __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
Maybe check whether port->dev is PCI_EXP_TYPE_UPSTREAM before calling 
__cxl_bi_commit_rt()?
> +
> +	return rc;
> +}
> +
> +/*
> + * Enable or dealloc BI-ID changes in the given level of the topology.
> + * @direct says this dport sits immediately above the device, which is
> + * what decides whether it assigns the BI-ID or forwards one assigned
> + * below it.
> + */
> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable,
> +			       bool direct)
> +{
> +	void __iomem *bi = dport->regs.bi_decoder;
> +	struct cxl_port *port = dport->port;
> +	u32 ctrl, value, set, clr;
> +	int rc;
> +
> +	guard(mutex)(&port->bi_lock);
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	if (!enable) {
> +		if (WARN_ON_ONCE(dport->nr_bi == 0))
> +			return -EINVAL;
> +		/* others below still need this level */
> +		if (--dport->nr_bi > 0)
> +			return 0;
> +
> +		writel(ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +				CXL_BI_DECODER_CTRL_BI_ENABLE),
> +		       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +		return cxl_bi_commit_dport(dport);
> +	}
> +
> +	set = direct ? CXL_BI_DECODER_CTRL_BI_ENABLE :
> +		       CXL_BI_DECODER_CTRL_BI_FW;
> +	clr = direct ? CXL_BI_DECODER_CTRL_BI_FW :
> +		       CXL_BI_DECODER_CTRL_BI_ENABLE;
> +
> +	value = (ctrl | set) & ~clr;
> +	if (value != ctrl)
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	/* owed per new device below, not per register change */
> +	rc = cxl_bi_commit_dport(dport);
> +	if (rc) {
> +		if (value != ctrl) {
> +			/* the undo is a BI-ID change owing its own commit */
> +			writel(ctrl, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +			cxl_bi_commit_dport(dport);
> +		}
> +		return rc;
> +	}
> +	dport->nr_bi++;
> +
> +	return 0;
> +}
> +
> +static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
> +{
> +	return __cxl_bi_ctrl_dport(dport, true, direct);
> +}
> +
> +static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
> +{
> +	return __cxl_bi_ctrl_dport(dport, false, false);
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
> + * devm teardown on endpoint port destruction. Registered before the
> + * decoders, so devres runs it after them: regions are detached and
> + * decoders unregistered by the time BI comes down.
> + */
> +static void cxl_bi_dealloc(void *data)
> +{
> +	struct cxl_port *endpoint = data;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_dport *dport_iter;
> +	struct cxl_port *port_iter;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		cxl_bi_ctrl_endpoint_disable(cxlds);
> +	cxlds->bi = false;
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
> +		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport);
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
> +/*
> + * An SBR wipes the device's BI Enable; an FLR leaves it alone.
> + * The check is against the hardware, not decoder state: BI is
> + * enabled at probe, so it can be wiped with no decoder ever
> + * committed. A wipe invalidates the software state; BI is never
> + * re-enabled here.
> + */
> +void cxl_bi_reset_detected(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	void __iomem *bi = endpoint->regs.bi_decoder;
> +
> +	if (!cxlds->bi)
> +		return;
> +
> +	if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
> +		      readl(bi + CXL_BI_DECODER_CTRL_OFFSET)))
> +		return;
> +
> +	dev_dbg(cxlds->dev, "BI disabled by reset\n");
I guess it would impact the regions using BI, maybe it is worth a 
dev_warn()?
> +	cxlds->bi = false;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_reset_detected, "CXL");
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
> +			    PCI_EXP_TYPE_UPSTREAM) {
> +			if (!cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
> +					       port_iter->regs.bi_rt)) {
For the switch upstream port, the bi pointer will not be checked in 
cxl_is_bi_capable(), maybe pass a NULL instead of port_iter->regs.bi_rt 
for cxl_is_bi_capable()?
> +				dev_dbg(cxlds->dev,
> +					"BI not supported by USP\n");
> +				return 0;
> +			}
> +			if (port_iter->reg_map.component_map.bi_rt.valid &&
> +			    !port_iter->regs.bi_rt) {
> +				dev_dbg(cxlds->dev,
> +					"BI RT advertised but unmapped\n");
> +				return 0;
> +			}
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
> index 131ed62e8db3..b81fd680d18a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -742,6 +742,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>   	xa_init(&port->dports);
>   	xa_init(&port->endpoints);
>   	xa_init(&port->regions);
> +	mutex_init(&port->bi_lock);
>   	port->component_reg_phys = CXL_RESOURCE_NONE;
>   
>   	device_initialize(dev);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 65be3b91259a..ad7c991f0f9b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -180,6 +180,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>   #define CXL_HEADERLOG_TRACE_SIZE SZ_512
>   #define CXL_HEADERLOG_TRACE_SIZE_U32 (CXL_HEADERLOG_TRACE_SIZE / sizeof(u32))
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
>   /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>   #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>   #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -565,6 +590,7 @@ struct cxl_dax_region {
>    * @decoder_ida: allocator for decoder ids
>    * @reg_map: component and ras register mapping parameters
>    * @regs: mapped component registers
> + * @bi_lock: serializes BI Decoder/RT state of this port's dports
>    * @nr_dports: number of entries in @dports
>    * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>    * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -587,6 +613,7 @@ struct cxl_port {
>   	struct ida decoder_ida;
>   	struct cxl_register_map reg_map;
>   	struct cxl_component_regs regs;
> +	struct mutex bi_lock; /* dport BI state shared below this port */
>   	int nr_dports;
>   	int hdm_end;
>   	int commit_end;
> @@ -650,6 +677,7 @@ struct cxl_rcrb_info {
>    * @coord: access coordinates (bandwidth and latency performance attributes)
>    * @link_latency: calculated PCIe downstream latency
>    * @gpf_dvsec: Cached GPF port DVSEC
> + * @nr_bi: number of BI-enabled endpoints below this dport
>    */
>   struct cxl_dport {
>   	struct device *dport_dev;
> @@ -662,6 +690,7 @@ struct cxl_dport {
>   	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>   	long link_latency;
>   	int gpf_dvsec;
> +	int nr_bi;
>   };
>   
>   /**
> @@ -920,6 +949,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>   			     struct access_coordinate *c2);
>   
>   bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_bi_setup(struct cxl_port *endpoint);
> +void cxl_bi_reset_detected(struct cxl_port *endpoint);
>   struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>   					    struct device *dport_dev);
>   
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..cdab4804dba7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -987,8 +987,12 @@ static void cxl_reset_done(struct pci_dev *pdev)
>   	if (!cxlmd->dev.driver)
>   		return;
>   
> -	if (cxlmd->endpoint &&
> -	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
> +	if (!cxlmd->endpoint)
> +		return;
> +
> +	cxl_bi_reset_detected(cxlmd->endpoint);
> +
> +	if (cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
>   		device_for_each_child(&cxlmd->endpoint->dev, NULL,
>   				      cxl_endpoint_decoder_clear_reset_flags);
>   
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 278b84b08c83..718eb4353887 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -168,6 +168,7 @@ struct cxl_dpa_partition {
>    * @regs: Parsed register blocks
>    * @cxl_dvsec: Offset to the PCIe device DVSEC
>    * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @bi: device is BI (Back-Invalidate) enabled
>    * @media_ready: Indicate whether the device media is usable
>    * @dpa_res: Overall DPA resource tree for the device
>    * @part: DPA partition array
> @@ -187,6 +188,7 @@ struct cxl_dev_state {
>   	struct cxl_device_regs regs;
>   	int cxl_dvsec;
>   	bool rcd;
> +	bool bi;
>   	bool media_ready;
>   	struct resource dpa_res;
>   	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];

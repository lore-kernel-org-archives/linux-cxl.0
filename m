Received: from cornsilk.ash.relay.mailchannels.net (cornsilk.ash.relay.mailchannels.net [23.83.222.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4B2D77E5
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769802; cv=none; b=Olqhd5MKRwHotKOht2HsbC9lzv+q/4Y/LXGYWk7xJIG7NZ507AIdGEXODlhSW7rOl2abKSmedg78O0ptjPJokblCwQbfglHgkDikLtGxbGutg0r+0f7nopJLC6HY6Oe0eE5eOp248iDGBWdehHR7Uu8s1u46nd6sXMOdKOu42gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769802; c=relaxed/simple;
	bh=KXfybRAlLcRNSVZccHwwq4yOq2gVFRw9eoEWv4SYQW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpmnLsXw3m4uYd0b+Z1wdbujFPOunPZJZ1k5SwvmVG53xW6y1D4B40Ygn+ekNhBVlGOG6CPlsUCKHRplLNp+txsGMbVuJ1H3rI3iQuqGcS+S9yp1Ftyt1meUysAh1ISQlaumWMlqrZTK+t1vNv0CNZRY4U4iBZFcpfBR9SghmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=AAnNT1Xy; arc=none smtp.client-ip=23.83.222.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="AAnNT1Xy"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5BFA53E45E0;
	Mon, 29 Jun 2026 15:08:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.99.12.125])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6AF793E464D;
	Mon, 29 Jun 2026 15:08:37 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Wipe: 1db4c4384cf9c5b5_1782745718260_485071184
X-MC-Loop-Signature: 1782745718260:3200750192
X-MC-Ingress-Time: 1782745718260
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.12.125 (trex/7.1.5);
	Mon, 29 Jun 2026 15:08:38 +0000
Received: from offworld (181-161-142-22.fo.baf.movistar.cl [181.161.142.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4gpqRQ5mCXzyrF;
	Mon, 29 Jun 2026 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1782745717;
	bh=dFY7nzWlYcnctnRZgzp+LwzXnFWUOTV7fqbrLqA8Buw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=AAnNT1Xyb6xtbPwrq5wH8rtwfA/H7i2cgXjEcC90JffxtPC8XwYrfACRzZOmaVAz2
	 4Rsi/vVTZ6+rNLV4POYoNvInWLBLbWywCyr2qaFitIdatHDP5YBSWcgC1XapmqXM2Y
	 kepd4ufE0Z3FRrzueG7ogqH5BzKwA6CTodH3swVKUKWUfx1Br7GsXpPUwZzgMvUZWs
	 GyF5TeLEqVJWlWK/hosCz4gpEcAzDIUcSqMzcodmSzH+Bk6ot2vA0gXn/teJThcVWe
	 fRejKw0q/a3Evo1PoRX5AatstCE6JM2U6NXIhHBmEQjWbWLiNQSmXyN2dVh6ZXAwmX
	 T+a0r2BFZfdnw==
Date: Mon, 29 Jun 2026 08:08:29 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	alison.schofield@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <20260629150829.7g6rdahu7kilhkei@offworld>
References: <20260615145529.13848-1-dave@stgolabs.net>
 <20260615145529.13848-3-dave@stgolabs.net>
 <ajpBq7pFdSEzyol1@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ajpBq7pFdSEzyol1@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Tue, 23 Jun 2026, Richard Cheng wrote:

>On Mon, Jun 15, 2026 at 07:55:26AM +0800, Davidlohr Bueso wrote:
>> Implement cxl_bi_setup(), which walks the CXL port topology to enable
>> BI flows on the device and every component in the path between the
>> device and the root port. The walk is two-pass: first to verify each
>> component advertises BI capability, then to write BI Enable on each
>> dport's BI Decoder Control register and on the device. On failure
>> during the enable pass, partially-enabled dports are rolled back.
>>
>> The teardown counterpart, cxl_bi_dealloc(), runs automatically on
>> cxl_mem unbind.
>>
>> cxl_bi_setup() does not touch HDM decoder configuration -- the BI bit
>> in each decoder is programmed separately at commit time. After a
>> successful setup the device is BI-capable but not yet using BI for
>> decode coherence.
>>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  drivers/cxl/core/pci.c | 366 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h      |  28 ++++
>>  drivers/cxl/mem.c      |   4 +
>>  include/cxl/cxl.h      |   2 +
>>  4 files changed, 400 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index e4338fd7e01b..cdb741d09b9e 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -2,11 +2,13 @@
>>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>>  #include <linux/units.h>
>>  #include <linux/io-64-nonatomic-lo-hi.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/device.h>
>>  #include <linux/delay.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci-doe.h>
>>  #include <linux/aer.h>
>> +#include <linux/string_choices.h>
>>  #include <cxlpci.h>
>>  #include <cxlmem.h>
>>  #include <cxl.h>
>> @@ -926,3 +928,367 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>>
>>	return ctx.count;
>>  }
>> +
>> +/*
>> + * BI requires 256B Flit operation on the link. RP/DSP/endpoint must
>> + * also have the BI Decoder cap mapped (@bi); for USPs the BI RT cap
>> + * is optional per CXL 4.0 8.2.4.26, so absent @bi is allowed.
>> + */
>> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
>> +{
>> +	if (!cxl_pci_flit_256(pdev))
>> +		return false;
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
>> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
>> +		return false;
>> +	}
>> +	return true;
>> +}
>> +
>> +/* limit any insane timeouts from hw */
>> +#define CXL_BI_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
>> +
>> +static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
>> +					     unsigned int scale,
>> +					     unsigned int base)
>> +{
>> +	static const unsigned long scale_tbl[] = {
>> +		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
>> +	};
>> +
>> +	if (scale >= ARRAY_SIZE(scale_tbl) || !base) {
>> +		dev_dbg(dev, "Invalid BI commit timeout: scale=%u base=%u\n",
>> +			scale, base);
>> +		return CXL_BI_COMMIT_MAXTMO_US;
>> +	}
>> +
>> +	return scale_tbl[scale] * base;
>> +}
>> +
>> +static int __cxl_bi_wait_commit(struct device *dev, void __iomem *status_reg,
>> +				u32 committed_bit, u32 err_bit,
>> +				unsigned int scale, unsigned int base)
>> +{
>> +	unsigned long tmo_us, poll_us;
>> +	ktime_t start;
>> +	u32 status;
>> +	int rc;
>> +
>> +	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,
>> +		       __cxl_bi_get_timeout_us(dev, scale, base));
>> +	poll_us = max_t(unsigned long, tmo_us / 10, 1); /* ~10% */
>> +	start = ktime_get();
>> +
>> +	rc = readx_poll_timeout(readl, status_reg, status,
>> +				status & (committed_bit | err_bit),
>> +				poll_us, tmo_us);
>> +	if (rc) {
>> +		dev_err(dev, "BI-ID commit timed out (%luus)\n", tmo_us);
>> +		return rc; /* -ETIMEDOUT */
>> +	}
>> +
>> +	if (status & err_bit) {
>> +		dev_err(dev, "BI-ID commit rejected by hardware\n");
>> +		return -EIO;
>> +	}
>> +
>> +	dev_dbg(dev, "BI-ID commit wait took %lluus\n",
>> +		ktime_to_us(ktime_sub(ktime_get(), start)));
>> +	return 0;
>> +}
>> +
>> +/* BI RT only exists on switch upstream ports. */
>> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
>> +{
>> +	u32 status, ctrl;
>> +	unsigned int scale, base;
>> +
>> +	if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
>> +		       readl(bi + CXL_BI_RT_CAPS_OFFSET)))
>> +		return 0;
>> +
>> +	ctrl = readl(bi + CXL_BI_RT_CTRL_OFFSET);
>> +	writel(ctrl & ~CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
>> +	writel(ctrl | CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
>> +
>> +	status = readl(bi + CXL_BI_RT_STATUS_OFFSET);
>> +	scale = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE, status);
>> +	base = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE, status);
>> +
>> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_RT_STATUS_OFFSET,
>> +				    CXL_BI_RT_STATUS_BI_COMMITTED,
>> +				    CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED,
>> +				    scale, base);
>> +}
>> +
>> +static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
>> +{
>> +	u32 status, ctrl;
>> +	unsigned int scale, base;
>> +
>> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
>> +		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
>> +		return 0;
>> +
>> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +	writel(ctrl & ~CXL_BI_DECODER_CTRL_BI_COMMIT,
>> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +	writel(ctrl | CXL_BI_DECODER_CTRL_BI_COMMIT,
>> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +
>> +	status = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
>> +	scale = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE, status);
>> +	base = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE, status);
>> +
>> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_DECODER_STATUS_OFFSET,
>> +				    CXL_BI_DECODER_STATUS_BI_COMMITTED,
>> +				    CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED,
>> +				    scale, base);
>> +}
>> +
>> +/* Enable or dealloc BI-ID changes in the given level of the topology. */
>> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
>> +	void __iomem *bi = dport->regs.bi_decoder;
>> +	struct cxl_port *port = dport->port;
>> +	u32 ctrl, value;
>> +	int rc;
>> +
>> +	guard(device)(&port->dev);
>> +	if (!bi)
>> +		return -EINVAL;
>> +
>> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +		if (enable) {
>> +			/*
>> +			 * There is no point of failure from here on,
>> +			 * BI will be enabled on the endpoint device.
>> +			 */
>> +			dport->nr_bi++;
>> +
>> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
>> +			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
>> +				return 0;
>> +
>> +			value = ctrl | CXL_BI_DECODER_CTRL_BI_FW;
>> +			value &= ~CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +		} else {
>> +			if (WARN_ON_ONCE(dport->nr_bi == 0))
>> +				return -EINVAL;
>> +			if (--dport->nr_bi > 0)
>> +				return 0;
>> +
>> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
>> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
>> +		}
>> +
>> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +		return 0;
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +		if (enable) {
>> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
>> +			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +		} else {
>> +			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
>> +				return 0;
>> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
>> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
>> +		}
>> +
>> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +
>> +		rc = __cxl_bi_commit_decoder(dport->dport_dev, bi);
>> +		if (rc)
>> +			return rc;
>> +
>> +		if (port->regs.bi_rt)
>> +			return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport)
>> +{
>> +	return __cxl_bi_ctrl_dport(dport, true);
>> +}
>> +
>> +static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
>> +{
>> +	return __cxl_bi_ctrl_dport(dport, false);
>> +}
>> +
>> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
>> +{
>> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>> +	void __iomem *bi = endpoint->regs.bi_decoder;
>> +	u32 ctrl, val;
>> +
>> +	if (!bi)
>> +		return -EINVAL;
>> +
>> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +
>> +	if (enable) {
>> +		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
>> +			if (cxlds->bi)
>> +				return 0;
>> +			dev_err(cxlds->dev,
>> +				"BI already enabled in hardware\n");
>> +			return -EBUSY;
>> +		}
>> +		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +	} else {
>> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
>> +			if (!cxlds->bi)
>> +				return 0;
>> +			dev_err(cxlds->dev,
>> +				"BI already disabled in hardware\n");
>> +			return -EBUSY;
>> +		}
>> +		val = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +	}
>> +
>> +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +	cxlds->bi = enable;
>> +
>> +	dev_dbg(cxlds->dev, "BI requests %s\n",
>> +		str_enabled_disabled(enable));
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_bi_ctrl_endpoint_enable(struct cxl_dev_state *cxlds)
>> +{
>> +	return __cxl_bi_ctrl_endpoint(cxlds, true);
>> +}
>> +
>> +static int cxl_bi_ctrl_endpoint_disable(struct cxl_dev_state *cxlds)
>> +{
>> +	return __cxl_bi_ctrl_endpoint(cxlds, false);
>> +}
>> +
>> +/*
>> + * devm teardown on cxl_mem unbind. Endpoint decoders may still be
>> + * committed here (cxl_workqueue tears them down asynchronously), but
>> + * memory access has been quiesced.
>> + */
>> +static void cxl_bi_dealloc(void *data)
>> +{
>> +	struct cxl_dev_state *cxlds = data;
>> +	struct cxl_dport *dport_iter, *dport;
>> +	struct cxl_port *port_iter;
>> +
>> +	if (!dev_is_pci(cxlds->dev))
>> +		return;
>> +
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &dport);
>> +	if (!port || !cxlds->bi)
>> +		return;
>> +
>> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
>> +		cxl_bi_ctrl_endpoint_disable(cxlds);
>> +
>> +	port_iter = port;
>> +	dport_iter = dport;
>> +	while (!is_cxl_root(port_iter)) {
>> +		int rc = cxl_bi_ctrl_dport_disable(dport_iter);
>> +
>> +		/* best effort */
>> +		if (rc)
>> +			dev_dbg(&port_iter->dev,
>> +				"BI dport disable failed: %d\n", rc);
>> +
>> +		dport_iter = port_iter->parent_dport;
>> +		port_iter = dport_iter->port;
>> +	}
>> +}
>
>Hi Davidlohr,
>
>I think the failing dport enablement will get disabled here, too.
>Because you put the "== failed" check after the disable. For a DSP that
>re-runs __cxl_bi_commit_decoder() on HW that just failed to commit during
>enable, I think a second commit timeout up to 5s will occur on every failed
>bring-up.
>
>Rollback should only unwind the dports that fully enabled, stop before the failed one.

Agreed, I had this at some point but then changed it. I never liked the double
timeout, as you point out. See the cover letter:

[    2.994821] cxl_core:__cxl_bi_wait_commit:985: pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
[    5.010606] cxl_core:__cxl_bi_wait_commit:985: pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)

I have gone back to only undoing the successfully enabled dports before the error.

Thanks,
Davidlohr

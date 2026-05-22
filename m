Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1B34388F
	for <linux-cxl@vger.kernel.org>; Fri, 22 May 2026 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474829; cv=none; b=OFMGKDhl/OnufP1v+dqjTLTb/vl561a4nWfzTp62jZ5RFfrzgPZJ5D/uqvUdyizQRQIlpwkIB5qjz8/YSsYFwJWoAKvfObQcUXkXeTMw+0fnK+fiSfVEVTnmA4KfNA3l/J0t5nO8ThmLiWPfb+dtLna+UV++gNUuOXf4yhkrUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474829; c=relaxed/simple;
	bh=9qyD7aKMTi6HfKxpjQr25hYf10lg63bZ65bfQ8EyEW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WenwrxYx1WqQzKBBCQx2CwOAhQQMeprWhJeIRG/2VLsfSJlcn9qsSDNWZ/wbNCqC6Tb0UuIOiBcTnQOgdcIOvq3izaDzILXSdkXtsqVrzrAQq3cRRGWcuobE5k6s7CbOZ5sUnPAYJwmhx771kV45OMnF8kPtg+l03cWSmS4u65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=BSaROsfW; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="BSaROsfW"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3A6A1942EFA;
	Fri, 22 May 2026 18:33:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (100-106-191-189.trex-nlb.outbound.svc.cluster.local [100.106.191.189])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C60039431A8;
	Fri, 22 May 2026 18:33:40 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Chemical: 33954b6369193979_1779474821115_932547993
X-MC-Loop-Signature: 1779474821115:1004463626
X-MC-Ingress-Time: 1779474821115
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.191.189 (trex/7.1.5);
	Fri, 22 May 2026 18:33:41 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4gMYnc0dGHzyqP;
	Fri, 22 May 2026 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1779474820;
	bh=5qcigN66OlsnyjrzyczRk8ZmZGppuOHFQ6Z1guY1KkY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=BSaROsfWfDEhq9O9NIckutR9FV/lD61xYqGYLCWZ/prTjlMsTl/NhIG3QqHL/T3km
	 BcKCNxILpO/qUfYGqcmYOFmM7lYSZ1qV/Mv2HVnfEJ9Hy7vf9X2fbnCHq/rmC9rLqJ
	 kIpfRgIQE/ASDT0fmo8gtdqP4mNkbBcTV0FsljP4Cj8kdnn+C/WGrRNUkLuVBNPYA1
	 l/ZjWx0DAJPJ7HrD7h0BqB24IEV9PuOi7Jw+YGUtAbyDwoIub83p2txy4TkyJ9asmE
	 E2FQNQDwneKike97FzK+GLbjkV3Qs32NR1TiyhQ85XtLV44LOjie7wf12g7z7sfjeP
	 0DNTtycLi5RkQ==
Date: Fri, 22 May 2026 11:33:37 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: djbw@kernel.org, jic23@kernel.org, benjamin.cheatham@amd.com,
	alucerop@amd.com, alison.schofield@intel.com, ira.weiny@intel.com,
	gourry@gourry.net, dongjoo.seo1@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <20260522183337.kgmh6oi7aaxuquup@offworld>
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <20260516022037.1761453-3-dave@stgolabs.net>
 <e83cae66-8d61-45c3-b90a-93d1efe36cc0@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e83cae66-8d61-45c3-b90a-93d1efe36cc0@intel.com>
User-Agent: NeoMutt/20220429

On Mon, 18 May 2026, Dave Jiang wrote:

>On 5/15/26 7:20 PM, Davidlohr Bueso wrote:
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index d1f487b3d809..7029055217c3 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/pci.h>
>>  #include <linux/pci-doe.h>
>>  #include <linux/aer.h>
>> +#include <linux/string_choices.h>
>>  #include <cxlpci.h>
>>  #include <cxlmem.h>
>>  #include <cxl.h>
>> @@ -926,3 +927,321 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>>
>>	return ctx.count;
>>  }
>> +
>> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
>> +{
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
>> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>
>Maybe add a comment for this helper that that BI_RT is only for upstream ports?

Ok, and I have also added a comment to cxl_is_bi_capable().

>
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
>> +	if (scale >= ARRAY_SIZE(scale_tbl)) {
>> +		dev_dbg(dev, "Invalid BI commit timeout scale: %u\n", scale);
>> +		return CXL_BI_COMMIT_MAXTMO_US;
>> +	}
>> +
>> +	return scale_tbl[scale] * base;
>> +}
>> +
>> +#define ___cxl_bi_commit(dev, bi, ctype)				\
>> +do {									\
>> +	u32 status, ctrl;						\
>> +	unsigned int scale, base;					\
>> +	ktime_t tmo, now, start;					\
>> +	unsigned long poll_us, tmo_us;					\
>> +									\
>> +	ctrl = readl(bi + CXL_BI_##ctype##_CTRL_OFFSET);		\
>> +	writel(ctrl & ~CXL_BI_##ctype##_CTRL_BI_COMMIT,			\
>> +	       (bi) + CXL_BI_##ctype##_CTRL_OFFSET);			\
>> +	writel(ctrl | CXL_BI_##ctype##_CTRL_BI_COMMIT,			\
>> +	       (bi) + CXL_BI_##ctype##_CTRL_OFFSET);			\
>> +									\
>> +	status = readl((bi) + CXL_BI_##ctype##_STATUS_OFFSET);		\
>> +	scale = FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMIT_TM_SCALE,	\
>> +			  status);					\
>> +	base = FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMIT_TM_BASE,	\
>> +			 status);					\
>> +									\
>> +	/* ... and poll */						\
>> +	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,		\
>> +		       __cxl_bi_get_timeout_us((dev), scale, base));	\
>> +	poll_us = tmo_us / 10; /* arbitrary 10% of timeout */		\
>
>Any chance that poll_us end up being 0 because tmo_us is less than 10 and that creates a tight spin polling loop? Maybe
>poll_us = max(poll_us, 1) to deal with a 0 value? Or some sane default min poll value.

Right, went with max_t().

>
>> +	start = now = ktime_get();					\
>> +	tmo = ktime_add_us(now, tmo_us);				\
>> +	while (!FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMITTED, status) && \
>> +	       !FIELD_GET(CXL_BI_##ctype##_STATUS_BI_ERR_NOT_COMMITTED,	\
>> +			  status)) {					\
>> +		if (ktime_after(now, tmo)) {				\
>> +			dev_dbg((dev), "BI-ID commit timed out (%luus)\n", \
>> +				tmo_us);				\
>> +			return -ETIMEDOUT;				\
>> +		}							\
>> +									\
>> +		fsleep(poll_us);					\
>> +		now = ktime_get();					\
>> +		status = readl((bi) + CXL_BI_##ctype##_STATUS_OFFSET);	\
>> +	}								\
>> +									\
>> +	if (FIELD_GET(CXL_BI_##ctype##_STATUS_BI_ERR_NOT_COMMITTED, status)) \
>> +		return -EIO;						\
>> +									\
>> +	dev_dbg((dev), "BI-ID commit wait took %lluus\n",		\
>> +		ktime_to_us(ktime_sub(now, start)));			\
>> +} while (0)
>
>There has to be a cleaner way to do this instead of this huge macro? I think Ben mentioned this in v1. And I don't particularly like it either.

So I think Ben was more divided, but yeah I was expecting your pushback here.
And while I still like the macro approach, I do agree that the above is not
ideal. What I should have done is something like:

+#define DEFINE_CXL_BI_COMMIT(type, TYPE, null_rc)                            \
+static int __cxl_bi_commit_##type(struct device *dev, void __iomem *bi)      \
+{                                                                            \
+     u32 status, ctrl;                                                       \
+     unsigned int scale, base;                                               \
+                                                                             \
+     if (!bi)                                                                \
+             return (null_rc);                                               \
+                                                                             \
+     if (!FIELD_GET(CXL_BI_##TYPE##_CAPS_EXPLICIT_COMMIT_REQ,                \
+                    readl(bi + CXL_BI_##TYPE##_CAPS_OFFSET)))                \
+             return 0;                                                       \
...
+}
...
+DEFINE_CXL_BI_COMMIT(rt, RT, 0);
+DEFINE_CXL_BI_COMMIT(decoder, DECODER, -EINVAL);

... and we do such things in various kernel subsystems (atomics, locking, etc.).

But I went ahead and got rid of the macro altogether, cannot say it is nicer than
the above, even when trying to reduce some of the duplicated code with a wait helper.

+static int __cxl_bi_wait_commit(struct device *dev, void __iomem *status_reg,
+                               u32 committed_bit, u32 err_bit,
+                               unsigned int scale, unsigned int base)
+{
+       unsigned long tmo_us, poll_us;
+       ktime_t start;
+       u32 status;
+       int rc;
+
+       tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,
+                      __cxl_bi_get_timeout_us(dev, scale, base));
+       poll_us = max_t(unsigned long, tmo_us / 10, 1); /* ~10% */
+       start = ktime_get();
+
+       rc = readx_poll_timeout(readl, status_reg, status,
+                               status & (committed_bit | err_bit),
+                               poll_us, tmo_us);
+       if (rc) {
+               dev_dbg(dev, "BI-ID commit timed out (%luus)\n", tmo_us);
+               return rc; /* -ETIMEDOUT */
+       }
+
+       if (status & err_bit) {
+               dev_dbg(dev, "BI-ID commit rejected by hardware\n");
+               return -EIO;
+       }
+
+       dev_dbg(dev, "BI-ID commit wait took %lluus\n",
+               ktime_to_us(ktime_sub(ktime_get(), start)));
+       return 0;
+}

Then, for example __cxl_bi_commit_decoder():

+static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
+{
+       u32 status, ctrl;
+       unsigned int scale, base;
+
+       if (!bi)
+               return -EINVAL;
+
+       if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
+                      readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
+               return 0;
+
+       ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
+       writel(ctrl & ~CXL_BI_DECODER_CTRL_BI_COMMIT,
+              bi + CXL_BI_DECODER_CTRL_OFFSET);
+       writel(ctrl | CXL_BI_DECODER_CTRL_BI_COMMIT,
+              bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+       status = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
+       scale = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE, status);
+       base = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE, status);
+
+       return __cxl_bi_wait_commit(dev, bi + CXL_BI_DECODER_STATUS_OFFSET,
+                                   CXL_BI_DECODER_STATUS_BI_COMMITTED,
+                                   CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED,
+                                   scale, base);
+}

>
>> +
>> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
>
>I do wonder if 'struct cxl_component_regs *' would be better passed in than allowing arbitrary iomem addr.

Comparing how both are currently passed along (ie: ras), I am more inclined to leave it
as is.

>
>> +{
>> +	if (!bi)
>> +		return 0;
>> +
>> +	if (FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
>> +		      readl(bi + CXL_BI_RT_CAPS_OFFSET)))
>> +		___cxl_bi_commit(dev, bi, RT);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __cxl_bi_commit(struct device *dev, void __iomem *bi)
>> +{
>> +	if (!bi)
>> +		return -EINVAL;
>> +
>> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
>> +		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
>> +		return 0;
>> +
>> +	___cxl_bi_commit(dev, bi, DECODER);
>> +	return 0;
>> +}
>> +
>> +/* Enable or dealloc BI-ID changes in the given level of the topology. */
>> +static int cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>
>I don't particularly care for the bool for toggle. Please either use an enum for readability or use wrapper functions i.e.
>cxl_bi_ctrl_dport_enable() / _disable().

Agreed.

>
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
>> +	void __iomem *bi = dport->regs.bi_decoder;
>> +	struct cxl_port *port = dport->port;
>> +	u32 ctrl, value;
>> +	int rc;
>> +
>> +	guard(device)(&port->dev);
>> +
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
>> +			port->nr_bi++;
>> +
>> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl))
>> +				return 0;
>> +
>> +			value = ctrl | CXL_BI_DECODER_CTRL_BI_FW;
>> +			value &= ~CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +		} else {
>> +			if (WARN_ON_ONCE(port->nr_bi == 0))
>> +				return -EINVAL;
>> +			if (--port->nr_bi > 0)
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
>> +		rc = __cxl_bi_commit(dport->dport_dev, bi);
>> +		if (rc)
>> +			return rc;
>> +
>> +		return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
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
>> +			WARN_ON_ONCE(!cxlds->bi);
>> +			return 0;
>> +		}
>> +		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +	} else {
>> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
>> +			WARN_ON_ONCE(cxlds->bi);
>> +			return 0;
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
>> +/*
>> + * devm teardown on cxl_mem unbind. Endpoint decoders may still be
>> + * committed here (cxl_workqueue tears them down asynchronously), but
>> + * memory access has been quiesced.
>> + */
>> +static void cxl_bi_dealloc(void *data)
>> +{
>> +	struct cxl_dev_state *cxlds = data;
>> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_dport *dport, *_dport;
>> +	struct cxl_port *port;
>> +
>> +	struct cxl_port *_port __free(put_cxl_port) =
>> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &_dport);
>> +
>> +	if (!_port || !cxlds->bi)
>> +		return;
>> +
>> +	if (endpoint) {
>> +		scoped_guard(rwsem_read, &cxl_rwsem.region)
>> +			cxl_bi_ctrl_endpoint(cxlds, false);
>> +	} else {
>> +		/*
>> +		 * Endpoint already removed: regions torn down and
>> +		 * decoders uncommitted. Endpoint BI registers are no
>> +		 * longer mapped; just clear the flag.
>> +		 */
>> +		cxlds->bi = false;
>> +	}
>> +
>> +	port = _port;
>> +	dport = _dport;
>> +	while (!is_cxl_root(port)) {
>> +		int rc = cxl_bi_ctrl_dport(dport, false);
>> +
>> +		/* best effort */
>> +		if (rc)
>> +			dev_dbg(&port->dev,
>> +				"BI dport disable failed: %d\n", rc);
>> +
>> +		dport = port->parent_dport;
>> +		port = dport->port;
>> +	}
>> +}
>> +
>> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>> +	struct cxl_dport *dport, *_dport, *failed;
>> +	struct cxl_port *port;
>> +	int rc;
>> +
>> +	struct cxl_port *_port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &_dport);
>> +
>> +	if (!_port)
>> +		return -EINVAL;
>> +
>> +	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi_decoder))
>> +		return 0;
>> +
>> +	/* walkup the topology twice, first to check, then to enable */
>> +	port = _port;
>> +	dport = _dport;
>> +	while (!is_cxl_root(port)) {
>> +		/* check rp, dsp */
>> +		if (!cxl_is_bi_capable(to_pci_dev(dport->dport_dev),
>> +				       dport->regs.bi_decoder))
>> +			return -EINVAL;
>> +
>> +		/* check usp */
>> +		if (dev_is_pci(port->uport_dev) &&
>> +		    pci_pcie_type(to_pci_dev(port->uport_dev)) ==
>> +			    PCI_EXP_TYPE_UPSTREAM)
>> +			if (!cxl_is_bi_capable(to_pci_dev(port->uport_dev),
>> +					       port->regs.bi_rt))
>> +				return -EINVAL;
>> +
>> +		dport = port->parent_dport;
>> +		port = dport->port;
>> +	}
>> +
>> +	port = _port;
>> +	dport = _dport;
>> +	while (!is_cxl_root(port)) {
>> +		rc = cxl_bi_ctrl_dport(dport, true);
>> +		if (rc)
>> +			goto err_rollback;
>> +
>> +		dport = port->parent_dport;
>> +		port = dport->port;
>> +	}
>> +
>> +	/* finally, enable BI on the device */
>> +	cxl_bi_ctrl_endpoint(cxlds, true);
>
>ignoring returned error. if endpoint fail to enable, do you need to rollback and skip the dealloc registration?

Yep.

Thanks,
Davidlohr

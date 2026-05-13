Received: from dragonfly.birch.relay.mailchannels.net (dragonfly.birch.relay.mailchannels.net [23.83.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF235DA7B
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636345; cv=pass; b=gdqAxcbRTuTjcc836G1raZbP+kMbTMW/nPJl4+a3Ptva3nBu7tO85eJroH3VGeds8YbEHy2KCCAMipSR0KTJgZMnmk9efjpOyLZM7woF5xET9dBNuWF2+Xli/qz9AEB/7F9pBTkqN83jOymEn/10kIKlIsRQEIX3izuwexqMw3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636345; c=relaxed/simple;
	bh=Q3NuhaPIVOA6Ts0MqLmfIcAtKGNrnAVQsuA90wYyt0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ9y4WNDBT+Iql2kGgNDLON6cldM35UVKzzAixO68m6vx+Pm3H2kLnDMqXjYF5ud5YBhhf7Mr5smjmn9MFjGxKXJ3OeysSMxks+hQekP4s8muh/rHSz7ioNn6ecaePnzmLQjMI2NjELE7bxBLlUwFvqrjnl0kLhfx+LV1tlZNtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=jUhepLaK; arc=pass smtp.client-ip=23.83.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="jUhepLaK"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 078427E05B0;
	Wed, 13 May 2026 00:22:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (100-98-7-66.trex-nlb.outbound.svc.cluster.local [100.98.7.66])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A17007E211E;
	Wed, 13 May 2026 00:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778631773;
	b=6ygmGj0dXPxLmoG2mDXJduPJB7WwabFhTCJDwbVZ769UM/xrivNrQcN0LEwhtapGNE/hsJ
	R/QNzC3B/BUJLSFYpaOveY81xNSgCjAj8CXFmrVWilzS+4mpQMKm1W5/WmRwE6XJtwhqrH
	7JksPi5wPIQuqg6vsC7VLfSglreE04uYdXtbdyL5YCpBIxh1lQV/lLq2H9jCC1a5eB8QHU
	KqftDKFY8cG3Kik9EINFm6sXdoUbDSHm3AQTMVvnrH5Xhfq4T460BuuWCCVRkWMeSpIC+b
	eFxDdsUtQraVtmQGvv24p00gzYo+Auu7X+YJUsT0QY41l3EOjxLu9XZPa4cpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778631773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=y4I3ncYHUuB25JbviNEXdRSLvsfTmWl7vgt9ZCL3bB8=;
	b=gw8Qp9v3YB0iEUNIHh80izRf7TpwIFO4rwqnzcECYqWFoWqbiBC+/SjLALrdnjBROXXnfH
	PJahGj+tc842XkTBHci/xQ3nnC0QCZnnHrHZyfYiQkfgtBSYqe8lBXr/QNl31iGKY7DUAY
	mYUcvd2wUEKYOABrxL37xlCL6FJKQLYkOorNb+eL1Q91KDAxnvhoY26CZsU1il/Wf7vqO3
	KlaPiVK03WPlwuFRrVLw0E3B1dsETmrPAifLA8B6m4H+dl7Ipnq364v8UhOooOX+CuLDHX
	f+qH8nHar+i/PoZvU+Z9X+z41m/AKIPRItNCuOoJ0DJ74pfhS7VP+6G3WkT6ew==
ARC-Authentication-Results: i=1;
	rspamd-5c5444c55f-8p7gn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spill-Harmony: 59fbcd1f4b36e6b4_1778631773926_1200057820
X-MC-Loop-Signature: 1778631773926:1220890308
X-MC-Ingress-Time: 1778631773926
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.7.66 (trex/7.1.5);
	Wed, 13 May 2026 00:22:53 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4gFZ1872wHz1NY;
	Tue, 12 May 2026 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778631773;
	bh=y4I3ncYHUuB25JbviNEXdRSLvsfTmWl7vgt9ZCL3bB8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=jUhepLaKuM0XJF/plwvbFogle7hpmKopt8S1mThKysgWwD2dDBUlxtayKR1WSi4wK
	 wCFM85enegBBEk9H28n3IrcnB0l7B61W3z68dv0WsChDTNfY/cl7Wyj1wSWviL0nP4
	 TejWE0Kg8Bee9vuN/vbQZ2zEJfIrzmSKCi5P5ynGgjZzWEnCRDs9L2yy62900u5Npw
	 IzAHjagvPtd/o+X8iV6/CgyDvyfhIoH/0hQAfqQYwOg3BCNJMSXuRECRQnJANtn9l2
	 C4eK6GIPGBnD4oulBgHRTAHkhKFkyna4RoFqLqGNnY/2qfKAK65F2jJKStkanujpRL
	 3OB7KMnZX10jQ==
Date: Tue, 12 May 2026 17:22:50 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, gourry@gourry.net, dongjoo.seo1@samsung.com,
	anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/6] cxl/pci: Add Back-Invalidate topology enable/disable
Message-ID: <20260513002250.uuxynctachppk5ug@offworld>
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-4-dave@stgolabs.net>
 <fcebf688-ac73-4a72-b4ba-683b3380bce3@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fcebf688-ac73-4a72-b4ba-683b3380bce3@amd.com>
User-Agent: NeoMutt/20220429

On Fri, 20 Mar 2026, Cheatham, Benjamin wrote:

>On 3/15/2026 3:27 PM, Davidlohr Bueso wrote:
>> +#define ___cxl_bi_commit(dev, bi, ctype)				\
>> +do {									\
>> +	u32 status, ctrl;						\
>> +	int scale, base;						\
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
>I'm split on whether it's better to use a macro here or just duplicate the
>code between __cxl_bi_commit() and __cxl_bi_commit_rt(). On one hand it saves
>space, but I hate looking at long macros...

I'm obviously biased, but will leave it as a macro for now as the v2 is
already reworked in a lot of ways addressing all the feedback (thanks!).

>
>> +
>> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
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
>
>I'd make this return void. Leaving it as an int return suggests it can fail
>which isn't worth the mental overhead imo, especially if it only saves a few
>lines below.

Agreed.

>
>> +
>> +static int __cxl_bi_commit(struct device *dev, void __iomem *bi)
>> +{
>> +	if (!bi)
>> +		return -EINVAL;
>> +
>> +	___cxl_bi_commit(dev, bi, DECODER);
>> +	return 0;
>> +}
>> +
>> +/* enable or dealloc BI-ID changes in the given level of the topology */
>> +static int cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>> +{
>> +	u32 ctrl, value;
>> +	void __iomem *bi = dport->regs.bi;
>> +	struct cxl_port *port = dport->port;
>> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
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
>> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
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
>> +
>> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +		}
>> +
>> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +
>> +		if (FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
>> +			      readl(bi + CXL_BI_DECODER_CAPS_OFFSET))) {
>> +			int rc = __cxl_bi_commit(dport->dport_dev,
>> +						 dport->regs.bi);
>
>It's been a while since I looked at how these decoders work, but why not move the
>explicit commit check into __cxl_bi_commit()? I think it's only called here,
>but I could be missing something.

Having it in cxl_bi_ctrl_dport() reads better imo, a reminder that __cxl_bi_commit
is conditional. But sure, I can move it in.

>
>> +			if (rc)
>> +				return rc;
>> +		}
>> +
>> +		return __cxl_bi_commit_rt(&port->dev, port->uport_regs.bi);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
>> +{
>> +	u32 ctrl, val;
>> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>> +	void __iomem *bi = endpoint->regs.bi;
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
>> +	dev_dbg(cxlds->dev, "device %scapable of issuing BI requests\n",
>> +		enable ? "" : "in");
>
>Nit: It's pretty hard to tell the difference between the enable/disable case when it's only two letters.
>I'd prefer something like:
>	dev_dbg(cxlds->dev, "%s issuing BI requests\n", enable ? "enabled" : "disabled");
>
>The device part isn't really important since the dev_dbg() prints the device name anyway.

Ok.

>
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>> +	struct cxl_dport *dport, *_dport, *failed;
>> +	struct cxl_port *parent_port, *port;
>> +	int rc;
>> +
>> +	struct cxl_port *_port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &_dport);
>> +
>> +	if (!_port)
>> +		return -EINVAL;
>> +
>> +	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi))
>> +		return 0;
>> +
>> +	/* walkup the topology twice, first to check, then to enable */
>> +	port = _port;
>> +	dport = _dport;
>> +	while (1) {
>
>You should be able to replace this with "while (!is_cxl_root(port))"; it's more
>resilient imo.

Yep.

...
>
>> +		parent_port = to_cxl_port(port->dev.parent);
>> +		/* check rp, dsp */
>> +		if (!cxl_is_bi_capable(to_pci_dev(dport->dport_dev),
>> +				       dport->regs.bi))
>> +			return -EINVAL;
>> +
>> +		/* check usp */
>> +		if (pci_pcie_type(to_pci_dev(dport->dport_dev)) ==
>> +		    PCI_EXP_TYPE_DOWNSTREAM) {
>> +			if (!cxl_is_bi_capable(to_pci_dev(port->uport_dev),
>> +					       port->uport_regs.bi))
>> +				return -EINVAL;
>> +		}
>> +
>> +		if (is_cxl_root(parent_port))
>> +			break;
>> +
>> +		dport = port->parent_dport;
>> +		port = parent_port;
>> +	}
>> +
>> +	port = _port;
>> +	dport = _dport;
>> +	while (1) {
>
>Same thing here.
>
>> +		parent_port = to_cxl_port(port->dev.parent);
>> +
>> +		rc = cxl_bi_ctrl_dport(dport, true);
>> +		if (rc)
>> +			goto err_rollback;
>> +
>> +		if (is_cxl_root(parent_port))
>> +			break;
>> +
>> +		dport = port->parent_dport;
>> +		port = parent_port;
>> +	}
>> +
>> +	/* finally, enable BI on the device */
>> +	cxl_bi_ctrl_endpoint(cxlds, true);
>> +	return 0;
>> +
>> +err_rollback:
>> +	/*
>> +	 * Undo all dports enabled so far by re-walking from the bottom
>> +	 * up to (but not including) the failed dport.
>> +	 */
>> +	failed = dport;
>> +	dport = _dport;
>> +	port = _port;
>> +	while (dport != failed) {
>> +		parent_port = to_cxl_port(port->dev.parent);
>> +
>> +		cxl_bi_ctrl_dport(dport, false);
>> +		if (is_cxl_root(parent_port))
>> +			break;
>> +		dport = port->parent_dport;
>> +		port = parent_port;
>> +	}
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
>> +
>> +int cxl_bi_dealloc(struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_port *parent_port, *port;
>> +	struct cxl_dport *dport, *_dport;
>> +
>> +	struct cxl_port *_port __free(put_cxl_port) =
>> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &_dport);
>> +
>> +	if (!_port)
>> +		return -EINVAL;
>> +
>> +	if (!cxlds->bi)
>> +		return 0;
>> +
>> +	if (endpoint) {
>> +		/* ensure the device is offline and unmapped */
>> +		scoped_guard(rwsem_read, &cxl_rwsem.region) {
>> +			if (cxl_num_decoders_committed(endpoint) > 0)
>> +				return -EBUSY;
>> +		}
>> +
>> +		/* first, disable BI on the device */
>> +		cxl_bi_ctrl_endpoint(cxlds, false);
>> +	} else {
>> +		/*
>> +		 * Teardown path: the endpoint was already removed, which
>> +		 * tears down regions and uncommits decoders. The endpoint
>> +		 * BI registers are no longer mapped so just clear the flag
>> +		 * and walk the dports below.
>> +		 */
>> +		cxlds->bi = false;
>> +	}
>> +
>> +	port = _port;
>> +	dport = _dport;
>> +	while (1) {
>
>And here.
>
>> +		int rc;
>> +
>> +		parent_port = to_cxl_port(port->dev.parent);
>> +
>> +		rc = cxl_bi_ctrl_dport(dport, false);
>> +		if (rc)
>> +			return rc;
>
>Would it be better to not return on an error here? It may be better to
>disable as many decoders as possible, but I don't know enough to
>say either way.

Agreed.

Thanks,
Davidlohr

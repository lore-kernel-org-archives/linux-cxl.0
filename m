Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044638D
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780876965; cv=none; b=Xis+UPkHe/KF8zxOmZG8QwRfVoFCvJbTMxmSnnVhU2kU3dnnnpmAR1jyWRjUREUFZ+f3KBKEZIZrJtSSGRofwNhNzrjTar+mCXvYZ8Zi3gzq5B/rFeB5bYfQHPVJgTiIWLavehInv8clOIt9FjY6XBzOJ2vw447jznDjAOO5nfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780876965; c=relaxed/simple;
	bh=BE2Otd9tgxY0yQNOBmfh41MjRzzPW04UeNQi4OAAgfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkM30mob9upQETu4XtA4USW6rCBAYxerdIKsRIqUWR45A138SyWzMWHXNqUx9efq81U5awdEbTYk5EEiPRaQcUglcom6BoiRh9D5R656Uvhu7+oneK4+LbiqwG3mr0/pMHbmNe0t8ImRe4D6+8uMXYZkliF0pYc2vHO/ZrQHd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=SCLFI12C; arc=none smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="SCLFI12C"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1263516208C;
	Mon, 08 Jun 2026 00:02:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a252.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.116.150.114])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 40D5E161EFE;
	Mon, 08 Jun 2026 00:02:36 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thread-Language: 1267c80d75fa5c13_1780876956880_1076883641
X-MC-Loop-Signature: 1780876956880:3184346716
X-MC-Ingress-Time: 1780876956879
Received: from pdx1-sub0-mail-a252.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.150.114 (trex/7.1.5);
	Mon, 08 Jun 2026 00:02:36 +0000
Received: from offworld (186-79-212-212.fo.baf.movistar.cl [186.79.212.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a252.dreamhost.com (Postfix) with ESMTPSA id 4gYXKl0f0jzyrG;
	Sun,  7 Jun 2026 17:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780876956;
	bh=dJwUZ88fXyOLj08N8CriGgxR4Id4P6BeA1zZW5y89sI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=SCLFI12CGo2N0StxPMQdlHi6X6+CUj9yx8bW6ugRNn99uQmaqW/I01lnTQfGEb3n6
	 6qTLGokO04jT3tllNEQZ+YLcJqAgDmKm6Nps0cVi03Hm01PwyMAkETHO0wskELtszP
	 bFtFLPb/rXEExdFtJcx0uEzAMBxCVcz+XtUeSBjjIYIIlZFikNrOH4PtOFU0j29EbO
	 9K3mmUwBZyLpQjZmWcklkCk4DUhJuhSpuiwqFEJwcj5goTAYf6dK+wlM0JyPoFn9An
	 SQteJuPpdr2l/f5a6ey5tTRXBIRRzNxf3AdEEde7TL7sEpsBDsk9ifOvZduapXRymj
	 eegeZ6r0YZwLA==
Date: Sun, 7 Jun 2026 17:02:26 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <20260608000226.jb2ploxc5nkjestk@offworld>
References: <20260605003329.2584012-3-dave@stgolabs.net>
 <20260605012940.1A1EC1F00898@smtp.kernel.org>
 <aiIu9vtpOldAX3nu@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiIu9vtpOldAX3nu@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Fri, 05 Jun 2026, Richard Cheng wrote:

>On Fri, Jun 05, 2026 at 01:29:39AM +0800, sashiko-bot@kernel.org wrote:
>> > +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>> > +{
>> > +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
>> > +	void __iomem *bi = dport->regs.bi_decoder;
>> > +	struct cxl_port *port = dport->port;
>> > +	u32 ctrl, value;
>> > +	int rc;
>> > +
>> > +	guard(device)(&port->dev);
>> > +	if (!bi)
>> > +		return -EINVAL;
>> > +
>> > +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
>> > +
>> > +	switch (pci_pcie_type(pdev)) {
>> > +	case PCI_EXP_TYPE_ROOT_PORT:
>> > +		if (enable) {
>> > +			/*
>> > +			 * There is no point of failure from here on,
>> > +			 * BI will be enabled on the endpoint device.
>> > +			 */
>> > +			dport->nr_bi++;
>>
>> [ ... ]
>>
>> > +	case PCI_EXP_TYPE_DOWNSTREAM:
>> > +		if (enable) {
>> > +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
>> > +			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
>> > +		} else {
>> > +			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
>> > +				return 0;
>> > +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
>> > +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
>> > +		}
>>
>> [Severity: High]
>> Should this case maintain a reference count for the downstream port similar
>> to how dport->nr_bi is used in the PCI_EXP_TYPE_ROOT_PORT case?
>>
>> In cascaded switch topologies, an upstream switch's downstream port can be
>> shared by multiple downstream endpoints. If one endpoint is unbound,
>> cxl_bi_dealloc will clear the BI_ENABLE bit on the shared downstream port
>> unconditionally.
>>
>> Could this silently break Back-Invalidate for all other active endpoints
>> relying on that same path?
>>
>
>Acked on sashiko-bot's finding, 2 BI-capable endpoints behind
>the same DSP can break it, first unbind breaks the second.
>Switch DSP unconditionally clear BI_ENABLE on the first memdev unbind.

So this had crossed my mind (for both cascading switches and MLDs), but
wanted to keep things close to what the spec was explicit about and just
cover the RP:

"If the previous steps were successful, and no other devices in this
VCS have been assigned a BI-ID, configure the Root Port that is directly
connected to Switch S"...

Thanks,
Davidlohr

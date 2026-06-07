Received: from butterfly.aspen.relay.mailchannels.net (butterfly.aspen.relay.mailchannels.net [23.83.221.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B578F2F
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.221.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780866600; cv=none; b=lqTTcKW1+SCYoLh1AU9Lxvda28dSjQnY754QG3TXwKVfDzAHszSW8Svnic7tV0y6ObwSHbBFPU+ZQfJdkftAmaJnYvs0cplfa0jgBwwABSdaM2w5Wj/SOcXTvqd2UKX5iw3qOi4i04McdAMrbNDcAbmMSzTyuYlchomOJIa996M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780866600; c=relaxed/simple;
	bh=pYDW+mC/hDNsRbaNI8elRLQ3QUlTFlIrVWI1/9Yhv4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qje9LPVOgFxbPjAGOH/2Ia6QTzWf1eQlj4I9kYrcQalCqdD7waw1m89bM2khZRLfKde/RtFcl+r1wmZ422ubY6zE47wgiZhmIJ7W9BH8exaYAXCs364+loSYfnmrRv9ra8/rXwUmp+LRxvfJwIpXKT41HHTFqBp5DZIsEAgnz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=LP18LHBx; arc=none smtp.client-ip=23.83.221.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="LP18LHBx"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 022C34C17A2;
	Sun, 07 Jun 2026 20:52:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.106.45.226])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6ABD24C17FD;
	Sun, 07 Jun 2026 20:52:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Junk
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Inform-Spill: 190129c33b10093f_1780865534673_2776495008
X-MC-Loop-Signature: 1780865534673:960797764
X-MC-Ingress-Time: 1780865534673
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.45.226 (trex/7.1.5);
	Sun, 07 Jun 2026 20:52:14 +0000
Received: from offworld (unknown [172.56.180.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gYS602xKZz107j;
	Sun,  7 Jun 2026 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780865532;
	bh=WwXBIVMPVORS0JzmGYBU9HageU9qoJoyDXSfCSE724Q=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=LP18LHBxKRfjAPzSbnZs240MDCsBFBAPiX6Ou3zzKAAJuys++o+OGePa+WMfvNJ3F
	 NQJMenPR460v7Q3Ao2/LqiWbF8Qp19w4NQ5CqcCbkIRTiMrObHJG/d5/SGRDGqqgoe
	 F3qfjivH+/14ob0whHuoE009uDY4dCtZIJ5L8qah1TQ245vHrOK0XKCkn0NHbyNvsY
	 ZAXo5x/oSb+Jflwxi2SoDcr+bRJgdmuVE0AJsrTmGQ7dRncdXqyd9KAvd+Q2fsI+M/
	 jOuNr/uM1/7f/pys0cQF2AcJqi5tjDBd1tpaoyh0l7MNH7m/pe/swSIGTbVqXOnPDV
	 fWFg/BHVQA9RA==
Date: Sun, 7 Jun 2026 13:52:01 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	alison.schofield@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <20260607205201.lkq4a7wuyhcueerc@offworld>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-3-dave@stgolabs.net>
 <aiIycaatJLZ9_Lz6@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiIycaatJLZ9_Lz6@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Fri, 05 Jun 2026, Richard Cheng wrote:

>> @@ -150,6 +150,10 @@ static int cxl_mem_probe(struct device *dev)
>>	if (rc)
>>		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
>>
>> +	rc = cxl_bi_setup(cxlds);
>> +	if (rc)
>> +		dev_dbg(dev, "BI setup failed rc=%d\n", rc);
>> +
>
>I don't think dynamic debug here is enough, we probe the device
>and the error might not surface, HDM-DB might fails later at region attach
>and we lack of traces. Maybe dev_warn() would be better for this kind of
>non-recoverable errors.
>
>What do you think ?

I don't disagree, however, I don't think that dev_warn() should be for
the caller of cxl_bi_setup(), but instead we can harden the actual errors
that are hw fault (and distinguish those mixed-configuration topologies
where not having BI is perfectly acceptable).

I ended up with:

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e4f05ad254a5..4734b9056c23 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -983,12 +983,12 @@ static int __cxl_bi_wait_commit(struct device *dev, void __iomem *status_reg,
				status & (committed_bit | err_bit),
				poll_us, tmo_us);
	if (rc) {
-               dev_dbg(dev, "BI-ID commit timed out (%luus)\n", tmo_us);
+               dev_err(dev, "BI-ID commit timed out (%luus)\n", tmo_us);
		return rc; /* -ETIMEDOUT */
	}

	if (status & err_bit) {
-               dev_dbg(dev, "BI-ID commit rejected by hardware\n");
+               dev_err(dev, "BI-ID commit rejected by hardware\n");
		return -EIO;
	}

@@ -1246,16 +1246,20 @@ int cxl_bi_setup(struct cxl_dev_state *cxlds)
	while (!is_cxl_root(port_iter)) {
		/* check rp, dsp */
		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
-                                      dport_iter->regs.bi_decoder))
-                       return -EINVAL;
+                                      dport_iter->regs.bi_decoder)) {
+                       dev_dbg(cxlds->dev, "BI not supported by topology\n");
+                       return 0;
+               }

		/* check usp */
		if (dev_is_pci(port_iter->uport_dev) &&
		    pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
			    PCI_EXP_TYPE_UPSTREAM)
			if (!cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
-                                              port_iter->regs.bi_rt))
-                               return -EINVAL;
+                                              port_iter->regs.bi_rt)) {
+                               dev_dbg(cxlds->dev, "BI not supported by USP\n");
+                               return 0;
+                       }

		dport_iter = port_iter->parent_dport;
		port_iter = dport_iter->port;

Thanks,
Davidlohr

Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60B37267A
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.214.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780960404; cv=none; b=nnlMr0s+qLBGPfktcGEO9mFp8J/PqrQAFdrH0HsTAtVbhPxcsKIY65OcVo2YLRG+EL9WWV9c3Yr/lUeYOHtkwd24eW/K+lrmyW+xUfrN/Zw0mKg60L/R3aaYQUAk+JGxULU77dsZL+cRavrFmSRbF80DwCAJJJffjRGlPTsyq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780960404; c=relaxed/simple;
	bh=FZwk0SZ7ite0RSAxUH4GY2KUn6hkE5IB827TmqQrLak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDzGnUeMPcylMdQ+hRTtfg/Y28uz/aEBcajKtFH7VOZY+3FpBdBaMnnB8mJ6bwlHqoyBnELeE0igydiJAnEX2oz5oPL8VbrFbFi0QNX3aRD2pVoTuxgiNdwy/eKgdy6wNDshIThFCb5wa6nio78VLUhjKh3n1iFx4Wc/ctbosN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=FV9vKU9C; arc=none smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="FV9vKU9C"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 491634137F;
	Mon, 08 Jun 2026 22:54:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.116.149.191])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D2E364127A;
	Mon, 08 Jun 2026 22:54:40 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Arithmetic: 53fd3b29429a743f_1780959281134_1428887124
X-MC-Loop-Signature: 1780959281134:1900875057
X-MC-Ingress-Time: 1780959281134
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.149.191 (trex/7.1.5);
	Mon, 08 Jun 2026 22:54:41 +0000
Received: from offworld (186-79-212-212.fo.baf.movistar.cl [186.79.212.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4gZ6ms2dZKz1y;
	Mon,  8 Jun 2026 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780959280;
	bh=L3Akzxddr0CC27BCUP9FKiwuLuwZkkdRWtnaAI5g9ss=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=FV9vKU9Cq59i/QQNqYgyG6m0E4WCiVFoLvq456pxm8TYxZFMaUsZj7hAa4L7r47ST
	 eGu4/DcCnuavzTcOSt0s9EGj+gu7aKIXNjri2HLk35N0IDiTvmZPtUnrcOsVUc/FFu
	 BJjrk3L5iYSMFGab9WJqKMMQuRm0PprlwYjHVbtieyGjRckxc19pq1BSpRRtiynOnc
	 82j3MRzxQPGu7fQDFXw9bGxnUp1zkZpo5dz7x3XY2acNFKKFplDJrbDAr4fmoagvE4
	 hj25gQRnaLzBRaOjcH6oiSXQMhFtK+DNv8lZkBsFk/B4NkdtPtSHnNn4TWh2+mR4S5
	 qgBhKdXIoAz8Q==
Date: Mon, 8 Jun 2026 15:54:31 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <20260608225431.zvgrwk2kfqwr2usq@offworld>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-3-dave@stgolabs.net>
 <c15c6902-3d3f-4e9b-8dc2-2e95cf0719f2@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c15c6902-3d3f-4e9b-8dc2-2e95cf0719f2@amd.com>
User-Agent: NeoMutt/20220429

On Mon, 08 Jun 2026, Cheatham, Benjamin wrote:

>On 6/4/2026 7:33 PM, Davidlohr Bueso wrote:
>> +/* BI RT only exists on switch upstream ports. */
>> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
>> +{
>> +	u32 status, ctrl;
>> +	unsigned int scale, base;
>> +
>> +	if (!bi)
>> +		return 0;
>
>Don't need this check since we already checked at the call site(s).
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
>> +	if (!bi)
>> +		return -EINVAL;
>
>Same thing here.

So this one is redundant yes, but not the bi_rt one, as it is optional.

I went with this:

@@ -1003,9 +1003,6 @@ static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
         u32 status, ctrl;
         unsigned int scale, base;
  
-       if (!bi)
-               return 0;
-
         if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
                        readl(bi + CXL_BI_RT_CAPS_OFFSET)))
                 return 0;
@@ -1029,9 +1026,6 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
         u32 status, ctrl;
         unsigned int scale, base;
  
-       if (!bi)
-               return -EINVAL;
-
         if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
                        readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
                 return 0;
@@ -1111,7 +1105,9 @@ static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
                 if (rc)
                         return rc;
  
-               return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
+               if (port->regs.bi_rt)
+                       return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
+               return 0;
         default:
                 return -EINVAL;
         }

>
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
>
>[snip]
>
>> +
>> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>> +	struct cxl_dport *dport_iter, *dport, *failed;
>> +	struct cxl_port *port_iter;
>> +	struct pci_dev *pdev;
>> +	int rc;
>> +
>> +	if (!dev_is_pci(cxlds->dev))
>> +		return 0;
>> +
>> +	pdev = to_pci_dev(cxlds->dev);
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>> +
>> +	if (!port)
>> +		return -EINVAL;
>> +
>> +	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi_decoder))
>> +		return 0;
>
>I'd return -ENXIO here since we only report the error with a dev_dbg() later on.

But this is not considered an error.

>
>> +
>> +	/* walkup the topology twice, first to check, then to enable */
>> +	port_iter = port;
>> +	dport_iter = dport;
>> +	while (!is_cxl_root(port_iter)) {
>> +		/* check rp, dsp */
>> +		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
>> +				       dport_iter->regs.bi_decoder))
>> +			return -EINVAL;
>> +
>> +		/* check usp */
>> +		if (dev_is_pci(port_iter->uport_dev) &&
>> +		    pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
>> +			    PCI_EXP_TYPE_UPSTREAM)
>> +			if (!cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
>> +					       port_iter->regs.bi_rt))
>> +				return -EINVAL;
>
>This can be one if statement: if (... && !cxl_is_bi-capable(...))> +

Sure.

>> +		dport_iter = port_iter->parent_dport;
>> +		port_iter = dport_iter->port;
>> +	}
>> +
>> +	port_iter = port;
>> +	dport_iter = dport;
>> +	while (!is_cxl_root(port_iter)) {
>> +		rc = cxl_bi_ctrl_dport_enable(dport_iter);
>> +		if (rc)
>> +			goto err_rollback;
>> +
>> +		dport_iter = port_iter->parent_dport;
>> +		port_iter = dport_iter->port;
>> +	}
>> +
>> +	/* finally, enable BI on the device */
>> +	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
>> +	if (rc)
>> +		goto err_rollback;
>> +
>> +	return devm_add_action_or_reset(&cxlds->cxlmd->dev,
>> +					cxl_bi_dealloc, cxlds);
>> +
>> +err_rollback:
>> +	/*
>> +	 * Undo all dports enabled so far, including the failed one.
>> +	 */
>> +	failed = dport_iter;
>> +	dport_iter = dport;
>> +	port_iter = port;
>> +	while (!is_cxl_root(port_iter)) {
>> +		cxl_bi_ctrl_dport_disable(dport_iter);
>> +		if (dport_iter == failed)
>> +			break;
>
>Nit: you can move this into the while statement check above. The extra overhead
>is worth the readability IMO.

We still need to account for the failing dport-iter, so moving that check will
still require another flag. I'd rather leave as is.

Thanks,
Davidlohr

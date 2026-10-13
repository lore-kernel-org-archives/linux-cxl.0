Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579637A83D
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874396; cv=pass; b=Xy7T6qqUmWbk6B4OmIheFjhSSomAfHuSTeFKd/Tr7nb/nzm56LxkrPvkou9vy97Z+EzWIkkq/+1mSgj0oqXmFshr4YfbjebTEBm8MOBviRFYv0cg4s1SsXVzLB8SF6JiWkhsii3PYzcqS8oWQ/2IPmrvQ6b/aCmBWATVLCYm7tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874396; c=relaxed/simple;
	bh=wYyj+mCBWJGZK83rTbatLKVwj8dHWKnqQR455vILOWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QP/yIkCR3/ik5RBpnRsXO+uJsILlIawTAH2VjZl8Snn2uXySA0TbqIlKYOycqYzEAX49sc+viLZkKPWdF9uOw9/Ejcsx1z9WypJxx+1w8tF95m0FTFIdLoevqiCI7d0Uj3wOWSWCyfeNvSHbQmol62JDALLdSLrIBBpP1Ll+N74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=UUyE4Jzx; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="UUyE4Jzx"
ARC-Seal: i=1; a=rsa-sha256; t=1791874386; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bKsK7Ja7BTTZo6+47NQsPlPzwStQWz/dPNjPAzSnEZYHMHDm77xsJFZRKmnwyfUHThhDF8CpxI5mWLcArXhx6jXIztCnRDqiYj24T8RaQbEGuYgZRwQjBR5mHW3+tPKorO7UTd58NA9t2LgGSlqIefXoJFoyKOvd7/yUI3ol24M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791874386; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O95AMUUTWNqaXwNI20yWI8OdxPXlSxHDeFhK/qAVtjk=; 
	b=jNXR0xUa973arq3dxbUiPVW8LZbzZPEICAbEfK50OsZJonuv6iutU14aldPKaplngFmYq5PXRJvf1ClKD1b21IqPxMJSNxCuKAOTtvxkQOuDQbMaqmAzEZmMHB8SUuCSZFIP7nzb9Q6tqqwH93jlYK1z7hK409zo3UwdLSPs1ZI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791874386;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=O95AMUUTWNqaXwNI20yWI8OdxPXlSxHDeFhK/qAVtjk=;
	b=UUyE4JzxRDti/XQP+uLZ312PDlISJVI0YUEpFiOyaXxpvVE/KRWXoB0mbTz0/cTS
	auO+GdjHyxXwTw14nMHuEnmBy7Pe1TuXCmMzNrqpsg1f3KurgVk7hhQFslJ2AemUGvR
	aIece04/QSdw3JY0VG81HwAtR3oCJLEEXMuf5PxQ=
Received: by smtp.zohomail.com with SMTPS id 1791874385118398.0014322166876;
	Mon, 12 Oct 2026 23:53:05 -0700 (PDT)
Message-ID: <ab1f937a-31b4-40ec-9c67-e1bb0221c310@zohomail.com>
Date: Tue, 13 Oct 2026 14:53:01 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] cxl/region: Factor out
 cxl_switch_port_add_target()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791860305.git.alison.schofield@intel.com>
 <97c96f804a383b13ff83f81e9e9255f4ea0887ec.1791860305.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <97c96f804a383b13ff83f81e9e9255f4ea0887ec.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112274765ce16bbc76c893a6cc4b4000063c8db96f2951563fb6d795274fa3b4856e41781090bdfab59:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/13 12:26, Alison Schofield 写道:
> cxl_switch_port_setup_targets() adds an endpoint's downstream port to a
> port's decoder target list. For an auto region it checks that the decoder
> already targets that downstream port at the next position. For a user
> created region it programs the downstream port at that position. That step
> is open coded behind an add_target label that the target search jumps to.
>
> Move that step to a new helper, cxl_switch_port_add_target(). The helper
> takes the switch decoder whose target list it updates, rather than the
> port, which makes its scope explicit. With the decoder setup and the
> target add now in helpers, the path for the first endpoint to reach a port
> becomes an else branch of the target search, so the add_target label is
> no longer needed.
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>


Just one minor comment below.

> ---
>   drivers/cxl/core/region.c | 80 ++++++++++++++++++++++++---------------
>   1 file changed, 49 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 229372123271..50f4830c225d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1608,15 +1608,50 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
>   	return 0;
>   }
>   
> +static int cxl_switch_port_add_target(struct cxl_switch_decoder *cxlsd,
> +				      struct cxl_region *cxlr,
> +				      struct cxl_region_ref *cxl_rr,
> +				      struct cxl_endpoint_decoder *cxled,
> +				      struct cxl_ep *ep)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxl_rr->port;
> +	int pos = cxled->pos;
> +
> +	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: targets full trying to add %s:%s at %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> +		return -ENXIO;
> +	}
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> +			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> +				dev_name(port->uport_dev), dev_name(&port->dev),
> +				dev_name(&cxlsd->cxld.dev),
> +				dev_name(ep->dport->dport_dev),
> +				cxl_rr->nr_targets_set);
> +			return -ENXIO;
> +		}
> +	} else {
> +		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> +		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> +	}
> +	cxl_rr->nr_targets_set++;
> +
> +	return 0;
> +}
> +
>   static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
>   					 struct cxl_endpoint_decoder *cxled)
>   {
> -	int iw, ig, rc, pos = cxled->pos;
>   	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
>   	struct cxl_decoder *cxld = cxl_rr->decoder;
>   	struct cxl_switch_decoder *cxlsd;
> +	int rc, pos = cxled->pos;
>   
>   	/*
>   	 * While root level decoders support x3, x6, x12, switch level
> @@ -1641,38 +1676,21 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
>   					return rc;
>   				goto out_target_set;
>   			}
> -		goto add_target;
> -	}
> -
> -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> -	if (rc)
> -		return rc;
> -add_target:
> -	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s: targets full trying to add %s:%s at %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> -		return -ENXIO;
> -	}
> -	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> -			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> -				dev_name(port->uport_dev), dev_name(&port->dev),
> -				dev_name(&cxlsd->cxld.dev),
> -				dev_name(ep->dport->dport_dev),
> -				cxl_rr->nr_targets_set);
> -			return -ENXIO;
> -		}
>   	} else {
> -		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> -		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> +		int iw, ig;
> +
> +		rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> +		if (rc)
> +			return rc;
>   	}
> -	cxl_rr->nr_targets_set++;
> +
> +	rc = cxl_switch_port_add_target(cxlsd, cxlr, cxl_rr, cxled, ep);
> +	if (rc)
> +		return rc;
>   out_target_set:
Do we really need this "out_target_set"? Seems like it can be removed 
too. Once a new target is set up, this function outputs the following 
log, if this function finds a registered target, I guess we don't need 
to output the following log again?
>   	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
>   		dev_name(port->uport_dev), dev_name(&port->dev),

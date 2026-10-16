Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7AF48DB2F
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176804; cv=none; b=hcaAdDPwbZ7Bpgwd0XxDLv6zArCfsAGe9fmyhf6TfucyYAEmcncrWpYBWhSBuNJHjX8GkJg/7qBLHR/UOz3sZnCQwoAbecu9KyYpGtNZIHgQ1NwPO7Pvlb0po9GZAlsCxtcC5i29yazTOq14Es6mG3z2HuK6+zg3PyWLzTYoEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176804; c=relaxed/simple;
	bh=h1UJD3Ib+qeGp626nngfSp3gkiDZb02gGFJNeC5rAHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfkggFxDhKA8OnLfmRygpVlx9z9vaHARIMCAwx2eCKU8fTdjcY+l0JNM63i+XOGGZiCnI9B6pNw4yvpEZ9fOcmXzu+UZctdQN8g+RL/kaBhmdiIgJzEsnmAfromXaJwrZ+ggjMTEEL7hkfD1gpagrem+XjuNbsOK9MPF4cuGPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaZ9WV6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaZ9WV6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBDA1F000C4;
	Fri, 16 Oct 2026 18:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792176803;
	bh=mS4vEeOOmcZk0Zz/zLfjND/cVaGywnEMCCN+1t+j5TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IaZ9WV6ThyIA+mLZXFPPfVu2L656k2GinpVbu4nAqw60bDiwSOyXrs+9oPFwywa0F
	 ajyBip3iqHFUFlrTXHoxSN9h4PqIJ/LTq5cyy75Tx+Vn36zs14hkN9nN0qTWtRyRQQ
	 hFf93dhOOr3DSe4iBuZto9tWplUWDZOUjeOFtt0S9f/UVdswBfheKMoJkU8DvXTK6w
	 KOQJms/15PfZ8hUuvKnUIhYXdHrmosd29z+uyIPt4jsFezo01Z58VyZpi7DlfeLK7G
	 cbuJ4fg3yovGc0MI53diL3AC/BPK0+aK4HiXbNEPpqpTGdYdQxl6NPgTgIpLEWDHlD
	 RnAs/syhdtg+w==
Date: Fri, 16 Oct 2026 19:53:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 6/7] cxl/region: Factor out cxl_port_setup_decoder()
Message-ID: <20261016195317.00b2c5b5@jic23-hlaptop>
In-Reply-To: <b518a60cae9a472c6463195f0173800378990d2f.1791860305.git.alison.schofield@intel.com>
References: <cover.1791860305.git.alison.schofield@intel.com>
	<b518a60cae9a472c6463195f0173800378990d2f.1791860305.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 21:26:02 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Once cxl_switch_port_setup_targets() has calculated the interleave for a
> port's decoder, it either checks that interleave against the decoder
> settings found for an auto region, or checks the decoder's interleave
> capabilities and programs the decoder for a user created region. Both paths
> are open coded in cxl_switch_port_setup_targets().
> 
> Move both paths to a new helper, cxl_port_setup_decoder().
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Maybe some further opportunities in here to improve readability
(using Ming and Richard's suggestions)

>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
> @@ -1639,6 +1604,53 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
>  	}
>  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
>  		dev_name(&port->dev), iw, ig);
> +
> +	return 0;
> +}
> +
> +static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> +					 struct cxl_endpoint_decoder *cxled)
> +{
> +	int iw, ig, rc, pos = cxled->pos;
> +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_decoder *cxld = cxl_rr->decoder;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	/*
> +	 * While root level decoders support x3, x6, x12, switch level
> +	 * decoders only support powers of 2 up to x16.
> +	 */
> +	if (!is_power_of_2(cxl_rr->nr_targets)) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			cxl_rr->nr_targets);
> +		return -EINVAL;
> +	}
> +
> +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	if (cxl_rr->nr_targets_set) {
> +		int distance = cxl_port_peer_distance(port, cxlr);
> +
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
I wonder if it is worth taking opportunity to flip things:

		for (int i = 0; i < cxl_rr_nr_targets_set; i++) {
			if (ep->dport != cxlsd->target[i])
				continue;

			distance = cxl_port_peer_distance(port, cxlr);
			return check_last_peer(cxled, ep, cxl_rr,
					       cxl_port_peer_distance(port, cxlr));
			// Ming's comment and Richard's patch rolled in
			// The local variable ended up ugly hence inline unlike
			// Richard's suggestion.
		}
		goto add_target;
			
> +			if (ep->dport == cxlsd->target[i]) {
> +				rc = check_last_peer(cxled, ep, cxl_rr,
> +						     distance);
> +				if (rc)
> +					return rc;
> +				goto out_target_set;
> +			}
> +		goto add_target;
> +	}
> +
> +	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> +	if (rc)
> +		return rc;
>  add_target:
>  	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
>  		dev_dbg(&cxlr->dev,


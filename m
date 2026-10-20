Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459589;
	b=UCiHcvyPetQOL7DtcTKasdjsszVq9Xs/f7oh5+aCb6OoUjg+IRIFKmRSx2aUYb/szKhJ
	 0aArdvOOq3Cfyc57GPts7i4u81P4emwitOJ5faR79pzD1aVDTD/SbV10RMoCBfDo1t1w+
	 7fnACf5j5xkBQXLv338wajR9/TM1qgpgAN5juRyngNk1iI93bcqUEVMb+4Z5H/I5WZt4y
	 iGZrGMArtqtLllQjpS4JexUnPdOP8L1WXfPsxOJM/IalededkUMYsqma1MhJ6+GuOYzww
	 Hj1BtB0V8FTdY6HqFX3xCzh0tHqF8E1GFl72/6ygx+oNNRTyphjQWi9NVTxhHgbvWqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459589;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iv45LYvShipprxhBkf3sNas5OmhdAQ95E5Dvn1ERyFo=;
	b=XWhM/RleqsZl2hOSB2mOqjRwu2nAE+/HcmZyFeJsk9vjQM1+Un+OisO43x2S999Ndt9B
	 Y2j/MeiMKSKMpC/FSm3eZ2Oh1TmyxxOj+9dJgVbyP7QYVAKMQFTDZcqexVR4TARrZeetK
	 3hS0PZG9huCBj5ER4a6u3JffqySCISrVsXqMvz2+gNM9++2AyMkZ8AqfgIJP/FsIvl2Pu
	 K8++XZ0rwdBaiXCQwx5b7bpRy7gtJXScDcfPvyilNHs9wiPSbEc6yMCtO3E22UJHe8+vL
	 fCjPDNDK64WIsV8xgcotjAEZDDss7SvFh4xFHfXd8QpB5Eu79UyRo4JrRGaTWZuoHyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYiw+6hs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF532606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYiw+6hs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED351F000C4;
	Tue, 20 Oct 2026 01:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459588;
	bh=iv45LYvShipprxhBkf3sNas5OmhdAQ95E5Dvn1ERyFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nYiw+6hsB9i4RytPGWvNiRoejUZ1xcA76HRw9E/mjxMLYrzjtNuvE3NFNAdW7z8P/
	 CKMpfJsDj27WvsAoOCU49pa/ArduzMAbJy5fhH7wid9JwnmVYtVABqV8UKHqzzi/8B
	 IgFqwuZAiFF77D9K1WXQcz7a5KdoEMtG4kBbisO2hHEePtmcuEChDx2GjY/mc1hQME
	 yRA7+UAivQyptTw+z4Oqz+U+RJFf1wUvDllJitzkR6M3yvlQa84fEaNkG/c310+JnO
	 g+WDoEjCzDCvR1BQ11SFDem33sy/NrbunoBnooJi+6DWOOtId4JkKUnJpZ5NxBTYOW
	 yeqk4XGPp69og==
Date: Tue, 20 Oct 2026 02:26:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, vishal.l.verma@intel.com,
 iweiny@kernel.org, ming.li@zohomail.com, icheng@nvidia.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 7/9] cxl/region: Factor out cxl_port_setup_decoder()
Message-ID: <20261020022624.3cc65948@jic23-hlaptop>
In-Reply-To: <77d38f529a6fdb26cad5e52ac8116854e2d62a7c.1792263750.git.alison.schofield@intel.com>
References: <cover.1792263750.git.alison.schofield@intel.com>
	<77d38f529a6fdb26cad5e52ac8116854e2d62a7c.1792263750.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 12:28:53 -0700
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
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

given my feedback on v3 is now in the next patch.

> ---
>  drivers/cxl/core/region.c | 88 ++++++++++++++++++++++-----------------
>  1 file changed, 50 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d25df041e922..025cf21adfa9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1565,46 +1565,11 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
>  	return 0;
>  }
>  
> -static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
> -					 struct cxl_region *cxlr,
> -					 struct cxl_endpoint_decoder *cxled)
> +static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> +				  struct cxl_decoder *cxld, int iw, int ig)
>  {
> -	struct cxl_port *port = to_cxl_port(cxlsd->cxld.dev.parent);
> -	int iw, ig, rc, pos = cxled->pos;
> -	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
>  	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_decoder *cxld = &cxlsd->cxld;
> -
> -	/*
> -	 * While root level decoders support x3, x6, x12, switch level
> -	 * decoders only support powers of 2 up to x16.
> -	 */
> -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			cxl_rr->nr_targets);
> -		return -EINVAL;
> -	}
> -
> -	if (cxl_rr->nr_targets_set) {
> -		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> -			if (ep->dport == cxlsd->target[i]) {
> -				int distance = cxl_port_peer_distance(port, cxlr);
> -
> -				rc = check_last_peer(cxled, ep, cxl_rr,
> -						     distance);
> -				if (rc)
> -					return rc;
> -				goto out_target_set;
> -			}
> -		goto add_target;
> -	}
> -
> -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> -	if (rc)
> -		return rc;
> +	int rc;
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
> @@ -1643,6 +1608,53 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
>  	}
>  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
>  		dev_name(&port->dev), iw, ig);
> +
> +	return 0;
> +}
> +
> +static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
> +					 struct cxl_region *cxlr,
> +					 struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *port = to_cxl_port(cxlsd->cxld.dev.parent);
> +	int iw, ig, rc, pos = cxled->pos;
> +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
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
> +	if (cxl_rr->nr_targets_set) {
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> +			if (ep->dport == cxlsd->target[i]) {
> +				int distance = cxl_port_peer_distance(port, cxlr);
> +
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


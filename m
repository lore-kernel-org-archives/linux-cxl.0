Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E9246781
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681755; cv=none; b=R05XrwokD6kyoeGL4X9uUj3nMIeXDaCuNelkOKZvfSAV5dd+PTMgrIX3HLB/sJ7VLGCJLIVQ3r6f6doTCdehlXuVzbjYoZ+tx0WJ0U73BpntsAF/zqeV6Po2sIXOLc+UGpzzOdery0fo5Pa70EGmTwNN9nBVj96w9ykHyEjfyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681755; c=relaxed/simple;
	bh=FYi3ohHMG0bPyHLfTOxtLAMGZi9VUCl8TpQejB235SY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWtbhfUsj/XjEPRqkoSgoPOIad60U2a6D68mKQlKbdFE6FpKOXcK2kVobD9FDn5pQ4S9E8hZXf0mX0ZOp1gpmB1BYcsuZvkkPP/SQXMksY6UvXoussbw3QCnq7cID0KIePdD/0GlIWLgpKs470qBD/5bkpPgCTzXR10QkUrmeBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP+pslJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP+pslJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA8E1F000E9;
	Wed, 22 Jul 2026 00:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681753;
	bh=c5naB8oPgsmoVSwXhSz1i1+AFDZEkh70M7tmtubQro4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FP+pslJLxnexQToYPPLAwG+968wMtQ4AtRLcnfWf5TMFq0gjHm5jGyaD/NsgpjHju
	 okQ9903W4JyVSDFmkazHfK/tiljgyoP2Aj2YFW+uds+ygBh8rYBWCX4evdgu+L7Ac9
	 wFmvQw60YyAsVwhOVWF7EgKRNQz+NZ8XKhQmOSW3kzzA80AxcAPbPmY5MpBj4BUmUA
	 wCpWORO5cZ8wlE4XCxQNx1OJt9mRKR0Gm7cTbiz8qsCn576DVwvI1FofdD7DDn1YYU
	 HkHpMJqk1gl9fY/6BT5X1xdS0wDl01XcxL5JW78NrljMOwrign6BTC4iE3rRVuMZpg
	 XPP80w6rC8uzw==
Date: Wed, 22 Jul 2026 01:55:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan
 Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v4 1/4] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <20260722015547.6c3bdd47@jic23-huawei>
In-Reply-To: <1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
	<1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 18:59:37 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Switch decoder enumeration validates that the interleave ways encoding
> is legal, but not that the resulting number of ways fits the available
> targets. This can overrun the target arrays during enumeration.
> 
> Reject committed decoders whose interleave ways exceed either the
> hardware target list capacity or the reported target count. Reject
> switch decoders that report zero targets.
> 
> For uncommitted decoders, ignore the stale interleave ways value and
> reset it to one until the decoder is committed.
> 
> Add a clarifying comment that target_count is a direct count, not
> 0-based like decoder_count.
> 
> Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

oops. I replied to v3 after you sent this out. Please take a look.

Thanks,

Jonathan

> ---
>  drivers/cxl/core/hdm.c | 33 +++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  2 ++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..d81df45d8005 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  
>  	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
>  	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +
> +	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
>  	cxlhdm->target_count =
>  		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> @@ -1084,6 +1086,37 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		cxld->interleave_ways, cxld->interleave_granularity);
>  
>  	if (!cxled) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +
> +		if (cxlsd->nr_targets < 1) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: reports zero targets\n",
> +				port->id, cxld->id);
> +			return -ENXIO;
> +		}
> +
> +		if (!committed) {
> +			/* Ignore interleave ways until commit */
> +			cxld->interleave_ways = 1;
> +			return 0;
> +		}
> +
> +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				CXL_HDM_DECODER0_TL_TARGETS);
> +			return -ENXIO;
> +		}
> +		if (cxld->interleave_ways > cxlsd->nr_targets) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				cxlsd->nr_targets);
> +			return -ENXIO;
> +		}
> +
>  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value = (hi << 32) + lo;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c0e5308e4d1b..291ada46b646 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -67,6 +67,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
>  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> +/* Two registers with one target ID per byte */
> +#define CXL_HDM_DECODER0_TL_TARGETS 8
>  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>  #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>  


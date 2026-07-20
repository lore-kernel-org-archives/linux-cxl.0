Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E13A543F
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784528093; cv=pass; b=tCL5bqOHknJlOlo986h9TwTt3R0ikCSOiPPrbe7EUFM9O9cU1F3etRbhac/Azqo8xw2Y0Kuae6tIGY5X02b2xC+c3Dp0q1n1/yppD8cWpIrIU4RQWEFkNKSoy1LCVMCXmKSlipuKD1NAaqUgsWG0fDpEH/B/XKFQPh5GAdL/RdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784528093; c=relaxed/simple;
	bh=vx0ljldpH5plEOTZnN3935zcFM2Qtn4b9wj5TIaOOyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZXPgQSZHup4NZ3LHjo66SP7UGFzeiWEXDuIX9GiSPM6BnTDM/OKGdXQGMypcjwOCl5AeB/1qT+gbJR9wYr3i+DFMEOO3lwVgMgsichVatx7f+AfhQ9iYOdTRNS7/E7QMpgoqSiyg49qj1tC25Q9Ik6YRg1Z+sFs8BS0+T1Cgkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=QDzdSKRi; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="QDzdSKRi"
ARC-Seal: i=1; a=rsa-sha256; t=1784528077; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BUPb12QONP3bJcyS+46Hea0Gyu427eskTNGJaeRvUxGVR/PrwMswUHQQ3+zJJgcYS7hfda68omEdP4f+Ru8GHRD5pT/MD+nLlbXZu/EZ6wTCgV85EM5G/HZdiQI/odEd9sueBmbQLggivGzhDC2JneY07F7prlAHIh26VRc1Ojw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784528077; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k9ZfCjdytUEmjY5beTWoIzrmvKVsglvJlvl/nMf94Js=; 
	b=BoIAncGj0wwUAYjpQZcf+dh6IDHypamHgq3E4267mb98+To2B21f0JUdsP03feKqP2JISiwMTvVmlTcnByiN224xghHj/BuaPIsvPjRAcSeLXVxiWqtI2CQOd5bDqmBaiIY4v/CWSAjNwbdgZU9pigM3OOaUK9/Bs5F+G2myfMg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784528077;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=k9ZfCjdytUEmjY5beTWoIzrmvKVsglvJlvl/nMf94Js=;
	b=QDzdSKRivtTWhwsdxDe7egY9Es3vwxO9ZnuykreIC7KWkzmk1aHup+Q/rYoBbh3c
	LhBIzOv7XEgAceuAPkzWca4e+L9QVZ+FiHGbE4LWcZMf5wlM4z1Kl0qwgDJ0ofL+08C
	AJ3iWN6L5sd9W8Y2zM/c4WrQ2oIi6jAuzkRColmk=
Received: by mx.zohomail.com with SMTPS id 1784528075513175.0852934525442;
	Sun, 19 Jul 2026 23:14:35 -0700 (PDT)
Message-ID: <0967bc78-226d-47c2-a8f6-577577976c89@zohomail.com>
Date: Mon, 20 Jul 2026 14:14:30 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cxl/hdm: Restore commit_end when decoder
 enumeration fails
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <cover.1784322343.git.alison.schofield@intel.com>
 <d75080ecb9fad922623781e9e354baab05842c2a.1784322343.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <d75080ecb9fad922623781e9e354baab05842c2a.1784322343.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112275e04263379fca5da3ebc179500008b838120dcf5ade573c917b9981df57da425d7134107d5af0f:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/7/18 05:42, Alison Schofield 写道:
> commit_end tracks the highest committed decoder on a port. It gets
> advanced before decoder enumeration is complete, so a later failure
> leaves it pointing at a decoder that was never added. The next probe
> then rejects decoder0 as out of order and enumeration fails.
>
> Reset commit_end to the none committed baseline once the decoders are
> torn down, so a subsequent probe rebuilds it from scratch. Register the
> reset before the decoders are added so that on unwind it runs after
> every decoder has been unregistered. This prevents commit_end from
> dropping below the highest committed decoder still registered and
> exposing an inconsistent value to a concurrent reader.
>
> Protect the commit_end advance in the DVSEC emulation path against
> concurrent readers, matching the register-programmed path.
>
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   drivers/cxl/core/hdm.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 4aaadb842d90..6dc6e53c28c6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -955,7 +955,8 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>   	 * change the range registers at run time.
>   	 */
>   	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> -	port->commit_end = cxld->id;
> +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> +		port->commit_end = cxld->id;
>   
>   	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
>   	if (rc) {
> @@ -1183,18 +1184,34 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
>    * @cxlhdm: Structure to populate with HDM capabilities
>    * @info: cached DVSEC range register info
>    */
> +static void cxl_reset_commit_end(void *data)
> +{
> +	struct cxl_port *port = data;
> +
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +	port->commit_end = -1;
> +}
> +
>   static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>   				       struct cxl_endpoint_dvsec_info *info)
>   {
>   	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>   	struct cxl_port *port = cxlhdm->port;
> -	int i;
>   	u64 dpa_base = 0;
> +	int i, rc;
>   
>   	cxl_settle_decoders(cxlhdm);
>   
> +	/*
> +	 * Reset commit_end after all decoders have been torn down so a
> +	 * subsequent probe rebuilds it from scratch.
> +	 */
> +	rc = devm_add_action_or_reset(&port->dev, cxl_reset_commit_end, port);
> +	if (rc)
> +		return rc;

Seems like devm_add_action() is enough here. port->commit_end is -1 already.


> +
>   	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		int rc, target_count = cxlhdm->target_count;
> +		int target_count = cxlhdm->target_count;
>   		struct cxl_decoder *cxld;
>   
>   		if (is_cxl_endpoint(port)) {

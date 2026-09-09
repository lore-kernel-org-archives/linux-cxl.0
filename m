Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9142E405
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990053; cv=none; b=qExJsJ02PH4vJTVxcNHNyw8QRc0ewt54s/jhGD7GNqLMalZx38rJDvyZ+wHLRkgeQ1/HkF7PuZOosV0K93MrNUwO/kYGmO8ew5yxjXQCDRDQSv6PErZTZ9+uFplns7Cj1TLVXaL14TIqlLSPnsv74UbjQV1xPeQqopH4sp0JXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990053; c=relaxed/simple;
	bh=O581mwPoEvwfd46phFLrQq8wr/8V/Y6s/HiF48sFf8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnwVc/VMo1f1QjV5Li3W2Un7T+8og+dxGo2GoMJ06pTncFCLSXmSmSSWrWmNqiVMb7ExiZIplFOaoqx5Vg2gUfyvtOmFJ2lbSfy0epORpbOsDPmIvMGesU2kDWq6aJI7xx6/rhFtTXFdmtHHBFFYmaQWKDdLgZi4tptTNdJ4BbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1QXIJFa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1QXIJFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC581F000FF;
	Wed,  9 Sep 2026 21:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990043;
	bh=xn5FNcGwVIkTxQNuA6Xwb9n0+8JWqGX4uXtF2Ulxlas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X1QXIJFacsNafZ9WSY7LCr+zJLeBF+nFN5auy1XB6MFF+4Qi/VWEGN8d6UVg94EiR
	 wLk60q45NpSXZDM2DdWiHkki7NvsLp4XQro04p1TW5ZXSn+/3coCrQw2VfLz0mo5bl
	 1bThXAPExGzjad/QZiKbDhBoUUEyM5SUDDmMHLaZkpmee8g7jXe4nE1g5mmIhbAehl
	 Nxa+lHkTCYKS7Clw22E8xy0SUphdfHLtVvWzO/6No+bgjVY4DOnN6KN9Szs1VLs+ZU
	 vC3A+zYKjb0KXqj0KSOO/H8OSmH+t/7LuHelfWsudonp+C9c+l6cRT143voZyyOFq3
	 gKG+ES8VmvCLA==
Date: Wed, 9 Sep 2026 22:40:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 07/10] cxl/pci: Split BI capability probe from setup
Message-ID: <20260909224037.7bd984d5@jic23-hlaptop>
In-Reply-To: <20260909170302.1550680-8-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
	<20260909170302.1550680-8-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:02:59 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Decouple the topology read-only capability verification phase from
> cxl_bi_setup() into cxl_bi_probe_capable(), recording the result in
> cxlds->bi_capable.
> 
> This allows further dealing with auto-committed BI hdm decoders;
> having such knowledge upon decoder enumeration time.
> 
> No functional change intended.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
One question about whether you can reduce the diff by shuffling things
a little.  Either way
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/pci.c | 87 +++++++++++++++++++++++++-----------------
>  drivers/cxl/cxl.h      |  1 +
>  drivers/cxl/port.c     |  1 +
>  include/cxl/cxl.h      |  2 +
>  4 files changed, 56 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8c3c00137849..95064be6faad 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1297,59 +1297,37 @@ static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,

> +/*
> + * An SBR wipes the device's BI Enable; an FLR leaves it alone.
> + * The check is against the hardware, not decoder state: BI is
> + * enabled at probe, so it can be wiped with no decoder ever
> + * committed. A wipe invalidates the software state; BI is never
> + * re-enabled here.
> + */
> +void cxl_bi_reset_detected(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	void __iomem *bi = endpoint->regs.bi_decoder;
> +
> +	if (!cxlds->bi)
> +		return;
> +
> +	if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
> +		      readl(bi + CXL_BI_DECODER_CTRL_OFFSET)))
> +		return;
> +
> +	dev_dbg(cxlds->dev, "BI disabled by reset\n");
> +	cxlds->bi = false;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_reset_detected, "CXL");

Why did this need to move?  Just to have a nicer code arrangement?
Maybe not worth it given it makes it look like this changed
and it didn't.  I'd leave it where diff thinks it was originally.



> +
> +int cxl_bi_setup(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dport *dport = endpoint->parent_dport;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	int rc;
> +
> +	if (!cxlds->bi_capable)
> +		return 0;
> +

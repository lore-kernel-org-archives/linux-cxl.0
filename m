Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E237D110;
	Wed, 16 Sep 2026 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525863; cv=none; b=Xh8/Lz0sXxGV/yAyuy7CyleipiTZ47y3e+ePttSTXjZITdEYXUT0SsTNcq0zFNermZlrIv6i6++xSe6ttOWVYlxffXs2kDbLOCCnGwMiYqf2dmi8Qh7D0ljiSI7DbVxMEzf02CMhSoLPD8EBpfDGBscX30xFsOJIgE9XJpyUFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525863; c=relaxed/simple;
	bh=pw+n6er4vS4wyzBCMDGhcqZmWJ9EK0FIgNbuKws4uHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=td68QOoWY1A3zKr/Jj2HfmXMUXwjv0BiZguKg7uw+W5i62ARlgSH+at1G+yKR0FmPan0JAiIx9RNOrZCt9O7jLnERLFpMLRDaNhVjGn7nq6cAotYDV1dUX7zr6QlpAThZnLVzs+GpV17O7Nwksru52f1YfmF+jGjUQiBpPIzn34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRwnRwjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRwnRwjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54771F000FF;
	Wed, 16 Sep 2026 02:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789525859;
	bh=XayTTHaA/20/1YHJcAIDuIRqedh5Y2E5vDdd0Hn0sM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oRwnRwjERKFYQDK/2mLv9Yf0I9hJ0FToDH1T/KyP2sCOTLUyw/azzYzJXe0v2/03T
	 J4LIBBmMDdxFZmASyxatdrDhVi8knxpWIQwgp5pN+eTQuWuwGCYlNYdt2Z7+NVEYLL
	 D9aBB656odwb605fKZpBHSDdq9kwAv/bLrRsEYYSHNWudgE8lt1nvEl/jygjGYmGbz
	 SoAa2ELMCXs6SDWCh0WBhGKNqPQGPK32GWp0h5CCXc0ibcbXYpnz9TG5qO9wW+Ee8E
	 X4I+hoPQsKATcOwlUusHiTi+qDEpeQs53Zd030Nxalner+mbhCiDP/yvzEGUs2rnGK
	 N0X0Re1ybmaOw==
Date: Wed, 16 Sep 2026 03:30:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com,
 gourry@gourry.net, rrichter@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kees@kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH v7 4/7] cxl/region: Start unmapped poison scan at the
 committed decoder boundary
Message-ID: <20260916033056.7f7be089@jic23-hlaptop>
In-Reply-To: <20260902053839.25595-5-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
	<20260902053839.25595-5-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 13:38:36 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> poison_by_decoder() stops at the last committed decoder and records the
> handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
> starts after the highest DPA allocation instead. Allocation exist for
> uncommitted decoders too, so their DPA is skipped by both phases and
> poison there is never reported. Resume the scan at ctx->offset, and scan
> later partitions in full, restoring the pre-rewrite behavior.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Whilst ctx->offset is conviently there, I do sort of wonder if
we should instead be figuring out directly what is committed.

Meh, too complicated. This works for me.
Jonathan

> ---
>  drivers/cxl/core/region.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ddf12075b95c..b7dc5d4988da 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2907,7 +2907,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	const struct resource *res;
> -	struct resource *p, *last;
>  	u64 offset, length;
>  	int rc = 0;
>  
> @@ -2920,10 +2919,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  	 */
>  	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
>  		res = &cxlds->part[i].res;
> -		for (p = res->child, last = NULL; p; p = p->sibling)
> -			last = p;
> -		if (last)
> -			offset = last->end + 1;
> +		if (i == ctx->part)
> +			offset = ctx->offset;
>  		else
>  			offset = res->start;
>  		length = res->end - offset + 1;


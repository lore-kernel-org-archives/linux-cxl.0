Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B349B5BA
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077512; cv=none; b=FeQysaxLJTkUtrBm1ngioRx6havgvm4cvwKxFygikZheDeaO9WUd1yWNvUtocbcNakL7S7DgjpZuTkURLW2+it4pbny5CYSF39L4M77TBpna5XBDZpsQStN4tste8nTeHvgI3HxjMxuf8+dnO4cp/cufHEznp32KVl7+a8Hq+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077512; c=relaxed/simple;
	bh=1IF9UAk6gTQfao5RoazJnmc8uUyLttkdl6lzd7xEq1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vj8P02ibHxj+jcI7oNiQW5+/US6SO/ACAzql7urAajYliZKY7o5jLRiiRdxCr3BMiWcg6zpmF8PwO1CSvi7RdBc54w6MIKqFgIffp1KzeloPQ0bSrIaQz4weDbQgIlatEVUeeFYPvEtHDx5nUAlJxxPeLVw/61c8dL76MKuc3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpTtdgxy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpTtdgxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDF21F000FF;
	Thu, 10 Sep 2026 21:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077510;
	bh=6kahQvkRtTzgThGZuGb2gfiVsZnuTWmo6a7lorjVLbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RpTtdgxyHJGa6dtjikDrzevcHE6maU/z3KUiKG8Db5bkisgmr6ZoT/cWX2B9vgUeV
	 tfbeHnS2XO2P0HpGQuroVbTyHZgC2dzxOzBP9G2dB4Slp8nPJLOa7uKJR2XnHdaiIw
	 hHLTvdkQsg3hGTRawj4n0PNu3k1lkU3R9lkz/IpqK9S6AL/llBwePlB+go1gVcHT6o
	 oYczl/vXKiIcsshGzhIbYdzR09eG5mgNBORyXg7uP+B5BjySqfYUEqLjcsfp+Tqpet
	 a1yxXm/jndlLiU8ux9l10+qR0OoiZEHl/v6gUSW8BHv7blMttBrMHVBofbJnK8a0yY
	 5rFwm3upkqsUA==
Date: Thu, 10 Sep 2026 22:58:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cxl/port: Fix uninitialized coordinates reported
 for RCDs
Message-ID: <20260910225825.6da05619@jic23-hlaptop>
In-Reply-To: <20260831092216.540644-3-kanie@linux.alibaba.com>
References: <20260831092216.540644-1-kanie@linux.alibaba.com>
	<20260831092216.540644-3-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 17:22:16 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> cxl_endpoint_get_perf_coordinates() returns success for a Restricted CXL
> Device without calculating coordinates, so the caller's output array is
> left uninitialized. Callers treat it as valid and can expose the stack
> residue as access coordinates.
> 
> Initialize the coordinates to zero before returning for an RCD. Zeroing in
> the helper rather than at the caller keeps the @coord output contract the
> exported function documents.
> 
> Reported by the Sashiko review bot.
> 
> Fixes: 5d211c709059 ("cxl: Fix cxl_endpoint_get_perf_coordinate() support for RCH")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
Makes sense.  You 'could' add an __at_least marking to the coord parameter of this
function just to make it clear this is the size (well technically the min size, but
that's fine).  Not important though and not really part of this fix.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/port.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..fea43a92744c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2394,8 +2394,10 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  	 * Skip calculation for RCD. Expectation is HMAT already covers RCD case
>  	 * since RCH does not support hotplug.
>  	 */
> -	if (cxlmd->cxlds->rcd)
> +	if (cxlmd->cxlds->rcd) {
> +		memset(coord, 0, sizeof(*coord) * ACCESS_COORDINATE_MAX);
>  		return 0;
> +	}
>  
>  	/*
>  	 * Exit the loop when the parent port of the current iter port is cxl


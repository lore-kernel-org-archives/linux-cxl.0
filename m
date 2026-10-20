Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532368;
	b=VYuRbF6KcDlXnNjNTo9bGfkRZyxAuRZbCSuhN8pCTzx+bJsCCDdqHK8vKtantDjwnE74
	 FSJK2XM0hUiPKqdD2+kqGg0mQvs+3g6yqA1aSMRNQPCUmwLvqml4mITmFAjJwycM6mfCw
	 pYbOVHLdchiks2bl6CmdacPIm7pjcodX3NM8f/e/GvQmFWIO43pyrE1Hi96IUzaDT5fyz
	 NtjxuAm4cIdyZRs9YlF3OJVR9U9LRgYu5Z3FGvMrasJCJKNhWF+vhOPAWLsK1Ewy1eiS8
	 c9y8/+Sz7lhJSYofnaLH3Dpc5lreRV1PpDIG+EX3+yelJFDTGJLKoS8pJPoHkZhHnmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532368;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iagEJDsq/OndHBLAGr/N0c5jEjtxnQvYIdM7GjxvLkI=;
	b=n0njKAwmb0uNOprLOzyl1JJGY7rpxM05V/D8IBJUMo8Y+VyKdtT/gDAbR9e3/xpYcktQ
	 sEtd6BkuPKlA2wE2kWhinmp1gUtK/3AqMjmLE5mbMtOEqz0j65KWDdjKma38IBVXe/Wov
	 OKS61TzCkUXbSDpigvaMAHnKS4eaY0/w8gxk5zXACFqOOBPaOEQQmz7Hvv8TO8bZjYj5E
	 AUxGXLMAMf5Wr4yJRac14pP44SQggO1U3nuwGr2sl9vRefsGTIH+l3bO8aJTbNucVNdmp
	 yG7PMaBqihS1QNoKxET2HAjnrP07dX5hvJoMP7sutGu0Jrxp2jLxhi4CNQk9Y1PvVuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNcaoEZg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2F606A319
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNcaoEZg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AAF1F000C9;
	Tue, 20 Oct 2026 21:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792532368;
	bh=iagEJDsq/OndHBLAGr/N0c5jEjtxnQvYIdM7GjxvLkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HNcaoEZgUpV853Hy7SidoHp6nMM4eFqpEccnpcc9DI74hENRzYA51jDnwHOe7gyAs
	 APRlK4mrStuRPxVhclr93Z9k9p11EhfjMM+g7Elpl+y08hd+Mxeu8+71ZphPZDxAjZ
	 WgpsdbprPlQMf80eQgq4NWvZ69Cvp+FCcNMOymzIBJxoBDJsIblsR5j5iIDyGP4O4U
	 p4+5pKfll16UWesb787S+XhHIZ0qK3wNKZQC7GGJEZzs/BHTkbIWKGnpIT90fIVA4D
	 LH4dO1UfUqLbMICdF5zGoDGQBn231QXFkSCeoQuffbHfO+3RwIc8PmIrpL4Q+mIT0L
	 XeUBnbk5GHxag==
Date: Tue, 20 Oct 2026 22:39:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/region: Reject a repeat write of an endpoint
 decoder to targetN
Message-ID: <20261020223920.6147db30@jic23-hlaptop>
In-Reply-To: <94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com>
References: <94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com>
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

On Wed, 30 Sep 2026 21:56:38 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Writing an endpoint decoder to a region targetN attribute that already
> holds it returns -EBUSY, but leaves the partially populated region in an
> inconsistent state. The targetN attribute still names the decoder, so the
> failed write gives no indication that the region was damaged.
> 
> Filling the remaining target positions can then trigger a NULL pointer
> dereference in cxl_region_setup_targets(). Root can reproduce this
> through sysfs:
> 
>   echo $decoder > /sys/bus/cxl/devices/region0/target0
>   echo $decoder > /sys/bus/cxl/devices/region0/target0
>   echo $other_decoder > /sys/bus/cxl/devices/region0/target1
> 
> Reject a write to an already assigned position before modifying the region.

Rejecting a write that does nothing with an error isn't the nicest of
ABI choices - not to mention it's an ABI change (even if doesn't matter
much here given previously it probably crashed :).

Can we instead just reject much earlier before doing anything that
needs tearing down?  Would moving the check to the top of
cxl_region_attach() work?  There are some queries before that but
I don't think any of them update state and I think we
already have the stuff needed for a sanity check and early bail
out at that point.

I'm too lazy to actually test that theory so may well have missed something!

Thanks,

Jonathan



> 
> Fixes: b9686e8c8e39 ("cxl/region: Enable the assignment of endpoint decoders to regions")
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> 
> An ndctl patch backstopping this fix in the cxl unit tests will follow.
> 
> 
> 
>  drivers/cxl/core/region.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..f9aafe89e5bb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1762,9 +1762,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (p->targets[pos] == cxled)
> -		return 0;
> -
>  	if (p->targets[pos]) {
>  		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
>  		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935


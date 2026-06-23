Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F33939B0
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244550; cv=none; b=nhuQm68t/6RyItk6b43feCNBm/91XrcrxaN8f8iCbm4pvTEGKVzG62tH0J5cNpa2CvmWtz/RiiGYmUmsirXNIlUBGu59YX3XlH7NzzvHv22dVz3QqV/ppIGexWuJMvgmjiC1bZ6hf4AZ4mijAsTH36xp+LMJfcrihMaLrevGKeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244550; c=relaxed/simple;
	bh=vPrIJqTnOv6bBWQ8lhFbwku9SNJ8NMBLFypflR7j2tw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UaV3hMjdbrivww1ZimMs4Nq5hQ0jApakG8MiYR81IQMsmzNH7Pmb/wdD8Wy/ZcI3YoTXsTRo9vBAjeovfHvrZ3vvm+WF9u5JiLXZrue7kuOX5YAjk6VrCk5XlxkPDy8L2jZROgyWQ5Lk254hgjVJZWfok1kjaS+bmpivqt5yR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvuT1jp7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvuT1jp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A261F00A3A
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 19:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782244547;
	bh=TamdkO/99lND0DyP2RW0Qyvn4QlOK30LgHVRZNI05Qg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=OvuT1jp75bN09jmBqpja++Url3k/OP3NRbrVPE++Sbav1zOkbR00QhgnRv7lBStCX
	 1/8bYLQYlayOQBV8a1nnJ9CU0oUg3X0TvLEwGFPexPSHTrvmY4eGrnmmKKnhArLjRv
	 wHG6XI72fr4X6RtlnQFH+e6kkDkrQrZeGuseGC3s0vj73wU2ZRIfb4sMd/fmQU06kX
	 jv5sXWKS//Fljw/laCqxEhYjeHx6LYdrlzHJEf2sscZNcI9txueUyjcSEo+CwdhH+E
	 jGEoZAMh/3qwDImQGT+0JX1zuGJsW6et7WioohVs6B6FjonQf2JiXnAtfVBd0r36WA
	 GB/as6BhD46iw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id E4BF1F40085;
	Tue, 23 Jun 2026 15:55:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 23 Jun 2026 15:55:46 -0400
X-ME-Sender: <xms:wuQ6av0HzkR_mJsJgsZWWx29-0GumKOopex1nuxlPAqDHaBeyJ8-qQ>
    <xme:wuQ6alis9NuxRys2aUp6TeWeh6vefW27n2C7O6w0waGbI_6X38K5qOWBCV4YetEP_
    JyX-Bdi9DluTrtHGyhVUT-rrrIh_7qaILWGOPq-XgSz6Fl2fONWUA>
X-ME-Received: <xmr:wuQ6atR5ot_wzNnnNouAZUjCM-v7vSKy32zhJU824pGunoh-goIKWulo6INqYXO4d4lQiZtiVvYnDUEiuC8yMSECNynpYPDLemk>
X-ME-Proxy-Cause: dmFkZTFGfjdVKsCRjRg0NKjxM+yFWMNUvQhZskt0GjGIYBMUeSBr6bHMt1EqR9pbht6bzD
    QcuX0bk6eWGrwm6knJRD/5k01KE0xuJ/IRCAvjDK9QR2AJifb6EmNCNX3Ngi5dBRMDG9sS
    nXT4REIapiAwp6poKnqK3k7PtFcLLjH7UywMBygZGEJEaZIr/u+lq8DBMP3J0ZvaEKq6cB
    iOUokWpB6gd/PSPKLeAEEHLrLTi2uqWOc03pWQ45NaIs8Z0VXOMqlb3pLQ6EuqhXmXtvu2
    4Ecn6ntkhHY/Daj4MO+aD3isgrr0fDqqOFtkPwylu5jNd/PvOgI87EyRprbYKgkycobQCh
    hCSneqX/FhHkpHKNYIQsGbsKOrtdaboe0BYU5SgaTTL3ne0sTKXGut3aBlaumHJ9S+4kMv
    bguRGMqNvPytbt/gQA0nt63e8ffGNHUJuFuT8W6Fe951oUCnB0XxwB+XQoEqrSEl4gA2XI
    zohJYMjkYv5bcIRMaG1eRo5creVcHVVe30GhBqQWOdmEAzYPPaG0gUtInAkz6c/jIJw4L2
    5xffwujPPPb5DGNBSbL0Oo809GZQFo8dSyJZCJpBSGbNxbDz16USOlAwDObYRb/1pPQ3m0
    9cZPrfOqqcRzKw3CWQcTKpenfuIl0hlDK7mWY/b+dp4RHzluyqSaEFvxJAsw
X-ME-Proxy: <xmx:wuQ6auja3EExPcaS3bx0Wme3aLREhi6GFlYmUVe2ZR6DAo5DhwooRQ>
    <xmx:wuQ6al4g998VPVwnMSPh-pcw1Lw_rrzURNPM88JNUvkX228w_XLISg>
    <xmx:wuQ6ajC9hsiKNCTA4YJGiudYm0C4Noih3934GQ19L6xlt5SY9moEwg>
    <xmx:wuQ6aka3auXJUIMRrXCqU5maSE946buJuaEKr5sM7po4uy_lNtKKZA>
    <xmx:wuQ6amatz5qM6AiU0Xp9PTtGF-VXbhNO8J8ALwKMfWgXxzFY4nd8o2u_>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 15:55:46 -0400 (EDT)
Date: Tue, 23 Jun 2026 12:55:45 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: sashiko-bot@kernel.org, 
 Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Message-ID: <6a3ae4c17f641_3c9f100b7@djbw-dev.notmuch>
In-Reply-To: <20260623093738.6B2C11F000E9@smtp.kernel.org>
References: <20260623091019.33417-1-icheng@nvidia.com>
 <20260623091019.33417-2-icheng@nvidia.com>
 <20260623093738.6B2C11F000E9@smtp.kernel.org>
Subject: Re: [PATCH v5 1/2] cxl/hdm: Allow zero sized HDM decoders
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

sashiko-bot@ wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] cxl_dpa_free() incorrectly bypasses teardown for zero-sized decoders, permanently locking hdm_end and breaking the LIFO DPA teardown sequence.
> 
> Pre-existing issues:
> - [High] Pre-existing bug in cxl_get_poison_unmapped: prematurely breaking out of the partition loop skips poison scanning for unmapped partitions.
> --
> 
> commit 66fbe5db5d8f3f27534b45af8c4ef71b88ab7f3e
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/hdm: Allow zero sized HDM decoders
> 
> Treat empty decoders as first class instead of special casing them, back
> them with a kmalloc'd resource, since the resource tree can't represent
> an empty range, and keep the skip and hdm_end accounting intact. Guard
> the paths an empty decoder can't serve, e.g. region attach, DPA free, and
> poison queries.
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b4..ccbab2e21f060 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> [ ... ]
> > @@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
> >  	struct device *dev = &cxled->cxld.dev;
> >  
> >  	guard(rwsem_write)(&cxl_rwsem.dpa);
> > -	if (!cxled->dpa_res)
> > +	if (cxled_empty(cxled))
> >  		return 0;
> 
> [Severity: High]
> Does this early return prevent decrementing port->hdm_end for zero-sized
> decoders?
> 
> If an unlocked zero-sized decoder is freed by userspace (for example, by
> writing 0 to dpa_size in sysfs), cxled_empty() returns true because
> resource_size(dpa_res) is 0. The function then returns 0 early, skipping
> devm_cxl_dpa_release().
> 
> Because hdm_end is decremented only inside __cxl_dpa_release(), bypassing it
> leaves port->hdm_end permanently elevated. Would subsequent attempts to free
> lower-indexed decoders fail the cxled->cxld.id != port->hdm_end check with
> -EBUSY, preventing further dynamic DPA reconfiguration?

This is blocked by the fact that there is no path to clear
CXL_DECODER_F_ENABLE due to empty decoders not participating in any
region. The permanent nature of empty decoders is ok for now.

Might be worth a comment to note that emtpy decoders are not manageable
by userspace.

> >  	if (cxled->cxld.region) {
> >  		dev_dbg(dev, "decoder assigned to: %s\n",
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e50dc716d4e82..eeecb588821a4 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> [ ... ]
> > @@ -2953,9 +2960,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
> >  	};
> >  
> >  	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> > -	if (rc == 1)
> > +	if (rc == 1) {
> > +		/*
> > +		 * No decoder with a sized DPA reservation was walked
> > +		 * (every committed decoder is zero-size): scan all
> > +		 * partitions in full.
> > +		 */
> > +		if (ctx.part < 0)
> > +			ctx.part = 0;
> >  		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
> >  					     &ctx);
> 
> [Severity: High]
> This is a pre-existing issue, but does cxl_get_poison_unmapped() prematurely
> break out of its partition loop when encountering a fully mapped partition?
> 
> Looking at cxl_get_poison_unmapped() in drivers/cxl/core/region.c:
> 
> for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
>         ...
>         length = res->end - offset + 1;
>         if (!length)
>                 break;
>         rc = cxl_mem_get_poison(...);
> 
> If it processes a partition that is fully mapped, length becomes 0, and the
> break statement completely terminates the outer loop over the remaining
> partitions instead of moving to the next one. Should this be a continue
> instead of a break so that poison in subsequent unmapped partitions isn't
> silently ignored?

This looks accurate. On entry for a fully mapped partition ctx->part
will be initialized from the decoder for that partition. If there are
more unmapped partitions they will be skipped.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4469A13CA92
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125891; cv=none; b=sNWCmvJMa5sQSZFNvff/yArEW4mewynjbmR2QQpCp3YgVuOwDqUcu/8NcalPTSOFLqCuwX3mRiKkJARMq/0ZSWLP9zAWfeVt0gx8/nQX4dn3lst3YI/3HBK4mgwaFtac0SrzgO8FZpO9RrGytxW15cNoy2Mm8tLqUIYL+A+1Ftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125891; c=relaxed/simple;
	bh=NJMiTih2zn0XIsXvfsdzbTarpvEf3kAZewkWmltC51c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AcKLKz0dmaSq9hvsTbW+EUKctfrDsiXrzHjx7kyS0Fw+Hz54mEYbGYKlhCjcUAXvYAY5aHXHen5sgHb8VVw0Mi6CZB/wXHoWLRSqAGXzdYi7AS3SdtYJE756E1cVRaBw4l54AXNtpoAlBQ/Aw5iuiYP57qlFQ8taiasEZt2PD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF4uniti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF4uniti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5F31F000FF;
	Wed, 23 Sep 2026 01:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790125890;
	bh=NW/IEyqDN6Nnmifca9NNZFip6in/cweC9My2HaB5uWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WF4unitiViFpCvRk0p/UmjXihVUCoDPXz+OTMSZyM5dHI/QKoR+vnyO9t5e0PHGRH
	 30Et450RjbjN6iyWD8QiWEzUSrgNLpBAaJgOnkfOsRQLUIBwL5RVKnRCJVMHMW6f1D
	 kWEpaP/sDYOeRfqDcp7rFkbW952qEUWezjDHNiZVBJ24fV5wx0uWoCySj62jT/jX9L
	 /WcszQdEh67RYHg9lIQDJpWqheVEUFDO4hdtx2pSAVgA3vFiNNNQWrARx3j23wpZa0
	 CsDDE2ytXeVy3fLweVCBfYkcf2Nsg6M/VRPZ8SnQyEfCFcdaRQ38/hCUK97/ZK1BLq
	 ruvnmd5I+Uw9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/10] cxl/test: Add mock BI topology support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <113381dfa31a452a5522ed84b14a3b77b6e027f3.1790103847.git.dave@stgolabs.net>
References: <cover.1790103847.git.dave@stgolabs.net>
 <113381dfa31a452a5522ed84b14a3b77b6e027f3.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:11:29 +0000
Message-Id: <20260923011129.BF5F31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl/test: Use-After-Free in mock_cxl_setup_hdm() on unbind/rebind
--

commit 943579b999ae7670b28d433527c8563008ab779f
Author: Davidlohr Bueso <dave@stgolabs.net>

    cxl/test: Add mock BI topology support
   =20
    Extend the mock topology with a Back-Invalidate path
    covering both the type3 memdevs and the type2 accelerator.

[ ... ]

    Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
    Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 62bd92b3be45f..cddea44e780aa 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
[ ... ]
> @@ -736,10 +767,65 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cx=
l_port *port,
>  	cxlhdm->port =3D port;
>  	cxlhdm->interleave_mask =3D ~0U;
>  	cxlhdm->iw_cap_mask =3D ~0UL;
> +
> +	/*
> +	 * A page of plain memory stands in for the HDM decoder register
> +	 * block: cxled_committed_bi() reads the per-decoder BI bit from
> +	 * it, which mock_decoder_commit()/reset() maintain below. All
> +	 * other consumers of these registers are bypassed by the mocked
> +	 * decoder setup and commit paths.
> +	 */
> +	cxlhdm->regs.hdm_decoder =3D
> +		(void __iomem *)devm_get_free_pages(dev,
> +						    GFP_KERNEL | __GFP_ZERO, 0);
> +	if (!cxlhdm->regs.hdm_decoder)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* likewise for the endpoint's BI Decoder block, BI Enable set */
> +	if (is_cxl_endpoint(port) && !port->regs.bi_decoder) {
> +		void __iomem *bi =3D (void __iomem *)
> +			devm_get_free_pages(dev, GFP_KERNEL | __GFP_ZERO, 0);
> +
> +		if (!bi)
> +			return ERR_PTR(-ENOMEM);
> +		writel(CXL_BI_DECODER_CTRL_BI_ENABLE,
> +		       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +		port->regs.bi_decoder =3D bi;
> +	}

[Severity: Medium]
Could this lead to a use-after-free during a driver unbind/rebind cycle?

In mock_cxl_setup_hdm(), devm_get_free_pages() is used to allocate memory
for port->regs.bi_decoder. During a cxl_test unbind, devres will free this
memory, but the pointer remains set in the long-lived struct cxl_port.=20

On a subsequent rebind, the condition !port->regs.bi_decoder will evaluate =
to
false, skipping the allocation of new memory. This leaves a dangling pointer
that could be dereferenced later by cxl_bi_decoder_enabled().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790103847.gi=
t.dave@stgolabs.net?part=3D9

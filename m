Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CE36BCED
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481321; cv=none; b=nJVEV4lP1KYowPRj/W0AOsEUQSq9qDGCN8heV5pnKMnc56/6qwz/HhpDYCIVRh0RNqoH5Zhw2DXg/+bP2DwIa/y+E9bxY4buAFZgKa4Ftr8s8XKKQR56M4laGP2vC4bETpQznMrUubMRU4sEF5piiuOrjYKOvmH++oFu4sUReQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481321; c=relaxed/simple;
	bh=BExyUmTRcMtsUZQJI8KjL11ZDrOBhX4q4k6/6yGLFLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YTUHy5RLoqRg1+uGdNTZQ41xFCh2p1x7Er7rfwFR8WoyTwxR2icUGNdJTsvrFyMN4qE1Td2WK7Ymn+ae3V+Q5WwmrLGlAFFgg1vePSjLBg+u0xCwXme8uyRggZgTVs2Jz8HcP5H7r1A/3e3WKLpmU/zzfxGY3uuC5aU626qH88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c61X5FkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c61X5FkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61051F00AC4;
	Fri, 31 Jul 2026 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785481318;
	bh=bdm2GwZD5UGw9DLdOvfUT9vYh2vzwbZAzeyq93bGIhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c61X5FkNHYoE+wHLy+iw9Yb8ynBytRTY4aYC/hlmDD40VWga45vBePYBErqz74fA/
	 sq+RyCVB3BXU+phd0YAmhKCgFeboelOzoUsoSVlHHsTkMMzm5MFBWat6ZInkOnAh6J
	 A/3ZIr9Q9C4cC1ssVPKElLPicUNWdoUuSfhxYmU0uw25/fYUV+NTFO4x+A78+05Imh
	 wPBWdL67/ag3W5GNDJZeo0+dKir/wVsBBJC8MoOCn+jaU7TUK/VeG9G7lgGlFlBTwS
	 2CgiUHYA5DHwLEMbtIfSBDQUNDcnf0+BnAC0LoSgj7fefnrNCTlaxRNzeBS2jXo9Iy
	 dHLkvKIXAQLkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] cxl/hdm: Allow zero sized HDM decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260731064902.34127-3-icheng@nvidia.com>
References: <20260731064902.34127-1-icheng@nvidia.com>
 <20260731064902.34127-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 07:01:58 +0000
Message-Id: <20260731070158.A61051F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl_dpa_free() silently early-returns on zero-sized decoders, fail=
ing to release the DPA tracking resource and permanently locking port->hdm_=
end, breaking LIFO teardown.
--

--- Patch [2]: [PATCH v8 2/3] cxl/hdm: Allow zero sized HDM decoders ---
commit d92ffa9b7fbe4708b46c314f7b9ca98c30df149a
Author: Richard Cheng <icheng@nvidia.com>

cxl/hdm: Allow zero sized HDM decoders

This commit updates the CXL core to allow committing an HDM decoder
with a size of 0, treating them as first-class decoders backed by a
kmalloc'd resource. It updates accounting and guards various paths
that an empty decoder cannot serve.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..3b3cfa0f25074 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> @@ -545,7 +572,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	struct device *dev =3D &cxled->cxld.dev;
> =20
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
> -	if (!cxled->dpa_res)
> +	if (cxled_empty(cxled))
>  		return 0;

[Severity: High]
Does this early return leak the zero-sized DPA reservation and break the
LIFO teardown order?

When a zero-sized decoder is initialized, __cxl_dpa_reserve() allocates a
zero-sized resource and increments port->hdm_end.

If a user later attempts to free this DPA (for example, by writing 0 to the
dpa_size sysfs attribute), cxled_empty() will evaluate to true here because
the resource size is 0. This bypasses devm_cxl_dpa_release(), meaning the
kmalloc'd resource is never freed and port->hdm_end is never decremented.

Since port->hdm_end remains stuck on this decoder, does this permanently
block the freeing of any prior decoders on the same port due to the strict
LIFO teardown requirements?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731064902.3412=
7-1-icheng@nvidia.com?part=3D2

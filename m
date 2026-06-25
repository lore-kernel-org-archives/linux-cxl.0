Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355C39C621
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380839; cv=none; b=NUb49817WRwlI7BlR9fXiFZ2Y2cPicalCcay94oHAq1L2oXfC1/xSZMwPtbzIy0XGIWH6rs20SD3ouO3MXbuBQwptcJFGzaXrcUTDOnQFm+FRRIRSoEMYf9gyfxuQRwtSeaieeKPj8gNXDp8Mk5da+o7W2qWAbMgw+kWAdXImvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380839; c=relaxed/simple;
	bh=VjpWUUTfMJrc1T0mTd7/pgBQcfdUw22cIpZf8/zHQv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h2NZjXI1kOd0qjc9dj6soif1DVZeu7Cj9BGgxx+EPRRzwbTECZzPVT7P714M2g42Ngrmah/GAhkwc88olcwcZVc38zYrjUFZbtXBD88w6yDCIDV3RIKs8AxLSP7B3AuhfNzzF7XGv8L0sFx48DuoXngTLCO7GHNHXVz+tpnItC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRoZtcGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRoZtcGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3FD1F000E9;
	Thu, 25 Jun 2026 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782380838;
	bh=EvaR2JkGCnHa3uh1/zb/FlnfEH94AxEmerz7nrbsdlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LRoZtcGOh81Bz2SOqFXJXf7oBVwQqC6syrulvHLYKOTnWvDbAkoNjKjNMENhLwPOt
	 ANPGgSyuQGT5d3Cfrlkteb9rnl7MorjG47PW2C1lOfB8fVEloqNw0VL2GdHiShpZqe
	 cwJglYVYp3ipLr7kKoyHzoKutFoIo4tNP96ml1kO+Gl3SBfJj69ZKlCE/5d9Qg2eRp
	 CuciOasr4F0QtQ0tNAdimzV1uE+HjbNLYF77/K+f450qOK0rg9OC16bam+PKoEiR+k
	 HSTOBSGaBWx7MLT0x4v8inf76SbggnkWN6AtJzdJMHjxMfITVFcFXnd8i8nlt8m2hy
	 tMiDidE6NrVnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] cxl/hdm: Allow zero sized HDM decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260625092857.41139-2-icheng@nvidia.com>
References: <20260625092857.41139-1-icheng@nvidia.com>
 <20260625092857.41139-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 09:47:18 +0000
Message-Id: <20260625094718.8D3FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl_dpa_free() returns early for zero-sized decoders, permanently =
stranding their DPA reservation and breaking LIFO decoder teardown.
--

commit 0afce63a5399c17fcedf2e4f736d16ed9b2f7179
Author: Richard Cheng <icheng@nvidia.com>

cxl/hdm: Allow zero sized HDM decoders

This commit allows empty (zero-sized) HDM decoders to be treated as first
class instead of being rejected. It backs them with a kmalloc'd resource
since the resource tree cannot represent an empty range, while keeping the
skip and hdm_end accounting intact.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..ccbab2e21f060 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
[ ... ]
> @@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	struct device *dev =3D &cxled->cxld.dev;
> =20
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
> -	if (!cxled->dpa_res)
> +	if (cxled_empty(cxled))
>  		return 0;

[Severity: High]
Does this early return permanently strand the DPA reservation and break LIFO
decoder teardown for zero-sized decoders?

By returning early for zero-sized decoders here, the cleanup logic inside
devm_cxl_dpa_release() is bypassed. This means the kmalloc'd 0-size
resource and any associated skip range aren't freed, and port->hdm_end is
not decremented.

Consequently, any attempt to resize a zero-sized decoder would fail with
-EBUSY because the reservation isn't actually freed. Attempting to free any
lower-indexed decoder would also fail with -EBUSY due to the port->hdm_end
ID mismatch.

>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder assigned to: %s\n",
>  			dev_name(&cxled->cxld.region->dev));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625092857.4113=
9-1-icheng@nvidia.com?part=3D1

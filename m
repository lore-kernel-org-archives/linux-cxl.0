Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F63438BA
	for <linux-cxl@vger.kernel.org>; Fri,  2 Oct 2026 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942534; cv=none; b=ZW77Xmh3a2r/Eo5udBfPQYfJWOV9muPZKuA0PC0ezfEugRaBVT1Ms5iP7yQg+lzxLocNsvRcF7r08CbSEyEPQigJHdElGkcQmYvxrgmwd2KiMLnldyUJwo4cYCjrz7gtt4YqYtazkz70IgItOb7jOWKiT9UWDN6EuAx9yBXJwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942534; c=relaxed/simple;
	bh=nW+T7lZhuopKEmbbUhPV3utdDmHaaW8G+/ZlVD4XeRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HXHZ/xhmTe2OUOAR3MCOJw9Hx7bESzGZQlyZqKmQLoensAU4WyqsZ3OxhkEW3FCoOY6OfXtJS3652SIzq5+zcszwU9nNLF3D0rwp4ovDjs25qe+aWk4llQ5W8XTu4IzKqjL57g0pccnsTjoZ3Y7LaMtlLAiCgrrOer88rFyjoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnvDl8yI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnvDl8yI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413011F000FF;
	Fri,  2 Oct 2026 12:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790942533;
	bh=ljwuoVol9xq30wBmH+IeOk2mEsu38Pri7BJSMrrPVEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RnvDl8yIhTysnrF6Q+X9myB7fPOMbCYMH8UjWPOSxFZQcAi169i2yllPUqMyLgsQh
	 A9KTG/E9C3XxKM9rcJQKf8CKE94P10wDTq8hpvrWmQUR0SU4O9mT1zH1uLj+Nvqlbf
	 Nv91+K6QXr9/IoexKE7GaUYImM6D5E3c1nPFfzAQob6r7cfAI1bZINLwknE1N3Zi9S
	 Y5c0kgEPWsnrmEpdxHvMaEVyeZzjkzIww9ic40xxqUQV4/2vXGYgrt95v++Q5l6Wbc
	 m6VzV043sIRPLL/UzOa52KqNqBs9uxApcxBrlenaVL0At/QJ3M2dONguOFe+DBhupi
	 yHj4cQ4d/mxIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] cxl/region: Add region reference in memdev
 attach
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261001132023.17032-3-alucerop@amd.com>
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-3-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:02:12 +0000
Message-Id: <20261002120213.413011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl/region: UAF due to dangling attach->cxlr pointer after endpoin=
t teardown
--

commit c1388a867928fb269ed84b5e755417256bbf4bd5
Author: Alejandro Lucero <alucerop@amd.com>

cxl/region: Add region reference in memdev attach

This commit adds a new field in the cxl_attach_region struct to link it with
the region the memdev is attached to. This facilitates device links creation
where such a region is the supplier with non-PF0 physical functions wanting=
 to
use the CXL region being the consumers.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c8..78ca7ebc3e557 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4132,6 +4132,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxl=
md)
>  	if (rc)
>  		return rc;
> =20
> +	attach->cxlr =3D cxlr;

[Severity: High]
Could this introduce a regression by leaving a dangling pointer that leads =
to a
use-after-free?

When the CXL port topology (endpoint) is unbound or torn down,
endpoint_unregister_region() is triggered via devm on the endpoint device.
This drops the reference to the region and potentially frees it.

However, the attach struct (bound to the parent PCIe PF0 device) outlives t=
he
endpoint and retains this dangling attach->cxlr pointer, along with the
non-zero hpa_range.

If a secondary PF driver probes later, could it check the unmodified hpa_ra=
nge
and dereference attach->cxlr->dev when creating a device link? Should there=
 be
a corresponding cleanup action registered to clear this pointer?

>  	attach->hpa_range =3D (struct range) {
>  		.start =3D cxlr->params.res->start,
>  		.end =3D cxlr->params.res->end,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001132023.1703=
2-1-alucerop@amd.com?part=3D2

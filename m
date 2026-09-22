Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CD1479891
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099776; cv=none; b=u4PS9izeuYK1aWrAxr1y76I7w6JWf07J99OY2KxYImHWWXir4Y/hRPRnp83mUmWLk6/M2F+lIC5ncyb14QB3bP+NY5CatPbf9xzbfNpOYBK79nmLpgAVugGjqkWLov/GGhXvfrqDcY4InFw8aNjMtzdZNN3V5WAyuHhaRmkhocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099776; c=relaxed/simple;
	bh=C/+iG3WuCf34CEe20cQ9EAGmkQ9irEPIfkaaHjydgFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMqCOnQjOHGBdm+CCLbgw3isOd0cIA+2itFgI/cMoiszzXuF4eEd8QU0BHOYNPh5T1KP8REWnQ+9qca42h9V7HXG4WfexpR41NzNTZgNNjrvHIu0gGEp1KlQsheD64u1/IUZU6XP5dlf12GQgx7wY0/cTRNgDOBLqU6pSGR0mmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa6wWrTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa6wWrTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC7F1F00893;
	Tue, 22 Sep 2026 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099773;
	bh=1g8ViXK9yo7QvpkD+v6B5TQVB/7EM7b5fUmWvbwGNxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oa6wWrTsfGMO2v1PdWMfq9Vakjn4fMbVZzHCu+AnYFFjGYwTEbRFVpAFIWqb1AOLN
	 QtQNu9M/Ham48OFBObei+f4KeGWauXowl873Xrep4Pixd6HMs9j/R8PYeWax1l30Vm
	 UHSroq5FJ4xxYkcjX8WTi/5ub/ZB7fvbGKgtsTDJUB4DEdiN03L+LI1F/lzM4jlDrI
	 h3cKHuJcy1SR71VVlVHjT3RzmNCkp8T5+IoI4P1CnXXhD4VO8JtSPoowDIyNSCXBt1
	 2FMUTAb63eqGb2E6OmS0ie1VPsisQDKTwK3xHgTNGKRJJxNjFK+DrU98Ub9w0oC8yY
	 BG4nqDwr16QLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] cxl/region: Add region reference in memdev
 attach
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260921191239.4249-3-alucerop@amd.com>
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-3-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:56:13 +0000
Message-Id: <20260922175613.7DC7F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl: Use-After-Free of attach->cxlr when endpoint unbinds
--

commit 0680840dffb6451e74369681a082d7e4373586f8
Author: Alejandro Lucero <alucerop@amd.com>

cxl/region: Add region reference in memdev attach

Use a new field in cxl_attach_region struct for easily link it with the
region the memdev is attached to. This facilitates device links creation
where such a region is the supplier with non-PF0 physical functions wanting
to use the CXL region being the consumers.

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
Could this result in a use-after-free if the endpoint is unbound?

Looking at cxl_memdev_attach_region(), attach is dynamically allocated on t=
he
parent PCI device (cxlds->dev), but the lifetime of cxlr is exclusively tied
to endpoint->dev via the devm action endpoint_unregister_region.

If the CXL endpoint port (endpoint->dev) driver is unbound independently of=
 the
PCI device (e.g., via sysfs or error recovery), the devm action runs and dr=
ops
the final reference, freeing cxlr.

However, attach remains alive on the still-bound PCI device, leaving
attach->cxlr pointing to freed memory. A subsequent consumer calling
cxl_get_pf0_memdev() could then access attach->cxlr->dev and trigger a
use-after-free.

Should an additional reference to cxlr be taken here, or the pointer cleared
during endpoint teardown?

>  	attach->hpa_range =3D (struct range) {
>  		.start =3D cxlr->params.res->start,
>  		.end =3D cxlr->params.res->end,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191239.4249=
-1-alucerop@amd.com?part=3D2

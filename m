Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595213F9268
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497498; cv=none; b=LMmQR750QA/dMOFnWJkPjg4gF6rRropYz202604jJqyHel2yopkggFsiVByPom4hTSsrpMt26OXBbJm+D29Hir5WJVyt0DkKs2/tfpMIonZhOi8exLb8iGAsfRnC3/N/hAS3r5PSIS6ryPVT/o5VdJopvqSR6EKFVh/pInvkkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497498; c=relaxed/simple;
	bh=WH8uDg171qVqqkeeXatm3qaf+ZnBpKJHMVBMf/7r5M4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P9HtJUwlji43MvIo8KzzNk4MGQ6gWaKGguiTIY1TRqoFtc5+ezHAD0sHqy1VfnAltzUMClMgvE8XqrXpEk84v2T5qdQd6NN/ZLVuQmfiI+u8fN+XAlGGlSDMsnaDo1V0Lxau5+OCE3Xz5+0FCPUR+clLSUbOlkAlaURL9WKxIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/rszBp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/rszBp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D741F000E9;
	Wed,  8 Jul 2026 07:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783497489;
	bh=ATsIu1FUuyzqcOqkhFyss/jcCu3Q2V4VP5Rjmw49jzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/rszBp8U2lTPXtRM/Llnk/ez0SHF/bLc58nbPfnD6+y447rmACknQ6cRY3aT0+za
	 YhUoDIRwLcTuXusiej5I4njLkwYNCfxhevSwwSf1BhFPop+cPEbcjt0OFz8mWLCxQu
	 B4tlwda3YuXaj6e/SW2bWLFRCrxrMxxC6PpVMzsUlfG9/WSUWTSDNallTxgoojdMvO
	 H5b4oDgsrKM1zYPoJGC9Sh+o2b3j+ga3wDxqfb4SLu2FchvHbJyUhSoeTmOuAQY3jL
	 v2BV3/bzocBFhddcxYYGYtRplzPFN+rujBZtfQzait1L4RrKbhcHpt4Zn5WOgv5Vn3
	 XVXMdSGJZM8Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] cxl/region: Start unmapped poison scan at the
 committed decoder boundary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260708074228.43654-5-icheng@nvidia.com>
References: <20260708074228.43654-1-icheng@nvidia.com>
 <20260708074228.43654-5-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 07:58:08 +0000
Message-Id: <20260708075809.77D741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing Out-of-Bounds array read in `poison_by_decoder()` whe=
n a decoder fails to map to a partition.
--

--- Patch [4]: [PATCH v3 4/5] cxl/region: Start unmapped poison scan at the=
 committed decoder boundary ---
commit 3fc5ee5ec0b9d8fae7576a61bcdfd58c1e6ca1c5
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Start unmapped poison scan at the committed decoder boundary

poison_by_decoder() stops at the last committed decoder and records the
handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
starts after the highest DPA allocation instead. Allocation exist for
uncommitted decoders too, so their DPA is skipped by both phases and
poison there is never reported. Resume the scan at ctx->offset, and scan
later partitions in full, restoring the pre-rewrite behavior.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 52ba8e9e42885..ba77416055f4a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2923,10 +2922,8 @@ static int cxl_get_poison_unmapped(struct cxl_memd=
ev *cxlmd,
>  	 */
>  	for (int i =3D ctx->part; i < cxlds->nr_partitions; i++) {
>  		res =3D &cxlds->part[i].res;
> -		for (p =3D res->child, last =3D NULL; p; p =3D p->sibling)
> -			last =3D p;
> -		if (last)
> -			offset =3D last->end + 1;
> +		if (i =3D=3D ctx->part)
> +			offset =3D ctx->offset;
>  		else
>  			offset =3D res->start;
>  		length =3D res->end - offset + 1;

[ ... ]

>  static int poison_by_decoder(struct device *dev, void *arg)
>  {
>  	struct cxl_poison_context *ctx =3D arg;
>  	struct cxl_endpoint_decoder *cxled;
>  	enum cxl_partition_mode mode;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_memdev *cxlmd;
>  	u64 offset, length;
>  	int rc =3D 0;
> =20
>  	if (!is_endpoint_decoder(dev))
>  		return rc;
> =20
>  	cxled =3D to_cxl_endpoint_decoder(dev);
>  	if (!cxled->dpa_res)
>  		return rc;
> =20
>  	cxlmd =3D cxled_to_memdev(cxled);
>  	cxlds =3D cxlmd->cxlds;
>  	mode =3D cxlds->part[cxled->part].mode;

[Severity: High]
This is a pre-existing issue, but is it possible for cxled->part to be -1
here, causing an out-of-bounds read?

If a CXL decoder's DPA allocation is malformed or spans across partition
boundaries during initial enumeration, __cxl_dpa_reserve() can leave
cxled->part as -1 while still setting cxled->dpa_res.

Since this function only checks if cxled->dpa_res is non-NULL before the
array access, could a privileged user initiating a poison scan trigger a
read before the cxlds->part array? Other areas in the subsystem appear to
check if cxled->part < 0 prior to access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708074228.4365=
4-1-icheng@nvidia.com?part=3D4

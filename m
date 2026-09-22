Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D251812E
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073003; cv=none; b=FJAltaChWlLGq/x9ydqoB66U+zMhHGQ0JkDQTQGQEa1fpwPQZ4HjO9dvIzk2VUpQi1I14gGpmdDN8QRMXYj8MYKc9/eJqAcS5rHjJKAtMAqOcGXaYbhquoml1/EMNay72MF+QN36KCedOPzab3E3s4V+RP6/ImrJudaheJE1kZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073003; c=relaxed/simple;
	bh=xeVxUNIw0tbij1oxVqQWqhCFZRa49bgqKQ8gINWeENw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DwfmSllPAMDolYG3UtSJjbozPXwQRU9y0vUzUxzK8CMBCOqe4HyhVsgs297GFuNhH/pesSYdMQkGQ7Ou4Y7VLvHtz9SN8O1/P+TPXBZ3P6goiMcWAyWjLtklr/KSyhk6bezH+WeT+hD9VQsqysthOWNz9zKjWy+95vl/GKbYer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac7ipG/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac7ipG/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A861F00893;
	Tue, 22 Sep 2026 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790073000;
	bh=mPF4XLYseATzApBoEkAP2wsNJznc71kGrqxEQekJYms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ac7ipG/BkdW2+2KdL7r/oEKl0XUlo4wG7LWQTnxrNv0Mea3e/h16QmEMHew1JbmvE
	 QsQiTC5iWGpv6yqlVxq7t2T67DoPw+67msJPW3hyDnD/7UW8QaIGjQGyEv2ax8ENrh
	 rklzLHGdK3INi688ov/2Ov33EMPptXJppZIuGIRFJV6Vs6iKQ9ruji8hlmmHe7GGeG
	 Rid4acibn1k7VzSGRLpoek6wjNtFT6KJa9w/t3h4AuoGkvaArE0pySdJ+wdHrySWcT
	 YUs/ilvLve6cbnM2MYE8IWt9iP+15UR1ifvReDKQ1FhAwcbZJh/KYCQJBAafMOjp5s
	 lCQq2fnwy+H3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] cxl/region: Start unmapped poison scan at the
 committed decoder boundary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260922101129.52794-4-icheng@nvidia.com>
References: <20260922101129.52794-1-icheng@nvidia.com>
 <20260922101129.52794-4-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:29:59 +0000
Message-Id: <20260922103000.88A861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl: integer underflow in cxl_get_poison_unmapped() from unmapped =
decoder offset
--

commit 8602a2ffbae3a910b43392bb444acb65b6b365e7
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Start unmapped poison scan at the committed decoder boundary

poison_by_decoder() stops at the last committed decoder and records the
handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
starts after the highest DPA allocation instead. Allocation exist for
uncommitted decoders too, so their DPA is skipped by both phases and
poison there is never reported. Resume the scan at ctx->offset, and scan
later partitions in full, restoring the pre-rewrite behavior.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 042356c71ed79..4869cdd6a3d48 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -2944,10 +2943,8 @@ static int cxl_get_poison_unmapped(struct cxl_memd=
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
> +		else
> +			offset =3D res->start;
>  		length =3D res->end - offset + 1;

[Severity: High]
Does this code risk an integer underflow if offset is greater than res->end?

If poison_by_decoder() encounters a zero-sized commit_end decoder, it can
set ctx->part =3D -1 and ctx->offset =3D cxled->dpa_res->end + 1. If that
decoder was configured by firmware with a large skip value, ctx->offset can
be strictly greater than the end of the first partition (part[0].res.end).

Later, cxl_get_poison_by_endpoint() forces ctx.part =3D 0 before calling
cxl_get_poison_unmapped():

drivers/cxl/core/region.c:cxl_get_poison_by_endpoint() {
    ...
	if (rc =3D=3D 1) {
		/* ... */
		if (ctx.part < 0)
			ctx.part =3D 0;
		rc =3D cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
					     &ctx);
	}
    ...
}

Because ctx.offset is not reset to part[0].res.start, offset is assigned
the out-of-bounds ctx->offset when i =3D=3D 0. This causes the length
calculation to underflow in unsigned 64-bit arithmetic to an enormous
positive value.

Could this underflow bypass the !length check and result in sending an
invalid mailbox command to the hardware?

A massive out-of-bounds length passed directly to cxl_mem_get_poison() may
cause the CXL device to hang, time out, or process out-of-bounds requests,
leading to system instability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922101129.5279=
4-1-icheng@nvidia.com?part=3D3

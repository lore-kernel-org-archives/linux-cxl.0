Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751C351C2D
	for <linux-cxl@vger.kernel.org>; Thu, 13 Aug 2026 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593341; cv=none; b=qdQHHdYfuiB3/i2DniM0Uj3voO8NKy2CsS08fg4J3kEIn0hAZDSYqSOk/evovlKu5RiJZnYMbVMfW5we/PBiz46qzbgsBoLJV9QN4MDRo59uPa4vNdM0K7V2iVp8cVrdT+udJ1+oD+fiPeBym4LTAbIszcy4F+okGO1KL4IvVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593341; c=relaxed/simple;
	bh=62O3Yed7/wUxHZpqZpMyLCVdHSkmHTSNTkujU2r1hz4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D7mzEZO/4MdmJOimFS0RAXc/GrHqHUOVgaLSQsZwjrikinVAgn7wM03Xybff5uteXr6eLgq3EMbpqOFWZb8RIz2TrzjNmod0RB9zT7rYGVcEtwyTBpzYyC/FANmkN75/RPZds12W2Ym4ABLU6Jvrbb3yPgvh6GPIC5fU7EHdK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxhuO78v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxhuO78v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB361F000E9;
	Thu, 13 Aug 2026 03:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593340;
	bh=M1O0BK1XPOvnQvz3+IuwF6k5r7JoHDJmOsocsZ3DoF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxhuO78vZY9cUmojWwLWEdByTtkIqoLq0Ic8wmsfAYN9wk0GLSVNGwqnLm/DVX056
	 xDUmOR6oDpDnPoWAw8neJ7kZDEoU7vjrkdDXtFjXa5uZbcVqsAbmWsjTN0cUNwcGak
	 pJkIJf9KnOdQ8W0WhEjPjcK2Fpg+LQ581PVWccV3JwySS4NAYiHNp+7G2wKgMsRl0A
	 DQPqiz11HAagv9o0JKZb39X5GIdzlV1vnYHwuTe/1WZKk1S0swGVMr23TusJrPx+bX
	 wwgnXuOQXpgRGR6yZDvJBghmtUb12wqqZvr4Yg7rcxcUSOkbv5ioxtOgsr7sUAZREO
	 MURA53J9/skrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] cxl/region: Start unmapped poison scan at the
 committed decoder boundary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260813034538.13189-5-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
 <20260813034538.13189-5-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 03:55:39 +0000
Message-Id: <20260813035540.4BB361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read and information leak via hardware-supplied pois=
on record count.
--

--- Patch [4]: [PATCH v5 4/7] cxl/region: Start unmapped poison scan at the=
 committed decoder boundary ---
commit 7ebf989f20ca7ca7009f85db447392e5d1e320f2
Author: Richard Cheng <icheng@nvidia.com>
Subject: cxl/region: Start unmapped poison scan at the committed decoder bo=
undary

This commit fixes poison reporting for unmapped DPA ranges by resuming
the scan at the last committed decoder offset instead of skipping it.
It ensures poison in uncommitted decoder allocations is properly scanned
and reported.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -2920,10 +2919,8 @@ static int cxl_get_poison_unmapped(struct cxl_memd=
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

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the subseque=
nt
call to cxl_mem_get_poison(), I noticed a potential out-of-bounds read in
drivers/cxl/core/mbox.c.

Does cxl_mem_get_poison() properly bounds check the hardware-supplied
poison record count?

In drivers/cxl/core/mbox.c:cxl_mem_get_poison(), the loop blindly uses
po->count to iterate:

		for (int i =3D 0; i < le16_to_cpu(po->count); i++)
			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
					 po->flags, po->overflow_ts,
					 CXL_POISON_TRACE_LIST);

If a malicious or buggy CXL device returns a small payload
(e.g., meeting the 32-byte header min_out) but a large po->count
(e.g., 65535), the internal send command will succeed.=20

Will this cause the loop to read past the end of the kvmalloc-backed
buffer and leak kernel memory into the ftrace ring buffer, or
potentially panic if it reaches an unmapped page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813034538.1318=
9-1-icheng@nvidia.com?part=3D4

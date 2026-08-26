Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A6E1F938
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787709464; cv=none; b=hY961MSWu8YDf+xeEkYlWVetg8DLKRo0LFvPaWV/+T0meOAlW7DfA/7Kuir3LxJ9c+p6ry+V9KTIS+0OM/9dbU/qRGXtgxZKZEK/L+XSq4YGd5mzn/vGbpDmGAQ5U4IE90uMX7mOovslDEj3ow1CxX6MogR8ndfRc+ub7VfA4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787709464; c=relaxed/simple;
	bh=xGcg70PTGwJQuo792QkP/sNamwSA8fScVMlVE8cjoaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CqdFIc3e+rY//II34SgTN0Zs74LXqqzKrX1x+YT1BEzxlSg4h6IfmikWp8bNgyhtzF5M/vjvzcPbDud9a73QyxSmGWvKTjv+MakVLrMkbsJcfBXI/qkjWiGW5EH3g8JUAlrr9Lw/t+2Q97b5h4+2oNx76eemWY0IDyPLekJY9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLa+3IxI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLa+3IxI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2B01F000E9;
	Wed, 26 Aug 2026 01:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787709463;
	bh=NLtscY49tOYK3cSZPm3ea9zLeQCXsYcFmGhaFH4Vp1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kLa+3IxI8jN0H5HarzYosOV9zwavH7KG0aY7t8uAsFP/LEWC2aRREvziAR/7mRYeE
	 ziD38FMtkNCItpYGjsd+T2KPe3pos3Qk1Oge8MJQC8AYBGRckplnfqixzzhYDtcM7L
	 GOxgNJvYNuBHPArBn2ykGbKUS0t7597OVu9mqsZvMMPr9tsjNJQo5Eo+rVlRVC92eW
	 l64cLgaTLZm8Bo1p5v8pzrDEWyIV4a2i9iVg6XgtsOCFPxFufJC8Cjmiq9qaQ7kt1n
	 q++i5sCZj+y9oTtRhQeMqCcNhXFApzufMRjdqzCak348iF6om/25jQc07XzTNcG9u7
	 UiginjIvBCSvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/7] cxl/region: Scan all partitions for unmapped
 poison
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260826014508.9989-3-icheng@nvidia.com>
References: <20260826014508.9989-1-icheng@nvidia.com>
 <20260826014508.9989-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 01:57:43 +0000
Message-Id: <20260826015743.6E2B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on hardware-supplied `po->count` in `cxl_mem_=
get_poison` leads to out-of-bounds read of kernel memory.
--

commit f52d52e430dd176144d958a0ce4c3eb954ee8a23
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Scan all partitions for unmapped poison

cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
from ctx->part onward. A fully-mapped partition has no unmapped tail,
it's a normal per-partition state, but the loop treated it with break,
aborting the whole sweep and silently skipping unmapped poison in all
later partition. Use continue so a fully-mapped partition is skipped and
later partitions are still scanned.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c8..b03f30c04d350 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2928,7 +2928,7 @@ static int cxl_get_poison_unmapped(struct cxl_memde=
v *cxlmd,
>  			offset =3D res->start;
>  		length =3D res->end - offset + 1;
>  		if (!length)
> -			break;
> +			continue;
>  		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds read =
in
cxl_mem_get_poison() when it processes the hardware-supplied poison records.

Looking at cxl_mem_get_poison() in drivers/cxl/core/mbox.c, the function
uses an untrusted hardware value po->count in the loop:

	for (int i =3D 0; i < le16_to_cpu(po->count); i++)
		trace_cxl_poison(cxlmd, cxlr, &po->record[i],
				 po->flags, po->overflow_ts,
				 CXL_POISON_TRACE_LIST);

Could a buggy or malicious CXL device return an arbitrarily large po->count
value (for example 0xFFFF) that doesn't fit within the returned payload size
or the dynamically allocated mds->poison.list_out buffer?

If this happens, does this loop read past the end of the allocated memory,
potentially causing a kernel panic or information leak via ftrace?

>  		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
>  			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826014508.9989=
-1-icheng@nvidia.com?part=3D2

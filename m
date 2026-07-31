Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7D31A6806
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481489; cv=none; b=q66lLtwntMZVBQiaCcEnK8+gIQSEInLwD7Lr/zxRemKbmduRuyLjmqouyG9gU91XOC9Tm4t0ZSpqkAUNsomtEVrOAu++DKJfQ29qfj9P4uuv/0AJPV7g09vajHuyOiNxGrXomigeidzZh8EO50WeztfYGvJcCXtg2YNG1ovzm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481489; c=relaxed/simple;
	bh=4xkKEUtuA2MgJ01XWfmDRJcHAMvDaZ/xYuRGbW1fcIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eL3rX3oNloQUdpqXXI/Toeini7/bCMpSjOcvEPWhoxoqnZIFn3AyMR9N6v5T1u021IIfNwuWujQGDE9dX2twmY4PEuYMsIy0VG1AgrTOwhPOo9/SJ7lMKj65HaZkY5r9ZfI7RJWCayIoV3gfGKnb5cn7yHvE+l75awHIEs70WhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfIACrPv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfIACrPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01A81F000E9;
	Fri, 31 Jul 2026 07:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785481487;
	bh=P1aUfCvHiNwMLrV5u2FM51grOlzAEgmj2BV+oSaUz2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfIACrPv9/eD7rAIWIBnQcCisG5Oqz7mTPDuw6Y/Wt5qNT8M+FhsMCrFEDgtGdj5G
	 fihzScgtjwB/f+gSuRUeM26VHze/N9DHOTG24M8TEGHjarKhSSiMfPhABoPeETqehW
	 5tNLRX+Un3r0PvIMaF0Pen1s3ffgs4CK76Www+gaBCh/DjOTgOA1bOaLhz/RiYHtNd
	 U80h5gEE9ROK0zCgcSxeq+YppiYeKw7TwNKsRPpkcLDBdw2WQui3MrYjztroOUKIDZ
	 K68yb4hzELwjaxSL+LlIBa65uGMRffnwZd1ViDGxUIvM78fcj53mgiamqy+/5Ruww3
	 uTvhowJYHe52A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] cxl/region: Simplify poison_by_decoder() error
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260731064902.34127-2-icheng@nvidia.com>
References: <20260731064902.34127-1-icheng@nvidia.com>
 <20260731064902.34127-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 07:04:46 +0000
Message-Id: <20260731070446.E01A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Array out-of-bounds read when `cxled->part` is -1.
- [High] Silent error masking in `cxl_get_poison_by_memdev` overwrites earl=
ier failures.
--

--- Patch [1]: [PATCH v8 1/3] cxl/region: Simplify poison_by_decoder() erro=
r handling ---
commit 091367d84a5db5147f3a65c244b70983d67217ac
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Simplify poison_by_decoder() error handling

"rc" carries both an error code and the loop control signal for
device_for_each_child(), so returning it bare is misleading, the early
guards mean "keep walking", not "no error". Zeroing "rc" to forgive an
-EFAULT on a RAM partition adds to that by discarding what the device
actually returned.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b64..fabaad3469b1b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2950,14 +2950,14 @@ static int poison_by_decoder(struct device *dev, =
void *arg)
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_memdev *cxlmd;
>  	u64 offset, length;
> -	int rc =3D 0;
> +	int rc;
> =20
>  	if (!is_endpoint_decoder(dev))
> -		return rc;
> +		return 0;
> =20
>  	cxled =3D to_cxl_endpoint_decoder(dev);
>  	if (!cxled->dpa_res)
> -		return rc;
> +		return 0;
> =20
>  	cxlmd =3D cxled_to_memdev(cxled);
>  	cxlds =3D cxlmd->cxlds;

[Severity: High]
This isn't a bug introduced by this patch, but does the array access in
poison_by_decoder() risk an out-of-bounds read if cxled->part is -1?

If firmware provides misconfigured ACPI tables or CXL DPA resources,
cxl_dpa_alloc() might leave cxled->part as -1. A subsequent userspace read
of the trigger_poison_list sysfs attribute calls
cxl_get_poison_by_endpoint() which iterates over endpoint decoders and
evaluates:

drivers/cxl/core/region.c:poison_by_decoder() {
    ...
    cxlmd =3D cxled_to_memdev(cxled);
    cxlds =3D cxlmd->cxlds;
    mode =3D cxlds->part[cxled->part].mode;
    ...
}

Would this result in an invalid memory access of cxlds->part[-1]?


[Severity: High]
This is also a pre-existing issue, but does cxl_get_poison_by_memdev()
silently overwrite errors from earlier partitions?

Looking at cxl_get_poison_by_memdev() in drivers/cxl/core/memdev.c:

drivers/cxl/core/memdev.c:cxl_get_poison_by_memdev() {
    ...
    for (int i =3D 0; i < cxlds->nr_partitions; i++) {
        ...
        rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
        if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RA=
M)
            rc =3D 0;
    }
    return rc;
}

If a device fails to retrieve poison for the first partition (e.g. PMEM,
returning -ENXIO) but succeeds on a subsequent partition (e.g. RAM, returni=
ng
0), rc is overwritten to 0.

Does this permanently mask failures of earlier partitions, potentially leav=
ing
poisoned memory undetected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731064902.3412=
7-1-icheng@nvidia.com?part=3D1

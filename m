Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46E9463
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377684; cv=none; b=ryA+5VZtlHRWd1wMLu9ga73RXa4zVZTgIKr1U7NOecky4uxuwiUMjiU0mffeHwn39WTXdq5G17i9r03KsCRLUucaaxHQ3ZNjNlnlsUnMZ26sSQqqc4hkj9LO6Flcd8pW8ZUkuuy3CHf11J9gb48EEbw2ao8rCINaxmpcoVx/wx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377684; c=relaxed/simple;
	bh=VPV22CEVcnSrd0wkGwSLByg0t/mNKc6t/OTyAbSkz5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ickt6atd/FpcC5HkNd73kWVs7lUl7/hHKBhAZ+uw4x1VS7wx4NGyLAPtghcotBK2GqrULsfix7h141xbhE+67asQonNwOC3NokiIz4xZhCVF7tbv3g/4Ij1qqH0msmc6nwiLK/9EzrCFqwJbh8W906eo6YpUrEfT6M+UMtBqLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXEBaMF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXEBaMF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA43B1F00898;
	Mon, 14 Sep 2026 09:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377683;
	bh=SG2OgFyCKd3BPSFJ5jG4wF4GUI8VMKWuJAyrU+B88Cs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gXEBaMF/M2bQ7zYNOP44RvrMh9a+zqpr4mjaVB9cx8fyz09cDpXtQ21UiVob2IBUp
	 /hJEKIkpTLuj71U8hpfNBQxecSHk4DcAt82pB6GMTA5Ys38Y+ts1r8OwSaHpYQQCrA
	 4n1HgftTH4twveXUDTZZV+NV8uCw2ZS+itquGLSCJtuARXDuJsbWyaCA8ID6IOM1Er
	 S8RJWgUhSonio5xHhvk0pK2Vb14nuwcfvih9TNDseOlz+HvuQqi8T980q/Br9Zb99H
	 9BV2aTDgIU3ZNNFodJ2ITGa3NIxGcDG7l8x6yAHSx7biCKxmz1AcDtVrRtGBrBUZp2
	 YIHa/26FT11ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/3] cxl/region: Simplify poison_by_decoder() error
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260914090858.19181-2-icheng@nvidia.com>
References: <20260914090858.19181-1-icheng@nvidia.com>
 <20260914090858.19181-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:21:22 +0000
Message-Id: <20260914092122.EA43B1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cxl_get_poison_unmapped() incorrectly leaks the -EFAULT error code=
 to the caller when a poison error on a RAM partition is forgiven.
- [High] cxl_get_poison_by_memdev() silently overwrites genuine errors from=
 cxl_mem_get_poison() due to a missing break statement.
--

commit 193a595f41828e1db31b1a7dfaf170f728e1bcfe
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Simplify poison_by_decoder() error handling

This patch simplifies error handling for device walks by directly returning=
 0
where the walk should continue, instead of reusing the rc variable. It also
adds poison_efault_forgiven() to standardize how -EFAULT is tolerated for R=
AM
partitions.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 75b8092e6dc2f..a12984fad429b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> @@ -2931,7 +2941,7 @@ static int cxl_get_poison_unmapped(struct cxl_memde=
v *cxlmd,
>  		if (!length)
>  			break;
>  		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
> +		if (poison_efault_forgiven(rc, cxlds->part[i].mode))
>  			continue;
>  		if (rc)
>  			break;

[Severity: High]
This isn't a bug introduced by this patch, but if poison_efault_forgiven()
evaluates to true in cxl_get_poison_unmapped(), the loop continues and
bypasses resetting rc to 0.

If this happens on the final loop iteration (or if a subsequent iteration
hits the !length break condition), doesn't the function return the
unmodified -EFAULT to the caller?

This could cause the sysfs trigger_poison_list_store operation to fail
when retrieving the poison list for a RAM partition.

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed another problem in
drivers/cxl/core/memdev.c that was missed when refactoring this error
forgiveness logic across the subsystem.

In drivers/cxl/core/memdev.c:cxl_get_poison_by_memdev():

	for (int i =3D 0; i < cxlds->nr_partitions; i++) {
		...
		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
		/*
		 * Invalid Physical Address is not an error for
		 * volatile addresses. Device support is optional.
		 */
		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
			rc =3D 0;
	}
	return rc;

If cxl_mem_get_poison() returns a genuine error (like -EIO) on any
partition other than the last, the loop fails to check for this error
and proceeds. The next successful call overwrites rc with 0.

Does this silently overwrite genuine errors from cxl_mem_get_poison(),
reporting false success to the user when polling for hardware errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914090858.1918=
1-1-icheng@nvidia.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C912E2749DC
	for <linux-cxl@vger.kernel.org>; Thu, 13 Aug 2026 03:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593514; cv=none; b=GJ3yOl8KdNIbxjI1REsYygdFkcwA3AhGhiV7Cie3DlC8IF7wGkhQ76kCxTNJufZJ6GJuBeiq7F6YJVfh8UZ8LNXOEos4k9UUzmivQjnwVvQvtAbIpm8gtowUgIAgvTTyO4SP+XNZUAqqbLgFRYs519DmhgldBf4DbgFJgs81Cgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593514; c=relaxed/simple;
	bh=X/oB4e2z48vIXc+l68eac0W5fdeluoOQPRtT9saBoTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uowV6UxS9cRBSAriQFvvpLSCTR9+ZJ1zaJLu7tIQhkKW3SiK32XwxjJQ2NMQtTAmQqw3DUQlZFQlfkFzV2JVmqUOVv4BxmRQ10QXo3UHEcY2TRpJCKwsEaj3YKSP6gP3MA9aQ57fA7bsHFivQliLRswLAFogl5D/20uqWj3WfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzZOtiCA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzZOtiCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BC81F000E9;
	Thu, 13 Aug 2026 03:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593513;
	bh=FTlfB/htbTMcRokdBo7kXEcBa53Cc1BmebEN326DSoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nzZOtiCAmIolQySZzBdr86RJ6svL5AmLoMV7gOf9i/a1BVD6hYWBtmwkSB3L2tTPI
	 15jdwsQyGvTn0BiW/VBpCp99YM9KcIjlhgL/P4bT8Q6CCq8vXSMutGtzKQdsqqMvId
	 EEn1fIWJDPclKXy7gDr7hDSo9+0E7FUAV8Z61e8SQGB1P/Ipp92NDovJHD5Eg+v5G4
	 7J3dWG6sm0WV/r5ZgOuqgnIdkGVJrkUsekk79Wc3cTluY7Swqp+VbGsxqjn2f/RW3l
	 G0/3X9i+6JkMlu4RZZyYK44KnNZ6cR14OSmGGnK/jDFiuhYKOTSDBGXVJBCGSjNo/R
	 yViX/j9n4rl8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] cxl/region: Don't leak tolerated RAM -EFAULT
 from unmapped poison scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260813034538.13189-4-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
 <20260813034538.13189-4-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 03:58:32 +0000
Message-Id: <20260813035833.41BC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the `cxl_get_poi=
son_by_memdev()` function silently masks hardware errors from early partiti=
ons due to a missing error check.
--

--- Patch [3]: [PATCH v5 3/7] cxl/region: Don't leak tolerated RAM -EFAULT =
from unmapped poison scan ---
commit 4c4b3832747d23fff6bcb4486dc7105f329afd3d
Author: Richard Cheng <icheng@nvidia.com>
Subject: cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison =
scan

This commit fixes an issue where a tolerated error from a RAM partition
causes the unmapped poison scan to fail. It correctly resets the return
code to 0 when ignoring the fault, matching the behavior of
poison_by_decoder().

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b03f30c04d350..ddf12075b95c0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2930,8 +2930,10 @@ static int cxl_get_poison_unmapped(struct cxl_memd=
ev *cxlmd,
>  		if (!length)
>  			continue;
>  		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
> +		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM) {
> +			rc =3D 0;
>  			continue;
> +		}
>  		if (rc)
>  			break;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this error
handling, I noticed a potential issue with similar logic in
cxl_get_poison_by_memdev() in drivers/cxl/core/memdev.c.

Does the loop in cxl_get_poison_by_memdev() mask hardware errors from
early partitions due to a missing error check?

drivers/cxl/core/memdev.c:cxl_get_poison_by_memdev() {
        ...
        for (int i =3D 0; i < cxlds->nr_partitions; i++) {
                ...
                rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
                /*
                 * Invalid Physical Address is not an error for
                 * volatile addresses. Device support is optional.
                 */
                if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PAR=
TMODE_RAM)
                        rc =3D 0;
        }
        return rc;
}

If cxl_mem_get_poison() returns an error on an early partition, the loop
continues without breaking. Could a success on a subsequent partition then
overwrite rc with 0, masking the retrieval failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813034538.1318=
9-1-icheng@nvidia.com?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C4C3DAAD1
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910155; cv=none; b=DSRRBy0abrZ/AortQz74eXfOD0GDeB8uf7GwbVw5ni6JDCoM/s95NMgIHS4DX+pt1rDQarlaFQP7j92KzQ3mNDCAjnpXr/atZYrP/VEBUdMDSGd5FoJKBYO05kjqLedBdGtkjcylFp9ohsyq5ldSBLqUIUxGAF9IGTcG4QygsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910155; c=relaxed/simple;
	bh=ZQ6RoqZ8mQd8pOPumqVjz9ODtBs/KqD/zYRWwR3XtIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=be9ncn9JNVhuDFFnBH4JJzfFIdhClQk9pbsGg5n+kkKxVtxmWwnQbOoeN/kfQbHnHAbkcQKKHTxEaYXTC/bvy86hon8WV+pjPzapaAWFV3urOtsaQAx20acVGxcWrzPsE0ZL69k/JB9Pr/lnAyhz39iHmHRkyc1u3BcfHXdHPgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmYPx8I2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmYPx8I2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3934B1F00A3A;
	Wed,  5 Aug 2026 06:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910151;
	bh=Ai18G8LS1Pa9FgxGMtIXmbctz10rD+3ZEn9p9J8KZVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mmYPx8I2H4LQiUBDBa26AZ7DuBSvuSp5exj5K4ikdHXfyvRBEbRwqplYteCOQzlBU
	 KdJx9Qih0E5zXxkBZfhedEfbTaBDJbXyPo3AI2rlQqWA4NyQc+ElRtW/6UqJ1ew9O/
	 EMCtBEssA0iOH6DP1ZV2dG557BEVN4fkQBEPHqcmvPu46CM5GFrUOhxzSt05vuuLu6
	 TDpzV7IZ+d2K8VkgWPD8aA1BNombt3QnYmgaGPRqtHAhf0KSswMywriqGi0/6ezvSe
	 Tph7hk+aw7ZE2HQz+kjF6KYZlIqMBHO06/HMG8R43oWOOs7u/t4PPxWi2CLOiqjArs
	 4QkskHIZvo0/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] cxl/region: Simplify poison_by_decoder() error
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260805055524.22311-2-icheng@nvidia.com>
References: <20260805055524.22311-1-icheng@nvidia.com>
 <20260805055524.22311-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:09:10 +0000
Message-Id: <20260805060911.3934B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The `poison_efault_forgiven()` helper is restricted to `region.c`, =
leaving identical open-coded logic in `memdev.c`.

Pre-existing issues:
- [High] Unchecked array index `cxled->part` can be `-1`, leading to an out=
-of-bounds access on `cxlds->part`.
--

--- Patch [1]: [PATCH v9 1/3] cxl/region: Simplify poison_by_decoder() erro=
r handling ---
commit b12d8e90580fa9f2baf0c0dcbd4c6c514e0b2343
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Simplify poison_by_decoder() error handling

This patch simplifies error handling in cxl_get_poison_unmapped() and
poison_by_decoder() by testing the -EFAULT condition directly and returning
a literal 0 to continue the walk. It introduces poison_efault_forgiven()
to consolidate this logic.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b64..45536909cc17d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2905,6 +2905,16 @@ struct cxl_poison_context {
>  	u64 offset;
>  };
> =20
> +/*
> + * A device may answer a Get Poison List request with "physical address
> + * specified is invalid" (-EFAULT). That answer is tolerated for a RAM
> + * partition and the poison walk continues.
> + */
> +static inline bool poison_efault_forgiven(int rc, enum cxl_partition_mod=
e mode)
> +{
> +	return rc =3D=3D -EFAULT && mode =3D=3D CXL_PARTMODE_RAM;
> +}

[Severity: Low]
Since this helper is defined locally here in region.c, could it be moved to=
 a
shared internal header like drivers/cxl/cxlmem.h?

There is identical open-coded logic in cxl_get_poison_by_memdev() within=20
memdev.c that could leverage this new helper instead of leaving it open-cod=
ed.

[ ... ]

> @@ -2950,14 +2960,14 @@ static int poison_by_decoder(struct device *dev, =
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
This is a pre-existing issue, but does this code risk an out-of-bounds array
access?

Right after these lines, the code evaluates mode =3D cxlds->part[cxled->par=
t].mode.

If cxl_dpa_alloc() allocates DPA capacity but cannot strictly map it to a
partition, it can leave cxled->part initialized to -1.

When sysfs invokes poison_by_decoder(), this evaluates cxlds->part[-1].mode
before ensuring cxled->part >=3D 0. This performs an out-of-bounds read into
memory preceding the array (such as the dpa_res struct) and could silently
corrupt the poison evaluation logic or trigger memory safety warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805055524.2231=
1-1-icheng@nvidia.com?part=3D1

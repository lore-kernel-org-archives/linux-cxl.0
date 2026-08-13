Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF22749DC
	for <linux-cxl@vger.kernel.org>; Thu, 13 Aug 2026 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593402; cv=none; b=SpVKfdkbdma2Kgx1okdL+6NK90XVFPeEDWTgnc9/677DXRoNLihLDpHYwFaZzZvYnM5h4CDw2U3vi1n1Z7DLp3iGANydNSfPddpruBYE2NThUHhtjShLVYaZzYVwEbUpYuSNPHsuO8ATUQb84gEe37Yzx/HnndIy+47NwQErPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593402; c=relaxed/simple;
	bh=nomXILN3zpaN65RRDdvwec3lyNwfKlYm/ysJM5K5AGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OyDk1cXyn6HaQFeoFOCZ6qFuRLeHfMSf/w7urcrLAcyfSdSu5p+/Q//Ql2hhetKi/MdVKTbmqukQnF97AZ/ULShblCfnSgZZwH70g3uKnr4T1d5WacmlUrGsww3CyG5d2dLtdxPqBKD/SsQw5mlOcAstyvppYobML4J1qNrCv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g67i00zs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g67i00zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C1F1F000E9;
	Thu, 13 Aug 2026 03:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593401;
	bh=7hFUPTV2cbwpWeMhBpyFEJjqYGVJX/9juFz4Y/oHQ38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g67i00zsIkbs2KhjZAGzAU/UWyLRkOElwO9ILclse9+Qd1pFlBb9sKrp2gt8IutkO
	 Sb1iPhiyCs3kaEPYcVFGg93dPpQd10evukkEOf1ckPLzmqQnD1nNaRVjKfxtPbKRq1
	 iDQRCf+whcngvnkofTuAl9WHv0WIf9C8sEEzcLBCILAydSFLeKuyRogDSK/MV3uuRT
	 ocvtSZfXFMLgOAYQ9KyecbbSZZ2z2L3BW2tLO7daPCoAxwWxPQoD4bQRunX5a99JZW
	 z6F+OtRT3Sf7zzppztBjKoZ/1auD52yEA2bQQwEbtQhZpLOtVuhDSIlFTJV64i/xV3
	 HuEz0PAfy/qLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] cxl/region: Reject poison scan for decoder
 without a partition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260813034538.13189-7-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
 <20260813034538.13189-7-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 03:56:40 +0000
Message-Id: <20260813035641.10C1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Returning -ENODEV from poison_by_decoder() for unmapped decoders=
 aborts the entire endpoint's poison list collection.
--

--- Patch [6]: [PATCH v5 6/7] cxl/region: Reject poison scan for decoder wi=
thout a partition ---
commit 8d92957ad7710c4351ca4406f4bb3f3474e28442
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Reject poison scan for decoder without a partition

This commit aims to prevent an out-of-bounds array read in
poison_by_decoder() by returning early when a decoder has no assigned
partition. It checks if the partition is negative and returns -ENODEV
before indexing the partition array.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b7dc5d4988da7..afe3fb57b7fe2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2954,6 +2954,8 @@ static int poison_by_decoder(struct device *dev, vo=
id *arg)
>  	cxled =3D to_cxl_endpoint_decoder(dev);
>  	if (!cxled->dpa_res)
>  		return rc;
> +	if (cxled->part < 0)
> +		return -ENODEV;

[Severity: Medium]
Will returning -ENODEV here abort the iteration for the entire endpoint?

Since poison_by_decoder() is used as a callback, returning a non-zero error
code causes device_for_each_child() to stop iterating immediately. This wou=
ld
completely prevent the retrieval of poison data for all other valid, mapped
decoders on the same device.

Would it be better to return 0 instead, which would safely skip the unmapped
decoder but allow the poison scan to continue for the remaining decoders?

> =20
>  	cxlmd =3D cxled_to_memdev(cxled);
>  	cxlds =3D cxlmd->cxlds;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813034538.1318=
9-1-icheng@nvidia.com?part=3D6

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE2351C2D
	for <linux-cxl@vger.kernel.org>; Thu, 13 Aug 2026 03:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593423; cv=none; b=Hea0zs11osbZPs4EIY6wFdE42AkAA+2Y1lkditgLOlMGR5T5LtzlON6UeujSBy/XNhMaGRKxytgj5jaDpJUJWU/RS+SSH6mmrphOI+gcoA8wdw1sW1cHlmo4tSpmejtcP3hlGMnfs4DenmJrons8LiYSaQ85n0SvBdtnRZgfaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593423; c=relaxed/simple;
	bh=z5ml4xKA+6sG5LAhKtr3a39R35GyuMZp1YdCbEsXHBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jg0gloXZ1E2+e6nsWRvq0HTNL8DmMQPJaP32HuTGAIviNPZr0TH9fgos2hrqnafMoLenysCZP3yxlN5Ot9w2UMCNB6+EQO7frioS09GH9eVUV7afrrRZW9eBV8Fm+oo4iff66EebwhrhNpTkiuGNdYplS0bXVmPgQcdwcH3igs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk0g74tM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk0g74tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B628E1F000E9;
	Thu, 13 Aug 2026 03:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593421;
	bh=suw643gxUDxamm0drnLwtZKs4cAaM+/ZThnKNYpYUms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nk0g74tMz9UF4F1RUY92N9uOZEMabOj2zRrbdUpQ2NN48BFyNOHVtbdalFS3o2PV2
	 7UlHJrf7suXheKColqMre14yefGIFi8Rn4ghKgpcrLWJi5SE7p7ONtenX4MFMp6e6c
	 3LJFii51but6QBE7xmBiwNjWx3cCYG+3dLQMaSLVE+o9p4UkO4QbEHgTjxUWFf/GDK
	 A/6Ih44Z+cOSmjnWkDwhvsbIO8j5Q1uFhDquconHy+p6WIB3bVseiE4d7sx4540wm8
	 JIE7qgc3DZfUIa2vDPjp5WS2ldwMU+Uk7XklqR5NieEcSfC7ZdR4QwvyWEb5ph9hU5
	 ps6K1nYuqS4UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/7] cxl/features: Reject feature offset that
 overflows 16-bit field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260813034538.13189-2-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
 <20260813034538.13189-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 03:57:01 +0000
Message-Id: <20260813035701.B628E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The bounds check designed to prevent 16-bit offset wrap-around i=
s off by one, making the final byte of the feature space inaccessible.
--

--- Patch [1]: [PATCH v5 1/7] cxl/features: Reject feature offset that over=
flows 16-bit field ---
commit 48e82cdf4087a2ffbeb7023fda65d3ff4f9b9c6f
Author: Richard Cheng <icheng@nvidia.com>

cxl/features: Reject feature offset that overflows 16-bit field

This commit adds bounds checking to prevent 16-bit offset wrap-around in CXL
feature commands. It also changes cxl_get_feature() to return ssize_t to
properly report errors instead of conflating them with a zero-byte result.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index ba6d2a5acb74a..8d44ce8294978 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
[ ... ]
> @@ -235,7 +235,10 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox,=
 const uuid_t *feat_uuid,
>  		*return_code =3D CXL_MBOX_CMD_RC_INPUT;
> =20
>  	if (!feat_out || !feat_out_size)
> -		return 0;
> +		return -EINVAL;
> +
> +	if (feat_out_size > U16_MAX - offset)
> +		return -EINVAL;

[Severity: Medium]
Does this check contain an off-by-one error that rejects valid accesses to =
the
last byte of the feature space?

If a request targets the final byte of the 64KB feature space with
offset =3D 65535 and feat_out_size =3D 1, this evaluates to 1 > 65535 - 655=
35
(1 > 0), which is true, incorrectly rejecting the single-byte transfer.

> =20
>  	uuid_copy(&pi.uuid, feat_uuid);
>  	pi.selection =3D selection;
[ ... ]
> @@ -288,6 +291,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	if (return_code)
>  		*return_code =3D CXL_MBOX_CMD_RC_INPUT;
> =20
> +	if (feat_data_size > U16_MAX - offset)
> +		return -EINVAL;
> +

[Severity: Medium]
Does this bounds check in cxl_set_feature() have the same off-by-one issue
restricting access to the last byte of the feature space?

>  	struct cxl_mbox_set_feat_in *pi __free(kfree) =3D
>  			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
>  	if (!pi)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813034538.1318=
9-1-icheng@nvidia.com?part=3D1

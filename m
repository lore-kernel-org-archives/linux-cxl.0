Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC463BE645
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781889885; cv=none; b=XDVU39kg5vfl1guwSVPWhUs6L16IHUZHP7Th0T7tfkZXN+2u/sVnJb/JJtu0518Xp5op3LWQjAZGyhhI1wl1fcGifMi+J2bkR34V+Vp5M6Dgd/FcC2cptxRWANFL1M06wjYW+4r+ilWLtiMZ4r+RxTB2XWygvQlc/YIO284gXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781889885; c=relaxed/simple;
	bh=zZozOkYH9sDroy8pPwTvVlIcEGpUHtK8Lz85vzqFGIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G9xp9GqPPL9u5cCc1MXPu+aKr6eOfyLDKgC+TEMMh2CER10awG/829vmut/vhkXg6JjCBCb5GjTHkCUjk4rnvoKHzBgzT7bS4xUarT6AyOvDF7dmzE4d0jENGeCPnPVz7UGVjD3v8xjfMLpKO+ZaKkYG6k4DgNbQbL3ynnGQqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+9d/RoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+9d/RoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ABB1F00A3D;
	Fri, 19 Jun 2026 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781889884;
	bh=QD6cEwvSuXfJmaBKw84xovOD5TstYBMz9QvTeMxM0Z4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S+9d/RoD6JuS8EP3A6VkNDyq8CbLjwkM213aZA2OJNtnKNx1MqFTIekElT/QXOSew
	 yqWlS18Ub/KdlJODPvHp92yPlzLRuVfvP/UicR5lkxL+LstFgkQnyBvaVYFAbiYBUz
	 irwOlu0eV0GMJsobPeTCy2GWb2AEiMdoYRbIrJnu3WF2ngsD0MbwO7f1TGipqwES9e
	 CGOwasPkdkjeUAXQHqgbJFvLpL7FNLtqpkGVAP/RjfEs7TNEZSHxj9HTg/JWwXA0LF
	 bPEyTxYToNe0BrQRXPsh9/KezXDX92nqa61JkkIOroDKj2EesP/qJCoOespm8agWX0
	 8XqEDn9Pvn2ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v28 3/5] cxl/sfc: Initialize dpa without a mailbox
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260618181806.118745-4-alejandro.lucero-palau@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:24:44 +0000
Message-Id: <20260619172444.75ABB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Malformed kernel-doc comment with a literal '+' character due to a =
diff artifact.
--

commit e64a1b07e5313555ece5e23f49237b31b36182be
Author: Alejandro Lucero <alucerop@amd.com>

cxl/sfc: Initialize dpa without a mailbox

This commit allows a Type2 driver to initialize DPA by giving the size of i=
ts
volatile hardware partition, avoiding reliance on a mailbox identify comman=
d.
It moves related functions to memdev and adds the sfc driver as a client.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 33a3d2e7b13af..500f077f935df 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c

[ ... ]

> @@ -594,6 +594,73 @@ bool is_cxl_memdev(const struct device *dev)

[ ... ]

> +/**
> + * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> + *
> ++ * @cxlds: pointer to cxl_dev_state

[Severity: Low]
This isn't a bug, but it looks like a literal + character was accidentally
included in the kernel-doc block. Was this an artifact left over from a
rebase resolution?

> + * @capacity: device volatile memory size
> + */
> +int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
> +{
> +	struct cxl_dpa_info range_info =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618181806.1187=
45-1-alejandro.lucero-palau@amd.com?part=3D3

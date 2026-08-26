Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5AE274FD0
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787709480; cv=none; b=T0Wu1+NugeFgJyd6gjZpUyzOmoFZcEBr7EsOQCetC2m3Wrluwy8ne9TiL2WCGdQt7x6u3wYXn/7nJBlscC5KoSzXGmj8DxGCr5cN1LVQOd3csdMLxOOQDRlvSQrSPWlmuhXB3P4Nlj0lyjgRXxq2FgWBx4IfPLJX2ilVbzFSaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787709480; c=relaxed/simple;
	bh=d5sDcItyFSch99cSoxIcF+fG/udUhxLnWyxknpa6bgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TUIinePX2AUKMVIalLWWwis0CjCZePRZlo59kd/j4z2zgBoakdIPi9iWjAYE2iaNVDSHrllEx+EkhcCYXWjs5BeBb4M4w+MrNP2FpXLlXM2lNiZVKlzrwWWJnnv8vbv3bFlyZvQe41szrerGTFdAi8g+WfhuXhj17yxsq0cSNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdAzpenR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdAzpenR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD971F000E9;
	Wed, 26 Aug 2026 01:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787709479;
	bh=KGumFdJZ9CoQQpP6u+z9v08+tYPCnZk4JBVlxnAmU3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gdAzpenRUBH9R7xQHKDx7s470RK0Bx6MR0zhD+56s9My3tAMlzzjB6kb5GbPJwzWV
	 lq1XVJ98OhvY6VvSaJ/n1GSGxQFrLpDwTgF3fc3BgKJbvZpVCDQnnaE/oNSNq2mQZg
	 OhFV7ys4TKlgmSGACR94h7ULSfgE26JEs4Hkv0PWgvUyWxIrmyxIi+Dpa7YpVdysI2
	 XtHWWpzrYMymtCzG/+yCyf/cw2AYoGer/KG3roKwrTvb78tr8NFcMhnVny+sosqFWn
	 GzdpPgE3/NkLpz0RFePAIIvzok/0X7t19gwN6bCC/nR+TK9vsHRWJ1a13Y/pdaF6qM
	 x+xAsj28h3qbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/7] cxl/region: Reject poison scan for decoder
 without a partition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260826014508.9989-7-icheng@nvidia.com>
References: <20260826014508.9989-1-icheng@nvidia.com>
 <20260826014508.9989-7-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 01:57:58 +0000
Message-Id: <20260826015759.2AD971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Premature iteration abort in poison collection when a decoder la=
cks a partition.
--

commit 414c0bfc48b7f7d14076be9625353a3a1ecb8ff9
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Reject poison scan for decoder without a partition

This commit returns -ENODEV when attempting to scan for poison on a
decoder without a valid partition. This prevents an out-of-bounds read
of the partition array during poison collection.

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
When poison_by_decoder() returns a non-zero error code like -ENODEV,
doesn't it cause the caller's iteration to abort entirely?

Looking at cxl_get_poison_by_endpoint() which iterates over the decoders:

int cxl_get_poison_by_endpoint(struct cxl_port *port)
{
	...
	rc =3D device_for_each_child(&port->dev, &ctx, poison_by_decoder);
	if (rc < 0)
		return rc;
	...
}

If a decoder lacks a partition and returns -ENODEV, this aborts the
device_for_each_child() loop. Should this return 0 instead of -ENODEV to
allow poison collection to continue for other valid decoders on the device?

> =20
>  	cxlmd =3D cxled_to_memdev(cxled);
>  	cxlds =3D cxlmd->cxlds;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826014508.9989=
-1-icheng@nvidia.com?part=3D6

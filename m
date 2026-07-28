Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55842EC57C
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280670; cv=none; b=hTvbvEShHCDQE19ckzxcYJpBYZGmRvkNtnMEtOYqOeG9P1kNRaeNWA0WYe2ymJE6ZrhxcAICQ2bwCtPFGhr3CUNFQog45lWrLgqGl5wXE/8KeNGgaE3HKcYvtk/7h7HQ5BYpsqamvWrDhW4aMecycHGS7df0fX/RIPTgBAjRjnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280670; c=relaxed/simple;
	bh=ZyEspEgnK7NmGi0gmv7rQ2CzgVtj/2Zj6cKq36Rd5mA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VnGg9QEtwDAOxfafqk1WRKhg3j2PYv2aukiG00j7DxnHOa+WVtMR34uPzNLwYIszsJl/+Kp5/fLFcSEfZAc5SIZN5aWW5fGdOvrs0JTZ3u/i5f9hceBK2z5ZLDIvo0POiQPiEIgJF/TgTc9QnopET36aerigsNXA5RZsRWD0osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw/u2FHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw/u2FHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7E51F000E9;
	Tue, 28 Jul 2026 23:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785280669;
	bh=7RW/lsdmHAZSgUrZc28UUIj0YKsAm8aJT3/t0CdpCG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gw/u2FHQIWJtsCZ3AQk9qtx3rAnyORLauLUxPhAFEe9hbRh7dq1lpwTwISjYsVgBE
	 emIH14MQ4XE+JzdpmBhutbZr8h65of47nIuqcnfkXjfYqb0r/yBtzWJAwKCHOhFHBX
	 AAWfVOjWJ6/+aZBrf9UvOh4rfROoZPGAlSmlyTCcph8M8aIX4dlbEjLfyM+7SdUDkT
	 luXRvEMN5PoPAiVOWjqHdSPwGVKr6P4Cf1BjDJ/X5w/8+XKJ8+6SroHxZXnHGY1kch
	 4dEJ5zbrqGdLfGWkGVVxIw3+3e2MDX+Igw9/JO+zyFdEbfZt/b94RODnOcTQ+MZmL7
	 zAEk7Opq1faRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/hdm: Robustify decoder target list reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260728230228.781303-1-dave@stgolabs.net>
References: <20260728230228.781303-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 23:17:48 +0000
Message-Id: <20260728231749.3B7E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Strict bounds check on interleave_ways causes fatal port enumerati=
on failure for uncommitted decoders.

Pre-existing issues:
- [High] Endianness bug via union type punning corrupts decoder target maps=
 on big-endian architectures.
--

--- Patch [1]: [PATCH] cxl/hdm: Robustify decoder target list reads ---
commit a440172bd3f3303bac0379eb1712a8d4f611d2ab
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl/hdm: Robustify decoder target list reads

This commit adds a bounds check on the interleave_ways value to prevent KAS=
AN
stack-out-of-bounds reads when iterating over the target_list union.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..87bdadeccb5fe 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1084,6 +1084,13 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,
>  		cxld->interleave_ways, cxld->interleave_granularity);
> =20
>  	if (!cxled) {
> +		if (cxld->interleave_ways > ARRAY_SIZE(target_list.target_id)) {
> +			dev_warn(&port->dev,
> +				 "decoder%d.%d: Invalid target list (iw: %d)\n",
> +				 port->id, cxld->id, cxld->interleave_ways);
> +			return -EINVAL;

[Severity: High]
Does this strict bounds check cause a regression where port enumeration fai=
ls
for uncommitted decoders?

If any uncommitted decoder is left by BIOS or powers on with an interleave_=
ways
value greater than 8, this returns -EINVAL. Because this is called in a loop
within devm_cxl_enumerate_decoders(), this error aborts the setup of the en=
tire
switch port and prevents userspace from ever configuring the device.

Could uncommitted decoders be gracefully ignored or clamped instead of caus=
ing a
probe failure?

> +		}
> +
>  		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value =3D (hi << 32) + lo;

[Severity: High]
This isn't a bug introduced by this patch, but does this union type punning
corrupt the decoder target maps on big-endian architectures?

The target IDs are read from a native 64-bit integer (target_list.value) and
then accessed as a byte array in the following loop:

		for (i =3D 0; i < cxld->interleave_ways; i++)
			cxld->target_map[i] =3D target_list.target_id[i];

On little-endian architectures this matches the byte order, but on big-endi=
an
architectures, the most significant byte is at index 0, causing the targets=
 to
be parsed in reverse.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728230228.7813=
03-1-dave@stgolabs.net?part=3D1

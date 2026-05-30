Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6227874F
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780117611; cv=none; b=kGfYy3mCJsHFyKquR/YNMSlHIjqqpMiz8OHycD8dviWmXxXX2JNIjVZup9JVVNlCksQGblsfwaTEeOFKs9VmmLHlQKBEv56AYbc3K0shh6YowJ3k4nB2NP0akQGeVFx50DeF+fMI7FStC/1O7oD7jg7VhBU6nDU2mheppUwJbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780117611; c=relaxed/simple;
	bh=AcfzCNI/gkJUdDY268NTsfDuCGVG03qLFwgi/naoIyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=du+Fi7Sktorn9DnxEK3jmvLYjDhxqhi+kK132vnny/xeifG2oNBUx5i0OxnvluQr0eO1Lbr+UUuno8037sMs6gmYM3Mqkd9xBbe16N8bhdBtNixH84DbyDnaxa79HpgZjQaqGl4KmQ6j4rF8UbIewyan4lfeo8yhxxtmJAFY2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEf7KIhN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEf7KIhN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFCD1F00893;
	Sat, 30 May 2026 05:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780117610;
	bh=CggDyxca9J60prNoGA0jm0e0fgt1qsIK93ycznIUSb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gEf7KIhNrKUzeBkuMWady1FiHAGaOHIjxFFNXkE5+4/W9tBRxZhK3SRSUBJFAGJqJ
	 mYfVwoI6whp/pdbwUbgzZpsyEpqS5HGCFfiSDg1WNTzl7OWTzcKhlbEpiNYlILftdc
	 1FjvdfoA64MiUkmZ8/0fLUlk6+LQBGh6k3OFc9X9cmplBL1SdZYHK7FybuiKiVjZgM
	 2JGUJSDYXcchmaV87SOiPsHw0MKNdQN+B2HS+UrnjfL3YzQqfOKEhUVZi8K+TiT6kK
	 wNyVoFEgqHGjXkvpa8ctFgVDykW3oD9fV+fGtE/ZRnaD6XBTY2IvIQ6jjLb+eieFX4
	 FaQuYdBJWmkyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/region: Fix NULL pointer within p->targets[]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Ming" <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260530-fix_null_in_targets_array-v1-1-312c3bf1fe0f@zohomail.com>
References: <20260530-fix_null_in_targets_array-v1-1-312c3bf1fe0f@zohomail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 05:06:49 +0000
Message-Id: <20260530050649.EBFCD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] __cxl_decoder_detach() suffers from the exact same p->targets hole=
 vulnerability for fully assembled auto-discovered regions, which will caus=
e a NULL pointer dereference upon re-attachment.
- [High] Failed auto-discovery decoders are left in the region targets arra=
y if failure occurs after endpoint port attachment, leading to a Use-After-=
Free (UAF).
--

commit 8beb15c55def2c0ba7cda46a708f6b3d2ab5e643
Author: Li Ming <ming.li@zohomail.com>

cxl/region: Fix NULL pointer within p->targets[]

This patch fixes a NULL pointer issue in p->targets[] during endpoint
decoder removal. It ensures the last valid endpoint decoder pointer is
swapped into the removed slot, avoiding gaps in the valid targets array.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e90c024c80365..54018db87a4c9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2220,7 +2220,15 @@ static int cxl_region_remove_target(struct device =
*dev, void *data)
>  			p->nr_targets--;
>  			cxled->state =3D CXL_DECODER_STATE_AUTO;
>  			cxled->pos =3D -1;
> -			p->targets[i] =3D NULL;
> +
> +			/*
> +			 * Swap the last valid target into the slot to
> +			 * ensure no invalid target in p->nr_targets range.
> +			 * The targets array will be re-sorted during the
> +			 * last endpoint decoder attaching again.
> +			 */
> +			p->targets[i] =3D p->targets[p->nr_targets];
> +			p->targets[p->nr_targets] =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does __cxl_decoder_detach()
suffer from the exact same p->targets hole vulnerability for fully assembled
auto-discovered regions?

When a target is detached from an auto-discovered region:

drivers/cxl/core/region.c:__cxl_decoder_detach() {
    ...
	p->targets[cxled->pos] =3D NULL;
	p->nr_targets--;
    ...
}

For auto-discovered regions, new targets are appended at
p->targets[p->nr_targets] by cxl_region_attach_auto(). This leaves the NULL
hole intact while overwriting a valid endpoint pointer that was previously
positioned at the end of the array. Once p->nr_targets reaches
p->interleave_ways again, cxl_region_sort_targets() iterates through the
array and attempts to dereference the NULL pointer, which could cause a
kernel panic.


[Severity: High]
This isn't a bug introduced by this patch, but are failed auto-discovery
decoders left in the region targets array if failure occurs after endpoint
port attachment, leading to a Use-After-Free?

cxl_rr_ep_add() correctly upgrades an endpoint's staging state to
CXL_DECODER_STATE_AUTO:

drivers/cxl/core/region.c:cxl_rr_ep_add() {
    ...
		if (cxld =3D=3D &cxled->cxld &&
		    cxled->state =3D=3D CXL_DECODER_STATE_AUTO_STAGED)
			cxled->state =3D CXL_DECODER_STATE_AUTO;
    ...
}

However, if subsequent topology validation fails, the error path calls
cxl_port_detach_region(), which clears the region pointer but neglects to
restore the endpoint's state back to CXL_DECODER_STATE_AUTO_STAGED. Because
of this, when __cxl_decoder_detach() invokes cxl_cancel_auto_attach(), it
silently skips removal due to the state mismatch:

drivers/cxl/core/region.c:cxl_cancel_auto_attach() {
    ...
	if (cxled->state !=3D CXL_DECODER_STATE_AUTO_STAGED)
		return;
    ...
}

The endpoint decoder remains in the p->targets array and is subsequently
freed upon removal, resulting in a persistent Use-After-Free vulnerability
when the sysfs region targets are read or the array is otherwise accessed.

> =20
>  			return 1;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530-fix_null_i=
n_targets_array-v1-1-312c3bf1fe0f@zohomail.com?part=3D1

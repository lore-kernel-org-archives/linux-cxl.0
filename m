Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8432F3F1AC5
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917012; cv=none; b=GUQabpu1VvcmJ9IxHcmCi1fgW6UVm1vG94qunf9sRwDuIyP7IhEneJCosNTihtwh/9ZT0NIaYF9cpTYHmH2/DPInkz1+6/sqfmf5vXAyY/UCnorIJQyaPC6NLeLHO4CkVuncfM8LVaiJGO+A2NMNdWG19hYoyg1x81glJwqpeP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917012; c=relaxed/simple;
	bh=mryyjjt3XDcQQafHXp+TxFfaVU5ch2qmVWgCkpBBSgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tvFiolx70Stou8vjvb0WnfO7n2uHXKVvRMOvRpYWAaUgKeJvBDwb+cLivIZOvdhoySaQRDP6mEOfSd0pCcqmHz2D+ScHy0ynwzpXkHN9UlRwLaxeosmnNuChS78J+GwFh58o+xFW4gpJvMsJ/507ZlvCUIW8uJsSxaafZK/srbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsVFQFt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsVFQFt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0424B1F000E9;
	Wed,  5 Aug 2026 08:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785917011;
	bh=JcWbEp0YubMpZXQLN/C4UEax8YnuXgjWzsR7dKIi2oo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gsVFQFt3jmS2xPxVSM/8xjRTaHGjS5AU1hhDhKNdUfBgM8XJ+xkcRrPGSwb+tXGmS
	 uR5e05cxWfifA8je3bpMECQyb+aB6XRGazuK5hnqO/P2uC9QXJB3UxmJt5+uy8pFxY
	 sBlYwuzjHDM/zEDhRj5n91JqRGNU9NFqwpmWlAMNHryVmQbeHX9OIPCtANl1sXT9Ok
	 i91ben7o3rlKoWnLfnol2CxYFdWzd4ctnZZbHvsV9YA0vs1/fC++98J9e+zAkk+jOy
	 R19iPemYjKaecJ1BTWBfDnLk5x0rIpVbBc5wVG/5CVTQbeEnU/IaKLpRXlPHC2JdIZ
	 ahkvpdyU4DIfA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] cxl/region: Reset software-created regions on
 memdev detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260805074042.30173-2-icheng@nvidia.com>
References: <20260805074042.30173-1-icheng@nvidia.com>
 <20260805074042.30173-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 08:03:30 +0000
Message-Id: <20260805080331.0424B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Userspace can bypass the F_LOCK protection intended to prevent use=
rspace disposition, resulting in permanently leaked hardware decoders and p=
otential memory corruption.
--

--- Patch [1]: [RFC PATCH 1/3] cxl/region: Reset software-created regions o=
n memdev detach ---
commit f2541005d7a5430e1aac6ecade8931768b282855
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Reset software-created regions on memdev detach

This patch modifies region teardown to pass a reset context (DEFAULT vs
MANAGED_DETACH). It allows a memdev attach provider to reset its own
software-created regions without changing generic teardown behavior.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b64..7fcaddc61180d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -2893,7 +2963,7 @@ static ssize_t delete_region_store(struct device *d=
ev,
>  	if (!cxlr || !sysfs_streq(buf, dev_name(&cxlr->dev)))
>  		return -ENODEV;
> =20
> -	unregister_region(cxlr);
> +	unregister_region(cxlr, CXL_REGION_RESET_DEFAULT);
> =20
>  	return len;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does this sysfs path allow
userspace to bypass the F_LOCK protection and corrupt memory?

When a user writes to the delete_region sysfs file, delete_region_store()
unconditionally calls unregister_region() with CXL_REGION_RESET_DEFAULT,
even if CXL_REGION_F_LOCK is set.

This propagates down to cxl_region_decode_reset(), where the combination
of F_LOCK and CXL_REGION_RESET_DEFAULT causes an early return, skipping
the hardware reset:

drivers/cxl/core/region.c:cxl_region_decode_reset() {
        if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags) &&
            (context !=3D CXL_REGION_RESET_MANAGED_DETACH || ...))
                return;
        ...
}

However, the software teardown still completes in __cxl_decoder_detach()
and the region is unregistered, freeing the HPA range for reallocation:

drivers/cxl/core/region.c:__cxl_decoder_detach() {
        ...
        if (p->state =3D=3D CXL_CONFIG_ACTIVE) {
                p->state =3D CXL_CONFIG_INTERLEAVE_ACTIVE;
                cxl_region_teardown_targets(cxlr);
        }
        p->targets[cxled->pos] =3D NULL;
        p->nr_targets--;
        ...
}

Could this leave the hardware decoders permanently programmed while the
software structures are destroyed? If the kernel reallocates this HPA range
to a new region, would it create overlapping hardware decoders and lead
to memory corruption?

The same bypass pattern appears to be preserved in store_targetN() when
detaching targets. Should these sysfs paths verify CXL_REGION_F_LOCK
before initiating teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805074042.3017=
3-1-icheng@nvidia.com?part=3D1

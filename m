Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6F329E55
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451250; cv=none; b=W3MwQab9vorltot7iILj23yFNIm8Nl+8chgAlRCmIpGIIg8peyu7OW25z8qOvOeiVxrh+pxhsdyKzaIz/xOxh20SSw8ticXnYMEURcFXBS226P9m2tj+uWojN/e7CkjYh0w8QPk4iblk0tIWMWvLQVAz6kZALxd4IELoYf2fqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451250; c=relaxed/simple;
	bh=F5uJTwlO3ODgTFSbFM1DL3Zliq77uWz4nT5xn2TFB8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TZxhgmQCGr23NxldfT4AWeNDqOgiISkbs/q94hHdBLhPxEamPaGUfVZtu+VTr9m/K6Ex97xgoxIfhWBruFDDOnBaE5C1RJ4gEgT9nKbELkZoTFld8TpInnQBIKFAeOoCmOI1CLrgUdiEIJmmuLV2FmXUkEpZwkDayfoddJUURLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFzwxMyw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFzwxMyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7271F000E9;
	Thu, 30 Jul 2026 22:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785451248;
	bh=gWhX/onl5H+D/az/fEopo/XESjIAbaqft3mbW82JCeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NFzwxMywfuWSIASVyKLvFpBTxOWoFLyqTUf+/mp8Et3XTRZNzTK8l6dO3qZRNBYS0
	 Wt9nTwofnJDQ/BYZPDLAwlEUQ0/+G5vupeICWmd3NA8XkM2FBcor9NiMlEFnbu0kW0
	 tw7BjJM2tUxDUrhUxsPnTlXmHQcnWbVajvdT7MCWTCtzNEJBwhQEJmLoQD9y+6+a9/
	 Vzl2Q4hGAhHENHuwux5ogpl6rX1Lk2D2PX0vrxT06PgcCny48aQdIhKIe7C07JQxTb
	 2zfH39Nx2xdHbuP7+b9Wq586rv219Cb5054u3rsSbK6AJlRryOBGlo2l5rh9PMfdns
	 OIbyJs7GaEVcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] cxl/region: Fail region creation on position
 check mismatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <73e263e243583a26d0ab302a4f39aabc4a47b105.1785444498.git.alison.schofield@intel.com>
References: <cover.1785444498.git.alison.schofield@intel.com>
 <73e263e243583a26d0ab302a4f39aabc4a47b105.1785444498.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 22:40:48 +0000
Message-Id: <20260730224048.AA7271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Duplicate region target attach causes state corruption and NULL po=
inter dereference.
--

--- Patch [7]: [PATCH v3 7/9] cxl/region: Fail region creation on position =
check mismatch ---
commit 4352ee883f0aeb726a532c5b7f4c7ec6075bf005
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Fail region creation on position check mismatch

This commit fails region creation when there is a mismatch between the
attach-order position and the auto-discovery calculator. By tearing down
targets before returning, it ensures configurations that cannot round-trip
through auto-discovery are not committed to CXL_CONFIG_ACTIVE.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b4e8ebe158f7a..62179d987e4b5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2492,6 +2492,29 @@ static int cxl_region_attach(struct cxl_region *cx=
lr,
>  		rc =3D cxl_region_setup_targets(cxlr);
>  		if (rc)
>  			return rc;

[Severity: High]
This is a pre-existing issue, but does a duplicate target attach cause a NU=
LL
pointer dereference here?

If a user writes the same endpoint decoder twice to a region target positio=
n,
the first write succeeds. On the second write, cxl_region_validate_position=
()
returns 0 because p->targets[pos] =3D=3D cxled.

We then proceed to cxl_region_attach_position() which fails during xa_inser=
t()
with -EEXIST. Its error rollback path unconditionally calls
cxl_port_detach_region() on all upstream ports, wiping out the cxl_rr port
tracking and freeing it if empty.

However, p->targets[pos] still holds the decoder.

Once the remaining targets are attached, this cxl_region_setup_targets() ca=
ll
iterates over p->targets and calls cxl_port_setup_targets(), which attempts
to load the freed cxl_rr:

drivers/cxl/core/region.c:cxl_port_setup_targets() {
    ...
    struct cxl_region_ref *cxl_rr =3D cxl_rr_load(port, cxlr);
    ...
    struct cxl_decoder *cxld =3D cxl_rr->decoder;
    ...
}

Will this dereference the freed cxl_rr? Should cxl_region_attach() instead
short-circuit when cxl_region_validate_position() indicates the target is
already attached?

> +
> +		/*
> +		 * Verify that auto-discovery reconstructs the endpoint
> +		 * positions assigned while creating the region.
> +		 */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785444498.gi=
t.alison.schofield@intel.com?part=3D7

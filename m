Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7662D131D
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780811462; cv=none; b=UM92Q2wvIa40Fdt/NQVu1iZnXCC/NifNTeC2QIMV4ZHIXfBbRqWeOveoeI8X6e3O62aqXcgLwAkQZRypoEwFd7arV7Nl3cVMhwf19WUuS/mHEpIvJNea2BeGOiLi0fJyh4QSExdoJWROYvFv3tbR0qwHIEF+03UpLssl1PZDDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780811462; c=relaxed/simple;
	bh=s2hwO0G5eqfqehylGcuFhGae9NyHasiFKVALBtfvL6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cONVAE/wDez9tIdm4tPuBtPSEcgpQ9rAnZOUwatHW8eVztss2tNUBvX+0BVfLaH01Qq8fMBbNy4rtVwzTGjkse0RJHCxI1EIjXCcpBUSqa8bgyJGGl28m3O+9UK73GPkrnteWaMeNwAbif6WhoziDOFRSykgR+pAGCakmjPLdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiH320mQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiH320mQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672B91F00893;
	Sun,  7 Jun 2026 05:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780811461;
	bh=EK8NfxkCN3TWIVmz/qgUenVW2xyZyVJKNKCLX6QMwWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KiH320mQzzgsYROa/1pzEnt8XdJywHJWPLrHA+KpP2kOdKTlaeRD0myLHcp8yYveC
	 3jGQfYQ1dh5ikgRl4k+z53cUtzqi4EMlKezQznEWvqBZaZfoFPF6ZTjDEfA+ZZilC3
	 0Ix3zP/HHKTclzeWkGr7p1hM0OP/bekMOF3tGrW9o9bB1f6mYoilbBuIhdwjxxc2FI
	 OBppiJlIE07eon3hq+masnvgxzu6l5Bx+jgkEw1YP4wIfl7JCcmaHxRDq9Ec9vB9is
	 CO9/uNgP1Nn5kczDMiIKfGgNJIZbXhPO8go1Wtr3QRbVAMNKpcbyOFB+Wt8hT+xmDN
	 JRigLYs4v/xvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] cxl/hdm: Allow zero sized HDM decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260607053837.4389-2-icheng@nvidia.com>
References: <20260607053837.4389-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 05:51:00 +0000
Message-Id: <20260607055101.672B91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unbalanced lifecycle operation: manually advancing `port->hdm_end`=
 for a zero-size decoder permanently breaks DPA resource freeing for all pr=
eceding decoders.
- [High] The patch modifies the port's DPA watermark (`port->hdm_end`) for =
zero-sized decoders without acquiring the required `cxl_rwsem.dpa` lock.
--

commit 9ef90cd8aa01ad12f98b0af61f61ae8863b14582
Author: Richard Cheng <icheng@nvidia.com>

cxl/hdm: Allow zero sized HDM decoders

This patch permits committing an HDM decoder with a size of 0. It enumerates
the decoder into the topology and manually advances the port's DPA watermark
to pass in-order checks without reserving actual DPA space.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
[ ... ]
> @@ -1096,6 +1100,15 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,
>  	if (!committed)
>  		return 0;
> =20
> +	/*
> +	 * A committed zero-size decoder reserves no DPA, but still advance
> +	 * the port's DPA watermark.
> +	 */
> +	if (size =3D=3D 0) {
> +		port->hdm_end =3D cxld->id;

[Severity: High]
Does modifying port->hdm_end here require the cxl_rwsem.dpa lock?

It appears other reads and writes to port->hdm_end are protected by the DPA
read-write semaphore. Since devm_cxl_enumerate_decoders() iteratively adds
decoders and exposes them to sysfs before the enumeration loop finishes,
could a concurrent sysfs operation on a previously added decoder race with
this assignment?

[Severity: High]
Could advancing port->hdm_end without registering a devres cleanup action
break DPA freeing for earlier decoders?

Normally devm_cxl_dpa_reserve() registers a cleanup that manages teardown.
If we advance port->hdm_end here but cxl_dpa_free() exits early when it sees
no DPA resource:

cxl_dpa_free() {
        if (!cxled->dpa_res)
                return 0;
        ...
        if (cxled->cxld.id !=3D port->hdm_end) {
                return -EBUSY;
        }
        ...
}

Will port->hdm_end remain permanently trapped at this zero-size decoder's
ID, preventing the strict LIFO un-provisioning of any preceding valid
decoders and breaking manual sysfs teardown?

> +		return 0;
> +	}
> +
>  	dpa_size =3D div_u64_rem(size, cxld->interleave_ways, &remainder);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607053837.4389=
-1-icheng@nvidia.com?part=3D1

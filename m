Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91340963E
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540405; cv=none; b=sHBdVuJ0dPGHyGuanIYXct5kjmmXdjMc5VOI75z9CtCVOkQ6sVZ9KknzERD3mrjFoEyOM0hZaGNOCKBAY4UgJScNBzhuGgummqwwroyAqCTvOQxHLRfJdYxF4BdwRlkJC+mrS7wxybekYBGPpy77BTdUQYnJcrQ4XvUtSSV914I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540405; c=relaxed/simple;
	bh=5Ty4RW2ZKsmNTy+0+SQ8AlSpY2zjoZKzBkaAGsCSfX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tTMZAKqwLWfarzF18Nd+lxHWf8rqDdeVtBPQUx/dcJWmLLLNg1ZCIK5ooOO2BcuOhvZrS9tQt1mHme/0hln7KNtCpJwvNmEI1+8urPneFm6tnCvtDnZm8iOT72/nsXSWvDYcV+Y76k00T70X/ZQNxdmAOKrpzEOhg0eZGlV1U1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm1e/Spi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm1e/Spi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658B51F00A3D;
	Mon, 15 Jun 2026 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540404;
	bh=b2z6Nj4qXfWjKGbM3HymhXnkMVA5Tx1aLa9tAlm9/WE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fm1e/Spi+f99zk1Rr28gSEEP5p7BH3VAI+vLAtLs5/fvunlJNMdinKpVVGFGG8a7g
	 uYQ5bj7almBCPZErsiXzx9L0Gmc7SLRP/Sz/zOIUi8fNvdS5pLouhfZZIS9X/LTOBd
	 5ZXSFxt0TpwGnftstVJpjbWTwq5YVAU+Yzpcqbn74/nnXLcQi1WvwEAow7JxXFMuDa
	 9tJWCv3q0pif5u1oYGeHm3L7REifEhvNKOlEdEvgiDt8vlsORKE1YsADtXT+BTFElN
	 9vwz+Qsardc5qPCPM0eGC5D64Epm2VO0h9PwZazuvhLT4TraeYjn1BWDzV/KHhxFQq
	 wohQgm5tzLlzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 08/10] dax: read holder_ops once in
 dax_holder_notify_failure()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ecc09bb56-5ecc9c6b-35ba-44f8-b112-921b01b34478-000000@email.amazonses.com>
References: <0100019ecc09bb56-5ecc9c6b-35ba-44f8-b112-921b01b34478-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 16:20:04 +0000
Message-Id: <20260615162004.658B51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch uses READ_ONCE() to prevent a NULL pointer dereference o=
n `holder_ops` but fails to address a critical race condition with `holder_=
data`, leaving the code vulnerable to an immediate NULL pointer dereference=
 or Use-After-Free in the filesystem callback.
--

commit ee437cee4c275726ddf2ce4c7880e48e8f58eab5
Author: John Groves <John@Groves.net>

dax: read holder_ops once in dax_holder_notify_failure()

This commit uses READ_ONCE() to fetch dax_dev->holder_ops exactly once in
dax_holder_notify_failure(). This prevents a race condition where a concurr=
ent
fs_put_dax() clears holder_ops between the NULL check and the indirect call.

> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 25cf99dd9360b..433cd431a6c06 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -311,12 +312,19 @@ int dax_holder_notify_failure(struct dax_device *da=
x_dev, u64 off,
>  		goto out;
>  	}
> =20
> -	if (!dax_dev->holder_ops) {
> +	/*
> +	 * Read holder_ops once: a concurrent fs_put_dax() can clear it without
> +	 * synchronizing against readers. Without the single fetch the compiler
> +	 * could reload between the NULL check and the call and dereference a
> +	 * NULL ops.
> +	 */
> +	ops =3D READ_ONCE(dax_dev->holder_ops);
> +	if (!ops) {
>  		rc =3D -EOPNOTSUPP;
>  		goto out;
>  	}
> =20
> -	rc =3D dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
> +	rc =3D ops->notify_failure(dax_dev, off, len, mf_flags);

[Severity: High]
This is a pre-existing issue, but does fixing the holder_ops race still lea=
ve
a race with holder_data?

If a concurrent fs_put_dax() executes right after ops is fetched but before
ops->notify_failure() executes, holder_data could be cleared to NULL because
fs_put_dax() does not call synchronize_srcu(&dax_srcu) to wait for active
readers:

drivers/dax/super.c:fs_put_dax() {
	if (dax_dev && holder) {
		void *prev;
		WRITE_ONCE(dax_dev->holder_ops, NULL);
		prev =3D cmpxchg(&dax_dev->holder_data, holder, NULL);
		WARN_ON(prev && prev !=3D holder);
	}
	put_dax(dax_dev);
}

The filesystem callback in XFS retrieves holder_data via dax_holder() and
expects it to be valid:

fs/xfs/xfs_notify_failure.c:xfs_dax_notify_failure() {
	struct xfs_mount	*mp =3D dax_holder(dax_dev);

	if (!(mp->m_super->s_flags & SB_BORN)) {
		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
...
}

Because xfs_dax_notify_failure() unconditionally dereferences the retrieved
holder without a NULL check, could this result in an immediate NULL pointer
dereference or a use-after-free as the unmount proceeds?

A later patch in the series changes the ordering of how these pointers are
cleared, but it appears to still lack synchronization with dax_read_lock()
readers.

>  out:
>  	dax_read_unlock(id);
>  	return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ecc080a68-8d=
c0c99f-ab17-4aa9-83d9-490e9c97ac2e-000000@email.amazonses.com?part=3D8

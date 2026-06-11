Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A279A3FE667
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202515; cv=none; b=IPV6IK6tKvf20frMzbYziO8G7x8f3zKgx2yiyf+7W4HhbDcGD8nOW5nyVfNce6O7mLH7jmbHHjzt0o59+aEL7K9Iwb0jqbMfHtJgE/2hYEjE/bPv8AlIG5BgLv1N4PQDWXWFOovyU40N2PnqHbksyRUTcVA/TuKfbYZnkRGx9jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202515; c=relaxed/simple;
	bh=FPvqk4jwwsDIJUjsvO0RLkzgbNAqu7LmW0K+mG6Es3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DFZ7tRmu9P/1y9iuw533v4rhkJyzgXhNq2vhSyVM21GDkjJ1tULH2YMddOfaBMTVfMOAhj9krZHsbRR/Szu1JGRZOzm9S3l4LiZwGcVQGgVMQ6Hal5YczijiKVrYhfWyLhRn/VhTSvNU9O0puwcrdLtWvqb8oHQgWXwb1rQxTtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMnYdslm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMnYdslm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8221F000E9;
	Thu, 11 Jun 2026 18:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781202512;
	bh=2Mh4x20LCmqvxOMb8+zb9/Kb4hzh7ab/1MVGI9UcVas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMnYdslmg2mMyVcK1BivMX1I/lFGsQGXnSZkWkxjvG1yR1thfMUeIcI0jYS/+H4Jz
	 Li8VY0k1R2VpNHHrKsziv/FjUM7I1SOLXSz26Hch0mWlH48D+ZwC4ftWYsxIdrCZS9
	 TVvpHeFAA3fDMc/JF56hy8MeIaIXAv40MWirKlOYARDACIpc0GycwbOXpUx4zLCUXA
	 dp7xIuPcxkIYBmKVfHVgTXtVEKIYC+h0Ts0HbjNtsbwCqjCvXAUf2AbSNd5VnpphzP
	 jMZq9w9nJbCm+3MPae9/L5KWiTNqYjjhUxL29WU25jUdXa3v66ESosnW8SsacSC5++
	 AfctHLn0xorRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 8/9] dax: fix holder_ops race in fs_put_dax()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019eb7be77a8-aa9a8781-e2b8-4c7b-92ba-63a0f7017d1a-000000@email.amazonses.com>
References: <0100019eb7be77a8-aa9a8781-e2b8-4c7b-92ba-63a0f7017d1a-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:28:31 +0000
Message-Id: <20260611182832.1A8221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional `WRITE_ONCE()` in `fs_put_dax()` corrupts `holder_op=
s` of concurrent mounts due to a pre-existing race in `fs_dax_get()`.

Pre-existing issues:
- [High] Lack of SRCU synchronization in `fs_put_dax()` leads to NULL point=
er dereference or use-after-free in memory failure handlers.
--

commit 4554a08ddf0ff95891c1710cb432fdf796290f3d
Author: John Groves <John@Groves.net>

dax: fix holder_ops race in fs_put_dax()

This patch clears holder_ops before holder_data in fs_put_dax() to
prevent a concurrent fs_dax_get() from having its newly installed
operations overwritten. It adds a WARN_ON for API contract violations.

> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 6b5ee6589e39b..af5c1e14f7e39 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -116,11 +116,47 @@ EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
> =20
>  #if IS_ENABLED(CONFIG_FS_DAX)
> =20
[ ... ]
>  void fs_put_dax(struct dax_device *dax_dev, void *holder)
>  {
> -	if (dax_dev && holder &&
> -	    cmpxchg(&dax_dev->holder_data, holder, NULL) =3D=3D holder)
> -		dax_dev->holder_ops =3D NULL;
> +	if (dax_dev && holder) {
> +		void *prev;
> +
> +		/*
> +		 * Clear holder_ops before releasing holder_data. A concurrent
[ ... ]
> +		 * its subsequent store of new ops will not be overwritten.
> +		 */
> +		WRITE_ONCE(dax_dev->holder_ops, NULL);

[Severity: High]
Does this unconditional write corrupt concurrent mounts?

Because the SRCU lock is dropped in fs_dax_get() before claiming
holder_data, kill_dax() can run concurrently and clear the device state.
This allows fs_dax_get() to mount a new filesystem on a dead device.

If the original filesystem performs a forced unmount and calls
fs_put_dax(), this WRITE_ONCE() unconditionally destroys the new
filesystem's holder_ops before verifying ownership via cmpxchg().

> +		prev =3D cmpxchg(&dax_dev->holder_data, holder, NULL);

[Severity: High]
This is a pre-existing issue, but does the lack of SRCU synchronization
here lead to use-after-free or NULL pointer dereferences in memory failure
handlers?

dax_holder_notify_failure() executes under an SRCU read lock and reads
holder_ops before calling the filesystem's callback. If fs_put_dax()
clears holder_data and completes the unmount without waiting for an SRCU
grace period, it can cause problems if a hardware memory failure runs
concurrently.

For instance, looking at xfs_dax_notify_failure():

    struct xfs_mount *mp =3D dax_holder(dax_dev);
    if (!(mp->m_super->s_flags & SB_BORN)) {
        ...

If holder_data is cleared right after holder_ops is checked, can the
callback read a cleared holder_data, resulting in a NULL mp dereference
when accessing mp->m_super, or access a fully freed mp if the filesystem
has finished unmounting?

> +
> +		/*
> +		 * prev =3D=3D holder: normal release.
[ ... ]
> +		 *                 instead since violating the contract is
> +		 *                 a bug.
> +		 */
> +		WARN_ON(prev && prev !=3D holder);
> +	}
>  	put_dax(dax_dev);
>  }
>  EXPORT_SYMBOL_GPL(fs_put_dax);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019eb7bcda4b-3f=
8edae9-d7a4-4bfa-aaea-fcef77fdbbc3-000000@email.amazonses.com?part=3D8

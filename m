Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA601A262D
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861758; cv=none; b=YLEt06xPguu4grGNIfOtALHCDY0LekbAGVVabrvnJuzVxjTmWzz+ubYfOmSatRSdjkvS3TYvGsVHTJNdz+Kr9BEL9JiJ643tcf4kZ1WPuldgnzv9N4K9eYEn5/B1kBwzySUUoSyQ/7CksbJJXnnQaCdrHz3N2xkV12ZjrO5MG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861758; c=relaxed/simple;
	bh=3kb8OuwXVyeb0TEa3cPBf/w10VAolrXdjQUtuUcYtUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kIhv7ExZIJDKHWygxS+9ASpJtSHn9q/aAXh6me+uOyqN2RWvM5DLUmuPJEg5kjz5nVTL5J/Xv+uh8LMoDfOvlHwz5y3O0KZpRHKuMawWUK94MW0dvVsAxHC9A7ni5v9dpKcQSRA4tOk3D7o5Ayw0x/Jrxb0PyvxRHrIxD+jGehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bibFbT8i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bibFbT8i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE561F00893;
	Sun,  7 Jun 2026 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780861757;
	bh=X4qA0bz5ceQeyJ0voCj1i5Dc5wHZ4C8P/nSZlHWa1bE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bibFbT8iMLelUZEGUd7q54QotMWDC3suGgqbyDnM643rh1jWFBEfytctW+R+MaRZH
	 3JtTBTRtL1yPIviSDFT9ueCtEWxB/z11Ww2UMfZqjSa6Icbjh0ZOkrS8dEa1Lffe72
	 kIAInMASUzetPAeYTxQcd7llDxxPkQEkQsXPuwQSx5aJO1XAg6jsz0DiBtRZfb5ez3
	 3REQsz79gOYB7NKzP2/M/EV6OlsSVc2fx+1kFMfQAXW9TZfa2WuvQgriprnfLEEvXu
	 M9MyVgHj3omL8oLgxAicd2f+jgSG6jlr7FP8t3ryK6npb9LkUbD9VkXfGy6IY7s5Iu
	 7bQnu3WC7LuOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 7/9] dax: fix holder_ops race in fs_put_dax()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ea3941018-519230fa-2897-41b8-9677-dabc8d1124ca-000000@email.amazonses.com>
References: <0100019ea3941018-519230fa-2897-41b8-9677-dabc8d1124ca-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 19:49:16 +0000
Message-Id: <20260607194917.1CE561F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] fs_put_dax() unconditionally clears dax_dev->holder_ops before ver=
ifying ownership, corrupting the operations of a legitimate holder if calle=
d incorrectly.

Pre-existing issues:
- [High] dax_holder_notify_failure() reads dax_dev->holder_ops without READ=
_ONCE(), allowing compiler double-fetches and a TOCTOU NULL pointer derefer=
ence.
- [High] fs_dax_get() drops the SRCU read lock before modifying device stat=
e, allowing it to race with kill_dax() and acquire a dead device.
- [High] fs_put_dax() clears holder information but fails to wait for pre-e=
xisting SRCU readers, leading to a UAF or NULL pointer dereference in notif=
y callbacks.
- [High] kill_dax() checks holder_data before clearing DAXDEV_ALIVE, creati=
ng a TOCTOU race where a newly attached holder is wiped without notificatio=
n.
--

commit c385d20d67e08b6d8549b98dcf43d6d8a692ac06
Author: John Groves <John@Groves.net>

dax: fix holder_ops race in fs_put_dax()

Clear holder_ops before holder_data so that a concurrent fs_dax_get()
cannot have its newly installed holder_ops overwritten. cmpxchg()
provides release ordering on weakly-ordered architectures, ensuring the
WRITE_ONCE(holder_ops, NULL) store is visible to any CPU that observes
the holder_data release.

> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 25cf99dd9360b..96f778dcde50b 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -116,11 +116,47 @@ EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);

[ ... ]

> +		/*
> +		 * Clear holder_ops before releasing holder_data. A concurrent
> +		 * dax_holder_notify_failure() that sees NULL ops returns
> +		 * -EOPNOTSUPP cleanly. A concurrent fs_dax_get() that acquires

[Severity: High]
This isn't a bug introduced by this patch, but this comment relies on a fla=
wed
behavior in the failure notification path.

Looking at dax_holder_notify_failure():

drivers/dax/super.c:dax_holder_notify_failure() {
    if (!dax_dev->holder_ops) {
        rc =3D -EOPNOTSUPP;
        goto out;
    }

    rc =3D dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
}

Since holder_ops is read without the READ_ONCE macro, can the compiler emit
two separate memory loads? If fs_put_dax() sets holder_ops to NULL between
the check and the indirect function call, it seems the second load would re=
ad
NULL, resulting in a NULL pointer dereference.

> +		 * holder_data after the cmpxchg below is guaranteed to observe
> +		 * holder_ops=3DNULL first (cmpxchg provides release ordering), so
> +		 * its subsequent store of new ops will not be overwritten.
> +		 */
> +		WRITE_ONCE(dax_dev->holder_ops, NULL);
> +		prev =3D cmpxchg(&dax_dev->holder_data, holder, NULL);

[Severity: High]
Does this unconditionally clear the holder operations before verifying=20
ownership?

If an errant caller invokes fs_put_dax() with a non-matching holder, the=20
cmpxchg will correctly fail and preserve holder_data. However, the legitima=
te=20
holder's operations have already been overwritten with NULL here. Could thi=
s=20
corrupt the rightful holder's state and silently break future memory failur=
e=20
notifications?

[ ... ]

> +		WARN_ON(prev && prev !=3D holder);
> +	}
>  	put_dax(dax_dev);
>  }

[Severity: High]
This is a pre-existing issue, but does fs_put_dax() need to synchronize with
SRCU readers before returning?

When a filesystem unmounts, it calls fs_put_dax() to clear holder_data and
holder_ops, but returns without calling synchronize_srcu.=20

If dax_holder_notify_failure() is executing asynchronously, it retrieves the
mount pointer:

fs/xfs/xfs_notify_failure.c:xfs_dax_notify_failure() {
    struct xfs_mount *mp =3D dax_holder(dax_dev);

    if (!(mp->m_super->s_flags & SB_BORN)) {
        ...
    }
}

If fs_put_dax() has just cleared holder_data, dax_holder() returns NULL, and
this immediately dereferences the NULL pointer. Could this cause a crash on
unmount?

[Severity: High]
This is a pre-existing issue, but looking at fs_dax_get() which is related =
to
these ownership changes:

drivers/dax/super.c:fs_dax_get() {
    id =3D dax_read_lock();
    if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode)) {
        dax_read_unlock(id);
        return -ENODEV;
    }
    dax_read_unlock(id);
    ...=20
    if (cmpxchg(&dax_dev->holder_data, NULL, holder))
}

Does dropping the SRCU read lock before modifying the device state allow a
race with kill_dax()?

If kill_dax() executes concurrently, clears the alive flag, and wipes=20
holder_data, could the cmpxchg in fs_dax_get() blindly succeed and set=20
operations on a dead device?

[Severity: High]
This is a pre-existing issue, but could there be a race during device remov=
al
in kill_dax()?

drivers/dax/super.c:kill_dax() {
    if (dax_dev->holder_data !=3D NULL)
        dax_holder_notify_failure(dax_dev, 0, U64_MAX,
                MF_MEM_PRE_REMOVE);

    clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
}

Because holder_data is checked before clearing the alive flag, could a=20
new filesystem execute fs_dax_get_by_bdev() concurrently, see dax_alive() is
true, and successfully register its holder_data?=20

If kill_dax() then unconditionally wipes holder_data and holder_ops after
this, the new filesystem would miss the pre-remove notification entirely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ea3929225-a0=
f8e6f7-30ae-4f8e-ae6f-19129666c4c3-000000@email.amazonses.com?part=3D7

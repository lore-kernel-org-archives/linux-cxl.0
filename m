Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7C284690
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165242; cv=none; b=h6Q+S5L7eR0TUnLqJ6HxUNN/meUvg+VyPGlAg2q4vG0nEU3UMxlSwFEJn33qjFsb0Tgf66vwLvp0yk3yg30EQzJwNNDjpnNnf8yHQg6fVFkAgtMZMVTuZjMGe7q7UIJGHoyQtnYc/dzv5OlBjd1DfS9pt3BurqWOG8AtjnJc/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165242; c=relaxed/simple;
	bh=ofwxILM2MFxRQ7Awt6/cV/DF/WcbiWwRbaIjcV4BXAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AEt0MprlGaeJs1pxLecuwGgU5nmq/RdX2WSMFYuhT7eUESwUlmGWCeoNgx3oMxExd2i0A9wM7lZL8BXAGWVVxswYm1JMzMfjJTzTmbJaMSjLuBrhoU0X8wz5A+4uA7elLMlJ82sw1IyqZYxWPwfgmcwchLtoxkB2H9E4Sc1kHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVsgcn/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVsgcn/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7406B1F00893;
	Sat, 30 May 2026 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780165239;
	bh=WGGwaALPfY1MGxQ0yeGeA65Clj/nry6LEQ5yXajFnXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVsgcn/gCLLUZTdbUxgFxer/kOM+/+krgowkn3zl1iPggxMukluGOZayHLRiaIO03
	 z7YX0EUTXxU4HVYmiz+zsQwBrqmpCUll7YOMtxyUDwNUxzuL0rD9EF8Oy8dcQ/7YSA
	 sF6SqWMgHt+zvZ6PDUTQrwKmgYba8SR/AXSOeIv66+OFO6wnqRiRGaMDgYyt+LZD+k
	 H9HUj7aGV+e0h5nmjzSaF6wjgWfhji8nF4d3pg4n1Q8ya0b6NuqVVxfhYvsSlByBoO
	 SQ4soc9A9ZCIMql/LoM6T3ERzuoUruLl77eURG4a/5zfdCECcrbRBQle03b3mn5v6b
	 qei/4HxTtta6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 8/9] dax: replace exported dax_dev_get() with
 non-allocating dax_dev_find()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019e79cc4e0f-26041b0e-3c38-4641-9e36-c8964a7f0e89-000000@email.amazonses.com>
References: <0100019e79cc4e0f-26041b0e-3c38-4641-9e36-c8964a7f0e89-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 18:20:39 +0000
Message-Id: <20260530182039.7406B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Recycled `dax_device` objects inherit stale flags and operations d=
ue to lack of zero-initialization.
- [High] `alloc_dax()` exposes a partially initialized `dax_device` to conc=
urrent lookups before `ops` and `private` are configured.
- [High] `dax_core_init()` incorrectly returns 0 on failure, leading to use=
-after-free panics during delayed DAX device allocations.
--

commit d84f23ffdf147bc18ecb76242e383acc9eb6cbc0
Author: John Groves <John@Groves.net>

dax: replace exported dax_dev_get() with non-allocating dax_dev_find()

This commit introduces dax_dev_find() for lookup-only semantics and makes
dax_dev_get() static. It resolves teardown warnings and potential minor
number corruption caused by allocating inodes without backing drivers.

> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 4c56ac2faacdb..6cb271e034a70 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
[ ... ]
> @@ -573,7 +573,41 @@ struct dax_device *dax_dev_get(dev_t devt)
> =20
>  	return dax_dev;
>  }
> -EXPORT_SYMBOL_GPL(dax_dev_get);
> +
> +/**
> + * dax_dev_find - look up an existing dax_device by dev_t
[ ... ]
> +struct dax_device *dax_dev_find(dev_t devt)
> +{
[ ... ]
> +	dax_dev =3D to_dax_dev(inode);
> +	id =3D dax_read_lock();
> +	if (!dax_alive(dax_dev)) {
> +		dax_read_unlock(id);
> +		iput(inode);
> +		return NULL;
> +	}
> +	dax_read_unlock(id);
> +
> +	return dax_dev;
> +}
> +EXPORT_SYMBOL_GPL(dax_dev_find);
> =20
>  struct dax_device *alloc_dax(void *private, const struct dax_operations =
*ops)
>  {
>  	struct dax_device *dax_dev;
[ ... ]
>  	dax_dev =3D dax_dev_get(devt);
>  	if (!dax_dev)
>  		goto err_dev;
> =20
>  	dax_dev->ops =3D ops;
>  	dax_dev->private =3D private;

[Severity: High]
This is a pre-existing issue, but does setting the operations pointer here
create a race condition with concurrent lookups?

Looking at dax_dev_get(), it calls unlock_new_inode() which makes the
inode globally visible in the VFS cache before alloc_dax() configures
these critical fields:

drivers/dax/super.c:dax_dev_get() {
    ...
    if (inode_state_read_once(inode) & I_NEW) {
        set_bit(DAXDEV_ALIVE, &dax_dev->flags);
        ...
        unlock_new_inode(inode);
    }
    return dax_dev;
}

Could a concurrent thread calling the newly introduced dax_dev_find()
observe dax_alive() returning true, but dereference an uninitialized or=20
stale ops pointer when performing DAX operations?

>  	return dax_dev;
> =20
>   err_dev:
[ ... ]


While reviewing this patch, I also noticed a couple of other pre-existing=20
issues in drivers/dax/super.c that might be worth investigating:

[Severity: High]
This is a pre-existing issue, but can recycled dax_device objects inherit
stale flags?

In dax_alloc_inode(), the dax_device is allocated from the slab without
clearing the outer fields:

drivers/dax/super.c:dax_alloc_inode() {
    ...
    dax_dev =3D alloc_inode_sb(sb, dax_cache, GFP_KERNEL);
    ...
}

The init_once() function only clears the memory on the initial slab creatio=
n:

drivers/dax/super.c:init_once() {
    ...
    memset(dax_dev, 0, sizeof(*dax_dev));
    ...
}

Since bits like DAXDEV_SYNC and DAXDEV_WRITE_CACHE are set but never cleared
on teardown, could a newly allocated DAX device erroneously inherit these
states and skip required CPU cache flushes?


[Severity: High]
This is a pre-existing issue, but does dax_core_init() hide initialization
failures?

If subsystem initialization fails, the error path destroys critical global
structures but explicitly returns 0:

drivers/dax/super.c:dax_core_init() {
    ...
err_chrdev:
    dax_fs_exit();
    return 0;
}

Would this hide the failure from the kernel's init system, causing delayed
DAX device allocations via alloc_dax() or dax_dev_find() to attempt=20
accessing the destroyed dax_cache or unmounted dax_superblock and panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019e79caead2-57=
95328c-af48-4a93-b147-c11df7446e1a-000000@email.amazonses.com?part=3D8

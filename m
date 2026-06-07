Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039CC27FD6D
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861748; cv=none; b=JJV2xsXP4QqldwP9EH33gpmaaZOL095AzJj0OxSPU4x4nbjtBXnsrboRi4n5A4vYXnecRJn1lwmWtpN+0kjhBXDPHgq9APVQJnHOflTWqJ5Nazojp+Mxj8wiEy9cbzxVmbhEE2wMGkt16fmLODJ7plFkii4y4M53I3yfxkOGy+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861748; c=relaxed/simple;
	bh=aXnJRGJeDdnzP5P2W+TF+qW1p6SpEd8hjq9/AUGAA3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jIk6G156neTb19pTjLwnLqSQfruOHEmu81C3pDaQNHYosoJfFjbYb+VEwZeQ/cE07cDg12YmL56YY7TwgtOiFFYKG6I3cemLML4U7tpxzKqFS5bWRRjUxYn0c2gptTK0S98J8kP7rjS3j8ngLfOsUGXe+MewJELhpY/YseBIGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1pu9zvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1pu9zvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711901F00893;
	Sun,  7 Jun 2026 19:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780861746;
	bh=m8BDB1yX8JxxgqJ84fkhYrOVIyEx9ZtIyvTKpgGpZyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K1pu9zvKyG+ht3rMWLNx5A/2iHKcRiji2AVCUtV4FLH1eTo+7KGG3S+FkhNDXlPke
	 udd0HD0ShrklZk62wGnfWh8APUVg6mcicjGl4oUALnNi/7uy6A9U0EAj7emh3Bn+9K
	 LqNBur6acmQObim93mpPK7X0h8KrHSJ4bOVvv244P+XQ38FSPPpNND+Td5maFa/nKC
	 wShec2fWAlljGro4mIpapBT1dk/tFaMQ32Tv9FTr5lm2pzlka32vKTUkmne/SAPO/3
	 jY7VHrp1o96dhnA9vccP3I3WpNW5rO7KHfDEdb3RRbBbjhJKnTuWyaem4IToeKs4GM
	 1HlXLMiB2Z3Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 8/9] dax: replace exported dax_dev_get() with
 non-allocating dax_dev_find()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ea3943a9d-3724a539-97c6-46f9-a3bb-c7b9a51d3889-000000@email.amazonses.com>
References: <0100019ea3943a9d-3724a539-97c6-46f9-a3bb-c7b9a51d3889-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 19:49:06 +0000
Message-Id: <20260607194906.711901F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch introduces an exported symbol `dax_dev_find` but does =
not include the claimed caller updates, resulting in zero in-tree users.

Pre-existing issues:
- [High] A race condition allows `dax_dev_find()` to return a partially ini=
tialized `dax_device` with stale or uninitialized `ops` and `private` point=
ers, leading to a Use-After-Free or NULL pointer dereference.
--

commit 4db396b1477c7ac48536ccf90d47d3c4adb9e2d3
Author: John Groves <John@Groves.net>

dax: replace exported dax_dev_get() with non-allocating dax_dev_find()

This commit replaces the exported dax_dev_get with a new dax_dev_find
function that performs lookup-only semantics. It also makes dax_dev_get
static again to prevent external callers from accidentally creating new
unbacked DAX inodes.

> Make dax_dev_get() static again (internal to super.c for alloc_dax),
> export dax_dev_find() instead, and update the two external callers
> (famfs_inode.c, famfs.c). Also add the missing CONFIG_DAX=3Dn stub.

[Severity: Medium]
The commit message mentions updating external callers in famfs_inode.c
and famfs.c, but these files are not included in the patch and do not
exist in the upstream tree.

Is it possible the updates for these files were left out of the patch,
or are they out-of-tree? Exporting a symbol without any in-tree users
typically goes against upstream guidelines.

> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 96f778dcde50b..b37ae79c084bb 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
[ ... ]
> +struct dax_device *dax_dev_find(dev_t devt)
> +{
> +	struct dax_device *dax_dev;
> +	struct inode *inode;
> +	int id;
> +
> +	inode =3D ilookup5(dax_superblock, hash_32(devt + DAXFS_MAGIC, 31),
> +			 dax_test, &devt);
> +	if (!inode)
> +		return NULL;
> +
> +	dax_dev =3D to_dax_dev(inode);
> +	id =3D dax_read_lock();
> +	if (!dax_alive(dax_dev)) {

[Severity: High]
This is a pre-existing issue, but does adding dax_dev_find expose a race
condition where a partially initialized device can be returned to external
callers?

When a new DAX device is created, alloc_dax calls dax_dev_get. Inside
dax_dev_get, the new inode is unlocked and DAXDEV_ALIVE is set:

    if (inode_state_read_once(inode) & I_NEW) {
        set_bit(DAXDEV_ALIVE, &dax_dev->flags);
        ...
        unlock_new_inode(inode);
    }

However, alloc_dax initializes the ops and private pointers after
dax_dev_get returns:

    dax_dev =3D dax_dev_get(devt);
    if (!dax_dev)
        goto err_dev;

    dax_dev->ops =3D ops;
    dax_dev->private =3D private;

Since dax_device is allocated via alloc_inode_sb with GFP_KERNEL (no
__GFP_ZERO), could a concurrent call to dax_dev_find successfully look up
the inode via ilookup5 and see DAXDEV_ALIVE set before alloc_dax sets
the ops and private pointers?

If an external caller invokes DAX operations on the returned device, could
it dereference dangling ops or private pointers from a previous slab object
lifecycle? Is it possible to defer unlock_new_inode or setting
DAXDEV_ALIVE until after ops and private are fully initialized?

> +		dax_read_unlock(id);
> +		iput(inode);
> +		return NULL;
> +	}
> +	dax_read_unlock(id);
> +
> +	return dax_dev;
> +}
> +EXPORT_SYMBOL_GPL(dax_dev_find);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ea3929225-a0=
f8e6f7-30ae-4f8e-ae6f-19129666c4c3-000000@email.amazonses.com?part=3D8

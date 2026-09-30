Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5724EDCB5
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778596; cv=pass; b=sM/CmhAu+9J/t5SxBKxojeTVZ6fg3vvtHi9NWJr4O0sPaLX7ahH/14YZnvAlzllYp1eFYWJOgQr7SNgIDnwjk+zDDd2Ds1gqAquxYXgsUNo9RGd09ardgtEVjqSQgvcTMsKZMYc/jEPZ+m+qd6BT/+6zZaMFLHNbGHZUIctN17c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778596; c=relaxed/simple;
	bh=Jv5f1g0f3qDS45IX1yQFN/XI/1HiyQaIpDbEOG1DCc4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WzLTfuNJUMIxW1GT1HK9dlLRSbj2E8BBvGI0Z7YaTLxq6mvui/bAFYCW0StZc1Kgq7tEBwEgbuqgbLGAYRJfNR8yrFlj0SXn6Nl8iPOknRgEDH2+1tCw0kOEG7k8ZyDG/bP3XGHnzl1ivqRXMf48gWd6I0ghr4dB0BClyoZ6Go8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JtZc2h8E; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JtZc2h8E"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320dc09f3so42724431cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 07:29:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790778585; cv=none;
        d=google.com; s=arc-20260327;
        b=dcUMRPLqc58036pwSS3lhplf6utL6Cm+X5uIwOA36SVyqzoKMBUT59Ns+7MQY3Y0F8
         wzQkF8tzNIQksdsD7TKnMe4HRTpqFV86OMAGHxhwdrKMa+8pBkZDl9lFXq4H/L7b+cbu
         afUDIcz8OGzOGO4VEcYJAZQDbtyDjHwqrTwsBoQFMQ95W8xVK7lOCfuwoh9qgbLIMrQP
         qHlvbvNNIriBjRxNxhHz01sjWwAWbzzTlsPp+z+255oBUPudKlKGOcayiFbdooxwAAqB
         cARZ+p/DNi8xiekYPjX4aMON+C30T0+yUzM9CLcMqR9FzvfaENqygAZjvdAql+GzWD9Q
         Bv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bFcOr5qvsPCgBjFZ4BWLUmj9QlCgJD693TK70ZfQ/Lc=;
        fh=PgcVhoNTTF81NUVt4J9MfafztwnE+/QcR9DInt48qiQ=;
        b=MtMNioZVFBhWupWyd9fBGFhF7iLnP4t4Uqbw/mouLvyKZX6GYP4cScuC2SoNrjoT5L
         O5xGBaM7pcXkipbbQglmNAJZ473ht+6T3BOvZ/vOOWB5r20xlGFmFYq0c/td1iplTMkE
         qIeUSY8yYWYAsvHD8BGNeDAxe74BSkgRt8XlxV2gd36lyKxuTdQxIYrCDkcZeFfiEAhq
         i1tEvLcrP+jD7bQdLq0Uw1BcTNVKoIUSrVMfcl3MgVCUmYjDq2Ogp1COySdnnP2o9bms
         1tITk7Qhjcy3bjGTmfj1EZIEalGqwAxWMELrpHopfrsUCRUkjrlLwtgGo8X8quHo00Ir
         7zEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1790778585; x=1791383385; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bFcOr5qvsPCgBjFZ4BWLUmj9QlCgJD693TK70ZfQ/Lc=;
        b=JtZc2h8EQA45wKHjoOhwjBPvJIRF+85Eyx9ImkE9V6edmGXF91BJBPX14iSyK7TyK8
         2ryN6nFxlROoSwmDZaf24EgMB1C/0riOHVLkH94bm6pdZs+12tQLuIFoulWdm8xK4NUi
         RWKl2Lup3bX3feQudkK0NEhGsFCbRAeccwFUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778585; x=1791383385;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bFcOr5qvsPCgBjFZ4BWLUmj9QlCgJD693TK70ZfQ/Lc=;
        b=Zb2P/KaLpzzAB9yQhZznvbA9CYoOycorYINSpo1PgS7mFDj57bma9cFN2oXHmaqNTJ
         x+kRwLOefYS6vFscHIPVn6iFbHNOxqYRww69aJ8nlXq0iLwpTgJotYo5vSA2SX8bYlF/
         KWcvLxluZXkq5dVRXzO6qFjOiypwoggNdnb6bFgr572yJ4U+PRUH1pEMbbjQA50JS+V2
         7UjpAIHvlbbwZYk/NQN8mlZh9ttA5Vm8VXQAvEuwp2HtLU6Sm10FCrkua4ftvX9BrIq4
         iF4lAy47j8+W7E93fNmLUzpTjOl0yED2jyiMXeVLVgmmKJ1MHnuHhQJ+j9tGtkvOR3/M
         NkTw==
X-Forwarded-Encrypted: i=1; AKwUvByyCDdJljbZWoCBtTtsQTkBN3HQvAWzvmI84D90It2A78bsF6VBTWGjjOPy3L3VOVisaMFzRotnAOE=@vger.kernel.org
X-Gm-Message-State: AFuF++mO0eWUtQQYdXMjke22GnJS/408ETpp7YCAJR7nSwNC7ZnwYdha
	w7BiNzbl4tsppKKv45fztmiu25uQlA6JNT2/jESPCGZyGKolDCAW+zJUj9L7kJ3+DPY4DRJePWb
	FJaLkycC56GPeqcv60T4YiS71CLUtc9eW+WaRi3CEWg==
X-Gm-Gg: AYBFou1fX4ZT3qz7k2d86u6AUnFLC3DxB1pI3+NuZ9W4HN1kuzzLNeTIhk9k0EWoM38
	xLbdDG8VBQD4iTCQNL3TaBV2wJdS8keahvk2YRgQzSBkZ2c3ay+ftrqBhpyv38SlngXuTqXu/I9
	79U4PCSIA2RGPY60Bp980ge60SEhlRAZio3qg65h5zbuiiy+DQjOMkcDg0o5fEshVLsHG8qW7XX
	9VfNf70tFD6rv0aD64I7aDHK9P55BkCcebEUl/q00OhlnU9aRFWJhshAmOsCl4Tsv5fkj6XsFrW
	F9rnQ+hZWHIXwQpppbxciSu2d33ypTGVG2lCHO9Rxc7kklHgGiAW0QAiOwNUGEtkZU85WL9PT8H
	9n6pcESFHafYxWw==
X-Received: by 2002:a05:622a:258f:b0:533:32f3:1db0 with SMTP id
 d75a77b69052e-533742bb8cbmr29673951cf.6.1790778584578; Wed, 30 Sep 2026
 07:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 30 Sep 2026 16:29:33 +0200
X-Gm-Features: AclHuK8GeOe_W3mvOTyMrVDZeZ25RiRcVppHiB0syijS4_yNrxLEymVmpXQKS-M
Message-ID: <CAJfpeguyOXGQO4Q8rSAc8GxExTJU0G2o19fxRnh_93GvAoNcRg@mail.gmail.com>
Subject: fs_put_dax() vs. dax_holder_notify_failure() race
To: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org
Cc: fuse-devel <fuse-devel@lists.linux.dev>, Carlos Maiolino <cem@kernel.org>, 
	linux-xfs <linux-xfs@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	John Groves <John@groves.net>
Content-Type: text/plain; charset="UTF-8"

During ->notify_failure() callback will dereference holder.  It may be
NULL at this point, resulting in an Oops, or it may be non-NULL but be
freed during that call, resulting in UAF.

This affects xfs at this point, but the fuse extent map patchset[1]
also adds dax failure handling and is affected by this issue.

I think this should be fixed in drivers/dax/super.c, since this will
be a problem in each user.

Thanks,
Miklos

[1] Report from sashiko (select Patch 8):

https://sashiko.dev/#/patchset/20260922061019.3320196-1-mszeredi%40redhat.com

Or here it is inline:

commit 1580a2f8ad3f103a20b6280aa39a01f8b0be2d3f
Author: Miklos Szeredi <mszeredi@redhat.com>

fuse: add support for opening dax device as backing

Add FUSE_BACKING_IS_DEV flag that allows opening a character device
(dax device) as a backing, in addition to regular files. Mark the
inode with S_DAX if FUSE_LOOKUP returns with FUSE_ATTR_DAX set.

> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 58dbdd17c1ef4..aa558a0c2e647 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
[ ... ]
> @@ -22,9 +23,16 @@ static void fuse_backing_free(struct fuse_backing *fb)
>  {
>   pr_debug("%s: fb=0x%p\n", __func__, fb);
>
> - if (fb->file)
> - fput(fb->file);
> - put_cred(fb->cred);
> + switch (fb->type) {
> + case FUSE_BACKING_PATH:
> + path_put(&fb->path);
> + put_cred(fb->cred);
> + break;
> +
> + case FUSE_BACKING_DAXDEV:
> + fs_put_dax(fb->dax_dev, fb);
> + break;
> + }
>   kfree_rcu(fb, rcu);

Does this code introduce a use-after-free race with a concurrent hardware
memory failure?

When a DAX-backed FUSE backing file is closed, fuse_backing_free() drops the
DAX device holder by calling fs_put_dax() and frees the backing object using
normal RCU via kfree_rcu().

Concurrently, a hardware memory failure can trigger dax_holder_notify_failure(),
which protects its read-side critical section with SRCU using dax_read_lock().

If dax_holder_notify_failure() reads dax_dev->holder_ops and checks for NULL,
and is preempted here, fs_put_dax() can run to completion. This would set
dax_dev->holder_ops and dax_dev->holder_data to NULL, and eventually free fb
after a normal RCU grace period.

Because kfree_rcu() does not wait for SRCU readers, the memory could be freed
while dax_holder_notify_failure() is still running.

[ ... ]
> @@ -79,23 +87,88 @@ static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc, u64 id,
>   return fb;
>  }
>
> +static int fuse_dax_notify_failure(struct dax_device *daxdev, u64 offset, u64 len, int mf_flags)
> +{
> + struct fuse_backing *fb = dax_holder(daxdev);
> +
> + fb->dax_error = true;

Can this code cause a NULL pointer dereference or use-after-free when racing
with fuse_backing_free()?

When dax_holder_notify_failure() resumes after the race described in
fuse_backing_free(), it blindly calls ops->notify_failure() which is this
function.

Because fs_put_dax() may have already cleared dax_dev->holder_data,
dax_holder() might return NULL causing a NULL pointer dereference here.
Depending on the timing, it could also return a stale pointer to the freed
fb object, resulting in a use-after-free.

> +
> + return 0;
> +}

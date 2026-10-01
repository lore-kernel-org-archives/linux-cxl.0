Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA563E40E4
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872362; cv=pass; b=pIVzbCJ79DoDRyFUD/MUU4ee84BMpGDEbin/bE+zzmEm7tHgJR5f9et1dIANDAVgrv7SVZP5fOEIgM1bkhdmWM06JBz+I2yBxzsFVhXwdwPRH9zukwvbd1ZP2MuzsU1bLUVQi4Lo77stL/hIwS/PXOBOgzq7xBtMICfrnhcOSmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872362; c=relaxed/simple;
	bh=Hmrg1utwy1UsI/La0jCaZph+V7N3+1dJzQKkRO9nMBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1rZlIWl3aWf0F5h+tqMOwl9LdeNKhyZ+9nquAiJYc3YR/YeyJjMMCeCOTnxJZQui1o31lm8jnU1K2tGE7b+I3Cu3TMJgYN0U4WV1C7wCW/2SuuBD93daOo2t7b6eULn73K78pMGM1VWfEs8W/Pezzvn9uD8lfFpojOjhLqjFls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTlHavh7; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTlHavh7"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso4891324a12.2
        for <linux-cxl@vger.kernel.org>; Thu, 01 Oct 2026 09:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790872359; cv=none;
        d=google.com; s=arc-20260327;
        b=AH1Za1jcP6okweWDMObyemfurx2AYhSi8zkS/44t9PbwMgHTuA4qB2N2j7dBO03tZK
         DBpJEVNv2K2hLJk0HX6U6LbrBuEBiiMRN+xEWUqzbZ6kAxptJ7maot1AsJj3f/j5vF2q
         IXSusNel4To2TqlaGxCvckLUVLjiOhKNUIjNrudH+4L8fSIfNg8eMwIBpS0JEAH5oHHg
         rkS7dGDSxdpXnLzLbjWjvmfD7teunt93e1yWEbI9akC7HjL7J+sP4BIN1I5aO4TOqlwi
         Gk2N88ohjlnc1b1y5h0XdK9IHyNo2RV1uItfBltnQbDHVgrfyBd4IBEeWH1BrebIQ8N7
         3tRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TznGzYFAbbkKA0AdCMYN+GaZPqVPOXxDGKW1f5n1Xes=;
        fh=moJsffImmmHLYVYxlLFW7YzmdIMcgpzgzdwBb0zkH+w=;
        b=CzTBJnT+enYbkaJRhmD61DJ+Qrl/GzILFPc3U1/2u/IJOG+jUUKp3TMF0ua4O9JX2L
         YfTirqhQn8TXT5LeiA8fXvKIM47IEH4TF+GDq/p/OkTCM681bY8Ba/bJTXbuPC8MAbof
         cut58p4rZNEhl9WBIYhDdU50c1zMvfNbOBXbxHzwM4hzni2YmhkGn8krROdhWkh+up+j
         rBGd0BdHY8Z3QsIOJIF4KiIuCC8hGhrWA1k5onrmCEtUZrGn4G/7S408WjJSOFvJcGom
         C1SzCHzSIOUM8KWy3+6jj0dyBRvbKI8qV7LW9EJ8MqSnrxKsowCV0mq4tjxPNmwyLR/E
         tuWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872359; x=1791477159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TznGzYFAbbkKA0AdCMYN+GaZPqVPOXxDGKW1f5n1Xes=;
        b=OTlHavh7g0qG7ChwS/U7hraQjj6uosx5R1gX+YtvcZx9g/vWdDg4u/jfymZkaRl2/Q
         wVGWyZyNY5DdOVPg+fbHduMkqV7xDg2LuPcfuDdHmqcc35Wc0j1o5MpUZIOA1sELOy3P
         1E/Bt1WJEcTAdLmgxprvv58SWHMkWdcFOkSsTX1xWgO6/vnaKTRspvRku9Wq2SSHDKI+
         am27RfcGvdTPriKqX+5B0885VGf13M1zRJTDiqj3nE10YePXcr3YOSxNnag5zzaQiRK9
         mYOeOhsX+FXZ20M2jOK8YcKeN+QXX+v7UQ8K04t5hRGCAlgUqhbiD+hlDmCrfjEbKg4O
         3Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872359; x=1791477159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TznGzYFAbbkKA0AdCMYN+GaZPqVPOXxDGKW1f5n1Xes=;
        b=b1WjoUfF/qdaJKpm86tR1555g3NWoID/fQv17r3y34aGuauF5F4jXVlX4nicKGPVTx
         ANrg5299Tgf18UfqEroU8XChQqJ/MdHTrpQSQjqaEs+jdR3f+g+52wahACyXD9AKL5DL
         15mvxNZuRS9L0tgOfrioztdFaZG6zJo1ChNxhnYA2pd+lbc+5qDcJXU5PWqyITtoEnWv
         u9g16SiNZ4jkhLBHIO6BVMT/ILfiqOJKhjkrSlb9RHru0UwuyVX52N6rGTr0mFM+Mei7
         oxs+dqhmG6f9nCNt9Dn4AfB4qsn9GTEAOOeaUxPkScihZrWRAsrM4JukeLaaP3Vw1EAn
         MB/w==
X-Forwarded-Encrypted: i=1; AKwUvBxddWi51NbrJoMkWwBDIcUV3aNQFSBrwCqoQ1wGpO/EnvgpEXRKFVRkDx67B2hAtrEBjpukh85jPow=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8R+aMeLudbdzLWxRy7afTIx2n1RhglJCK698Q0XJXYc3jN7WQ
	hZ/9CisjQQ5mDcg7lWMsffcWK6XB5mQ7k/S1ODnrLzu53u1zNNuSecS+M2uKL3xkOgd3ARFmLg1
	nUP0Q7a+q8eFZMHx5gk4BVLMIF5o3NEk=
X-Gm-Gg: AYBFou0md3NGH9ulOImPBrQZdhSURSx1ZRhjZ3kyExJQMcNmoGVwEmKYkY4KwoU7SpU
	Cp/W7XlmmTXvq3oatdufRU8YpCz1LoAnYKPQnjVN046gLrF5vxX3EnAuglOaCAaG89CCVl03RAX
	Ll0BO27271nO4ulZUz3kOPWAKnByW7g5QgoEdLqULameuj5N+sQ9jE8liHjG6nyfVDZVAKs5B7O
	7I+Vn/WmuqfDyRcXFw0sfeaw2bQYK3OcEpgc13UV5oHdop2AMCdPvQcqeTOnb9eWFDIGMbUipQN
	6w64OhBwfuQpkHd1FI4/8BfGPmCy5Fm6TUObj4Ej3Mb5ioGdf0Y/iwUPX7/jYkIUdlE=
X-Received: by 2002:a05:6402:2348:b0:6ac:813a:a1ef with SMTP id
 4fb4d7f45d1cf-6ae1993bcd1mr4364855a12.26.1790872358679; Thu, 01 Oct 2026
 09:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <20261001150935.655979-3-mszeredi@redhat.com>
In-Reply-To: <20261001150935.655979-3-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Oct 2026 18:32:27 +0200
X-Gm-Features: AclHuK8eTEc6STnpBDxfmRuKYDGoODXckCxazjNwWIfmWODp6sxlTPHn37GRHY0
Message-ID: <CAOQ4uxjQYaFUG=VT1LoKbs3QUTbTeEy3tTY=_FMujMiWGRR_=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] fuse: add helpers for EIO return value with kernel message
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, John Groves <john@groves.net>, 
	"Darrick J . Wong" <djwong@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 5:09=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> Conditions are triggered by a buggy fuse server will result in -EIO which
> is hard to interpret without any context.
>
> Add helpers that print a short message to the kernel log as well as
> returning the error value.  This serves a dual purpose:
>
>  - documents the error condition inside the code
>
>  - allows the implementor of the fuse server to get the context for the
>    error
>
> Some debug messages are removed in favor of this.
>
> This also changes the mmap return value from -ETXTBSY to -ENODEV if a
> passthrough open raced with the prior check.  This makes both cases retur=
n
> -ENODEV if the file is in passthrough mode.
>
> Additionally change the return value of fuse_inode_uncached_io_start() an=
d
> fuse_file_cached_io_open() from an error value to a bool (true on success=
)
> as the error value is translated anyway.
>
> Currently these use the pr_notice_once() variant.  Possibly should be
> changed to a ratelimit of e.g. once per minute.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/file.c        |  8 ++---
>  fs/fuse/fuse_i.h      |  6 ++--
>  fs/fuse/iomode.c      | 74 ++++++++++++++++---------------------------
>  fs/fuse/passthrough.c | 19 ++++-------
>  4 files changed, 42 insertions(+), 65 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 6d707f2b3bff..92976906ab05 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1478,7 +1478,7 @@ static void fuse_dio_lock(struct kiocb *iocb, struc=
t iov_iter *from,
>                  * have raced, so check it again.
>                  */
>                 if (fuse_io_past_eof(iocb, from) ||
> -                   fuse_inode_uncached_io_start(fi, NULL) !=3D 0) {
> +                   !fuse_inode_uncached_io_start(fi, NULL)) {
>                         inode_unlock_shared(inode);
>                         inode_lock(inode);
>                         *exclusive =3D true;
> @@ -2415,7 +2415,6 @@ static int fuse_file_mmap(struct file *file, struct=
 vm_area_struct *vma)
>         struct fuse_file *ff =3D file->private_data;
>         struct fuse_conn *fc =3D ff->fm->fc;
>         struct inode *inode =3D file_inode(file);
> -       int rc;
>
>         /* DAX mmap is superior to direct_io mmap */
>         if (FUSE_IS_VDAX(inode))
> @@ -2457,9 +2456,8 @@ static int fuse_file_mmap(struct file *file, struct=
 vm_area_struct *vma)
>                  * After first mmap, the inode stays in caching io mode u=
ntil
>                  * the direct_io file release.
>                  */
> -               rc =3D fuse_file_cached_io_open(inode, ff);
> -               if (rc)
> -                       return rc;
> +               if (!fuse_file_cached_io_open(inode, ff))
> +                       return -ENODEV;
>         }
>
>         if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 8546855386b5..3dd4dff24c50 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -11,6 +11,8 @@
>  # define pr_fmt(fmt) "fuse: " fmt
>  #endif
>
> +#define fuse_EIO(fmt, ...) (pr_notice_once("%s: " fmt "\n", __func__, ##=
__VA_ARGS__), -EIO)
> +
>  #include "args.h"
>  #include <linux/fuse.h>
>  #include <linux/fs.h>
> @@ -1251,8 +1253,8 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
>                       struct dentry *dentry, struct file_kattr *fa);
>
>  /* iomode.c */
> -int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
> -int fuse_inode_uncached_io_start(struct fuse_inode *fi,
> +bool fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff)=
;
> +bool fuse_inode_uncached_io_start(struct fuse_inode *fi,
>                                  struct fuse_backing *fb);
>  void fuse_inode_uncached_io_end(struct fuse_inode *fi);
>
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index 79637c09e883..1a10bc65fb31 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -27,15 +27,15 @@ static inline bool fuse_is_io_cache_wait(struct fuse_=
inode *fi)
>   * Blocks new parallel dio writes and waits for the in-progress parallel=
 dio
>   * writes to complete.
>   */
> -int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff)
> +bool fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff)
>  {
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
>
>         /* There are no io modes if server does not implement open */
>         if (!ff->args)
> -               return 0;
> +               return true;
>
> -       spin_lock(&fi->lock);
> +       guard(spinlock)(&fi->lock);
>         /*
>          * Setting the bit advises new direct-io writes to use an exclusi=
ve
>          * lock - without it the wait below might be forever.
> @@ -53,8 +53,7 @@ int fuse_file_cached_io_open(struct inode *inode, struc=
t fuse_file *ff)
>          */
>         if (fuse_inode_backing(fi)) {
>                 clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> -               spin_unlock(&fi->lock);
> -               return -ETXTBSY;
> +               return false;
>         }
>
>         WARN_ON(ff->iomode =3D=3D IOM_UNCACHED);
> @@ -64,8 +63,7 @@ int fuse_file_cached_io_open(struct inode *inode, struc=
t fuse_file *ff)
>                         set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>                 fi->iocachectr++;
>         }
> -       spin_unlock(&fi->lock);
> -       return 0;
> +       return true;
>  }
>
>  static void fuse_file_cached_io_release(struct fuse_file *ff,
> @@ -82,22 +80,19 @@ static void fuse_file_cached_io_release(struct fuse_f=
ile *ff,
>  }
>
>  /* Start strictly uncached io mode where cache access is not allowed */
> -int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_back=
ing *fb)
> +bool fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_bac=
king *fb)
>  {
>         struct fuse_backing *oldfb;
> -       int err =3D 0;
>
> -       spin_lock(&fi->lock);
> +       guard(spinlock)(&fi->lock);
>         /* deny conflicting backing files on same fuse inode */
>         oldfb =3D fuse_inode_backing(fi);
> -       if (fb && oldfb && oldfb !=3D fb) {
> -               err =3D -EBUSY;
> -               goto unlock;
> -       }
> -       if (fi->iocachectr > 0) {
> -               err =3D -ETXTBSY;
> -               goto unlock;
> -       }
> +       if (fb && oldfb && oldfb !=3D fb)
> +               return false;
> +
> +       if (fi->iocachectr > 0)
> +               return false;
> +
>         fi->iocachectr--;
>
>         /* fuse inode holds a single refcount of backing file */
> @@ -107,9 +102,7 @@ int fuse_inode_uncached_io_start(struct fuse_inode *f=
i, struct fuse_backing *fb)
>         } else {
>                 fuse_backing_put(fb);
>         }
> -unlock:
> -       spin_unlock(&fi->lock);
> -       return err;
> +       return true;
>  }
>
>  /* Takes uncached_io inode mode reference to be dropped on file release =
*/
> @@ -118,11 +111,9 @@ static int fuse_file_uncached_io_open(struct inode *=
inode,
>                                       struct fuse_backing *fb)
>  {
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> -       int err;
>
> -       err =3D fuse_inode_uncached_io_start(fi, fb);
> -       if (err)
> -               return err;
> +       if (!fuse_inode_uncached_io_start(fi, fb))
> +               return fuse_EIO("failed to start uncached I/O");

Why lose the internal error code?
If server implementation is wrong that is a good hint of what went wrong.
ETXTBSY is trying to mix cache mode and passthrough mode.
EBUSY is trying to passthrough to two different backing inodes.
I am not claiming this is a good API but at least we (or LLM) could do
something useful with this lost information.

>
>         WARN_ON(ff->iomode !=3D IOM_NONE);
>         ff->iomode =3D IOM_UNCACHED;
> @@ -173,9 +164,11 @@ static int fuse_file_passthrough_open(struct inode *=
inode, struct file *file)
>         int err;
>
>         /* Check allowed conditions for file open in passthrough mode */
> -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough ||
> -           (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK))
> -               return -EINVAL;
> +       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough)
> +               return fuse_EIO("passthrough not enabled");
> +
> +       if (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK)
> +               return fuse_EIO("conflicting open flags");
>
>         fb =3D fuse_passthrough_open(file, ff->args->open_outarg.backing_=
id);
>         if (IS_ERR(fb))
> @@ -208,11 +201,12 @@ int fuse_file_io_open(struct file *file, struct ino=
de *inode)
>
>         /*
>          * Server is expected to use FOPEN_PASSTHROUGH for all opens of a=
n inode
> -        * which is already open for passthrough.
> +        * which is already open for passthrough.  Using incorrect open m=
ode is
> +        * a server mistake, which results in user visible failure of ope=
n()
> +        * with EIO error.
>          */
> -       err =3D -EINVAL;
>         if (fuse_inode_backing(fi) && !(ff->open_flags & FOPEN_PASSTHROUG=
H))
> -               goto fail;
> +               return fuse_EIO("FOPEN_PASSTHROUGH expected");
>
>         /*
>          * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
> @@ -234,22 +228,10 @@ int fuse_file_io_open(struct file *file, struct ino=
de *inode)
>
>         if (ff->open_flags & FOPEN_PASSTHROUGH)
>                 err =3D fuse_file_passthrough_open(inode, file);
> -       else
> -               err =3D fuse_file_cached_io_open(inode, ff);
> -       if (err)
> -               goto fail;
> +       else if (!fuse_file_cached_io_open(inode, ff))
> +               err =3D fuse_EIO("conflicting passthrough open");

Same here.
If we can keep this bit of information and print it - it is helpful IMO,
even if we don't go all the way to annotate every error case with
a pretty log.

Thanks,
Amir.

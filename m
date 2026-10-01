Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB351DE03
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874591; cv=pass; b=PHJSSE8aDxc18xcA4tqA3qb/EkVemxXx1frKyDsD+uwb1qtoReGGGqv5ZEFU3pgzYZTcWNsPWHNxJNH8dxqlEZlEsfmtykah4XpXO8qvIKgMBFOdiBp/BnlvJNcoTHVvuy1N/rYi+H/yd4DxNCnin8z+LNcIoHIP04lh89/VS/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874591; c=relaxed/simple;
	bh=8GH8/SsNfmtkhdpX79c0aQcCb3/XRb8OtTW5xDOS0oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+aLnJqofUKLPvMryjFTVUYdAv/oWT990lMzdbmRSHbrtBPU08ovM0Qy1pLd1YVWJsSCb2g6vA4ImmAMTc/spNUlYS3AuhNXFfuh4WgpDLm5IKY30kqczG3wFac8E69KuX78ZDa0PgRJvQODxR3hjcpn98TTJpjQEtq7aQzoQRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdFob3cV; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdFob3cV"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6af7d408b51so646572a12.1
        for <linux-cxl@vger.kernel.org>; Thu, 01 Oct 2026 10:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790874585; cv=none;
        d=google.com; s=arc-20260327;
        b=ER/9H47L4H6MEo/MQPGU+SMUDj5HnoS4SzuQwNFHVE6GVPM5w0KoojTH0PbGKmXp50
         DBE+IdZC2UVnF7Ez2pukychtVz5ozlnRupuzO5s182/uMivZ6Wf+/X4bezEHPE7yJI+L
         vsrXrLWDfBwIJp85pi28zjtkWo7cUiJ+OvWQ3DBzz726MKX2xF08gYvByeeHxUgfr35N
         qBgfWU2neesDQ7TuRvyWQZv3jWfWMC3GlAojQs64TEKhWzupsQzImJNHQibq3OHA5AA/
         LdXfbIeJ6nE9LH2yQtJO6Zwe5rWeWclXiiNHnEKrISOry3lw9C7h4XvomaFdOpXoSEpD
         G6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aLFtAFtsh0QtLKb/lJ9Aky55k7s033R21zc2oLJYS2s=;
        fh=b50Kkz46+6U1N7YCrexaSgxFhrwIh85myBowQqm7880=;
        b=WgGjlV7Pw9zXUlv8C5homm1eFBK0S2kChzpB4TAK/Pc47UhasXDUWEBssQ8GKhtPyk
         hPxso+ttKq/Qg3mjpWTQbm79psAd4OAi0MXTWQpxl1q2bEewEl0cXI6yYd2Dlgl+vZri
         EUoIwng91ZkcjLXEePyKxar3suOIxoN9c2wY+p7LcJT3JCLjbn1O3S1KUYhCd+DB61yp
         DuqjM7PgzVViDrT+ltwxibZC5/UgaPB+mBQmkB4rGLoIEeS1jZLe+FxDQdsG6E5DOPnV
         obKW6DMpPrSmhY4gOKQ7qnWYGid0QkVefpMwNcaJXOPNmA97ieEMpzuQv6O6wsCQklng
         gigw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790874585; x=1791479385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aLFtAFtsh0QtLKb/lJ9Aky55k7s033R21zc2oLJYS2s=;
        b=fdFob3cVvRbAi0v3bNi02zzmHhkAc8HSgfr5/IgSgosAljWZckL652OFkGCcgj/JSC
         oXzPJd8kEXoaouRoI9HyuMKtdMXYUuMF53QwoORBT62uhTsjvYAmZ2hRCKJ0BeMajsKg
         jK7A6sRk3MR3K9ncv1dBvu2ZXtrzTYAsBM0m4RUQ5m2eH0NFms5JtRShswcv5xH48S+I
         lr2JhrGkCtEoV1aemEhutV+p/ocCIi7osxt/3NDSj1fioFdzoSuM4va+FmipiwVFQrij
         GP7Gd5xwV8NXh+ukwwSmDffbaSRWQXqwcCLENW1yXdJdhyySqFi69WZcVuJLajVN4Kl9
         Md7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790874585; x=1791479385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLFtAFtsh0QtLKb/lJ9Aky55k7s033R21zc2oLJYS2s=;
        b=fkMP05VmoyFGtfaFenA/vyh27znSw8Nf6hve+/nABL1OLUzWGZbjZbLfq313Nz47k9
         DD6zDC3wAon+JuQcGq40LbR0swUY5xd5gvXxY5r2K50oSG2TX8OeP0cT5QnQSP4KAoGL
         wuc9qSufbQ8+XNYp0HOazPlDYFlAFJUdSHVrkA5Y/+mYMsCeko5F0gn5zp1hL0jFTbD2
         3VpC8QVby/3ZhNvXMqhTgt5RfMv8/M+eNZWFdzkvr6zauDTn+6dU2wYaD8EXFBjBGMf5
         bBP2e85NeYD83HJFric2IzYfLJWaN8y67NzlIZMVxHU9IU0LPCcTvAm1XmZC8VI4IyCU
         0/6g==
X-Forwarded-Encrypted: i=1; AKwUvBx2JBNBLunH9ZjtkHhIBKrZ2x5OgSKZign/KWyFgnfVV+YmMgPSK0CdbvJ2NRAqSJL7R8XvDnQfMYU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI84jkGA3Rw9c6mhwf61Rr6XQhIlyPP9UvzYPrct0FA6A+RINA/
	5HmfqCgHtjrv8py3rgd6X/c/9yMDM0n2uqA6A8XjZJjBrtUBOR++moy2Fy7T3U3P6bQ8l0kEviO
	NcqXW+sn98yFc4cpzT2OrmaSRUr2dUok=
X-Gm-Gg: AYBFou20ped/cyVHpYDJ9j6R8bWBz6fAmY/MBcdpUPoqn8abo4DMa0dIlbyVUX1Xf6C
	CWpHBm9yeqs1W1mRfqy/Q6y6laV4YocRorWdbFsibclXq9f1ifVZgu9MWsYPTP6GY1feCP3f6MI
	Xv8tCnMgXhL8yH1KC5i9ID0diufhuRymrODeKUGx9PEX7iCtGjIKR9AWQmxdvv/+FcICphOl7rO
	KeXtUkRJw/g/B1ubfiY1ao1sgk+qDOlkswRFdDem0JL/OA09dfnrDx45R0zmohTweAwawnRr6+F
	eT1WomylqGOPhBjRjjfmaOc5X5LQfIj/seU6Rux+8htUIpqnIKZ7Lhi2
X-Received: by 2002:a05:6402:4342:b0:6ac:7d58:dbed with SMTP id
 4fb4d7f45d1cf-6ae3078464amr3051715a12.3.1790874585408; Thu, 01 Oct 2026
 10:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <20261001150935.655979-5-mszeredi@redhat.com>
In-Reply-To: <20261001150935.655979-5-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Oct 2026 19:09:32 +0200
X-Gm-Features: AclHuK9nuV0RaVWmbG-anRzzaRQN-OQPaWaI6T2wMRNbUW7396KBL-OwgCATbk4
Message-ID: <CAOQ4uxgyCo0-YAgwqu-3CAo+6hVOtSc9W1qJX5gZAz4YgpLM1Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] fuse: support opening 64 bit backing ID
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
> Add backing_id_64 field to fuse_open_out to allow opening files with
> 64-bit server-allocated backing IDs.
>
> When the server sets FUSE_BACKING_ID_64 in open_out.open_flags, the
> kernel reads the backing ID from open_out.backing_id_64 instead of
> open_out.backing_id.
>
> The open reply is now variable-length for backward compatibility with
> servers that don't send the new backing_id_64 field.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/dir.c             |  3 ++-
>  fs/fuse/file.c            |  6 +++++-
>  fs/fuse/fuse_i.h          |  2 +-
>  fs/fuse/iomode.c          | 34 ++++++++++++++++++++++++++++------
>  fs/fuse/passthrough.c     | 28 ++++++----------------------
>  include/uapi/linux/fuse.h |  2 ++
>  6 files changed, 44 insertions(+), 31 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f48fafccce4b..874ec7cfffb1 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -876,6 +876,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
struct inode *dir,
>         args.out_args[0].value =3D &outentry;
>         /* Store outarg for fuse_finish_open() */
>         outopenp =3D &ff->args->open_outarg;
> +       args.out_argvar =3D true; /* compat */
>         args.out_args[1].size =3D sizeof(*outopenp);
>         args.out_args[1].value =3D outopenp;
>
> @@ -885,7 +886,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
struct inode *dir,
>
>         err =3D fuse_simple_idmap_request(idmap, fm, &args);
>         free_ext_value(&args);
> -       if (err)
> +       if (err < 0)
>                 goto out_free_ff;
>
>         err =3D -EIO;
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 92976906ab05..1036c06fe35a 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -28,6 +28,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 no=
deid,
>  {
>         struct fuse_open_in inarg;
>         FUSE_ARGS(args);
> +       int res;
>
>         memset(&inarg, 0, sizeof(inarg));
>         inarg.flags =3D open_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
> @@ -45,10 +46,13 @@ static int fuse_send_open(struct fuse_mount *fm, u64 =
nodeid,
>         args.in_args[0].size =3D sizeof(inarg);
>         args.in_args[0].value =3D &inarg;
>         args.out_numargs =3D 1;
> +       args.out_argvar =3D true; /* compat */
>         args.out_args[0].size =3D sizeof(*outargp);
>         args.out_args[0].value =3D outargp;
>
> -       return fuse_simple_request(fm, &args);
> +       res =3D fuse_simple_request(fm, &args);
> +
> +       return res < 0 ? res : 0;
>  }
>
>  struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 003ef3c35d7a..59afebc3dd2b 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1314,7 +1314,7 @@ static inline struct fuse_backing *fuse_inode_backi=
ng_set(struct fuse_inode *fi,
>  #endif
>  }
>
> -struct fuse_backing *fuse_passthrough_open(struct file *file, int backin=
g_id);
> +int fuse_passthrough_open(struct file *file, struct fuse_backing *fb);
>  void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing =
*fb);
>
>  static inline bool fuse_is_passthrough(struct fuse_file *ff)
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index 1a10bc65fb31..811ea603b776 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -160,7 +160,9 @@ static int fuse_file_passthrough_open(struct inode *i=
node, struct file *file)
>  {
>         struct fuse_file *ff =3D file->private_data;
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
> +       struct fuse_open_out *outarg =3D &ff->args->open_outarg;
>         struct fuse_backing *fb;
> +       u64 backing_id;
>         int err;
>
>         /* Check allowed conditions for file open in passthrough mode */
> @@ -170,18 +172,38 @@ static int fuse_file_passthrough_open(struct inode =
*inode, struct file *file)
>         if (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK)
>                 return fuse_EIO("conflicting open flags");
>
> -       fb =3D fuse_passthrough_open(file, ff->args->open_outarg.backing_=
id);
> -       if (IS_ERR(fb))
> -               return PTR_ERR(fb);
> +       if (!fc->backing_id_64) {
> +               if (outarg->backing_id_64 !=3D 0)
> +                       return fuse_EIO("64 bit backing ID set");
> +
> +               backing_id =3D outarg->backing_id;
> +               if (backing_id <=3D 0)
> +                       return fuse_EIO("invalid backing ID");
> +       } else {
> +               if (outarg->backing_id !=3D 0)
> +                       return fuse_EIO("32 bit backing ID set");
> +
> +               backing_id =3D outarg->backing_id_64;
> +       }
> +       fb =3D fuse_backing_lookup(fc, backing_id);
> +       if (!fb)
> +               return fuse_EIO("backing not found");
> +
> +       err =3D fuse_passthrough_open(file, fb);
> +       if (err)
> +               goto backing_put;
>
>         /* First passthrough file open denies caching inode io mode */
>         err =3D fuse_file_uncached_io_open(inode, ff, fb);
> -       if (!err)
> -               return 0;
> +       if (err)
> +               goto passthrough_release;
> +
> +       return 0;
>
> +passthrough_release:
>         fuse_passthrough_release(ff, fb);
> +backing_put:
>         fuse_backing_put(fb);
> -
>         return err;
>  }
>
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 313c8d7ffc09..4894842ad6d0 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -150,41 +150,25 @@ ssize_t fuse_passthrough_mmap(struct file *file, st=
ruct vm_area_struct *vma)
>
>  /*
>   * Setup passthrough to a backing file.
> - *
> - * Returns an fb object with elevated refcount to be stored in fuse inod=
e.
>   */
> -struct fuse_backing *fuse_passthrough_open(struct file *file, int backin=
g_id)
> +int fuse_passthrough_open(struct file *file, struct fuse_backing *fb)
>  {
>         struct fuse_file *ff =3D file->private_data;
> -       struct fuse_conn *fc =3D ff->fm->fc;
> -       struct fuse_backing *fb =3D NULL;
>         struct file *backing_file;
>
> -       if (fc->backing_id_64)
> -               return ERR_PTR(fuse_EIO("incompatible backing version"));
> -
> -       if (backing_id <=3D 0)
> -               return ERR_PTR(fuse_EIO("invalid backing_id"));
> -
> -       fb =3D fuse_backing_lookup(fc, backing_id);
> -       if (!fb)
> -               return ERR_PTR(fuse_EIO("backing not found"));
> -
>         /* Allocate backing file per fuse file to store fuse path */
>         backing_file =3D backing_file_open(file, file->f_flags,
>                                          &fb->file->f_path, fb->cred);
> -       if (IS_ERR(backing_file)) {
> -               fuse_backing_put(fb);
> -               return ERR_PTR(fuse_EIO("failed to open backing file (%ld=
)", PTR_ERR(backing_file)));
> -       }
> +       if (IS_ERR(backing_file))
> +               return fuse_EIO("failed to open backing file (%ld)", PTR_=
ERR(backing_file));
>
>         ff->passthrough =3D backing_file;
>         ff->cred =3D get_cred(fb->cred);
>
> -       pr_debug("%s: backing_id=3D%d, fb=3D0x%p, backing_file=3D0x%p\n",=
 __func__,
> -                backing_id, fb, ff->passthrough);
> +       pr_debug("%s: backing_id=3D%llu, fb=3D0x%p, backing_file=3D0x%p\n=
", __func__,
> +                fb->backing_id, fb, ff->passthrough);
>
> -       return fb;
> +       return 0;
>  }
>
>  void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing =
*fb)
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c88d7094af44..60fb2add5e12 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -254,6 +254,7 @@
>   *  - add FUSE_PASSTHROUGH_V2
>   *  - add FUSE_DEV_IOC_BACKING_CREATE, struct fuse_backing_create_in
>   *  - add FUSE_NOTIFY_BACKING_REMOVE, struct fuse_notify_backing_remove_=
out
> + *  - add backing_id_64 to fuse_open_out
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -841,6 +842,7 @@ struct fuse_open_out {
>         uint64_t        fh;
>         uint32_t        open_flags;
>         int32_t         backing_id;
> +       uint64_t        backing_id_64;
>  };
>
>  struct fuse_release_in {
> --
> 2.54.0
>

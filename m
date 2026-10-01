Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778BB52269A
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874461; cv=pass; b=BL+tcbisiB3/7NV8R4djM0Dp2ep4xoPvNVmOZKMcfR8NWQaXZ71H32XUg/iNhH5ko3VdZavFv9ce5RIKly53CP4WfLWr9GSjapPtyvjNnkzosseBobLX8QrFKKyA1S6zZTQEuNBmUXNn5n3wXWvi9IrWg9Up//9jKc0GZMr/WlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874461; c=relaxed/simple;
	bh=r6TQ7LBFS6YQmbRDYcfO89HMMIOZCZKWiOUmeAO/hvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2Sf9Qjf0vWFp+Kz+vSkhuJmWNqYadoZ+QlExoWp4qPAvjoW+upajHa49wFiQQFtlKFsl6C1tIqIxJ9eMM9M435/1BGLmbZE2jxhdc9zMWKw8DOpa68AhBlAhFNGwmxylateouhcK6y7rTFrcohXx8HT5q+LuRS7/ivsv3t4UPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC9sNSF4; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC9sNSF4"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6aeeccb7d59so1424843a12.2
        for <linux-cxl@vger.kernel.org>; Thu, 01 Oct 2026 10:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790874451; cv=none;
        d=google.com; s=arc-20260327;
        b=f6BV5+KEnoStkfjb/eAz5BRL7x2EvG91jBpbWGRqdVQ0VRGSeDAOykDL3vsJEA3jx3
         6VQ7uGgRquHzOR6CWUOLHnOfd7JiX2iQ5PYXxk8EuA9OMZ1MCFtHFX0qvMhFKwp8tBB9
         llDEYUvDvVK02AqeOQENcd2X1usqi5QXVq0qBSa7GomOEjrPlKU9R6WYggNaYzOp8nyr
         mo9d6EeqKkGfaxOV4kkA6ELrKwqVv+f+r6zrNnl1WLXmTdUuyFMCGAjW/kHT4Q0Qixch
         w4V/3gbay0+MZkcrqAPUPjYqqEdQI4I9n3L7P5kU7GR+zh7DfBxd2CCgvJ/MSphqnzBa
         xj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w74hvbvNTGvr8lU1kwSwfbzXAOpjfYgg+VyuWdFqCFo=;
        fh=kJfhUsKojF83N9eSy2HTcDrS/Jco20zTOKuwTa0o0PA=;
        b=eIFNVoFYOXf001lsW3piQaOzRQRSv8pGcrffaAxbxB+p96fjqoy/++p4MOfqKR8u70
         xyyLJRWFedegMnnphuRZ/FTmyfB6cwIIzimBdEt3ltlciAdznpXWxnyX6JEBxOwObO0l
         ni5VzQXEq0/TRYYajioqHx+4yo05d6xl/PN8Z3LZ2Y3rql7lwjNBNJJeMgdPu9cvUM1V
         rYokD9fABrTsAvCfX6wagmylkqj82eB2tZigAYn+uA+TgSm/eywjQr2M+kouZfamipWH
         wls8pe5fthCidCXGpNDxh2IAPYr66LdSrtsp2x2qDdsCuDLmICCdsxljjM0xsJ2VaJE3
         iAnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790874451; x=1791479251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w74hvbvNTGvr8lU1kwSwfbzXAOpjfYgg+VyuWdFqCFo=;
        b=lC9sNSF4mqkD/kRL6iy2+R3KsuZPFYF1uwUeImQUauhhAIjbVNOzeE1YhwcUZiHfUW
         fMVlHZSDy4ysCezkBBt7JXi2PsJJ2EqQ75YhqCdgQJg+hmgF1j0sbNgJGixQwHkol3Bn
         tA4yuq7PgkmAt3ZF688+UjpwFbdkdUcQi0qmiu5ljwHS0+vfgtzpxj6Nf9HoZlW5IfgW
         QSw3mNmVbcCkSmuyJQzL+OCyFbSaen2//nvZlB+dRS9J5BPcZr0Q+2gduxyt9sl/q/fF
         EgH0eVDLrNfXpi388bdedyi9DYC/cYlC+OxF3+LMa/W3erOB8gz6INN4MzXKL7vgwNrj
         i7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790874451; x=1791479251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w74hvbvNTGvr8lU1kwSwfbzXAOpjfYgg+VyuWdFqCFo=;
        b=HHIYdnjJc8xoq+AT7uJOEsUiO6ZNOyAFwuL1FS83/SPs9viD4ANvurISjcBOhs9VsM
         4cj4noobQDsoRxCKJ8g1Lq+ZLzIdlGA0sI4wHWiFVnO+QtxENww1zOMSJ+4y62/BhwyU
         s1XwE3z5mEY/bX4YyGOebxHXcAPcp4DQVf1fyepdCjOH5FScmde2Rap1/s1w9b5zdZMD
         Nz9Kf/THz/jgBdp9j8CKOeNtWEaOJ5POay24fAibA3chfY5sgvLqOVIibRYylPR+StT7
         l5kthFf5rxGRTtGMZzAe0vfaCLYmDxpwX1ynwt3T6/xAUww9GBPpepgasHzDd51PnT/T
         YPTQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/JduSvsGv1N2GlodtVhskuRCF42HzLbHI+HiG1KSnCuJNPFkVKaOPr3Toj7oih/e9hDGu+jrauSU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8UAsx/d3HYHNKJE7J6cxUj+sVIhp1W84OryGWjIN3qnmHG7fI
	9vX7HoOJrHi314nDvQM+1ftTeZyW8p6hld9yhcelg8axxa/d6MVp4MLWGo5rl3xCy/qoOb9mOGF
	vRmKNjVmDxzvKtmK2qSiCGuf1iZPwE3o=
X-Gm-Gg: AYBFou2K/zR1o+ZGUD8DLANt0Vbm+ZYl6XwrbfuDBKFzURGOYlMAoWF/xZEmUlitLDz
	q3YSlPO12TUHDDiBZI2SFyduwNz0g8ZqK2UJ5tz2fg2z1PDVXMVFkPx5O8ZdiiX5gbJhzo2f2vl
	KjBNsI91gbeAJhGEmeYrUwaWLKfqZwYsnW5C8AsBY72LOcidu8tYXuL50Zr3VQgYN47H6RAnyP2
	CtbyIBbrDl48iNeHVO5uTJAEaeyFVfgOOR7kw4wJKgfB5Wm7mpx66mlzbF4wdfmZ7QIc+pTR5ZJ
	7zLUheYPNcT6hGCwoI1u2OYL+llveabjwIjav3jGi4F4h8CXFEJ0HfrA
X-Received: by 2002:a05:6402:304b:b0:6ac:73f8:2e40 with SMTP id
 4fb4d7f45d1cf-6ae1992a142mr3225411a12.27.1790874451190; Thu, 01 Oct 2026
 10:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <20261001150935.655979-4-mszeredi@redhat.com>
In-Reply-To: <20261001150935.655979-4-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Oct 2026 19:07:19 +0200
X-Gm-Features: AclHuK-0agDk93sgGY2m87PmGLxgE6-FRANPFMspwEa5RlpKXtEw5z3S6YImJvM
Message-ID: <CAOQ4uxjWCRs59Qpc4t+2=i67rdJkHt=+rH07ZXv7ZzAvTjTm-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] fuse: support 64 bit, server allocated backing ID
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
> Add support for server allocated 64-bit backing IDs alongside the
> existing kernel allocated 32-bit IDs.
>
> Opened with FUSE_DEV_IOC_BACKING_OPEN, but the backing ID is sent via
> fuse_backing_map.backing_id, with FUSE_BACKING_ID_64 being set in .flags.

Description outdated.

>
> Closed with FUSE_NOTIFY_BACKING_REMOVE.  Since close only provides the
> backing ID, not the file descriptor, it doesn't have to be done with an
> ioctl.
>
> All 64 bit values are valid.

Can you reserve id 0? or have a reason to need it?

>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/backing.c         | 180 ++++++++++++++++++++++++++++----------
>  fs/fuse/dev.c             |  21 +++++
>  fs/fuse/dev.h             |   3 +
>  fs/fuse/fuse_i.h          |  21 ++++-
>  fs/fuse/inode.c           |   6 +-
>  fs/fuse/notify.c          |  28 ++++++
>  fs/fuse/passthrough.c     |   3 +
>  include/uapi/linux/fuse.h |  22 ++++-
>  8 files changed, 231 insertions(+), 53 deletions(-)
>
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 433fa3098d71..3c879df7989c 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -9,6 +9,7 @@
>  #include "fuse_i.h"
>
>  #include <linux/file.h>
> +#include <linux/rhashtable.h>
>
>  static struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
>  {
> @@ -48,6 +49,8 @@ static int fuse_backing_id_alloc(struct fuse_conn *fc, =
struct fuse_backing *fb)
>         id =3D idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATO=
MIC);
>         spin_unlock(&fc->lock);
>         idr_preload_end();
> +       if (id > 0)
> +               fb->backing_id =3D id;
>
>         WARN_ON_ONCE(id =3D=3D 0);
>         return id;
> @@ -61,81 +64,131 @@ static struct fuse_backing *fuse_backing_id_remove(s=
truct fuse_conn *fc,
>         spin_lock(&fc->lock);
>         fb =3D idr_remove(&fc->backing_files_map, id);
>         spin_unlock(&fc->lock);
> +       if (fb)
> +               fb->backing_id =3D 0;
>
>         return fb;
>  }
>
> -static int fuse_backing_id_free(int id, void *p, void *data)
> -{
> -       struct fuse_backing *fb =3D p;
> +static const struct rhashtable_params fuse_backing_prm =3D {
> +       .head_offset =3D offsetof(struct fuse_backing, hash_node),
> +       .key_offset =3D offsetof(struct fuse_backing, backing_id),
> +       .key_len =3D sizeof_field(struct fuse_backing, backing_id),
> +};
>
> -       WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
> -       fuse_backing_free(fb);
> -       return 0;
> +static int fuse_backing_add_64(struct fuse_conn *fc, struct fuse_backing=
 *fb)
> +{
> +       return rhashtable_insert_fast(&fc->backing_64_ht, &fb->hash_node,=
 fuse_backing_prm);
>  }
>
> -void fuse_backing_files_free(struct fuse_conn *fc)
> +int fuse_backing_close_64(struct fuse_conn *fc, u64 backing_id)
>  {
> -       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
> -       idr_destroy(&fc->backing_files_map);
> +       struct fuse_backing *fb;
> +       int err;
> +
> +       if (!fc->backing_id_64)
> +               return -EINVAL;
> +
> +       scoped_guard(spinlock, &fc->lock) {
> +               fb =3D rhashtable_lookup_fast(&fc->backing_64_ht, &backin=
g_id, fuse_backing_prm);
> +               if (!fb)
> +                       return -ENOENT;
> +
> +               err =3D rhashtable_remove_fast(&fc->backing_64_ht, &fb->h=
ash_node, fuse_backing_prm);
> +               WARN_ON(err);
> +       }
> +       fb->backing_id =3D 0;
> +       fuse_backing_put(fb);
> +
> +       return 0;
>  }
>
> -int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map=
)
> +static struct fuse_backing *fuse_backing_new(struct fuse_conn *fc, int f=
d)
>  {
> -       struct file *file;
> +       struct fuse_backing *fb;
>         struct super_block *backing_sb;
> -       struct fuse_backing *fb =3D NULL;
> -       int res;
> -
> -       pr_debug("%s: fd=3D%d flags=3D0x%x\n", __func__, map->fd, map->fl=
ags);
> +       struct file *file;
>
>         /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> -       res =3D -EPERM;
>         if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> -               goto out;
> +               return ERR_PTR(-EPERM);
>
> -       res =3D -EINVAL;
> -       if (map->flags || map->padding)
> -               goto out;
> +       CLASS(fd_raw, f)(fd);
> +       if (fd_empty(f))
> +               return ERR_PTR(-EBADF);
>
> -       file =3D fget_raw(map->fd);
> -       res =3D -EBADF;
> -       if (!file)
> -               goto out;
> +       file =3D fd_file(f);
>
>         /* read/write/splice/mmap passthrough only relevant for regular f=
iles */
> -       res =3D d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
>         if (!d_is_reg(file->f_path.dentry))
> -               goto out_fput;
> +               return d_is_dir(file->f_path.dentry) ? ERR_PTR(-EISDIR) :=
 ERR_PTR(-EINVAL);
>
>         backing_sb =3D file_inode(file)->i_sb;
> -       res =3D -ELOOP;
>         if (backing_sb->s_stack_depth >=3D fc->max_stack_depth)
> -               goto out_fput;
> +               return ERR_PTR(-ELOOP);
>
>         fb =3D kmalloc_obj(struct fuse_backing);
> -       res =3D -ENOMEM;
>         if (!fb)
> -               goto out_fput;
> +               return ERR_PTR(-ENOMEM);
>
> -       fb->file =3D file;
> +       fb->file =3D get_file(file);
>         fb->cred =3D get_current_cred();
>         refcount_set(&fb->count, 1);
>
> -       res =3D fuse_backing_id_alloc(fc, fb);
> -       if (res < 0) {
> -               fuse_backing_free(fb);
> -               fb =3D NULL;
> +       return fb;
> +}
> +
> +int fuse_backing_open_64(struct fuse_conn *fc, struct fuse_backing_creat=
e_in *map)
> +{
> +       struct fuse_backing *fb;
> +       int res;
> +
> +       res =3D -EINVAL;
> +       if (map->padding || map->spare[0] || map->spare[1])

Please reserve backing_id 0

> +               goto out;
> +
> +       if (!fc->backing_id_64)
> +               goto out;
> +
> +       fb =3D fuse_backing_new(fc, map->fd);
> +       res =3D PTR_ERR(fb);
> +       if (!IS_ERR(fb)) {
> +               fb->backing_id =3D map->backing_id;
> +               res =3D fuse_backing_add_64(fc, fb);
> +               if (res < 0)
> +                       fuse_backing_free(fb);
>         }
> +out:
> +       return res;
> +}
> +
> +int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map=
)
> +{
> +       struct fuse_backing *fb =3D NULL;
> +       int res;
> +
> +       pr_debug("%s: fd=3D%d flags=3D0x%x\n", __func__, map->fd, map->fl=
ags);
>
> +       res =3D -EINVAL;
> +       if (map->flags || map->padding)
> +               goto out;
> +
> +       if (fc->backing_id_64)
> +               goto out;
> +
> +       fb =3D fuse_backing_new(fc, map->fd);
> +       res =3D PTR_ERR(fb);
> +       if (!IS_ERR(fb)) {
> +               res =3D fuse_backing_id_alloc(fc, fb);
> +               if (res < 0) {
> +                       fuse_backing_free(fb);
> +                       fb =3D NULL;
> +               }
> +       }
>  out:
>         pr_debug("%s: fb=3D0x%p, ret=3D%i\n", __func__, fb, res);
>
>         return res;
> -
> -out_fput:
> -       fput(file);
> -       goto out;
>  }
>
>  int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> @@ -145,6 +198,9 @@ int fuse_backing_close(struct fuse_conn *fc, int back=
ing_id)
>
>         pr_debug("%s: backing_id=3D%d\n", __func__, backing_id);
>
> +       if (fc->backing_id_64)
> +               return -EINVAL;
> +
>         /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
>         err =3D -EPERM;
>         if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> @@ -167,14 +223,48 @@ int fuse_backing_close(struct fuse_conn *fc, int ba=
cking_id)
>         return err;
>  }
>
> -struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backi=
ng_id)
> +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, u64 backi=
ng_id)
>  {
>         struct fuse_backing *fb;
>
> -       rcu_read_lock();
> -       fb =3D idr_find(&fc->backing_files_map, backing_id);
> -       fb =3D fuse_backing_get(fb);
> -       rcu_read_unlock();
> +       guard(rcu)();
> +       if (!fc->backing_id_64)
> +               fb =3D idr_find(&fc->backing_files_map, backing_id);
> +       else
> +               fb =3D rhashtable_lookup(&fc->backing_64_ht, &backing_id,=
 fuse_backing_prm);
>
> -       return fb;
> +       return fuse_backing_get(fb);
> +}
> +
> +static void fuse_backing_check_free(struct fuse_backing *fb)
> +{
> +       WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
> +       fuse_backing_free(fb);
> +}
> +
> +static int fuse_backing_idr_free(int id, void *p, void *data)
> +{
> +       fuse_backing_check_free(p);
> +       return 0;
> +}
> +
> +static void fuse_backing_rht_free(void *p, void *data)
> +{
> +       fuse_backing_check_free(p);
> +}
> +
> +void fuse_backing_files_free(struct fuse_conn *fc)
> +{
> +       if (fc->backing_id_64) {
> +               rhashtable_free_and_destroy(&fc->backing_64_ht, fuse_back=
ing_rht_free, NULL);
> +       } else {
> +               idr_for_each(&fc->backing_files_map, fuse_backing_idr_fre=
e, NULL);
> +               idr_destroy(&fc->backing_files_map);
> +       }
> +}
> +
> +void fuse_backing_files_init_64(struct fuse_conn *fc)
> +{
> +       rhashtable_init(&fc->backing_64_ht, &fuse_backing_prm);
> +       fc->backing_id_64 =3D true;
>  }
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 2d7ee5498f1c..8b63a08a26b6 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2339,6 +2339,24 @@ static long fuse_dev_ioctl_backing_open(struct fil=
e *file,
>         return fuse_backing_open(fud->chan->conn, &map);
>  }
>
> +static long fuse_dev_ioctl_backing_create(struct file *file,
> +                                         struct fuse_backing_create_in _=
_user *argp)
> +{
> +       struct fuse_dev *fud =3D fuse_get_dev(file);
> +       struct fuse_backing_create_in map;
> +
> +       if (IS_ERR(fud))
> +               return PTR_ERR(fud);
> +
> +       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +               return -EOPNOTSUPP;
> +
> +       if (copy_from_user(&map, argp, sizeof(map)))
> +               return -EFAULT;
> +
> +       return fuse_backing_open_64(fud->chan->conn, &map);
> +}
> +
>  static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user=
 *argp)
>  {
>         struct fuse_dev *fud =3D fuse_get_dev(file);
> @@ -2379,6 +2397,9 @@ static long fuse_dev_ioctl(struct file *file, unsig=
ned int cmd,
>         case FUSE_DEV_IOC_BACKING_OPEN:
>                 return fuse_dev_ioctl_backing_open(file, argp);
>
> +       case FUSE_DEV_IOC_BACKING_CREATE:
> +               return fuse_dev_ioctl_backing_create(file, argp);
> +
>         case FUSE_DEV_IOC_BACKING_CLOSE:
>                 return fuse_dev_ioctl_backing_close(file, argp);
>
> diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
> index f6c47ae0395b..dbffd5bed2f5 100644
> --- a/fs/fuse/dev.h
> +++ b/fs/fuse/dev.h
> @@ -14,6 +14,7 @@ struct fuse_dev;
>  struct fuse_args;
>  struct fuse_copy_state;
>  struct fuse_backing_map;
> +struct fuse_backing_create_in;
>  struct file;
>  struct folio;
>  enum fuse_notify_code;
> @@ -87,6 +88,8 @@ int fuse_notify(struct fuse_conn *fc, enum fuse_notify_=
code code,
>
>  int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map=
);
>  int fuse_backing_close(struct fuse_conn *fc, int backing_id);
> +int fuse_backing_open_64(struct fuse_conn *fc, struct fuse_backing_creat=
e_in *map);
> +int fuse_backing_close_64(struct fuse_conn *fc, u64 backing_id);
>
>  int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size);
>  int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 3dd4dff24c50..003ef3c35d7a 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -32,6 +32,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/refcount.h>
>  #include <linux/user_namespace.h>
> +#include <linux/rhashtable-types.h>
>
>  /** Default max number of pages that can be used in a single read reques=
t */
>  #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
> @@ -92,7 +93,8 @@ struct fuse_submount_lookup {
>  struct fuse_backing {
>         struct file *file;
>         const struct cred *cred;
> -
> +       u64 backing_id;
> +       struct rhash_head hash_node;
>         /* refcount */
>         refcount_t count;
>         struct rcu_head rcu;
> @@ -689,6 +691,9 @@ struct fuse_conn {
>         /** @init_security: Initialize security xattrs when creating a ne=
w inode */
>         unsigned int init_security:1;
>
> +       /** Backing ID is 64 bit and allocated by the server */
> +       bool backing_id_64:1;
> +
>         /**
>          * @create_supp_group: Add supplementary group info when creating
>          * a new inode
> @@ -770,8 +775,14 @@ struct fuse_conn {
>         struct fuse_sync_bucket __rcu *curr_bucket;
>
>  #ifdef CONFIG_FUSE_PASSTHROUGH
> -       /** @backing_files_map: IDR for backing files ids */
> -       struct idr backing_files_map;
> +       /* Selected by backing_id_64 */
> +       union {
> +               /** @backing_files_map: IDR for backing files ids */
> +               struct idr backing_files_map;
> +
> +               /** @backing_64_ht: 64 bit ID lookup hash table */
> +               struct rhashtable backing_64_ht;
> +       };
>  #endif
>  };
>
> @@ -1270,7 +1281,7 @@ void fuse_file_release(struct inode *inode, struct =
fuse_file *ff,
>  /* backing.c */
>  #ifdef CONFIG_FUSE_PASSTHROUGH
>  void fuse_backing_put(struct fuse_backing *fb);
> -struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backi=
ng_id);
> +
>  #else
>
>  static inline void fuse_backing_put(struct fuse_backing *fb)
> @@ -1278,7 +1289,9 @@ static inline void fuse_backing_put(struct fuse_bac=
king *fb)
>  }
>  #endif
>
> +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, u64 backi=
ng_id);
>  void fuse_backing_files_init(struct fuse_conn *fc);
> +void fuse_backing_files_init_64(struct fuse_conn *fc);
>  void fuse_backing_files_free(struct fuse_conn *fc);
>
>  /* passthrough.c */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index cbb10e19e7e8..bb76bddfc241 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1408,13 +1408,15 @@ static void process_init_reply(struct fuse_args *=
args, int error)
>                          * them together.
>                          */
>                         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
> -                           (flags & FUSE_PASSTHROUGH) &&
> +                           (flags & (FUSE_PASSTHROUGH | FUSE_PASSTHROUGH=
_V2)) &&
>                             arg->max_stack_depth > 0 &&
>                             arg->max_stack_depth <=3D FILESYSTEM_MAX_STAC=
K_DEPTH &&
>                             !(flags & FUSE_WRITEBACK_CACHE))  {
>                                 fc->passthrough =3D 1;
>                                 fc->max_stack_depth =3D arg->max_stack_de=
pth;
>                                 fm->sb->s_stack_depth =3D arg->max_stack_=
depth;
> +                               if (flags & FUSE_PASSTHROUGH_V2)
> +                                       fuse_backing_files_init_64(fc);

It would feel a little less hacky if we do:
    else
          fuse_backing_files_init_32(fc);

and set
         fc->passthrough =3D 1;

inside both of them to gate against fuse_backing_files_free()
called without processing init response,
or without either FUSE_PASSTHROUGH in the init response.

Thanks,
Amir.

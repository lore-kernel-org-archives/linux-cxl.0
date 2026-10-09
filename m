Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA147C0FA
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531421; cv=pass; b=d0un0TWWQ5zL9JftirG6iSnM+eiantlyhRYcgJ4Ww73JvUm+4IjuMef20iSzqYqNmu5SK0E//PIJyBWhthwN75eVEMmQLM/Tk7wHfuqxnVtksd/EBfofR4qJ0pn4kvkoGqmr2wNtQUoXnx/Ml52O6YgVMGe9yDAISs922Zr8D0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531421; c=relaxed/simple;
	bh=YMfKNylBb9GzxVIsFKNLxFRCTRDskPy0v9kUA3JZ0Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNeDLse7wlFsdCafvQOC9o2zQdv/G66dSH7DVnog8WVVIF1lroK1DyrqkNcfCd5bCWuu3AJpnX6dY6ApUb3IWm/uVPVFoBYg1e+vD8vWL/r6XpWgBDkD5VXtorvYnNUqjG0j2kIqBaeO5yr26TTPqU/EAWXzAmZ78Vgkti5dn2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8vBkkky; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8vBkkky"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso3779050a12.0
        for <linux-cxl@vger.kernel.org>; Fri, 09 Oct 2026 00:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791531418; cv=none;
        d=google.com; s=arc-20260327;
        b=svKSEmxYzTZ1hydxj/PSVnxQz9g60p4OnAPN2izVJtr3Lo4gjj3Yf8rO88aRcl4MGX
         bvzzCSN2pHIKdjRXE4IJRsC/CJZw9fcqTozSKoL4qXPSp9gMBNYjhjYyE+Z3+BjGcZ74
         4oyGJa/buWLV4kHvLROCcJLSHjy5s5TBxgLNWEne5rBt6QUVnQe0VWjjO62u9XIFx43u
         Mj8DWKEJABQIQw/lrM151VqPjzD80eiXDH01n1tWQD+l1KCJAoJgMCS9ML85lXkqdSQt
         iNXPWyWIn5E6U8BB4lW2DyK6suaewUeAEskHuN41gJsGEgsF4ZGD+cCqIiOp3Vt09Zt4
         YH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DhSjNxqbm4HcT9hh0RRIJr4WnJT+XPSewhpuWWrAjrI=;
        fh=TxzepEQXGkxnK/f9yReQk+78S7vPsScHZ1HNGK8ITmM=;
        b=TZr/sPZWzhkNAyjAvXMG4wrd2wRxRBk24C8QrHiVyI9uf/wdypMS0WpaMeYpWiapjY
         ak5ERwIqAPS9Ymhf7HMlChoVek7Gy42ZCsYiMyQNMMUuCY91UkfsCMfASviDrnqpNv8t
         X3AuwdfjnJwFtCzpVLuWpxidIHGjb9ZEX1Q11XGHX45MMwmTX21rf/EkUZ6WkczaNMZm
         LzHTSkby4eZNNNAOqcNLZoNGWxvn/vEp92c2hYKk3gJFvi2qt+SAuF6l8OnFFdkTR4dC
         OtbaFsAJQwdbjBg/lb1mf7aJ7gd270YIT9fqPjy4BIEk69bdu7niOsQ4hbx0YcKZ2t4X
         yKww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791531418; x=1792136218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DhSjNxqbm4HcT9hh0RRIJr4WnJT+XPSewhpuWWrAjrI=;
        b=o8vBkkkyjjW2weglXNMg6j2n5X33qHNouVKSf00EKGgBamExIAnR5h3rKbxPxqvYQo
         G1HS0sx/+xj2+e7L2k/gMBcRZHUZJxZ/oZhAjxpayqlQQjEAOJKKnfcsXi+Kmo5xxuK7
         8Nk+gPvDHNerPdlzmRArnaeO6FHf5qwecrQGbjEbxz2z6/KbKnWFb4SrtZD8OJMDw3ll
         D85y504IHg9Hmxo5cxQO1MWJb7ujJB7t2cLaVLmS++M/CyF6zhj2v7GuC5SvyU9mFmaI
         B3foVKnVbFYap+A4LvbSYnI+fSGwDfjZrVdaS3caiacNWgGGqEwjFXxUDfKmb+9IWPTM
         XRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791531418; x=1792136218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhSjNxqbm4HcT9hh0RRIJr4WnJT+XPSewhpuWWrAjrI=;
        b=dk9alT83E/aLLLNFtAgU8tvDsH3zjDMp/JOVwFK+lZ+evSjqLKt8heRM/uKDyZV8ju
         N47zZqBWhYPdfqkeJz7tXtpcyOSB0wcB2FsXkyWFrwmqTUQoueVmtiQrLO/95njheOoR
         OQKQV/6q40uqhvWIx+xKW4Z1gfKyD4+pp1VBPbGAsx3CdIr5UoAdXwVyayUz/SqOmwr4
         MNMtZwNsnjheL8E2KZFoRY0LVc2oBtxzGwWOjomKMLKSpOxlTiCxSDgccSTsuXQq5CK5
         x8f5Q6be6DODDnxxcs7JZewM5OM2rfAdGbtfO3mFISwtiU4I83qa0Q5koZGL60ECzMdE
         O2+g==
X-Forwarded-Encrypted: i=1; AKwUvBzWl2VQRPfd3uK77O04lwA8WcNR/OYOgMvmZU3PxgKTtKLazRjBdOp7KORMH7p2cWQG1BamnK9V6ek=@vger.kernel.org
X-Gm-Message-State: AFq9FYLC5lh0SGNQ1AXnIa9p1O2Bx62EyMI8a9TisgPWL8hl6kVjCVMy
	7J1JqUFIY8odf4yFastiaxEhlfmY6ozV//jWrwPthPC3BNurSG2QnYeJKjfJYQ/4LVylZaKNmBE
	LcjTKt37AuqUYSDb1OaXfVd6ZUvFeQWXO5/ubr70IKQ==
X-Gm-Gg: AYBFou20vbQgQnfTJzMXAmqy/2GjQRR4F742h2Wyn55iCl8Lp6wFyvTyPqk+hU3xLw3
	dEr5LmjcVko94KicQwFiG7vNBtAkJ7+B+uBZwlX/Ei3JIiZfXBt3XT47W0r/tA4QcDupNhfDHe5
	SnfMvpRxaFxklJN32bvNdJeLRiJz2ehWneg8rcW8n7hXg8fPPKGRi7CXy2W57pZ87tCmmvC9vhu
	jN+OaDwVJJYslRV/boj4oslkcqig3/GCGtdQngcdz46JkCRVdJGc3hak4x1TB8MHFsUGaefptH5
	vgIldJ5q/RVHgeuE5ricPYwP7IvU/Cjtdk8fWkj62UfB81YC9sm146no
X-Received: by 2002:a05:6402:5c8:b0:6ac:62aa:e3bc with SMTP id
 4fb4d7f45d1cf-6b17c2942a5mr781703a12.9.1791531417888; Fri, 09 Oct 2026
 00:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008112004.1899560-1-mszeredi@redhat.com> <20261008112004.1899560-5-mszeredi@redhat.com>
In-Reply-To: <20261008112004.1899560-5-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Oct 2026 09:36:45 +0200
X-Gm-Features: AclHuK_71_unbNtN5QAuP7E5DNG3AQphRS8x1gOfZa03ukUeAASAlNMwd4zqZhQ
Message-ID: <CAOQ4uxi5gLR5xUjmg5v_byPF1SUhzCv=iWT1xzNok3GTy09tZw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] fuse: support 64 bit, server allocated backing ID
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, John Groves <john@groves.net>, 
	"Darrick J . Wong" <djwong@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 1:20=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> Add support for server allocated 64-bit backing IDs alongside the
> existing kernel allocated 32-bit IDs.
>
> Opened with FUSE_DEV_IOC_BACKING_CREATE, the backing ID sent via
> fuse_backing_create_in.backing_id.
>
> Closed with FUSE_NOTIFY_BACKING_REMOVE.  Since close only provides the
> backing ID, not the file descriptor, it doesn't have to be done with an
> ioctl.
>
> Backing ID can take any 64 bit value other than zero.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/file.c                 |   1 +
>  fs/fuse/backing.c         | 178 ++++++++++++++++++++++++++++----------
>  fs/fuse/dev.c             |  54 +++++++++---
>  fs/fuse/dev.h             |   3 +
>  fs/fuse/fuse_i.h          |  21 ++++-
>  fs/fuse/inode.c           |   8 +-
>  fs/fuse/notify.c          |  28 ++++++
>  fs/fuse/passthrough.c     |   3 +
>  include/uapi/linux/fuse.h |  22 ++++-
>  9 files changed, 252 insertions(+), 66 deletions(-)
>
[...]

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
> index d9ec88028d7b..b1e450f096f6 100644
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
> @@ -713,6 +715,9 @@ struct fuse_conn {
>         /** @passthrough: Passthrough support for read/write IO */
>         unsigned int passthrough:1;
>
> +       /** @backing_id_64: Backing ID is 64 bit and allocated by the ser=
ver */
> +       bool backing_id_64:1;
> +
>         /** @use_pages_for_kvec_io: Use pages instead of pointer for kern=
el I/O */
>         unsigned int use_pages_for_kvec_io:1;
>
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
> index cbb10e19e7e8..b69c95ebb1ad 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1408,13 +1408,17 @@ static void process_init_reply(struct fuse_args *=
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
> +                               if (flags & FUSE_PASSTHROUGH_V2) {
> +                                       fc->backing_id_64 =3D true;
> +                                       fuse_backing_files_init_64(fc);
> +                               }
>                         }
>                         if (flags & FUSE_NO_EXPORT_SUPPORT)
>                                 fm->sb->s_export_op =3D &fuse_export_fid_=
operations;

Much better, but I still think it is somewhat ugly to call
fuse_backing_files_init_64()
after fuse_backing_files_init() for an init of a union.

Don't you think this is cleaner?

Thanks,
Amir.

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 330655af3bd0f..9abf6b1afef5d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -996,9 +996,6 @@ void fuse_conn_init(struct fuse_conn *fc, struct
fuse_mount *fm,
        fc->max_pages_limit =3D fuse_max_pages_limit;
        fc->name_max =3D FUSE_NAME_LOW_MAX;

-       if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
-               fuse_backing_files_init(fc);
-
        INIT_LIST_HEAD(&fc->mounts);
        list_add(&fm->fc_entry, &fc->mounts);
        fm->fc =3D fc;
@@ -1424,10 +1421,8 @@ static void process_init_reply(struct fuse_args
*args, int error)
                                fc->passthrough =3D 1;
                                fc->max_stack_depth =3D arg->max_stack_dept=
h;
                                fm->sb->s_stack_depth =3D arg->max_stack_de=
pth;
-                               if (flags & FUSE_PASSTHROUGH_V2) {
-                                       fc->backing_id_64 =3D true;
-                                       fuse_backing_files_init_64(fc);
-                               }
+                               fc->backing_id_64 =3D !!(flags &
FUSE_PASSTHROUGH_V2);
+                               fuse_backing_files_init(fc);
                        }
                        if (flags & FUSE_NO_EXPORT_SUPPORT)
                                fm->sb->s_export_op =3D
&fuse_export_fid_operations;
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index c93e4a45dd6f6..6157a18b5d554 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -46,11 +46,6 @@ void fuse_backing_put(struct fuse_backing *fb)
                fuse_backing_free(fb);
 }

-void fuse_backing_files_init(struct fuse_conn *fc)
-{
-       idr_init(&fc->backing_files_map);
-}
-
 static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing=
 *fb)
 {
        int id;
@@ -338,6 +333,9 @@ void fuse_backing_files_free(struct fuse_conn *fc)
        struct rhashtable_iter iter;
        struct fuse_backing *fb;

+       if (!fc->passthrough)
+               return;
+
        if (!fc->backing_id_64) {
                idr_for_each(&fc->backing_files_map,
fuse_backing_idr_free, NULL);
                idr_destroy(&fc->backing_files_map);
@@ -369,7 +367,12 @@ void fuse_backing_files_free(struct fuse_conn *fc)
        rhashtable_free_and_destroy(&fc->backing_64_ht,
fuse_backing_rht_free, NULL);
 }

-void fuse_backing_files_init_64(struct fuse_conn *fc)
+void fuse_backing_files_init(struct fuse_conn *fc)
 {
+       if (!fc->backing_id_64) {
+               idr_init(&fc->backing_files_map);
+               return;
+       }
+
        rhashtable_init(&fc->backing_64_ht, &fuse_backing_prm);
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 064fed459b93c..4235b8fc669b0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1324,7 +1324,6 @@ struct fuse_backing *fuse_backing_lookup(struct
fuse_conn *fc, u64 backing_id);
 int fuse_backing_add_64(struct fuse_conn *fc, struct fuse_backing *fb);
 bool fuse_backing_is_dax(struct fuse_backing *fb);
 void fuse_backing_files_init(struct fuse_conn *fc);
-void fuse_backing_files_init_64(struct fuse_conn *fc);
 void fuse_backing_files_free(struct fuse_conn *fc);

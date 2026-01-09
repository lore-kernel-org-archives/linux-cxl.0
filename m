Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39A22AE65
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982631; cv=none; b=GXDstCSDJXxggHwwohU/VKa7ZLFnWEq7+wGiTzfKRUoK/Pu18WLrAwvlHDlhWzsgtumUHwGj5sA7VCTqOROBP0JdPfAvIWVmJIZSn1Ssl6pjWgCQHvO2h6EG3M6UTkuOOp5P5CfmUR89dEugLLfPY11R0k8jaMqeGt+ubC8r0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982631; c=relaxed/simple;
	bh=wDQz4/9kZDqBRhEduIm0c9MYaFs+Pc7VcoLQiQYsc0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QM87W9uSdvkQ5M8YUp4fq5xonyTS5zJkZCEh6z1mGMiw9rcGCY1Vk8MKs1B7iCsB/mQYww6MUY+u4eejcw+8TmLMTpp83XJFVe/DcicS3z8GzDVokGQcV7qqZCvqKZg73ccmgOp4Bl2lICnfmz9vTHIVPMG/gHzFaCqINfj/n7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ88c9C6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ88c9C6"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed9c19248bso41899051cf.1
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767982628; x=1768587428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99Bs8S0fdZX8Ye9690VGi/t/MTR/ntJJl67b7rjD20M=;
        b=LQ88c9C6iNed7Qe8rYo5ZS0ISVDg6u+a0ZLwAUWCSE8jbuEEQDotbZePnKYV37HG+c
         9/930z9pF7H+duIy+jpqOeftxtzHQt1vZhCV/bevSkz0D6USDSKFPBIum62AMvTAGssM
         NDFNWzThIZWxwc2jYZUtLHiZAyUIgct09vemMmHbg9xdZpp9WeOKlFRk9D6U87PlnCST
         r8a8fRxIgD/+1x0IfI3xK4hvC5Kat7wAJaHEylAhYMeo5iOGgLZOwBiKNB79i6emfJl7
         tLl5ChvhvCu7oowvVlZ/2MPUL6dduoWImXWO54YC6HFTae02kXggro8/3uLRLRX/Z/ai
         D6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767982628; x=1768587428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=99Bs8S0fdZX8Ye9690VGi/t/MTR/ntJJl67b7rjD20M=;
        b=Arse02dbRfuZRjerwPY1MDkK+BcBJbti7QL6pUCLN0AiWkxc+3DPVzI9sCRl2vce+3
         5tHT/2FTggJfeDSh75llxdjzuV2TlEATgoEzYYZRq+PHnkS/0jyvOfryswj8svkFqQv9
         sRHgWbqPk3GvabVGGa9NeJA82HUK/65WTmj/sKW3CAJI1RbbTYPWvPMRLVH2U0u/UxcT
         UQVNsmbSyZ8HIDW5X00yDcz9DAMvj/DMXU8KEKoLJNENFKminLChOwOr1rHl2cnGh7pS
         bylWyhIPiEyYG34KG5fZTgd/ryzHsmkfCdui9nCzl5/dZqaI+6h8KpiA78+gkS8hoVjM
         V0iw==
X-Forwarded-Encrypted: i=1; AJvYcCUZbm7YHdooS70Jap7UYmhKtWDdWV71Ap1itXKWLTMWj/0GxUTobMEIFvqcYFRgw+reEFq+56gweTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cSn5AefSOv/bjerthTiMRBOrZlL4qz95GzFSdQWWZaAia6Sr
	ZSJBPgzR50lcPL2co1iCinszf0jK+CQgmdAWb3k6XNMDaHUCaqYq2XjGasX4F92NcHZ5S9MHjx5
	qJFE7VJQA8MGjio9/XaVhlQ3RdzUT8pw=
X-Gm-Gg: AY/fxX7H+6BySp2+gAAE53gv/DHGn1KAiHIFzyfhDxTWjSF7VG0bZ/kt9JwLvLH3W4/
	Jebx9+ThUOhXyfD+B22EBSs3JAs6DPx8wty4YME4D/sgkCvrFzs7rAGWnu776Wb7imEsO2EVg9B
	4bZSMS9M4eUUbaUdbYxiuchXmWTRKCfCHZZPwBotyrBVLqPAeSCDmJ5Vk3Tr06FEHIDIxvFJZgg
	2C5oyGYMPJRnmSwblHD9Hnm+k9iN+nMbJfR9EeiDj4RBymgHEeaOmCiO3mCBeQ8lT2+sBiv94Ri
	Pv/W
X-Google-Smtp-Source: AGHT+IH5+xJnp1a7PuWX1AlKsiRN99ozxNGtRWQ/qZ5RJUifdmvCatdxw6dSXGDWNttKbNDhIKFCmffMgnKYpiFNkIY=
X-Received: by 2002:a05:622a:1ba9:b0:4f4:ddff:b1b3 with SMTP id
 d75a77b69052e-4ffb494e23dmr156643501cf.22.1767982627972; Fri, 09 Jan 2026
 10:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107153244.64703-1-john@groves.net> <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-12-john@groves.net>
In-Reply-To: <20260107153332.64727-12-john@groves.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 9 Jan 2026 10:16:57 -0800
X-Gm-Features: AQt7F2ogZw-Qc2qKqJ80XJE7WwiTnLf-j6OBE6JHVL90Ak-M1koy9qRlA2GGgRc
Message-ID: <CAJnrk1ZxmryZQJhvesJET12xK8Hemir0uk6wojTty0NDvu1Xng@mail.gmail.com>
Subject: Re: [PATCH V3 11/21] famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
To: John Groves <John@groves.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:34=E2=80=AFAM John Groves <John@groves.net> wrote:
>
> Virtio_fs now needs to determine if an inode is DAX && not famfs.

nit: it was unclear to me why this patch changed the macro to take in
a struct fuse_inode until I looked at patch 14. it might be useful
here to add a line about that

>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/dir.c    |  2 +-
>  fs/fuse/file.c   | 13 ++++++++-----
>  fs/fuse/fuse_i.h |  6 +++++-
>  fs/fuse/inode.c  |  4 ++--
>  fs/fuse/iomode.c |  2 +-
>  5 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4b6b3d2758ff..1400c9d733ba 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2153,7 +2153,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct=
 dentry *dentry,
>                 is_truncate =3D true;
>         }
>
> -       if (FUSE_IS_DAX(inode) && is_truncate) {
> +       if (FUSE_IS_VIRTIO_DAX(fi) && is_truncate) {
>                 filemap_invalidate_lock(mapping);
>                 fault_blocked =3D true;
>                 err =3D fuse_dax_break_layouts(inode, 0, -1);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..093569033ed1 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -252,7 +252,7 @@ static int fuse_open(struct inode *inode, struct file=
 *file)
>         int err;
>         bool is_truncate =3D (file->f_flags & O_TRUNC) && fc->atomic_o_tr=
unc;
>         bool is_wb_truncate =3D is_truncate && fc->writeback_cache;
> -       bool dax_truncate =3D is_truncate && FUSE_IS_DAX(inode);
> +       bool dax_truncate =3D is_truncate && FUSE_IS_VIRTIO_DAX(fi);
>
>         if (fuse_is_bad(inode))
>                 return -EIO;
> @@ -1812,11 +1812,12 @@ static ssize_t fuse_file_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
>         struct file *file =3D iocb->ki_filp;
>         struct fuse_file *ff =3D file->private_data;
>         struct inode *inode =3D file_inode(file);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>
>         if (fuse_is_bad(inode))
>                 return -EIO;
>
> -       if (FUSE_IS_DAX(inode))
> +       if (FUSE_IS_VIRTIO_DAX(fi))
>                 return fuse_dax_read_iter(iocb, to);
>
>         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> @@ -1833,11 +1834,12 @@ static ssize_t fuse_file_write_iter(struct kiocb =
*iocb, struct iov_iter *from)
>         struct file *file =3D iocb->ki_filp;
>         struct fuse_file *ff =3D file->private_data;
>         struct inode *inode =3D file_inode(file);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>
>         if (fuse_is_bad(inode))
>                 return -EIO;
>
> -       if (FUSE_IS_DAX(inode))
> +       if (FUSE_IS_VIRTIO_DAX(fi))
>                 return fuse_dax_write_iter(iocb, from);
>
>         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> @@ -2370,10 +2372,11 @@ static int fuse_file_mmap(struct file *file, stru=
ct vm_area_struct *vma)
>         struct fuse_file *ff =3D file->private_data;
>         struct fuse_conn *fc =3D ff->fm->fc;
>         struct inode *inode =3D file_inode(file);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>         int rc;
>
>         /* DAX mmap is superior to direct_io mmap */
> -       if (FUSE_IS_DAX(inode))
> +       if (FUSE_IS_VIRTIO_DAX(fi))
>                 return fuse_dax_mmap(file, vma);
>
>         /*
> @@ -2934,7 +2937,7 @@ static long fuse_file_fallocate(struct file *file, =
int mode, loff_t offset,
>                 .mode =3D mode
>         };
>         int err;
> -       bool block_faults =3D FUSE_IS_DAX(inode) &&
> +       bool block_faults =3D FUSE_IS_VIRTIO_DAX(fi) &&
>                 (!(mode & FALLOC_FL_KEEP_SIZE) ||
>                  (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d1..17736c0a6d2f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1508,7 +1508,11 @@ void fuse_free_conn(struct fuse_conn *fc);
>
>  /* dax.c */
>
> -#define FUSE_IS_DAX(inode) (IS_ENABLED(CONFIG_FUSE_DAX) && IS_DAX(inode)=
)
> +/* This macro is used by virtio_fs, but now it also needs to filter for
> + * "not famfs"
> + */

Did you mean to add this comment to "patch 14/21: famfs_fuse: Plumb
the GET_FMAP message/response" instead? it seems like that's the patch
that adds the "&& !fuse_file_famfs(fuse_inode))" part to this.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

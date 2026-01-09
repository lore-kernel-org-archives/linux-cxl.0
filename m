Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B273451D7
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767996946; cv=none; b=LnmQyYQHGPeCvkEqstyYrEh7mJqrWfgz3V8MGnalXv5r65MtlsV8OhHXoC4a2TLajs9F75SuxA0H3TGwts8j+yoOuo6yJS4uKhyT22gCCh0ujbz7CyfHIHESO9/AQmCKWkMDRXloVzrWL1306bcMUPXk+98sLNZV7MmZ5xE0vSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767996946; c=relaxed/simple;
	bh=ItWZAUGEh6tnK87R9qTzUtVy5c9G5IfgZOB7PdDx76w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSkniBI43L89lWKlnQQCx0IhdvtHPjaJ3TW8w/k28TOCpJ3S8nQ/fR5y6ak/JjY41Kb7Oc7xoG92HsB61LKPQ+myMI+TBSibFS3xWAT0x9LbDcHK1mjiev/d8AGFjwjIabfWLfqcUbrJPDd+XdQQbxgNwIGJNlt3NLI27eymX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMXpLroF; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMXpLroF"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3f9e592af58so2879283fac.2
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 14:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767996943; x=1768601743; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsInap0TYjUJhuIYgyTfNATp9iw0wN/wAynfp2rVoTg=;
        b=dMXpLroF8PiS/q6OaGYYMm7s19cCP8DG9l4Id36oG9nNOpwnLJQ+9lagttQ1lj4MvL
         VPVgixf9RhQ9onGvpsOvkjJCNlfk1ZLAGJlQwJyOFDi2q0WwSyZnft88s4yDqfO9a8tp
         J1ya9WTkabqYIuYZ9Hz2SYkrVINDaG96oA4NLDxFadB09TJ/WARmYlrZhKFehE7yua67
         8XP1CnsoBk5v+3lT0OJ3CbZdkC3KULHDyTe8DjYFz0p5YP+WcQFtUYlxCe+PC9DM9B3q
         yPXCtKcZwl8EWsk7Z4PHXjFk6MpfURcvGlbj2Ubz3RWH69TptJBVG4uhl7F2P4i8/HtZ
         UGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767996943; x=1768601743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsInap0TYjUJhuIYgyTfNATp9iw0wN/wAynfp2rVoTg=;
        b=IMgcsJXIPB4cxEVYhPLTK5+wiLZFdDRLpVXnEIYH9HzIf4agu9JBM2F/lQDRLRkp+r
         eLT9DjeBX11jxhuWY6+24NB3kzbtokZRe5u9/uGdUyQQxR4TyaOUScgkA4Q+4XqN3EoN
         sK/Vd0oKgNXtjDK/acBpoo/efyOsML48C9yUjWDtw1FBEIXt5eTfPPfvC4bcW9m0yuNW
         FiZNxmdn9/ZFMBXUbA4KukkM+CadBoanzMLvk5VsnpqkSpZ606ZkO9EjSULr2pswn6Ae
         TBr4TWjShvysqQNYA8PMfqbhIcAHBDlWUFXNBdQ2rzFCoon3mxVRINBem3AsuwWJD8b6
         9oGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcpL0jCVU9Tt8V2JYHFWgfwY9Zh8KtGnZyGh8mIhHaIDtoB1laaWMdpRyUfVKedbERVsWf0kJZiVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRUWGbCupdPLvxc9l0ceeti48ZEZHznEc5IYPu00NId5+EcVsr
	eSLiUexLr1SuEBaeIOTgeHUYf6imtmcn+DSmJtdDQasGK+J0oJPYf16j
X-Gm-Gg: AY/fxX5bJnxM0yYTnpjVGKRFLoucvGQhu5N2OE4J2HzGM/Xwc2yygg7xWL56DUr74Pu
	xXpjlX8vXs95AmIoXbWs051kCqOSQdD0JOqN+25mbmd5qBq2DIX846uh8rIhTUbOptQZ3S77AGG
	Goii9eF5mVl39bAeqCKuwa3HFYa8ecOVMdO/rp4mTjHfBi759l7YH7NNKWmwRbvkrKvQVEuOBBQ
	A8eiPnwvoHy3HwGNe9MlZKhBjq7IJuiEBk/Co0MMYDoK9zXKUQ+inQBWawY1ofzxSvpGLawvoAU
	fPRWLk9/RjuGGuyGyJnoUa9LtpGXyV9WPUofBVM40NeJ1ku1VEpSASIaEqmklap1ekro0sQX6LU
	QRyd3fxllVlc8t7zyQ/mme+wz5iGl0fR6J24wwHa3WEbB/QFS8TytYx7ZHspisZWfZ9iIeYFZyF
	JcLntV+Or0Zy4QB2ZccVCBm+Ghe1hjfw==
X-Google-Smtp-Source: AGHT+IGeIXb/5HKhuPRt53VlHxR5e7TkKbTUESMzGZMkoiJYjOXEnJCEIvTH/DLOMpN4vbxz+vu/YA==
X-Received: by 2002:a05:6870:708c:b0:3ec:41eb:6e38 with SMTP id 586e51a60fabf-3ffc0b18aeemr5749038fac.38.1767996943253;
        Fri, 09 Jan 2026 14:15:43 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:184d:823f:1f40:e229])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4e3af4csm7798614fac.7.2026.01.09.14.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 14:15:42 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 9 Jan 2026 16:15:40 -0600
From: John Groves <John@groves.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
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
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 11/21] famfs_fuse: Update macro
 s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX
Message-ID: <mqfmngk6qjxhmxrbbpluzfbhhf2pkvzaintdiyy2kjy2ezgtnv@pascmnqloczj>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-12-john@groves.net>
 <CAJnrk1ZxmryZQJhvesJET12xK8Hemir0uk6wojTty0NDvu1Xng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZxmryZQJhvesJET12xK8Hemir0uk6wojTty0NDvu1Xng@mail.gmail.com>

On 26/01/09 10:16AM, Joanne Koong wrote:
> On Wed, Jan 7, 2026 at 7:34 AM John Groves <John@groves.net> wrote:
> >
> > Virtio_fs now needs to determine if an inode is DAX && not famfs.
> 
> nit: it was unclear to me why this patch changed the macro to take in
> a struct fuse_inode until I looked at patch 14. it might be useful
> here to add a line about that

Thanks Joanne; I beefed up the comment, and also added a dummy
fuse_file_famfs() macro so the new FUSE_IS_VIRTIO_DAX() macro shows
what it's gonna do. I should have done a better commit message...
Next rev will have a better one.

> 
> >
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/dir.c    |  2 +-
> >  fs/fuse/file.c   | 13 ++++++++-----
> >  fs/fuse/fuse_i.h |  6 +++++-
> >  fs/fuse/inode.c  |  4 ++--
> >  fs/fuse/iomode.c |  2 +-
> >  5 files changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 4b6b3d2758ff..1400c9d733ba 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -2153,7 +2153,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >                 is_truncate = true;
> >         }
> >
> > -       if (FUSE_IS_DAX(inode) && is_truncate) {
> > +       if (FUSE_IS_VIRTIO_DAX(fi) && is_truncate) {
> >                 filemap_invalidate_lock(mapping);
> >                 fault_blocked = true;
> >                 err = fuse_dax_break_layouts(inode, 0, -1);
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 01bc894e9c2b..093569033ed1 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -252,7 +252,7 @@ static int fuse_open(struct inode *inode, struct file *file)
> >         int err;
> >         bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
> >         bool is_wb_truncate = is_truncate && fc->writeback_cache;
> > -       bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
> > +       bool dax_truncate = is_truncate && FUSE_IS_VIRTIO_DAX(fi);
> >
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> > @@ -1812,11 +1812,12 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >         struct file *file = iocb->ki_filp;
> >         struct fuse_file *ff = file->private_data;
> >         struct inode *inode = file_inode(file);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> >
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> >
> > -       if (FUSE_IS_DAX(inode))
> > +       if (FUSE_IS_VIRTIO_DAX(fi))
> >                 return fuse_dax_read_iter(iocb, to);
> >
> >         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> > @@ -1833,11 +1834,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >         struct file *file = iocb->ki_filp;
> >         struct fuse_file *ff = file->private_data;
> >         struct inode *inode = file_inode(file);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> >
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> >
> > -       if (FUSE_IS_DAX(inode))
> > +       if (FUSE_IS_VIRTIO_DAX(fi))
> >                 return fuse_dax_write_iter(iocb, from);
> >
> >         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> > @@ -2370,10 +2372,11 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
> >         struct fuse_file *ff = file->private_data;
> >         struct fuse_conn *fc = ff->fm->fc;
> >         struct inode *inode = file_inode(file);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> >         int rc;
> >
> >         /* DAX mmap is superior to direct_io mmap */
> > -       if (FUSE_IS_DAX(inode))
> > +       if (FUSE_IS_VIRTIO_DAX(fi))
> >                 return fuse_dax_mmap(file, vma);
> >
> >         /*
> > @@ -2934,7 +2937,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
> >                 .mode = mode
> >         };
> >         int err;
> > -       bool block_faults = FUSE_IS_DAX(inode) &&
> > +       bool block_faults = FUSE_IS_VIRTIO_DAX(fi) &&
> >                 (!(mode & FALLOC_FL_KEEP_SIZE) ||
> >                  (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7f16049387d1..17736c0a6d2f 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1508,7 +1508,11 @@ void fuse_free_conn(struct fuse_conn *fc);
> >
> >  /* dax.c */
> >
> > -#define FUSE_IS_DAX(inode) (IS_ENABLED(CONFIG_FUSE_DAX) && IS_DAX(inode))
> > +/* This macro is used by virtio_fs, but now it also needs to filter for
> > + * "not famfs"
> > + */
> 
> Did you mean to add this comment to "patch 14/21: famfs_fuse: Plumb
> the GET_FMAP message/response" instead? it seems like that's the patch
> that adds the "&& !fuse_file_famfs(fuse_inode))" part to this.

The idea I was going for is for this commit to substitute the new macro name
(FUSE_IS_VIRTIO_DAX()) without otherwise changing functionality - and then
to plumb the famfs test later. 

The revised version of this commit adds a dummy test (fuse_file_famfs(inode)), so
it's more apparent what this commit is trying to do. So I hope it will make
more sense ;)
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> 
> Thanks,
> Joanne

Thanks Joanne!

John

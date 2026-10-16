Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4534DDB5D
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163859; cv=none; b=NTtleANDY1fmX0isB143E4pC1o560oSKl6ywXcmvdNJEmyXQN9ZaNtAbm2Wn39W4elcbvlpk1E/977iTBQ7wVqIWvfPfEmGnrtBKKWAdbhQmYTD4sjx7V5L1s/LT8X0yL/NXeDipAebUg9O4M02SXPFDVJBWhBVUiPWJE8w5a9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163859; c=relaxed/simple;
	bh=SNEbIkmqMRgdOsSg9KH5QVEk1C1VAe1U4QKbZuBRQdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=nvHgWQVYeNnaRUod/tXZDyNDBwhyg4gUY7BZzHldrwoi2R+d64TDBj41rdZgzeHLhy2ohzwEge/TvY1fToFPWBLeDMpzsWPgg//Mi5EmDRrah9ZCRhJ1GKA2TjibhO4UunCkLGqzJ/qfF4RjSkigMCj/1pTKrmwDVHBl3fW5Vqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBaRm5LZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBaRm5LZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792163854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pc3Xwl9t+j5CR2CMehADcG779mgFhsG3eyow0h9w7X0=;
	b=YBaRm5LZhiYaEMVAOm0xYYb2AnkM2EegOGaVn59s2v7kfXKSkRKtM0RkP8plx353sC3dR3
	HJymkDFuvcr/tvPZIZRhVpkH9ud82nrAO5T6zhh3G9+2dB4QEMxOM8MVinqYcry5o2pprG
	tT+V+e5Cxb2ycS1aCckSEIKvOb/GQGs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-EASg66pDNsm0sROzdtiY1Q-1; Fri, 16 Oct 2026 15:17:26 +0000
X-MC-Unique: EASg66pDNsm0sROzdtiY1Q-1
X-Mimecast-MFC-AGG-ID: EASg66pDNsm0sROzdtiY1Q_1792163846
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1d7663a4dso279985e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 08:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163845; x=1792768645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pc3Xwl9t+j5CR2CMehADcG779mgFhsG3eyow0h9w7X0=;
        b=p8XAfsISOEGsaK0jmXTPTpHehSRTxbI1l5FF/rUiC+6rP52La0QhRbDp7QOfYafkIv
         OSC+w3L9U/OhuNw+xScMRMS60oaJ85sqa5n0f8E4RjfK8AISQXrnlrm83NMs1tp3Dvy+
         fIwnHfcrabbqVTChff+9DXd6lVBY8S1zCE2q2nhcVi/zgRWQ6SSLQl2aLn09gkJUhVgz
         Q3xtlXa4JqBNNtzFI5jdZbgC09xK/+/FBpvM7u4bUDZFb9g78ruBmaQ2ZoEvRZnotazY
         ASBbBZii0IwDjKBbThk6bftUg3663uR1mFR0mwaf/HoFBDxmrNk/eYPdPBoYaQrJrzAt
         hk4A==
X-Forwarded-Encrypted: i=1; AKwUvBwUqBp1IPRl7htzpjNctfP1NyYWTMGzdZmTdEVA/919CbtkqE3zQicX5BONa3uVx8l4mYduv/BErAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLinp9UsX2q7j5kpho+veOs1oJrsBwaBECNdHOql0wUZGdsNYCM
	hUXlDhir7rbg6xYO0KTTbZ2xeYdkcg3adsF42f23bXd5qEn3QoDoez2r8hdQql8eCXyy/I01Ji+
	F5B2y2Hpxc2Mu0GEqtan7vhHAU7cwGSJMxmcQjIDcseFI8aE6AhB3FKCwgR2jhG6xdQKmpw==
X-Gm-Gg: AYBFou3gyA6yl3jITuZTJj4uZc9qiobG8I2SD6BM/RTS+t8t/Q93j0/C1Vcy1+gdSaX
	xEwwHQh5Mdl9n4ccVlR0H+4dz7XgR8MW7yFWQAdywU4cNKJmnFP2YjGieQjs+lqejBitd4PIjvF
	d/KulhwBJFebgGyLTQUaxc1N/H9W2Hr2ydk6r7zBZ1hPKrDtFkexDj83QFCee4ArnoYNMoJ/jTS
	zv08/Xyh66EHGeLf0WHoyyKPyrDQ0WE1jvPhPuAQTsk+DLUswI41xbHyThbROmJ+RiENELXw8/t
	H3yyDiURDA+pBep+/tNAE0jdvEameYWTkpttXYPr+H+c6Wk3lPhjJsQQsxM2RAhEvC96FlOc+y5
	VNP9RK7LyKXig6t2w+XlQRA==
X-Received: by 2002:a05:600c:3513:b0:4a1:d05d:2af7 with SMTP id 5b1f17b1804b1-4a1d7607497mr2488175e9.10.1792163845405;
        Fri, 16 Oct 2026 08:17:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:4a1:d05d:2af7 with SMTP id 5b1f17b1804b1-4a1d7607497mr2487545e9.10.1792163844944;
        Fri, 16 Oct 2026 08:17:24 -0700 (PDT)
Received: from maszat.com (85-67-2-18.pool.digikabel.hu. [85.67.2.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm64621665e9.14.2026.10.16.08.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:17:24 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: John Groves <john@groves.net>,
	Amir Goldstein <amir73il@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [PATCH v5 03/10] fuse: add helpers for EIO return value with kernel message
Date: Fri, 16 Oct 2026 17:16:30 +0200
Message-ID: <20261016151638.2962413-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016151638.2962413-1-mszeredi@redhat.com>
References: <20261016151638.2962413-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UVBvQvNqmKtvJsVJ535mK8ce4AVBJZ6xBkS2Q1uFSII_1792163846
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Conditions are triggered by a buggy fuse server will result in -EIO which
is hard to interpret without any context.

Add helpers that print a short message to the kernel log as well as
returning the error value.  This serves a dual purpose:

 - documents the error condition inside the code

 - allows the implementor of the fuse server to get the context for the
   error

Some debug messages are removed in favor of this.

This also changes the mmap return value from -ETXTBSY to -ENODEV if a
passthrough open raced with the prior check.  This makes both cases return
-ENODEV if the file is in passthrough mode.

Additionally change the return value of fuse_file_cached_io_open() from an
error value to a bool (true on success) as the error value is translated
anyway.

Currently these use the pr_notice_once() variant.  Possibly should be
changed to a ratelimit of e.g. once per minute.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c        |  6 ++--
 fs/fuse/fuse_i.h      |  4 ++-
 fs/fuse/iomode.c      | 75 ++++++++++++++++++-------------------------
 fs/fuse/passthrough.c | 19 ++++-------
 4 files changed, 43 insertions(+), 61 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d88fc2173c1f..eb04f08ac907 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2418,7 +2418,6 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
 	struct inode *inode = file_inode(file);
-	int rc;
 
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_VDAX(inode))
@@ -2460,9 +2459,8 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 		 * After first mmap, the inode stays in caching io mode until
 		 * the direct_io file release.
 		 */
-		rc = fuse_file_cached_io_open(inode, ff);
-		if (rc)
-			return rc;
+		if (!fuse_file_cached_io_open(inode, ff))
+			return -ENODEV;
 	}
 
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c917b1a7d695..950242b59709 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -11,6 +11,8 @@
 # define pr_fmt(fmt) "fuse: " fmt
 #endif
 
+#define fuse_EIO(fmt, ...) (pr_notice_once("%s: " fmt "\n", __func__, ##__VA_ARGS__), -EIO)
+
 #include "args.h"
 #include <linux/fuse.h>
 #include <linux/fs.h>
@@ -1251,7 +1253,7 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct file_kattr *fa);
 
 /* iomode.c */
-int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
+bool fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
 int fuse_inode_uncached_io_start(struct fuse_inode *fi,
 				 struct fuse_backing *fb);
 void fuse_inode_uncached_io_end(struct fuse_inode *fi);
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 79637c09e883..1b8b267d0c0d 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -27,15 +27,15 @@ static inline bool fuse_is_io_cache_wait(struct fuse_inode *fi)
  * Blocks new parallel dio writes and waits for the in-progress parallel dio
  * writes to complete.
  */
-int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff)
+bool fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* There are no io modes if server does not implement open */
 	if (!ff->args)
-		return 0;
+		return true;
 
-	spin_lock(&fi->lock);
+	guard(spinlock)(&fi->lock);
 	/*
 	 * Setting the bit advises new direct-io writes to use an exclusive
 	 * lock - without it the wait below might be forever.
@@ -53,8 +53,7 @@ int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff)
 	 */
 	if (fuse_inode_backing(fi)) {
 		clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
-		spin_unlock(&fi->lock);
-		return -ETXTBSY;
+		return false;
 	}
 
 	WARN_ON(ff->iomode == IOM_UNCACHED);
@@ -64,8 +63,7 @@ int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff)
 			set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
 		fi->iocachectr++;
 	}
-	spin_unlock(&fi->lock);
-	return 0;
+	return true;
 }
 
 static void fuse_file_cached_io_release(struct fuse_file *ff,
@@ -85,19 +83,16 @@ static void fuse_file_cached_io_release(struct fuse_file *ff,
 int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
 {
 	struct fuse_backing *oldfb;
-	int err = 0;
 
-	spin_lock(&fi->lock);
+	guard(spinlock)(&fi->lock);
 	/* deny conflicting backing files on same fuse inode */
 	oldfb = fuse_inode_backing(fi);
-	if (fb && oldfb && oldfb != fb) {
-		err = -EBUSY;
-		goto unlock;
-	}
-	if (fi->iocachectr > 0) {
-		err = -ETXTBSY;
-		goto unlock;
-	}
+	if (fb && oldfb && oldfb != fb)
+		return -EBUSY;
+
+	if (fi->iocachectr > 0)
+		return -ETXTBSY;
+
 	fi->iocachectr--;
 
 	/* fuse inode holds a single refcount of backing file */
@@ -107,9 +102,7 @@ int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
 	} else {
 		fuse_backing_put(fb);
 	}
-unlock:
-	spin_unlock(&fi->lock);
-	return err;
+	return 0;
 }
 
 /* Takes uncached_io inode mode reference to be dropped on file release */
@@ -121,8 +114,11 @@ static int fuse_file_uncached_io_open(struct inode *inode,
 	int err;
 
 	err = fuse_inode_uncached_io_start(fi, fb);
-	if (err)
-		return err;
+	if (err) {
+		if (err == -EBUSY)
+			return fuse_EIO("mismatched backing");
+		return fuse_EIO("conflicting caching mode");
+	}
 
 	WARN_ON(ff->iomode != IOM_NONE);
 	ff->iomode = IOM_UNCACHED;
@@ -173,9 +169,11 @@ static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
 	int err;
 
 	/* Check allowed conditions for file open in passthrough mode */
-	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough ||
-	    (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK))
-		return -EINVAL;
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough)
+		return fuse_EIO("passthrough not enabled");
+
+	if (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK)
+		return fuse_EIO("conflicting open flags");
 
 	fb = fuse_passthrough_open(file, ff->args->open_outarg.backing_id);
 	if (IS_ERR(fb))
@@ -197,7 +195,6 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	int err;
 
 	/*
 	 * io modes are not relevant with virtiofs DAX and with server that does not
@@ -208,11 +205,12 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 
 	/*
 	 * Server is expected to use FOPEN_PASSTHROUGH for all opens of an inode
-	 * which is already open for passthrough.
+	 * which is already open for passthrough.  Using incorrect open mode is
+	 * a server mistake, which results in user visible failure of open()
+	 * with EIO error.
 	 */
-	err = -EINVAL;
 	if (fuse_inode_backing(fi) && !(ff->open_flags & FOPEN_PASSTHROUGH))
-		goto fail;
+		return fuse_EIO("FOPEN_PASSTHROUGH expected");
 
 	/*
 	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
@@ -233,23 +231,12 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 		return 0;
 
 	if (ff->open_flags & FOPEN_PASSTHROUGH)
-		err = fuse_file_passthrough_open(inode, file);
-	else
-		err = fuse_file_cached_io_open(inode, ff);
-	if (err)
-		goto fail;
+		return fuse_file_passthrough_open(inode, file);
 
-	return 0;
+	if (!fuse_file_cached_io_open(inode, ff))
+		return fuse_EIO("conflicting passthrough open");
 
-fail:
-	pr_debug("failed to open file in requested io mode (open_flags=0x%x, err=%i).\n",
-		 ff->open_flags, err);
-	/*
-	 * The file open mode determines the inode io mode.
-	 * Using incorrect open mode is a server mistake, which results in
-	 * user visible failure of open() with EIO error.
-	 */
-	return -EIO;
+	return 0;
 }
 
 /* No more pending io and no new io possible to inode via open/mmapped file */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 12aaaf0a2bbb..a0eb52d1b743 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -172,34 +172,29 @@ struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_backing *fb = NULL;
 	struct file *backing_file;
-	int err;
 
-	err = -EINVAL;
 	if (backing_id <= 0)
-		goto out;
+		return ERR_PTR(fuse_EIO("invalid backing_id"));
 
-	err = -ENOENT;
 	fb = fuse_backing_lookup(fc, backing_id);
 	if (!fb)
-		goto out;
+		return ERR_PTR(fuse_EIO("backing not found"));
 
 	/* Allocate backing file per fuse file to store fuse path */
 	backing_file = backing_file_open(file, file->f_flags,
 					 &fb->file->f_path, fb->cred);
-	err = PTR_ERR(backing_file);
 	if (IS_ERR(backing_file)) {
 		fuse_backing_put(fb);
-		goto out;
+		return ERR_PTR(fuse_EIO("failed to open backing file (%ld)", PTR_ERR(backing_file)));
 	}
 
-	err = 0;
 	ff->passthrough = backing_file;
 	ff->cred = get_cred(fb->cred);
-out:
-	pr_debug("%s: backing_id=%d, fb=0x%p, backing_file=0x%p, err=%i\n", __func__,
-		 backing_id, fb, ff->passthrough, err);
 
-	return err ? ERR_PTR(err) : fb;
+	pr_debug("%s: backing_id=%d, fb=0x%p, backing_file=0x%p\n", __func__,
+		 backing_id, fb, ff->passthrough);
+
+	return fb;
 }
 
 void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb)
-- 
2.54.0


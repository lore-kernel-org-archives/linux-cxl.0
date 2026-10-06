Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001A391E6D
	for <linux-cxl@vger.kernel.org>; Tue,  6 Oct 2026 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309694; cv=none; b=XxgMH4VmzvItGIWPZqyO0tS76pO7Y/GE9yueq5V36OcJAA14uB+f3AwCsYu+G2s1wKxjjX0rzGUoTJxvggoeRYyOIz6+s4xlVCXgWP2iPpPbMByZjupzSekrq4A+XkeGub7HEI46VJa3ug1aPav+99Oydp5dTWAPyTMZPwCzV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309694; c=relaxed/simple;
	bh=bzFzopkZhQqBooj3zjPKDnml80xibuAqrHENP8B+i84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bL0XBWinxqJcUSYkP3zWDF/mBz/6SlzSjuMOVi81oV5ciq+srgdkzoiOYHjixzoNN6nC+Ug4g5QLXCPjDW5cs+F8MPW1VWlpwZ2Ye/hbExXxds0/9zJ446OxHxYoT0u+MgS1iagLDtJLa8YeQw77mVzJytdRUibjdE/Zz+p67t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGc2/QqU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGc2/QqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791309692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vk4gAN0pgQarl5/69zytCpbyum19vGUm6W+fTGEyNSc=;
	b=aGc2/QqUmqTg9O0mP7RH3rb0R2ikRKedjmgfF7TnLRWoJdjHAFRQLwAgwAiltQdQVYr46e
	ODNWrk6ltoICO/s0EWEyF+qSpzc+LShnNx5hH1FawBA769xgU9meT9CIFuoY7G7B/PHG68
	hP9rsQPLzpQDV5SWv0xtBJYcUklPsnI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-__wWcbASNESwxQSeMPs55A-1; Tue, 06 Oct 2026 14:01:31 -0400
X-MC-Unique: __wWcbASNESwxQSeMPs55A-1
X-Mimecast-MFC-AGG-ID: __wWcbASNESwxQSeMPs55A_1791309690
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a125f5b317so4376669a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 06 Oct 2026 11:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309690; x=1791914490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vk4gAN0pgQarl5/69zytCpbyum19vGUm6W+fTGEyNSc=;
        b=Qn88CNBAw6D/yZrrSniI9y3nLNtOfWzeXz7qKbNsmJFCv5N8tadoAbhzEiqxvjzGnc
         GhPxSlVb67ZSi3KYO1T4f5MtdEdA/A22/1gd32x3xGSyDM6zT0gnivo17tdsjsiH2FZd
         eWZvLOYfJUG6zszlZrgvBB93FJKQdiGNs1uInq0rA7l0jcl6ht73Xe5CKdefAkxysEKY
         bEutXwtdutcXsL10lGieTSO5Q8HYU5USF+dvaA+AmlmGmbDcVAbRU/uMiTE1dZzN7u7s
         2Lyk4xrtpHYxIByQrKS1ZE8TgZeLUn8fzKUQcl5L8YasfjKyEGV4bKEyjHFiS2hhuFnm
         2nWg==
X-Forwarded-Encrypted: i=1; AKwUvBwOVbDvFLT42NjNG/p+YlYkgZp5tlRnDTLAcDNRlARtNXgikf7W7ZJfyUuW6Yu0SSk9iun+eN7UT8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3pkCV4OnlwAPbTShgWu6QnNtnz2/doDkARHjZ7+pp5w3vGbTC
	KPTcWZhdfvRKLKfVYX1JuJCMydr3kqiRSm4AsZbmMOorjPRvE2k/rAG9HWqkFsnhum0GsOpTvMV
	IcSY6xhvsBtp/50lMfHtdaJKtMMhWelKK4gJ7amyAqYJhpBM1DMy26T/VohYeAg==
X-Gm-Gg: AYBFou17VMAjZTexNTWnmA10Nrv8GDD7b2XUbeVSAjiTKz4NvM+U0h5N18/j75TiDBq
	9DaqzbXyswDd614IqXgvMntXO/avA/zPeo58rXM+c/U6ateS+lzta4d9XOG5E4wJpoUkC7WdzwT
	W8p6X5Jyd6QHuGfI6OX4nwyOGGrzwpK1d9cAo7HRGkw4TnDYQfhNlXjKKHc1YYZr8dTmvTFaal3
	ZLx3Nme9ajViJV9TrZZcZHcf69Hlvdg3XEaZFfD9eGBWX7IdQDQ9lvw1MKwV6nb0mVmb0Gue7Rw
	bW4DyYST+1kXQCqNBlkQdCiv3eDjPIbreIqs8fLzxBZDEHxGv/RMl3nAYZh90002fnlaOPCFmsg
	gAyk4XulxLEa7WIV9hCysWK1RCYKbjcvmsVdBNw/UbZABhgG21SSxfhFt
X-Received: by 2002:a05:6402:a0ce:b0:6ae:550e:59ee with SMTP id 4fb4d7f45d1cf-6afe29e6656mr1806827a12.36.1791309689871;
        Tue, 06 Oct 2026 11:01:29 -0700 (PDT)
X-Received: by 2002:a05:6402:a0ce:b0:6ae:550e:59ee with SMTP id 4fb4d7f45d1cf-6afe29e6656mr1806814a12.36.1791309689452;
        Tue, 06 Oct 2026 11:01:29 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-152-55.pool.digikabel.hu. [188.142.152.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e5942sm5056684a12.9.2026.10.06.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:01:28 -0700 (PDT)
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
Subject: [PATCH v3 5/9] fuse: support opening 64 bit backing ID
Date: Tue,  6 Oct 2026 20:01:10 +0200
Message-ID: <20261006180115.1425232-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006180115.1425232-1-mszeredi@redhat.com>
References: <20261006180115.1425232-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A56QgQmfse70K3Ug3-ylzNVINulBsQYnI-gzFBCISUE_1791309690
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add backing_id_64 field to fuse_open_out to allow opening files with
64-bit server-allocated backing IDs.

If the connection was initialized with FUSE_PASSTHROUGH_V2, the kernel
reads the backing ID from open_out.backing_id_64 instead of
open_out.backing_id.

The open reply is now variable-length for backward compatibility with
servers that don't send the new backing_id_64 field.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c             |  3 ++-
 fs/fuse/file.c            |  6 +++++-
 fs/fuse/fuse_i.h          |  2 +-
 fs/fuse/iomode.c          | 35 +++++++++++++++++++++++++++++------
 fs/fuse/passthrough.c     | 28 ++++++----------------------
 include/uapi/linux/fuse.h |  2 ++
 6 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f48fafccce4b..874ec7cfffb1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -876,6 +876,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	args.out_args[0].value = &outentry;
 	/* Store outarg for fuse_finish_open() */
 	outopenp = &ff->args->open_outarg;
+	args.out_argvar = true; /* compat */
 	args.out_args[1].size = sizeof(*outopenp);
 	args.out_args[1].value = outopenp;
 
@@ -885,7 +886,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 
 	err = fuse_simple_idmap_request(idmap, fm, &args);
 	free_ext_value(&args);
-	if (err)
+	if (err < 0)
 		goto out_free_ff;
 
 	err = -EIO;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bde07948d1f0..5273957f0399 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -28,6 +28,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 {
 	struct fuse_open_in inarg;
 	FUSE_ARGS(args);
+	int res;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.flags = open_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
@@ -45,10 +46,13 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
 	args.out_numargs = 1;
+	args.out_argvar = true; /* compat */
 	args.out_args[0].size = sizeof(*outargp);
 	args.out_args[0].value = outargp;
 
-	return fuse_simple_request(fm, &args);
+	res = fuse_simple_request(fm, &args);
+
+	return res < 0 ? res : 0;
 }
 
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6def89667409..f34607eda2c0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1317,7 +1317,7 @@ static inline struct fuse_backing *fuse_inode_backing_set(struct fuse_inode *fi,
 #endif
 }
 
-struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id);
+int fuse_passthrough_open(struct file *file, struct fuse_backing *fb);
 void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb);
 
 static inline bool fuse_is_passthrough(struct fuse_file *ff)
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 1b8b267d0c0d..8b4774c80b11 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -165,7 +165,9 @@ static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_open_out *outarg = &ff->args->open_outarg;
 	struct fuse_backing *fb;
+	u64 backing_id;
 	int err;
 
 	/* Check allowed conditions for file open in passthrough mode */
@@ -175,18 +177,39 @@ static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
 	if (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK)
 		return fuse_EIO("conflicting open flags");
 
-	fb = fuse_passthrough_open(file, ff->args->open_outarg.backing_id);
-	if (IS_ERR(fb))
-		return PTR_ERR(fb);
+	if (!fc->backing_id_64) {
+		if (outarg->backing_id_64 != 0)
+			return fuse_EIO("64 bit backing ID set");
+
+		if (outarg->backing_id <= 0)
+			return fuse_EIO("invalid backing ID");
+
+		backing_id = outarg->backing_id;
+	} else {
+		if (outarg->backing_id != 0)
+			return fuse_EIO("32 bit backing ID set");
+
+		backing_id = outarg->backing_id_64;
+	}
+	fb = fuse_backing_lookup(fc, backing_id);
+	if (!fb)
+		return fuse_EIO("backing not found");
+
+	err = fuse_passthrough_open(file, fb);
+	if (err)
+		goto backing_put;
 
 	/* First passthrough file open denies caching inode io mode */
 	err = fuse_file_uncached_io_open(inode, ff, fb);
-	if (!err)
-		return 0;
+	if (err)
+		goto passthrough_release;
 
+	return 0;
+
+passthrough_release:
 	fuse_passthrough_release(ff, fb);
+backing_put:
 	fuse_backing_put(fb);
-
 	return err;
 }
 
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 313c8d7ffc09..4894842ad6d0 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -150,41 +150,25 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
 
 /*
  * Setup passthrough to a backing file.
- *
- * Returns an fb object with elevated refcount to be stored in fuse inode.
  */
-struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
+int fuse_passthrough_open(struct file *file, struct fuse_backing *fb)
 {
 	struct fuse_file *ff = file->private_data;
-	struct fuse_conn *fc = ff->fm->fc;
-	struct fuse_backing *fb = NULL;
 	struct file *backing_file;
 
-	if (fc->backing_id_64)
-		return ERR_PTR(fuse_EIO("incompatible backing version"));
-
-	if (backing_id <= 0)
-		return ERR_PTR(fuse_EIO("invalid backing_id"));
-
-	fb = fuse_backing_lookup(fc, backing_id);
-	if (!fb)
-		return ERR_PTR(fuse_EIO("backing not found"));
-
 	/* Allocate backing file per fuse file to store fuse path */
 	backing_file = backing_file_open(file, file->f_flags,
 					 &fb->file->f_path, fb->cred);
-	if (IS_ERR(backing_file)) {
-		fuse_backing_put(fb);
-		return ERR_PTR(fuse_EIO("failed to open backing file (%ld)", PTR_ERR(backing_file)));
-	}
+	if (IS_ERR(backing_file))
+		return fuse_EIO("failed to open backing file (%ld)", PTR_ERR(backing_file));
 
 	ff->passthrough = backing_file;
 	ff->cred = get_cred(fb->cred);
 
-	pr_debug("%s: backing_id=%d, fb=0x%p, backing_file=0x%p\n", __func__,
-		 backing_id, fb, ff->passthrough);
+	pr_debug("%s: backing_id=%llu, fb=0x%p, backing_file=0x%p\n", __func__,
+		 fb->backing_id, fb, ff->passthrough);
 
-	return fb;
+	return 0;
 }
 
 void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 37e9559783c3..4b3904b3acb7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -254,6 +254,7 @@
  *  - add FUSE_PASSTHROUGH_V2
  *  - add FUSE_DEV_IOC_BACKING_CREATE, struct fuse_backing_create_in
  *  - add FUSE_NOTIFY_BACKING_REMOVE, struct fuse_notify_backing_remove_out
+ *  - add backing_id_64 to fuse_open_out
  */
 
 #ifndef _LINUX_FUSE_H
@@ -841,6 +842,7 @@ struct fuse_open_out {
 	uint64_t	fh;
 	uint32_t	open_flags;
 	int32_t		backing_id;
+	uint64_t	backing_id_64;
 };
 
 struct fuse_release_in {
-- 
2.54.0


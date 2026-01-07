Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695F3933EA
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800057; cv=none; b=ELLmA8AH5P0bsDYX6t+waxQgbqbU6qzclyCMGZ/e+qa4S0neyeHI6lI/9pbFKpfm7cL9PlpEvAEMsyjbW3bh976LvoHTa5Uqh/vU81fWJRxL0z1tLhiR6NEtC1o6X0ucwutwHg/7gqFlIhvuv2wIZsrw0jS7s1RdBk+wdDD0EIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800057; c=relaxed/simple;
	bh=KDdIsA9D92H7U82UXu8uRfeAr/a85ssGj/h8ss0xZlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+AOqAZHqEiaPfbAMWLtkpP0oGcygdVsbv8EfEnFLsYKovKTJ/g0OXd7K1mj5ydU877/uQeMP3GmcW9pSGjNsHfUy+34QvTH0LyhYLvR2urMTlUl6Ry5ZgX1P6Wq57CUxiWJWtaGghNv0luI21y2GHUfd4aWNR15pFMVl3aMO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTSrqzPz; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTSrqzPz"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-455ddb90934so747816b6e.0
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800053; x=1768404853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBLWubQyI6xZVEp0jqdiIeZ2GXSmn2JLxEmTFZ45eqM=;
        b=UTSrqzPzZsLJoa+3EZGSx8ckaD7su+jBeOoFOF6p14d2SgZ5RoXejUYiX6UK0mSaJB
         67y2EbucQNS8YGAsyOrB308ZXNrS4hkgBz/HAoKqPau76rbZDNzjbN4L9A+jub+zhAiX
         6exFP0DGunPk+pHyobmuMzRkvCDhmjOThpqlxpYrrdvUYonF88ZKCAQXgakwxWCU9B6E
         ellAT2m+voJ+F9tET8rfwhDG78Ut/+yr+zqrhZUP02bakLr9c68Zakv8YFoRCJYVMe1h
         1hwix+Hmn9E3LlLWHwbTjCP6e3CKMCL3zv0AvtUvJyGyUijG5APTE+q9HE8qtPSKSRJz
         x2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800053; x=1768404853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBLWubQyI6xZVEp0jqdiIeZ2GXSmn2JLxEmTFZ45eqM=;
        b=IOo7HMD/HEpMGr77/fYvl99L07V3+XmT038c0KQyRcdCXX9gykIRTKVMbIdSlUeIXI
         jAhPI18A+1+Bgsv/42ynk6SRe7lYJ9uY+ey9J247BcjBC2qOyaEqT+oi+wqhbNgbK+Ky
         FcGSUmKXxnZFipyBiEGa2jf0J30uDip0yZcbd5/qg6xQTnwhuKos34wQeKm/nS/r2s6O
         mHKA+NEm20uGhdhH22L3m1JmpxM2V5uzQ4WzfPI/dlWHAcBJToNpeYxxCaNL5tkHWdXq
         b9QHqtmXFDsn9gjVwa1pX/OqKXCo7EesVtNWNJCENoWVasbxFOEJC6z0qec/o2DiciLj
         1leA==
X-Forwarded-Encrypted: i=1; AJvYcCV4l1Xszs2Mu8eT++KHWA6GuNf+oLOi8rxfNBmYs7SRzrWksa8uu5hTjX0q2BGeHpctbRRDFWy9++I=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRQBzWZ9A7rG7ecYXVlNhhzIZKxNKDy1mgQn4CA0olBUTy4pZ
	3uK5Q3UCOJX+ma+0c/+RFrN5r2QHRyJZ5D0ufY3nLBIzqyhGzhFhaVqf
X-Gm-Gg: AY/fxX4Unw6GGJqqkeLS3cQjO6v97/cyv0Ho0EG9rAmZhgVNKB2s7X4HbUPChup5xjq
	DMeUVPmt8bv9OfLGzBKfmVhHQoiUXIp0FeSG19pTJKwoZsLsDYl5h1TBEAUBKhq7LyUJtFZusVg
	EHyVdgLOkwo6OjWnP5ryffMBMrhojlurzrOyUdCR4t6Pn0SJ7/7m2xQcTwQxaV5rKtqAWdxmjxA
	5K3sLNedPJEgaMvYAgRbZiAaw2KyMwPBD3u4GuJjm+WOVj3EtHX5/Sj+8O2e3CVPfFYT2G++CS1
	aNWwKvhXrGgpNAeTjYtNZyGlxyrq8MEya7ocicPB1IRN72B9xT4D9PW0XCkUMbTddR6NBZQJsTI
	lTjvgJaAJkd7mVjsUgerYf224O3aBYoftaWmsawLKo5l92s4SOvdQ+L/Rs/dIYstKdNFWCAkHPt
	dziWyYFtuqzVd7AKJOn4LYAi2qAnxW9hcqlXX/L1zK3LAc
X-Google-Smtp-Source: AGHT+IFOd8s1wzfv2HGwBLfy7yoEMT8R9K3YpHqc6qg9LqPf5eknmZBY0Kt5yrjbMWCqtHbEQ9YNXw==
X-Received: by 2002:a05:6808:3206:b0:450:c6af:7c25 with SMTP id 5614622812f47-45a6bd8b7a2mr1331578b6e.21.1767800052873;
        Wed, 07 Jan 2026 07:34:12 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:12 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 11/21] famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
Date: Wed,  7 Jan 2026 09:33:20 -0600
Message-ID: <20260107153332.64727-12-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153332.64727-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio_fs now needs to determine if an inode is DAX && not famfs.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/file.c   | 13 ++++++++-----
 fs/fuse/fuse_i.h |  6 +++++-
 fs/fuse/inode.c  |  4 ++--
 fs/fuse/iomode.c |  2 +-
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff..1400c9d733ba 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2153,7 +2153,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		is_truncate = true;
 	}
 
-	if (FUSE_IS_DAX(inode) && is_truncate) {
+	if (FUSE_IS_VIRTIO_DAX(fi) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, -1);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..093569033ed1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -252,7 +252,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 	int err;
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
 	bool is_wb_truncate = is_truncate && fc->writeback_cache;
-	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
+	bool dax_truncate = is_truncate && FUSE_IS_VIRTIO_DAX(fi);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -1812,11 +1812,12 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (FUSE_IS_DAX(inode))
+	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_read_iter(iocb, to);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
@@ -1833,11 +1834,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (FUSE_IS_DAX(inode))
+	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_write_iter(iocb, from);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
@@ -2370,10 +2372,11 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
 	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	int rc;
 
 	/* DAX mmap is superior to direct_io mmap */
-	if (FUSE_IS_DAX(inode))
+	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_mmap(file, vma);
 
 	/*
@@ -2934,7 +2937,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.mode = mode
 	};
 	int err;
-	bool block_faults = FUSE_IS_DAX(inode) &&
+	bool block_faults = FUSE_IS_VIRTIO_DAX(fi) &&
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
 		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..17736c0a6d2f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1508,7 +1508,11 @@ void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */
 
-#define FUSE_IS_DAX(inode) (IS_ENABLED(CONFIG_FUSE_DAX) && IS_DAX(inode))
+/* This macro is used by virtio_fs, but now it also needs to filter for
+ * "not famfs"
+ */
+#define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)	\
+					&& IS_DAX(&fuse_inode->inode))
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 819e50d66622..ed667920997f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -162,7 +162,7 @@ static void fuse_evict_inode(struct inode *inode)
 	/* Will write inode on close/munmap and in all other dirtiers */
 	WARN_ON(inode_state_read_once(inode) & I_DIRTY_INODE);
 
-	if (FUSE_IS_DAX(inode))
+	if (FUSE_IS_VIRTIO_DAX(fi))
 		dax_break_layout_final(inode);
 
 	truncate_inode_pages_final(&inode->i_data);
@@ -170,7 +170,7 @@ static void fuse_evict_inode(struct inode *inode)
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
 
-		if (FUSE_IS_DAX(inode))
+		if (FUSE_IS_VIRTIO_DAX(fi))
 			fuse_dax_inode_cleanup(inode);
 		if (fi->nlookup) {
 			fuse_queue_forget(fc, fi->forget, fi->nodeid,
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 3728933188f3..31ee7f3304c6 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -203,7 +203,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * io modes are not relevant with DAX and with server that does not
 	 * implement open.
 	 */
-	if (FUSE_IS_DAX(inode) || !ff->args)
+	if (FUSE_IS_VIRTIO_DAX(fi) || !ff->args)
 		return 0;
 
 	/*
-- 
2.49.0


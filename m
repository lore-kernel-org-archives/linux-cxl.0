Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6337C0E2
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426866; cv=none; b=CRQx++Yg0eDKrXgGD2J6xUAr57KNSVQHM2XWbbzrI4O9+ypTQDlEUuuUw5J6H3xMszuJJhd38/dOk/iYN+5Mxs3VcyoqQ1MQIKqHDHGE1xkjMArCDYxxI0PdW1w7LvevSWToz7aihTjszKcRdkdswRIK+j+68wxs7wrgAJzpkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426866; c=relaxed/simple;
	bh=/kh1Sgm2clgVmf76DEI3esMCMcjpG7Yhbe8a3eLHZkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Op8JvPmjEN6yNLPikETENWkRoh37L+Vvm90YulNjcYE5oPPp9+9yMjaMsnwJnz2/c8qCK5mTv7Z9HfMaDl7WIpJVJoeloUsL61sbs8GLfH2Gtl/Qr2BJUGb0nlom31iiWkqOPflwLjkTZc8lnQxvBengcvKGCMzNCVKZge9cbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/L/3bxb; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/L/3bxb"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-661106487f9so44695eaf.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 13:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426826; x=1769031626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yiPfBlqoIwULclmP3td676+eN0ngcHpTfHhG4dLRD0=;
        b=K/L/3bxbOn1o6e27TMMduhpk4J0Nb28SUc6E1zL0y7/j8piBXVQrFuLvfUVl3MsnZ4
         a5X9I16dQmL10cv4k10erdXcnYN/JekgPkhi8OxK3uDjb2J78cS4YFHZxiA0Wjv8znzN
         ETyYlpbMnmAdRRC3OUo8MBI48D4C9hPSlPtCTBbc5N4629SHCXN9zcy7s/GlFxCoF9U4
         SDN/KxTWhlkZttVknmWXWc6imq9nxX2t8/G7V+ibuZRpRJYu2xnp0PPqUDE7VFrMHnwO
         1SK1zJTc5tmg+UvJPTWcO2qW6oOV9lnGbu6nzdxKM+zEhl9U4PuJ23uyZalT09l0Dzt7
         pwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426826; x=1769031626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yiPfBlqoIwULclmP3td676+eN0ngcHpTfHhG4dLRD0=;
        b=fCEQyPVaODe+mP1skWMYe9ryzV851OYRJ6PBPqtiK4n4dvOH2Ujax7wTsYK4nztjbw
         YGx0IifCmu8BnFx7AHIWNp4LkF+i1k+u3f5WGq5fL/4dKuRGdybTSxOkAu+ZY0GKC3CC
         s3ElcQmjon9uryLpjRqkUNm8sQhizbo+3WaEHJGdTa/Z1C9mMYMLdfnrCRHPgokS2yr5
         gXCaM3BibTHy5zhFIKZpWBe7M6xDv24mlpanZGRAlvwOijHNI9FsH4JP6NYWbtBoT3WC
         yxWG2cDFFhwaf/E0itgiB0B+55Px8vaFd3+PbrHhafKoP7YCzcfPom8okuKlFQrMWWue
         qH+w==
X-Forwarded-Encrypted: i=1; AJvYcCXWdhxmpFbB/oqOOpAVOfAAv7VG4d3LfkaiLHx7pkja3yXY15qweaqo4l31GWfSWo2zXPXhO6iMx4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGC23kwDgkAhlZGgoU5ltWnWOKg9gh/G9wdmYFziu7816WvW23
	aFcLS+aOho0XKwpSq22MTdkpnUe9DDCQk+ci0h75R646HsLqx3ZhgNOh
X-Gm-Gg: AY/fxX6OtU8V13+7PdcykLl9q+G+K02jeQM0kIyZ2sWy76u6IImkoXTm5q9dpwVo9Hg
	2nMcWqjExKFq/ZghYWHLcZ2Q+0gE0OH0l+hJqJS+PCS5aaDVQ7nwGeRzcSWgkzaz3lq5DPaMYCT
	dH1DoN5zoZoSPlviQ1+j6v5k9M16fI9HKn5KsZzPN7BeE2U9MSAcVQXNznfSNVRyNPahVAniILS
	TipJCwTybQsF5wMmWUHCNZgy0BZ2Bl72nLC4OLuJTWwpdWkKSrER+2Y6BlDG36FjHXcJIsjzseQ
	noygR5HgG9iu9/4Vqo+5NNzvGgI8XqKxXbdQFHTSS8oURcwLJUwOBXqoHftViHp6yuypg+1/sdv
	O/MtBEpN1Q8CcOfZLlJa64fz7DxY7Hxna6CSSXicWzPQmjVoGXp7q/O5GAdjjBgEFI5t6rf5Gz2
	X3QCaD755WxrdcFCuZ/WB/nW7IqlGRVkgrNjbbvA/pMDU22nGWPKDia/g=
X-Received: by 2002:a4a:d006:0:b0:65f:6d6c:52eb with SMTP id 006d021491bc7-6610063951bmr2371384eaf.19.1768426825908;
        Wed, 14 Jan 2026 13:40:25 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ccea34sm10445670eaf.13.2026.01.14.13.40.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:40:25 -0800 (PST)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 15/19] famfs_fuse: Plumb dax iomap and fuse read/write/mmap
Date: Wed, 14 Jan 2026 15:32:02 -0600
Message-ID: <20260114213209.29453-16-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fills in read/write/mmap handling for famfs files. The
dev_dax_iomap interface is used - just like xfs in fs-dax mode.

- Read/write are handled by famfs_fuse_[read|write]_iter() via
  dax_iomap_rw() to fsdev_dax.
- Mmap is handled by famfs_fuse_mmap()
- Faults are handled by famfs_filemap_fault(), using dax_iomap_fault()
  to fsdev_dax.
- File offset to dax offset resolution is handled via
  famfs_fuse_iomap_begin(), which uses famfs "fmaps" to resolve the
  the requested (file, offset) to an offset on a dax device (by way of
  famfs_fileofs_to_daxofs() and famfs_interleave_fileofs_to_daxofs())

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/famfs.c  | 443 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c   |  18 +-
 fs/fuse/fuse_i.h |  19 ++
 3 files changed, 478 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
index 438fc286d1a6..2de70aef1df8 100644
--- a/fs/fuse/famfs.c
+++ b/fs/fuse/famfs.c
@@ -574,6 +574,449 @@ famfs_file_init_dax(
 	return rc;
 }
 
+/*********************************************************************
+ * iomap_operations
+ *
+ * This stuff uses the iomap (dax-related) helpers to resolve file offsets to
+ * offsets within a dax device.
+ */
+
+static int famfs_file_bad(struct inode *inode);
+
+static int
+famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
+			 loff_t file_offset, off_t len, unsigned int flags)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct famfs_file_meta *meta = fi->famfs_meta;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	loff_t local_offset = file_offset;
+
+	/* This function is only for extent_type INTERLEAVED_EXTENT */
+	if (meta->fm_extent_type != INTERLEAVED_EXTENT) {
+		pr_err("%s: bad extent type\n", __func__);
+		goto err_out;
+	}
+
+	if (famfs_file_bad(inode))
+		goto err_out;
+
+	iomap->offset = file_offset;
+
+	for (int i = 0; i < meta->fm_niext; i++) {
+		struct famfs_meta_interleaved_ext *fei = &meta->ie[i];
+		u64 chunk_size = fei->fie_chunk_size;
+		u64 nstrips = fei->fie_nstrips;
+		u64 ext_size = min(ext_size, meta->file_size);
+
+		if (ext_size == 0) {
+			pr_err("%s: ext_size=%lld file_size=%ld\n",
+			       __func__, fei->fie_nbytes, meta->file_size);
+			goto err_out;
+		}
+
+		/* Is the data is in this striped extent? */
+		if (local_offset < ext_size) {
+			u64 chunk_num       = local_offset / chunk_size;
+			u64 chunk_offset    = local_offset % chunk_size;
+			u64 chunk_remainder = chunk_size - chunk_offset;
+			u64 stripe_num      = chunk_num / nstrips;
+			u64 strip_num       = chunk_num % nstrips;
+			u64 strip_offset    = chunk_offset + (stripe_num * chunk_size);
+			u64 strip_dax_ofs = fei->ie_strips[strip_num].ext_offset;
+			u64 strip_devidx = fei->ie_strips[strip_num].dev_index;
+
+			if (strip_devidx >= fc->dax_devlist->nslots) {
+				pr_err("%s: strip_devidx %llu >= nslots %d\n",
+				       __func__, strip_devidx,
+				       fc->dax_devlist->nslots);
+				goto err_out;
+			}
+
+			if (!fc->dax_devlist->devlist[strip_devidx].valid) {
+				pr_err("%s: daxdev=%lld invalid\n", __func__,
+					strip_devidx);
+				goto err_out;
+			}
+
+			iomap->addr    = strip_dax_ofs + strip_offset;
+			iomap->offset  = file_offset;
+			iomap->length  = min_t(loff_t, len, chunk_remainder);
+
+			iomap->dax_dev = fc->dax_devlist->devlist[strip_devidx].devp;
+
+			iomap->type    = IOMAP_MAPPED;
+			iomap->flags   = flags;
+
+			return 0;
+		}
+		local_offset -= ext_size; /* offset is beyond this striped extent */
+	}
+
+ err_out:
+	pr_err("%s: err_out\n", __func__);
+
+	/* We fell out the end of the extent list.
+	 * Set iomap to zero length in this case, and return 0
+	 * This just means that the r/w is past EOF
+	 */
+	iomap->addr    = 0; /* there is no valid dax device offset */
+	iomap->offset  = file_offset; /* file offset */
+	iomap->length  = 0; /* this had better result in no access to dax mem */
+	iomap->dax_dev = NULL;
+	iomap->type    = IOMAP_MAPPED;
+	iomap->flags   = flags;
+
+	return -EIO;
+}
+
+/**
+ * famfs_fileofs_to_daxofs() - Resolve (file, offset, len) to (daxdev, offset, len)
+ *
+ * This function is called by famfs_fuse_iomap_begin() to resolve an offset in a
+ * file to an offset in a dax device. This is upcalled from dax from calls to
+ * both  * dax_iomap_fault() and dax_iomap_rw(). Dax finishes the job resolving
+ * a fault to a specific physical page (the fault case) or doing a memcpy
+ * variant (the rw case)
+ *
+ * Pages can be PTE (4k), PMD (2MiB) or (theoretically) PuD (1GiB)
+ * (these sizes are for X86; may vary on other cpu architectures
+ *
+ * @inode:  The file where the fault occurred
+ * @iomap:       To be filled in to indicate where to find the right memory,
+ *               relative  to a dax device.
+ * @file_offset: Within the file where the fault occurred (will be page boundary)
+ * @len:         The length of the faulted mapping (will be a page multiple)
+ *               (will be trimmed in *iomap if it's disjoint in the extent list)
+ * @flags:       flags passed to famfs_fuse_iomap_begin(), and sent back via
+ *               struct iomap
+ *
+ * Return values: 0. (info is returned in a modified @iomap struct)
+ */
+static int
+famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
+			loff_t file_offset, off_t len, unsigned int flags)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct famfs_file_meta *meta = fi->famfs_meta;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	loff_t local_offset = file_offset;
+
+	if (!fc->dax_devlist) {
+		pr_err("%s: null dax_devlist\n", __func__);
+		goto err_out;
+	}
+
+	if (famfs_file_bad(inode))
+		goto err_out;
+
+	if (meta->fm_extent_type == INTERLEAVED_EXTENT)
+		return famfs_interleave_fileofs_to_daxofs(inode, iomap,
+							  file_offset,
+							  len, flags);
+
+	iomap->offset = file_offset;
+
+	for (int i = 0; i < meta->fm_nextents; i++) {
+		/* TODO: check devindex too */
+		loff_t dax_ext_offset = meta->se[i].ext_offset;
+		loff_t dax_ext_len    = meta->se[i].ext_len;
+		u64 daxdev_idx = meta->se[i].dev_index;
+
+
+		/* TODO: test that superblock and log offsets only happen
+		 * with superblock and log files. Requires instrumentaiton
+		 * from user space...
+		 */
+
+		/* local_offset is the offset minus the size of extents skipped
+		 * so far; If local_offset < dax_ext_len, the data of interest
+		 * starts in this extent
+		 */
+		if (local_offset < dax_ext_len) {
+			loff_t ext_len_remainder = dax_ext_len - local_offset;
+			struct famfs_daxdev *dd;
+
+			if (daxdev_idx >= fc->dax_devlist->nslots) {
+				pr_err("%s: daxdev_idx %llu >= nslots %d\n",
+				       __func__, daxdev_idx,
+				       fc->dax_devlist->nslots);
+				goto err_out;
+			}
+
+			dd = &fc->dax_devlist->devlist[daxdev_idx];
+
+			if (!dd->valid || dd->error) {
+				pr_err("%s: daxdev=%lld %s\n", __func__,
+				       daxdev_idx,
+				       dd->valid ? "error" : "invalid");
+				goto err_out;
+			}
+
+			/*
+			 * OK, we found the file metadata extent where this
+			 * data begins
+			 * @local_offset      - The offset within the current
+			 *                      extent
+			 * @ext_len_remainder - Remaining length of ext after
+			 *                      skipping local_offset
+			 * Outputs:
+			 * iomap->addr:   the offset within the dax device where
+			 *                the  data starts
+			 * iomap->offset: the file offset
+			 * iomap->length: the valid length resolved here
+			 */
+			iomap->addr    = dax_ext_offset + local_offset;
+			iomap->offset  = file_offset;
+			iomap->length  = min_t(loff_t, len, ext_len_remainder);
+
+			iomap->dax_dev = fc->dax_devlist->devlist[daxdev_idx].devp;
+
+			iomap->type    = IOMAP_MAPPED;
+			iomap->flags   = flags;
+			return 0;
+		}
+		local_offset -= dax_ext_len; /* Get ready for the next extent */
+	}
+
+ err_out:
+	pr_err("%s: err_out\n", __func__);
+
+	/* We fell out the end of the extent list.
+	 * Set iomap to zero length in this case, and return 0
+	 * This just means that the r/w is past EOF
+	 */
+	iomap->addr    = 0; /* there is no valid dax device offset */
+	iomap->offset  = file_offset; /* file offset */
+	iomap->length  = 0; /* this had better result in no access to dax mem */
+	iomap->dax_dev = NULL;
+	iomap->type    = IOMAP_MAPPED;
+	iomap->flags   = flags;
+
+	return -EIO;
+}
+
+/**
+ * famfs_fuse_iomap_begin() - Handler for iomap_begin upcall from dax
+ *
+ * This function is pretty simple because files are
+ * * never partially allocated
+ * * never have holes (never sparse)
+ * * never "allocate on write"
+ *
+ * @inode:  inode for the file being accessed
+ * @offset: offset within the file
+ * @length: Length being accessed at offset
+ * @flags:  flags to be retured via struct iomap
+ * @iomap:  iomap struct to be filled in, resolving (offset, length) to
+ *          (daxdev, offset, len)
+ * @srcmap: source mapping if it is a COW operation (which it is not here)
+ */
+static int
+famfs_fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		  unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct famfs_file_meta *meta = fi->famfs_meta;
+	size_t size;
+
+	size = i_size_read(inode);
+
+	WARN_ON(size != meta->file_size);
+
+	return famfs_fileofs_to_daxofs(inode, iomap, offset, length, flags);
+}
+
+/* Note: We never need a special set of write_iomap_ops because famfs never
+ * performs allocation on write.
+ */
+const struct iomap_ops famfs_iomap_ops = {
+	.iomap_begin		= famfs_fuse_iomap_begin,
+};
+
+/*********************************************************************
+ * vm_operations
+ */
+static vm_fault_t
+__famfs_fuse_filemap_fault(struct vm_fault *vmf, unsigned int pe_size,
+		      bool write_fault)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	vm_fault_t ret;
+	unsigned long pfn;
+
+	if (!IS_DAX(file_inode(vmf->vma->vm_file))) {
+		pr_err("%s: file not marked IS_DAX!!\n", __func__);
+		return VM_FAULT_SIGBUS;
+	}
+
+	if (write_fault) {
+		sb_start_pagefault(inode->i_sb);
+		file_update_time(vmf->vma->vm_file);
+	}
+
+	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &famfs_iomap_ops);
+	if (ret & VM_FAULT_NEEDDSYNC)
+		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
+
+	if (write_fault)
+		sb_end_pagefault(inode->i_sb);
+
+	return ret;
+}
+
+static inline bool
+famfs_is_write_fault(struct vm_fault *vmf)
+{
+	return (vmf->flags & FAULT_FLAG_WRITE) &&
+	       (vmf->vma->vm_flags & VM_SHARED);
+}
+
+static vm_fault_t
+famfs_filemap_fault(struct vm_fault *vmf)
+{
+	return __famfs_fuse_filemap_fault(vmf, 0, famfs_is_write_fault(vmf));
+}
+
+static vm_fault_t
+famfs_filemap_huge_fault(struct vm_fault *vmf, unsigned int pe_size)
+{
+	return __famfs_fuse_filemap_fault(vmf, pe_size,
+					  famfs_is_write_fault(vmf));
+}
+
+static vm_fault_t
+famfs_filemap_mkwrite(struct vm_fault *vmf)
+{
+	return __famfs_fuse_filemap_fault(vmf, 0, true);
+}
+
+const struct vm_operations_struct famfs_file_vm_ops = {
+	.fault		= famfs_filemap_fault,
+	.huge_fault	= famfs_filemap_huge_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= famfs_filemap_mkwrite,
+	.pfn_mkwrite	= famfs_filemap_mkwrite,
+};
+
+/*********************************************************************
+ * file_operations
+ */
+
+/**
+ * famfs_file_bad() - Check for files that aren't in a valid state
+ *
+ * @inode: inode
+ *
+ * Returns: 0=success
+ *          -errno=failure
+ */
+static int
+famfs_file_bad(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct famfs_file_meta *meta = fi->famfs_meta;
+	size_t i_size = i_size_read(inode);
+
+	if (!meta) {
+		pr_err("%s: un-initialized famfs file\n", __func__);
+		return -EIO;
+	}
+	if (meta->error) {
+		pr_debug("%s: previously detected metadata errors\n", __func__);
+		return -EIO;
+	}
+	if (i_size != meta->file_size) {
+		pr_warn("%s: i_size overwritten from %ld to %ld\n",
+		       __func__, meta->file_size, i_size);
+		meta->error = true;
+		return -ENXIO;
+	}
+	if (!IS_DAX(inode)) {
+		pr_debug("%s: inode %llx IS_DAX is false\n",
+			 __func__, (u64)inode);
+		return -ENXIO;
+	}
+	return 0;
+}
+
+static ssize_t
+famfs_fuse_rw_prep(struct kiocb *iocb, struct iov_iter *ubuf)
+{
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	size_t i_size = i_size_read(inode);
+	size_t count = iov_iter_count(ubuf);
+	size_t max_count;
+	ssize_t rc;
+
+	rc = famfs_file_bad(inode);
+	if (rc)
+		return (ssize_t)rc;
+
+	/* Avoid unsigned underflow if position is past EOF */
+	if (iocb->ki_pos >= i_size)
+		max_count = 0;
+	else
+		max_count = i_size - iocb->ki_pos;
+
+	if (count > max_count)
+		iov_iter_truncate(ubuf, max_count);
+
+	if (!iov_iter_count(ubuf))
+		return 0;
+
+	return rc;
+}
+
+ssize_t
+famfs_fuse_read_iter(struct kiocb *iocb, struct iov_iter	*to)
+{
+	ssize_t rc;
+
+	rc = famfs_fuse_rw_prep(iocb, to);
+	if (rc)
+		return rc;
+
+	if (!iov_iter_count(to))
+		return 0;
+
+	rc = dax_iomap_rw(iocb, to, &famfs_iomap_ops);
+
+	file_accessed(iocb->ki_filp);
+	return rc;
+}
+
+ssize_t
+famfs_fuse_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	ssize_t rc;
+
+	rc = famfs_fuse_rw_prep(iocb, from);
+	if (rc)
+		return rc;
+
+	if (!iov_iter_count(from))
+		return 0;
+
+	return dax_iomap_rw(iocb, from, &famfs_iomap_ops);
+}
+
+int
+famfs_fuse_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(file);
+	ssize_t rc;
+
+	rc = famfs_file_bad(inode);
+	if (rc)
+		return rc;
+
+	file_accessed(file);
+	vma->vm_ops = &famfs_file_vm_ops;
+	vm_flags_set(vma, VM_HUGEPAGE);
+	return 0;
+}
+
 #define FMAP_BUFSIZE PAGE_SIZE
 
 int
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1f64bf68b5ee..45a09a7f0012 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1831,6 +1831,8 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_read_iter(iocb, to);
+	if (fuse_file_famfs(fi))
+		return famfs_fuse_read_iter(iocb, to);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
 	if (ff->open_flags & FOPEN_DIRECT_IO)
@@ -1853,6 +1855,8 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_write_iter(iocb, from);
+	if (fuse_file_famfs(fi))
+		return famfs_fuse_write_iter(iocb, from);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
 	if (ff->open_flags & FOPEN_DIRECT_IO)
@@ -1868,9 +1872,13 @@ static ssize_t fuse_splice_read(struct file *in, loff_t *ppos,
 				unsigned int flags)
 {
 	struct fuse_file *ff = in->private_data;
+	struct inode *inode = file_inode(in);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
-	if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
+	if (fuse_file_famfs(fi))
+		return -EIO; /* famfs does not use the page cache... */
+	else if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_passthrough_splice_read(in, ppos, pipe, len, flags);
 	else
 		return filemap_splice_read(in, ppos, pipe, len, flags);
@@ -1880,9 +1888,13 @@ static ssize_t fuse_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				 loff_t *ppos, size_t len, unsigned int flags)
 {
 	struct fuse_file *ff = out->private_data;
+	struct inode *inode = file_inode(out);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
-	if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
+	if (fuse_file_famfs(fi))
+		return -EIO; /* famfs does not use the page cache... */
+	else if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_passthrough_splice_write(pipe, out, ppos, len, flags);
 	else
 		return iter_file_splice_write(pipe, out, ppos, len, flags);
@@ -2390,6 +2402,8 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_mmap(file, vma);
+	if (fuse_file_famfs(fi))
+		return famfs_fuse_mmap(file, vma);
 
 	/*
 	 * If inode is in passthrough io mode, because it has some file open
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 83e24cee994b..f5548466c2b2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1650,6 +1650,9 @@ extern void fuse_sysctl_unregister(void);
 int famfs_file_init_dax(struct fuse_mount *fm,
 			struct inode *inode, void *fmap_buf,
 			size_t fmap_size);
+ssize_t famfs_fuse_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t famfs_fuse_read_iter(struct kiocb *iocb, struct iov_iter	*to);
+int famfs_fuse_mmap(struct file *file, struct vm_area_struct *vma);
 void __famfs_meta_free(void *map);
 
 void famfs_teardown(struct fuse_conn *fc);
@@ -1692,6 +1695,22 @@ int fuse_get_fmap(struct fuse_mount *fm, struct inode *inode);
 static inline void famfs_teardown(struct fuse_conn *fc)
 {
 }
+static inline ssize_t famfs_fuse_write_iter(struct kiocb *iocb,
+					    struct iov_iter *to)
+{
+	return -ENODEV;
+}
+static inline ssize_t famfs_fuse_read_iter(struct kiocb *iocb,
+					   struct iov_iter *to)
+{
+	return -ENODEV;
+}
+static inline int famfs_fuse_mmap(struct file *file,
+				  struct vm_area_struct *vma)
+{
+	return -ENODEV;
+}
+
 static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
 						  void *meta)
 {
-- 
2.52.0


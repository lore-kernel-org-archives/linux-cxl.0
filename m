Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D44DD3D5
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163862; cv=none; b=ILR6/PvQBDLAFNpk5n7S/Op+N+LLUerP5ioaXcdz7g2qlk20ykBCtR4tri6GUBXQkDeVxrWVCCsNnnrvkRi+R/WdJChbXd7dGkOdvno1XTlN9bOwSXe3ghfmxAvNRvR2KJk6m5+maZLsZsY9aD0blj3VwUrsaLfQWQcfhYsbDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163862; c=relaxed/simple;
	bh=J7ObzGOOfgHEEAQ1KfWlumulrx2G1wrZpyeAufpKba8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=u6rm6cqAFBuLQnE+EOsloTa9xMkNMDQLoVPvKbY0uNCZGTtVZ5mmeFKCl4UV9AZXlTJBM7C+xTfUXuRFQkGthDq9KfzER2YF6iovrAfTTX/JAMrFMEt1fXyxrrSvRRhappejHfIta9S/6Ol6U7Jb7+F25tn/VXzNp/XEaj7NxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2jFEGaF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2jFEGaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792163855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FgWRLrg43htuci6ks/jvPth/cct5CLJ6KvnuLDYJg4=;
	b=e2jFEGaFWJBUKuMeVNy9qzNTjQYaCVjndzZZ/uoRZcb6OQ9rv8Q3ioe+dQfYZirIv1o4re
	90RItjUFOqP2F25X3fPFl56yjqsXvoQ2II2PP6KTf6O89KvMW4bUXsm3c5gcncrFxHvkwB
	0KSiF/rE+JV5ENZgRomw5/v69XB7W4Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-Lm6GO9AfMxeSGDvq2BupTg-1; Fri, 16 Oct 2026 15:17:32 +0000
X-MC-Unique: Lm6GO9AfMxeSGDvq2BupTg-1
X-Mimecast-MFC-AGG-ID: Lm6GO9AfMxeSGDvq2BupTg_1792163851
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a166a9ea21so395515e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163851; x=1792768651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2FgWRLrg43htuci6ks/jvPth/cct5CLJ6KvnuLDYJg4=;
        b=CuJ5FGJH0MconO00kOwXuKR3TYtMmL1mgKpq+50F0n2xrqA7AUgzl2VrgeoCl/ecsd
         L0pWegdjUl2kOtccoG5XJS7ZUSwuIORqN1ekQY0nmJ/2VxZLiFchJjLpXKH2V/SXBRXV
         S9tXX4wQRk53UGmESYKziQY2nRxZbsFZoXA27jwCEFjWsrzmw/ywohgHKoX1ZU3O4tya
         Lco3nEMjOhXjGzYRmH+o2FDoclNZp3Fn0zy0KooBnA0UOmYAnMDPtKsLH5k7HK3YGrM8
         6LyUL+9e8dISWPE1X+Yqc7lkviEkKdMm+OQ2HtIPCXPTnyH/q0WFl5m/kXWo2UOmZ9lg
         V3ww==
X-Forwarded-Encrypted: i=1; AKwUvByZMM0Ro/UGJRPeoRSsq5YAUES/8gLXv4bryJOFGlpTy/uaiMAW15WWUxMnitN9qUPunsqsGb3AweU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXceBqdNG6iDtRnruBQPJlqEYbfoc1oDCIBoIp4NwvH2raXYmM
	fqai1jlIuryTzQfOPK64BcUA3JEnLpZrBAma2+fGk+BGYB7sdC14cNVZwYTcZSd2IMvxQMqj2Zs
	dHgIMIW7jFKZhOGt+PNyf9W6Xvc9zQAxIrts8rJ3ma9pyTPhBzDgH0/I9hJ8qwA==
X-Gm-Gg: AYBFou1mUjF3s4+C2332Bti8cuV6tcHjsnPfsNOGDgkEVk5SUQVqoJpCFWQqqB4kygY
	iQsmTWvYkg0N5fqPv6QCk8iaigvoCv7jgru4mMmwBCvqHXrRH40us13Tfr/dVBppzhtHOl8Oo/i
	tyi0OUytXp97LwuDX+XujJio54sKi7LaxwkrYYG3EZPhxyp/8oZFO/sz//n/t3Z86TBbRpkXzeT
	mdhQjuM5OIHSO1HsoFXJ5dZsN+q95CwRvU286XJEEE61S//M9BvTUw0rzyHD59ujONtHTkVKJXt
	lRZQJgEyNgop/tQpZCOaQg7jewxPnhicU3i/jFxbVDM/0iwTa5dGA3RtYNUi3nyFAzuesdcq0m8
	3jujath0YbySRlxRr4PWT7g==
X-Received: by 2002:a05:600c:699a:b0:4a1:80d8:aeb3 with SMTP id 5b1f17b1804b1-4a1d75fcddfmr2640965e9.12.1792163850963;
        Fri, 16 Oct 2026 08:17:30 -0700 (PDT)
X-Received: by 2002:a05:600c:699a:b0:4a1:80d8:aeb3 with SMTP id 5b1f17b1804b1-4a1d75fcddfmr2640415e9.12.1792163850508;
        Fri, 16 Oct 2026 08:17:30 -0700 (PDT)
Received: from maszat.com (85-67-2-18.pool.digikabel.hu. [85.67.2.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm64621665e9.14.2026.10.16.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:17:29 -0700 (PDT)
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
Subject: [PATCH v5 07/10] fuse: add extent map data structure
Date: Fri, 16 Oct 2026 17:16:34 +0200
Message-ID: <20261016151638.2962413-8-mszeredi@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 71rxFHzvnhj58t8l60j_tBsgLsiawJ6h_Z8-doC8Pic_1792163851
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add support for creating and managing extent maps that map file regions to
dax device regions.

Introduce FUSE_NOTIFY_BACKING_MAP for populating extent maps from
userspace.

Extent maps are handled as a new type of backing and are assigned a 64 bit
backing ID by the server.

One extent consists of

 - offset within the containing backing
 - length of extent
 - target backing ID
 - offset into target backing

Extents must be non-overlapping, and can only refer to dax device backings
for now.

At this point only support creating and populating the extent map in one
operation, though the interface is not limited by this and later may be
changed, so that partial population of an extent map would be possible.

Originally-by: John Groves <john@groves.net>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/Makefile          |   2 +-
 fs/fuse/backing.c         |  38 +++++++++--
 fs/fuse/ext_map.c         | 131 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |  14 +++-
 fs/fuse/notify.c          |  47 ++++++++++++++
 include/uapi/linux/fuse.h |  26 ++++++++
 6 files changed, 251 insertions(+), 7 deletions(-)
 create mode 100644 fs/fuse/ext_map.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 5858feafa916..da9e802d7ae1 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -15,7 +15,7 @@ fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o r
 fuse-y += poll.o notify.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_VDAX) += dax.o
-fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
+fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o ext_map.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
 
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 972a145484d7..bb756f4e3b86 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -32,6 +32,10 @@ static void fuse_backing_free(struct fuse_backing *fb)
 	case FUSE_BACKING_DAXDEV:
 		fs_put_dax(fb->dax_dev, fb);
 		break;
+
+	case FUSE_BACKING_EXTMAP:
+		fuse_ext_map_destroy(&fb->extents);
+		break;
 	}
 	kfree_rcu(fb, rcu);
 }
@@ -84,7 +88,7 @@ static const struct rhashtable_params fuse_backing_prm = {
 	.key_len = sizeof_field(struct fuse_backing, backing_id),
 };
 
-static int fuse_backing_add_64(struct fuse_conn *fc, struct fuse_backing *fb)
+int fuse_backing_add_64(struct fuse_conn *fc, struct fuse_backing *fb)
 {
 	return rhashtable_lookup_insert_fast(&fc->backing_64_ht, &fb->hash_node, fuse_backing_prm);
 }
@@ -316,12 +320,38 @@ static void fuse_backing_rht_free(void *p, void *data)
 
 void fuse_backing_files_free(struct fuse_conn *fc)
 {
-	if (fc->backing_id_64) {
-		rhashtable_free_and_destroy(&fc->backing_64_ht, fuse_backing_rht_free, NULL);
-	} else {
+	struct rhashtable_iter iter;
+	struct fuse_backing *fb;
+
+	if (!fc->backing_id_64) {
 		idr_for_each(&fc->backing_files_map, fuse_backing_idr_free, NULL);
 		idr_destroy(&fc->backing_files_map);
+		return;
 	}
+
+	/*
+	 * extents are referencing other backings, put these refs before
+	 * destroying the backings themselves
+	 */
+	rhashtable_walk_enter(&fc->backing_64_ht, &iter);
+	rhashtable_walk_start(&iter);
+	while ((fb = rhashtable_walk_next(&iter))) {
+		if (IS_ERR(fb)) {
+			if (PTR_ERR(fb) == -EAGAIN)
+				continue;
+			break;
+		}
+		if (fb->type == FUSE_BACKING_EXTMAP && !RB_EMPTY_ROOT(&fb->extents)) {
+			rhashtable_walk_stop(&iter);
+			fuse_ext_map_destroy(&fb->extents);
+			fb->extents.rb_node = NULL;
+			rhashtable_walk_start(&iter);
+		}
+	}
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+
+	rhashtable_free_and_destroy(&fc->backing_64_ht, fuse_backing_rht_free, NULL);
 }
 
 void fuse_backing_files_init_64(struct fuse_conn *fc)
diff --git a/fs/fuse/ext_map.c b/fs/fuse/ext_map.c
new file mode 100644
index 000000000000..afac5de51c80
--- /dev/null
+++ b/fs/fuse/ext_map.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "fuse_i.h"
+#include <linux/rbtree.h>
+#include <linux/pagemap.h>
+
+struct fuse_iext {
+	struct rb_node rb;
+	u64 start;
+	u64 end; /* exclusive */
+	struct fuse_backing *backing;
+	u64 backing_offset;
+};
+
+void fuse_ext_map_destroy(struct rb_root *extents)
+{
+	struct fuse_iext *fie, *tmp;
+
+	rbtree_postorder_for_each_entry_safe(fie, tmp, extents, rb) {
+		fuse_backing_put(fie->backing);
+		kfree(fie);
+	}
+}
+
+static int fuse_add_extent(struct fuse_conn *fc, struct rb_root *extents,
+			   struct fuse_extent *ext)
+{
+	struct fuse_iext *new_fie __free(kfree) = kzalloc_obj(*new_fie);
+	struct rb_node *parent = NULL, **link = &extents->rb_node;
+	loff_t end;
+	u64 tmp;
+
+	if (!new_fie)
+		return -ENOMEM;
+
+	if (ext->reserved[0] || ext->reserved[1])
+		return fuse_EIO("reserved fields set");
+
+	if (!PAGE_ALIGNED(ext->offset) || !PAGE_ALIGNED(ext->length) || !PAGE_ALIGNED(ext->addr))
+		return fuse_EIO("not page aligned");
+
+	if (!ext->length)
+		return fuse_EIO("zero sized extent");
+
+	if (overflows_type(ext->offset, loff_t) ||
+	    check_add_overflow(ext->offset, ext->length, &end) ||
+	    check_add_overflow(ext->addr, ext->length, &tmp))
+		return fuse_EIO("offset overflow");
+
+	new_fie->start = ext->offset;
+	new_fie->end = end;
+	new_fie->backing_offset = ext->addr;
+
+	while (*link) {
+		struct fuse_iext *fie = rb_entry(*link, typeof(*fie), rb);
+
+		parent = *link;
+		if (new_fie->end <= fie->start)
+			link = &parent->rb_left;
+		else if (new_fie->start >= fie->end)
+			link = &parent->rb_right;
+		else
+			return fuse_EIO("overlap");
+	}
+
+	new_fie->backing = fuse_backing_lookup(fc, ext->backing_id);
+	if (!new_fie->backing)
+		return fuse_EIO("backing not found");
+
+	if (new_fie->backing->type != FUSE_BACKING_DAXDEV) {
+		fuse_backing_put(new_fie->backing);
+		return fuse_EIO("backing is not dax device");
+	}
+
+	rb_link_node(&new_fie->rb, parent, link);
+	rb_insert_color(&no_free_ptr(new_fie)->rb, extents);
+
+	return 0;
+}
+
+bool fuse_ext_map_is_dax(struct fuse_backing *fb)
+{
+	struct fuse_iext *fie;
+
+	if (WARN_ON(fb->type != FUSE_BACKING_EXTMAP || RB_EMPTY_ROOT(&fb->extents)))
+		return false;
+
+	fie = rb_entry(fb->extents.rb_node, typeof(*fie), rb);
+	return fie->backing->type == FUSE_BACKING_DAXDEV;
+}
+
+int fuse_ext_map_populate(struct fuse_conn *fc, struct fuse_notify_backing_map_out *arg,
+			  struct fuse_extent *ext)
+{
+	struct fuse_backing *fb;
+	unsigned int i;
+	int err;
+
+	if (!arg->num_extents)
+		return fuse_EIO("no extents");
+
+	if (arg->flags & FUSE_BACKING_MAP_CREATE) {
+		fb = kzalloc_obj(*fb);
+		if (!fb)
+			return -ENOMEM;
+
+		refcount_set(&fb->count, 1);
+		fb->type = FUSE_BACKING_EXTMAP;
+		fb->backing_id = arg->backing_id;
+	} else {
+		/* Adding extents to an existing extmap backing is not yet supported */
+		return -EINVAL;
+	}
+
+	for (i = 0; i < arg->num_extents; i++) {
+		err = fuse_add_extent(fc, &fb->extents, &ext[i]);
+		if (err)
+			goto err_put;
+	}
+
+	err = 0;
+	if (arg->flags & FUSE_BACKING_MAP_CREATE) {
+		err = fuse_backing_add_64(fc, fb);
+		if (!err)
+			return 0;
+	}
+
+err_put:
+	fuse_backing_put(fb);
+	return err;
+}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c6caeaebcf23..79078e58d4d9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -24,7 +24,7 @@
 #include <linux/backing-dev.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/poll.h>
 #include <linux/workqueue.h>
 #include <linux/kref.h>
@@ -92,6 +92,7 @@ struct fuse_submount_lookup {
 enum fuse_backing_type {
 	FUSE_BACKING_PATH,
 	FUSE_BACKING_DAXDEV,
+	FUSE_BACKING_EXTMAP,
 };
 
 /* Container for data related to mapping to backing file */
@@ -107,6 +108,9 @@ struct fuse_backing {
 			struct dax_device *dax_dev;
 			bool dax_error;
 		};
+		struct {
+			struct rb_root extents;
+		};
 	};
 	u64 backing_id;
 	struct rhash_head hash_node;
@@ -1308,7 +1312,6 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 /* backing.c */
 #ifdef CONFIG_FUSE_PASSTHROUGH
 void fuse_backing_put(struct fuse_backing *fb);
-
 #else
 
 static inline void fuse_backing_put(struct fuse_backing *fb)
@@ -1317,6 +1320,7 @@ static inline void fuse_backing_put(struct fuse_backing *fb)
 #endif
 
 struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, u64 backing_id);
+int fuse_backing_add_64(struct fuse_conn *fc, struct fuse_backing *fb);
 void fuse_backing_files_init(struct fuse_conn *fc);
 void fuse_backing_files_init_64(struct fuse_conn *fc);
 void fuse_backing_files_free(struct fuse_conn *fc);
@@ -1368,4 +1372,10 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+/* ext_map.c */
+
+void fuse_ext_map_destroy(struct rb_root *extents);
+bool fuse_ext_map_is_dax(struct fuse_backing *fb);
+int fuse_ext_map_populate(struct fuse_conn *fc, struct fuse_notify_backing_map_out *arg,
+			  struct fuse_extent *ext);
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/notify.c b/fs/fuse/notify.c
index cc0afffc2c00..90d1f5c053e6 100644
--- a/fs/fuse/notify.c
+++ b/fs/fuse/notify.c
@@ -434,6 +434,50 @@ static int fuse_notify_backing_remove(struct fuse_conn *fc, unsigned int size,
 	return fuse_backing_close_64(fc, outarg.backing_id);
 }
 
+static int fuse_notify_map(struct fuse_conn *fc, unsigned int size,
+			   struct fuse_copy_state *cs)
+{
+	struct fuse_notify_backing_map_out outarg;
+	struct fuse_extent *ext __free(kvfree) = NULL;
+	int err;
+
+	if (size < sizeof(outarg))
+		return -EINVAL;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		return err;
+
+	if (!fc->backing_id_64)
+		return -EINVAL;
+
+	if (outarg.num_extents > FUSE_MAX_EXTENTS)
+		return -EINVAL;
+
+	size -= sizeof(outarg);
+	if (size != outarg.num_extents * sizeof(*ext))
+		return -EINVAL;
+
+	if (outarg.reserved[0] != 0 || outarg.reserved[1] != 0)
+		return -EINVAL;
+
+	if (outarg.flags & ~FUSE_BACKING_MAP_CREATE)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		return -EOPNOTSUPP;
+
+	ext = kvmalloc_objs(*ext, outarg.num_extents);
+	if (!ext)
+		return -ENOMEM;
+
+	err = fuse_copy_one(cs, ext, size);
+	if (err)
+		return err;
+
+	return fuse_ext_map_populate(fc, &outarg, ext);
+}
+
 int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		unsigned int size, struct fuse_copy_state *cs)
 {
@@ -468,6 +512,9 @@ int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_BACKING_REMOVE:
 		return fuse_notify_backing_remove(fc, size, cs);
 
+	case FUSE_NOTIFY_BACKING_MAP:
+		return fuse_notify_map(fc, size, cs);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 90e0a9be7df0..43a92d834cd3 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -255,6 +255,7 @@
  *  - add FUSE_DEV_IOC_BACKING_CREATE, struct fuse_backing_create_in
  *  - add FUSE_NOTIFY_BACKING_REMOVE, struct fuse_notify_backing_remove_out
  *  - add backing_id_64 to fuse_open_out
+ *  - add FUSE_NOTIFY_BACKING_MAP, fuse_notify_backing_map_out, fuse_extent, FUSE_BACKING_MAP_CREATE
  */
 
 #ifndef _LINUX_FUSE_H
@@ -716,6 +717,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_PRUNE = 9,
 	FUSE_NOTIFY_BACKING_REMOVE = 10,
+	FUSE_NOTIFY_BACKING_MAP = 11,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1213,6 +1215,30 @@ struct fuse_notify_backing_remove_out {
 	uint64_t	reserved;
 };
 
+/**
+ * notify_map flags
+ *
+ * FUSE_BACKING_MAP_CREATE:	create backing with the supplied ID
+ */
+#define FUSE_BACKING_MAP_CREATE	(1 << 0)
+
+struct fuse_notify_backing_map_out {
+	uint64_t	backing_id;
+	uint32_t	num_extents;
+	uint32_t	flags;
+	uint64_t	reserved[2];
+};
+
+#define FUSE_MAX_EXTENTS 1365		/*  (1 << 16) / sizeof(struct fuse_extent) */
+
+struct fuse_extent {
+	uint64_t	offset;		/* offset of extent into parent backing */
+	uint64_t	length;		/* extent length */
+	uint64_t	backing_id;	/* target backing */
+	uint64_t	addr;		/* target offset within backing file/device */
+	uint64_t	reserved[2];
+};
+
 #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
 #define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
 struct fuse_setupmapping_in {
-- 
2.54.0


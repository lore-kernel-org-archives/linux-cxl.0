Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E883A48E9
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867399; cv=none; b=poX0NXYKc8ehCQuK6Xm3fZU7cWpPQnyVVASRE67BuxSq5LQugw+jQV+EzAMDQuCKWlvxjek7Jlyzj2KB3MRxDWqO+TG28JbwJasf98oWV9dqtP3D3bEwetjMDs90YXFLn1XDck7NUYlNzEz6qfSDsKFOQBq5omtXySLz6/ciJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867399; c=relaxed/simple;
	bh=J+Px55dagdfMw7YfxNKze6OmLaUjKceUErnuXWFGryg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=i0t+hDhGT/AvfxnJfez1f+vSlGCfHnvHgT8HBWcvRBYlVvb6G9POXJxXDCbofY2vmmiOaM0c7C0V8y/2zyZdhQudsihUK0B1Ky0gZc8frOHLWjYBYNrS6qttQ1loZyHZWfHexDCkhVi1G1Bh1u4dGY6LSwFjUGuPX40RZDEe/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYO/trhE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYO/trhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790867396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbYNmywWjThKt2Qey6sPOBu4/6mlPeMPuesMztax4Yg=;
	b=BYO/trhESu6KLQsGVpTq3fYvtjG04acz/gDgZidMktYkZxajP1bn9SMjl3tBevo/otVx/y
	JPvyp+qbUuefNeUkZdYC1b7sDzqmL6ctVU+r6dbgj0HWX+eUSk1cotC0/jjVyfS/NueXk+
	TthesYn6TeoALTplaMJmELqwpDGBtcg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-wSS3GvL1NSqGKjdHX7IxWA-1; Thu, 01 Oct 2026 11:09:55 -0400
X-MC-Unique: wSS3GvL1NSqGKjdHX7IxWA-1
X-Mimecast-MFC-AGG-ID: wSS3GvL1NSqGKjdHX7IxWA_1790867394
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2939083cefso756591566b.1
        for <linux-cxl@vger.kernel.org>; Thu, 01 Oct 2026 08:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867394; x=1791472194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbYNmywWjThKt2Qey6sPOBu4/6mlPeMPuesMztax4Yg=;
        b=ZrYgb8mOD5fzFUK7jcr9fWvIn73rqc9cmoAGKRHCINLndeHSS1saXIbFYR7P+t2pZz
         Eacutt7+GrigEAuV+CrV0H7fx2KmMmACtuMtOgivKUuk7O6KPZVqpPoSau/wYHJpDWEG
         CgkegFxTGXxpdyfulzPFTIQCmEXM7gLRp2o6ida89k2CcfMKc72k7/ixnPfAZEo/XT2j
         7GpFe9p4ELwcXXHmtfBPaQaJUeISmE5+D3qQbrPICcDVTkyfIZzAi5eYuGjvcS9fZqEY
         Ct56yVFwnLGRpLyjlAAh0c+GBPBvXQq+20mj5sUuW/U9BjKKQlzoLGtvl25tL1DqMTdZ
         iZBA==
X-Forwarded-Encrypted: i=1; AKwUvBwo8egmRBwt/61LH9N6kmtVt+X0g4XHwFlZCHU7/T1KIN0Vr6/PI3T+DyMLRdAtDM9ST+5JnZU9IQU=@vger.kernel.org
X-Gm-Message-State: AFuF++kbJkbQtuH82X1hAUZ9/p4EFePHglg02jmMwXct+lFOgDTCL33X
	93MsyI6qsSrEwXWcVCW5QGIjkSG5piCYnScdwNRaGc2o5na7mR7NUPfl5xLd8OgkRp3pJB1SroZ
	djhTpaQcBtkERNJPcweFHlNmth6mkoaPosl+Wq8UiDdBZQUhGxgBpwrikUxeiyg==
X-Gm-Gg: AYBFou03Xx0+/Ut3Hpu9tLXlYgudr2IriKnHYJ/8nEr+vaeBq0w8VMhq3HrzF5ZpD1W
	mp/mJI97T0BaxItoid72gNkxLelgmCNbkWWLtP/xuScXltZBf9EEQR3XNUMRFR63H/dNIq0KzNT
	tdnu5730paTb1oi/pAgIf1808cLZ+2N0SSQce9CPnQ5T0ys/5f46iMOeduDlAFNofYnbOwEdFX/
	yTothqiIzB1oNZEHsZhZ3rsUdK5fLn4IsMzcBA8hssZ1x1AcHDzp+7tJu+dG9jNBkV8EkbhAFPu
	uEKYTCjoRuAcAxolIgJbNdKN2MgZrFFjd09rc9aQFTT4ahjNtEDzMjM0FRjskPEO41lWu9JSb5r
	oovO+HyaFGpMTK4wLbm78xmdXhau32vhqpca1V00HDiwTTkIOTh5ARMIC2V8=
X-Received: by 2002:a17:907:86a3:b0:c29:c079:676d with SMTP id a640c23a62f3a-c2e23749ee1mr410211766b.3.1790867394278;
        Thu, 01 Oct 2026 08:09:54 -0700 (PDT)
X-Received: by 2002:a17:907:86a3:b0:c29:c079:676d with SMTP id a640c23a62f3a-c2e23749ee1mr410209366b.3.1790867393806;
        Thu, 01 Oct 2026 08:09:53 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-245-188.pool.digikabel.hu. [193.226.245.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d86372sm177735166b.56.2026.10.01.08.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:09:52 -0700 (PDT)
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
Subject: [PATCH v2 8/8] fuse: add support for striped backing
Date: Thu,  1 Oct 2026 17:07:26 +0200
Message-ID: <20261001150935.655979-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261001150935.655979-1-mszeredi@redhat.com>
References: <20261001150935.655979-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c30Hsg3hkdoifS9T3Xk7MJ38ih3OABLVzDZWRsFOPBQ_1790867394
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add the FUSE_BACKING_MAP_CYCLIC flag for FUSE_NOTIFY_BACKING_MAP
notifications to enable creating striped maps.

This is just a set of regular extents that repeats after the end of the
last extent using a striping pattern (i.e. on the target backings the
stripes have a contiguous footprint).

Two additional limits apply compared to non-cyclic extent map population:

 - the size of the extents (chunk size) must be equal

 - the extents must start from zero offset and follow each other without
   gaps.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/ext_map.c         | 27 ++++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |  1 +
 fs/fuse/notify.c          |  2 +-
 include/uapi/linux/fuse.h |  5 ++++-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/ext_map.c b/fs/fuse/ext_map.c
index 61cb22e821b6..356a5ec4f5e1 100644
--- a/fs/fuse/ext_map.c
+++ b/fs/fuse/ext_map.c
@@ -101,12 +101,18 @@ static int fuse_ext_map_iomap_begin(struct inode *inode, loff_t offset, loff_t l
 {
 	struct fuse_backing *fb = fuse_inode_backing(get_fuse_inode(inode));
 	struct fuse_iext *fie;
+	u64 ncycle = 0, seq_off = 0, addr, tmp;
 	loff_t ext_len;
 
 	if (!fb || fb->type != FUSE_BACKING_EXTMAP)
 		return fuse_EIO("missing or wrong type backing");
 
-	fie = fuse_find_extent(&fb->extents, offset);
+	if (fb->cycle_length) {
+		ncycle = div64_u64(offset, fb->cycle_length);
+		seq_off = ncycle * fb->cycle_length;
+	}
+
+	fie = fuse_find_extent(&fb->extents, offset - seq_off);
 	if (!fie)
 		return fuse_EIO("missing mapping");
 
@@ -119,9 +125,12 @@ static int fuse_ext_map_iomap_begin(struct inode *inode, loff_t offset, loff_t l
 	}
 
 	ext_len = fie->end - fie->start;
+	addr = fie->backing_offset;
+	if (check_mul_overflow(ncycle, ext_len, &tmp) || check_add_overflow(addr, tmp, &addr))
+		return fuse_EIO("extent address overflow");
 
-	iomap->offset = fie->start;
-	iomap->addr = fie->backing_offset;
+	iomap->offset = fie->start + seq_off;
+	iomap->addr = addr;
 	iomap->length = ext_len;
 	iomap->dax_dev = fie->backing->dax_dev;
 	iomap->type = IOMAP_MAPPED;
@@ -242,6 +251,7 @@ int fuse_ext_map_populate(struct fuse_conn *fc, struct fuse_notify_backing_map_o
 	struct fuse_backing *fb;
 	unsigned int i;
 	int err;
+	u64 chunk_size = 0;
 
 	if (!arg->num_extents)
 		return fuse_EIO("no extents");
@@ -259,7 +269,18 @@ int fuse_ext_map_populate(struct fuse_conn *fc, struct fuse_notify_backing_map_o
 		return -EINVAL;
 	}
 
+	if (arg->flags & FUSE_BACKING_MAP_CYCLIC) {
+		chunk_size = ext[0].length;
+		err = -EINVAL;
+		if (check_mul_overflow(chunk_size, arg->num_extents, &fb->cycle_length))
+			goto err_put;
+	}
+
 	for (i = 0; i < arg->num_extents; i++) {
+		err = -EINVAL;
+		if (chunk_size && (ext[i].offset != chunk_size * i || ext[i].length != chunk_size))
+			goto err_put;
+
 		err = fuse_add_extent(fc, &fb->extents, &ext[i]);
 		if (err)
 			goto err_put;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7248588b45c4..83cc1dd67cef 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -110,6 +110,7 @@ struct fuse_backing {
 		};
 		struct {
 			struct rb_root extents;
+			u64 cycle_length;
 		};
 	};
 	u64 backing_id;
diff --git a/fs/fuse/notify.c b/fs/fuse/notify.c
index 3bfedd0cdbdd..31172de72477 100644
--- a/fs/fuse/notify.c
+++ b/fs/fuse/notify.c
@@ -461,7 +461,7 @@ static int fuse_notify_map(struct fuse_conn *fc, unsigned int size,
 	if (outarg.reserved[0] != 0 || outarg.reserved[1] != 0)
 		return -EINVAL;
 
-	if (outarg.flags & ~FUSE_BACKING_MAP_CREATE)
+	if (outarg.flags & ~(FUSE_BACKING_MAP_CREATE | FUSE_BACKING_MAP_CYCLIC))
 		return -EINVAL;
 
 	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b17786492f0b..f371acb73cda 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -255,7 +255,8 @@
  *  - add FUSE_DEV_IOC_BACKING_CREATE, struct fuse_backing_create_in
  *  - add FUSE_NOTIFY_BACKING_REMOVE, struct fuse_notify_backing_remove_out
  *  - add backing_id_64 to fuse_open_out
- *  - add FUSE_NOTIFY_BACKING_MAP, fuse_notify_backing_map_out, fuse_extent, FUSE_BACKING_MAP_CREATE
+ *  - add FUSE_NOTIFY_BACKING_MAP, fuse_notify_backing_map_out, fuse_extent
+ *  - add FUSE_BACKING_MAP_CREATE, FUSE_BACKING_MAP_CYCLIC
  */
 
 #ifndef _LINUX_FUSE_H
@@ -1219,8 +1220,10 @@ struct fuse_notify_backing_remove_out {
  * notify_map flags
  *
  * FUSE_BACKING_MAP_CREATE:	create backing with the supplied ID
+ * FUSE_BACKING_MAP_CYCLIC:	map repeats after last extent
  */
 #define FUSE_BACKING_MAP_CREATE	(1 << 0)
+#define FUSE_BACKING_MAP_CYCLIC	(1 << 1)
 
 struct fuse_notify_backing_map_out {
 	uint64_t	backing_id;
-- 
2.54.0


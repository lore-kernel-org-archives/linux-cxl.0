Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8363BFAF7
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458432; cv=none; b=asTN4Ya91PdOHytWB6UNwdAILmC6UHNOMl6PqLccfiWKT9uJax+vzSDe0qXxeLjrcGSCdWOD3bgSM+3hjAAOUJamdHk3kPEvTz/0DzooLZJwAH9Wq+w35098Qx+y7ysqSKZeM6Tsi1lqOBCF0TyB6/Vk5IrLQEsztFv8S5tZY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458432; c=relaxed/simple;
	bh=MqhzvNDfqsSrSBD+GceG/Rs+U+1iQfvUWNLT5oRibME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=V4Qx7xnhnm6eCpBkM2mUxrnyTJs+u+GKhC03rszKB3FxXKKTwBUSCR+zuUHnm9ke11Zpzi1jXSu8+l7kJ1STe+w0qG8EelRWAb1JxDPIWxslYFf9v+uOg+49kqR1OTbuQDW4HZZgDgkVvCyeTctGNafltQS2yy26pnklpttEilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCWzGwvT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCWzGwvT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791458428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SoFG2gSIXYxGFdtALtVK/HXR2T0jRaX8RE4fu9oIH2M=;
	b=JCWzGwvTBeTcY1+bsWnvWFJxdJx7DlCw2mcFbFUHDykxzRVo4reuVvkIiL0tf6Ha6JUBPl
	DZroJgtgAxbsS4l85f9cJiQXPEAdBqtM4U+3fRs54Zl83nwfKOgGtCG3YRwkLTQztZjJ9Z
	ANvv2eAfiPk/CpeF7C2J7oxvCpkinyY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-UH1IbrWDMC-hyvs5KJKhoQ-1; Thu, 08 Oct 2026 07:20:27 -0400
X-MC-Unique: UH1IbrWDMC-hyvs5KJKhoQ-1
X-Mimecast-MFC-AGG-ID: UH1IbrWDMC-hyvs5KJKhoQ_1791458426
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c293e604f0eso538512366b.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Oct 2026 04:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791458426; x=1792063226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SoFG2gSIXYxGFdtALtVK/HXR2T0jRaX8RE4fu9oIH2M=;
        b=F4VkXMUwfnRlDzlh/wtsVuBIR8cC3SXdMzlfH+rkS63o5/0TS6UFl/g/GODM9iGaZo
         bgeNeCvfO8z1EaqR8HIMg731dXNKGGPaMFpDxettne1c5L8X3PR1ZeveST/McasrnkSY
         2WkYb10he2TcXrvs5bfyP9BRLeP8f13WSM00P3uo9sN3DpXcm4igvoHrJGTjwPr18lcx
         t6aFdTfmdqQxSsA/7VKu5Jr/o0sB/i86/ynetzN4Fo3j9PSdAGGQt9XMvK8X7woJPgME
         HkHHmLv1cVRv2mx6BZXuPpiMGQuBxt3HVLGoDs4Lgukxdm0kevT/FEIf1CcIYKpEnwy3
         Rtog==
X-Forwarded-Encrypted: i=1; AKwUvBwEvC+IKKdYOHUD7QqpCRmUytnm7QfUKNTepzciBba1HA/Gl05VYODVzGR7M57/dumnei6wVowE2KM=@vger.kernel.org
X-Gm-Message-State: AFuF++no7ERziMdzU5QjYZLz1J1Wn7yaqf7+iq2CYVJp2jbVuu+6qhWJ
	E0M7ZbnL1qZVty0/gSXlhS1HPBo+b8+295Eq2K/y0fJ4O3ikGmC6WMyAkassO5C0iqWO0NSkSi6
	OdRvAE+SmdO8yJHUqPszur9JaZ7QIsSuONOrxF1CkR+krYECZ2/GNpa8HbdYuzg==
X-Gm-Gg: AYBFou04GT3hlCA+6wpUFNb9CNzMz7cAdq27ekul7wrfwymmN9GyaQDiMY6q5LRXYgz
	P0zWk3iKDDARuDrmCTBXqa7sLYO+n/DK5aeZ5LgdL4HQSxWXjRefrr46+yLCOOkeFUR99tOiAxi
	54w/tFdOPyh1P3xzG1KJgDAbkLpGh0V4SxzrAY7NurwDBbynKErzRgxlngHL5rTXUqMDDSR9CD5
	IKrThKO1Imy429gsZDlLwRputqaC/0p9vFcvhtd1PVpWqDwDlKbHxofkA5ZBhWqrS5Q9OX1iyxs
	qtDFtpPVsKRj6XBait+XRmsdA1nzpQTtnsi7LQsxXmIZ1U3025CDCD7y0ZbNfZ4QPUHQtBD936+
	bZjrN/6bvjfMIRm5Xbe3z3U0n4JUcIVox78Py2kqekSHTFrnN9qFUB5BR
X-Received: by 2002:a17:906:f586:b0:c29:4b79:e41a with SMTP id a640c23a62f3a-c317be010f6mr482483666b.20.1791458426117;
        Thu, 08 Oct 2026 04:20:26 -0700 (PDT)
X-Received: by 2002:a17:906:f586:b0:c29:4b79:e41a with SMTP id a640c23a62f3a-c317be010f6mr482482166b.20.1791458425763;
        Thu, 08 Oct 2026 04:20:25 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-152-55.pool.digikabel.hu. [188.142.152.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c2fae53sm204251866b.49.2026.10.08.04.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:20:25 -0700 (PDT)
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
Subject: [PATCH v4 9/9] fuse: add support for striped backing
Date: Thu,  8 Oct 2026 13:20:00 +0200
Message-ID: <20261008112004.1899560-10-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008112004.1899560-1-mszeredi@redhat.com>
References: <20261008112004.1899560-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DEUnh-C32Rc3oggdE9Xm1tLv-xWEorHTpIABG8yJW7o_1791458426
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

Originally-by: John Groves <john@groves.net>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/ext_map.c         | 30 +++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |  1 +
 fs/fuse/notify.c          |  2 +-
 include/uapi/linux/fuse.h |  5 ++++-
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/ext_map.c b/fs/fuse/ext_map.c
index 744940cbf36e..7adb78cf552d 100644
--- a/fs/fuse/ext_map.c
+++ b/fs/fuse/ext_map.c
@@ -103,12 +103,18 @@ static int fuse_ext_map_iomap_begin(struct inode *inode, loff_t offset, loff_t l
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
 
@@ -121,9 +127,15 @@ static int fuse_ext_map_iomap_begin(struct inode *inode, loff_t offset, loff_t l
 	}
 
 	ext_len = fie->end - fie->start;
+	addr = fie->backing_offset;
+	if (check_mul_overflow(ncycle, ext_len, &tmp) || check_add_overflow(addr, tmp, &addr))
+		return fuse_EIO("extent address overflow");
 
-	iomap->offset = fie->start;
-	iomap->addr = fie->backing_offset;
+	if (check_add_overflow(addr, ext_len, &tmp))
+		return fuse_EIO("extent end overflow");
+
+	iomap->offset = fie->start + seq_off;
+	iomap->addr = addr;
 	iomap->length = ext_len;
 	iomap->dax_dev = fie->backing->dax_dev;
 	iomap->type = IOMAP_MAPPED;
@@ -259,6 +271,7 @@ int fuse_ext_map_populate(struct fuse_conn *fc, struct fuse_notify_backing_map_o
 	struct fuse_backing *fb;
 	unsigned int i;
 	int err;
+	u64 chunk_size = 0;
 
 	if (!arg->num_extents)
 		return fuse_EIO("no extents");
@@ -276,7 +289,18 @@ int fuse_ext_map_populate(struct fuse_conn *fc, struct fuse_notify_backing_map_o
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
index 8a9961c4c924..064fed459b93 100644
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
index 90d1f5c053e6..984e4945e3e3 100644
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
index 60060da98e8d..6b2fe68b4ab5 100644
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


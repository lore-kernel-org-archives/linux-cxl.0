Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4037F723
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163863; cv=none; b=ZDMBviqzJT2RVEYL/xCP/d5UlqOHlss8MrdBLd9KtPsVunhIGnXZO6zHiPkYes69Cv5Sfyk8Jq6mRaVgPi9LlBhXSN18iKnK60BI6W88RPOrCTgvE7eSOOQ/+6DjonnMBdC+UYXHeoEuiHDrgAqlRaO/fmF3m/L2d+rRwypRyjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163863; c=relaxed/simple;
	bh=7BUL7LrIJwKZfLyXB8aUZj3zJf1dl2EUTwhnYn12Z7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=n4ztsdsyqbGQUoq1CHKLJePJQnUXTiG32ZxyvR9i1cmDKzAMLGY/HXAJXBlwwfyzTMu4V2PoeRZgYY403OL9ut5lWJ6TwGKSiIynSir2nom885u4xXEKpccKOSfr920fmH/GiT7Jl8zjEaCvY/Uxs7pgwDnZ1Vg6PpVwaS7xCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSEZ0yPH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSEZ0yPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792163856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wi3n3JQ/cHKeUcsyNYS5wpcW4DOqjpEHfKPbOyr8HiU=;
	b=dSEZ0yPHJKB1cU84bt859dqyFgLT4OAj3CrryhZD+xLDLt5MRSbauu4JrYDjEKebw3SL5a
	rkLm3uy72bUYWmw7h3PNvVf+vGr6Rp7/fBp/5dIVHngIf4xtzkdBmfdxMSXFCFFV71pNDe
	qmrCAb1dy3oFksNfmZnLLH7MLBj5B7Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-s5-FqLO3M46PnK0Bf02JkQ-1; Fri, 16 Oct 2026 15:17:35 +0000
X-MC-Unique: s5-FqLO3M46PnK0Bf02JkQ-1
X-Mimecast-MFC-AGG-ID: s5-FqLO3M46PnK0Bf02JkQ_1792163854
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0228f4a1bso362575e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 08:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163854; x=1792768654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wi3n3JQ/cHKeUcsyNYS5wpcW4DOqjpEHfKPbOyr8HiU=;
        b=ma/yY78/ex0ZJr0gh4WGMcbr1/2OqORUoOJ8Wq6k+ghcLJSfXdlEs8b6dAI30HKweU
         YkTqf9MxEHrWDsWpbVaGAJuGw+Imqmc6ZmVqjFCY4pqkasC/UFWdpDHqiL3KKCgtKPqS
         BhhEW9uiWIe5VchFXVv0+bCcecBysySuTijm0h+UAJJFA42X8G9BpN2DYIcfcRXzOp6k
         rd3MwOLhTIuD3MPFj7m21OKCUdBcVM+xAHjJCPtV3yb7vWCRNbaGrl6+x7NFlQ41briK
         RdASvwnnRExfbNNEC7KhAwg2Q4LxqsU7idSPqC1GU18isdnmO8lCPWFBB+4OpqmAwbKI
         RzCA==
X-Forwarded-Encrypted: i=1; AKwUvBwj/rllJNvTVDWZ5eEaWf9a1PWq3cu3jHZkAo2JN7Hx5oMRRPgOFPWj3CXiVzXj42pyyOWuCwTOKng=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEA5VmI3yquHC7qwHgUIWrZFDKh7rz9mGUUZucRSbsTsFVXmZV
	npsOvkfTgCsBQAd532lqpkyHDFybLU/bw1umZbElAnOldxghBomIr4bxM2t8lBnOAEyZRZAXdBN
	hiaz7oiSsOEUQTmXRgNGoBYcIhmFm4VtwygMijJ5TsyBRxDqUZYmlOeDXnCy3cw==
X-Gm-Gg: AYBFou3Z0fSwbo5o4LwBS2ov9rGp7De1j3Nd63dJyT0iAYV4EfdCv/Vs//yJ29ZfDqe
	hfROTC6RVW68DfiPFItyTJ856fwWg39xKdkXUGhu0P+rez/cOYAj6lZAyOvxkB/6p7TDzE+O7Bi
	FZfXaXGL96XBJie5V7mFMaUIz4NnM/iCDjPHEHjpxM+/SBHOV4x7ED5dBC5BObYDrmTLnjoHIWy
	TzDKUURrgjNggaE1xDvOkocxiS8oOk81jKmluExUS/F2CmNC5ooASMJx8IkYzZEY3yNwqK+tKR+
	dHoUxXcE8MW8DULB+/sNYOInACuUIeOx6q252hiZaobOKBxeLx/vcmMNcobtvHiWxUYxvFoLmvD
	bdYFog2KTLQJZgBBg3iinAw==
X-Received: by 2002:a05:600c:c084:b0:49f:d6f0:6f24 with SMTP id 5b1f17b1804b1-4a1d75af414mr2646085e9.2.1792163854056;
        Fri, 16 Oct 2026 08:17:34 -0700 (PDT)
X-Received: by 2002:a05:600c:c084:b0:49f:d6f0:6f24 with SMTP id 5b1f17b1804b1-4a1d75af414mr2645825e9.2.1792163853710;
        Fri, 16 Oct 2026 08:17:33 -0700 (PDT)
Received: from maszat.com (85-67-2-18.pool.digikabel.hu. [85.67.2.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm64621665e9.14.2026.10.16.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:17:33 -0700 (PDT)
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
Subject: [PATCH v5 09/10] fuse: add support for striped backing
Date: Fri, 16 Oct 2026 17:16:36 +0200
Message-ID: <20261016151638.2962413-10-mszeredi@redhat.com>
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
X-Mimecast-MFC-PROC-ID: UrcpLEFKlTKrBsJsFgvivKIV8FnE5gJF17cE8BOftkE_1792163854
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
index 8419a4d3451b..4a63268c4b25 100644
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
index 43a92d834cd3..616430a2973c 100644
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


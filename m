Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73008370AFD
	for <linux-cxl@vger.kernel.org>; Tue,  6 Oct 2026 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309705; cv=none; b=udgIusntEWkSKKfPZOtM3qYvLeVDOYUTxre+upHNTECQEVGuuzo3y4wxIC4jRDubceuLPFfI5pV9Sx+eyCG88GA36mhd+diiHZtxqRNhGFHnckc523Xv8Q350OI5VFv8A5/mp7pJnkBc7cgOJwgDKwWgoQZ8ic/AH2LYhtUqc3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309705; c=relaxed/simple;
	bh=DjhcPylcHhCqjFXAuyirPeUa+NH5Ei9QeLolft6Argk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=eoZj0EiQ5H97xFSysmv0icPTwuWvx/kRVBVoKtMRBsf5Lx7p0Fo7EsrJuBXI506ifRYhbyf5uQqLAj810nMuuuxQdMhU/T2UwfxXhX1/WF1mrowxL2UV2CvBFyza/Ce18LP9QCIldXd3xnJ5mQkrktNwDQPKediV3Ic/qOidops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KeLFoopD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeLFoopD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791309702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+EleZpynb4+a3XFu5iGO0EyTuAjdCIAH6pPcLUR432s=;
	b=KeLFoopDRUkQ2WxzpIsvZkXKpOmSxL+hj/QtJIizX7h+UHpUjz/VtnBOuIKQAop5uHZrNf
	wqDBFyE2S2Of8TuV1wkeZ+0BiPT7kKhYbpHs7J43Y6v6WZoLTzMdFKyaesBXKWQdEqMQs8
	HnNccFFTCe/h6dUtlsdD/3hqQ8JCYqc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-pnm1G63IO76tjXUMSI0oqw-1; Tue, 06 Oct 2026 14:01:38 -0400
X-MC-Unique: pnm1G63IO76tjXUMSI0oqw-1
X-Mimecast-MFC-AGG-ID: pnm1G63IO76tjXUMSI0oqw_1791309697
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2e2a9fa1fcso394732866b.0
        for <linux-cxl@vger.kernel.org>; Tue, 06 Oct 2026 11:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309697; x=1791914497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+EleZpynb4+a3XFu5iGO0EyTuAjdCIAH6pPcLUR432s=;
        b=pD/1k6mu+GtiyTp+5lEJLnVia8ix7CPU4Q7DF3BFIWKLhPncOSNX7x8HkrcSukYGtL
         e4rtp76NPvBctC6UDXY/9M523JhmSabzeNcJStvoU+iDhCRaKsJbUmcByFN6xXz/0O7L
         0mJ9f4mdNssJyUNoBzGJbhSIML+mTjzO4aFqCP4/cwIOwnQvWqxuTLX5tJ2L7DCjdJjU
         G12qpAHMRiw+OeiXbMtNryxbSbJDagt60TpxvrjIXi1WaHfiQ2y8qEc3wT5mKsh3z4MG
         b6fFrRFy6PWxanfYH0tVdX8Sv31gTHB4nGSnRmAkko1LNNGTF0JiPxktmkoGg64muYo3
         hdHw==
X-Forwarded-Encrypted: i=1; AKwUvByn/jSntwAWxKbQT325IscDyM6qGCjc40xQvJkAC5oCGS5fSrM1jQo9nMgMwvVaeJ9DxydEuQyxAzI=@vger.kernel.org
X-Gm-Message-State: AFuF++l4tesrlpweh5KLpQyW1GUhv1GASwUb5ifYRm+nOi9wkI6whUhA
	AZaXHIKXSbkeuLt/sHBqKJdMpZTyU0fWtLlQVwFuRxoGryYrDcnnpWGsjvjYTDZ6Nunaoc1DofD
	q3P4DUDGd5RrpZfm5kTYpbXTP2C7LjsqpNM1I7aQ2JgPclt3H/GV3DVHvMmNs3A==
X-Gm-Gg: AYBFou2+Q9gHX7eytu9yIeI9lTm6Qp+dJcYQbWldEBbc2X06/veTAUJlX95DC/WIN0s
	qPOad7FHA+hHBcJnciz7FP4cEta1vjxRHKzexf5Drc9kw3fLN1KXiykgizjnhIQ4sW5DRZMoK3Y
	ejt0W7TpR/PACe1OHHHtswl1bKDEK2UPDtErNUdvFYK5hC/SI/lEQUq5OfHTTKUgjhTwXih5LOR
	/WKltCbCF9V4WQpgdzwmfRX8cFSdkVXtAe4mqDym2cg3Peub5rbL97s69WTsQMDZ0T7A5fusFMo
	J52SB1c01itJpfjce7FaQC/Zss9QQ/lD7AnUTrltHX69O5oQvSPSXKs50SMkTPJbrresJK48MU6
	nHcQNLv9dXH7J45dhacn2ibu2x+rpy9KNFOJmpiRo59WkL4kMmrqB5DkE
X-Received: by 2002:a17:907:3e07:b0:c2b:4142:2db1 with SMTP id a640c23a62f3a-c316a0c01b1mr244831666b.40.1791309697135;
        Tue, 06 Oct 2026 11:01:37 -0700 (PDT)
X-Received: by 2002:a17:907:3e07:b0:c2b:4142:2db1 with SMTP id a640c23a62f3a-c316a0c01b1mr244829266b.40.1791309696784;
        Tue, 06 Oct 2026 11:01:36 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-152-55.pool.digikabel.hu. [188.142.152.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e5942sm5056684a12.9.2026.10.06.11.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:01:36 -0700 (PDT)
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
Subject: [PATCH v3 9/9] fuse: add support for striped backing
Date: Tue,  6 Oct 2026 20:01:14 +0200
Message-ID: <20261006180115.1425232-10-mszeredi@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ZVoY_ebvBc5azefKL9770aILMWCY5jusIMErs_vJEvY_1791309697
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
index 4f418185c0b7..049e0b4514bc 100644
--- a/fs/fuse/ext_map.c
+++ b/fs/fuse/ext_map.c
@@ -109,12 +109,18 @@ static int fuse_ext_map_iomap_begin(struct inode *inode, loff_t offset, loff_t l
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
 
@@ -127,9 +133,15 @@ static int fuse_ext_map_iomap_begin(struct inode *inode, loff_t offset, loff_t l
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
@@ -256,6 +268,7 @@ int fuse_ext_map_populate(struct fuse_conn *fc, struct fuse_notify_backing_map_o
 	struct fuse_backing *fb;
 	unsigned int i;
 	int err;
+	u64 chunk_size = 0;
 
 	if (!arg->num_extents)
 		return fuse_EIO("no extents");
@@ -273,7 +286,18 @@ int fuse_ext_map_populate(struct fuse_conn *fc, struct fuse_notify_backing_map_o
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
index 5d38dc1b6f0c..cd10156e09d4 100644
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


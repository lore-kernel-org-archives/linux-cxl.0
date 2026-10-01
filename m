Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94951DAEA
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867387; cv=none; b=OvypV+gvBaGqFMcCg4BV+7Ik/wpuBwU5LFLf9x0YI4P7K2IP8vqSFhOBkWML8FfDm3Fd5GqGebQDSG9nz9I2pbEkg1RoHCF6pG/Sc/LlxJLuvmIsZN68xngjxw+ooSKYEJBqe8Q1FplTi20rdnvitT2QqVAJT/+VWuM8EkSGrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867387; c=relaxed/simple;
	bh=QqGsxUZuEtLO/SWJKab8EXCQqECv/GPyBy+79b3jBMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BLqQUUYucUmC1ngL3nKc6yNP1zQJBd7swg2WtZ7P5c7c908AbkS1CFjISVEJ5JxXwEyg9qhfhEv2qzYxCfXqWN4BwQ6IqtGBXmLEb/xX4JMriKKrtN8z6VqThmFpHj1/OROeAvf6lzdPcHsaTrJmAHQwZVUHSkZ+Hio2bNcnwqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YoQGHLAC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoQGHLAC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790867384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUOje82dfH+H4WczVQo1AOkLQDRbkjxsMyPdE9CHREA=;
	b=YoQGHLACTliSShMZaaVi9MtPMjtFWdecjt0tqoa4d5Fl/EGwtBiZHEQ0+d0wYePgW0H0VL
	zbW7Zgt2zWT9p/BnKntq0wsKKlF1nN2tmMlScDnnp8s7vNEZcOovkMu1D6lqAKnApVNtaX
	KPUMcYvhqzzl/usLMRFJENqPoyixipk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-QuoaL9OQOv6OQG7htlKrNg-1; Thu, 01 Oct 2026 11:09:42 -0400
X-MC-Unique: QuoaL9OQOv6OQG7htlKrNg-1
X-Mimecast-MFC-AGG-ID: QuoaL9OQOv6OQG7htlKrNg_1790867381
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c25501f4aa2so427523966b.1
        for <linux-cxl@vger.kernel.org>; Thu, 01 Oct 2026 08:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867381; x=1791472181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wUOje82dfH+H4WczVQo1AOkLQDRbkjxsMyPdE9CHREA=;
        b=Clo4uHtOHECpGsLaqJOVHlSBkuVvu8uf3h5cT9OsznqpsVS46+GxOVcV4ewGg4D8Jp
         0a6+wKDnVoprRgOErBuwIbXvJM3vm8I8P2Bi+ioUfmEitwgpf9e00zszL+mL68fkvvi0
         PQkX3deehNdeOTKh5X4XRkacw/6JvklYeXP7obk2EKp24z1DCI1xOyRO4WXl88rNvSrr
         5b9P/AJX/IyEOu00bUM9rwfng0w38OvyYsWqDLI3IhXvHFUe1JA0tK3GOtQU42pM/BwZ
         PFDMlVGttRoPR5L+oXVyNEsfGCTeaoq9BcxJ3f7XHhdTA2oLHOTHckDe17v6nsaSPtxg
         DePQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsRsf55WkZuMUjXXOPb+KLv31VnGQF3XXAWvVlDfv/igIGoUVeizQSfjWUIYFdAFAXkvB/SQ/aulE=@vger.kernel.org
X-Gm-Message-State: AFuF++kTfmDAKV297Lvkif1Bq1yOxVzfcjNXP1hvSgfziQ0kGy510weQ
	WR2VahbtENBAa6MmtzoLJwuKkRs79doclEbh5vmv9kfpFo11Vk9UaVkR9C9+yzr0WqxUUI42sYt
	E2uUG0w0o0vvnUsYFISWCohazq77j8VTzJR4WEUU2kB0FSDrqnixBmjv5o4TfoQ==
X-Gm-Gg: AYBFou3DKIVouJGhxRS0Q/C5gHcYdTiRA/OsS6ye5qIQ3t8zyf9pzgyGp20wPtDWwuF
	hEwbY4QsQcVTjb3R8AuhXt67IbwKwdWZji1nTmhj5coN+X1Pc5qHUgWEKRikc8cI2urBsR2Xo96
	2CNeVHwjbEwYuxkU3Go0RsVVba5AkC/auM/PgZu5PlaEbEBwk0Lf/j8KtHy1L+Wb6JU8OqshLLt
	Wxxr2yfuB6NV0M/ZSQGVCoQ99+01TW9gIgewDOz3a58jKMBawDr46QeebU40ERlikzPYpEVG/Du
	cKxBZSBtC9iRyv1OSrJUPdKHt5Q4cT3L0oNey9mBkkNjXpQv+3X2FNM9zX/YrQ6pCi2BIJgbIVa
	jElgBuaD6ymkHUKR/y6c3OjODkLydlbtSZl/THZUYejIEi28QyIUI2jg8WsY=
X-Received: by 2002:a17:907:9691:b0:c2a:86d8:66bb with SMTP id a640c23a62f3a-c2e33d39b2amr286839166b.10.1790867381427;
        Thu, 01 Oct 2026 08:09:41 -0700 (PDT)
X-Received: by 2002:a17:907:9691:b0:c2a:86d8:66bb with SMTP id a640c23a62f3a-c2e33d39b2amr286836066b.10.1790867380994;
        Thu, 01 Oct 2026 08:09:40 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-245-188.pool.digikabel.hu. [193.226.245.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d86372sm177735166b.56.2026.10.01.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:09:39 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: John Groves <John@Groves.net>,
	John Groves <john@groves.net>,
	Amir Goldstein <amir73il@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/8] dax: replace exported dax_dev_get() with non-allocating dax_dev_find()
Date: Thu,  1 Oct 2026 17:07:19 +0200
Message-ID: <20261001150935.655979-2-mszeredi@redhat.com>
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
X-Mimecast-MFC-PROC-ID: wr23dkpeURvv1pKyL4ry7tKNQOZX90km6uwkoY_Njfs_1790867381
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: John Groves <John@Groves.net>

This fix is in response to a Sashiko review, and some subsequent
analysis.

dax_dev_get() uses iget5_locked() which creates a new inode if no
matching one exists. This is correct for the internal caller
(alloc_dax), but dangerous for external callers that look up devices
from user-supplied or metadata-supplied dev_t values:

1. A new inode is created with DAXDEV_ALIVE set but no backing driver,
   no ops, and no IDA-allocated minor number.

2. On teardown, dax_destroy_inode() warns because kill_dax() was never
   called, and dax_free_inode() calls ida_free() for a minor that was
   never ida_alloc'd -- potentially freeing the minor of a real device.

Add dax_dev_find() which uses ilookup5() for lookup-only semantics:
it returns an existing dax_device with an elevated inode reference, or
NULL if no device with the given dev_t exists. It never creates inodes.
A dax_alive() check under dax_read_lock() guards against returning a
device that is concurrently being torn down by kill_dax().

Make dax_dev_get() static again (internal to super.c for alloc_dax),
export dax_dev_find() instead.  Also add the missing CONFIG_DAX=n stub.

About the 'fixes' tag: this removes the export of dax_dev_get(),
which was flawed, and replaces is with dax_dev_find(). It feels like
the fixes tag makes sense for correcting an ABI error.

Fixes: 2ae624d5a555d ("dax: export dax_dev_get()")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Groves <john@groves.net>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 drivers/dax/super.c | 38 ++++++++++++++++++++++++++++++++++++--
 include/linux/dax.h |  6 +++++-
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 45f84b0eb909..824e1f6df378 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -565,7 +565,7 @@ static int dax_set(struct inode *inode, void *data)
 	return 0;
 }
 
-struct dax_device *dax_dev_get(dev_t devt)
+static struct dax_device *dax_dev_get(dev_t devt)
 {
 	struct dax_device *dax_dev;
 	struct inode *inode;
@@ -588,7 +588,41 @@ struct dax_device *dax_dev_get(dev_t devt)
 
 	return dax_dev;
 }
-EXPORT_SYMBOL_GPL(dax_dev_get);
+
+/**
+ * dax_dev_find - look up an existing dax_device by dev_t
+ * @devt: the device number to find
+ *
+ * Returns a dax_device with an elevated inode reference, or NULL if no
+ * device with the given dev_t exists. Unlike dax_dev_get(), this never
+ * allocates a new inode -- it is safe for external callers that are looking
+ * up devices from user-supplied or metadata-supplied dev_t values.
+ *
+ * Caller must put_dax() the returned device when done.
+ */
+struct dax_device *dax_dev_find(dev_t devt)
+{
+	struct dax_device *dax_dev;
+	struct inode *inode;
+	int id;
+
+	inode = ilookup5(dax_superblock, hash_32(devt + DAXFS_MAGIC, 31),
+			 dax_test, &devt);
+	if (!inode)
+		return NULL;
+
+	dax_dev = to_dax_dev(inode);
+	id = dax_read_lock();
+	if (!dax_alive(dax_dev)) {
+		dax_read_unlock(id);
+		iput(inode);
+		return NULL;
+	}
+	dax_read_unlock(id);
+
+	return dax_dev;
+}
+EXPORT_SYMBOL_GPL(dax_dev_find);
 
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index fe6c3ded1b50..29113eb95e72 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -54,7 +54,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
-struct dax_device *dax_dev_get(dev_t devt);
+struct dax_device *dax_dev_find(dev_t devt);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
@@ -92,6 +92,10 @@ static inline void put_dax(struct dax_device *dax_dev)
 static inline void kill_dax(struct dax_device *dax_dev)
 {
 }
+static inline struct dax_device *dax_dev_find(dev_t devt)
+{
+	return NULL;
+}
 static inline void dax_write_cache(struct dax_device *dax_dev, bool wc)
 {
 }
-- 
2.54.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF02412BF8
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458416; cv=none; b=GgSS4UNi3W6xtHvz61lB+lTuFjgHqaCWplf/EbtBmU22r3tyvSQPUhsFuOl+yxlChdPMlHXgYZL4jSyRqy59vl5AGQENmtbkuBErbzhccuwARfEvkHIScUZCFNpVBUKhI44a9nmNU+F0efdpBNlvgfwgAj/a/O6IrkRB3+3YXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458416; c=relaxed/simple;
	bh=19IqXmwYNsjUduLj1avoZqwv6d+lKaGH67IsveE7tU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=G1wkKTQ9757I4c7BFtoUuJrz5YtDuRZLddmFm3wkztnTbatWdtF4ZbmiaQSvDlcmfmuwXzavsWBPdQcFH3K74VfrHpM/p3I3gc0+h9Y9vTJ8fN8DFfd0JVED6d/2UKCFqw8lu+AHdDlhJy+3QvXK9McMt4CFCwBcX/0wCkxwHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/C1f6Cq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/C1f6Cq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791458413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+dzW9NAcK/PemMwwdCNYcD+RAltqa6Xku44UsRnnuA=;
	b=b/C1f6Cqgzgv0anOEjTIQs0qHKIVqmYOjMuKuGelRbkbNyMGLVdhaXJUf3tNW3A0WG8hxr
	CqiTJlUnPjf2xANO/Ft2i+g3E5xcIjn+AzybfSLw5m+mSWkQho4AVnPnoQIwwhGzOx0KIl
	uW9Onv3YYDT/kWiQtw5bJ4WikannJhI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-MjdhpUCcMnWYiD_z3jCl4w-1; Thu, 08 Oct 2026 07:20:12 -0400
X-MC-Unique: MjdhpUCcMnWYiD_z3jCl4w-1
X-Mimecast-MFC-AGG-ID: MjdhpUCcMnWYiD_z3jCl4w_1791458412
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c3167afb84fso338807466b.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Oct 2026 04:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791458411; x=1792063211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+dzW9NAcK/PemMwwdCNYcD+RAltqa6Xku44UsRnnuA=;
        b=JPrlEVPZXsabIJ4eJ3EJk2vdu9WUurHB2XmHifUpxYJ7PxBTRct5nxsnQGp/UsQGyP
         bToTjsY5NjiyAOF4sGJAYUepYMGMnvmewYQOx8z/DJiCq0LYbn+QEDvgjXbzmpeAPfNe
         T7c2lnN609xEUXesjDZDcExmHizqCOe3RPMzfe4q8hD045mMI14ZqOQFbnM8+srSSLk5
         sok9Wsw36nBjHRVpj9pQo3YYiJzcDAoy7+SizokAVfsv9quJuKLFzJcr1bklzLnmYDeb
         OT8gpHqRKT6nny8fz/Oaj+xFVy/zOJDxCA3Zu7ltlAp1E2/gXSLW+qvZr/7bNjt7Vkrx
         OYOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtNLtARfy71MxLztil+k9VczyvDG9TDI45dMOfXSeJ2bC4cDz7pPnQkswFpRtHWV4MxglrfpW4Amo=@vger.kernel.org
X-Gm-Message-State: AFuF++klQ7jy+gHKZYV6J2aYnA+bPARTwOW05foVxGJhKuNF6QHOlETV
	SAsQNymEMX6OaOr1iMTS5oBAxjTs3ZnN8m0V5ijCAXR12HGUj9W491ilEbKP/ZiAG83h/Hd/HZu
	NnmdTGClSVQOKpZs5WwysLe+Kx+ogSeINjG5SzB1EMnqaripAz6NxRSpA+2ynQg==
X-Gm-Gg: AYBFou1YS/EyTFQZsYAVuB0M4u3urH00PVINS9jFxgpVly4X28KDVbR5/peOKR1yuF7
	keR9RuVdfHk65BnpO+cB1o9EYcT+eJVp6nyAKts2eAinQ6isKGxSJtZvVpttegOiJCd7VhLBKdp
	bbfWSuXoYa0A9arjowkGFHHkO7V5XhLCRJVvbJiUtJ+MHKo6LKM7uf7L152h10w67Tvsa4ua3Cy
	tbLvA/lhpRVmHppU3nQAKZ6cSGbbCsMXd7wcliVA8x2M+3mbtm2M2+Rt7il8QelIsqXG+6Hr//b
	VcFUNQn8zXKin9pZ60Ip3IH9D5m248Esbp4GhXaTEYaGZryqJkl7ep4wF0ceBV7ibFgn8ZmWXjG
	BK2iXPsIa9gw3EgzCW9ZpkK89uTb9xjgkJzp0I9reB1jpDGHgRu7sRlTy
X-Received: by 2002:a17:907:9483:b0:c26:1648:a060 with SMTP id a640c23a62f3a-c317be37b20mr508928166b.27.1791458411515;
        Thu, 08 Oct 2026 04:20:11 -0700 (PDT)
X-Received: by 2002:a17:907:9483:b0:c26:1648:a060 with SMTP id a640c23a62f3a-c317be37b20mr508920966b.27.1791458410178;
        Thu, 08 Oct 2026 04:20:10 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-152-55.pool.digikabel.hu. [188.142.152.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c2fae53sm204251866b.49.2026.10.08.04.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:20:09 -0700 (PDT)
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
Subject: [PATCH v4 1/9] dax: add fsdev_dax_from_file()
Date: Thu,  8 Oct 2026 13:19:52 +0200
Message-ID: <20261008112004.1899560-2-mszeredi@redhat.com>
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
X-Mimecast-MFC-PROC-ID: gliYeAv88-KeSXK6jBH9ddmyuU7dsMuGpTyZZhuYyPo_1791458412
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: John Groves <John@Groves.net>

If the file is a fsdev_dax open, take the dax_dev from the device inode's
i_cdev.  Return with a reference grabbed on the private dax inode.

Make dax_dev_get() static again (internal to super.c for alloc_dax), export
fsdev_dax_from_file() instead.

This fix is in response to a Sashiko review, and some subsequent analysis.

About the 'fixes' tag: this removes the export of dax_dev_get(), which was
flawed, and replaces it with fsdev_dax_from_file(). It feels like the fixes
tag makes sense for correcting an ABI error.

Fixes: 2ae624d5a555d ("dax: export dax_dev_get()")
Originally-by: John Groves <john@groves.net>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 drivers/dax/fsdev.c | 24 ++++++++++++++++++++++++
 drivers/dax/super.c |  3 +--
 include/linux/dax.h |  3 ++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
index 598604bf5ac5..04b04d0d3da5 100644
--- a/drivers/dax/fsdev.c
+++ b/drivers/dax/fsdev.c
@@ -234,6 +234,30 @@ static const struct file_operations fsdev_fops = {
 	.release = fsdev_release,
 };
 
+/**
+ * fsdev_dax_from_file - get dax_device from an open file
+ * @file: open device file
+ *
+ * Returns a dax_device pointer if @file refers to a fsdev_dax device.
+ * Otherwise return NULL.
+ *
+ * Caller must put_dax() the returned device when done.
+ */
+struct dax_device *fsdev_dax_from_file(struct file *file)
+{
+	struct dax_device *dax_dev;
+
+	if (file->f_op != &fsdev_fops)
+		return NULL;
+
+	dax_dev = inode_dax(file_inode(file));
+	WARN_ON(!dax_alive(dax_dev));
+	ihold(dax_inode(dax_dev));
+
+	return dax_dev;
+}
+EXPORT_SYMBOL_GPL(fsdev_dax_from_file);
+
 /*
  * Acquire the dev_pagemap for probe: the static (pre-populated) one if
  * present, or a devm-allocated one for the dynamic case. Note that
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 45f84b0eb909..25836f389bde 100644
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
@@ -588,7 +588,6 @@ struct dax_device *dax_dev_get(dev_t devt)
 
 	return dax_dev;
 }
-EXPORT_SYMBOL_GPL(dax_dev_get);
 
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index fe6c3ded1b50..2c9fc81f031b 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -54,7 +54,6 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
-struct dax_device *dax_dev_get(dev_t devt);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
@@ -323,3 +322,5 @@ typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
 			    const struct resource *res);
 int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
 #endif
+
+struct dax_device *fsdev_dax_from_file(struct file *file);
-- 
2.54.0


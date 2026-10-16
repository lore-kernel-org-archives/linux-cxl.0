Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542254DAF84
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163848; cv=none; b=tLK9WCWC/qIWpcvHQTnE8ezqIsVCa9Q1J11eUEjnEbFWHfycWKyCvlqHGhzki6avgN9yB/A44q/Z4BfIZanEFpksO86r42XNXY1WlZCsQvBCXmldMlMdxYwFEyhGmjjztOIm71yOksUFSPzRJtsgcEarGVB+wE734TZjJx22nhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163848; c=relaxed/simple;
	bh=YUkw+dai85UeClnTY/cNJI38d36WxPxX1F8i1DhNk+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KlyXmqq3p1owFBQdze6YMy+GJsqLzPpkC+bJBrr/PGGqMu7sN10rNz9UQcfCO07WCh9B1qXOPqGcsYjqHWq90yj/KkC9A11SbTgBMi9eTY/QDr2Cc6+4ZTQhnrIwd/onOVdkYm4R/uRJXhMs4oWvRoQYD7pYSZUehSzP6yGsSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaQKFElv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaQKFElv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792163845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TROMxDl8UrJYxG0M+aHIDtSYaFMtjE8ArsPy1R4PO0=;
	b=eaQKFElvlOovPhnQf7FOaPohVGFXLAU+B8IcCSnisvyH2rPWOcvp6AkITamB7fL5sN+0n+
	rRFc/UD5ZAterVHfXQDUhBySwmnsT2DBxqc/9ttuSh1lmin3BHTaAsS6mBXBEpf5DNTG/6
	QMubVQw+NSko/gCww375PMyRhBEsaPM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-YYRowuuRObKxH5fuNhIAyA-1; Fri, 16 Oct 2026 15:17:24 +0000
X-MC-Unique: YYRowuuRObKxH5fuNhIAyA-1
X-Mimecast-MFC-AGG-ID: YYRowuuRObKxH5fuNhIAyA_1792163843
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so416775e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 08:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163843; x=1792768643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+TROMxDl8UrJYxG0M+aHIDtSYaFMtjE8ArsPy1R4PO0=;
        b=yyv+0z1TO05/p4kT9DgMmT16uQiYCOqvmZFX00Qotqooao8x1gKNkmqAUjv9pYFy22
         QdvC1WVf4esFAsmf1nmyAPapDsdxZkO2PomFL3/CaH5Ihn9WWyOiVO5+LsGPwWYnWKzo
         DtTwrhmQs4HQ92zfSVIEii1B3O0j2RlS7XwAM8w21JGWo/dGnT3HDiRE5BArL9y5MTWl
         npw4itOSmZIE6nooAQxQ0HNPS8GKHss123JiOjIJbGDAml4oRSLomJ/8Ux9nbxCaNWSt
         tz+AVrbDLS9eT8cTzzCY7VPQS2hzep2odDF1MfN2RnO3H7INnYu6fA9joCGaGr4mA3Yf
         JGgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKYIeToCPpYCp/VG2e4FYy3HqqZift/3MX5Vh0BQKwn9CZBP9JZq9oGpBlxLwb4Z4w8PeyEJdE86A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbK3GKrYRhYO0JVJHXl/QnzsCcN4uaWhHFMTdwymsVsAVUwqrj
	8sbn4rBpTdmJtPFKVSUkQRBumfI1Wrt6UMmNXs/ftDKKAZaPySEBuidtAnAE503DdXGSrKCKdjx
	n2JZMLI7RCMduujtiTsheHfjajeEQyv1V60eQnNyRYAP6mmzeAg1fWfe589cBWg==
X-Gm-Gg: AYBFou0cMVPNJzAh4Wxs7ROu2ehzqbCOp7IrcxHgx4AnuMhrdXwpFNwlswHBSU1NxUL
	NYGCErdxTUHwHAmHl1IeIlU3FOnyL4UfPXh+EYK27OGZtoeEzbGZ650x3UX9q+rxrtegZpr2NP7
	QgX1K+EW/tCW5YfSj/QfAYFad1APLsJTrJSSVsVFqeAityZB7TjpdKPd1316k8PnZVsYSic4E5r
	BIuMqVt4ZB1PD624FgcsWoRfo1rC+OSDk1fAOiBpwjQ4sc6tkbnWkdyvgEKz33KCa/HS5XMn9HE
	Uc5c7fclB8t9pS0UkKQfBBq3WcN1md6woJxJ+fYYq0CrGr3CraspFfh/EZuswDiqT77gA2AjI5C
	0/u6/LddcmBxqlrOj9Jh9Sw==
X-Received: by 2002:a05:600c:1393:b0:4a1:d248:25b5 with SMTP id 5b1f17b1804b1-4a1d760e327mr2401125e9.24.1792163842813;
        Fri, 16 Oct 2026 08:17:22 -0700 (PDT)
X-Received: by 2002:a05:600c:1393:b0:4a1:d248:25b5 with SMTP id 5b1f17b1804b1-4a1d760e327mr2399225e9.24.1792163841216;
        Fri, 16 Oct 2026 08:17:21 -0700 (PDT)
Received: from maszat.com (85-67-2-18.pool.digikabel.hu. [85.67.2.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm64621665e9.14.2026.10.16.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:17:20 -0700 (PDT)
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
Subject: [PATCH v5 01/10] dax: add fsdev_dax_from_file()
Date: Fri, 16 Oct 2026 17:16:28 +0200
Message-ID: <20261016151638.2962413-2-mszeredi@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fmm79VMEvnoCF-gKvAF1RNL3BNXbSv5MHpZGEjzZlq8_1792163843
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
 drivers/dax/fsdev.c | 23 +++++++++++++++++++++++
 drivers/dax/super.c |  3 +--
 include/linux/dax.h |  3 ++-
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
index 598604bf5ac5..910665c1f492 100644
--- a/drivers/dax/fsdev.c
+++ b/drivers/dax/fsdev.c
@@ -234,6 +234,29 @@ static const struct file_operations fsdev_fops = {
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


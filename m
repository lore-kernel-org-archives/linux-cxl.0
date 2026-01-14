Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7C368283
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426545; cv=none; b=vB13Mu3n0kUW9MiwuXmWNklcxkVgSUJrlaRR9SCCouJMCIUvzP8y9SWikRmlIKubRBDGC7AJhxkAbmTy1r2zq0+DcVPDKONyXMKIPFGp2Mo1vdYQx97sMdvZQreY1WR4fS3UoQZn2vmANC9Np6chq0kJmWm5Uw/m29JOEO6PqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426545; c=relaxed/simple;
	bh=Ifuf2L6wRVVt+3qNeBjdLicdVJ8UNwMl/Wbxz9ngJzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcQatd9/+AsgZpTBhF9lQwILeZXYGJatce1nUBcteMHRO5VdFp8Bw/aCHxCMcMTRUdaSKU2pepRufs4VXUxEuBqOd3wPNSBrON7vN+vd64OkOdxegGlmT/YJz7bbY/J4UomrS4QruLTb5QkezpW0GMnTlvmGRSORQQJertAdEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKJXNjXR; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKJXNjXR"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40423f8c5faso171297fac.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426530; x=1769031330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPBFShXog0UoyhMxz+wxzMnblXj48CNmW7x9zXtvk2c=;
        b=nKJXNjXRM8Zliu8M/KlKk+1v4a5LztVfsrmeTshpcfOHC4ohxwT2cEW7Pvdew6pRp3
         dEXNgPpUsx1XuR//IznBqqrQARbPwqtfplUOfCV2DrnwzUguBGCMKTR+g/+eKr5tBcxM
         L392xxXOFaEQWBsCdvBcGlPzw+memAaxndcxwYaFlnpSTf3ElWsS/zOz+G3I3Fno9WJh
         I0H0IE1Nbc/ErD1kV/J2c6lM5mSMKJDpMTmYukzE643qXnwnwOhZ+dk9yjPQXT/v70XQ
         BOnUOZlr2+13spvb9+cqJFm9Z/Qx8DaFEvclYCWNxwVgY0It5MJ2nsI/cHUUQ46bkmkK
         oI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426530; x=1769031330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPBFShXog0UoyhMxz+wxzMnblXj48CNmW7x9zXtvk2c=;
        b=sn4b51P1v4KhE4vfppLE62gZzJaFird4YcxC1+GVzdh1BHOtqZG9byzCa5NEwo61Dz
         oITvbt9/2nfwFg5MHobxMBA+7h43Fv1SKTf0TnnfJ/rQjTf2tVGVuBvRIW/aPigQkNOt
         +wKC4cdZLiPuFmqXMM7Hih1KWomYqDpdzZSKQLkXyDbZp2fqAXU8pyTgm9FyvW4inzuD
         DFy4k1ZF0g+drcVv0cCNZ4TiCLBzIW+MFklusLPYf81JuQDNfitGO5F3+DVGq14uv5DR
         0vKT7Knw1n8iAcgdyCra+E+WWJMwiS79xInfAwfHeVV9mNgmS9gLGLqjTIQHepAFQPvp
         ovlA==
X-Forwarded-Encrypted: i=1; AJvYcCVKJ3Kuy4tLM2N/YljE6+K+xbEKqbMGvogQIyllZOKIZCdi2Gm7CQr7WiZaH1rWOMMN0muWO38sIOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTl+7094a9DoVE4y/GUUDyozXZm5gO3QDiT4sNqzd3VFvlh8p
	Qc4UuQkLrYRIa464yv6tCLGU8UlHh9mFJXuzhwg3T6vkaIs5Fav0ARBj
X-Gm-Gg: AY/fxX60BkrVfSbRVN/fvsZ3poSZLIiDAzIupyP3LhDT55PTUX+1dqWAEVXlZgQzjO5
	ZA3WCnMtFWmg3p13PAZ+TqA2kYXcs2opuQD8ebEsp0DmJ5L/VvqXYqp/jthQ/T4SS/VPiOyezy2
	NAwtvnve0RZ8I/jBlL4mLgUkt0iNRisPo6yl/QLdaPkCjjlRmC9gWyLcguBIDGXbmVoc2xlEpTp
	t9y2p9GUGIRFyu4+k1A/gsJygl/MAm64tryuboLLW46nsGVoAL0qIq1WF/hpSGtCq3oOi0yE3K0
	e8118YRjp3EZEnxsls/tz6U3DEumPI6QsA6r0htDUFjeQBebDPA8IvX97HmVf+autcjfF6KfeCJ
	ESeSwPA5WDvxDUgzxSnsnzUmqzqd/hx7rXXiuRAqL4G41X8mIuFxpjetivDwDZPZU028OMlELJZ
	N2ZA89qX/8uIqA3xCo7zbTkKjXLWS5qv6+nsFV/xWJkQ5v
X-Received: by 2002:a05:6871:8b0b:b0:404:1da3:8005 with SMTP id 586e51a60fabf-4041da384acmr1095432fac.54.1768426530025;
        Wed, 14 Jan 2026 13:35:30 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa50721a6sm17707178fac.10.2026.01.14.13.35.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:35:29 -0800 (PST)
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
Subject: [PATCH V4 06/19] dax: Add dax_set_ops() for setting dax_operations at bind time
Date: Wed, 14 Jan 2026 15:31:53 -0600
Message-ID: <20260114213209.29453-7-john@groves.net>
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

From: John Groves <John@Groves.net>

Add a new dax_set_ops() function that allows drivers to set the
dax_operations after the dax_device has been allocated. This is needed
for fsdev_dax where the operations need to be set during probe and
cleared during unbind.

The fsdev driver uses devm_add_action_or_reset() for cleanup consistency,
avoiding the complexity of mixing devm-managed resources with manual
cleanup in a remove() callback. This ensures cleanup happens automatically
in the correct reverse order when the device is unbound.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/fsdev.c | 16 ++++++++++++++++
 drivers/dax/super.c | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/dax.h |  1 +
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
index f58c88de7a4d..d658942b7143 100644
--- a/drivers/dax/fsdev.c
+++ b/drivers/dax/fsdev.c
@@ -114,6 +114,13 @@ static void fsdev_kill(void *dev_dax)
 	kill_dev_dax(dev_dax);
 }
 
+static void fsdev_clear_ops(void *data)
+{
+	struct dev_dax *dev_dax = data;
+
+	dax_set_ops(dev_dax->dax_dev, NULL);
+}
+
 /*
  * Page map operations for FS-DAX mode
  * Similar to fsdax_pagemap_ops in drivers/nvdimm/pmem.c
@@ -296,6 +303,15 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
 	if (rc)
 		return rc;
 
+	/* Set the dax operations for fs-dax access path */
+	rc = dax_set_ops(dax_dev, &dev_dax_ops);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(dev, fsdev_clear_ops, dev_dax);
+	if (rc)
+		return rc;
+
 	run_dax(dax_dev);
 	return devm_add_action_or_reset(dev, fsdev_kill, dev_dax);
 }
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c00b9dff4a06..ba0b4cd18a77 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -157,6 +157,9 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 	if (!dax_alive(dax_dev))
 		return -ENXIO;
 
+	if (!dax_dev->ops)
+		return -EOPNOTSUPP;
+
 	if (nr_pages < 0)
 		return -EINVAL;
 
@@ -207,6 +210,10 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 
 	if (!dax_alive(dax_dev))
 		return -ENXIO;
+
+	if (!dax_dev->ops)
+		return -EOPNOTSUPP;
+
 	/*
 	 * There are no callers that want to zero more than one page as of now.
 	 * Once users are there, this check can be removed after the
@@ -223,7 +230,7 @@ EXPORT_SYMBOL_GPL(dax_zero_page_range);
 size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *iter)
 {
-	if (!dax_dev->ops->recovery_write)
+	if (!dax_dev->ops || !dax_dev->ops->recovery_write)
 		return 0;
 	return dax_dev->ops->recovery_write(dax_dev, pgoff, addr, bytes, iter);
 }
@@ -307,6 +314,35 @@ void set_dax_nomc(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(set_dax_nomc);
 
+/**
+ * dax_set_ops - set the dax_operations for a dax_device
+ * @dax_dev: the dax_device to configure
+ * @ops: the operations to set (may be NULL to clear)
+ *
+ * This allows drivers to set the dax_operations after the dax_device
+ * has been allocated. This is needed when the device is created before
+ * the driver that needs specific ops is bound (e.g., fsdev_dax binding
+ * to a dev_dax created by hmem).
+ *
+ * When setting non-NULL ops, fails if ops are already set (returns -EBUSY).
+ * When clearing ops (NULL), always succeeds.
+ *
+ * Return: 0 on success, -EBUSY if ops already set
+ */
+int dax_set_ops(struct dax_device *dax_dev, const struct dax_operations *ops)
+{
+	if (ops) {
+		/* Setting ops: fail if already set */
+		if (cmpxchg(&dax_dev->ops, NULL, ops) != NULL)
+			return -EBUSY;
+	} else {
+		/* Clearing ops: always allowed */
+		dax_dev->ops = NULL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_set_ops);
+
 bool dax_alive(struct dax_device *dax_dev)
 {
 	lockdep_assert_held(&dax_srcu);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index fe1315135fdd..5aaaca135737 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -247,6 +247,7 @@ static inline void dax_break_layout_final(struct inode *inode)
 
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
+int dax_set_ops(struct dax_device *dax_dev, const struct dax_operations *ops);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 		enum dax_access_mode mode, void **kaddr, unsigned long *pfn);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
-- 
2.52.0


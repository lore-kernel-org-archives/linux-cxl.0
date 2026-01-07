Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099F318ECD
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800042; cv=none; b=Ry5WOjDUQqMts2t8NxjBvOFp95mYaHbRU5WgudeVFA8QJdFVntB9yfbsI+RdZ66VsMInTEzM0iL8J0zUeu45FAGl4WuyCv6KPW5s1ElUNnrvMaUlds/01TlbXFlIcrkFi0koYwQH+n+79c0W/jCNpOZqvXM1nC6NYFfbC8sBEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800042; c=relaxed/simple;
	bh=WRVZBT8kMG5wCLoPZZC5bOMvnEB+0NlJlCyntEWpc5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jboP9X5F9TKlBy7+AsXce8Hoaa37b7TUulXyq0iHff6sKKsEGRFhtbnhRqoJXQz6FCVSs3WopOhFrr5mkNnAVSFsV3wn9AwYVc52tFtggoKfaO7pPVo1EtO37171A5aVX+icaypyiclHF79Jo/zSUGJ+nS1hDiHKtj6dZXKCtsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEhR4xQC; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEhR4xQC"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-455bef556a8so1445248b6e.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 07:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800039; x=1768404839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFpUE248sHWKO0jMsz45uNwCckbm+2ReGU0X8tOcxqc=;
        b=aEhR4xQCYQN3NA9/prqTA48FLx6GDk1H72V6kODI+yl1ODxSilRXDuEwIyV76CEy/p
         HEFbk6y3GqE7PwAVvx9pUIzpC8wqz4KOTqrU2pCOXpbfyEHfYb+gXkuG4TW0FWtPG8DG
         c19y5MAHm1U4E7QzIxQhIpYLMrjWDSxPZUhdesQngGpEfo1Dar0Vz5+oAOKlgRLv6dGs
         JNT/UEvWSDizb8H9D1IvU5b9i7ENu0tcpN59iOh6T348FGwyjPgCP0yZmvZYpdw+3EyK
         s/tUeECj2HEWt0bvWE2k+6b3/qfHTBKeNSYJXC7m+DNDHEMdbKMYwgVbpK22xzE7tWdl
         XAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800039; x=1768404839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFpUE248sHWKO0jMsz45uNwCckbm+2ReGU0X8tOcxqc=;
        b=fUkXw7Ln3rx/GlYDUH6AhEDnP/Kx+FakEGVWLduc53lefAEDeqkDzpGJept7UHdbkL
         1EjMuY0vRoJWcocTma09y4TSHymyBJ8YRlzTaSGqSROAdhyedagGOqLNA7vbCTI5W946
         hMR+KJZEi/SUiuneyuPD5y/tXagyAqC4qT+KhLB04e2EeJIDCnaZcpKJzBzFibr1hhjB
         RCSX+uppod3p5F4j6Gkh6iFgUG9yxSvtYMlrlkgUQv4vlaJtCCFqw0tZ4rcABZpsRWX+
         POqZY51z8u3w2AlF+JpDSdzvg3gAnvkwwp2LNCoJhDSjauSHwollmXTG/nS61gobUubG
         SZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoKrFxuNWAbSBf0CSD+xVVh0+cBKm/sVNo5feefxExzz87Q9pCp0PXMeZ9Y6M6Hj1lja+qVwY6WxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZUAMjRDz7WkHl5QpPlbywkv+LkiOYmbSaXx/yrXxhxfgz2Pt
	wGY946khOJiAnBiMXbmTKmkjATVeZlm7zM+BJ4IyKMRwT9eY+QP5AcH7
X-Gm-Gg: AY/fxX7EGwtmul16OaQlnDQZkAeZyQC2hJqhJWb4IdUfemfEnIcknp2swID1DmPLpuQ
	YQ4MzrPqNd8wzQaQlZb71kacq1aSTJB23D2Qex0V0alPPlE8+bPt2GMTCVrsPwgD0yIeGK4xIze
	5tsb9bf1i3xRZOMEtr84r763E7TYAIoVF3s/QJ/QpOkUtMvDUNx7rM4Qs2YhKsDcdJfZX4RACzV
	6RbYc0uZgtj4L1O0qx68Q+PRPR5IL99wcmJh15jP8VjAQ82zZg0RiM5n9uXHqgef7fjpaayg7Vv
	n9B/DUGnUH7TCx8Ci5lYHGVB0IMATUAmbNY988JR9rZVATRWQhaubylDyYqpt5G5AWoD3KU70ra
	p65giofONHbd+100E57+bXEuH5WGwkdRFL8m3JnKW3onPJncJh6lh1zO9B4sERHm3842IfTsPxW
	hHjRAIIj8WqEvT5XbQbYPQasxR3adG3PXtWAM2dNgTr6WC
X-Google-Smtp-Source: AGHT+IEszE+IwGAo4ineGymBiCez8ScClYQB6AM3nCGB9mlkfxe96RTOF5+tZUxQ9+aCXt3y02aEdQ==
X-Received: by 2002:a05:6808:6412:b0:455:f4e7:d09a with SMTP id 5614622812f47-45a6bccc205mr1321889b6e.12.1767800039196;
        Wed, 07 Jan 2026 07:33:59 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.33.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:33:58 -0800 (PST)
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
	Chen Linxuan <chenlinxuan@uniontech.com>,
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
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 06/21] dax: Add fs_dax_get() func to prepare dax for fs-dax usage
Date: Wed,  7 Jan 2026 09:33:15 -0600
Message-ID: <20260107153332.64727-7-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153332.64727-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fs_dax_get() function should be called by fs-dax file systems after
opening a fsdev dax device. This adds holder_operations, which provides
a memory failure callback path and effects exclusivity between callers
of fs_dax_get().

fs_dax_get() is specific to fsdev_dax, so it checks the driver type
(which required touching bus.[ch]). fs_dax_get() fails if fsdev_dax is
not bound to the memory.

This function serves the same role as fs_dax_get_by_bdev(), which dax
file systems call after opening the pmem block device.

This can't be located in fsdev.c because struct dax_device is opaque
there.

This will be called by fs/fuse/famfs.c in a subsequent commit.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/bus.c   |  2 --
 drivers/dax/bus.h   |  2 ++
 drivers/dax/super.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h |  1 +
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 0d7228acb913..6e0e28116edc 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -42,8 +42,6 @@ static int dax_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return add_uevent_var(env, "MODALIAS=" DAX_DEVICE_MODALIAS_FMT, 0);
 }
 
-#define to_dax_drv(__drv)	container_of_const(__drv, struct dax_device_driver, drv)
-
 static struct dax_id *__dax_match_id(const struct dax_device_driver *dax_drv,
 		const char *dev_name)
 {
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 880bdf7e72d7..dc6f112ac4a4 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -42,6 +42,8 @@ struct dax_device_driver {
 	void (*remove)(struct dev_dax *dev);
 };
 
+#define to_dax_drv(__drv) container_of_const(__drv, struct dax_device_driver, drv)
+
 int __dax_driver_register(struct dax_device_driver *dax_drv,
 		struct module *module, const char *mod_name);
 #define dax_driver_register(driver) \
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index ba0b4cd18a77..68c45b918cff 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/cacheinfo.h>
 #include "dax-private.h"
+#include "bus.h"
 
 /**
  * struct dax_device - anchor object for dax services
@@ -121,6 +122,59 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)
 EXPORT_SYMBOL_GPL(fs_put_dax);
 #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
+#if IS_ENABLED(CONFIG_DEV_DAX_FS)
+/**
+ * fs_dax_get() - get ownership of a devdax via holder/holder_ops
+ *
+ * fs-dax file systems call this function to prepare to use a devdax device for
+ * fsdax. This is like fs_dax_get_by_bdev(), but the caller already has struct
+ * dev_dax (and there is no bdev). The holder makes this exclusive.
+ *
+ * @dax_dev: dev to be prepared for fs-dax usage
+ * @holder: filesystem or mapped device inside the dax_device
+ * @hops: operations for the inner holder
+ *
+ * Returns: 0 on success, <0 on failure
+ */
+int fs_dax_get(struct dax_device *dax_dev, void *holder,
+	const struct dax_holder_operations *hops)
+{
+	struct dev_dax *dev_dax;
+	struct dax_device_driver *dax_drv;
+	int id;
+
+	id = dax_read_lock();
+	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode)) {
+		dax_read_unlock(id);
+		return -ENODEV;
+	}
+	dax_read_unlock(id);
+
+	/* Verify the device is bound to fsdev_dax driver */
+	dev_dax = dax_get_private(dax_dev);
+	if (!dev_dax || !dev_dax->dev.driver) {
+		iput(&dax_dev->inode);
+		return -ENODEV;
+	}
+
+	dax_drv = to_dax_drv(dev_dax->dev.driver);
+	if (dax_drv->type != DAXDRV_FSDEV_TYPE) {
+		iput(&dax_dev->inode);
+		return -EOPNOTSUPP;
+	}
+
+	if (cmpxchg(&dax_dev->holder_data, NULL, holder)) {
+		iput(&dax_dev->inode);
+		return -EBUSY;
+	}
+
+	dax_dev->holder_ops = hops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fs_dax_get);
+#endif /* DEV_DAX_FS */
+
 enum dax_device_flags {
 	/* !alive + rcu grace period == no new operations / mappings */
 	DAXDEV_ALIVE,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 3fcd8562b72b..76f2a75f3144 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -53,6 +53,7 @@ struct dax_holder_operations {
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 
 #if IS_ENABLED(CONFIG_DEV_DAX_FS)
+int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
 struct dax_device *inode_dax(struct inode *inode);
 #endif
 void *dax_holder(struct dax_device *dax_dev);
-- 
2.49.0


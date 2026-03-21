Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF5392819
	for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774105463; cv=none; b=M4YTc7bU2YgPA1y+6GQri3TZLiY+hzfxndQXVgIXcapsMeJOxbH9zVGdAqeUwepmBtketcAu9AGi/exZu3J59mVY0vET7me5KIIJiXTYR1LLEwTdZOZrtanuCwLakEAmAXpbCZUwZzCoO05cOTNxv39D1PCE5zDGqvLgDOm0chk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774105463; c=relaxed/simple;
	bh=Wowz7DV1aUnJYA8F9t35yrzNxk7X9sC3o+wv4gNWZWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hr2SthnKFwDm00z3Z4TG7j/O3VteJAq1C8L9V/oIseiU51UN0kieaXulz/CVU0BLQ9h5NljfUn+Ow+s40UCVv180E5gTK24+BXRf6OTsct+AAYJ/+FSZIq3uayh7kPyiSSDKyLreuWUT0cpHfvZ2J3NXlZ9eA+bMKCFHS2zxMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=irS2qXWx; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="irS2qXWx"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd7284782dso210839285a.1
        for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774105460; x=1774710260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpXtFQ1E8PxzzJ3jH0sASsMe/zJtVJUABHrep2C4jPI=;
        b=irS2qXWxWFeexAZMY+IiOHXE4lVvRhIKgIfbqdPOgR3M+D5Pr7sfFiF7DA6Y3jxSFj
         dLYH4jt0Or2o8Ci+d7sCnulb6ziFtZfsXjpCiYysZ4IUEr1nFoFY2ltSMhyL/HpkqlPm
         4KzB67t+QzA8kJJZsm54xUetG5BIVv9SNjJ8TaB4x42xiSDf3pWT1I/BtdfxXck+lRJy
         CO+O0jUqrH+rEfrPiqzYAjgbmwdx7KAs84xJxpcNm+4jGWS/B9vFKibU99hXqDkrf0vW
         gjmkRUGF0eYJPql4RwmTmUDEy5cEFgHh6Yq4at3JxketATqN6r3GOPXmdKHyXX0jtsHy
         n0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774105460; x=1774710260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DpXtFQ1E8PxzzJ3jH0sASsMe/zJtVJUABHrep2C4jPI=;
        b=cm8qQVAvuDGGOvpCXsocou8PSdhrbwceCLSL9YNY1SvdHWCKzLf1rx5wWlpU6im7Az
         eN7p/ACYzYw4YJYbSgkjHQWnM0B24tvZluZT9pfkNaUvvh3NdOrdu6RBrAcXY+rjn+TO
         2M8HL7NqjmBuXeEpGv/pmvzRVslklqDDes7Ne8dlQy2CaGtbWIW9jSnF2SeoPMBA8AON
         eToZAM23fiAoWHhXBVpnWzjMidNNMjWNstJJ2gHl6GktYghgR/64dmMVUPHAckpRjbxQ
         vkeWxUYDZFtRc3V9F7moEHd1McQTAsnVMUssjwIRcMMS7BGIVr/Ao9D9Z79G8f4bjPCc
         CKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFxrPf06ImMAEGFVIHrBZpYca1mp2STMZbjizm8pBru6oLr6U9iEzYyqXVpytRpb5WK99o3KAaAxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/djKOwaZgy0H5Ostdn9ppsDB7Tmp2LDNLCC1F6HrzDKC7Brx4
	FW38W8RtQvEwNePhdITwZG3jN+XaxumyoMCMX3XR6UoIYI4pa7PO4RZfxZQMwPy6Ioo=
X-Gm-Gg: ATEYQzyoS/5oRVK5IJPS1jVIcIbkg7zf8hafMHjBQKWNzQC2DQFMU7R/iJFGClWIE03
	UoKFjaDuVf7EoRryHAUQ/qfrXK83vpCreUsnP5bPYo5Lm1MsSOBCapdJe16fT2n8cWXB+zZflvF
	5c61pwRA7G4sGvAdgN9Xej3zdK7knc1gD8nnyRwiIsep+0TrlsHHpoW4lQ4YuY709KQUujOD6Nt
	k1Pj4BH+rqkjUago+/lsQBeCMKfrFXs6DNls+CQUOm+EkuiSDhnSbNgp9hBa6K2co1bMMh6FxQ0
	ul820Uc1+vlN8YwMZQWSY1G/THGXWOzxmYa9cAqN9VwJ0UmrPV6pGkqoLhsEVzr987cxAzUrkeV
	nHXzUrrStpzH+GtI+QmXoj5JV/l0OcGBNUrMT9U2QUTbfP+G69jmKZu6T+p56jWvrBIfdzexlKk
	DingHsePCQ3i+gZqpPQCMxnMWs7HtFmFHqUvZ/PECr4JofS8Rc/tXaQIgFvebjWDygq/plc/gd4
	g3lCgStAvoejbY=
X-Received: by 2002:a05:620a:4055:b0:8cf:dd4b:8a53 with SMTP id af79cd13be357-8cfdd4b9250mr167236585a.30.1774105459722;
        Sat, 21 Mar 2026 08:04:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90ba89fsm391979885a.40.2026.03.21.08.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:04:18 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	osalvador@suse.de
Cc: dan.j.williams@intel.com,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 6/8] dax: plumb hotplug online_type through dax
Date: Sat, 21 Mar 2026 11:04:02 -0400
Message-ID: <20260321150404.3288786-7-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321150404.3288786-1-gourry@gourry.net>
References: <20260321150404.3288786-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no way for drivers leveraging dax_kmem to plumb through a
preferred auto-online policy - the system default policy is forced.

Add 'enum mmop' field to DAX device creation path to allow drivers
to specify an auto-online policy when using the kmem driver.

Current callers initialize online_type to mhp_get_default_online_type()
to retain backward compatibility and to make explicit to the drivers
what is actually happening underneath.

No functional changes to existing callers.

Cc:David Hildenbrand <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/bus.c         |  3 +++
 drivers/dax/bus.h         |  2 ++
 drivers/dax/cxl.c         |  1 +
 drivers/dax/dax-private.h |  3 +++
 drivers/dax/hmem/hmem.c   |  1 +
 drivers/dax/kmem.c        | 13 +++++++++++--
 6 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index c94c09622516..2c6140dc9382 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2017-2018 Intel Corporation. All rights reserved. */
 #include <linux/memremap.h>
+#include <linux/memory_hotplug.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -395,6 +396,7 @@ static ssize_t create_store(struct device *dev, struct device_attribute *attr,
 			.size = 0,
 			.id = -1,
 			.memmap_on_memory = false,
+			.online_type = mhp_get_default_online_type(),
 		};
 		struct dev_dax *dev_dax = __devm_create_dev_dax(&data);
 
@@ -1494,6 +1496,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	ida_init(&dev_dax->ida);
 
 	dev_dax->memmap_on_memory = data->memmap_on_memory;
+	dev_dax->online_type = data->online_type;
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index cbbf64443098..f037cd8a2d51 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -3,6 +3,7 @@
 #ifndef __DAX_BUS_H__
 #define __DAX_BUS_H__
 #include <linux/device.h>
+#include <linux/memory_hotplug.h>
 #include <linux/range.h>
 
 struct dev_dax;
@@ -24,6 +25,7 @@ struct dev_dax_data {
 	resource_size_t size;
 	int id;
 	bool memmap_on_memory;
+	enum mmop online_type;
 };
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..d6fbec863361 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -27,6 +27,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		.id = -1,
 		.size = range_len(&cxlr_dax->hpa_range),
 		.memmap_on_memory = true,
+		.online_type = mhp_get_default_online_type(),
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index c6ae27c982f4..734fb83f5eb4 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/idr.h>
+#include <linux/memory_hotplug.h>
 
 /* private routines between core files */
 struct dax_device;
@@ -77,6 +78,7 @@ struct dev_dax_range {
  * @dev: device core
  * @pgmap: pgmap for memmap setup / lifetime (driver owned)
  * @memmap_on_memory: allow kmem to put the memmap in the memory
+ * @online_type: MMOP_* online type for memory hotplug
  * @nr_range: size of @ranges
  * @ranges: range tuples of memory used
  */
@@ -91,6 +93,7 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	bool memmap_on_memory;
+	enum mmop online_type;
 	int nr_range;
 	struct dev_dax_range *ranges;
 };
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 1cf7c2a0ee1c..acbc574ced93 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -36,6 +36,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 		.id = -1,
 		.size = region_idle ? 0 : range_len(&mri->range),
 		.memmap_on_memory = false,
+		.online_type = mhp_get_default_online_type(),
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 798f389df992..d4c34b2e3766 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -16,6 +16,11 @@
 #include "dax-private.h"
 #include "bus.h"
 
+/* Internal function exported only to kmem module */
+extern int __add_memory_driver_managed(int nid, u64 start, u64 size,
+				       const char *resource_name,
+				       mhp_t mhp_flags, enum mmop online_type);
+
 /* Memory resource name used for add_memory_driver_managed(). */
 static const char *kmem_name;
 /* Set if any memory will remain added when the driver will be unloaded. */
@@ -49,6 +54,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	struct dax_kmem_data *data;
 	struct memory_dev_type *mtype;
 	int i, rc, mapped = 0;
+	enum mmop online_type;
 	mhp_t mhp_flags;
 	int numa_node;
 	int adist = MEMTIER_DEFAULT_LOWTIER_ADISTANCE;
@@ -111,6 +117,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		goto err_reg_mgid;
 	data->mgid = rc;
 
+	online_type = dev_dax->online_type;
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct resource *res;
 		struct range range;
@@ -151,8 +159,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		 * Ensure that future kexec'd kernels will not treat
 		 * this as RAM automatically.
 		 */
-		rc = add_memory_driver_managed(data->mgid, range.start,
-				range_len(&range), kmem_name, mhp_flags);
+		rc = __add_memory_driver_managed(data->mgid, range.start,
+				range_len(&range), kmem_name, mhp_flags,
+				online_type);
 
 		if (rc) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
-- 
2.53.0


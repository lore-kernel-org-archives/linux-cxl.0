Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2727FD49
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022442; cv=none; b=X+r3wlwIAxY/5MLMNbqLHiQRjzkQR4qn5TzXEyFveuXD85TosX7NHbpLbZFEGCNOiRW7ksCSljKIsx3MN3fekleAQ80PftU9qCiQEs2G23CXWpvtrZPhIG/+GuU9G5CIo+2f4/PhNbQsYIyittP5j2PlUVLwl8Vzz+YPhUGxV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022442; c=relaxed/simple;
	bh=iTjg9Pr8+Kw96z8fh3rpmLzKBzh+9ED7tzBY1oRz/GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDnmZAyXAfNzf3VikCpjslba2ZK9XixIjm7sxHnD6BGfCzUTG7pWY/yYmfZhcQBVar09YZcEqcJeVTKHcbf6Lp7pW+ZRGkXDvHfU7f17gIWQ1Kt428blDaFlOvo3XhZhhOiV7mEUutclP0vn4XQ4QijUbT3/2BC1JvD9Eql1QRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C074C116C6;
	Fri, 13 Feb 2026 22:40:42 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v3 1/2] cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko
Date: Fri, 13 Feb 2026 15:40:37 -0700
Message-ID: <20260213224038.549798-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213224038.549798-1-dave.jiang@intel.com>
References: <20260213224038.549798-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving the symbol devm_cxl_add_nvdimm_bridge() to
drivers/cxl/cxl_pmem.c, so that cxl_pmem can export a symbol that gives
cxl_acpi a depedency on cxl_pmem kernel module. This is a prepatory patch
to resolve the issue of a race for nvdimm_bus object that is created
during cxl_acpi_probe().

No functional changes besides moving code.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Just move the symbol with a wrapper function. (Dan)
---
 drivers/cxl/core/pmem.c | 13 +++----------
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/pmem.c      | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index e7b1e6fa0ea0..7c78344acc6d 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -115,15 +115,8 @@ static void unregister_nvb(void *_cxl_nvb)
 	device_unregister(&cxl_nvb->dev);
 }
 
-/**
- * devm_cxl_add_nvdimm_bridge() - add the root of a LIBNVDIMM topology
- * @host: platform firmware root device
- * @port: CXL port at the root of a CXL topology
- *
- * Return: bridge device that can host cxl_nvdimm objects
- */
-struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
-						     struct cxl_port *port)
+struct cxl_nvdimm_bridge *__devm_cxl_add_nvdimm_bridge(struct device *host,
+						       struct cxl_port *port)
 {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct device *dev;
@@ -155,7 +148,7 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 	put_device(dev);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_nvdimm_bridge, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_nvdimm_bridge, "cxl_pmem");
 
 static void cxl_nvdimm_release(struct device *dev)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 04c673e7cdb0..f5850800f400 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -920,6 +920,8 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev);
 struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 						     struct cxl_port *port);
+struct cxl_nvdimm_bridge *__devm_cxl_add_nvdimm_bridge(struct device *host,
+						       struct cxl_port *port);
 struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm(struct device *dev);
 int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index e197883690ef..714beaf1704b 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -13,6 +13,20 @@
 
 static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 
+/**
+ * __devm_cxl_add_nvdimm_bridge() - add the root of a LIBNVDIMM topology
+ * @host: platform firmware root device
+ * @port: CXL port at the root of a CXL topology
+ *
+ * Return: bridge device that can host cxl_nvdimm objects
+ */
+struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
+						     struct cxl_port *port)
+{
+	return __devm_cxl_add_nvdimm_bridge(host, port);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_nvdimm_bridge, "CXL");
+
 static void clear_exclusive(void *mds)
 {
 	clear_exclusive_cxl_commands(mds, exclusive_cmds);
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503717;
	b=DqZt0rGiiLVGcMXjoqWzfMRia/O88AKWlFFnln/VtBwl8daaRLdJ81zFxmm4dPI15/iB
	 UOMY6ljV8C47GGHzYDiZA++ozfWFvcQXrtETGc0+DRzxet1pEl1XkLl3rboeMSMU3zcRy
	 Tfo/8ZRQxwTHHFI3mtCy3+0zB784gskTpqpf1wWRyeGdeDDmd9sDMyJlssK+HL2lPxsYr
	 UZM7/Xq61cBIhwlrAYUldPVhN12iSssilCEbiTWEDxQd8Z/N6su7Tc7p7YBK2ShGHe48/
	 wKiVsPXWpVnf2QUR9JlkzEyzJon8MG0oAfPm5h1kYxP2ZUeA9Qs6LEXZA0jtCYteh2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503717;
	h=DMARC-Filter:DKIM-Signature:From:Sender:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=sMHhlHivCsvaI5Tye/V+edIU2Y7AqQDg3C4kFXYUjZs=;
	b=4kgikTcd16hzQCvXLyrlZZN7jQNzVAdZf+8K8XYrenWv6j325SIy2dnfYPwmKod/0sPJ
	 mYtmBghM/142mpijiksKYTMzDg/k55g4SiPaG2qd9jvyl0F/4E4YYu14971TTkrN64MZb
	 y2cOXK8RYfdbdPArp3/HSapij7wl+rbYTsbQ6m67EB8Mlhe/NTQK8Emo3KQthVY+7fvYT
	 3tohVd1NIhxUp6pMeppStb+X40aaPn6KlrPlKLI8t9KZU7ptpzwBTRVlO63fJsh+JpCtt
	 ZTmDc2rYYhKOgeY8i/hCpwNsM/1AuosFcYBXVf2Qxwn8ca5VgsWyUnWPX0nzc7AhnwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ezt+EYJ9;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E0606A31E;
	Tue, 24 Nov 2026 07:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 848E0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ezt+EYJ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=sMHhlHivCsvaI5Tye/V+edIU2Y7AqQDg3C4kFXYUjZs=;
	b=ezt+EYJ92CeScGAqDdI38a4YsXnM3nURGoFPei13p0Pi0eFtjTCF6hPm0qhtYU
	Vy4GhXS0mPYK/CM0v61kB97jzdl/CWbCbjnuq3ZmxZk+5K8jtq7Ex3t1buUVmbvd
	5BWMic2St032wUgzoZlwk9Dmb4wYSuyJz0fD/vQZ1bYvo=
From: Yongxin Yang <yangyongxin@kylinos.cn>
Sender: yang_yongxin123@163.com
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Len Brown <lenb@kernel.org>,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v8] cxl/core: Create EINJ debugfs files when EINJ is initialized
Date: Tue, 24 Nov 2026 15:00:17 +0800
Message-ID: <179550361711.991197.13876815308672111616@kylinos.cn>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P40WNgVrd1I8Jg--.36837S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrWkJFy3ZrWxCFWftw48tFb_yoWfZr4fpa
	1UCr95Aw48Aay2kr13AryDXa4rtr4vgasrCr98W34akF4UCrs8GF1kJa4j9a4DWFW5J340
	v3Z8tF1UCw4UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeMKZUUUUU=
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbDABeuTGsFNhePTwAA36

einj_types under /sys/kernel/debug/cxl/ and the per-port einj_inject files
are how ndctl learns that CXL protocol error injection is available, so
they must exist where it works and stay absent where it does not.

With cxl_core built in, cxl_core_init() runs at subsys_initcall and
einj_init() at device_initcall, so the is_initialized() check there
always reads false and einj_types is never created.  Register
cxl_einj_debugfs_setup() with einj_cxl_register_ready_cb(); EINJ invokes
it from einj_cxl_notify_ready() once it is up, which creates einj_types
and the dport directories skipped before that point.  The three helpers
check einj_cxl_is_initialized() and return -ENODEV until then.

Test on a host with an EINJ table.  With CONFIG_CXL_BUS=y and
CONFIG_ACPI_APEI_EINJ=y (CONFIG_ACPI_APEI_EINJ_CXL defaults to y),
einj_types and the dport directories are missing before the change and
appear after it, and writing a type from einj_types to a port's
einj_inject reaches the dport path.  With both set to m, cxl_core depends
on einj, so einj comes up first and the files appear when cxl_core loads.
On a host without an EINJ table neither file appears.

Link: https://lore.kernel.org/all/20261104061256.1449275-1-yangyongxin@kylinos.cn/
Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
---
 drivers/acpi/apei/apei-internal.h |  7 ++++
 drivers/acpi/apei/einj-core.c     |  4 +-
 drivers/acpi/apei/einj-cxl.c      | 38 +++++++++++++++++
 drivers/cxl/core/port.c           | 70 ++++++++++++++++++++++++++++---
 include/cxl/einj.h                |  3 ++
 5 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 77c10a7a7a9f..5fb28cb4c7aa 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -137,6 +137,13 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			      u64 param3, u64 param4);
 bool einj_is_cxl_error_type(u64 type);
+
+/* Notified from einj_init() once the CXL side may set up its debugfs */
+#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL)
+void einj_cxl_notify_ready(void);
+#else
+static inline void einj_cxl_notify_ready(void) { }
+#endif
 int einj_validate_error_type(u64 type);
 
 #ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 1f3fa2278584..a3e7185f1e5a 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -1187,8 +1187,10 @@ static int __init einj_init(void)
 
 	einj_dev = faux_device_create("acpi-einj", NULL, &einj_device_ops);
 
-	if (einj_dev)
+	if (einj_dev) {
 		einj_initialized = true;
+		einj_cxl_notify_ready();
+	}
 
 	return 0;
 }
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index e70a416ec925..93003fe4527e 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -30,6 +30,9 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 	int cxl_err, rc;
 	u32 available_error_type = 0;
 
+	if (!einj_cxl_is_initialized())
+		return -ENODEV;
+
 	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
@@ -72,6 +75,9 @@ int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
 {
 	int rc;
 
+	if (!einj_cxl_is_initialized())
+		return -ENODEV;
+
 	/* Only CXL error types can be specified */
 	if (!einj_is_cxl_error_type(type))
 		return -EINVAL;
@@ -90,6 +96,9 @@ int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
 	u64 param4 = 0;
 	int rc;
 
+	if (!einj_cxl_is_initialized())
+		return -ENODEV;
+
 	/* Only CXL error types can be specified */
 	if (!einj_is_cxl_error_type(type))
 		return -EINVAL;
@@ -111,3 +120,32 @@ bool einj_cxl_is_initialized(void)
 	return einj_initialized;
 }
 EXPORT_SYMBOL_NS_GPL(einj_cxl_is_initialized, "CXL");
+
+static void (*einj_cxl_ready_cb)(void);
+
+/**
+ * einj_cxl_register_ready_cb - run a callback once EINJ is initialized
+ * @cb: callback to invoke, or NULL to cancel a pending registration
+ *
+ * cxl_core cannot tell at init time whether EINJ will come up.  If EINJ is
+ * already initialized, @cb runs immediately.
+ */
+void einj_cxl_register_ready_cb(void (*cb)(void))
+{
+	if (cb && einj_cxl_is_initialized()) {
+		cb();
+		return;
+	}
+
+	einj_cxl_ready_cb = cb;
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_register_ready_cb, "CXL");
+
+void einj_cxl_notify_ready(void)
+{
+	void (*cb)(void) = einj_cxl_ready_cb;
+
+	einj_cxl_ready_cb = NULL;
+	if (cb)
+		cb();
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..4f6137651ca4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -802,6 +802,8 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 
 DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
 
+static struct dentry *cxl_debugfs;
+
 static int cxl_einj_inject(void *data, u64 type)
 {
 	struct cxl_dport *dport = data;
@@ -822,6 +824,17 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 	if (!einj_cxl_is_initialized())
 		return;
 
+	/*
+	 * Skip dports that already got a directory when they came up.  The
+	 * lookup returns an ERR_PTR when CONFIG_DEBUG_FS is off, so it must
+	 * not be handed to dput() unchecked.
+	 */
+	dir = debugfs_lookup(dev_name(dport->dport_dev), cxl_debugfs);
+	if (!IS_ERR_OR_NULL(dir)) {
+		dput(dir);
+		return;
+	}
+
 	/*
 	 * Protocol error injection is only available for CXL 2.0+ root ports
 	 * and CXL 1.1 downstream ports
@@ -836,6 +849,54 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 			    &cxl_einj_inject_fops);
 }
 
+static struct dentry *einj_types_dentry;
+
+/*
+ * einj_types cannot be created from cxl_core_init(): EINJ is not up yet at
+ * that point, so create it once EINJ reports it is initialized.
+ */
+static void cxl_einj_debugfs_add_types(void)
+{
+	if (einj_types_dentry)
+		return;
+
+	if (!einj_cxl_is_initialized())
+		return;
+
+	einj_types_dentry = debugfs_create_file("einj_types", 0400, cxl_debugfs,
+						NULL,
+						&einj_cxl_available_error_type_fops);
+}
+
+static int cxl_einj_debugfs_create_dport_dirs(struct device *dev, void *data)
+{
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	unsigned long index;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	guard(device)(dev);
+	xa_for_each(&port->dports, index, dport)
+		cxl_debugfs_create_dport_dir(dport);
+
+	return 0;
+}
+
+/*
+ * Called from einj_cxl_notify_ready(), or directly from
+ * einj_cxl_register_ready_cb() when EINJ is already up.
+ */
+static void cxl_einj_debugfs_setup(void)
+{
+	cxl_einj_debugfs_add_types();
+	bus_for_each_dev(&cxl_bus_type, NULL, NULL,
+			 cxl_einj_debugfs_create_dport_dirs);
+}
+
 static int cxl_port_add(struct cxl_port *port,
 			resource_size_t component_reg_phys,
 			struct cxl_dport *parent_dport)
@@ -2501,8 +2562,6 @@ const struct bus_type cxl_bus_type = {
 };
 EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
 
-static struct dentry *cxl_debugfs;
-
 struct dentry *cxl_debugfs_create_dir(const char *dir)
 {
 	return debugfs_create_dir(dir, cxl_debugfs);
@@ -2515,10 +2574,6 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
-	if (einj_cxl_is_initialized())
-		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
-				    &einj_cxl_available_error_type_fops);
-
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
@@ -2541,6 +2596,8 @@ static __init int cxl_core_init(void)
 
 	cxl_ras_init();
 
+	einj_cxl_register_ready_cb(cxl_einj_debugfs_setup);
+
 	return 0;
 
 err_region:
@@ -2554,6 +2611,7 @@ static __init int cxl_core_init(void)
 
 static void cxl_core_exit(void)
 {
+	einj_cxl_register_ready_cb(NULL);
 	cxl_ras_exit();
 	cxl_region_exit();
 	bus_unregister(&cxl_bus_type);
diff --git a/include/cxl/einj.h b/include/cxl/einj.h
index 624ff6ff41f9..af2af62c8eaa 100644
--- a/include/cxl/einj.h
+++ b/include/cxl/einj.h
@@ -21,6 +21,7 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
 int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
 int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
 bool einj_cxl_is_initialized(void);
+void einj_cxl_register_ready_cb(void (*cb)(void));
 #else /* !IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL) */
 static inline int einj_cxl_available_error_type_show(struct seq_file *m,
 						     void *v)
@@ -39,6 +40,8 @@ static inline int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
 }
 
 static inline bool einj_cxl_is_initialized(void) { return false; }
+
+static inline void einj_cxl_register_ready_cb(void (*cb)(void)) { }
 #endif /* CONFIG_ACPI_APEI_EINJ_CXL */
 
 #endif /* EINJ_CXL_H */

base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
-- 
2.25.1



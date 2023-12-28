Received: from mail-m12748.qiye.163.com (mail-m12748.qiye.163.com [115.236.127.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540556FA2
	for <linux-cxl@vger.kernel.org>; Thu, 28 Dec 2023 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 1DB358601BF;
	Thu, 28 Dec 2023 14:05:19 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	ave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [RFC PATCH 4/4] cxl: introduce CXL Virtualization module
Date: Thu, 28 Dec 2023 06:05:10 +0000
Message-Id: <20231228060510.1178981-5-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
References: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0xKVktLH0xPTkhPQk1CTlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8caf06fb19023ckunm1db358601bf
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBA6SCo5TTcrISJRPBRKKz4O
	I0kwCzhVSlVKTEtITE9ITklLSE1JVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBTUhDTk03Bg++

As the real CXL device is not widely available now, we need
some virtual cxl device to do uplayer software developing or
testing. Qemu is good for functional testing, but not good
for some performance testing.

The new CXLV module allow user to use the reserved RAM[1], to
create virtual cxl device. When the cxlv module load, it will
create a directory named as "cxl_virt" under /sys/devices/virtual:

	"/sys/devices/virtual/cxl_virt/"

that's the top level device for all cxlv devices.
At the same time, cxlv module will create a debugfs directory:

/sys/kernel/debug/cxl/cxlv
├── create
└── remove

the create and remove debugfs file is the cxlv entry to create or remove
a cxlv device.

Each cxlv device have its owned virtual pci related bridge and bus, cxlv
will create a new root_port for the new cxlv device, setup cxl ports for
dport and nvdimm-bridge. After that, we will add the virtual pci device,
that will go into the cxl_pci_probe to setup new memdev.

Then we can see the cxl device with cxl list and use it as a real cxl
device.

[1]: Add argument in kernel command line: "memmap=nn[KMG]$ss[KMG]",
detail in Documentation/driver-api/cxl/memory-devices.rst

Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
---
 MAINTAINERS                         |   6 +
 drivers/cxl/Kconfig                 |  11 +
 drivers/cxl/Makefile                |   1 +
 drivers/cxl/cxl_virt/Makefile       |   5 +
 drivers/cxl/cxl_virt/cxlv.h         |  87 ++++
 drivers/cxl/cxl_virt/cxlv_debugfs.c | 260 ++++++++++
 drivers/cxl/cxl_virt/cxlv_device.c  | 311 ++++++++++++
 drivers/cxl/cxl_virt/cxlv_main.c    |  67 +++
 drivers/cxl/cxl_virt/cxlv_pci.c     | 710 ++++++++++++++++++++++++++++
 drivers/cxl/cxl_virt/cxlv_pci.h     | 549 +++++++++++++++++++++
 drivers/cxl/cxl_virt/cxlv_port.c    | 149 ++++++
 11 files changed, 2156 insertions(+)
 create mode 100644 drivers/cxl/cxl_virt/Makefile
 create mode 100644 drivers/cxl/cxl_virt/cxlv.h
 create mode 100644 drivers/cxl/cxl_virt/cxlv_debugfs.c
 create mode 100644 drivers/cxl/cxl_virt/cxlv_device.c
 create mode 100644 drivers/cxl/cxl_virt/cxlv_main.c
 create mode 100644 drivers/cxl/cxl_virt/cxlv_pci.c
 create mode 100644 drivers/cxl/cxl_virt/cxlv_pci.h
 create mode 100644 drivers/cxl/cxl_virt/cxlv_port.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e2c6187a3ac8..36fa8b6352b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5255,6 +5255,12 @@ S:	Maintained
 F:	Documentation/admin-guide/perf/cxl.rst
 F:	drivers/perf/cxl_pmu.c
 
+COMPUTE EXPRESS LINK VIRTUALIZATION (CXLV)
+M:	Dongsheng Yang <dongsheng.yang@easystack.cn>
+L:	linux-cxl@vger.kernel.org
+S:	Maintained
+F:	drivers/cxl/cxl_virt/
+
 CONEXANT ACCESSRUNNER USB DRIVER
 L:	accessrunner-general@lists.sourceforge.net
 S:	Orphan
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 8ea1d340e438..065767ba4e47 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -154,4 +154,15 @@ config CXL_PMU
 	  monitoring units and provide standard perf based interfaces.
 
 	  If unsure say 'm'.
+
+config CXL_VIRT
+	tristate "CXL Vritualization"
+	depends on CXL_MEM && CXL_PMEM
+	help
+	  Enable virtualization of cxl device. It can create cxl devices
+	  by reserved memory. That would be helpful to get a fast cxl
+	  devices for performance tests.
+
+	  If unsure, or if this kernel is meant for production environments,
+	  say N.
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index db321f48ba52..7732eff8241e 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += core/
+obj-$(CONFIG_CXL_VIRT) += cxl_virt/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
diff --git a/drivers/cxl/cxl_virt/Makefile b/drivers/cxl/cxl_virt/Makefile
new file mode 100644
index 000000000000..0585435ce553
--- /dev/null
+++ b/drivers/cxl/cxl_virt/Makefile
@@ -0,0 +1,5 @@
+cxlv-y := cxlv_main.o cxlv_pci.o cxlv_debugfs.o cxlv_port.o cxlv_device.o
+
+ccflags-y += -I$(srctree)/drivers/cxl
+ccflags-y += -I$(srctree)/drivers/cxl/core
+obj-$(CONFIG_CXL_VIRT) += cxlv.o
diff --git a/drivers/cxl/cxl_virt/cxlv.h b/drivers/cxl/cxl_virt/cxlv.h
new file mode 100644
index 000000000000..33ed4ff81713
--- /dev/null
+++ b/drivers/cxl/cxl_virt/cxlv.h
@@ -0,0 +1,87 @@
+#ifndef __CXLV_H__
+#define __CXLV_H__
+#include <linux/pci.h>
+#include "cxlmem.h"
+#include "core.h"
+
+#define CXLV_FW_VERSION	"CXLV VERSION 00"
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+struct cxlv_dev_options {
+	u8	cxltype;
+	u64	memstart;
+	u64	memsize;
+
+	bool	pmem;
+};
+
+struct cxlv_pci_cfg {
+	struct cxlv_pci_cfg_header	*pcihdr;
+	struct cxlv_pci_pm_cap		*pmcap;
+	struct cxlv_pci_msix_cap	*msixcap;
+	struct cxlv_pcie_cap		*pciecap;
+	struct cxlv_pci_ext_cap		*extcap;
+	u8 cfg_data[PCI_CFG_SPACE_EXP_SIZE];
+};
+
+struct cxlv_device {
+	struct device dev;
+	int cxlv_dev_id;
+
+	struct cxlv_dev_options *opts;
+
+	/* start and end should be CXLV_DEVICE_ALIGN aligned */
+	u64	aligned_start;
+	u64	aligned_end;
+
+	struct cxlv_pci_cfg dev_cfg;
+	struct cxlv_pci_cfg bridge_cfg;
+
+	struct pci_dev *bridge_pdev;
+	struct pci_dev *dev_pdev;
+
+	struct task_struct *cxlv_dev_handler;
+
+	struct cxl_port *root_port;
+	int domain_nr;
+	int host_bridge_busnr;
+	struct pci_host_bridge *host_bridge;
+};
+
+#define CXLV_DRV_NAME "CXLVirt"
+#define CXLV_VERSION 0x0110
+#define CXLV_DEVICE_ID	CXLV_VERSION
+#define CXLV_VENDOR_ID 0x7c73
+#define CXLV_SUBSYSTEM_ID	0x9a6c
+#define CXLV_SUBSYSTEM_VENDOR_ID CXLV_VENDOR_ID
+
+#define CXLV_DEVICE_RES_MIN		(1UL * CXL_CAPACITY_MULTIPLIER)
+#define CXLV_DEVICE_ALIGN		(SZ_256M)
+
+/* cxlv_main */
+extern struct bus_type cxlv_subsys;
+
+/* cxlv_pci */
+int cxlv_pci_init(struct cxlv_device *dev);
+void process_mbox(struct cxlv_device *dev);
+void process_decoder(struct cxlv_device *dev);
+
+/* cxlv_port */
+int cxlv_port_init(struct cxlv_device *cxlv_device);
+
+/* cxlv_device */
+int cxlv_create_dev(struct cxlv_dev_options *opts);
+int cxlv_remove_dev(u32 cxlv_dev_id);
+int cxlv_device_init(void);
+void cxlv_device_exit(void);
+struct cxlv_pci_cfg *find_pci_cfg(struct pci_bus *bus, unsigned int devfn);
+
+/* cxlv_debugfs */
+void cxlv_debugfs_cleanup(void);
+int cxlv_debugfs_init(void);
+#endif /*__CXLV_H__*/
diff --git a/drivers/cxl/cxl_virt/cxlv_debugfs.c b/drivers/cxl/cxl_virt/cxlv_debugfs.c
new file mode 100644
index 000000000000..084c36414900
--- /dev/null
+++ b/drivers/cxl/cxl_virt/cxlv_debugfs.c
@@ -0,0 +1,260 @@
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/parser.h>
+
+#include "cxlv.h"
+
+enum {
+	CXLV_CREATE_OPT_ERR		= 0,
+	CXLV_CREATE_OPT_CXLTYPE,
+	CXLV_CREATE_OPT_PMEM,
+	CXLV_CREATE_OPT_MEMSTART,
+	CXLV_CREATE_OPT_MEMSIZE,
+};
+
+static const match_table_t create_opt_tokens = {
+	{ CXLV_CREATE_OPT_CXLTYPE,	"cxltype=%u"	},
+	{ CXLV_CREATE_OPT_PMEM,		"pmem=%u"	},
+	{ CXLV_CREATE_OPT_MEMSTART,	"memstart=%s"	},
+	{ CXLV_CREATE_OPT_MEMSIZE,	"memsize=%s"	},
+	{ CXLV_CREATE_OPT_ERR,		NULL		}
+};
+
+static int parse_create_options(char *buf,
+		struct cxlv_dev_options *opts)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *o, *p;
+	int token, ret = 0;
+	u64 token64;
+
+	o = buf;
+
+	while ((p = strsep(&o, ",\n")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, create_opt_tokens, args);
+		switch (token) {
+		case CXLV_CREATE_OPT_PMEM:
+			if (match_uint(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->pmem = token;
+			break;
+		case CXLV_CREATE_OPT_CXLTYPE:
+			/* Only support type3 cxl device currently */
+			if (match_uint(args, &token) || token != 3) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			opts->cxltype = token;
+			break;
+		case CXLV_CREATE_OPT_MEMSTART:
+			if (match_u64(args, &token64)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->memstart = token64;
+			break;
+		case CXLV_CREATE_OPT_MEMSIZE:
+			if (match_u64(args, &token64)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->memsize = token64;;
+			break;
+		default:
+			pr_warn("unknown parameter or missing value '%s'\n", p);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+
+static struct dentry *cxlv_debugfs_root;
+static struct dentry *create_f;
+static struct dentry *remove_f;
+
+static void cxlv_debugfs_remove(struct dentry **dp)
+{
+	debugfs_remove(*dp);
+	*dp = NULL;
+}
+
+#define CXLV_DEBUGFS_WO_FILE(NAME)					\
+static const struct file_operations cxlv_ ## NAME ## _fops = {		\
+	.owner		= THIS_MODULE,					\
+	.open		= simple_open,					\
+	.write		= cxlv_ ## NAME ## _write,                      \
+	.llseek		= seq_lseek,					\
+};
+
+#define CXLV_DEBUGFS_FILE(NAME)						\
+static const struct file_operations cxlv_ ## NAME ## _fops = {		\
+	.owner		= THIS_MODULE,					\
+	.open		= simple_open,					\
+	.write		= cxlv_ ## NAME ## _write,			\
+	.read		= seq_read,					\
+	.llseek		= seq_lseek,					\
+};
+
+static ssize_t cxlv_debugfs_create_write(struct file *file, const char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	int ret;
+	char *buf;
+	struct cxlv_dev_options *opts;
+
+	opts = kzalloc(sizeof(struct cxlv_dev_options), GFP_KERNEL);
+	if (!opts) {
+		pr_err("failed to alloc cxlv_dev_options.");
+		return -1;
+	}
+
+	buf = memdup_user(ubuf, cnt);
+	if (IS_ERR(buf)) {
+		pr_err("failed to dup buf: %d", (int)PTR_ERR(buf));
+		return PTR_ERR(buf);
+	}
+
+	ret = parse_create_options(buf, opts);
+	if (ret) {
+		kfree(buf);
+		return ret;
+	}
+	kfree(buf);
+
+	ret = cxlv_create_dev(opts);
+	if (ret) {
+		pr_err("failed to create device: %d", ret);
+		return -EINVAL;
+	}
+
+	return cnt;
+}
+
+CXLV_DEBUGFS_WO_FILE(debugfs_create);
+
+enum {
+	CXLV_REMOVE_OPT_ERR		= 0,
+	CXLV_REMOVE_OPT_CXLV_ID,
+};
+
+static const match_table_t remove_opt_tokens = {
+	{ CXLV_REMOVE_OPT_CXLV_ID,	"cxlv_dev_id=%u"	},
+	{ CXLV_REMOVE_OPT_ERR,		NULL		}
+};
+
+static int parse_remove_options(char *buf, u32 *cxlv_dev_id)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *o, *p;
+	int token, ret = 0;
+
+	o = buf;
+
+	while ((p = strsep(&o, ",\n")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, remove_opt_tokens, args);
+		switch (token) {
+		case CXLV_REMOVE_OPT_CXLV_ID:
+			if (match_uint(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			*cxlv_dev_id = token;
+			break;
+		default:
+			pr_warn("unknown parameter or missing value '%s'\n", p);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+static ssize_t cxlv_debugfs_remove_write(struct file *file, const char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	char *buf;
+	u32 cxlv_dev_id;
+	int ret;
+
+	buf = memdup_user(ubuf, cnt);
+	if (IS_ERR(buf)) {
+		pr_err("failed to dup buf: %d", (int)PTR_ERR(buf));
+		return PTR_ERR(buf);
+	}
+
+	ret = parse_remove_options(buf, &cxlv_dev_id);
+	if (ret) {
+		kfree(buf);
+		return ret;
+	}
+	kfree(buf);
+
+	ret = cxlv_remove_dev(cxlv_dev_id);
+	if (ret < 0) {
+		return ret;
+	}
+
+	return cnt;
+}
+
+CXLV_DEBUGFS_WO_FILE(debugfs_remove);
+
+void cxlv_debugfs_cleanup(void)
+{
+	cxlv_debugfs_remove(&remove_f);
+	cxlv_debugfs_remove(&create_f);
+	cxlv_debugfs_remove(&cxlv_debugfs_root);
+}
+
+int cxlv_debugfs_init(void)
+{
+	struct dentry *dentry;
+	int ret;
+
+	dentry = cxl_debugfs_create_dir("cxlv");
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	cxlv_debugfs_root = dentry;
+
+	create_f = debugfs_create_file("create", 0600, dentry, NULL,
+			&cxlv_debugfs_create_fops);
+	if (IS_ERR(create_f)) {
+		ret = PTR_ERR(create_f);
+		goto remove_root;
+	}
+
+	remove_f = debugfs_create_file("remove", 0600, dentry, NULL,
+			&cxlv_debugfs_remove_fops);
+	if (IS_ERR(remove_f)) {
+		ret = PTR_ERR(remove_f);
+		goto remove_create_f;
+	}
+
+	return 0;
+
+remove_create_f:
+	cxlv_debugfs_remove(&create_f);
+remove_root:
+	cxlv_debugfs_remove(&cxlv_debugfs_root);
+out:
+	return ret;
+}
diff --git a/drivers/cxl/cxl_virt/cxlv_device.c b/drivers/cxl/cxl_virt/cxlv_device.c
new file mode 100644
index 000000000000..3a0da247513d
--- /dev/null
+++ b/drivers/cxl/cxl_virt/cxlv_device.c
@@ -0,0 +1,311 @@
+#include <linux/delay.h>
+#include <linux/kthread.h>
+
+#include "cxlpci.h"
+#include "cxlv.h"
+#include "cxlv_pci.h"
+
+/* TODO support more cxlv devices */
+#define CXLV_DEVICE_MAX_NUM	1
+static struct cxlv_device *cxlv_devices[CXLV_DEVICE_MAX_NUM];
+static struct mutex cxlv_devices_lock;
+
+/* TODO faster way to find pci cfg for more devices supporting, e.g: XARRAY */
+struct cxlv_pci_cfg *find_pci_cfg(struct pci_bus *bus, unsigned int devfn)
+{
+	int i;
+	struct cxlv_device *cxlv_device;
+
+	for (i = 0; i < CXLV_DEVICE_MAX_NUM; i++) {
+		cxlv_device = cxlv_devices[i];
+
+		if (!cxlv_device)
+			continue;
+
+		if (pci_find_host_bridge(bus)->bus->number != cxlv_device->host_bridge_busnr ||
+				pci_domain_nr(bus) != cxlv_device->domain_nr)
+			continue;
+
+		if (pci_is_root_bus(bus)) {
+			return &cxlv_device->bridge_cfg;
+		} else {
+			return &cxlv_device->dev_cfg;
+		}
+
+		continue;
+	}
+
+	return NULL;
+}
+
+static int cxlv_device_find_empty(void)
+{
+	int i;
+
+	for (i = 0; i < CXLV_DEVICE_MAX_NUM; i++) {
+		if (!cxlv_devices[i])
+			return i;
+	}
+
+	return -1;
+}
+
+static int cxlv_device_register(struct cxlv_device *cxlv_device)
+{
+	int cxlv_dev_id = cxlv_device->cxlv_dev_id;
+
+	if (cxlv_devices[cxlv_dev_id] != NULL) {
+		return -EEXIST;
+	}
+
+	cxlv_devices[cxlv_dev_id] = cxlv_device;
+
+	return 0;
+}
+
+static void cxlv_device_unregister(struct cxlv_device *cxlv_device)
+{
+	int cxlv_dev_id = cxlv_device->cxlv_dev_id;
+
+	BUG_ON(cxlv_devices[cxlv_dev_id] != cxlv_device);
+
+	cxlv_devices[cxlv_dev_id] = NULL;
+}
+
+int cxlv_device_init(void)
+{
+	int i;
+
+	for (i = 0; i < CXLV_DEVICE_MAX_NUM; i++) {
+		cxlv_devices[i] = NULL;
+	}
+
+	mutex_init(&cxlv_devices_lock);
+
+	return 0;
+}
+
+void cxlv_device_exit(void)
+{
+	return;
+}
+
+static void cxlv_dev_release(struct device *dev)
+{
+}
+
+static struct cxlv_device *cxlv_device_create(struct cxlv_dev_options *opts)
+{
+	struct device *cxlv_dev;
+	struct cxlv_device *cxlv_device = NULL;
+	int cxlv_dev_id;
+	int ret;
+
+	mutex_lock(&cxlv_devices_lock);
+	cxlv_dev_id = cxlv_device_find_empty();
+	if (cxlv_dev_id < 0) {
+		pr_err("There is no more cxlv device can be created.");
+		goto unlock;
+	}
+
+	cxlv_device = kzalloc(sizeof(struct cxlv_device), GFP_KERNEL);
+	if (!cxlv_device) {
+		pr_err("failed to alloc cxlv_device");
+		goto unlock;
+	}
+
+	cxlv_device->opts = opts;
+	cxlv_device->cxlv_dev_id = cxlv_dev_id;
+	cxlv_device->aligned_start = ALIGN(opts->memstart + CXLV_RESOURCE_OFF,
+					   CXLV_DEVICE_ALIGN);
+	cxlv_device->aligned_end = ALIGN_DOWN(opts->memstart + opts->memsize,
+					      CXLV_DEVICE_ALIGN) - 1;
+
+	ret = cxlv_device_register(cxlv_device);
+	if (ret) {
+		pr_err("failed to register cxlv_device");
+		goto release_device;
+	}
+	mutex_unlock(&cxlv_devices_lock);
+
+	cxlv_dev = &cxlv_device->dev;
+	cxlv_dev->release = cxlv_dev_release;
+	cxlv_dev->bus = &cxlv_subsys;
+	dev_set_name(cxlv_dev, "cxlv%d", cxlv_dev_id);
+	device_set_pm_not_required(cxlv_dev);
+
+	ret = device_register(cxlv_dev);
+	if (ret < 0) {
+		goto unregister;
+	}
+
+	return cxlv_device;
+
+unregister:
+        mutex_lock(&cxlv_devices_lock);
+        cxlv_device_unregister(cxlv_device);
+release_device:
+	kfree(cxlv_device);
+unlock:
+	mutex_unlock(&cxlv_devices_lock);
+	return NULL;
+}
+
+void cxlv_device_release(struct cxlv_device *cxlv_device)
+{
+	device_unregister(&cxlv_device->dev);
+
+	mutex_lock(&cxlv_devices_lock);
+	cxlv_device_unregister(cxlv_device);
+	mutex_unlock(&cxlv_devices_lock);
+
+	if (cxlv_device->opts)
+		kfree(cxlv_device->opts);
+
+	if (cxlv_device)
+		kfree(cxlv_device);
+}
+
+#define CXLV_HANDLER_SLEEP_US		1000
+static int cxlv_handle(void *data)
+{
+	while (!kthread_should_stop()) {
+		process_mbox(data);
+		process_decoder(data);
+
+		/* sleep 10us after each loop */
+		fsleep(CXLV_HANDLER_SLEEP_US);
+	}
+
+	return 0;
+}
+
+static void cxlv_dev_handler_init(struct cxlv_device *cxlv_device)
+{
+	cxlv_device->cxlv_dev_handler = kthread_create(cxlv_handle,
+						       cxlv_device,
+						       "cxlv_dev_handler");
+	wake_up_process(cxlv_device->cxlv_dev_handler);
+}
+
+static void cxlv_dev_handler_final(struct cxlv_device *cxlv_device)
+{
+	if (!IS_ERR_OR_NULL(cxlv_device->cxlv_dev_handler)) {
+		kthread_stop(cxlv_device->cxlv_dev_handler);
+		cxlv_device->cxlv_dev_handler = NULL;
+	}
+}
+
+static int not_reserved(struct resource *res, void *arg)
+{
+	pr_err("has System RAM: %pr\n", res);
+
+	return 1;
+}
+
+static int validate_configs(struct cxlv_dev_options *opts)
+{
+	u64 res_start;
+	u64 res_end;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_CXL_PMEM) && opts->pmem) {
+		pr_err("CONFIG_CXL_PMEM is not enabled");
+		return -EINVAL;
+	}
+
+	if (!opts->memstart || !opts->memsize) {
+		pr_err("[memstart] and [memsize] should be specified");
+		return -EINVAL;
+	}
+
+	/* check for memory reserved */
+	res_start = opts->memstart;
+	res_end = res_start + opts->memsize - 1;
+
+	ret = walk_iomem_res_desc(IORES_DESC_NONE,
+				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+				res_start,
+				res_end, NULL,
+				not_reserved);
+
+	if (ret > 0) {
+		pr_err("range [%llu, %llu] is not reserved.", res_start, res_end);
+		return ret;
+	}
+
+	/* check the aligned resource */
+	res_start = ALIGN(res_start + CXLV_RESOURCE_OFF, CXLV_DEVICE_ALIGN);
+	if ((res_end - res_start + 1) < CXLV_DEVICE_RES_MIN) {
+		pr_err("[%llu, %llu]: first %u is for metadata, \
+				the rest is too small as we need %lu aligned resource range.",
+				opts->memstart, res_end, CXLV_RESOURCE_OFF, CXLV_DEVICE_RES_MIN);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int cxlv_create_dev(struct cxlv_dev_options *opts)
+{
+	int ret;
+	struct cxlv_device *cxlv_device;
+
+	if (validate_configs(opts)) {
+		return -EINVAL;
+	}
+
+	cxlv_device = cxlv_device_create(opts);
+	if (!cxlv_device) {
+		return -ENOMEM;
+	}
+
+	ret = cxlv_pci_init(cxlv_device);
+	if (ret) {
+		goto err;
+	}
+
+	ret = cxlv_port_init(cxlv_device);
+	if (ret)
+		goto err;
+
+	cxlv_dev_handler_init(cxlv_device);
+
+	pci_bus_add_devices(cxlv_device->host_bridge->bus);
+
+	__module_get(THIS_MODULE);
+	return 0;
+
+err:
+	cxlv_device_release(cxlv_device);
+	return -EIO;
+}
+
+int cxlv_remove_dev(u32 cxlv_dev_id)
+{
+	struct cxlv_device *cxlv_device;
+
+	if (cxlv_dev_id >= CXLV_DEVICE_MAX_NUM)
+		return -EINVAL;
+
+	if (cxlv_devices[cxlv_dev_id] == NULL)
+		return -EINVAL;
+
+	cxlv_device = cxlv_devices[cxlv_dev_id];
+	if (cxl_disable_port(cxlv_device->root_port))
+		return -EBUSY;
+
+	if (cxlv_device->host_bridge) {
+		pci_stop_root_bus(cxlv_device->host_bridge->bus);
+		pci_remove_root_bus(cxlv_device->host_bridge->bus);
+		put_device(&cxlv_device->host_bridge->dev);
+	}
+
+	cxlv_dev_handler_final(cxlv_device);
+
+	cxlv_device_release(cxlv_device);
+
+	module_put(THIS_MODULE);
+
+	return 0;
+}
diff --git a/drivers/cxl/cxl_virt/cxlv_main.c b/drivers/cxl/cxl_virt/cxlv_main.c
new file mode 100644
index 000000000000..3ac6f612b7ca
--- /dev/null
+++ b/drivers/cxl/cxl_virt/cxlv_main.c
@@ -0,0 +1,67 @@
+/*
+ * Copyright(C) 2024, Dongsheng Yang <dongsheng.yang@easystack.cn>
+ */
+
+#include "cxlv.h"
+
+struct bus_type cxlv_subsys = {
+	.name                           = "cxl_virt",
+};
+
+static int cxl_virt_dev_init(void)
+{
+	int ret;
+
+	ret = subsys_virtual_register(&cxlv_subsys, NULL);
+	if (ret) {
+		pr_err("failed to register cxlv subsys");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void cxl_virt_dev_exit(void)
+{
+	bus_unregister(&cxlv_subsys);
+}
+
+static int __init cxlv_init(void)
+{
+	int ret;
+
+	ret = cxl_virt_dev_init();
+	if (ret)
+		goto out;
+
+	ret = cxlv_device_init();
+	if (ret)
+		goto cxl_virt_dev_exit;
+
+	ret = cxlv_debugfs_init();
+	if (ret)
+		goto device_exit;
+
+	return 0;
+
+device_exit:
+	cxlv_device_exit();
+cxl_virt_dev_exit:
+	cxl_virt_dev_exit();
+out:
+	return ret;
+}
+
+static void cxlv_exit(void)
+{
+	cxlv_debugfs_cleanup();
+	cxlv_device_exit();
+	cxl_virt_dev_exit();
+}
+
+MODULE_AUTHOR("Dongsheng Yang <dongsheng.yang@easystack.cn>");
+MODULE_DESCRIPTION("CXL(Compute Express Link) Virtualization");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+module_init(cxlv_init);
+module_exit(cxlv_exit);
diff --git a/drivers/cxl/cxl_virt/cxlv_pci.c b/drivers/cxl/cxl_virt/cxlv_pci.c
new file mode 100644
index 000000000000..b3e73d4c5957
--- /dev/null
+++ b/drivers/cxl/cxl_virt/cxlv_pci.c
@@ -0,0 +1,710 @@
+#include "cxlv.h"
+#include "cxlv_pci.h"
+#include "cxlpci.h"
+#include "cxlmem.h"
+
+static struct cxl_cel_entry cel_logs[] = {
+	{ .opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS, .effect = 0 },
+	{ .opcode = CXL_MBOX_OP_GET_LOG, .effect = 0 },
+	{ .opcode = CXL_MBOX_OP_IDENTIFY, .effect = 0 },
+};
+
+#define CXLV_CEL_SUPPORTED_NUM		3
+
+void process_decoder(struct cxlv_device *dev)
+{
+	struct cxl_component *comp;
+	struct cxl_decoder_cap *decoder;
+
+	/* process device decoder */
+	comp = ioremap(pci_resource_start(dev->dev_pdev, 0) + CXLV_DEV_BAR_COMPONENT_OFF,
+					  CXLV_DEV_BAR_COMPONENT_LEN);
+
+	decoder = (struct cxl_decoder_cap *)((char *)comp + CXLV_COMP_CACHEMEM_OFF + CXLV_COMP_DECODER_OFF);
+	if (decoder->decoder[0].ctrl_regs & CXLV_DECODER_CTRL_COMMIT) {
+		decoder->decoder[0].ctrl_regs |= CXLV_DECODER_CTRL_COMMITTED;
+		decoder->decoder[0].ctrl_regs &= ~CXLV_DECODER_CTRL_COMMIT;
+		decoder->decoder[0].ctrl_regs &= ~CXLV_DECODER_CTRL_COMMIT_ERR;
+	}
+	iounmap(comp);
+
+	/* process bridge decoder */
+	comp = ioremap(pci_resource_start(dev->bridge_pdev, 0) + CXLV_BRIDGE_BAR_COMPONENT_OFF,
+					  CXLV_BRIDGE_BAR_COMPONENT_LEN);
+
+	decoder = (struct cxl_decoder_cap *)((char *)comp + CXLV_COMP_CACHEMEM_OFF + CXLV_COMP_DECODER_OFF);
+	if (decoder->decoder[0].ctrl_regs & CXLV_DECODER_CTRL_COMMIT) {
+		decoder->decoder[0].ctrl_regs |= CXLV_DECODER_CTRL_COMMITTED;
+		decoder->decoder[0].ctrl_regs &= ~CXLV_DECODER_CTRL_COMMIT;
+		decoder->decoder[0].ctrl_regs &= ~CXLV_DECODER_CTRL_COMMIT_ERR;
+	}
+	iounmap(comp);
+
+	return;
+}
+
+void process_mbox(struct cxlv_device *dev)
+{
+	struct pci_dev *pdev = dev->dev_pdev;
+	struct cxl_bar *bar;
+	struct cxlv_mbox *mbox;
+	int ret;
+
+	bar = ioremap(pci_resource_start(pdev, 0) + CXLV_DEV_BAR_DEV_REGS_OFF,
+		      CXLV_DEV_BAR_DEV_REGS_LEN);
+
+	mbox = ((void *)bar) + CXLV_DEV_CAP_MBOX_OFF;
+
+	if (cxlv_mbox_test_doorbell(mbox)) {
+		if (cxlv_mbox_get_cmd(mbox) == CXL_MBOX_OP_GET_SUPPORTED_LOGS) {
+			struct cxl_mbox_get_supported_logs *supported_log;
+			u32 payload_len;
+
+			payload_len = sizeof(*supported_log) + sizeof(supported_log->entry[0]);
+
+			supported_log = kzalloc(payload_len, GFP_KERNEL);
+			if (!supported_log) {
+				ret = CXL_MBOX_CMD_RC_INTERNAL;
+				goto out;
+			}
+
+			supported_log->entries = cpu_to_le16(1);
+			supported_log->entry[0].uuid = DEFINE_CXL_CEL_UUID;
+			supported_log->entry[0].size = cpu_to_le32(sizeof(struct cxl_cel_entry) * CXLV_CEL_SUPPORTED_NUM);
+
+			cxlv_mbox_copy_to_payload(mbox, 0, supported_log, payload_len);
+			cxlv_mbox_set_cmd_payload_len(mbox, payload_len);
+			ret = CXL_MBOX_CMD_RC_SUCCESS;
+			kfree(supported_log);
+		} else if (cxlv_mbox_get_cmd(mbox) == CXL_MBOX_OP_GET_LOG) {
+			struct cxl_mbox_get_log get_log;
+
+			cxlv_mbox_copy_from_payload(mbox, 0, &get_log, sizeof(struct cxl_mbox_get_log));
+
+			if (!uuid_equal(&get_log.uuid, &DEFINE_CXL_CEL_UUID)) {
+				ret = CXL_MBOX_CMD_RC_LOG;
+				goto out;
+			}
+
+			cxlv_mbox_copy_to_payload(mbox, le32_to_cpu(get_log.offset), cel_logs, le32_to_cpu(get_log.length));
+			cxlv_mbox_set_cmd_payload_len(mbox, le32_to_cpu(get_log.length));
+			ret = CXL_MBOX_CMD_RC_SUCCESS;
+		} else if (cxlv_mbox_get_cmd(mbox) == CXL_MBOX_OP_IDENTIFY) {
+			struct cxl_mbox_identify id = { 0 };
+			u64 capacity = (dev->aligned_end - dev->aligned_start + 1) / CXL_CAPACITY_MULTIPLIER;
+
+			strcpy(id.fw_revision, CXLV_FW_VERSION);
+
+			if (dev->opts->pmem) {
+				id.total_capacity = cpu_to_le64(capacity);
+				id.volatile_capacity = 0;
+				id.persistent_capacity = cpu_to_le64(capacity);
+				id.lsa_size = cpu_to_le64(CXLV_DEV_BAR_LSA_LEN);
+			} else {
+				id.total_capacity = cpu_to_le64(capacity);
+				id.volatile_capacity = cpu_to_le64(capacity);
+				id.persistent_capacity = 0;
+			}
+
+			cxlv_mbox_copy_to_payload(mbox, 0, &id, sizeof(id));
+			cxlv_mbox_set_cmd_payload_len(mbox, sizeof(id));
+			ret = CXL_MBOX_CMD_RC_SUCCESS;
+		} else if (cxlv_mbox_get_cmd(mbox) == CXL_MBOX_OP_GET_LSA) {
+			void *lsa;
+			struct cxl_mbox_get_lsa get_lsa = { 0 };
+
+			cxlv_mbox_copy_from_payload(mbox, 0, &get_lsa, sizeof(struct cxl_mbox_get_lsa));
+
+			u32 offset = le32_to_cpu(get_lsa.offset);
+			u32 len = le32_to_cpu(get_lsa.length);
+
+			if (len > CXLV_DEV_CAP_MBOX_PAYLOAD) {
+				ret = CXL_MBOX_CMD_RC_INPUT;
+				goto out;
+			}
+
+			/* read lsa from bar */
+			lsa = memremap(pci_resource_start(pdev, 0) + CXLV_DEV_BAR_LSA_OFF,
+					CXLV_DEV_BAR_LSA_LEN, MEMREMAP_WB);
+			cxlv_mbox_copy_to_payload(mbox, 0, lsa + offset, len);
+			memunmap(lsa);
+
+			cxlv_mbox_set_cmd_payload_len(mbox, len);
+			ret = CXL_MBOX_CMD_RC_SUCCESS;
+		} else if (cxlv_mbox_get_cmd(mbox) == CXL_MBOX_OP_SET_LSA) {
+			void *lsa;
+			struct cxl_mbox_set_lsa *set_lsa = (struct cxl_mbox_set_lsa *)mbox->payload;
+			u32 offset = le32_to_cpu(set_lsa->offset);
+			u32 len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, mbox->cmd);
+
+			/* write lsa to bar */
+			lsa = memremap(pci_resource_start(pdev, 0) + CXLV_DEV_BAR_LSA_OFF,
+					CXLV_DEV_BAR_LSA_LEN, MEMREMAP_WB);
+			memcpy(lsa + offset, set_lsa->data, len);
+			memunmap(lsa);
+
+			ret = CXL_MBOX_CMD_RC_SUCCESS;
+		} else {
+			dev_err(&dev->dev, "unsupported cmd: 0x%x", cxlv_mbox_get_cmd(mbox));
+			ret = CXL_MBOX_CMD_RC_UNSUPPORTED;
+		}
+out:
+		cxlv_mbox_set_retcode(mbox, ret);
+		smp_mb();
+		cxlv_mbox_clear_doorbell(mbox);
+		iounmap(bar);
+	}
+
+	return;
+}
+
+static int cxlv_pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
+{
+	struct cxlv_pci_cfg *pci_cfg;
+
+	if (devfn != 0)
+		return 1;
+
+	pci_cfg = find_pci_cfg(bus, devfn);
+	if (!pci_cfg)
+		return -ENXIO;
+
+	memcpy(val, pci_cfg->cfg_data + where, size);
+
+	pr_debug("[R] bus: %p, devfn: %u, 0x%x, size: %d, val: 0x%x\n", bus, devfn, where, size, *val);
+
+	return 0;
+};
+
+static int cxlv_pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 _val)
+{
+	struct cxlv_pci_cfg *pci_cfg;
+	u32 mask = ~(0U);
+	u32 val = 0x00;
+	int target = where;
+
+	WARN_ON(size > sizeof(_val));
+
+	pci_cfg = find_pci_cfg(bus, devfn);
+	if (!pci_cfg)
+		return -ENXIO;
+
+	memcpy(&val, pci_cfg->cfg_data + where, size);
+
+	if (where < CXLV_PCI_PM_CAP_OFFS) {
+		if (target == PCI_STATUS) {
+			mask = 0xF200;
+		} else if (target == PCI_BIST) {
+			mask = PCI_BIST_START;
+		} else if (target == PCI_BASE_ADDRESS_0) {
+			/* bar size is 1M */
+			mask = 0xFFE00000;
+		} else if (target == PCI_INTERRUPT_LINE) {
+			mask = 0xFF;
+		} else {
+			mask = 0x0;
+		}
+	}
+
+	val = (val & (~mask)) | (_val & mask);
+	memcpy(pci_cfg->cfg_data + where, &val, size);
+
+	pr_debug("[W] bridge 0x%x, mask: 0x%x, val: 0x%x -> 0x%x, size: %d, new: 0x%x\n", where, mask,
+	    val, _val, size, (val & (~mask)) | (_val & mask));
+
+	return 0;
+};
+
+static struct pci_ops cxlv_pci_ops = {
+	.read = cxlv_pci_read,
+	.write = cxlv_pci_write,
+};
+
+static struct pci_sysdata cxlv_pci_sysdata = {
+	.domain = CXLV_PCI_DOMAIN_NUM,
+	.node = 0,
+};
+
+static void cxlv_dev_reg_init(struct pci_dev *dev)
+{
+	struct cxl_bar *bar;
+	struct cap_array_header *array_header;
+	struct cap_header *cap_header;
+	struct cxlv_mbox *mbox;
+	struct cxl_dev_status *dev_status;
+	struct cxl_memdev_cap *memdev;
+	u16 val;
+	u64 status_val;
+
+	bar = ioremap(pci_resource_start(dev, 0) + CXLV_DEV_BAR_DEV_REGS_OFF, CXLV_DEV_BAR_DEV_REGS_LEN);
+
+	BUG_ON(!bar);
+
+	memset(bar, 0x0, CXLV_DEV_BAR_DEV_REGS_LEN);
+
+	/* Initialize device cap array header */
+	array_header = &bar->cap_array_header;
+	array_header->cap_id = cpu_to_le16(CXLDEV_CAP_ARRAY_CAP_ID);
+
+	val = CXLV_DEV_CAP_ARRAY_HEADER_VERS_DEFAULT;
+	val |= FIELD_PREP(CXLV_DEV_CAP_ARRAY_HEADER_TYPE_MASK, CXLV_DEV_CAP_ARRAY_HEADER_TYPE_MEMDEV);
+	array_header->vers_type = cpu_to_le16(val);
+
+	array_header->cap_count = cpu_to_le16(CXLV_DEV_CAP_ARRAY_SIZE);
+
+	/* Initialize device status cap */
+	cap_header = &bar->cap_headers[0];
+	cap_header->cap_id = cpu_to_le16(CXLDEV_CAP_CAP_ID_DEVICE_STATUS);
+	cap_header->version = 0;
+	cap_header->offset = cpu_to_le32(CXLV_DEV_CAP_STATUS_OFF);
+	cap_header->len = cpu_to_le32(CXLV_DEV_CAP_STATUS_LEN);
+
+	cap_header = &bar->cap_headers[1];
+	cap_header->cap_id = cpu_to_le16(CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX);
+	cap_header->version = 0;
+	cap_header->offset = cpu_to_le32(CXLV_DEV_CAP_MBOX_OFF);
+	cap_header->len = cpu_to_le32(CXLV_DEV_CAP_MBOX_LEN);
+
+	cap_header = &bar->cap_headers[2];
+	cap_header->cap_id = cpu_to_le16(CXLDEV_CAP_CAP_ID_MEMDEV);
+	cap_header->version = 0;
+	cap_header->offset = cpu_to_le32(CXLV_DEV_CAP_MEMDEV_OFF);
+	cap_header->len = cpu_to_le32(CXLV_DEV_CAP_MEMDEV_LEN);
+
+	dev_status = ((void *)bar) + CXLV_DEV_CAP_STATUS_OFF;
+	dev_status->status = 0;
+
+	mbox = ((void *)bar) + CXLV_DEV_CAP_MBOX_OFF;
+	mbox->cap = cpu_to_le32(CXLV_MBOX_CAP_PAYLOAD_SIZE_DEFAULT & CXLV_MBOX_CAP_PAYLOAD_SIZE_MASK);
+	mbox->control = 0;
+
+	memdev = ((void *)bar) + CXLV_DEV_CAP_MEMDEV_OFF;
+	status_val = CXLV_MEMDEV_CAP_MBXO_INTERFACE_READY;
+	status_val |= FIELD_PREP(CXLV_MEMDEV_CAP_MEDIA_STATUS_MASK, CXLV_MEMDEV_CAP_MEDIA_STATUS_DEFAULT);
+	status_val |= FIELD_PREP(CXLV_MEMDEV_CAP_MBOX_RESET_NEEDED_MASK, CXLV_MEMDEV_CAP_MBOX_RESET_NEEDED_DEFAULT);
+	memdev->status = cpu_to_le64(status_val);
+
+	iounmap(bar);
+}
+
+static int cxlv_component_reg_init(struct pci_dev *pdev, u32 off, u32 len)
+{
+	struct cxl_component *comp;
+	struct cxl_decoder_cap *decoder;
+	u32 val;
+
+	comp = ioremap(pci_resource_start(pdev, 0) + off, len);
+
+	val = CM_CAP_HDR_CAP_ID;
+	val |= FIELD_PREP(CXLV_COMP_CACHEMEM_HDR_CAP_VER_MASK, 1);
+	val |= FIELD_PREP(CXLV_COMP_CACHEMEM_HDR_CACHEMEM_VER_MASK, 1);
+	val |= FIELD_PREP(CXLV_COMP_CACHEMEM_HDR_ARRAY_SIZE_MASK, 1);
+	writel(val, &comp->cachemem_comp.header);
+
+	val = CXL_CM_CAP_CAP_ID_HDM;
+	val |= FIELD_PREP(CXLV_COMP_CACHEMEM_HDM_CAP_VER_MASK, 3);
+	val |= FIELD_PREP(CXLV_COMP_CACHEMEM_HDM_DECODER_POINTER_MASK, CXLV_COMP_DECODER_OFF);
+	writel(val, &comp->cachemem_comp.hdm_cap);
+
+	decoder = (struct cxl_decoder_cap *)((char *)comp + CXLV_COMP_CACHEMEM_OFF + CXLV_COMP_DECODER_OFF);
+	val = FIELD_PREP(CXLV_DECODER_CAP_DCOUNT_MASK, 0);
+	val |= FIELD_PREP(CXLV_DECODER_CAP_TCOUNT_MASK, 1);
+	writel(val, &decoder->cap_reg);
+
+	decoder->decoder[0].ctrl_regs &= ~CXLV_DECODER_CTRL_COMMITTED;
+
+	iounmap(comp);
+
+	return 0;
+}
+
+static void cxlv_msix_table_init(struct pci_dev *dev)
+{
+	void *msix_table;
+
+	msix_table = ioremap(pci_resource_start(dev, 0) + CXLV_BAR_PCI_MSIX_OFF,
+			CXLV_BAR_PCI_MSIX_LEN);
+	memset(msix_table, 0x00, CXLV_BAR_PCI_MSIX_LEN);
+	iounmap(msix_table);
+}
+
+static struct pci_bus *cxlv_pci_bus_init(struct cxlv_device *cxlv_device)
+{
+	struct pci_bus *bus = cxlv_device->host_bridge->bus;
+	struct pci_dev *dev, *t_dev;
+
+	pci_scan_child_bus(bus);
+
+	list_for_each_entry(t_dev, &bus->devices, bus_list) {
+		if (!t_dev->subordinate)
+			continue;
+
+		struct pci_bus *b_bus = t_dev->subordinate;
+		struct resource *res = &t_dev->resource[0];
+		int i;
+
+		cxlv_device->bridge_pdev = t_dev;
+
+		res->parent = &iomem_resource;
+
+		for (i = PCI_BRIDGE_RESOURCES; i <= PCI_BRIDGE_RESOURCE_END; i++) {
+			res = &t_dev->resource[i];
+			res->parent = &iomem_resource;
+		}
+
+		cxlv_component_reg_init(t_dev, CXLV_BRIDGE_BAR_COMPONENT_OFF, CXLV_BRIDGE_BAR_COMPONENT_LEN);
+		cxlv_msix_table_init(t_dev);
+
+		list_for_each_entry(dev, &b_bus->devices, bus_list) {
+			res = &dev->resource[0];
+			res->parent = &iomem_resource;
+
+			cxlv_device->dev_pdev = dev;
+			cxlv_dev_reg_init(dev);
+			cxlv_component_reg_init(dev, CXLV_DEV_BAR_COMPONENT_OFF, CXLV_DEV_BAR_COMPONENT_LEN);
+			cxlv_msix_table_init(dev);
+		}
+	}
+
+	return bus;
+};
+
+static void pci_dev_header_init(struct cxlv_pci_cfg_header *pcihdr, unsigned long base_pa)
+{
+	pcihdr->vid = CXLV_VENDOR_ID;
+	pcihdr->did = CXLV_DEVICE_ID;
+	u32 bar = 0;
+
+	pcihdr->status = cpu_to_le16(PCI_STATUS_CAP_LIST);
+
+	pcihdr->rid = 0x01;
+
+	pcihdr->class_code.bcc = PCI_BASE_CLASS_MEMORY;
+	pcihdr->class_code.scc = 0x02;
+	pcihdr->class_code.pi = 0x10;
+
+	pcihdr->header_type = PCI_HEADER_TYPE_NORMAL;
+
+	bar |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	bar |= PCI_BASE_ADDRESS_MEM_PREFETCH;
+	bar |= PCI_BASE_ADDRESS_SPACE_MEMORY;
+	bar |= base_pa & CXLV_PCI_BASE_ADDRESS_PA_MASK;
+	pcihdr->bar0 = cpu_to_le32(bar);
+
+	pcihdr->bar1 = cpu_to_le32(base_pa >> 32);
+
+	pcihdr->type0.subsystem_id = cpu_to_le16(CXLV_SUBSYSTEM_ID);
+	pcihdr->type0.subsystem_vendor_id = cpu_to_le16(CXLV_SUBSYSTEM_VENDOR_ID);
+
+	pcihdr->type0.expand_rom = cpu_to_le32(0);
+
+	pcihdr->type0.cap_pointer = CXLV_PCI_PM_CAP_OFFS;
+}
+
+static void pci_pmcap_init(struct cxlv_pci_pm_cap *pmcap)
+{
+	pmcap->cid = PCI_CAP_ID_PM;
+	pmcap->next = CXLV_PCI_MSIX_CAP_OFFS;
+
+	/* set version of power management cap to 0x11 */
+	pmcap->pm_cap = cpu_to_le16(PCI_PM_CAP_VER_MASK & 0x11);
+
+	pmcap->pm_ctrl_status = cpu_to_le16(PCI_D0 | PCI_PM_CTRL_NO_SOFT_RESET);
+}
+
+static void pci_msixcap_init(struct cxlv_pci_msix_cap *msixcap)
+{
+	u16 val;
+	u32 tab_val;
+
+	msixcap->cid = PCI_CAP_ID_MSIX;
+	msixcap->next = CXLV_PCIE_CAP_OFFS;
+
+	val = PCI_MSIX_FLAGS_ENABLE;
+	/* set msix table size decoded by (n + 1) */
+	val |= ((CXLV_BAR_PCI_MSIX_OFF - 1) & PCI_MSIX_FLAGS_QSIZE);
+	msixcap->msix_ctrl = cpu_to_le16(val);
+
+	/* msix table at the beginning of bar0 */
+	tab_val = (PCI_MSIX_TABLE_BIR & 0x0);
+	tab_val |= (PCI_MSIX_TABLE_OFFSET & CXLV_BAR_PCI_MSIX_OFF);
+	msixcap->msix_tab = cpu_to_le32(tab_val);
+}
+
+static void pci_pciecap_init(struct cxlv_pcie_cap *pciecap, u8 type)
+{
+	u32 val;
+	u16 cap_val;
+
+	pciecap->cid = PCI_CAP_ID_EXP;
+	pciecap->next = 0x0;
+
+	cap_val = CXLV_PCI_EXP_VERS_DEFAULT;
+	cap_val |= FIELD_PREP(CXLV_PCI_EXP_TYPE_MASK, type);
+	pciecap->pcie_cap = cpu_to_le16(cap_val);
+
+	val = CXLV_PCI_EXP_PAYLOAD_DEFAULT;
+	val |= FIELD_PREP(CXLV_PCI_EXP_DEVCAP_L0S_MASK, CXLV_PCI_EXP_DEVCAP_L0S_DEFAULT);
+	val |= FIELD_PREP(CXLV_PCI_EXP_DEVCAP_L1_MASK, CXLV_PCI_EXP_DEVCAP_L1_DEFAULT);
+	pciecap->pcie_dev_cap = cpu_to_le32(val);
+}
+
+static void init_pci_ext_cap(struct cxlv_pci_ext_cap *ext_cap, u16 next)
+{
+	u16 next_val;
+
+	ext_cap->cid = cpu_to_le16(PCI_EXT_CAP_ID_DVSEC);
+	next_val = CXLV_PCI_EXT_CAP_VERS_DEFAULT;
+	next_val |= FIELD_PREP(CXLV_PCI_EXT_CAP_NEXT_MASK, next);
+	ext_cap->next = cpu_to_le16(next_val);
+}
+
+static void init_cxl_dvsec_header1(__le32 *header1, u16 len)
+{
+	u32 header1_val;
+
+	header1_val = PCI_DVSEC_VENDOR_ID_CXL;
+	header1_val |= FIELD_PREP(CXLV_DVSEC_REVISION_MASK, CXLV_DVSEC_REVISION_DEFAULT);
+	header1_val |= FIELD_PREP(CXLV_DVSEC_LEN_MASK, len);
+
+	*header1 = cpu_to_le32(header1_val);
+}
+
+static void init_cxl_loc_low(__le32 *low, u8 bar, u8 type, u64 off)
+{
+	u32 val;
+	u32 off_val;
+
+	off_val = FIELD_GET(CXLV_DVSEC_LOC_LO_OFF_MASK, off);
+
+	val = bar;
+	val |= FIELD_PREP(CXLV_DVSEC_LOC_LO_TYPE_MASK, type);
+	val |= FIELD_PREP(CXLV_DVSEC_LOC_LO_OFF_MASK, off_val);
+
+	*low = cpu_to_le32(val);
+}
+
+static void init_cxl_loc_hi(__le32 *hi, u64 off)
+{
+	u32 off_val;
+
+	if (!FIELD_FIT(CXLV_DVSEC_LOC_HI_OFF_MASK, off)) {
+		*hi = cpu_to_le32(0);
+		return;
+	}
+
+	off_val = FIELD_GET(CXLV_DVSEC_LOC_HI_OFF_MASK, off);
+	*hi = cpu_to_le32(FIELD_PREP(CXLV_DVSEC_LOC_HI_OFF_MASK, off_val));
+}
+
+static void pci_dev_excap_init(struct cxlv_pci_ext_cap *ext_cap)
+{
+	void *ext_cap_base = ext_cap;
+	struct cxlv_pci_ext_cap_id_dvsec *cap_id;
+	struct cxlv_pci_ext_cap_locator *cap_loc;
+	struct reg_block_loc *loc;
+	u16 cap_val;
+
+	/* Initialize the CXL_DVSEC_PCIE_DEVICE */
+	cap_id = ext_cap_base;
+	init_pci_ext_cap(&cap_id->header.cap_header, PCI_CFG_SPACE_SIZE + 0x3c);
+
+	init_cxl_dvsec_header1(&cap_id->header.cxl_header1, 0x3c);
+
+	cap_id->header.cxl_header2 = cpu_to_le16(CXL_DVSEC_PCIE_DEVICE);
+
+	cap_val = CXLV_DVSEC_CAP_MEM;
+	cap_val |= FIELD_PREP(CXLV_DVSEC_CAP_HDM_COUNT_MASK, 1);
+	cap_id->cap = cpu_to_le16(cap_val);
+
+	cap_id->size_low_1 = cpu_to_le32(CXLV_DVSEC_CAP_VALID | CXLV_DVSEC_CAP_ACTIVE);
+
+	/* Initialize locator dvsec for memdev */
+	cap_loc = ext_cap_base + 0x3c;
+	init_pci_ext_cap(&cap_loc->header.cap_header, 0);
+
+	init_cxl_dvsec_header1(&cap_loc->header.cxl_header1, 0xC + sizeof(struct reg_block_loc) * 2);
+
+	cap_loc->header.cxl_header2 = cpu_to_le16(CXL_DVSEC_REG_LOCATOR);
+
+	loc = &cap_loc->loc1;
+	init_cxl_loc_low(&loc->reg_block_lo_off, 0, CXL_REGLOC_RBI_MEMDEV, CXLV_DEV_BAR_DEV_REGS_OFF);
+	init_cxl_loc_hi(&loc->reg_block_hi_off, CXLV_DEV_BAR_DEV_REGS_OFF);
+
+	loc = &cap_loc->loc2;
+	init_cxl_loc_low(&loc->reg_block_lo_off, 0, CXL_REGLOC_RBI_COMPONENT, CXLV_DEV_BAR_COMPONENT_OFF);
+	init_cxl_loc_hi(&loc->reg_block_hi_off, CXLV_DEV_BAR_COMPONENT_OFF);
+}
+
+static void pci_bridge_extcap_init(struct cxlv_pci_ext_cap *ext_cap)
+{
+	void *ext_cap_base = ext_cap;
+	struct cxlv_pci_ext_cap_id_dvsec *cap_id;
+	struct cxlv_pci_ext_cap_locator *cap_loc;
+	struct reg_block_loc *loc;
+	u16 cap_val;
+
+	/* Initialize the CXL_DVSEC_PCIE_DEVICE */
+	cap_id = ext_cap_base;
+	init_pci_ext_cap(&cap_id->header.cap_header, PCI_CFG_SPACE_SIZE + 0x3c);
+
+	init_cxl_dvsec_header1(&cap_id->header.cxl_header1, 0x3c);
+	cap_id->header.cxl_header2 = cpu_to_le16(CXL_DVSEC_PCIE_DEVICE);
+
+	cap_val = CXLV_DVSEC_CAP_MEM;
+	cap_val |= FIELD_PREP(CXLV_DVSEC_CAP_HDM_COUNT_MASK, 1);
+	cap_id->cap = cpu_to_le16(cap_val);
+
+	cap_id->size_low_1 = cpu_to_le32(CXLV_DVSEC_CAP_VALID | CXLV_DVSEC_CAP_ACTIVE);
+
+	/* Initialize locator dvsec for memdev */
+	cap_loc = ext_cap_base + 0x3c;
+	init_pci_ext_cap(&cap_loc->header.cap_header, 0);
+
+	init_cxl_dvsec_header1(&cap_loc->header.cxl_header1, 0xC + sizeof(struct reg_block_loc) * 3);
+	cap_loc->header.cxl_header2 = cpu_to_le16(CXL_DVSEC_REG_LOCATOR);
+
+	loc = &cap_loc->loc1;
+	init_cxl_loc_low(&loc->reg_block_lo_off, 0, CXL_REGLOC_RBI_COMPONENT, CXLV_BRIDGE_BAR_COMPONENT_OFF);
+	init_cxl_loc_hi(&loc->reg_block_hi_off, CXLV_BRIDGE_BAR_COMPONENT_OFF);
+}
+
+
+static void pci_bridge_header_init(struct cxlv_pci_cfg_header *pcihdr, unsigned long base_pa)
+{
+	u32 bar;
+
+	pcihdr->did = CXLV_DEVICE_ID;
+	pcihdr->vid = CXLV_VENDOR_ID;
+	pcihdr->status = cpu_to_le16(PCI_STATUS_CAP_LIST);
+
+	pcihdr->header_type = PCI_HEADER_TYPE_BRIDGE;
+
+	pcihdr->rid = 0x01;
+
+	pcihdr->class_code.bcc = PCI_BASE_CLASS_BRIDGE;
+	pcihdr->class_code.scc = 0x04;
+	pcihdr->class_code.pi = 0x00;
+
+	bar = PCI_BASE_ADDRESS_MEM_TYPE_64;
+	bar |= PCI_BASE_ADDRESS_MEM_PREFETCH;
+	bar |= PCI_BASE_ADDRESS_SPACE_MEMORY;
+	bar |= base_pa & CXLV_PCI_BASE_ADDRESS_PA_MASK;
+	pcihdr->bar0 = cpu_to_le32(bar);
+
+	pcihdr->bar1 = cpu_to_le32(base_pa >> 32);
+
+	pcihdr->type1.capabilities_pointer = CXLV_PCI_PM_CAP_OFFS;
+}
+
+static void pci_pointer_assign(struct cxlv_pci_cfg *cfg)
+{
+	cfg->pcihdr = (void *)cfg->cfg_data + CXLV_PCI_HDR_OFFS;
+	cfg->pmcap = (void *)cfg->cfg_data + CXLV_PCI_PM_CAP_OFFS;
+	cfg->msixcap = (void *)cfg->cfg_data + CXLV_PCI_MSIX_CAP_OFFS;
+	cfg->pciecap = (void *)cfg->cfg_data + CXLV_PCIE_CAP_OFFS;
+	cfg->extcap = (void *)cfg->cfg_data + CXLV_PCI_EXT_CAP_OFFS;
+}
+
+static int pci_bridge_init(struct cxlv_pci_cfg *bridge, u64 off)
+{
+	pci_pointer_assign(bridge);
+
+	pci_bridge_header_init(bridge->pcihdr, off);
+	pci_pmcap_init(bridge->pmcap);
+	pci_msixcap_init(bridge->msixcap);
+	pci_pciecap_init(bridge->pciecap, PCI_EXP_TYPE_ROOT_PORT);
+	pci_bridge_extcap_init(bridge->extcap);
+
+	return 0;
+}
+
+static void pci_dev_init(struct cxlv_pci_cfg *dev_cfg, u64 off)
+{
+	pci_pointer_assign(dev_cfg);
+
+	pci_dev_header_init((struct cxlv_pci_cfg_header *)dev_cfg->pcihdr, off);
+	pci_pmcap_init(dev_cfg->pmcap);
+	pci_msixcap_init(dev_cfg->msixcap);
+	pci_pciecap_init(dev_cfg->pciecap, PCI_EXP_TYPE_ENDPOINT);
+	pci_dev_excap_init(dev_cfg->extcap);
+}
+
+static int cxlv_pci_find_busnr(int domain_start, int *domain_ret, int *bus_ret)
+{
+	int domain = domain_start;
+	int busnr = 0;
+	struct pci_bus *bus;
+
+	for (; domain < 255; domain++) {
+		for (busnr = 0; busnr < 255; busnr++) {
+			bus = pci_find_bus(domain, busnr);
+			if (!bus) {
+				goto found;
+			}
+		}
+	}
+
+	pr_err("There is no available bus number found.");
+
+	return -1;
+found:
+	*domain_ret = domain;
+	*bus_ret = busnr;
+
+	return 0;
+}
+
+static int cxlv_pci_create_host_bridge(struct cxlv_device *cxlv_device)
+{
+	LIST_HEAD(resources);
+	struct pci_bus *bus;
+	int domain, busnr;
+	int ret;
+	static struct resource busn_res = {
+	        .start = 0,
+	        .end = 255,
+	        .flags = IORESOURCE_BUS,
+	};
+
+	ret = cxlv_pci_find_busnr(CXLV_PCI_DOMAIN_NUM, &domain, &busnr);
+	if (ret) {
+		return ret;
+	}
+
+	cxlv_device->domain_nr = domain;
+	cxlv_device->host_bridge_busnr = busnr;
+
+	cxlv_pci_sysdata.domain = domain;
+
+	pci_add_resource(&resources, &ioport_resource);
+	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_res);
+
+	bus = pci_create_root_bus(NULL, busnr, &cxlv_pci_ops, &cxlv_pci_sysdata, &resources);
+	if (!bus) {
+		pci_free_resource_list(&resources);
+		pr_err("Unable to create PCI bus\n");
+		return -1;
+	}
+
+	cxlv_device->host_bridge = to_pci_host_bridge(bus->bridge);
+
+	/* TODO to support native cxl error */
+	cxlv_device->host_bridge->native_cxl_error = 0;
+
+	return 0;
+}
+
+int cxlv_pci_init(struct cxlv_device *cxlv_device)
+{
+	cxlv_pci_create_host_bridge(cxlv_device);
+
+	pci_bridge_init(&cxlv_device->bridge_cfg, cxlv_device->opts->memstart + CXLV_BRIDGE_REG_OFF);
+
+	pci_dev_init(&cxlv_device->dev_cfg, cxlv_device->opts->memstart + CXLV_DEV_REG_OFF);
+
+	cxlv_pci_bus_init(cxlv_device);
+
+	return 0;
+}
diff --git a/drivers/cxl/cxl_virt/cxlv_pci.h b/drivers/cxl/cxl_virt/cxlv_pci.h
new file mode 100644
index 000000000000..b39c27760859
--- /dev/null
+++ b/drivers/cxl/cxl_virt/cxlv_pci.h
@@ -0,0 +1,549 @@
+#ifndef __CXLV_PCI_H__
+#define __CXLV_PCI_H__
+#include <linux/pci.h>
+
+/* [PCIE 6.0] 7.5.1 PCI-Compatible Configuration Registers */
+#define CXLV_PCI_BASE_ADDRESS_PA_MASK	0xFFFF8000
+
+struct cxlv_pci_cfg_header {
+	__le16 vid; /* vendor ID */
+	__le16 did; /* device ID */
+
+	__le16 command;
+	__le16 status;
+
+	u8 rid;	/* revision ID */
+
+	struct {
+		u8 pi;
+		u8 scc;
+		u8 bcc;
+	} class_code;
+
+	u8 cache_line_size;
+	u8 latency_timer_reg;
+
+	u8 header_type;
+	u8 bist;
+
+	__le32 bar0;
+	__le32 bar1;
+
+	union {
+		struct {
+			__le32 bar[4];
+
+			__le32 cardbus_cis_pointer;
+
+			__le16 subsystem_vendor_id;
+			__le16 subsystem_id;
+
+			__le32 expand_rom;
+			u8 cap_pointer;
+
+			u8 rsvd[7];
+
+			u8 intr_line;
+			u8 intr_pin;
+
+			u8 min_gnt;
+			u8 max_lat;
+		} type0;
+		struct {
+			u8 primary_bus;
+			u8 secondary_bus;
+			u8 subordinate_bus;
+			u8 secondary_latency_timer;
+			u8 iobase;
+			u8 iolimit;
+			__le16 secondary_status;
+			__le16 membase;
+			__le16 memlimit;
+			__le16 pref_mem_base;
+			__le16 pref_mem_limit;
+			__le32 prefbaseupper;
+			__le32 preflimitupper;
+			__le16 iobaseupper;
+			__le16 iolimitupper;
+			u8 capabilities_pointer;
+			u8 reserve[3];
+			__le32 romaddr;
+			u8 intline;
+			u8 intpin;
+			__le16 bridgectrl;
+		} type1;
+	};
+};
+
+struct cxlv_pci_pm_cap {
+	u8 cid;
+	u8 next;
+
+	__le16 pm_cap; /* power management capability */
+	__le16 pm_ctrl_status; /* power management control status */
+
+	u8 resv;
+	u8 data;
+};
+
+struct cxlv_pci_msix_cap {
+	u8 cid;
+	u8 next;
+
+	__le16 msix_ctrl;
+	__le32 msix_tab;
+	__le32 msix_pba; /* pending bit array */
+};
+
+/*
+ * [PCIE 6.0] 7.5.3.2 PCI Express Capabilities Register
+ */
+
+/* version must be hardwired to 2h for Functions compliant */
+#define CXLV_PCI_EXP_VERS_DEFAULT	2
+
+#define CXLV_PCI_EXP_TYPE_MASK		GENMASK(7, 4)
+
+/*
+ *
+ * Max payload size defined encodings are:
+ *
+ * 000b		128 bytes max payload size
+ * 001b		256 bytes max payload size
+ * 010b		512 bytes max payload size
+ * 011b		1024 bytes max payload size
+ * 100b		2048 bytes max payload size
+ * 101b		4096 bytes max payload size
+ */
+
+/* set default max payload to 256 bytes */
+#define CXLV_PCI_EXP_PAYLOAD_DEFAULT	0b001
+
+/*
+ * Endpoint L0s Acceptable Latency
+ *
+ * 000b		Maximum of 64 ns
+ * 001b		Maximum of 128 ns
+ * 010b		Maximum of 256 ns
+ * 011b		Maximum of 512 ns
+ * 100b		Maximum of 1 μs
+ * 101b		Maximum of 2 μs
+ * 110b		Maximum of 4 μs
+ * 111b		No limit
+ */
+#define CXLV_PCI_EXP_DEVCAP_L0S_MASK	GENMASK(8, 6)
+#define CXLV_PCI_EXP_DEVCAP_L0S_DEFAULT 0b110
+
+/*
+ * Endpoint L1 Acceptable Latency
+ *
+ * 000b		Maximum of 1 μs
+ * 001b		Maximum of 2 μs
+ * 010b		Maximum of 4 μs
+ * 011b		Maximum of 8 μs
+ * 100b		Maximum of 16 μs
+ * 101b		Maximum of 32 μs
+ * 110b		Maximum of 64 μs
+ * 111b		No limit
+ */
+#define CXLV_PCI_EXP_DEVCAP_L1_MASK	GENMASK(11, 9)
+#define CXLV_PCI_EXP_DEVCAP_L1_DEFAULT	0b110
+
+struct cxlv_pcie_cap {
+	u8 cid;
+	u8 next;
+
+	__le16 pcie_cap;
+	__le32 pcie_dev_cap;
+	__le16 pxdc;
+	__le16 pxds;
+	__le32 pxlcap;
+	__le16 pxlc;
+	__le16 pxls;
+
+	/* not used in cxlv */
+	__le32 others[10];
+};
+
+/**
+ *
+ * [PCIE 6.0] 7.6.3 PCI Express Extended Capability Header
+ */
+#define CXLV_PCI_EXT_CAP_VERS_DEFAULT	1
+#define CXLV_PCI_EXT_CAP_NEXT_MASK	GENMASK(15, 4)
+
+struct cxlv_pci_ext_cap {
+	__le16 cid;
+	__le16 next;
+};
+
+/*
+ * cxlv memory layout
+ *
+ * |--dev regs (1M)---|--bridge regs (1M)---|---reserved(2M)---|----resource (rest)-----|
+ */
+#define CXLV_DEV_REG_OFF			0x0
+#define CXLV_DEV_REG_SIZE			0x100000
+#define CXLV_BRIDGE_REG_OFF			(CXLV_DEV_REG_OFF + CXLV_DEV_REG_SIZE)
+#define CXLV_BRIDGE_REG_SIZE			0x100000
+
+/* resource start from 4M offset */
+#define CXLV_RESOURCE_OFF		0x400000
+
+#define   CXLV_BAR_PCI_MSIX_OFF		0x0
+#define   CXLV_MSIX_ENTRY_NUM		128
+#define   CXLV_BAR_PCI_MSIX_LEN		(PCI_MSIX_ENTRY_SIZE * CXLV_MSIX_ENTRY_NUM)
+
+#define CXLV_DEV_BAR_PCI_OFF		0x0
+#define CXLV_DEV_BAR_PCI_LEN		0x10000
+#define CXLV_DEV_BAR_DEV_REGS_OFF	(CXLV_DEV_BAR_PCI_OFF + CXLV_DEV_BAR_PCI_LEN)
+#define CXLV_DEV_BAR_DEV_REGS_LEN	0x10000
+#define CXLV_DEV_BAR_COMPONENT_OFF	(CXLV_DEV_BAR_DEV_REGS_OFF + CXLV_DEV_BAR_DEV_REGS_LEN)
+#define CXLV_DEV_BAR_COMPONENT_LEN	0x10000
+#define CXLV_DEV_BAR_LSA_OFF		(CXLV_DEV_BAR_COMPONENT_OFF + CXLV_DEV_BAR_COMPONENT_LEN)
+#define CXLV_DEV_BAR_LSA_LEN		0x10000
+
+#define CXLV_BRIDGE_BAR_PCI_OFF		0x0
+#define CXLV_BRIDGE_BAR_PCI_LEN		0x10000
+#define CXLV_BRIDGE_BAR_COMPONENT_OFF	(CXLV_BRIDGE_BAR_PCI_OFF + CXLV_BRIDGE_BAR_PCI_LEN)
+#define CXLV_BRIDGE_BAR_COMPONENT_LEN	0x10000
+
+/*
+ * [CXL 3.0] 8.1.3 PCIe DVSEC for CXL Devices
+ */
+
+/*
+ * DVSEC Revision ID 2h represents the structure
+ * as defined in the CXL 3.0 specification.
+ * */
+
+#define CXLV_DVSEC_REVISION_MASK	GENMASK(19, 16)
+#define CXLV_DVSEC_LEN_MASK		GENMASK(31, 20)
+
+#define CXLV_DVSEC_REVISION_DEFAULT	3
+
+struct cxlx_dvsec_header {
+	struct cxlv_pci_ext_cap cap_header;
+	__le32 cxl_header1;
+	__le16 cxl_header2;
+} __packed;
+
+#define CXLV_DVSEC_CAP_MEM		0x4
+#define CXLV_DVSEC_CAP_HDM_COUNT_MASK	GENMASK(5, 4)
+
+#define CXLV_DVSEC_CAP_VALID		0x1
+#define CXLV_DVSEC_CAP_ACTIVE		0x2
+struct cxlv_pci_ext_cap_id_dvsec {
+	struct cxlx_dvsec_header header;
+	__le16 cap;
+
+	__le32	skip[3];
+	__le32	size_hi_1;
+	__le32	size_low_1;
+};
+
+/*
+ * [CXL 3.0] 8.1.9 Register Locator DVSEC
+ */
+
+#define CXLV_DVSEC_LOC_LO_TYPE_MASK	GENMASK(15, 8)
+#define CXLV_DVSEC_LOC_LO_OFF_MASK	GENMASK(31, 16)
+#define CXLV_DVSEC_LOC_HI_OFF_MASK	GENMASK(63, 32)
+struct reg_block_loc {
+	__le32 reg_block_lo_off;
+	__le32 reg_block_hi_off;
+};
+
+struct cxlv_pci_ext_cap_locator {
+	struct cxlx_dvsec_header header;
+	struct reg_block_loc loc1;
+	struct reg_block_loc loc2;
+	struct reg_block_loc loc3;
+};
+
+/*
+ * [CXL 3.0] 8.2.8 CXL Device Register Interface
+ */
+
+/*
+ * Version: Defines the version of the capability structure present. This field shall be
+ * set to 01h. Software shall check this version number during initialization to
+ * determine the layout of the device capabilities, treating an unknown version number
+ * as an error preventing any further access to the device by that software.
+ */
+#define CXLV_DEV_CAP_ARRAY_HEADER_VERS_DEFAULT	1
+/*
+ * Type: Identifies the type-specific capabilities in the CXL Device Capabilities Array.
+ *   0h = The type is inferred from the PCI Class code. If the PCI Class code is not
+ * associated with a type defined by this specification, no type-specific capabilities
+ * are present.
+ *   1h = Memory Device Capabilities (see Section 8.2.8.5).
+ *   2h = Switch Mailbox CCI Capabilities (see Section 8.2.8.6).
+ *   All other encodings are reserved.
+ */
+#define CXLV_DEV_CAP_ARRAY_HEADER_TYPE_MASK	GENMASK(12, 8)
+#define CXLV_DEV_CAP_ARRAY_HEADER_TYPE_MEMDEV	1
+#define CXLV_DEV_CAP_ARRAY_HEADER_TYPE_SWITCH	2
+
+struct cap_array_header {
+	__le16	cap_id;
+	__le16	vers_type;
+	__le16	cap_count;
+	__le16	res[5];
+} __packed;
+
+struct cap_header {
+	__le16	cap_id;
+	__le16	version;
+	__le32	offset;
+	__le32	len;
+	__le32	res2;
+};
+
+struct cxl_bar {
+	struct cap_array_header cap_array_header;
+	struct cap_header	cap_headers[];
+};
+
+/*
+ *
+ * [CXL 3.0] 8.2.8.3 Device Status Registers (Offset: Varies)
+ */
+struct cxl_dev_status {
+	__le32	status;
+	__le32	reserved;
+};
+
+/*
+ * [CXL 3.0] 8.2.8.4 Mailbox Registers (Offset: Varies)
+ */
+
+/*
+ * Payload Size: Size of the Command Payload registers in bytes, expressed as 2^n.
+ * The minimum size is 256 bytes (n=8) and the maximum size is 1 MB (n=20).
+ */
+#define CXLV_MBOX_CAP_PAYLOAD_SIZE_MASK		0x1f
+#define CXLV_MBOX_CAP_PAYLOAD_SIZE_DEFAULT	11	/* 2K */
+
+struct cxlv_mbox {
+	__le32 cap;
+	__le32 control;
+	__le64 cmd;
+	__le64 status;
+	__le64 bg_cmd_status;
+	u8	payload[];
+} __packed;
+
+static inline bool cxlv_mbox_test_doorbell(struct cxlv_mbox *mbox)
+{
+	return (readl(&mbox->control) & CXLDEV_MBOX_CTRL_DOORBELL);
+}
+
+static inline void cxlv_mbox_clear_doorbell(struct cxlv_mbox *mbox)
+{
+	u32 val;
+
+	val = readl(&mbox->control);
+	val &= ~CXLDEV_MBOX_CTRL_DOORBELL;
+
+	writel(val, &mbox->control);
+}
+
+static inline u16 cxlv_mbox_get_cmd(struct cxlv_mbox *mbox)
+{
+	return FIELD_GET(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK, mbox->cmd);
+}
+
+static inline void cxlv_mbox_set_cmd_payload_len(struct cxlv_mbox *mbox, u16 len)
+{
+	u64 val;
+
+	val = readq(&mbox->cmd);
+	val |= FIELD_PREP(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, len);
+
+	writeq(val, &mbox->cmd);
+}
+
+static inline void cxlv_mbox_set_retcode(struct cxlv_mbox *mbox, int ret)
+{
+	u64 val;
+
+	val = readq(&mbox->control);
+	val |= FIELD_PREP(CXLDEV_MBOX_STATUS_RET_CODE_MASK, ret);
+
+	writeq(val, &mbox->control);
+}
+
+static inline void cxlv_mbox_copy_to_payload(struct cxlv_mbox *mbox, u32 off,
+		void *p, u32 len)
+{
+	memcpy_toio(mbox->payload + off, p, len);
+}
+
+static inline void cxlv_mbox_copy_from_payload(struct cxlv_mbox *mbox, u32 off,
+		void *p, u32 len)
+{
+	memcpy_fromio(p, mbox->payload + off, len);
+}
+
+/*
+ * [CXL 3.0] 8.2.8.5 Memory Device Capabilities
+ */
+
+/*
+ * Media Status: Describes the status of the device media.
+ *  00b = Not Ready - Media training is incomplete.
+ *  01b = Ready - The media trained successfully and is ready for use.
+ *  10b = Error - The media failed to train or encountered an error.
+ *  11b = Disabled - Access to the media is disabled.
+ */
+#define CXLV_MEMDEV_CAP_MEDIA_STATUS_MASK	GENMASK(3, 2)
+#define CXLV_MEMDEV_CAP_MEDIA_STATUS_DEFAULT	0b01
+
+#define CXLV_MEMDEV_CAP_MBXO_INTERFACE_READY	0x10
+
+/*
+ * Reset Needed: When nonzero, indicates the least impactful reset type needed to
+ * return the device to the operational state. A cold reset is considered more impactful
+ * than a warm reset. A warm reset is considered more impactful that a hot reset,
+ * which is more impactful than a CXL reset. This field returns nonzero value if FW Halt
+ * is set, Media Status is in the Error or Disabled state, or the Mailbox Interfaces Ready
+ * does not become set.
+ *  000b = Device is operational and a reset is not required
+ *  001b = Cold Reset
+ *  010b = Warm Reset
+ *  011b = Hot Reset
+ *  100b = CXL Reset (device must not report this value if it does not support CXL
+ * Reset)
+ * • All other encodings are reserved.
+ */
+#define CXLV_MEMDEV_CAP_MBOX_RESET_NEEDED_MASK		GENMASK(7, 5)
+#define CXLV_MEMDEV_CAP_MBOX_RESET_NEEDED_DEFAULT	0b0
+
+struct cxl_memdev_cap {
+	__le64 status;
+} __packed;
+
+#define CXLV_DEV_CAP_MBOX_PAYLOAD	2048
+#define CXLV_DEV_CAP_ARRAY_SIZE		4
+
+#define CXLV_DEV_CAP_STATUS_OFF		(0x10 * CXLV_DEV_CAP_ARRAY_SIZE)
+#define CXLV_DEV_CAP_STATUS_LEN		sizeof(struct cxl_dev_status)
+#define CXLV_DEV_CAP_MEMDEV_OFF		(CXLV_DEV_CAP_STATUS_OFF + CXLV_DEV_CAP_STATUS_LEN)
+#define CXLV_DEV_CAP_MEMDEV_LEN		sizeof(struct cxl_memdev_cap)
+#define CXLV_DEV_CAP_MBOX_OFF		(CXLV_DEV_CAP_MEMDEV_OFF + CXLV_DEV_CAP_MEMDEV_LEN)
+#define CXLV_DEV_CAP_MBOX_LEN		sizeof(struct cxlv_mbox) + CXLV_DEV_CAP_MBOX_PAYLOAD
+
+struct cxlv_pci_ext_cap_dsn {
+	struct cxlv_pci_ext_cap id;
+	__le64 serial;
+};
+
+/*
+ * [CXL 3.0] 8.2.3 Component Register Layout and Definition
+ */
+
+#define CXLV_COMP_CACHEMEM_OFF		4096
+#define   CXLV_COMP_DECODER_OFF		1024
+
+#define   CXLV_COMP_CACHEMEM_HDR_CAP_ID_MASK		GENMASK(15, 0)
+#define   CXLV_COMP_CACHEMEM_HDR_CAP_VER_MASK		GENMASK(19, 16)
+#define   CXLV_COMP_CACHEMEM_HDR_CACHEMEM_VER_MASK	GENMASK(23, 20)
+#define   CXLV_COMP_CACHEMEM_HDR_ARRAY_SIZE_MASK	GENMASK(31, 24)
+
+#define   CXLV_COMP_CACHEMEM_HDM_CAP_ID_MASK		GENMASK(15, 0)
+#define   CXLV_COMP_CACHEMEM_HDM_CAP_VER_MASK		GENMASK(19, 16)
+#define   CXLV_COMP_CACHEMEM_HDM_DECODER_POINTER_MASK	GENMASK(31, 20)
+
+struct cxl_cachemem_comp {
+	__le32 header;
+	__le32 hdm_cap;
+};
+
+struct cxl_component {
+	u8	resv1[4096];
+	struct cxl_cachemem_comp	cachemem_comp;
+	u8	impl_spec[49152];
+	u8	arb_mux[1024];
+	u8	resv2[7168];
+};
+
+/*
+ * Decoder Count: Reports the number of memory address decoders
+ * implemented by the component. CXL devices shall not advertise more than 10
+ * decoders. CXL switches and Host Bridges may advertise up to 32 decoders.
+ * 0h – 1 Decoder
+ * 1h – 2 Decoders
+ * 2h – 4 Decoders
+ * 3h – 6 Decoders
+ * 4h – 8 Decoders
+ * 5h – 10 Decoders
+ * 6h – 12 Decoders2
+ * 7h – 14 Decoders2
+ * 8h – 16 Decoders2
+ * 9h – 20 Decoders2
+ * Ah – 24 Decoders2
+ * Bh – 28 Decoders2
+ * Ch – 32 Decoders2
+ * All other values are reserved
+ */
+#define CXLV_DECODER_CAP_DCOUNT_MASK	GENMASK(3, 0)
+
+/*
+ * Target Count: The number of target ports each decoder supports (applicable
+ * only to Upstream Switch Port and CXL Host Bridge). Maximum of 8.
+ * 1h – 1 target port
+ * 2h – 2 target ports
+ * 4h – 4 target ports
+ * 8h – 8 target ports
+ * All other values are reserved.
+ */
+#define CXLV_DECODER_CAP_TCOUNT_MASK	GENMASK(7, 4)
+
+#define CXLV_DECODER_GLOBAL_CTRL_POISON		BIT(0)
+#define CXLV_DECODER_GLOBAL_CTRL_ENABLE		BIT(1)
+
+#define CXLV_DECODER_CTRL_IG_MASK		GENMASK(3, 0)
+#define CXLV_DECODER_CTRL_IW_MASK		GENMASK(7, 4)
+#define CXLV_DECODER_CTRL_COMMIT		BIT(9)
+#define CXLV_DECODER_CTRL_COMMITTED		BIT(10)
+#define CXLV_DECODER_CTRL_COMMIT_ERR	BIT(11)
+
+struct cxl_decoder_regs {
+	__le32	base_lo;
+	__le32	base_hi;
+	__le32	size_lo;
+	__le32	size_hi;
+
+	__le32 ctrl_regs;
+
+	union {
+		__le32	target_list_lo;
+		__le32	dpa_skip_lo;
+	};
+	union {
+		__le32	target_list_hi;
+		__le32	dpa_skip_hi;
+	};
+} __packed;
+
+struct cxl_decoder_cap {
+	__le32 cap_reg;
+	__le32 global_ctrl_reg;
+	__le32	resv[2];
+	struct cxl_decoder_regs decoder[];
+} __packed;
+
+
+/* use domain 0x10 instead of 0x0 to avoid race with real pci device */
+#define CXLV_PCI_DOMAIN_NUM	0x10
+#define CXLV_PCI_BUS_NUM	0x0
+
+/* offset in pci configureation space */
+#define CXLV_PCI_HDR_OFFS	0x0
+#define CXLV_PCI_PM_CAP_OFFS	0x40
+#define CXLV_PCI_MSIX_CAP_OFFS	0x50
+#define CXLV_PCIE_CAP_OFFS	0x60
+
+#define CXLV_PCI_EXT_CAP_OFFS (PCI_CFG_SPACE_SIZE)
+#endif /* __CXLV_PCI_H__ */
diff --git a/drivers/cxl/cxl_virt/cxlv_port.c b/drivers/cxl/cxl_virt/cxlv_port.c
new file mode 100644
index 000000000000..eb1a2de7f333
--- /dev/null
+++ b/drivers/cxl/cxl_virt/cxlv_port.c
@@ -0,0 +1,149 @@
+#include "cxlv.h"
+#include "cxlv_pci.h"
+
+static int cxlv_port_create_root_port(struct cxlv_device *cxlv_device)
+{
+	struct device *host = &cxlv_device->dev;
+	struct cxl_port *root_port;
+
+	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
+	if (IS_ERR(root_port))
+		return PTR_ERR(root_port);
+
+	cxlv_device->root_port = root_port;
+
+	return 0;
+}
+
+static int cxlv_port_add_root_decoder(struct cxlv_device *cxlv_device, struct resource *cxlv_res)
+{
+	int ret;
+	struct resource *res;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_decoder *cxld;
+	int target_map[CXL_DECODER_MAX_INTERLEAVE];
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	res->name = kasprintf(GFP_KERNEL, "CXLV Window %d", cxlv_device->cxlv_dev_id);
+	if (!res->name)
+		goto free_res;
+
+	res->start = cxlv_device->opts->memstart + CXLV_RESOURCE_OFF;
+	res->end = cxlv_device->opts->memstart + cxlv_device->opts->memsize - 1;
+	res->flags = IORESOURCE_MEM;
+
+	ret = insert_resource(cxlv_res, res);
+	if (ret)
+		goto free_name;
+
+	cxlrd = cxl_root_decoder_alloc(cxlv_device->root_port, 1, cxl_hb_modulo);
+	if (IS_ERR(cxlrd)) {
+		ret = PTR_ERR(cxlrd);
+		goto out;
+	}
+	cxlrd->qos_class = 0;
+
+	cxld = &cxlrd->cxlsd.cxld;
+	cxld->flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM | CXL_DECODER_F_PMEM;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+
+	cxld->hpa_range = (struct range) {
+		.start = res->start,
+		.end = res->end,
+	};
+	cxld->interleave_ways = 1;
+	cxld->interleave_granularity = CXL_DECODER_MIN_GRANULARITY;
+
+	target_map[0] = 1;
+
+	ret = cxl_decoder_add(cxld, target_map);
+	if (ret) {
+		put_device(&cxld->dev);
+		goto out;
+	}
+
+	ret = cxl_decoder_autoremove(&cxlv_device->host_bridge->dev, cxld);
+	if (ret)
+		goto out;
+
+	return 0;
+
+free_name:
+	kfree(res->name);
+free_res:
+	kfree(res);
+out:
+	return ret;
+}
+
+int cxlv_port_init(struct cxlv_device *cxlv_device)
+{
+	int ret;
+	struct resource *cxl_res;
+	struct cxl_port *root_port, *port;
+	struct cxl_dport *dport;
+	u64 component_phy_addr;
+
+	ret = cxlv_port_create_root_port(cxlv_device);
+	if (ret)
+		return ret;;
+
+	root_port = cxlv_device->root_port;
+
+	dport = devm_cxl_add_dport(root_port, &cxlv_device->host_bridge->dev, 1, CXL_RESOURCE_NONE);
+	if (IS_ERR(dport)) {
+		pr_err("failed to add dport: %d", (int)PTR_ERR(dport));
+		return PTR_ERR(dport);
+	}
+
+	cxl_res = devm_kzalloc(&cxlv_device->host_bridge->dev, sizeof(*cxl_res), GFP_KERNEL);
+	if (!cxl_res) {
+		return -ENOMEM;
+	}
+
+	cxl_res->name = "CXL mem";
+	cxl_res->start = 0;
+	cxl_res->end = -1;
+	cxl_res->flags = IORESOURCE_MEM;
+
+	ret = devm_add_action_or_reset(&cxlv_device->host_bridge->dev, remove_cxl_resources, cxl_res);
+	if (ret)
+		return ret;
+
+	ret = cxlv_port_add_root_decoder(cxlv_device, cxl_res);
+	if (ret) {
+		return ret;
+	}
+
+	ret = add_cxl_resources(cxl_res);
+	if (ret) {
+		return ret;
+	}
+
+	device_for_each_child(&root_port->dev, cxl_res, pair_cxl_resource);
+
+	ret = devm_cxl_register_pci_bus(&root_port->dev, &cxlv_device->host_bridge->dev, cxlv_device->host_bridge->bus);
+	if (ret) {
+		pr_err("failed to register pci bus");
+		return ret;
+	}
+
+	component_phy_addr = cxlv_device->opts->memstart + CXLV_BRIDGE_REG_OFF + CXLV_BRIDGE_BAR_COMPONENT_OFF;
+	port = devm_cxl_add_port(&root_port->dev, &cxlv_device->host_bridge->dev, component_phy_addr, dport);
+	if (IS_ERR(port))
+		return PTR_ERR(port);
+
+	if (IS_ENABLED(CONFIG_CXL_PMEM)) {
+		ret = device_for_each_child(&root_port->dev, root_port,
+					   add_root_nvdimm_bridge);
+		if (ret < 0) {
+			pr_err("failed add nv bridge");
+			return ret;
+		}
+	}
+
+	return 0;
+}
-- 
2.34.1


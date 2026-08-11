Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C043CE6D
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448187; cv=none; b=b1Ii4ACbVfR0tvo/5ghHGHkSVomqZkQDV45N5wWPEGpuRJpn14ks8AViU6mFdmHcfvo+MA5scQiCxxmuPjoRYi7Xtu6Gl7EQIzQ2Fk3ELBzyVCuVOL+NUcRVmttuNHk7bSjBCMd5OybEkbWLxfM+YRZ1g7Y0MkUaNFLGGhUbXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448187; c=relaxed/simple;
	bh=REZ2lYwKAxlJEAzqtYkjfEM+oqcmVjnQJDnk5PhCr30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQ3sYBDitFvKLX0k7dvxfGT637f9Zn54i3i8BGjYexIjKUcBnr6mEJlr0JP3pKTLc7N/mFsHdpYQxfsGAJ/OLylat/G1ymsYx0J4qTHPSxAAXX8jn7tJ5/CHdMICMH5S+Pa+zxqB+mGd2T2IsCVLb1r+VmMQWbeFjDG7azqqRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J8aFc7s2; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J8aFc7s2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786448179; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yP6NHZc//sLjuDoLDwKVqjskANYdRwrQDgUgNNawOG0=;
	b=J8aFc7s2NjqfKsemnyW6Rb4gAyIAPjTrKwdfOhQpyrPNOytfHii7Dyk6LCTzAQMKkBZ5E8oM31T8nYUu04XPTh+vN+JqneLDfoKZmHV+g+2C9+VSoPYK3l4ukU3BMzGPQqL12nCXkVwtpLTSkgDyeW54SKcGUV4+5L+FrPczZ2s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8oJZ4H_1786448177;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8oJZ4H_1786448177 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 19:36:18 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH 3/8] cxl/core: Fix dport use-after-free via the einj_inject debugfs file
Date: Tue, 11 Aug 2026 19:36:03 +0800
Message-ID: <20260811113608.2815625-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260811113608.2815625-1-kanie@linux.alibaba.com>
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_debugfs_create_dport_dir() creates a debugfs directory holding an
"einj_inject" file whose i_private is the 'struct cxl_dport', but it
discards the returned dentry and registers no cleanup. The dport is freed
by free_dport() when the devres group of its host device is released,
while the debugfs nodes live until the cxl_core module is unloaded
(debugfs_remove_recursive() in cxl_core_exit()).

So after unbinding the dport's host, e.g. unbinding the host bridge port
or the ACPI0017 root, writing to

  /sys/kernel/debug/cxl/<dport_dev>/einj_inject

calls cxl_einj_inject() on freed memory and dereferences dport->rch and
dport->dport_dev.

The leaked directory is also named after the dport device, so re-adding the
same dport (bind after unbind) hits an existing name, debugfs creation
fails, and error injection stays broken for that dport for the rest of the
module's lifetime.

Save the dentry and drop the whole directory via a devm action on the same
host device. The action is registered inside the dport devres group and
after free_dport(), so it runs before the dport is freed. Propagate the
failure to __devm_cxl_add_dport() rather than continuing with a dport that
has a dangling debugfs node.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/port.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f4035..76bda54ed986 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -813,13 +813,18 @@ static int cxl_einj_inject(void *data, u64 type)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
 			 "0x%llx\n");
 
-static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
+static void remove_debugfs(void *dentry)
+{
+	debugfs_remove_recursive(dentry);
+}
+
+static int cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 {
 	struct cxl_port *parent = parent_port_of(dport->port);
 	struct dentry *dir;
 
 	if (!einj_cxl_is_initialized())
-		return;
+		return 0;
 
 	/*
 	 * Protocol error injection is only available for CXL 2.0+ root ports
@@ -827,12 +832,15 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 	 */
 	if (!dport->rch &&
 	    !(dev_is_pci(dport->dport_dev) && parent && is_cxl_root(parent)))
-		return;
+		return 0;
 
 	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
 
 	debugfs_create_file("einj_inject", 0200, dir, dport,
 			    &cxl_einj_inject_fops);
+
+	return devm_add_action_or_reset(dport_to_host(dport), remove_debugfs,
+					dir);
 }
 
 static int cxl_port_add(struct cxl_port *port,
@@ -1240,7 +1248,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (dev_is_pci(dport_dev))
 		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
 
-	cxl_debugfs_create_dport_dir(dport);
+	rc = cxl_debugfs_create_dport_dir(dport);
+	if (rc)
+		return ERR_PTR(rc);
 
 	if (!dport->rch)
 		devm_cxl_dport_ras_setup(dport);
-- 
2.43.7


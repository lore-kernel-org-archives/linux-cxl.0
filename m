Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29292C11CA
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388340; cv=none; b=gdU5yTWjjPRyUyIJPUBZpDRmPU/XKQiJrjNVU8+eVQ3WJSVU9H9C454YJm22y9Jslyx0xc9gQx/hwdqdRbcNpes5TjDGvkLnjQLJ1OHDkX7TUtmVpMPfnKova8SEPkSK+G6le8bGKCm2kbo34rLdktBpPVtzhKR1osuv3g6oHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388340; c=relaxed/simple;
	bh=U5TFJ9tCQeTl3AT+UBa40vjHEcCEGJ48f3dQ/PSKDXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSq9Bh3h/9ys/MWpJXovlI2zQzjpDaB0DMJzm+c1PhPMIPtyc2cSuEhxm+INbS2rAx+SjRRX9kJXV9nUs+fHQjn3hOq9ISRs5uF6bV+q5vqzdtqelpaWDyYDZTu7hfWURXigI4N4de0chUKfXnmOoFRq3vC+Hen3Rh6xCHHZ4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Mu/Aypz8; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Mu/Aypz8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789388328; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1XzOyZSnDu8f0xU2VzS4OOU4BZKnEsPvU5nTVXZYoBM=;
	b=Mu/Aypz8r8c0o9v4qNP8YIPdW2/Wi8dUJvjtUENP1mu60F+iCJctaEtn4+Sxach52akasghSi1ub0wKoDvB7L5uUyULblK0Qju9lWhWceGpejhdvEUQz1b+87kRzXWSyyLvPpC6NV4cMM7BsTb8R9pRz6HVKiuvQ9wok7Ldr7Ys=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XAwT2Kn_1789388327;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XAwT2Kn_1789388327 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 20:18:48 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4] cxl/core: Fix dport use-after-free via the einj_inject debugfs file
Date: Mon, 14 Sep 2026 20:18:43 +0800
Message-ID: <20260914121843.718493-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-dport einj_inject debugfs file retains a pointer to the
'struct cxl_dport', but its lifetime is not tied to the dport. Unbinding
the dport host frees the dport and leaves einj_inject behind, so writing
the file dereferences freed memory.

The stale directory also prevents recreation on rebind.

Remove the per-dport debugfs directory when the dport host is released.

Found by code inspection, then reproduced on a QEMU CXL topology with
KASAN (the einj_cxl_is_initialized() guard had to be forced open, as
QEMU emits no EINJ table). Unpatched, writing the leftover file after
unbind gives a KASAN slab-use-after-free report in cxl_einj_inject(),
and rebind hits "already exists in 'cxl'". Patched, the directory goes
away with the dport and rebind recreates a working einj_inject.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
v3: https://lore.kernel.org/linux-cxl/20260828074752.3336779-1-kanie@linux.alibaba.com/

v3->v4:
- move the devm_add_action_or_reset() call next to the directory creation
  (Jonathan Cameron)
- drop the KASAN stack from the commit message (Alison Schofield)
- rebase onto master (v7.3-rc2), per Dave's request for patches against
  Linus's tags rather than cxl/next

 drivers/cxl/core/port.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..82513b46f634 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -814,6 +814,11 @@ static int cxl_einj_inject(void *data, u64 type)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
 			 "0x%llx\n");
 
+static void remove_debugfs(void *dentry)
+{
+	debugfs_remove_recursive(dentry);
+}
+
 static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 {
 	struct cxl_port *parent = parent_port_of(dport->port);
@@ -832,6 +837,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 
 	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
 
+	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
+
 	debugfs_create_file("einj_inject", 0200, dir, dport,
 			    &cxl_einj_inject_fops);
 }

base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.43.7


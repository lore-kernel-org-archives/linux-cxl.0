Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580A426696;
	Thu,  9 Jul 2026 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614491; cv=none; b=bycjUJHxpf9+Cld11DJEBznxQ+KH+scgZYOfesZgIdNOkf34sxuc0RcA2uFZOYrJ87j/tT/kBID+rGlvIyoB+DreWoHLngomsMLcmjBXlzKJ6BDE7FlSR5ONofyJ0zSBqC+fkI9iyQp1Zg2dWXVriVK2CAjRKAJqwxbTzthXtps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614491; c=relaxed/simple;
	bh=+EagzDCC+/tQ5DXS2t9l0lamK9cl+N/5MX49+isGQNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4ne8n9QVtYfMMT3ohzj7VNNwyDCammDWeSzbAZVoMAp5efznFUAUIE+ojAn6NHDokeu4cEef6/PFO7RfVlNPeN6xV57LaBWqjPpxUrQejDKeKwHFdOim9ovgQwxHodkImQVeIK/1Tkrc5Q09+O6XRBtfdlic8VUYrmP9SvWJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43FB1F00A3A;
	Thu,  9 Jul 2026 16:28:09 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com
Subject: [PATCH 1/4] ACPI: APEI: GHES: Use spin_lock_irqsave() for CXL CPER work locks
Date: Thu,  9 Jul 2026 09:28:04 -0700
Message-ID: <20260709162807.1957783-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709162807.1957783-1-dave.jiang@intel.com>
References: <20260709162807.1957783-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_cper_post_event() and cxl_cper_post_prot_err() acquire
cxl_cper_work_lock and cxl_cper_prot_err_work_lock with
spin_lock_irqsave(). These producers run from ghes_do_proc() in hard IRQ
context (the GHES IRQ handler) and, for SEA/NMI notifications, from NMI
context.

The register/unregister helpers take the same two locks with a plain
spin_lock() from process context (cxl_ras_init()/cxl_ras_exit() at module
load and unload). If a GHES error interrupt is delivered to a CPU that is
holding one of these locks via the plain spin_lock(), the interrupt
handler's spin_lock_irqsave() on the same lock spins forever against a
lock the interrupted thread can no longer release.

Take these locks with spin_lock_irqsave() on the register/unregister
paths as well.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/apei/ghes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..9b6917698ed2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -783,7 +783,7 @@ int cxl_cper_register_prot_err_work(struct work_struct *work)
 	if (cxl_cper_prot_err_work)
 		return -EINVAL;
 
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 	cxl_cper_prot_err_work = work;
 	return 0;
 }
@@ -794,7 +794,7 @@ int cxl_cper_unregister_prot_err_work(struct work_struct *work)
 	if (cxl_cper_prot_err_work != work)
 		return -EINVAL;
 
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 	cxl_cper_prot_err_work = NULL;
 	return 0;
 }
@@ -852,7 +852,7 @@ int cxl_cper_register_work(struct work_struct *work)
 	if (cxl_cper_work)
 		return -EINVAL;
 
-	guard(spinlock)(&cxl_cper_work_lock);
+	guard(spinlock_irqsave)(&cxl_cper_work_lock);
 	cxl_cper_work = work;
 	return 0;
 }
@@ -863,7 +863,7 @@ int cxl_cper_unregister_work(struct work_struct *work)
 	if (cxl_cper_work != work)
 		return -EINVAL;
 
-	guard(spinlock)(&cxl_cper_work_lock);
+	guard(spinlock_irqsave)(&cxl_cper_work_lock);
 	cxl_cper_work = NULL;
 	return 0;
 }
-- 
2.54.0


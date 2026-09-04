Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E0514761;
	Fri,  4 Sep 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542641; cv=none; b=hTam28GxugDYMmP6VeHxpO4N+gFAioNrEXXnMLmzwRc52lteGtuKYs5jnRkEe6gsoB1SISPK/nI77Bmxv6oFpohCWMBDKz5HqC5AAQBg075WDkYUAaHP6DdZgI37q2EWoeRDltPF2gtoIny5z0CviqFcAr513Mt3305G7aIsafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542641; c=relaxed/simple;
	bh=GrsHlLGEFefUtFV2OZJUmo5rQF6/DJ77zZOtzgEaQqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OluWuUQ2K55QtOgadV9jpnB20hsGc4i+wiUck1jrvPxCyzDZTMYzQHCuvNMIFB5Z4Viw21X+hGr5BhR6R4qoKSACzW3FWGWOrgyIcGt7D58PsxWs8YwKjAPBJ5OLYDG49e3qoi6A/sbo2WoSly8RTTmSK1MyssQS6u9ul4iS0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1810C1F00AC4;
	Fri,  4 Sep 2026 17:23:58 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	terry.bowman@amd.com,
	benjamin.cheatham@amd.com,
	alison.schofield@intel.com
Subject: [PATCH v6 13/13] cxl/ras: Make cxl_cper_handle_prot_err() static
Date: Fri,  4 Sep 2026 10:23:37 -0700
Message-ID: <20260904172337.1409775-14-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904172337.1409775-1-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extlog caller went away when extlog switched to
cxl_cper_post_prot_err(), leaving cxl_cper_prot_err_work_fn() in the same
file as the only caller.

Drop the export and the declaration in <cxl/event.h>, and make it static.

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/ras.c | 3 +--
 include/cxl/event.h    | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index e307361bb39e..c91db125a971 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -77,7 +77,7 @@ static int match_memdev_by_parent(struct device *dev, const void *uport)
 	return 0;
 }
 
-void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
+static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 {
 	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
 				       data->prot_err.agent_addr.function);
@@ -118,7 +118,6 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 	else
 		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
 }
-EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
 
 static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 {
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 5779e35310c7..a9f5c2381cc9 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -331,6 +331,4 @@ cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
 }
 #endif
 
-void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *wd);
-
 #endif /* _LINUX_CXL_EVENT_H */
-- 
2.54.0


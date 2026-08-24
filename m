Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D365356A0D;
	Mon, 24 Aug 2026 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593798; cv=none; b=CLw/sBC/rDLHzL0ZABu9adEJkpDBG6nBEkq3Y+G4cSYCwGeapg73rlLgY+8pu5f/fVRWQNr6NeBJDD6lfmrdtrDPk+yFlKVihPHPxpwTVtHVSe8hpXw++mPuXINS1+RY4EhJ14bMaHhNacUY/sRrOXDE5U3Es3MNed2OO20JjCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593798; c=relaxed/simple;
	bh=HfCfOb4+ZDNrb4TCgpliFhl/RkWORzV9YmET+/pvASQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rj8U3hDq4Jrlz+Lxle356UtNyhUTIwHWIhYUdwL5v8ovbhQUTy69aULGjm8KwuktCmAml7Ntf/OwzQVED6WSJBUmbB/o4/Kmwu96SziWHzHBBh6Zj54HDC5QFU6cZSVrCUXBL5SeV1W+2vePr6KrAB+5Im7C+9xD5B1sCec1SbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A381F000E9;
	Mon, 24 Aug 2026 17:49:56 +0000 (UTC)
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
Subject: [PATCH v4 13/13] cxl/ras: Make cxl_cper_handle_prot_err() static
Date: Mon, 24 Aug 2026 10:49:36 -0700
Message-ID: <20260824174936.939059-14-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824174936.939059-1-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
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

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- New patch. The extlog lock inversion fix earlier in the series removes the
  last external caller, leaving the export and the <cxl/event.h> declaration
  dead.
---
 drivers/cxl/core/ras.c | 3 +--
 include/cxl/event.h    | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 99fb00949c2f..eceb33bc534b 100644
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
index 912305bee3bc..894eccbe5cbe 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -340,6 +340,4 @@ cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
 }
 #endif
 
-void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *wd);
-
 #endif /* _LINUX_CXL_EVENT_H */
-- 
2.54.0


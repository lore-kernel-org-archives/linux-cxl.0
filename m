Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571E3A1687
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673051; cv=none; b=JkQ/xnbdRaUHAgHQtq9yQDdDHDq7JTl3VU0tYbTuebpycx5XLtKrmn3+7CGCxfcqZbc1UXtxbhhDK7Xwf5wtC6jelrT0K1oWcytAMAU+cm6NmynYhxdl1UVGiBr7tR+uAsAR6wP16ROEFvz13qqroGVM1ctbq4qO7nltcrvqGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673051; c=relaxed/simple;
	bh=wTrXCdV8AzwxSn8/wumycYvIi/3KBkGCkcB7oOa/3gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9hA5vHwaFeDiHZfK1z2QF+Z0Vm2IuIhrfdTLzRZowwzX9atfdyBXcqBExOhk1LNAl5Ah8W8TS3r0UD4ctEl37qy0J4HUUxYc7lBAmrw/2rpFsovflXvpZMkECA6i76l4LTlk2KVIUiO3APfkorDFLJwQQ0znE2ZgH0EEuhagWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG6LnH6G; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG6LnH6G"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc147d86bebso341555a12.0
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791673048; x=1792277848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdsV85v5vqXCLh3/0lUrvTrzvLjiTUom72JURhklJHg=;
        b=iG6LnH6GGHlTwIreBjm7i+M7UE0sA6HT14m8/obHjuPOyq6lj+uXFIUC1NDkOxQaPK
         kQfw0Pi3I9J3X8Kt8tQQjBrq/JKZsKd0wD9kmYCPUJ7+H/vlbBBftsCHIj0S8XpQkZPj
         H1D8CBoJFBaE7r9087V5tZ3NtRE0z1tYAI2QVpTC8A3443Eu+eco06wb+6kAoWUC86j5
         V2GcQrabXUGj+0e4tp5ys/jriWG+3kVURtTCc5fDfTWmz0pMIaQmMuwSUITyX+YLLPsG
         xRSBuZhDc3L0H+ivXqwxoxnUXVyiC79xZ5iqiNPFSfy9gzbNEU5Ja82D0c8BMiNRkPx+
         gPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673048; x=1792277848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qdsV85v5vqXCLh3/0lUrvTrzvLjiTUom72JURhklJHg=;
        b=IsgpbdFsJbjWvDwI/NPr1n/ngBsymsZvomEfy84/n/vFEbkJ83NDAcsHC83m8qIgZw
         9SqX3O7tOrdXmvaLgsj8gJvGSx+Y4K+XAKE9n7jttYxkaP8JnelAV1uz/ZtsvV/yJqGS
         ngSIjD72j16MiRGkHttPqMkrSoI04NUHb46yoQ05gj7upj2OP/3ziYuqXC3sVrePj3Xv
         dhrlSlxDkd6vkJyaC90Jv2rBnKXNzgkNExyBGhbqHZ5owXeShFCMGL9rSbsEVXnT4j7k
         Ogtl9pb9c2CkO6Mg4AmPD56S3xfANHczKjelQmtdPC7pQmr4f37HNMymZzY3ozwiC0S4
         B1bA==
X-Gm-Message-State: AFq9FYLei5EHB0IzudMbCb8sYeTlZ2Zyv19x5i71b6/8PpsxNX7U0wHN
	R6MyiJB0xtwXgEJMsrQdUodflpcFGzlYpro+Jczx+pMOFbd8lICzH8YwioK2ntcZ
X-Gm-Gg: AYBFou1NT7bHh4U0e4QSWYoNtZYTwJQmPlg5cLl0smI5cKzxMWT0R31MhYRvMko7VDu
	ReOUpQjXvt4u02ZxIwgZpcFpvfxcbqtH/D/Cn2zZk+3DcXyuDDLnWIwSt1ysOac8hF1d49orqDc
	NQcE7bdkzwWZxd5kQ9CxFF7lcD/6GwY/PQ75xkWkqZrZ6QsB1dRs2aLmTQjMBVrh9II430aAjSN
	eDF63/pn5L1OcEE5yAJhHCZ8jDm2hkwIDLh2wnIK+CFGtwNhGPI2QlmeshDK+WmRUcC2gyHZxu5
	fKsdi2LS2ovLxHD1WRlLsMepovj+oioeGxfz6IyVA52f5+vu0Fwb1mPTDq1wT3ETDk0yJDcpaC9
	xLR2tdT68pCW72i9ynL8nlNkjiWO6uXGDxkfFFNQcpe7qQr3G7xg1ZPGvmpvj1Bbj/2zy+A1HWs
	YmLOGKAG6Ifh74jU8N6moQHfiKMm/Z4C5VqTvNKVcjlgC7XMyQrfS6qFCBG1UfKjW3PTdiG+Anz
	fFdxzrC0OWSXpKo6JoHCvMK7g2ba4ozfo/S+g4=
X-Received: by 2002:a17:90b:48cb:b0:3a4:cf85:aef with SMTP id 98e67ed59e1d1-3ab36d637b6mr4475092a91.25.1791673048079;
        Sat, 10 Oct 2026 15:57:28 -0700 (PDT)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e07329sm2603662a12.5.2026.10.10.15.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:57:26 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v16 5/8] cxl/pci: Factor out interrupt policy check
Date: Sun, 11 Oct 2026 07:54:56 +0900
Message-ID: <20261010225852.10727-6-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010225852.10727-1-anisa.su@samsung.com>
References: <20261010225852.10727-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Dynamic Capacity Devices (DCD) require event interrupts to process
memory addition or removal.  BIOS may have control over non-DCD event
processing.  DCD interrupt configuration needs to be separate from
memory event interrupt configuration.

Factor out check for firmware ownership of memory event logs.

Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Suggested-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/pci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4867657f5526..7b754af2168d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -640,6 +640,14 @@ static bool cxl_event_int_is_fw(u8 setting)
 	return mode == CXL_INT_FW;
 }
 
+static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy)
+{
+	return cxl_event_int_is_fw(policy->info_settings) ||
+	       cxl_event_int_is_fw(policy->warn_settings) ||
+	       cxl_event_int_is_fw(policy->failure_settings) ||
+	       cxl_event_int_is_fw(policy->fatal_settings);
+}
+
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
@@ -662,10 +670,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	if (cxl_event_int_is_fw(policy.info_settings) ||
-	    cxl_event_int_is_fw(policy.warn_settings) ||
-	    cxl_event_int_is_fw(policy.failure_settings) ||
-	    cxl_event_int_is_fw(policy.fatal_settings)) {
+	if (cxl_event_fw_owns_mem_logs(&policy)) {
 		dev_err(mds->cxlds.dev,
 			"FW still in control of Event Logs despite _OSC settings\n");
 		return -EBUSY;
-- 
2.43.0


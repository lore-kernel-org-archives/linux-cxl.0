Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA243DDAE0
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862940; cv=none; b=rTfESDJK2/Fd+1yU8b5veyKcXllnWQ/Db0JznRwLfPDfVskrPeaYfbdkr9InIwV5tAbrqaZ19pXQ71u1Y3uSjij3CLrPa/kIHsyhaHhkCUGZX2q0KQqo/A3VuXndm7zKeYISrwP9fU6olzc/zjeqj+otu8DDxEx23olqdQnxrsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862940; c=relaxed/simple;
	bh=BuWEdVeSSAQHQo1VA4CAxRp6Nr+e+KmYuvci5ttXZKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goq+fdvm//UqggSHTwCrcGDC7A5Wq5MB2zg6gsruBG/JB3nxrlo5iyRmAwLNwP3NohU/1W1fe9amZ0jQMZbB1QVtpVq8MBzO+Ctc8ZpsncvBYzYTphQ1/qlSGZmCvZaDv/LEADpIxka+u2Gz37jYX3eCIRmMxyVNQzT2gDQPsx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqQYi/Y5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqQYi/Y5"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4593897a91.2
        for <linux-cxl@vger.kernel.org>; Tue, 08 Sep 2026 03:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788862938; x=1789467738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qSkz88HbbWlkxKLy9yA/+AKhV9OXLe4CoScPerkUEv0=;
        b=HqQYi/Y5LtKpvOg793B+RJI613+VB1BJ/jZuhrjS7W/r1Qyssz0jnP3/+6J0KH1L3B
         rbRvDPuKzXvEj88OG4FjucYMZT1jT2iFIiA0qLLPXwvSHENuCpA7RMuKRiOOK80g5/Ft
         Fb6Gl4LxBuiWD/kOIy0cQ2/uVYDMbcsu+mgnLrPmGl8TMsKD7C0RRWNwkxEhZw7hLLF1
         uir3R2wMUa1wjpamkVq1h84cRI3VyJjOa9z7xFR6mE5iWyv1MbnMcW96FrkZSthNMG/C
         D7NP9vXyZCToNrhhmxB087dnXm7rrCaGN28kT5yGRmnQuyQv7cFWoxpO2SocMZtWC6ng
         mN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862938; x=1789467738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qSkz88HbbWlkxKLy9yA/+AKhV9OXLe4CoScPerkUEv0=;
        b=lyoT6N/cNyji7Ffx2Ap6C4/heu24wUuRs/GeECrrtgY0vsC+PxCojyMPZxUIbGbP4H
         LjugvmaQI9pxliZkEtQfiw9uwJ78mkAKb5heoqKkjlIlGqfAjkRSO6CtP2kWlruoYe3G
         hKrXX9CvFdFMXg3fN8Agn5CULsxRpjokOpYtyyLyasb1+itBWgDGgTPN/hK+awCFv51D
         1CN/hGUE7wwVvPHas68WQhP6jEti7qx+Nu5/b+2hZ0pIISMEF36YwbpV9nij6zvVrtw2
         pnl99XCRJv0wQ+M/qWHh+kgMpoUYTDlM8AIRIe37fGUDg2yrjhEglPszsW86NbPUmvB6
         oXjg==
X-Gm-Message-State: AFuF++nuBJ5OloHKY+KZI0yTPihf3e3buCHgdfUvKDmmYpctOi8mkcvx
	fVTclgLO9xI/WjfkOy1J6ex0Xy7ylwxi0kY6pkusRfy1pAcaL7E/E5ETHyw+0g==
X-Gm-Gg: AYBFou1g5SHCvrDTDdUa+gNTSEZl3XB4AjjCmDt01kEDMi5Loaqxc3UwPbueBnjU83Y
	TixvrIj/7e33Mz8npsWM0+32wtl7POlq3y6LMx7UUUWX/+2ZIJE3PIvP82jwe2mNxdMWQ8oJZ9R
	ERM37cmDVxTBwnIrqZ3YwKXXH3I7Zypn2aM4jE2syzR2HDWUXilEFlHOvci2VqjXHPtZs1UDiIf
	zdP3mMAqoGRrrSOpdSoPzsflI1IFJugJhI5W9MRIogmwpq1vBnV8txNycg6z+DiKO/NbMsxOMZd
	sEyUGOwMEuEVqKbSkToexKe3+Hzk6X5B0N7HVCLrqqxSv+xMxfxky28Rd8AUaOh4EmfhvFqJrYg
	Lvc/prd6n7V0uEyJlrxtTpBC06HWUa39c4QIYjiFb6zudMdmHo58SovdWj9RBuL00Fn6G4456AU
	8StZxfKUw3S+pqBMjSXuGOM4LFkufvFKTZ2GX5FbFLiAMvcvYGc4Fe3TIkVxj1/kEP02Ga3Hmid
	YiBlMFH7bkBkZ0F09dWNfVoniovOUn+mCzhrBqiIajdSgWKfErTjVrFDi3hd5r1pIcOXbcZzMeZ
X-Received: by 2002:a17:90b:2b4e:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39b261d0d8emr43661754a91.15.1788862938187;
        Tue, 08 Sep 2026 03:22:18 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3396e7e477csm3435658eec.29.2026.09.08.03.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:22:17 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	jic23@kernel.org,
	dave.jiang@intel.com,
	gourry@gourry.net,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	vishal.l.verma@intel.com,
	dave@stgolabs.net,
	benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>,
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>,
	Fan Ni <nifan.cxl@gmail.com>
Subject: [RESEND PATCH v13 4/8] cxl/events: Split event msgnum configuration from irq setup
Date: Tue,  8 Sep 2026 03:15:08 -0700
Message-ID: <20260908102124.2231730-6-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908102124.2231730-2-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
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

Split cxl_event_config_msgnums() from irq setup in preparation for
separate DCD interrupts configuration.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/pci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2fe9db4b3d86..4867657f5526 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -600,35 +600,31 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 	return cxl_event_get_int_policy(mds, policy);
 }
 
-static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
+static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
+			      struct cxl_event_interrupt_policy *policy)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct cxl_event_interrupt_policy policy;
 	int rc;
 
-	rc = cxl_event_config_msgnums(mds, &policy);
-	if (rc)
-		return rc;
-
-	rc = cxl_event_req_irq(cxlds, policy.info_settings);
+	rc = cxl_event_req_irq(cxlds, policy->info_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
+	rc = cxl_event_req_irq(cxlds, policy->warn_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
+	rc = cxl_event_req_irq(cxlds, policy->failure_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
+	rc = cxl_event_req_irq(cxlds, policy->fatal_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
 		return rc;
@@ -675,11 +671,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 		return -EBUSY;
 	}
 
+	rc = cxl_event_config_msgnums(mds, &policy);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_alloc_event_buf(mds);
 	if (rc)
 		return rc;
 
-	rc = cxl_event_irqsetup(mds);
+	rc = cxl_event_irqsetup(mds, &policy);
 	if (rc)
 		return rc;
 
-- 
2.43.0


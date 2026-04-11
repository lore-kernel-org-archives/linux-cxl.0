Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA4255F52
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871639; cv=none; b=iu0iwlnBtvqJOpHrew0lC6nPawXer0+pBq/3GVyW7r/+9/vKS9xb9tGy+ji2UsAxWY4gHfEAz2TzNM9Aau63PkEAJwRvPH4zuPOjGlnGbEPJMB4FrtiXODFdaPq455GKE1o+0a6OYE9jszBrBO5dqpWUpOQ3c+IWhcx/htEGipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871639; c=relaxed/simple;
	bh=TRNy5M/WN3qqAniDdN+oE2OFskxJxYDlCStFug8uZT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CH12DTxJ0ce4JtVOfxo4Vu+sxX9z2aAI2osCF4mc/uYDq//wKiueVK47VaYYW3L6tPaneSAjaXEjFv8+RGFw00tk4qrF4xEis3iggk+t/WJ4BtQbD7q/Wu2RmpwPDWp5M8B5lpsJJqyFykYynJGs+s0n4CvHoMhHl1xMBi/Kmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kacXqCml; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kacXqCml"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79c20063a32so29253427b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871637; x=1776476437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6d+nwILJMu/HApS7ffo+r9TZ58+uVhFX0f64Cee/yY=;
        b=kacXqCml+NfyrAi/wCzTLz4Y4jWbE2CnCQn6BuZdYYcebq74/fnHohPob+IT/aTRnH
         2kEW1AzcY9GIfQNxEHGDnQxCiL5wPS9w+riiLC0ERlYwoPIxJetic5F0p3raectNLoZH
         z+TPLaoeh1ikJI2VYcVX8grQXYRTORdpL0dmcqBGGlxj63k8UgvJduQSj86wfun4BPLM
         EemOw9jDOwytb8OhQzvoVHrsi2eYriuxZTHXdBYSkC1Hzbkxc4JBgRzihhj2nVaywnLo
         Ly5JlxzD5hYAfSUp8cGzmMeRPpPLin5NDDfBdtHDBgimuyIU5kckEZA2ZiLDGIAy44Hz
         5tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871637; x=1776476437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s6d+nwILJMu/HApS7ffo+r9TZ58+uVhFX0f64Cee/yY=;
        b=sY6TN1TzBxPZgc5QzdxktUTZfECyi4sMEOB79rkGioUINbnnlO+NKQAjy+N9vXCH6f
         yzyH5SlCqhUkjuXoAc2mPF9D/2Ql8zw2DU2YZ58sxZYiw/idLBELvQTl4EGxaW7yFBhi
         HSJ/iPbWO5Hi5PQnjlK7LrVn4LbudBKvNULBvIfiYTAdeJllMqrvLlDSejsbO+Ig93un
         K1mYpBBvkoKa2kgwYrBMlGeh4oowHLFeOMO+BTlyg2ELhiCyoHz1MrunV1MJ7M4224RX
         jvitZ51joM2cjlFeyxPPBBJU2jEMsUsW6QcfkVenjFzRNe1RmnPSMhZ0WdKTx6pn8NHI
         RZFg==
X-Gm-Message-State: AOJu0YwCRHlQvry5RIesbmzELcN9d2bdBYapNNK47LhGElm4aJYPL+XJ
	7/hqQlsTOFA6aVvbh6GY1MgMSbVmRVcQZJwdEJu3jSFKdkm1pexv/xyX7lu1eQ==
X-Gm-Gg: AeBDietC9rEXTVveadaxvhoRo3DTVholyDqrdCLXoBSmAKNpWu9e795YPPyalQBe/qs
	IubDgei2jVkJonzSxk9ymcBC8xNfiNWVSQMm7z9AzWnLIV3Bhce7yAmhCAcc59z+3H1UIgatlGn
	EireZUbZ+LkFEHOneOL6NQap4unLSFjPirA4ayEouObu7agjOcVNDsOtmmexFpsZsS/shH/Pg0W
	YUPXDjmbueayV3wNLYEbc9xwLOEVNhFKAJTPqSPIvP1V1kwWYNVLGZMFQR6WL/nZ5iF/r3tZfIz
	ihn4MT0Niivu39MX1k+k2edMPp8RZXhXWGw96Fc9upREA01YVQAlZHgpe2kGeiLm9iJtwz6ZKRd
	ke4pvc7oidoGJ7RWiuHlMF98nBwbtiFOJ3aNFA5nDX5KDFANWaJPTaOvWn1YVwfiCoubCSImwg8
	H8BSqZKf4+Y+bmD6QmGQFC/J3ZC/yOl0hxy7a2szUZzA==
X-Received: by 2002:a05:690c:34c9:b0:7a2:bda8:21f7 with SMTP id 00721157ae682-7af76de9408mr45046387b3.2.1775871637490;
        Fri, 10 Apr 2026 18:40:37 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:37 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 08/20] cxl/events: Split event msgnum configuration from irq setup
Date: Fri, 10 Apr 2026 18:23:03 -0700
Message-ID: <20260411013958.47422-9-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

Dynamic Capacity Devices (DCD) require event interrupts to process
memory addition or removal.  BIOS may have control over non-DCD event
processing.  DCD interrupt configuration needs to be separate from
memory event interrupt configuration.

Split cxl_event_config_msgnums() from irq setup in preparation for
separate DCD interrupts configuration.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
---
 drivers/cxl/pci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 60f9fa05d9ef..35942b2ace53 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -599,35 +599,31 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
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
@@ -674,11 +670,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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


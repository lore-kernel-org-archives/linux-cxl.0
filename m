Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632193D7D88
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487797; cv=none; b=DPcVn1sTGUjW1Ads1AG9YelTfYJmUA1ibvnyjL3z+kkowK3pw6kUs4ffwuGL7vb2ASZU+Z7Zaiob0Jm6KWboLx9KCwvJQDkLx94sNznmNH/LN3/5ZQU4wexAuD5FpXgDd/n2kML/5Jo+An0tnY62Mj7wf2C7vYCrz4eVBNZlvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487797; c=relaxed/simple;
	bh=R+n9YLqadG6TAOwmEwxUSZn7a9bCX/tKzpwXMlqPam0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFYbyaolJSiAWED/H7o4SQeu3AlqeLLYkdYl25BMAa/XSUkiS2va3iPhG23+zFpIj2vMObeD4k/xp2JtJYaD/nvKox38v20ZuLf+2Nh9Ci63TtYsgYKhDyRcSliu9rb4U9s5VqJbNvO6Xx6bgwCoMjWU9vm1LZdAkB4QhzCP54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfJnm5XS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfJnm5XS"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacf197759so9938555ad.2
        for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785487793; x=1786092593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzK1wNsapURaE+L5SdIvNiyOu/fP48evIRM0DvEwwV0=;
        b=SfJnm5XSKeOH/i1XRy5iFjbHsz4WVc0ejrqthahr5GaAEyNFbpXgFto0PGibg/zKJ8
         2Wmwa/ma5eD7esnSz6RHCRqq80yQeElcFwXk8tX5dy67hCjAKOWuAGD4MMc8QM8sAxnm
         y1xtuLzR3cDx7VLcnwEvCzFqpZIZhOclv9xVB+1KUfgnOZmHwuj8VBRF3QM38bxoeQAG
         rD8r6gbBI6Oi4eRMi5o/1c8FD9O9zpV317c7m7DIF28Bh4eoXjDgtkmiMV1d1pqW73oY
         OAsUos3mNzWt7bAPgn9YFA+UmL1wDOyLkLaeeYNPra2TdRG1Hfj61ijx0w/xpIPV7AFD
         6Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785487793; x=1786092593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzK1wNsapURaE+L5SdIvNiyOu/fP48evIRM0DvEwwV0=;
        b=RPykoNJYqWBRo+rcw78UKe5/jbwJMrWwkDYOWx1MmwU3Fmek3rLtNT2hz7CZA0fGny
         l/v54WIQxuwyg7C2cyLLORbmsflonMkXp/i769i7chzMip7MHxe7fid1/zPUuZMz0zVz
         91F98W2itxu8HwJm7QahnTtdERqjnNbUnTw10OdyP5VkKSXD3a9d1qDX3OkQCF377zuw
         GgFh0NC6SvWjKWlliV/GV59o/RvqvTYv5aZpacr4+HPYBtjZoHajPU1LZxH5z8CfQnzs
         vJl7UbFnGluvqZRcbCxV4zqIiLdzwqXNk652tYu4LIcK3HN73rteNL8Tsk1Pud3VbJqJ
         t7YQ==
X-Gm-Message-State: AOJu0Yyc3DnwA+q7BLCFVtWugALamvFg/8/mcjnCxc91L/d1s6RbsJxo
	r/xvxGtyWu2tQH22fu+1+oPOxZGE5a9pse/bsA8tytTEkiY82i2V2rp2uMD2Xg==
X-Gm-Gg: AR+sD11XUhNYhrwCHFDL5uyaaeB4iW6WdDuKBNtRqO1aFklZrWhsjviwT5Q9Qq771oA
	AXogJ3H6ggQcqjfG3YyC/8O87v6UmWSpNhSGS5cDJSAJi6yJDJv4g+F45tHx8ZmxNYrW1ALWwN1
	8ikoLqrFxgu1Vd+YQk+x5leg70g69Y24TvZFfVdDW+uMUAQMuXa3KcHbVhKpaEZkDZqeDrQK/Yb
	eeF1s3ymBFvzq75PmJCGPE/0b5uHWF/GNwWsrCgAg/YDgBu05Xtkl2CHAQkOUkJ9v6eg7gmhrAd
	lz+Gz4JYO57Oxb/Ca6nHdYLsS8UcWf+78hvLC829DyR+Ex0EoiO2GMaD5ntNtAFfXQK2bYxV1dJ
	Ibg+1EO+1SWqamvVWUECB0T0c+IeJfw5i+2Jfq2RIQQqceeq4BSmvCXlYgE0LXlh8WS5ZqjkhkN
	Jg4XbGZb62h3rpltynB2o0mrgySBlIohZBAxs0MCJahQN9LcyXIoh0lmm57OJUNApzjktzY0Sl2
	fWGFnGLLMIdk16JTEtd5lV5iwRGAGUdvHhkqhUMkm60
X-Received: by 2002:a17:902:cf43:b0:2cb:3f63:7c3e with SMTP id d9443c01a7336-2d046ee5b90mr11692545ad.35.1785487793307;
        Fri, 31 Jul 2026 01:49:53 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5abaesm2708425ad.27.2026.07.31.01.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 01:49:52 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>,
	Dan Williams <djbw@kernel.org>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v12 5/8] cxl/pci: Factor out interrupt policy check
Date: Fri, 31 Jul 2026 01:48:10 -0700
Message-ID: <20260731084901.1512819-6-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731084901.1512819-1-anisa.su@samsung.com>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
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

Factor out event interrupt setting validation.

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
---
 drivers/cxl/pci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8e122de1876b..df13fb8802c3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -639,6 +639,21 @@ static bool cxl_event_int_is_fw(u8 setting)
 	return mode == CXL_INT_FW;
 }
 
+static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
+					  struct cxl_event_interrupt_policy *policy)
+{
+	if (cxl_event_int_is_fw(policy->info_settings) ||
+	    cxl_event_int_is_fw(policy->warn_settings) ||
+	    cxl_event_int_is_fw(policy->failure_settings) ||
+	    cxl_event_int_is_fw(policy->fatal_settings)) {
+		dev_err(mds->cxlds.dev,
+			"FW still in control of Event Logs despite _OSC settings\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
@@ -661,14 +676,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	if (cxl_event_int_is_fw(policy.info_settings) ||
-	    cxl_event_int_is_fw(policy.warn_settings) ||
-	    cxl_event_int_is_fw(policy.failure_settings) ||
-	    cxl_event_int_is_fw(policy.fatal_settings)) {
-		dev_err(mds->cxlds.dev,
-			"FW still in control of Event Logs despite _OSC settings\n");
+	if (!cxl_event_validate_mem_policy(mds, &policy))
 		return -EBUSY;
-	}
 
 	rc = cxl_event_config_msgnums(mds, &policy);
 	if (rc)
-- 
2.43.0


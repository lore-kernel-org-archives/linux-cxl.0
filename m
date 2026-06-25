Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767F3CF1FF
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386903; cv=none; b=aPqVbTTpkjQokOj18R9h/xIdbBvQ+y1DwnOkc7OlUK5qLlzy7KjCg0Eo/Jl2Ojxk0DMxBSfz3NBqgh48R4oOjz4tJkZiyXBsk0RTnSiDIJP92wree7HS0MA+VENUh4oBpzJu8FcQN3Fg3ngqNoJdK6hGQrB6RhpB9rH5uGQJD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386903; c=relaxed/simple;
	bh=MH96XZs7MF5UV1+fZ2jQQiPTR+7dlAPgtIOhHTm8MGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVVo/nms81ofq6qo6TirHA5bRK2GB9/XdLkQbO87pmcoSK4k0qTWL64/CXrt4iAVOgkrKkF8Sj8w2FWL2cmF9rCglv78x5B4TyL8avdH8aj6Mng223XueoRpbKHv6t9sR2vzXX9BMfZ+5eibfvcbxSs3Y0pKKF31RVza//S31FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8Dt8mV2; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Dt8mV2"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bc871ecdfso2538444eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386901; x=1782991701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWGYp5PimR7iNvegHe/tRkVtZEJJWTBhNsd/pXJaxDQ=;
        b=j8Dt8mV2LO06ikx3WJts6wRMwQJKgLTdlTVrq0RxP+dsrMPWSugK9Hi4NdYfwMNae4
         Lr8TsC8n8qfrPsc/GOl1onPGDqqSCXkAl5JKIdGyoceQzxbyoFD4nwdcKlPV7724/TC6
         w/PgYmZzxy9fyJQ0edLWtluVl8PxuyZByYfxAIkqAn4ujoQkAxr3EAwjn3bpSK/3wFAu
         xisxFA4+dtSuRQXWMttCMi/f3YV6PokLkGSikGkPkJ8Ir++0Q+snkKJQMkYtKQxZl3EC
         Kbj4BVoJ2GnnNulbSbvbt7411kPp+IT5UhrYGqT5zJsDWpXpA8Ft0SgxJAmkNy35F9gt
         QFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386901; x=1782991701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWGYp5PimR7iNvegHe/tRkVtZEJJWTBhNsd/pXJaxDQ=;
        b=BLxFldLyYglTrJ1m9h6qDeG3IoCP/z2X/TKRm2h6nTxL2bVJ3sUN8s/Fb4LmNrF7M4
         yT+hhDSpqsZ1yinWk7l5KZhOrtG45YmwQqnd5sQGTbqQOtnXeiKDz1GpS1XTTdDiFlag
         08+MD0Jowox9L3P+S+XBdLLjKKSd0jBVXKRVtbOPPN+n6TG77Ew6W1Grbv9CTG9EJnun
         M+ODbdAwOCH/QksRRHQp/G2PweuNjcDdb1IHmR3qOlyE8QevXI/LGJ/JKpMw24AhhsVt
         xVw/WUqSl/CvZPb68pg0gW+NxlNI5S3OGuKOaPpV6F7hnEKIOtqyzL3C0rlwQow4NH7S
         Iu8w==
X-Gm-Message-State: AOJu0YzthOgD0RU+zmVLnum1q8gbHBvWYbZ9gHxtjRgBSupUec+VWe9H
	RxCXvyymSG7XIdHTxzqOMD/GhYOibm0uX0MTQkbDtIJokxfB569NMIlJh1YT+A==
X-Gm-Gg: AfdE7cnG/8DK1K8fo7sxVuzVGcWzKfretK1/uXXP7d1GKz077nF9wIn8/9AcLAUF58l
	STzoz28HXxEuvEGSWy5zl4RXS0F78wIAy+ecHy7nZrD1/nWiuMZ/A3ZwBiNUSOBTcOEgTEqWSPt
	dBrCAsO1hApH0GUCGaHhTYgjcB7dJ+h3pf1R+sT0HRIlACjceP54yEMuPzX0qBA38xEw7lgMSKg
	L6N+EPuAGzj/vspbEITK0z3FSzlbKi+EqcSGEtG60OplHwU7FFdF9ALOIvsM8VRfHZ5an9bZ3L1
	6Psu/YWkWqq2vVoZUGyJu7Zg+EwB0qfIjxx0x9KV8rAXQmAhfgwya4Gng+DO0Z8W1rhfll1E5uj
	d+MYVhVA2TITUNbZM/nyvoaaOADfOl4IXXHlbM16LEqUz095cv/MIkVKaQoI0wcJTICA0p+QP6l
	HS5oySEkjqsOwPxrvmIC6xRUA8pEJCUxHk9NLQYY3L5RMZ72Odf5HadrLhE78Hb18uHBO9
X-Received: by 2002:a05:7300:7246:b0:30c:5a5:df4f with SMTP id 5a478bee46e88-30c84eb9cf8mr2905159eec.16.1782386901207;
        Thu, 25 Jun 2026 04:28:21 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:28:20 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v11 08/31] cxl/events: Split event msgnum configuration from irq setup
Date: Thu, 25 Jun 2026 04:04:45 -0700
Message-ID: <20260625112638.550691-9-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
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
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
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


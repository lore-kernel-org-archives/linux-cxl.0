Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A942386C2C
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529436; cv=none; b=sWOyfJM3xZOTCBVjoQnbGF4nfEOtVqBSRfm0p3XhB3jrYN8gXpBRKSqxRskPzMZ0AudPv6WJwkGCDCGtu/OPtsjb5P1M3i168lprDHkiVU9yn2h7tRYxZFZh3djcKd8G2VpcgVNZAJiNVhAgQF8Todn+MXqd7B/UaIFjoxxkMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529436; c=relaxed/simple;
	bh=TRNy5M/WN3qqAniDdN+oE2OFskxJxYDlCStFug8uZT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3OzXMnGCAeW+Il39MTWR4RXwMTqvi9Suidl9NKS9sDsV9ybBRcpGtLZ3UtSTNgOg8wAvY7dXiH140LZKHOwKZ1anHSlaO38xpbS6gCMewt+7h3pzIxeOttdNV7wDFVYbSefWq+j/B4S60uxAfX07YQ4gO59TQac7xpP9AKR+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAECiOy+; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAECiOy+"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-130c9dcbd25so5271430c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529431; x=1780134231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6d+nwILJMu/HApS7ffo+r9TZ58+uVhFX0f64Cee/yY=;
        b=gAECiOy+XAOqgHZWBqzWk4XESAncrOn4/i34Rz8ZrOzP1iRUEWCamu59isinTPfBER
         eH3NU+Xw6xjdSs66dRurNrgEV8POIIsr4UTlGcDH6AHKDIWgf5ij7msqvEIkgPMnGuFk
         kOusT04r/iu1/U5yi9maHMT+bl7oG6c5zN2nzpK69ZT8ftfy/8Oz4m9FrGRXi1fIjoQy
         O12HJwscEliabKujnJlF7YRKivMDA+PBGnsGldvvVdc4hp4GoZHmB2hn7VK3WQ9VM+0/
         T5r8+evrjj2jFA6VZdrhFKt574dW3cx7JSm+35Cg0s8vBTq6QxTEJ6KOSX5hWwZl1H72
         VlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529431; x=1780134231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s6d+nwILJMu/HApS7ffo+r9TZ58+uVhFX0f64Cee/yY=;
        b=SMSIDrrO67e5UQDTGfjFaG1jDZ5QVww6ht9vHraDpp4hhvXNkVbE1qngvDHqr7I7Gw
         xOGQRSHnXgDZouhZfZG5BjBfL5zamDpHyj8aJEcgNzSZ7cOb575b2tVsCRcePudPUJ4F
         JpK00l1/5yqRAvVrihGxmoM0wBcVStJfMernaF5h+7kIl3grgSsNeYeaQT9JJdX4eWtb
         7pD5DRPs4F+aQH6+6IUcy5OfqHsirxYhbOj2JRXcThGRE/yGnmP+B2SYxJ2UP4Y/JvCc
         rhecw3CIT0nQuzKyZe97hO5Wkr1E3hCWnueHlgI8RsbnXOrLNIRp47Ir6M8sujycFI+U
         c9xw==
X-Gm-Message-State: AOJu0YztOGblirza/20zow7x/QZoP+mJNd2Ie8FPKHt2Gx5RW681Yg/w
	LBjzbZIkSutp62aCjlxY/A+U8UxNVT9iAUau0JqXBxc9F3TH6ayLhgTx5qZDtg==
X-Gm-Gg: Acq92OFYPSay/p21l3MxbIR4c9vy9zVIHDux11FLyBhmg7XxJ7gjPytJzlZ26y5bFeq
	UiNspj7b3JTsdN9KAQEykYdbH358JZvYkyYaTmEvRfxOxkHLe7B93aDlRNSOrEm2YlcQGpIF7Sv
	qicqTGjsgzSGNmUbCjbn4NWHYt0qWXh6iu81+jWErooFpfCX/wpKInWPsA+lPIXNR4weX9nD8TC
	AXq0FNjoROcRsm2EvrRGZoyIVGLm0qpPGYcpBzD+t8OfmLIXv98/TpFQvgENkGIhxeqtJZmpAyE
	QhJCOktm/ABgVZehUdkuvI0tlGb4W1e10uI2jjEWFLY0WtU9U9+UdAEQ8wuCVKDXyEYVpy/e1R7
	ip+XlsMprzENROPN9FfvDOMXQ1jsNbY/Rjn6y1bujF6b4+3jDov437Ty3fyv/LdQ75yFBPMYi3E
	tEx2rWIwm/2sDUL4KnjC+XtMEIziB8R91LPq/Nd9JHqSI0zrTZ3pxg2tu3qS8Q02eVkeEU1fx17
	nxTf7w=
X-Received: by 2002:a05:7022:f91:b0:129:1d25:f1da with SMTP id a92af1059eb24-13633a69b63mr4019288c88.3.1779529431282;
        Sat, 23 May 2026 02:43:51 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:43:50 -0700 (PDT)
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
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v10 08/31] cxl/events: Split event msgnum configuration from irq setup
Date: Sat, 23 May 2026 02:43:02 -0700
Message-ID: <2906584012fc147ecf67578022a78415f60f73ce.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
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


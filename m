Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F45311592
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763500; cv=none; b=d/Z1nW8BuRtfdTA/G9hGK+ECcZpArnfdjEPHIe6MNBPC3K8RoNC0CJTOvNtW73GURDTgglyVwrvdgFCaPeI9vXEpH/4R4KcqwCl+UapvhVlgwLdACU/uzkF/AX4RiKEltQpXRHE77mqYlGu8XMDt5NV6owEC8CsXjJqZluYv1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763500; c=relaxed/simple;
	bh=q4D5qnCIGdBeNlMnRythH0cr+qgB83W6uU2g//EeA/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSTxo0JaPRUlpByvoyOUyYn1uR+sDckNhkodTMpJBY0LY0Sqm5Q3rHbXLJe8m8B+kpxZl0gu2sd4wbQDAuRuk98mDbShTvtbTepTMw8+s3eYBcjUNZynnuE4qZqlVbFFyRICvtjuoF0deOOkBtSppdQSNFlfANJPBfPhD2slhXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvsQxYIj; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvsQxYIj"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43da99easo10923127b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789763497; x=1790368297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c6roOfMDxi+ROOvcks5ZO05EYmUwKbuyn+ki2AKobXI=;
        b=DvsQxYIjMQIgJx7eer5GtCA+Ue6OZg4QrDXeEkfid9DR+meRBNEmTme7iK77dzZ/qj
         X9UMNsQ0H7e04S2/1TtAysmvdPaAfGFZeXJg+SljnK52RcZ/5g1Bz7Ms+NajhwOrYIz0
         uuC1L9rCyI+k5CT/U881wvXNrwbxyWa44k1RZT81kevil2zMg2Tf+MSizNpGT6jwFzYZ
         VIqn/9nvOg+K3hckFKFYTjJBTeqsLN9aTbbrefwy1WZxp/uwONR6vpELcurJ7cjH/yA0
         7KCoq2craSqNBrKy/p8PTT3lAaYPe1JrGVyesWJ57GI/xP1yAGinYLJmzIr6OslCVCP2
         Echw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763497; x=1790368297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c6roOfMDxi+ROOvcks5ZO05EYmUwKbuyn+ki2AKobXI=;
        b=OBX7XovWqf2Z64LTYyMM6amvrcEmUA9xnbiC4LjCkJ4LBEerf1ILxwmKCmdWvy1iYg
         prlXdCdkzXcsQsEM8eh5UZ36p0K+TL4odTkbhvqGPNyqeasJbmQgt3oZTMmMd4r2mqQ2
         kN4mHmXxvhOWSISNRMrMQxTwLZzvtiaoXtqJrZU2QB3eRm2/7DlHtIwLnF9UqeO2M9+p
         MBUtFAtAq91VsgOsc6eqg2yu5Qt1T8soJXK/u4WmFt5XVvnBpHBqE7J9NkJ/fUXN7/1S
         zPJhrWRwP/9zJiiM4L3Gne422aD3aPz1j1hvfQ79UHXn83VaI+V/i/izqz6dwv6WroJo
         eQKA==
X-Gm-Message-State: AFuF++nwJKPYwcp+OfOHgyDkY/dsIewZ5laysZd59xueAVMjkthrxJW2
	qY5O+0xSGCBzu6R6WDQm3Ei8S44Ke2q+SFpJh7r9TBWuq6BgMfQVdv1w+TdM9A==
X-Gm-Gg: AYBFou3Wr8dKPxkCHsUn52NjTEOWh8YsoyP00pznqphGKMzEQ6k9Dc0xv/rNKQ3cwsN
	SM8kFTUNu759qADibkFAk9FRxRItNzKaz8Rp7klOHtfkQffZY9TkhzQxlEeC7+sY2dqA6UIMsMN
	VAozChRcA3lWnsZMpRrqt20UCNyE3yjm/HA5klXgediakb53H7Hr4wSj6p9G02BBZotL+do9Lwo
	ehkzGSTlcB51H6JTpOwWRvr5wbYa6YuVMNJT+T8EadREPd6+5ffpNXIk8xoYSnjbKcWHOOVmKFz
	WotMEtJV8jFOVz2A4n3kBY0R5rF1c+iZFdR/za/CiBerQE9n3anMEbYb/0QUGU//3jVxKv67Nuk
	RYVpTq3HWXQGKRNd/UIMZbA6AA0bSKMGwFUWfNQfj1nrmJKlM+EvFPvs7I4PXZo6O7xv7/W+jIQ
	LQquLgKMhpxWU5L5NJRmZa/dCfFye+r4zxfw0Ade4sF5ZR4AYqooG789vVc0fC+9dTb40ryMHpE
	nF+4iFhJdvoMP9cprOLgkOj3aJo2BmPGJF07dXgEltfShFcrQ==
X-Received: by 2002:a05:690e:4192:b0:671:27d8:d90c with SMTP id 956f58d0204a3-6717fcb0402mr997252d50.30.1789763497249;
        Fri, 18 Sep 2026 13:31:37 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64b74sm427240d50.1.2026.09.18.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:31:36 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fan Ni <nifan.cxl@gmail.com>
Subject: [PATCH v14 5/8] cxl/pci: Factor out interrupt policy check
Date: Fri, 18 Sep 2026 13:30:14 -0700
Message-ID: <20260918203049.7273-6-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918203049.7273-1-anisa.su@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
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


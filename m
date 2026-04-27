Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A826A08A
	for <linux-cxl@vger.kernel.org>; Mon, 27 Apr 2026 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260393; cv=none; b=pUUknTjo8s2AUAsdbjW0Huyn1hahym24hHR6lsW9V/YFk52yVQYfi4hYXkwhCsvGJB9BOw0fpARyP7b/Xe7629IdxeZOaMWjkrii4DsZeDG2mtj8ACnu7pOfcak9g/1cLqtBK4zxy5wLoe8isi3RNguLw2P++6+qs38xGkVWo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260393; c=relaxed/simple;
	bh=/tuIm7lBZ2ovM2HT2MHU2C5GZd5ttgZkhMqpDfT31H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQMcJ5tn72flxrFlXbgf2VRQvbKCmoDGu3vBgw1A9FlToZrjQkI1Tp4Qgy+UaYdAYqh+LzkBxuDhQGlBm0VkSiFi2eq6JmdhdGu1PCnCbaEktBD1U0G1cDeS9AdDPg2xi0gRWe35XO1IUAtDc0jh45D+ev3FwTZYUZL210J2h5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65318dafbcbso9409510d50.2
        for <linux-cxl@vger.kernel.org>; Sun, 26 Apr 2026 20:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777260391; x=1777865191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jL0w3++j1T4lvfmJHedjOyHD2Gu9RdXz+BDQhF932Xw=;
        b=m/5KyxV0MsCkEMhyb3zgtBlRKjKkdSaKCws9rLqgJgKG8HLevtDelEBOLUnRxVb8Gx
         sCWA+e0ZQYOHhhkX2cgTvCsRc2y3Sg8YtCqnYTA8+9I/qDYT9//QizQq26feICz8wNjj
         pwZQvMOSm+dxT9x/6IGvSkTAewNFFY/pKQgP6tguwmlNzFad73J6mBJHU4W4QL2qSXQC
         xBnJTY98m4X9IusHkiYwX+MpjT9FHJ9D+i1XTuxa6ufZ3nO8m4JnU8AN28qMilGZ3v1k
         umM0STXDDUBjz7iptsFr3qc1ko85LMLX+JK0P3mgl70tK7ig9drORt/+ZQ7Pji5lu8ZS
         Do+g==
X-Forwarded-Encrypted: i=1; AFNElJ88o0RT5riPnxR+qWtrQaoyUqYu50GlUZeWBl/fPmXwR1MB8dxL7mVIYIpCMBTYnQmfbiyGemVURxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQ7XPHUy1Rn0W/Sjmh1E7T9Xtkg1FBlJ2Xemf9o0YduUrQP93
	nZuBhR004thFuvpFBiSEsRZRMgWrcjoko6cV1cdYXe0q+HMdqjLCPSdo
X-Gm-Gg: AeBDieuFAYoGglhaI8Wf/7TE1JFScQktdYxEi7nOWmP7nwPPFnexOcetk1eDY7XD1+G
	AiwwUNtChpuqgeQgj/IjOMtuf+1Bqt2y0Pw4ayL/pMAN9I1FP9e4pCcuRezz6O0yTTvReYlUgtV
	dQj9sKaljcG3XxBU7niP+3jBHjFNNp9crJkNKAeOJJoDPx7RTUnt0N4UYe/VVDRHurqcwVPti0d
	QvjoN6xZkvGfiyil40fM/Mvasgax0QQdoST+62btH6vjSfbMGZs9uhm9ca/tMpbS9S+oBnVARUH
	AX/FYuB7/Ns8LCdtk5x5b8NUa9PVog6tEYS0RvGHJeakO1AcCwnsjs71ZyMgNED0czcdUxiPvvT
	O58BbpSmSyxH9XK9vqh0Di2xJxIe3bbAEFclf+iGbt9K+da2On3DTm5a9wysnGL/w99xCqu1mPW
	H3KmjFVgZjANGpAEkLf44d
X-Received: by 2002:a05:690e:144c:b0:654:6cd0:f96b with SMTP id 956f58d0204a3-6546cd144b3mr13884636d50.5.1777260391520;
        Sun, 26 Apr 2026 20:26:31 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-65314b26b56sm14087239d50.4.2026.04.26.20.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 20:26:31 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ben Widawsky <bwidawsk@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] cxl/region: Fix a race bug in delete_region_store()
Date: Sun, 26 Apr 2026 23:20:10 -0400
Message-ID: <20260427032010.916681-5-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427032010.916681-2-iam@sung-woo.kim>
References: <20260427032010.916681-2-iam@sung-woo.kim>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes race conditions in cxl region unregistration by (1) using
remove_devm_actions() instead of directly calling devm_release_action()
and (2) making unregister_region() idempotent.

Race:

CPU 0                     CPU 1
======                    ======
delete_region_store()
  cxlr = cxl_find_region_by_name()
                          delete_region_store()
                            cxlr = cxl_find_region_by_name()
  devm_release_action()
                            devm_release_action()
                            // cannot find the action, WARN_ON()

Splat:

WARNING: drivers/base/devres.c:824 at devm_release_action drivers/base/devres.c:824 [inline], CPU#0: syz.1.12224/47589
WARNING: drivers/base/devres.c:824 at devm_release_action+0x2b2/0x360 drivers/base/devres.c:817, CPU#0: syz.1.12224/47589

It's found by a fuzzer based on Syzkaller that rapidly executes CXL's
sysfs interface with QEMU CXL devices cxl-type3 and pxb-cxl.

Syzkaller's CXL grammar is available at:
https://github.com/swkim101/syz-cxl/blob/main/cxl.txt

The bug's impact seems low, since the region has already been released.
So, it does not affect users, except for a negligible warning message.

Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
Suggested-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 drivers/cxl/core/region.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b086ae88b5bb..08b93b14a2c7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2544,6 +2544,9 @@ static void unregister_region(void *_cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
+	if (test_and_set_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags))
+		return;
+
 	device_del(&cxlr->dev);
 
 	/*
@@ -2863,15 +2866,18 @@ static ssize_t delete_region_store(struct device *dev,
 				   const char *buf, size_t len)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
-	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_region *cxlr;
 
+	/* remove_devm_actions_work() will put cxlr->dev. */
 	cxlr = cxl_find_region_by_name(cxlrd, buf);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
-	put_device(&cxlr->dev);
+	unregister_region(cxlr);
+	if (!remove_devm_actions(cxlr)) {
+		put_device(&cxlr->dev);
+		return -EBUSY;
+	}
 
 	return len;
 }
@@ -3736,7 +3742,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 {
 	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
@@ -3757,7 +3762,12 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = __construct_region(cxlr, ctx);
 	if (rc) {
-		devm_release_action(port->uport_dev, unregister_region, cxlr);
+		/* remove_devm_actions_work() will put the device */
+		get_device(&cxlr->dev);
+		unregister_region(cxlr);
+		if (!remove_devm_actions(cxlr))
+			put_device(&cxlr->dev);
+
 		return ERR_PTR(rc);
 	}
 
-- 
2.47.3


Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761B30DECC
	for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875895; cv=none; b=IN6XaAUmKUVgw5LZqHN509Ny6fy9Yv1tP5iC5JTTXxBXHggviJJ3brB7bKbu9AqSSZwhzK+irpTkpEQf3lw1ndqMjtDm9zng380ncz5tEWdOMgE1fKWOpPFHgqrfNxjpKNU6XwDBLicJJ3nke/1kdp5njQAvXyW9A1kTAgxD1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875895; c=relaxed/simple;
	bh=HO46xXiaOEoNQuNX446KuoMFMjLpaf8jb4DS4NNt61k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saag+TnpfX0P4EeSFrSZGk4P2eql0fun9V03R62nJ7AAeWzBp5sahSou8adn8t/R87bAxlOP5Dk2dTVBYh7IoZkapn24CYblLMwNkUnw+XVezjXtwEqevcEWGI0a0q9QDb8pWllpFTkX4UTs8PVuG/BoRAXfEGIVUHKLOpIqkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd8576a512so594673685a.0
        for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 06:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774875893; x=1775480693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPxDq54rMr2H74jw6fg584rwf//Zw9k/WAlYqCcMc1A=;
        b=jHSCaCkD4vN1uQPp07n3wDZG/9nM0IEoZCu35q/BEWHQE3VJHMf3lOSKXWPE52EAsm
         uEJrVsh9zQjP+sZh5nRNeVi5v2pujx/g2FIYh3Am9gPkyF27OwcF1x7ppHUX53Hjylya
         cQDqZ/hxApBeVCBFSo/JNbHrjbp3pBM1yN1RlbNDWoDap6+gq19hHKZqtMvosb0mf/wW
         bDe4mzIIcl2HXeRufPFQgRdmibd2x4TzNqH+2bXXwdhPFr3imCqKjBwDukXKMdaMDUXF
         bENc+Wct5IVau/eEoNvH8Nrx7cLQFmaY3zo+PcKqW99Y+bxNo1NQydu44qa9W+awALeu
         uhhg==
X-Forwarded-Encrypted: i=1; AJvYcCUHw6s4FwVGVO85bdR65h28cPTT0WyIGVltq47mJYQSIw4aGwWgYjGi8gtNrP0Ipxxavk7vn7kM67c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/HSTCYnI1TDMqA7EQyO4tzVJuhztHizp3rNb7SQuT18MEsFn
	xdyCqFX6h88UNQ9BqQ5DOL23FXAq6Pjvqpn+0d3Wq2gKD3Enhj8uL7oj
X-Gm-Gg: ATEYQzwNvR0RFJN/oPI51TKXzICQC4QLvnQBPjN48n4KbtrKpISMzOP2g/hVab1an8A
	o1CEs1AyqQNHFS7WTE9xHWkrvORFDIcD0GOkVC2fDxrOXj7zBln87xcCC/W7HBM4+Q94Ip2ANvR
	eCQ/CoDLetR21PneJW9dK8/9LCWRiY7wA8/e0cIiPXIeMBLEtxJz50LTltSeYnNUm8bc+ZvFZdq
	E2iz13HokRwKRE2CenlIKL1M/1Wet4DtZfcF2bw4EgktxifWm+MHDVo3bWJzeBZNOItvz2XnyF/
	owAHYkP7CpzkMvKgLmR5SSi7uW16I/RvbGyjBnVs9yFgW1hl3+RwrWzozKqNEaTekk5NvQ3TD3n
	aipBjRAXhtgE+0B//kX3ks2arGnqaP9eeRPZ13xI+zgXVSNwVydtfqdow5yLqMLlnvzhWjLg+K9
	VZ41A26nBqlA==
X-Received: by 2002:a05:690c:6989:b0:79b:cced:2342 with SMTP id 00721157ae682-79bde5b9536mr99687637b3.28.1774875893014;
        Mon, 30 Mar 2026 06:04:53 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-79cba172828sm34618347b3.35.2026.03.30.06.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:04:52 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ben Widawsky <bwidawsk@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] cxl/hdm: fix a warning in devm_remove_action()
Date: Mon, 30 Mar 2026 09:01:57 -0400
Message-ID: <20260330130156.2212694-3-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the following race scenario, devm_remove_action() can be called
before devm_add_action(), triggering a warning because there is no
action to remove.

To fix this, __cxl_dpa_reserve() performs devm_add_action(). This
extends the critical section that embraces cxled->dpa_res = res and
devm_add_action(), so cxl_dpa_free() cannot observe dpa_res without
the devres action.

task 1:
cxl_dpa_alloc()
  __cxl_dpa_alloc()
    guard(&cxl_rwsem.dpa)
    cxled->dpa_res = res;  ...(1)
  devm_add_action()        ...(4)

task 2:
cxl_dpa_free()
  guard(&cxl_rwsem.dpa)
  if (!cxled->dpa_res)     ...(2) pass, due to (1)
    return 0;
  devm_cxl_dpa_release()
    devm_remove_action()   ...(3) warning, no action is added yet

Splat:

WARNING: ./include/linux/device/devres.h:160 at devm_remove_action include/linux/device/devres.h:160 [inline], CPU#0: syz.1.6464/25993
WARNING: ./include/linux/device/devres.h:160 at devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline], CPU#0: syz.1.6464/25993
WARNING: ./include/linux/device/devres.h:160 at cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572, CPU#0: syz.1.6464/25993

Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an endpoint decoder")
Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
V1: https://lore.kernel.org/linux-cxl/20260309000810.2632065-2-iam@sung-woo.kim/
V1->V2:
- Let __cxl_dpa_reserve() handle devm_remove_action() to reduce
  duplicated patches. (Thanks to Dan for the suggestion)
- Make the comment concise (Reflect Dan and Alison's comments)
- Make a warning log in a commit message concise

 drivers/cxl/core/hdm.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index cb5d5a047a9d..63bd0d5f31df 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -408,7 +408,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
 	port->hdm_end++;
 	get_device(&cxled->cxld.dev);
-	return 0;
+
+	/*
+	 * Perform devres registration while holding cxl_rwsem.dpa so
+	 * cxl_dpa_free() cannot observe dpa_res without a matching devres
+	 * action.
+	 */
+	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
 static int add_dpa_res(struct device *dev, struct resource *parent,
@@ -499,16 +505,8 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 				resource_size_t base, resource_size_t len,
 				resource_size_t skipped)
 {
-	struct cxl_port *port = cxled_to_port(cxled);
-	int rc;
-
-	scoped_guard(rwsem_write, &cxl_rwsem.dpa)
-		rc = __cxl_dpa_reserve(cxled, base, len, skipped);
-
-	if (rc)
-		return rc;
-
-	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	return __cxl_dpa_reserve(cxled, base, len, skipped);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
 
@@ -606,7 +604,8 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	struct resource *p, *last;
 	int part;
 
-	guard(rwsem_write)(&cxl_rwsem.dpa);
+	lockdep_assert_held_write(&cxl_rwsem.dpa);
+
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder attached to %s\n",
 			dev_name(&cxled->cxld.region->dev));
@@ -669,14 +668,8 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 {
-	struct cxl_port *port = cxled_to_port(cxled);
-	int rc;
-
-	rc = __cxl_dpa_alloc(cxled, size);
-	if (rc)
-		return rc;
-
-	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	return __cxl_dpa_alloc(cxled, size);
 }
 
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
-- 
2.47.3


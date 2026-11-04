Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833368;
	b=Q099esJ+mqFKo3W8mmrRfFjMtOo/egGQURn9KYS7kj91hiG649n59vEGXiCx/3rkrYLZ
	 rP2wgLOkOV1gslJr86v3oYybXA7ae14rFf39lbGvO4bfiBETsJJylvkiVgxzhwWi6A+S6
	 2LtWezCBFHsG9CSuydPjFTGqZl5FIVKw9QZ9q7qYigDHIMuWyQvDJsccvPT4yIB3pFtCT
	 Mpxj3y3QB+xJnsBXdeAAyUGgDPnf80ockRfZG5njwfAysHGL2OKqAGXT1suIKA1eHkbFK
	 3ewjfYqodR0Tqss6G1V5Y0HVstLhdxHMs2JZ3pBci2TvQ2BhjrRJVAE9tAnySaXZu0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CNM1EYOlTzyNUEwxlK4YGo2GVC9yeplaVRpTfyoYgug=;
	b=FKnZ7jCiipLzu6KSPrm5YPoEWb5qBaBkPyHSf87LExLgyKCWG0U/ET/HNhAxbOTYpE+f
	 MkYFdydw+3JT10cZ4WfomPH64qQO5oflHnKxtTcW9PPjYMn2b0j3LXMgUzxiB5HdKJiht
	 9gLLv7VRLcfLrN57hA/vj4m+TZ4B9cI8dkNEo7kpLjEJHBztNM+c/QnB39EFK4Uc1YCrG
	 XtMJYuTPZ58JAuZikIEs1y+nxUEn9miK6EtREcGLoJhrok2sNTDvKTheRx4lueOjQ+AGt
	 4RCZ+iw15DNEVgD/ye7KWp8HZ1JIfzvimD8o1xOmwtxB5zxGgRMJLf4kENKRDFloSPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gaLRF7L5;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC61606EE99
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 23:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABC61606EE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gaLRF7L5
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9d7791b00so10735095ad.0
        for <linux-cxl@vger.kernel.org>; Wed, 04 Nov 2026 15:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833367; x=1794438167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNM1EYOlTzyNUEwxlK4YGo2GVC9yeplaVRpTfyoYgug=;
        b=gaLRF7L5Pn9Uc2x+WXg/r17vuVl//0qrT+MvXxXnJ+mNRzTG2cr6PrK9/yQuddIeTU
         DsJ5EDfxsR5k3gFLkw/LadWhPtpg0D8uZu7RtRv+4nLVHReASjUuXY1CJfbzbik6DqjV
         qYYAsoV5aGXnBjRMbCL40V9XfFYPlddxvTnYCWSFpbKfNPqBVo+zdYe/GQHVXErST/Xy
         9B//O5Sz2ADEgpEjg7Ht5MGiji/SUuCAMokd4c+1HhOvgfGGUdW+TNT1iv+8RZgpWpox
         2Yf8NbEoDAm7sWqIXh1+lwdNmmN0m5rs2dXkWBY8Kh/gtHG5Q5LD4dS4wwVxz1Ll1LYG
         ckxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833367; x=1794438167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CNM1EYOlTzyNUEwxlK4YGo2GVC9yeplaVRpTfyoYgug=;
        b=Ln025YiiQDkq+invlyiDeTC3RzGr4ayFNtTS+ClwzuxvkpB8Q19uRE4AA4zM8KdCKx
         ZASEmatJujO18bmgQsOiL5tAhZFkJA+mGJNwV6tyqzEii4lDrcYwkOpWd6wuVITXP7sz
         A7XLmFRTX8pxwSw9bzyCCiyNrwBt1tC1ilqsCCa5xcnCE5vcuwKKhdkMadmkejppjzeV
         Y/tWX5dal/Su1D55en9FOhJP5xRgBlOAO2yUWKHWcPi2dQ1WGU49VJJ8UM5BrZyy6p2R
         RgIaowd21p5wauaPb5jNuA8/E0EBfMh2lsDZ9F+7kRoRTVQBsF/39UJOsIpzYEsE/29A
         ca7Q==
X-Gm-Message-State: APuU4Z/zck3UpGVJzq/zWkseufxHWIYdqzonS6fX0VblKqe90QaEgB6b
	o6jrcHUhu2GrJAAZGwW3PzbkESxgveJXNO/+njxJS5pYIRhqJNNV4V7kxA6Ys8UT
X-Gm-Gg: AYBFou1euGHD3eyQuhHlJlcMp6syDNbCBDfdozNyCPs5jN+8u4qUZlRBcLoIAibw04e
	abOfPqsdV24XfROlNc1tliOpbdrEZX7eutCxigNEXb5Gbz2pocIB674FddYxHcMn0U4tBSph8a9
	JtZcH2EADQ/f2OQQ8Uy+eZswIfwJdmnvWOlgN7ASHoCdnJN2gkpBMuRYaIf1cDt9gNE3QiVKlJU
	SnCvG3EmvkUVBGWIYhiNaEbhyTPi8xoRlJOWXY3Oa/+kfk10GF3pqt4s2mTAY/SeVYwbKPMMhp+
	xYMWdQJW6NQtARL5QzVm8qtXprmtNlnGi8OgJOjVMRTfglwP+hUsJ5iPiq+hONqfIeibMKmGu5l
	93RmbiDfAEpS7kgGkIYg3FdCHkk2P1Fno4MBe4J6//lzTL3tS141ybnOnWM5WoMRZ8r2RmLo5it
	URQEp7Dzz58Ycqoh1ljL2skg5gJxZbZnC89pZ8CTY8PRUP9Oc1nvQ2CRrOemy88b52oV2zARHSP
	Z/NYWz6LBwGg+cYe8OTIo3jZwbYcD6kHRbXy2hoANoidj+ELxcFBgYLUjrYG3fQw+LtMYAKrVL5
	etByKeIb77K1OEKc7DJLDu20kDkheg==
X-Received: by 2002:a17:902:d505:b0:2ed:29eb:177f with SMTP id d9443c01a7336-2ed29eb17c1mr509575ad.13.1793833366944;
        Wed, 04 Nov 2026 15:02:46 -0800 (PST)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0908587dsm10999175ad.36.2026.11.04.15.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:02:46 -0800 (PST)
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
Subject: [PATCH v1 05/14] cxl/mem: Add 20 second timeout for stalled DC event chains
Date: Thu,  5 Nov 2026 08:02:29 +0900
Message-ID: <20261104230445.66625-6-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104230445.66625-1-anisa.su@samsung.com>
References: <20261104230445.66625-1-anisa.su@samsung.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A Dynamic Capacity event can span multiple event records grouped
together by the CXL_DCD_EVENT_MORE flag. Extents are staged in the
pending list until the last event record ('More'=0) is received, at
which point the chain is processed. If the device opens such a chain
(More=1) but never sends the closing record, the staged list sits
indefinitely.

Add a delayed-work watchdog that drops the chain on timeout: an add
chain is refused with an empty Add Dynamic Capacity Response (4802h),
a release chain is left for the device to retry.

The spec sets no limit; 20s is a generous upper bound that may be
tightened later, and guards against a lost mailbox response or a
crashed fabric manager.

The deadline is fixed when the chain opens rather than extended per
record, so a device cannot keep a chain alive, and the staged list
growing, by streaming More=1 records.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
---
 drivers/cxl/core/mbox.c | 84 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 15 ++++++++
 2 files changed, 99 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 3acf5ace48db..fea910e6c510 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -873,6 +873,8 @@ static const uuid_t log_uuid[] = {
 	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
 };
 
+static void cxl_cancel_dcd_chain_work(void *_mds);
+
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
  * @mds: The driver data for the operation
@@ -891,6 +893,16 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 	struct cxl_mem_command *cmd;
 	int i, rc;
 
+	/*
+	 * The DC chain watchdog sends a mailbox command when it fires.  Register
+	 * its cancellation here, once the mailbox is usable, so devm runs it
+	 * before the mailbox goes away: in cxl_pci the device registers were
+	 * mapped before this point and are unmapped after the cancel.
+	 */
+	rc = devm_add_action_or_reset(dev, cxl_cancel_dcd_chain_work, mds);
+	if (rc)
+		return rc;
+
 	gsl = cxl_get_gsl(mds);
 	if (IS_ERR(gsl))
 		return PTR_ERR(gsl);
@@ -1198,6 +1210,14 @@ static void clear_pending_extents(void *_mds)
 		delete_extent_node(pos);
 }
 
+/*
+ * Bound on how long the host will wait for a device to finish a
+ * multi-record DC event chain (More=1 ... More=0) before refusing the
+ * chain.  The spec sets no limit; 20s is a generous upper bound, the
+ * maximum GPF timeout.
+ */
+#define CXL_DC_CHAIN_TIMEOUT	(20 * HZ)
+
 static const char *cxl_dcd_evt_type_str(u8 type)
 {
 	switch (type) {
@@ -1226,6 +1246,11 @@ static void cxl_dc_chain_abort(struct cxl_memdev_state *mds)
 	struct cxl_dc_event_chain *chain = &mds->dc_chain;
 	struct device *dev = mds->cxlds.dev;
 
+	lockdep_assert_held(&chain->lock);
+
+	chain->armed = false;
+	cancel_delayed_work(&chain->timeout_work);
+
 	if (chain->event_type == DCD_ADD_CAPACITY &&
 	    cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
 				 &chain->pending_extents, 0))
@@ -1234,6 +1259,43 @@ static void cxl_dc_chain_abort(struct cxl_memdev_state *mds)
 	clear_pending_extents(mds);
 }
 
+static void cxl_dc_chain_timeout(struct work_struct *work)
+{
+	struct cxl_dc_event_chain *chain = container_of(to_delayed_work(work),
+							struct cxl_dc_event_chain,
+							timeout_work);
+	struct cxl_memdev_state *mds = container_of(chain,
+						    struct cxl_memdev_state,
+						    dc_chain);
+	struct device *dev = mds->cxlds.dev;
+
+	guard(mutex)(&chain->lock);
+
+	/*
+	 * handle_dcd_chain_event() cancels this work non-synchronously (a sync
+	 * cancel would deadlock on @chain->lock, which the chain-close path
+	 * holds), so a callback that already started running can reach here
+	 * after its chain has moved on.  Abort only if a chain is still armed
+	 * AND the timer has not been re-armed since this expiry fired: a new
+	 * chain's queue_delayed_work() makes delayed_work_pending() true,
+	 * meaning this expiry belongs to a superseded deadline and must not
+	 * abort the current chain.
+	 */
+	if (!chain->armed || delayed_work_pending(&chain->timeout_work))
+		return;
+
+	dev_warn(dev, "DC %s chain timed out\n",
+		 cxl_dcd_evt_type_str(chain->event_type));
+	cxl_dc_chain_abort(mds);
+}
+
+static void cxl_cancel_dcd_chain_work(void *_mds)
+{
+	struct cxl_memdev_state *mds = _mds;
+
+	cancel_delayed_work_sync(&mds->dc_chain.timeout_work);
+}
+
 static int stage_pending_extent(struct list_head *pending,
 				struct cxl_extent *to_add)
 {
@@ -1260,6 +1322,8 @@ static int handle_dcd_chain_event(struct cxl_memdev_state *mds,
 	struct device *dev = mds->cxlds.dev;
 	int rc;
 
+	guard(mutex)(&chain->lock);
+
 	/* Chained records share one event type (CXL r4.0 Table 8-229) */
 	if (list_empty(&chain->pending_extents)) {
 		chain->event_type = event->event_type;
@@ -1279,9 +1343,22 @@ static int handle_dcd_chain_event(struct cxl_memdev_state *mds,
 
 	if (event->flags & CXL_DCD_EVENT_MORE) {
 		dev_dbg(dev, "more bit set; delay processing of extent\n");
+		/* The deadline is fixed when the chain opens, not per record */
+		if (!chain->armed) {
+			queue_delayed_work(system_wq, &chain->timeout_work,
+					   CXL_DC_CHAIN_TIMEOUT);
+			chain->armed = true;
+		}
 		return 0;
 	}
 
+	/*
+	 * Chain is closing.  Disarm before flushing so a pending watchdog
+	 * (queued but blocked on @chain->lock) sees !armed and bails out.
+	 */
+	chain->armed = false;
+	cancel_delayed_work(&chain->timeout_work);
+
 	/* Nothing is tracked yet: refuse every add, acknowledge every release */
 	if (event->event_type == DCD_ADD_CAPACITY)
 		rc = cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
@@ -2021,7 +2098,14 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 
 	mutex_init(&mds->event.log_lock);
 	INIT_LIST_HEAD(&mds->dc_chain.pending_extents);
+	mutex_init(&mds->dc_chain.lock);
+	INIT_DELAYED_WORK(&mds->dc_chain.timeout_work, cxl_dc_chain_timeout);
 
+	/*
+	 * The watchdog cancel is registered later, by cxl_enumerate_cmds(), so
+	 * devm's reverse-order unwind cancels (and waits for) the watchdog
+	 * before this list cleanup runs.
+	 */
 	rc = devm_add_action_or_reset(dev, clear_pending_extents, mds);
 	if (rc)
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c88de7cb65d1..52c936ec15a9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -8,6 +8,8 @@
 #include <linux/uuid.h>
 #include <linux/node.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
 #include <cxl/event.h>
 #include <cxl/mailbox.h>
 #include "cxl.h"
@@ -431,6 +433,11 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * struct cxl_dc_event_chain - staged Dynamic Capacity event chain
  * @pending_extents: extents received so far; flushed when the chain
  *		     closes (More=0)
+ * @timeout_work: watchdog that fires if a chain is opened with
+ *		  CXL_DCD_EVENT_MORE but the closing record never arrives
+ * @lock: serialises updates to the chain state against the watchdog
+ * @armed: set when a More=1 chain opens; cleared when the chain closes
+ *	   (More=0), is aborted by cxl_dc_chain_abort(), or times out.
  * @event_type: DCD event type of the open chain (add or release)
  *
  * The records of one Dynamic Capacity operation can be chained by the
@@ -439,9 +446,17 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * chain is open at a time.  Both Add Capacity and Release Capacity chains
  * are staged here, @event_type says which.  Records are staged until
  * More=0, then the chain is processed and responded to as a whole.
+ *
+ * If a chain is opened (More=1) but the device never sends the closing
+ * record, the staged list would otherwise sit indefinitely.  @timeout_work
+ * is a defensive watchdog that drops such a chain: an add is refused with
+ * an empty response, a release is held for the device to retry.
  */
 struct cxl_dc_event_chain {
 	struct list_head pending_extents;
+	struct delayed_work timeout_work;
+	struct mutex lock;	/* chain state, against the watchdog */
+	bool armed;
 	u8 event_type;
 };
 
-- 
2.43.0


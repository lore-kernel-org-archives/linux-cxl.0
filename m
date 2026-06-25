Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84C3D9DC4
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386926; cv=none; b=XKF791k24x8PvWk84z7SQYlZv/jCwcGOlUR+RICfsbMUEdshwqr65qFpZDxrO5d2Gyp2WTAaa4FdpcOUaeesOQlrhiGwH0uqDDiFSxhJaQJIFKuT7T6fDtHEuBVCnbTrySPpR53NQ4gyPLIFJKyH/yBau7NHfvKIBnebW4HJOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386926; c=relaxed/simple;
	bh=DZ7/p/k+hRPStr/nvrhW7M9r+9W3HBn/PCBJcQ12HTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohxj5s5nIT3vXMzKIjcRHKds4/ETycWSku4lEi3YickZ+KdP3TqfmNcY0gP9gVRZ8K4Qib4uf2TMsuJ0Lf4q/KMTczdaQ2iBDrWRjaY/4WmGa3S6QocwiSll8RUSJbZdc3HlXjCBB3ZdG24oS/YwWL+sooG0Nj78uUxH52Helxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrZ1dnUp; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrZ1dnUp"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c8f2d93baso443629eec.0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386924; x=1782991724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1Q4HoDRflTJ8UoBWS4trvhsixbEL0xrWlQEjrAFDGs=;
        b=jrZ1dnUp8K5YAV0dZxi6ArqtGeaX06Sgvj729vi+huoVeTX9XeVNPVg+wfbTCI0Mvf
         PwNlGAgwFte8x7wX5MbJWfjC1c279QFva+E5wUVe2PZJJPxjWQMSOFqulD4dQ4eMYxoV
         eAkWrSpCpu2u1FssW9h8IHrbcO7VV6WSWksgmW932ftooRCr3cGs/kEKXktuV2KAB7qt
         fIm52HZz2e332AH6Hg+3vP6PPurj0+x4favjD4WLT7+abV2FZDk9PATOhjXtmvNCvKGJ
         wbNvHl72c99O5IRIXFakbAAouPOOrJDyLPmURU5Bs2e+b5RLJRTgG58F/nnDsyYMNq+q
         1aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386924; x=1782991724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X1Q4HoDRflTJ8UoBWS4trvhsixbEL0xrWlQEjrAFDGs=;
        b=ahrgrb8fsCM5vhgPETI0NVvlPkslwwNwrX1tVnINsgwXXkk2k5fzuwmfC6S1NqC3LZ
         mjm4TUgPKl8IyHzKkv5qrVLW1yKT3Lj8c3MWSjd24yExTc0aBNAeuZjWPOINi+HYLcyG
         bOatITWtwTpY4kac8mEhkolLy3PsWRBgD/hxA1CabBwBYz7R3djIqcMVl6As83xTY6Ug
         i0DYSYENzQ65yDUp30agRVxj970dAdiI6Etc8BJuUq2sVwLyq6r5rELxi+3tiIG8jT27
         5CXdV6T8g7PPtyeAH1n8UKqND3q5CdZcr05biQbk9btHI6EOCNOUWPyZ0QJ2jDd6IXKI
         YCEQ==
X-Gm-Message-State: AOJu0Yw7P4lOzpFH2CaliDvpauKDPyAxDr+dtFlyd0wKlhKCFG3PJRIf
	QBwXzQAMxD6AHL2nwElUbiagLVk13C0ds95GGTO0cAILSRYASPb6AXrzCakccg==
X-Gm-Gg: AfdE7cnb/nSFOWAzH3Ec/q+LaACt+CuafXnUB7hRJB6uVuBFW3aQs0rezA+swbXLGXu
	Zs3M6EOdQKKVV1mbmjuGTJuprK7IqXaH9w+YnThxMCe+GDx49izxjv44I4/HSyo3CJ+FNqvareA
	Dn+RTNWk9Z17RycMpbFoVjyjtDh4HTjtewFZtPVVeLOKcFywwM78dklmPJqtcR5grl9IkHP1TR7
	udrHbxpaLButL2dVweUknzEMDCZzvvp8Iw/TlX9KckkwL4dG74QcSRymgtZRuTPWh0fsZSZ5ym7
	+c1GQ4CkOszFcMjunTGJQixD1OPb9gkuHIJxSM3O1/Gq5thQe9jjxHaQtKaPQivV4YSC+XW4RQK
	oRL3SWXf5zlo64QyB3dKDmOcUQO9VJMnHQ5yx4Zm8NuwQ5aGdK2lRpCE2Ojd/V2CxFEjjMsYKrP
	E0GfY1PHQ5YLXZNs6goF8scU3x1VoiCSYu4+CALsd9FtfkKrTAxhvGPaIsEsgjQJw2uoJi
X-Received: by 2002:a05:7301:3d0d:b0:304:eaa8:11ea with SMTP id 5a478bee46e88-30c85124ae2mr2395020eec.34.1782386924222;
        Thu, 25 Jun 2026 04:28:44 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:28:43 -0700 (PDT)
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
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v11 13/31] cxl/mem: Add 20 second timeout for stalled DC_ADD_CAPACITY chains
Date: Thu, 25 Jun 2026 04:04:50 -0700
Message-ID: <20260625112638.550691-14-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A DC_ADD_CAPACITY event can span multiple event records grouped together
by the CXL_DCD_EVENT_MORE flag. Extents are staged in the pending list until
the last event record ('More'=0) is received, at which point the pending
list is processed. If the device opens such a chain (More=1) but never
sends the closing record, the staged list sits indefinitely.

Add a delayed-work watchdog that, on expiry, refuses the chain with an
empty ADD_DC_RESPONSE and drops the staged list.

The 20s timeout is a conservative upper bound and may be tightened
later. The timeout is purely defensive — the spec does not require it,
but prevents issues from a lost mailbox response or a crashed fabric manager.

The watchdog bounds how long a chain may stall, but a device could still
defeat it by streaming More=1 records faster than the timeout, growing the
staged list without bound. Also cap a runtime chain at
CXL_DC_MAX_PENDING_EXTENTS and refuse it once exceeded; existing-extent
recovery is bounded separately by the device's reported extent count.

Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
1. mbox.c: Fix comment in handle_add_event(), before closing the 'More'
   chain and disabling the watchdog. The comment incorrectly claimed
   handle_add_event() runs in system_wq.
2. mbox.c: Drop unnecessary initialization of add_ctx.armed=false in
   cxl_memdev_state_create(), as allocated memory is already zeroed
3. mbox.c: assert add_ctx.lock is held in add_to_pending_list(); it
   serializes access to add_ctx.pending_extents.
4. mbox.c: cap a runtime More=1 chain at CXL_DC_MAX_PENDING_EXTENTS in
   handle_add_event() so a buggy device cannot grow the staged list
   without bound (the watchdog bounds time, not memory).
---
 drivers/cxl/core/mbox.c | 98 ++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxlmem.h    | 24 ++++++++--
 2 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7dd40fb8d613..4e887b5cdc3e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1208,15 +1208,78 @@ static void clear_pending_extents(void *_mds)
 
 	list_for_each_entry_safe(pos, tmp, &mds->add_ctx.pending_extents, list)
 		delete_extent_node(pos);
+	mds->add_ctx.nr_pending = 0;
 	mds->add_ctx.group = NULL;
 }
 
+/*
+ * Defensive cap on extents staged in one runtime More=1 chain: a buggy
+ * device could otherwise grow the list without bound.  Not spec-defined.
+ */
+#define CXL_DC_MAX_PENDING_EXTENTS	100
+
+/*
+ * Bound on how long the host will wait for a device to finish a
+ * multi-record DC_ADD_CAPACITY chain (More=1 ... More=0) before
+ * refusing the chain.
+ * The timeout is not defined in the spec, but added for defensive purposes.
+ * Since there is no spec-defined timeout, 20s is chosen as a generous
+ * upper bound and matches the GPF timeout.
+ */
+#define CXL_DC_ADD_TIMEOUT	(20 * HZ)
+
+static void cxl_dc_add_timeout(struct work_struct *work)
+{
+	struct pending_add_ctx *ctx = container_of(to_delayed_work(work),
+						   struct pending_add_ctx,
+						   timeout_work);
+	struct cxl_memdev_state *mds = container_of(ctx,
+						    struct cxl_memdev_state,
+						    add_ctx);
+	struct device *dev = mds->cxlds.dev;
+
+	guard(mutex)(&ctx->lock);
+
+	/*
+	 * handle_add_event() cancels this work non-synchronously (a sync
+	 * cancel would deadlock on @ctx->lock, which the chain-close path
+	 * holds), so a callback that already started running can reach here
+	 * after its chain has moved on.  Abort only if a chain is still armed
+	 * AND the timer has not been re-armed since this expiry fired: a fresh
+	 * mod_delayed_work() (a later extent in this chain, or a new chain)
+	 * makes delayed_work_pending() true, meaning this expiry belongs to a
+	 * superseded deadline and must not abort the current chain.
+	 */
+	if (!ctx->armed || delayed_work_pending(&ctx->timeout_work))
+		return;
+
+	dev_warn(dev, "DC add chain timed out; refusing staged extents\n");
+
+	if (cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
+				 &ctx->pending_extents, 0))
+		dev_dbg(dev, "Failed to send empty ADD_DC_RESPONSE on timeout\n");
+
+	clear_pending_extents(mds);
+	ctx->armed = false;
+}
+
+static void cxl_cancel_dcd_add_chain_work(void *_mds)
+{
+	struct cxl_memdev_state *mds = _mds;
+
+	cancel_delayed_work_sync(&mds->add_ctx.timeout_work);
+}
+
 static int add_to_pending_list(struct list_head *pending_list,
 			       struct cxl_extent *to_add)
 {
+	struct pending_add_ctx *ctx =
+		container_of(pending_list, struct pending_add_ctx, pending_extents);
 	struct cxl_extent_list_node *node = kzalloc(sizeof(*node), GFP_KERNEL);
 	struct cxl_extent *extent;
 
+	lockdep_assert_held(&ctx->lock);
+
 	if (!node)
 		return -ENOMEM;
 	extent = kmemdup(to_add, sizeof(*extent), GFP_KERNEL);
@@ -1227,6 +1290,7 @@ static int add_to_pending_list(struct list_head *pending_list,
 
 	node->extent = extent;
 	list_add_tail(&node->list, pending_list);
+	ctx->nr_pending++;
 	return 0;
 }
 
@@ -1239,10 +1303,20 @@ static int add_to_pending_list(struct list_head *pending_list,
 static int handle_add_event(struct cxl_memdev_state *mds,
 			    struct cxl_event_dcd *event)
 {
+	struct pending_add_ctx *ctx = &mds->add_ctx;
 	struct device *dev = mds->cxlds.dev;
 	int rc;
 
-	rc = add_to_pending_list(&mds->add_ctx.pending_extents, &event->extent);
+	guard(mutex)(&ctx->lock);
+
+	if (ctx->nr_pending >= CXL_DC_MAX_PENDING_EXTENTS) {
+		dev_warn(dev, "DC add chain exceeds %u extents; dropping (firmware bug)\n",
+			 CXL_DC_MAX_PENDING_EXTENTS);
+		clear_pending_extents(mds);
+		return -ENOSPC;
+	}
+
+	rc = add_to_pending_list(&ctx->pending_extents, &event->extent);
 	if (rc) {
 		clear_pending_extents(mds);
 		return rc;
@@ -1250,9 +1324,19 @@ static int handle_add_event(struct cxl_memdev_state *mds,
 
 	if (event->flags & CXL_DCD_EVENT_MORE) {
 		dev_dbg(dev, "more bit set; delay the surfacing of extent\n");
+		mod_delayed_work(system_wq, &ctx->timeout_work,
+						 CXL_DC_ADD_TIMEOUT);
+		ctx->armed = true;
 		return 0;
 	}
 
+	/*
+	 * Chain is closing.  Disarm before flushing so a pending watchdog
+	 * (queued but blocked on @ctx->lock) sees !armed and bails out.
+	 */
+	ctx->armed = false;
+	cancel_delayed_work(&ctx->timeout_work);
+
 	rc = cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
 				  &mds->add_ctx.pending_extents, 0);
 	clear_pending_extents(mds);
@@ -2036,11 +2120,23 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 
 	mutex_init(&mds->event.log_lock);
 	INIT_LIST_HEAD(&mds->add_ctx.pending_extents);
+	mutex_init(&mds->add_ctx.lock);
+	INIT_DELAYED_WORK(&mds->add_ctx.timeout_work,
+			  cxl_dc_add_timeout);
 
 	rc = devm_add_action_or_reset(dev, clear_pending_extents, mds);
 	if (rc)
 		return ERR_PTR(rc);
 
+	/*
+	 * Registered after clear_pending_extents so devm's reverse-order
+	 * unwind cancels (and waits for) the watchdog first, then the list
+	 * cleanup runs with the watchdog guaranteed not to refire.
+	 */
+	rc = devm_add_action_or_reset(dev, cxl_cancel_dcd_add_chain_work, mds);
+	if (rc)
+		return ERR_PTR(rc);
+
 	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
 	if (rc == -EOPNOTSUPP)
 		dev_warn(dev, "CXL MCE unsupported\n");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4ffa7bd1e5f1..81498d47f309 100644
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
@@ -407,19 +409,33 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
 
 /**
  * struct pending_add_ctx - Staging state for an in-progress
- *			    DCD_ADD_CAPACITY event chain
+ *							DCD_ADD_CAPACITY event chain
  * @pending_extents: extents received so far in the chain; flushed when
- *		     the chain closes (More=0)
+ *					 the chain closes (More=0)
  * @group: tag group being assembled from the chain
+ * @timeout_work: watchdog that fires if a chain is opened with
+ *				  CXL_DCD_EVENT_MORE but the closing record never arrives
+ * @lock: serialises updates to the chain state against the watchdog
+ * @armed: set when a More=1 chain opens; cleared when the chain closes,
+ *		   either by a More=0 event record or by the watchdog firing.
  *
  * A DCD_ADD_CAPACITY notification can span multiple event records
  * stitched together by the CXL_DCD_EVENT_MORE flag.  Records are staged
- * here until the device clears More, at which point the staged batch is
- * processed and responded to as a single Add_DC_Response.
+ * here until an event record with 'More'=0 is received, at which point the
+ * staged batch is processed and responded to as a single Add_DC_Response.
+ *
+ * If a chain is opened (More=1) but the device never sends the closing
+ * record, the staged list would otherwise sit indefinitely.  @timeout_work
+ * is a defensive watchdog that refuses such a chain with an empty response
+ * and drops the staged list.
  */
 struct pending_add_ctx {
 	struct list_head pending_extents;
 	struct cxl_dc_tag_group *group;
+	struct delayed_work timeout_work;
+	struct mutex lock;
+	unsigned int nr_pending;
+	bool armed;
 };
 
 /**
-- 
2.43.0


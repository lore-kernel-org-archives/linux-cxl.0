Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244B320A04
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222582; cv=none; b=pJyZaOBxnmzdEgL3nbabL5SE7BHLeyenexit731nlcOAj5zcoIIdNQQSgBCzGQAzeqxFE+wxzp5xsnAwscB9KyIoexK4E1c+upbuIHhCBXWvMcRkah6RH4jA0YkhSWaENKh5aVNPqYkUGGw/gRiIxUgxkOch79ZnvtoiKgNhN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222582; c=relaxed/simple;
	bh=0BNR6+Wyz1YAvCcCXGJBv5Nw/P7itlR7WSXjiXI3AVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qULECeGpWcYNqG61ae4MeGN83sfJS+pCLLfOSeA5f0X0ES8ZzpIWHppFRzO75mJ4nptV+YRnVKO2M865arDR81HhMQ6Xo1RLMo7dW8eo1MDaQVUWwHNHzGXf8/Gp6NSkual70AgTN4GwSi/umy45IhsTdgyEwI18ExjwlQpw4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ki5k8uNz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki5k8uNz"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-861a2ae9c51so3050507b3.0
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 17:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788222579; x=1788827379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jh97Kqxwhv1lExXUZpeg7y5cqdyR2k4oN9KzJf+y/MA=;
        b=Ki5k8uNz4Z4w08xAHJziPGP/pEEehAF0UDBAWHT+vnWutSHSuBejqFGC8D9Bt+ni1A
         fXD7yV+jOeOpbpjeHBR9Z0wnjlQ63FIofovYhaoF8rmQmN0HElqS2gtgzDr6nNw1CmOs
         O057AiZ2K62Ry1Dehd2hmL+Xw4ieerrM0xlj/BI/keeNGM7brAxDSXQcsiopnTmzaTp4
         17N9l2pALr5585W08G/b3RbRBr/aoC/TMgktUvKTovaX/5VhK7415C1x2pMr3h6ngZ0W
         FZV1tOb87rFReFE0HJ+Zo8vDuRmZg2yK0hL5Jy04t6eDieD0UycBEaW+P/6mqVpGlHSw
         Ondw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788222579; x=1788827379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jh97Kqxwhv1lExXUZpeg7y5cqdyR2k4oN9KzJf+y/MA=;
        b=Y1gVWQdtX2nxMV0oOfGAslFoTkN7RUWmdAVmzTJsEnCLZNFOrboD+QA5Nx4HP7zUMf
         eV0c7AH8JGjB5E7iB4lnFRLtBwof7TT6BsFfndtUG68yeSkGzhoFkeURzrPTGQksWvBr
         Fxev/0BTG+y06cl1bvyzrmiq3nQP+JQRH2+o+n9UtPHoSdXpRXMdfVG93SjI4Qs/nkp+
         Ne8NAisoRNPOoCQwY/BtpRaUKaEtRoyT6wuggzosocEcfZWwET1xU/+M5yT/hmje5f9O
         +k0oK/SUEcx9HiwgY//HYFKYieYmM3ApzdYSkSMCt/DAKN1iY/BWLE3ZygS52FE0Z/MI
         SxBw==
X-Gm-Message-State: AFuF++lURxyqIVRXopJs6AS+RfGxyruIBvudnf1a2fcNXFDDmqBU4N9E
	tPwNHyAQiWjR5F7lap6hgOPbEnxmQsVBzN8Uy8b1m5h75VlnmzsaV7a+6PmaxA==
X-Gm-Gg: AYBFou0RQbDVh+vcN9AKy0LkY6XB52P578ou6fTtPEqE3C7rh86QQukVMgRlI1TLIv6
	2IlxoAaVI0+GACkWjcgNlAyDCuBjaePRioVMD6TvqvRHnHaSBN7IOPjqiNlphQ2d5ezYwnr9JWN
	tXtYcKBK9dooYBhgixySsvqfwctdQVbnhyJBfBp1Hw+p4o5G9aXZLqV/4n7IpknIkNVGz3CKeZS
	G2A9uZdr2UB0AHcK+FXQhip3i5QMkiFNUuzWSJS5DAvdV/05mGBKE6ji2pxIQdbT/qtvuXaYBG0
	lyd0SIN1dKTj+aLMbl0DYZI761lQs5kfScuN8f4wQwNpcf831iMickZgVfZVMX0f8FGH6qE4tVs
	hdWiufNfciEz53lNQiIWDhzkUx1MrHUuCjdVgB0JvVMCWr+IWb865n6s3STRT32VPHdIjus4pjm
	18EMu79opKPxZm9S+SDRqfcp2x3hnIrYA1dcAU843UE6Wahao+K0b/GNOVyiGMEyjPOAcVIDmS4
	UcL3CrAvdsg5Tv3VQQN10/M5YU174FUsCQtLIARvfneFuWKZw==
X-Received: by 2002:a05:690c:f:b0:866:4769:d60d with SMTP id 00721157ae682-86647793634mr41134497b3.22.1788222579121;
        Mon, 31 Aug 2026 17:29:39 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e668ce7ecsm63349177b3.34.2026.08.31.17.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:29:38 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: benjamin.cheatham@amd.com,
	icheng@nvidia.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	jic23@kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 1/4] cxl/events: Bound get records loop in cxl_event_thread()
Date: Mon, 31 Aug 2026 17:26:54 -0700
Message-ID: <20260901002912.958-2-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901002912.958-1-anisa.su@samsung.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_event_thread() drains all logs named in the Event Status register and
repeats until the register reads zero. CXL r4.0 Section 8.2.9.3.1 Table 8-203
marks the register RO and leaves clearing it to the device, so a misbehaving
device that leaves a status bit set spins the thread forever, resending
Get Event Records as fast as the mailbox completes.

Bound the loop on work completed instead. cxl_mem_get_records_log() and
cxl_mem_get_event_records() report failures and which logs returned
records; the thread drops any log whose status bit was set while it
returned nothing, and caps consecutive errors at CXL_EVENT_DRAIN_ATTEMPTS.
Every pass either drains a record, clears a bit from the mask or spends an
attempt, so the loop eventually terminates, even if the device misbehaves.
The first error is returned and an error from one log does not prevent
getting logs from the rest.

Retrying is limited to the failures that can plausibly be cleared:
-EBUSY and -ETIMEDOUT from the mailbox, and Retry Required from the
device. Anything else gives up on the first error, so cycles are not wasted
retrying on a non-retryable error.

Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
[Richard Cheng]: retry on transient failures
---
 drivers/cxl/core/mbox.c      | 74 +++++++++++++++++++++++++++++-------
 drivers/cxl/cxlmem.h         |  3 +-
 drivers/cxl/pci.c            | 63 ++++++++++++++++++++++++++----
 tools/testing/cxl/test/mem.c |  4 +-
 4 files changed, 120 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..2b71a8e1f35f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -988,6 +988,18 @@ static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
 	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
 }
 
+/*
+ * cxl_mbox_cmd_rc2errno() collapses every device return code onto -ENXIO;
+ * pick out the one the spec asks the caller to retry.
+ */
+static int cxl_event_retry_rc(struct cxl_mbox_cmd *mbox_cmd, int rc)
+{
+	if (rc == -ENXIO && mbox_cmd->return_code == CXL_MBOX_CMD_RC_RETRY)
+		return -EAGAIN;
+
+	return rc;
+}
+
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 				  enum cxl_event_log_type log,
 				  struct cxl_get_event_payload *get_pl)
@@ -1056,11 +1068,11 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 
 free_pl:
 	kvfree(payload);
-	return rc;
+	return cxl_event_retry_rc(&mbox_cmd, rc);
 }
 
-static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
-				    enum cxl_event_log_type type)
+static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
+				   enum cxl_event_log_type type, bool *got_records)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
@@ -1068,12 +1080,15 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 	struct cxl_get_event_payload *payload;
 	u8 log_type = type;
 	u16 nr_rec;
+	int rc = 0;
+
+	*got_records = false;
 
 	mutex_lock(&mds->event.log_lock);
 	payload = mds->event.buf;
 
 	do {
-		int rc, i;
+		int i;
 		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
 			.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
 			.payload_in = &log_type,
@@ -1085,6 +1100,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 
 		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 		if (rc) {
+			rc = cxl_event_retry_rc(&mbox_cmd, rc);
 			dev_err_ratelimited(dev,
 				"Event log '%d': Failed to query event records : %d",
 				type, rc);
@@ -1094,6 +1110,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		nr_rec = le16_to_cpu(payload->record_count);
 		if (!nr_rec)
 			break;
+		*got_records = true;
 
 		for (i = 0; i < nr_rec; i++)
 			__cxl_event_trace_record(cxlmd, type,
@@ -1112,31 +1129,60 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 	} while (nr_rec);
 
 	mutex_unlock(&mds->event.log_lock);
+
+	return rc;
 }
 
 /**
  * cxl_mem_get_event_records - Get Event Records from the device
  * @mds: The driver data for the operation
  * @status: Event Status register value identifying which events are available.
+ * @drained: Optional mask of the logs in @status that returned records.
  *
  * Retrieve all event records available on the device, report them as trace
- * events, and clear them.
+ * events, and clear them.  Every log named in @status is drained even if
+ * another one fails, so that a broken log does not suppress reporting from
+ * the rest.
+ *
+ * Return: 0, or the first error encountered.  -EAGAIN if the device asked for
+ * a command to be retried.
  *
  * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
  * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
  */
-void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
+int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
+			      u32 *drained)
 {
+	static const struct {
+		u32 status;
+		enum cxl_event_log_type type;
+	} logs[] = {
+		{ CXLDEV_EVENT_STATUS_FATAL, CXL_EVENT_TYPE_FATAL },
+		{ CXLDEV_EVENT_STATUS_FAIL, CXL_EVENT_TYPE_FAIL },
+		{ CXLDEV_EVENT_STATUS_WARN, CXL_EVENT_TYPE_WARN },
+		{ CXLDEV_EVENT_STATUS_INFO, CXL_EVENT_TYPE_INFO },
+	};
+	int ret = 0;
+
 	dev_dbg(mds->cxlds.dev, "Reading event logs: %x\n", status);
 
-	if (status & CXLDEV_EVENT_STATUS_FATAL)
-		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FATAL);
-	if (status & CXLDEV_EVENT_STATUS_FAIL)
-		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FAIL);
-	if (status & CXLDEV_EVENT_STATUS_WARN)
-		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
-	if (status & CXLDEV_EVENT_STATUS_INFO)
-		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
+	if (drained)
+		*drained = 0;
+
+	for (int i = 0; i < ARRAY_SIZE(logs); i++) {
+		bool got_records;
+		int rc;
+
+		if (!(status & logs[i].status))
+			continue;
+
+		rc = cxl_mem_get_records_log(mds, logs[i].type, &got_records);
+		if (got_records && drained)
+			*drained |= logs[i].status;
+		ret = ret ?: rc;
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ed419d0c59f2..cb5372eb2d85 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -803,7 +803,8 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
-void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
+int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
+			      u32 *drained);
 void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c..239df18c9c87 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -509,26 +509,75 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
 	return true;
 }
 
+#define CXL_EVENT_DRAIN_ATTEMPTS 3
+
+/*
+ * -EAGAIN is the device asking for a retry, the rest are the mailbox being
+ * momentarily unavailable.  Everything else is permanent as far as this can
+ * tell.
+ */
+static bool cxl_event_drain_retryable(int rc)
+{
+	return rc == -EAGAIN || rc == -EBUSY || rc == -ETIMEDOUT;
+}
+
 static irqreturn_t cxl_event_thread(int irq, void *id)
 {
 	struct cxl_dev_id *dev_id = id;
 	struct cxl_dev_state *cxlds = dev_id->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	u32 status;
+	u32 mask = CXLDEV_EVENT_STATUS_ALL;
+	int attempts = CXL_EVENT_DRAIN_ATTEMPTS;
+
+	while (mask) {
+		u32 status, drained, stuck;
+		int rc;
 
-	do {
 		/*
 		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
 		 * ignore the reserved upper 32 bits
 		 */
 		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
-		/* Ignore logs unknown to the driver */
-		status &= CXLDEV_EVENT_STATUS_ALL;
+		/* Ignore logs unknown to the driver, and logs given up on */
+		status &= mask;
 		if (!status)
 			break;
-		cxl_mem_get_event_records(mds, status);
+
+		rc = cxl_mem_get_event_records(mds, status, &drained);
+		if (rc) {
+			if (!cxl_event_drain_retryable(rc)) {
+				dev_warn(cxlds->dev,
+					 "Event log drain failed: %d\n", rc);
+				break;
+			}
+			if (--attempts) {
+				fsleep(1000);
+				continue;
+			}
+			dev_warn(cxlds->dev,
+				 "Event log drain gave up after %d attempts: %d\n",
+				 CXL_EVENT_DRAIN_ATTEMPTS, rc);
+			break;
+		}
+		/* Progress was made, so reset number of attempts */
+		attempts = CXL_EVENT_DRAIN_ATTEMPTS;
+
+		/*
+		 * The Event Status register is device owned and read only, so
+		 * it cannot bound this loop; records read can.  A device that
+		 * leaves a bit set with an empty log makes no progress, and
+		 * only the device can clear that state, so stop polling that
+		 * log rather than spin on it.
+		 */
+		stuck = status & ~drained;
+		if (stuck) {
+			dev_warn_once(cxlds->dev,
+				      "Event status %#x set with no records to read\n",
+				      stuck);
+			mask &= ~stuck;
+		}
 		cond_resched();
-	} while (status);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -682,7 +731,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
 
 	return 0;
 }
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index a7da279aa3ef..87e01612cea9 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -372,7 +372,7 @@ static void cxl_mock_event_trigger(struct device *dev)
 			event_reset_log(log);
 	}
 
-	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
+	cxl_mem_get_event_records(mdata->mds, mes->ev_status, NULL);
 }
 
 struct cxl_event_record_raw maint_needed = {
@@ -1805,7 +1805,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		dev_dbg(dev, "No CXL FWCTL setup\n");
 
-	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
 	cxl_mock_test_feat_init(mdata);
 
 	return 0;
-- 
2.43.0


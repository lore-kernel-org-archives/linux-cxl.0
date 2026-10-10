Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2E3A5452
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673061; cv=none; b=N0+q3h8GNCxSbuIOcPBj4mhDOmxsHdum3Ta5SV5F+NBuJJBTK9JovnYJ1enCQdqmCvZs+HnJ1zykwOr9qXxAEJliMPKp5MOYatqkrN0B9Ni5u4q/UASJfhFy4iNi4nEAcp8A8/ZSahnlkueLG1fcNq8zr1S1YE2NeK8s8i06dvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673061; c=relaxed/simple;
	bh=44qC5nP8900s19Eb1as3683DClkw8tBs8Pufs8xoVHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brvH7nLNlsI/gyDQjgNY2bpdv4mfHc9AJ0JBscPWoaQrFuEBndAlITU0QF/8c+z7JPZbLykaHnN3U1vF/4u3nGvlVV0lkOE/jSkT4AJ/67cTBYOzv9xc24HrMbvQb/5VUTojiIC2XVxGhe+aV0yw3JBbE8/0r3b1ONJBg2HpQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0a6FxhN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0a6FxhN"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc758830601so513609a12.2
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 15:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791673053; x=1792277853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bq0/3a7x3RT2jO913JFjenLkXdb6Sm/BzH7r7LLhwn4=;
        b=k0a6FxhN3Sd10O+1KrlOAdqRNIGPs2kNUr0KcSEfrcDKIfPj6rwTOlyI3YdLL/qHwJ
         LU5oDnT/1so/dMsoXTRq91+Ghc2DP6nZ0g7Avs5esgkxQkcoUBVNdWlSnlCD551Gr2G3
         Vi5YAPCcCYh/zu7PJA+1fMqYtkITUu5JbIxgwSY3PUqSbZSW4FqNCLx8/SUYPN+ySzlg
         V1mPYI/sp6Gkk9EqLQoJoLoul3xZVVrBCIZybAnx4Av7hefkHmkyqJmTR8yHuZVI4qMC
         lUdvE47ZpDAikrm5i0HbBabJWeTkI0fP+RTRnajMzS49DMv4Yl3UzRslOavt7Z2O4i16
         zxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673053; x=1792277853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bq0/3a7x3RT2jO913JFjenLkXdb6Sm/BzH7r7LLhwn4=;
        b=OcRDSn7zptvKpCw3dntsotiUdrddKYdUdZDtzJ+8yVMFgk5yH8ZCcr0tmTwd7jXq5h
         nIJS8O5Xd5BEe32WmhSZi3zrkzO544A8Fto+gSokoz2Db/G6nmdjr4AzeJr39ke3JrqN
         4epjVyrlC+K189earC5XKd+kJN32iKP2EhwWZR1nswcOIa6lYiiNEu9XbAJGgf/v38gD
         XI76NG/NcUKtFRYqf7MB7nPI00OSKxFylhGEpNlX6Ao1cPiwn/f84MAC4rho34v0OQGt
         40dq83aovjsYMH9py6VnkM8ht7bn95rw31p791McJkwHjjJjThzwf7mSlOWX4eLzdhpK
         D0qQ==
X-Gm-Message-State: AFq9FYLxUiyCWLuU0fgNrsW0nknWHw694g6wRwLMm9nb1suIGRVyXKGP
	w9GguMZ1gR7lhnjAWbX89M5YkAnUbRKt3Kapm1Xw5su9tr6WoKjLgukeR8Ftro63
X-Gm-Gg: AYBFou0iOtIhxzfu9945kPz+zjEu0FnIrvr3LeNBqNmTecwGHR8XoAWh0OuYo0xeAyh
	Ybly7CE8N66yRSPkkMaalZMpW6MDgAgGreXAKaSOeKLBeWcRQnHdNjIOYx/45e4Wlu1e3taqh1m
	MP6XpGY4oJIr1KGndGXKcVrNrdfkntzvESlXC2usZu5SkoRbAXKY2jvqQl2q+J5lXYC35QKCCli
	F2KJBSXDg8uWe3MxgkhxqRA82tKF1RjVE/MZbjeJOcSJWib/KoNJ992bWU1SVpD5OIX7+Qd1LJP
	b5ZHFzwp+dHxtSw0E7bqJ21RDZgAx+rQ4YbBMAnjKqL+axO4H37uhRMZLK9MaOAOcKMjB2gfqHX
	uP8Lu6PAUHGbw0U/5qS1DSefMvmpZzi+k4KYChSamLVuY8Q0r2Kh8qNWcCVFgqtxYOaJI+BQVrf
	Uyq+XmTE3nNlQxDJb0nioW0YMKWHTpOhWi6QQ4N9KwMuHcAu8mFC+FhiJuuZAyABDhxpWrWJid8
	8bPBD/Xe9V3DN2aMlxu1JhLvLGS
X-Received: by 2002:a05:6a20:b40a:b0:3e0:c334:52a0 with SMTP id adf61e73a8af0-3e16bed478emr4638208637.49.1791673052890;
        Sat, 10 Oct 2026 15:57:32 -0700 (PDT)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e07329sm2603662a12.5.2026.10.10.15.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:57:32 -0700 (PDT)
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
Subject: [PATCH v16 6/8] cxl/mem: Configure dynamic capacity interrupts
Date: Sun, 11 Oct 2026 07:54:57 +0900
Message-ID: <20261010225852.10727-7-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010225852.10727-1-anisa.su@samsung.com>
References: <20261010225852.10727-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Dynamic Capacity Devices (DCD) support extent change notifications
through the event log mechanism. The interrupt mailbox commands were
extended in CXL 3.1 to support these notifications. Firmware can't
configure DCD events to be FW controlled but can retain control of
memory events.

Configure DCD event log interrupts on devices supporting dynamic
capacity. Disable DCD if interrupts are not supported.

The DCD event log is not drained here. cxl_event_drain_mask() reports
only the logs the driver can service, and the DCD bit is added by
the patch introducing DCD event handling. Until then a DCD interrupt
wakes the event thread, which finds no log it owns and returns.

Care is taken to preserve the interrupt policy set by the FW if FW first
has been selected by the BIOS.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Co-developed-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>

---
Changes:
1. When the DCD vector cannot be requested, clear dcd_settings on the
   device with Set Event Interrupt Policy as well as disabling DCD on
   the host, so the device does not keep signalling a vector with no
   handler.  The Set Event Interrupt Policy command moves out of
   cxl_event_config_msgnums() into a new helper,
   cxl_event_set_int_policy(), so cxl_irqsetup() can issue it too.
   [Richard]
---
 drivers/cxl/cxl.h            |  14 ++-
 drivers/cxl/cxlmem.h         |   2 +
 drivers/cxl/pci.c            | 174 +++++++++++++++++++++++++++++------
 tools/testing/cxl/test/mem.c |   2 +-
 4 files changed, 156 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cab8ce39f465..15356d25369d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -192,11 +192,15 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
 #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
 #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
-
-#define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
-				 CXLDEV_EVENT_STATUS_WARN |	\
-				 CXLDEV_EVENT_STATUS_FAIL |	\
-				 CXLDEV_EVENT_STATUS_FATAL)
+#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
+/*
+ * Logs whose ownership follows native_cxl_error; the DCD log is always
+ * OS owned.
+ */
+#define CXLDEV_EVENT_STATUS_STANDARD_LOGS	(CXLDEV_EVENT_STATUS_INFO | \
+						 CXLDEV_EVENT_STATUS_WARN | \
+						 CXLDEV_EVENT_STATUS_FAIL | \
+						 CXLDEV_EVENT_STATUS_FATAL)
 
 /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
 #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index b539b5a5c829..bac7e1ac715f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -240,7 +240,9 @@ struct cxl_event_interrupt_policy {
 	u8 warn_settings;
 	u8 failure_settings;
 	u8 fatal_settings;
+	u8 dcd_settings;
 } __packed;
+#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
 
 /**
  * struct cxl_event_state - Event log driver state
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7b754af2168d..1d94e9ebb1a2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -510,11 +510,22 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
 	return true;
 }
 
+/* Event logs the driver drains: standard logs when native_cxl */
+static u32 cxl_event_drain_mask(struct pci_host_bridge *host_bridge)
+{
+	if (host_bridge->native_cxl_error)
+		return CXLDEV_EVENT_STATUS_STANDARD_LOGS;
+	return 0;
+}
+
 static irqreturn_t cxl_event_thread(int irq, void *id)
 {
 	struct cxl_dev_id *dev_id = id;
 	struct cxl_dev_state *cxlds = dev_id->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct pci_host_bridge *host_bridge =
+		pci_find_host_bridge(to_pci_dev(cxlds->dev)->bus);
+	u32 mask = cxl_event_drain_mask(host_bridge);
 	u32 status;
 
 	do {
@@ -523,8 +534,8 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 		 * ignore the reserved upper 32 bits
 		 */
 		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
-		/* Ignore logs unknown to the driver */
-		status &= CXLDEV_EVENT_STATUS_ALL;
+		/* Ignore logs unknown to the driver or owned by BIOS */
+		status &= mask;
 		if (!status)
 			break;
 		cxl_mem_get_event_records(mds, status);
@@ -551,53 +562,81 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
 }
 
 static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
-				    struct cxl_event_interrupt_policy *policy)
+				    struct cxl_event_interrupt_policy *policy,
+				    size_t *policy_size)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd = {
 		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
 		.payload_out = policy,
 		.size_out = sizeof(*policy),
+		/* CXL 2.0 firmware omits dcd_settings; accept the shorter reply */
+		.min_out = CXL_EVENT_INT_POLICY_BASE_SIZE,
 	};
 	int rc;
 
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
-	if (rc < 0)
+	if (rc < 0) {
 		dev_err(mds->cxlds.dev,
 			"Failed to get event interrupt policy : %d", rc);
+		return rc;
+	}
 
+	if (policy_size)
+		*policy_size = mbox_cmd.size_out;
 	return rc;
 }
 
-static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
-				    struct cxl_event_interrupt_policy *policy)
+static int cxl_event_set_int_policy(struct cxl_memdev_state *mds,
+				    struct cxl_event_interrupt_policy *policy,
+				    size_t policy_size)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-	struct cxl_mbox_cmd mbox_cmd;
-	int rc;
-
-	*policy = (struct cxl_event_interrupt_policy) {
-		.info_settings = CXL_INT_MSI_MSIX,
-		.warn_settings = CXL_INT_MSI_MSIX,
-		.failure_settings = CXL_INT_MSI_MSIX,
-		.fatal_settings = CXL_INT_MSI_MSIX,
-	};
-
-	mbox_cmd = (struct cxl_mbox_cmd) {
+	struct cxl_mbox_cmd mbox_cmd = {
 		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
 		.payload_in = policy,
-		.size_in = sizeof(*policy),
+		.size_in = policy_size,
 	};
+	int rc;
 
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
-	if (rc < 0) {
+	if (rc < 0)
 		dev_err(mds->cxlds.dev, "Failed to set event interrupt policy : %d",
 			rc);
-		return rc;
+	return rc;
+}
+
+static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
+				    struct cxl_event_interrupt_policy *policy,
+				    bool native_cxl, size_t policy_size)
+{
+	int rc;
+
+	/* memory event policy is left if FW has control */
+	if (native_cxl) {
+		*policy = (struct cxl_event_interrupt_policy) {
+			.info_settings = CXL_INT_MSI_MSIX,
+			.warn_settings = CXL_INT_MSI_MSIX,
+			.failure_settings = CXL_INT_MSI_MSIX,
+			.fatal_settings = CXL_INT_MSI_MSIX,
+			.dcd_settings = 0,
+		};
 	}
 
+	/*
+	 * A CXL 3.0+ device can carry dcd_settings field without DCD command
+	 * support, so size the request by the device's policy_size and only
+	 * enable the DCD interrupt when DCD commands are supported.
+	 */
+	if (cxl_dcd_supported(mds))
+		policy->dcd_settings = CXL_INT_MSI_MSIX;
+
+	rc = cxl_event_set_int_policy(mds, policy, policy_size);
+	if (rc)
+		return rc;
+
 	/* Retrieve final interrupt settings */
-	return cxl_event_get_int_policy(mds, policy);
+	return cxl_event_get_int_policy(mds, policy, NULL);
 }
 
 static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
@@ -633,6 +672,37 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
 	return 0;
 }
 
+static int cxl_irqsetup(struct cxl_memdev_state *mds,
+			struct cxl_event_interrupt_policy *policy,
+			bool native_cxl, size_t policy_size)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	int rc;
+
+	if (native_cxl) {
+		rc = cxl_event_irqsetup(mds, policy);
+		if (rc)
+			return rc;
+	}
+
+	if (cxl_dcd_supported(mds)) {
+		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
+		if (rc) {
+			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
+			cxl_disable_dcd(mds);
+			/* No handler will service the DCD vector; tell the device */
+			policy->dcd_settings = CXL_INT_NONE;
+			rc = cxl_event_set_int_policy(mds, policy, policy_size);
+			if (rc)
+				dev_warn(cxlds->dev,
+					 "DCD disabled but its interrupt policy could not be cleared: %d\n",
+					 rc);
+		}
+	}
+
+	return 0;
+}
+
 static bool cxl_event_int_is_fw(u8 setting)
 {
 	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
@@ -651,46 +721,90 @@ static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
-	struct cxl_event_interrupt_policy policy;
+	struct cxl_event_interrupt_policy policy = { 0 };
+	bool native_cxl = host_bridge->native_cxl_error;
+	size_t policy_size;
+	u32 mask;
 	int rc;
 
 	/*
 	 * When BIOS maintains CXL error reporting control, it will process
 	 * event records.  Only one agent can do so.
+	 *
+	 * If BIOS has control of events and DCD is not supported skip event
+	 * configuration.
 	 */
-	if (!host_bridge->native_cxl_error)
+	if (!native_cxl && !cxl_dcd_supported(mds))
 		return 0;
 
 	if (!irq_avail) {
 		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
+		if (cxl_dcd_supported(mds)) {
+			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
+			cxl_disable_dcd(mds);
+		}
 		return 0;
 	}
 
-	rc = cxl_event_get_int_policy(mds, &policy);
+	rc = cxl_event_get_int_policy(mds, &policy, &policy_size);
 	if (rc)
-		return rc;
+		goto err;
+
+	/*
+	 * dcd_settings cannot be sent to a device whose policy is too short
+	 * to hold it, so the device would never accept the setting
+	 * cxl_irqsetup() arms the DCD interrupt with.
+	 */
+	if (cxl_dcd_supported(mds) && policy_size < sizeof(policy)) {
+		dev_warn(mds->cxlds.dev,
+			 "DCD supported but interrupt policy is only %zu bytes\n",
+			 policy_size);
+		cxl_disable_dcd(mds);
+		/* DCD was the only reason to be here */
+		if (!native_cxl)
+			return 0;
+	}
 
-	if (cxl_event_fw_owns_mem_logs(&policy)) {
+	if (native_cxl && cxl_event_fw_owns_mem_logs(&policy)) {
 		dev_err(mds->cxlds.dev,
 			"FW still in control of Event Logs despite _OSC settings\n");
 		return -EBUSY;
 	}
 
-	rc = cxl_event_config_msgnums(mds, &policy);
+	rc = cxl_event_config_msgnums(mds, &policy, native_cxl, policy_size);
 	if (rc)
-		return rc;
+		goto err;
 
 	rc = cxl_mem_alloc_event_buf(mds);
 	if (rc)
 		return rc;
 
-	rc = cxl_event_irqsetup(mds, &policy);
+	rc = cxl_irqsetup(mds, &policy, native_cxl, policy_size);
 	if (rc)
 		return rc;
 
-	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	mask = cxl_event_drain_mask(host_bridge);
+	if (mask)
+		cxl_mem_get_event_records(mds, mask);
+
+	dev_dbg(mds->cxlds.dev, "Event config : %s DCD %s\n",
+		native_cxl ? "OS" : "BIOS",
+		cxl_dcd_supported(mds) ? "supported" : "not supported");
 
 	return 0;
+
+err:
+	/*
+	 * Failed to Get/Set interrupt policy for DCD while BIOS owns the
+	 * other logs. Disable DCD and continue.
+	 */
+	if (!native_cxl) {
+		dev_warn(mds->cxlds.dev,
+			 "Event interrupt policy failed (%d), disabling DCD\n", rc);
+		cxl_disable_dcd(mds);
+		return 0;
+	}
+	return rc;
 }
 
 static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 7b756000a1a6..c740372bdaaa 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1818,7 +1818,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		dev_dbg(dev, "No CXL FWCTL setup\n");
 
-	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_STANDARD_LOGS);
 	cxl_mock_test_feat_init(mdata);
 
 	return 0;
-- 
2.43.0


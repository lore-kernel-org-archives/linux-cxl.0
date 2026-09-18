Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585E525A8B
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763503; cv=none; b=Wn+bkEEs4FC7xZGWctoLMpZabZPGb+xrLtFotvJ3/tHfY3ToP0W4KHxMVHZLZ05Dt26kYoalZ/7NlPBAaspT3GH7a3ufJoyKJD7eZlKkEke18HxiAxoSyMStdwEIuKSfA0TXvpQdKMTwIVeYwQvpDGuHgW1krk2b2aTpQxSPrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763503; c=relaxed/simple;
	bh=1evPeSCOd4bSIBrgWW1pZ82Af5IlL9qMmKl+CvsXavk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKH/900UDVvdl5MAR+5z5T+VUUQCsO2sLwolR7Hnx39UTCSOrkWZoZnyT3zgjNJB1tESrf178bvTf4JR+/5Vh4McpJ0BpiDj1L0QYM3/qlAT/JXL/aZC/6tXDB0Fga+fG4WJN2Syk/N8/gJ/xHLTFcI1R3Tr8VN3A7GjD0O2iQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHdQxgny; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHdQxgny"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso1142448d50.3
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789763500; x=1790368300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGasYBWaCJuST96Ucfr9a/kdAnpMKB2xXHoIWvC8wmk=;
        b=FHdQxgny45P9cnpatByiJZH1xGZVjPTnrcA1jA6bm91TS/7QgNSJclzKg25N8Uf62w
         R9WBQFOUd56ppv/TT20kxS1cPOrlDWBWFHuaKXAq8WKuEfRkSO1rzqU5bn47IRZC6FrN
         uzM2fmMl1a6spYzM27E5SEX5tRGa0AcRWSgYfNpTyCsDk92vwbC7ukIqzdcT0DFncWnu
         WMDmK4+FJJlQGFRcVczm/P4NDKXiTkCBKcY0Pvw+Tq1Y0ek0VnJa/mHHYBadkW9p23k+
         CpEFwFiCH+Mu1IP/NJA9hANssB5R43BR4Pp+0oE1nUfLz0Ba6dK382esjWGv9zwk8wd4
         eSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763500; x=1790368300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGasYBWaCJuST96Ucfr9a/kdAnpMKB2xXHoIWvC8wmk=;
        b=A57Wg1QckqFHWywmzu7K64emmH24KdLdjD+KmF1Ae8v09lIuk5boQT/pZmFEaEdiIA
         DvTBOw+I5t46iJnWTGvkHJRXrpwlhMoIxrLGOXl1CGVQBRYaNt1jcB+4ZXNTIe9w8BAZ
         YTJnx4lnNsQPT7jRzsrkp2vqhz4+z58jnXpCTuNaDKRIJ7OGO4CUoAOu20gj6YBBmO+z
         TKp1++Zrdo6eLDuV96ykbFoRs9bdoCPK303oK1aNSyoGVnzkuGL9x56WIoDWmPaNA0m4
         H5aY39N1FUj4bW9cmG95EUyAdANQxYuV0blBqDE+SGDTdM0P+6bbA+tRkOhVGAJjddpH
         imRw==
X-Gm-Message-State: AFuF++k/9HbdsSHFs8RcY9vWnjwXgn+gdzhoQUdQJSReavhSx2UKEMHL
	osCcdLz6iCl+i9nsiq/HlLN614C5gt1Fn+YsmLBbQUFsLJEduX5sWZP5abEJag==
X-Gm-Gg: AYBFou3rLjUGFTUxLICllzty+N+5fPg0I+AdAwCChUrugpDBq7/2vPRQGe4I5rqW8NG
	MQpR2j1YPbaKsw0UEshMxXR94KQz8tySlwdh+EO+i3vNR80vfGnI/G451lnlfRayFrKg6PVSxUv
	Ox/LCLDu5RC8WP26JIf5ydWhmfqRZRXR6knAcy2dPyjgpK/FKgqwsXF79EU2oNzL/i1i+7Q6DrL
	2YH2s7pIl+JoUHZKlk/9Q+g4GE96c1t4M2L8XzLiBY0RDqPnZO2pCttv0CXXg6eEEi5zkwXCL2w
	R+ztAlsdyRjiJiCNK4h94JGDLisail25t0ulomb1O+LkD2ocUii6WnY4jhjOOcv//pyfLlJ3b8D
	2ILGO7ALVqgHDx+p3gml1dEeCNXn+HuXjTTBAr6HdOkkajZPMDrTkXLm0YMnzG6+zjyM7sVx+uv
	J+4k77VqWWNMO6kC6XBLO/YInqstvGkTgVEKan+cAyDcO9XQ7SvHA4qG4h4eO6Wg+LdazIU0R80
	qHVkkwfiyOVcU1EgLzt3OleE1wuorzw0I1FZK+gOaer+WIF9w==
X-Received: by 2002:a05:690e:e88:b0:670:ff3d:e71a with SMTP id 956f58d0204a3-6717fdf0ccdmr1356995d50.76.1789763499620;
        Fri, 18 Sep 2026 13:31:39 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64b74sm427240d50.1.2026.09.18.13.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:31:39 -0700 (PDT)
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
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: [PATCH v14 6/8] cxl/mem: Configure dynamic capacity interrupts
Date: Fri, 18 Sep 2026 13:30:15 -0700
Message-ID: <20260918203049.7273-7-anisa.su@samsung.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
Changes:

1. [jonathan]: get rid of CXL_EVENT_STATUS_ALL and instead opt into
   event logs we want to read individually in cxl_event_drain_mask. This
   makes which logs the driver drains explicit if new logs are added in
   the future. The cxl_test mock names the same four logs for its
   probe-time drain.
2. pci.c: when BIOS owns the memory event logs and a short interrupt
   policy has just disabled DCD, return before Set Event Interrupt
   Policy and the event buffer allocation. Nothing is left to configure,
   and the Set would only have echoed firmware's own settings back.
---
 drivers/cxl/cxl.h            |   6 +-
 drivers/cxl/cxlmem.h         |   2 +
 drivers/cxl/pci.c            | 127 +++++++++++++++++++++++++++++------
 tools/testing/cxl/test/mem.c |   5 +-
 4 files changed, 114 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cab8ce39f465..1add114bc178 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -192,11 +192,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
 #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
 #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
-
-#define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
-				 CXLDEV_EVENT_STATUS_WARN |	\
-				 CXLDEV_EVENT_STATUS_FAIL |	\
-				 CXLDEV_EVENT_STATUS_FATAL)
+#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
 
 /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
 #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9fd5af2e41d4..9106affd7c81 100644
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
index 7b754af2168d..fee3a704b73b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -510,11 +510,23 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
 	return true;
 }
 
+/* Event logs the driver drains: standard logs when native_cxl */
+static u32 cxl_event_drain_mask(struct pci_host_bridge *host_bridge)
+{
+	if (host_bridge->native_cxl_error)
+		return CXLDEV_EVENT_STATUS_INFO | CXLDEV_EVENT_STATUS_WARN |
+		       CXLDEV_EVENT_STATUS_FAIL | CXLDEV_EVENT_STATUS_FATAL;
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
@@ -523,8 +535,8 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
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
@@ -551,42 +563,62 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
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
 
 static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
-				    struct cxl_event_interrupt_policy *policy)
+				    struct cxl_event_interrupt_policy *policy,
+				    bool native_cxl, size_t policy_size)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
-	*policy = (struct cxl_event_interrupt_policy) {
-		.info_settings = CXL_INT_MSI_MSIX,
-		.warn_settings = CXL_INT_MSI_MSIX,
-		.failure_settings = CXL_INT_MSI_MSIX,
-		.fatal_settings = CXL_INT_MSI_MSIX,
-	};
+	/* memory event policy is left if FW has control */
+	if (native_cxl) {
+		*policy = (struct cxl_event_interrupt_policy) {
+			.info_settings = CXL_INT_MSI_MSIX,
+			.warn_settings = CXL_INT_MSI_MSIX,
+			.failure_settings = CXL_INT_MSI_MSIX,
+			.fatal_settings = CXL_INT_MSI_MSIX,
+			.dcd_settings = 0,
+		};
+	}
+
+	/*
+	 * A CXL 3.0+ device can carry dcd_settings field without DCD command
+	 * support, so size the request by the device's policy_size and only
+	 * enable the DCD interrupt when DCD commands are supported.
+	 */
+	if (cxl_dcd_supported(mds))
+		policy->dcd_settings = CXL_INT_MSI_MSIX;
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
 		.payload_in = policy,
-		.size_in = sizeof(*policy),
+		.size_in = policy_size,
 	};
 
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
@@ -597,7 +629,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 	}
 
 	/* Retrieve final interrupt settings */
-	return cxl_event_get_int_policy(mds, policy);
+	return cxl_event_get_int_policy(mds, policy, NULL);
 }
 
 static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
@@ -633,6 +665,30 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
 	return 0;
 }
 
+static int cxl_irqsetup(struct cxl_memdev_state *mds,
+			struct cxl_event_interrupt_policy *policy,
+			bool native_cxl)
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
+		}
+	}
+
+	return 0;
+}
+
 static bool cxl_event_int_is_fw(u8 setting)
 {
 	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
@@ -651,32 +707,57 @@ static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy
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
 		return rc;
 
-	if (cxl_event_fw_owns_mem_logs(&policy)) {
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
+
+	if (native_cxl && cxl_event_fw_owns_mem_logs(&policy)) {
 		dev_err(mds->cxlds.dev,
 			"FW still in control of Event Logs despite _OSC settings\n");
 		return -EBUSY;
 	}
 
-	rc = cxl_event_config_msgnums(mds, &policy);
+	rc = cxl_event_config_msgnums(mds, &policy, native_cxl, policy_size);
 	if (rc)
 		return rc;
 
@@ -684,11 +765,17 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	rc = cxl_event_irqsetup(mds, &policy);
+	rc = cxl_irqsetup(mds, &policy, native_cxl);
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
 }
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 7b756000a1a6..6ef47265da10 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1818,7 +1818,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		dev_dbg(dev, "No CXL FWCTL setup\n");
 
-	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_INFO |
+				       CXLDEV_EVENT_STATUS_WARN |
+				       CXLDEV_EVENT_STATUS_FAIL |
+				       CXLDEV_EVENT_STATUS_FATAL);
 	cxl_mock_test_feat_init(mdata);
 
 	return 0;
-- 
2.43.0


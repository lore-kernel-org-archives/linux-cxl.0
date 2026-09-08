Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6F4AE8D3
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862945; cv=none; b=iornRehBmDhZ6rX1hq2z2pZNrQLYV0N7B1RPvssRCg8a2u6XZwmZEG1og75nk3arL1nNztefj8S3u2efrApJPtMWx42AQ41EZBcQ/YjvPByrtklvFKokBbiRKYowsER8nfPp0VflJby5TBrGEFdHjVDyPUxzUMWpC2vO6rIeAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862945; c=relaxed/simple;
	bh=UvdQP3c/ARZ20G+mFCOy+Gmt5ZQHqggRgnEkTTYa9SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGc3c40nrpj4c5ERLHjW2/yGvrp1KfC3dObDZ251AHXmVQUammex4PvPUUvF6zPQuQtoBw5YPteqV/dS7nQrVLjrm+P61uiJwmI4pXONwotOo/gkoR2K/FqgCF9OsIaVlOF4mTUKeFADZXfWQ5rhCBblKqYoVVhXl6ZyUtYfz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug1hq2Vq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug1hq2Vq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d9520b9155so36634055ad.3
        for <linux-cxl@vger.kernel.org>; Tue, 08 Sep 2026 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788862943; x=1789467743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGOhp22FQLajuYbGxHui4MWl8xEkUHPxunJm0oTUVh0=;
        b=Ug1hq2VqB/7Ao9blK2n4htdJAvaR7IGE2tbti5VDyBplLJHwrIEKS/R7HX9cD+7aP/
         6wp0o36279AftVpdUGMQG3li833JcG/96kX/uk+oCp+AtOFgKv7nO/1w84oVeni1HNf4
         6sL50iSPQOSWie7nGbiqtt77oaV8GQl367EhuFLm02c8BnTxbjMjmZOU89yf+ZKRQ5E8
         Doa7e6A9JfezXxrXlHR0nhdcPFl5zf+As8f3L2izcIL4KETPz8Q1xYAlB9C67zCFQkr3
         C5Vcl00Zjg/8TLPjhL6cnlkAWC87xZ8+qKk+D49L4jzNaETC2atjOXRGsQhzm5PYcJcY
         Yi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862943; x=1789467743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGOhp22FQLajuYbGxHui4MWl8xEkUHPxunJm0oTUVh0=;
        b=e9xPnooGdPmJ0GktlmSHr0ZuECbiGHg65f+ANrahcuA4jAw/prYF7miV1yV59hq+Vn
         dt339UZsbSZaVkKmUlP1A+61qDSExtv2oZo6C+6A/k8dc1PIKSgOLQK7RZz9FjHZ/Sca
         1AEShVRlpdm2rRl1YVcjCF+Y2wQERwj0/pAMmRwUOYrQhcgNMQrlmrf7C80dfi7Gu+Ty
         D2tRuU+1Gq1Ci7nhevqaG4dBRNQ7aQjy9EpU1nbWfX9mNEPbItdmys+5aJ+xXBDwdZ2i
         m0vLMhRIFQQd8kigTburwa3zXMPoDvXXXuBrByvj6skO/wlQzSwSzSChU1Tw/d/R3ScT
         Fh0A==
X-Gm-Message-State: AFuF++m1DGz7mx9UFPK2+yQzAm+tZqMi9tZU5ClhsIrWBuZzKnvkWGrL
	07RZcd+agNJ5fjG973+HIZkEHEFyqZulPal57DATQnCuoG4y2ctdudUaGsuORA==
X-Gm-Gg: AYBFou2H8XdlHNOH+jKldWzEJo9KPBdwc2UJr4QaULxy5ds+xLZqa+ctkuE+kCuF88L
	NZFOHJAvNpe6es0wo30vXBYaQKoYz4zY/J8WNW5WfjqAdB2mwENX6AdITn3fjYhXiDUYQZNU5md
	0K6BT9xi95pF7ZMvWuOwty+Fu9mcGdrKRsH414G6YuWoMTqcP8Ur5skKVdtNvjraJTvQvjzCQp4
	F3N+mT0ACpp0f+70xT/fu2hA4A5F2+R+RR/vTZiKVoVTQKxpFW+rm5Fa4JVOksxzjyW1FnlH85t
	U7yB8lyWYm8ax9Sk4gBO44sh/xkyd4QyWIPeayjY7583ggUFgzoconMPwqfpsOLjhfoQxXOyoR1
	PCVNtKdKro173Ynsu8QW5xu8aUwsyajkn2sDP3iWgFHknqe0qguyDTNZMJT9Tke8E2naCMZ5rP3
	zFaai1ubmW8KhTXopkVEbIlsc9e/1V4f5xBhVzXt3BZB1clLWKlRkTuxGqJNmIbstVw+40gIaKV
	sdz4PqslC6n/DmdAlMn1s9AYYdVG1dVcKYLG53gtIBYCjPNpYESiSjug035izf4twICQTj1dnmB
X-Received: by 2002:a17:90b:5344:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-39b261e0f14mr42691798a91.15.1788862943216;
        Tue, 08 Sep 2026 03:22:23 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3396e7e477csm3435658eec.29.2026.09.08.03.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:22:22 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	jic23@kernel.org,
	dave.jiang@intel.com,
	gourry@gourry.net,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	vishal.l.verma@intel.com,
	dave@stgolabs.net,
	benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>,
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: [RESEND PATCH v13 6/8] cxl/mem: Configure dynamic capacity interrupts
Date: Tue,  8 Sep 2026 03:15:10 -0700
Message-ID: <20260908102124.2231730-8-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908102124.2231730-2-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
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
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>

---
Changes:
1. pci.c: disable DCD when the device supports the DCD commands but its
   interrupt policy is too short to carry dcd_settings. The Set is sized
   by the device's own policy length, so on a short policy dcd_settings
   is never sent, and the re-read afterwards leaves the driver's own
   value in the struct because the device does not return that byte.
   cxl_irqsetup() would then arm the DCD interrupt from a setting the
   device never accepted. A conforming device cannot be in that state,
   DCD is CXL 3.x and a 3.x policy carries the field, but nothing tied
   the two facts together. Reported by Alison Schofield.

2. pci.c: move the DCD bit out of cxl_event_drain_mask(), dropping the
   mds argument it no longer needs, so the bit lands with the code that
   drains the log as described above.  Requested by Alison Schofield.
---
 drivers/cxl/cxl.h    |   4 +-
 drivers/cxl/cxlmem.h |   2 +
 drivers/cxl/pci.c    | 124 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 109 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cab8ce39f465..d6e02bd0cf50 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -192,11 +192,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
 #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
 #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
+#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
 
 #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
 				 CXLDEV_EVENT_STATUS_WARN |	\
 				 CXLDEV_EVENT_STATUS_FAIL |	\
-				 CXLDEV_EVENT_STATUS_FATAL)
+				 CXLDEV_EVENT_STATUS_FATAL |	\
+				 CXLDEV_EVENT_STATUS_DCD)
 
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
index 7b754af2168d..1ea505b1f40e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -510,11 +510,23 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
 	return true;
 }
 
+/* Event logs the driver drains: standard logs when native_cxl */
+static u32 cxl_event_drain_mask(struct pci_host_bridge *host_bridge)
+{
+	if (host_bridge->native_cxl_error)
+		return CXLDEV_EVENT_STATUS_ALL & ~CXLDEV_EVENT_STATUS_DCD;
+
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
@@ -651,32 +707,54 @@ static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy
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
 
@@ -684,11 +762,17 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
-- 
2.43.0


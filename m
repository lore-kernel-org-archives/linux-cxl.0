Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB9385D7E
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529438; cv=none; b=XS9WVwXTGa6qja0BMEPyFbb3S9TLC81mlLfBAiiOLVVkT93XrSHN9QoPd3djEzaVoabdzMPrNN5RQAS2hmrhlGI/tSQ/fzHitbvM484cg1814j+Z1GzvZtxCp6kSqRvPoZAWe+UYlTnccJTQeobfokG0rbUpSPm43Ndf59H8WZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529438; c=relaxed/simple;
	bh=WdPnNZdBMfPNVkxZQcUkvrepHszswdE8ldfahIBUbPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSn5sn7GWWMy1jX7taYlqKHLkM0O2YeOknX+0EgFShFJ1G2ZoffrEVWBJBmQqn5EXT/4SEyT7cQaUnEX/4KG4pLJbuU7eZhP3cglwdsNcveoHvjeMOVfL/e8ANLAteoRRVrwUxmpMmsgaWMsTvV7yP0weyY4oiyWcDcCXIcXJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaUZzPlC; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaUZzPlC"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-132830d8281so2577268c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529435; x=1780134235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drGooomvIKHMHD9aQDfS7/igAqAzAvEceRuTEAEvyv8=;
        b=IaUZzPlC3yvqSx7EJcmUaz6UY621MICdFUzcDAscnW1BfYKhbnF7VIcZI0bAzQZRLQ
         GEDhhFcuapnFfThVxkh4uo25TlAkaPGMlJAA6Qfk9z44kRHiUea3aZynCTrIGWKwqtN1
         iGZPKJGVlMGUGqg3lHejEf34XUOzIuDQJm8p1Az2ama5SMReKDYgeaomldsSP1syjTbI
         yhUY2UTJj4RDhaFWb+PRNMzoBpgsdUR6Yasd9D2/VFrKKv/DXRDccq0QDr4NQ2MzIdh7
         /iv9ncHUPqrvmw/mS9TO/evtDrCH7N7xB8o/vzY4Ur7whvEUJ2qFgLLtV1UF+ubMXKyy
         zXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529435; x=1780134235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=drGooomvIKHMHD9aQDfS7/igAqAzAvEceRuTEAEvyv8=;
        b=oE0xAqlUwnqeXkRzqCAhCVY0akrcz/aNiCBo9mMKZ2v0Sh+11yjOuHWtSWNasuW5dw
         MPAn32FIU6InTfeAe/8CTXxHOxeUKSbqQ4bgK311+ywz2xJtCK5OtSiejiLwIvYvqMg1
         oQ4LoF8oo60dccZhAW/ezU94pdTgOFC/ZIqDlkIqg6xFRH+4FberjKU2Bz5xyybPrWGe
         C82Nsygama7aAWBOBQQZyA/uI5LTaOtX4jBsgxp6KbqdrHAVnYgUqpmbzLWo4JRXi0hN
         A5Yj45fV29/LnrLjTGs/1yQrmVxUDKrzaECKnQTzmONoZhvHnK4TmG5NG42FSFjSvq5J
         9Dpw==
X-Gm-Message-State: AOJu0Yz4AeKG3jL0KbEN7Xe32SfuKtpJrLvSzRc8wWizTYHiGsR4McQO
	ANCXN7ED2UtopnWeT8tbtfULTOfcoufm8WLkfK+JENUC6mFPhxqF1/JjgheYGQ==
X-Gm-Gg: Acq92OHciTQa9jH8jweYZojqrrQlvy8Nn+1EgnVyuTWc7uXgPtJj15QCLJaOBUhnlYE
	Vpbrj1pblt22/FS5cgWIXVc/o90RSkv/RUvnV66wGxRFL5XYJL3AZbcPuTVE7+otL0KbEzzGN6x
	MJahFDlejanmX4HAg68blrdG5j2rttjPOE3a24jGo4AryiTQDfXhfeoBHYfIQFLGU0UqqwltCww
	ZKXUk/BpyomrVxPwA4crWWngLUmAjQjcHXtiDoFfG8DsJjMjfswLxq0UaGyK0Xxum4ha2m1S1PZ
	vVafSem1a2g+2m4va0aEAz1OtSYhouSWEnZr5eyN206rqHDPl+K82/MCe5QlH304UjHaIXFbeRI
	xKqqMTticRDRe5HK/DyK7k+j0DFidBmvF2qXLi2v4LgBKFESEmGV/eTtvIgmWMwyAs4ple8FNhD
	7HVlO+uO8fja9ry5t7o8HImoQAjz/SQbb6XiRGFykZUb3xt9AfOlxk9WgoW13HPFLGaicnhhead
	zAEnkA=
X-Received: by 2002:a05:7022:511:b0:134:d708:1a24 with SMTP id a92af1059eb24-1365f8161bemr2409921c88.17.1779529434676;
        Sat, 23 May 2026 02:43:54 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:43:54 -0700 (PDT)
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
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v10 10/31] cxl/mem: Configure dynamic capacity interrupts
Date: Sat, 23 May 2026 02:43:04 -0700
Message-ID: <7f2e4fe385415e0b77b58f4bd988bc5895557dcf.1779528761.git.anisa.su@samsung.com>
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

Dynamic Capacity Devices (DCD) support extent change notifications
through the event log mechanism.  The interrupt mailbox commands were
extended in CXL 3.1 to support these notifications.  Firmware can't
configure DCD events to be FW controlled but can retain control of
memory events.

Configure DCD event log interrupts on devices supporting dynamic
capacity.  Disable DCD if interrupts are not supported.

Care is taken to preserve the interrupt policy set by the FW if FW first
has been selected by the BIOS.

Accept the 4-byte CXL 2.0 reply on GET Event Interrupt Policy by setting
min_out to CXL_EVENT_INT_POLICY_BASE_SIZE; pre-CXL 3.1 firmware omits
dcd_settings and would otherwise fail the size check.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
[anisa: rebase]
[anisa: accept 4-byte CXL 2.0 GET reply via min_out]
[anisa: drop Reviewed-by tags now that the patch carries new changes]
---
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/pci.c    | 75 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 10175ca3b7ee..65c009b02da6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -218,7 +218,9 @@ struct cxl_event_interrupt_policy {
 	u8 warn_settings;
 	u8 failure_settings;
 	u8 fatal_settings;
+	u8 dcd_settings;
 } __packed;
+#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
 
 /**
  * struct cxl_event_state - Event log driver state
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8d12c684d670..83617439bbd3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -557,6 +557,8 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
 		.payload_out = policy,
 		.size_out = sizeof(*policy),
+		/* CXL 2.0 firmware omits dcd_settings; accept the shorter reply */
+		.min_out = CXL_EVENT_INT_POLICY_BASE_SIZE,
 	};
 	int rc;
 
@@ -569,23 +571,34 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 }
 
 static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
-				    struct cxl_event_interrupt_policy *policy)
+				    struct cxl_event_interrupt_policy *policy,
+				    bool native_cxl)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	size_t size_in = CXL_EVENT_INT_POLICY_BASE_SIZE;
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
+	if (cxl_dcd_supported(mds)) {
+		policy->dcd_settings = CXL_INT_MSI_MSIX;
+		size_in += sizeof(policy->dcd_settings);
+	}
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
 		.payload_in = policy,
-		.size_in = sizeof(*policy),
+		.size_in = size_in,
 	};
 
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
@@ -632,6 +645,30 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
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
@@ -657,18 +694,26 @@ static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
-	struct cxl_event_interrupt_policy policy;
+	struct cxl_event_interrupt_policy policy = { 0 };
+	bool native_cxl = host_bridge->native_cxl_error;
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
 
@@ -676,10 +721,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	if (!cxl_event_validate_mem_policy(mds, &policy))
+	if (native_cxl && !cxl_event_validate_mem_policy(mds, &policy))
 		return -EBUSY;
 
-	rc = cxl_event_config_msgnums(mds, &policy);
+	rc = cxl_event_config_msgnums(mds, &policy, native_cxl);
 	if (rc)
 		return rc;
 
@@ -687,12 +732,16 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	rc = cxl_event_irqsetup(mds, &policy);
+	rc = cxl_irqsetup(mds, &policy, native_cxl);
 	if (rc)
 		return rc;
 
 	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
 
+	dev_dbg(mds->cxlds.dev, "Event config : %s DCD %s\n",
+		native_cxl ? "OS" : "BIOS",
+		cxl_dcd_supported(mds) ? "supported" : "not supported");
+
 	return 0;
 }
 
-- 
2.43.0


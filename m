Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A4271471
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871642; cv=none; b=FnQDSlZdmqGcakHnPT9I+snrMbTLO0ODu2Z+D9jsg1zBAGYrwyqO2PFHPOpsDKE73mTBCk2rlPQmTPC33hJnAqvVmts5jrE8cb//Gt3iFKvZD7IxzZz0/RQwVvCAm/1ZAc2XZIpJ7IUxMfhUhyiMZC69pJvc8Gt0R3ac9Emx2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871642; c=relaxed/simple;
	bh=NdXT431uGZOTMP3CkTBXoIqNow8BHLbE0LszCBSGG0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4wNK+cEZHskQu+Eq1aHxy2sSY9lZxPBFhUvKHtGAo2bOFkLVlSuLejpxpqoTKhEtIxXGSKqhDOfsMRXXzh9dg7wMxD4Zr51oPnR9Zes6ttRbVq/zQxDF5Q0bCQLeQh+eeLuRRJGfbquO3ZgtR1TfhWYtXoqWme/oMN5fSts7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0kaCvhL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0kaCvhL"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-793fdbb8d3aso30628957b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871640; x=1776476440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8daiW/schijtf5yqsox2TubZEu9Yk4Ya5Y2HXK3bpU=;
        b=T0kaCvhL+zclbYwbHnviafBJWdGnqVV5HdHTdhbRx/KEW2ldvtDVgAt59FGNK5jA9b
         6oQXyv1QFy4RxYIUgebSO/XixlZIzpCg36/0aG+jjC5d2DQxv6IRdx1f9wohMgV9bWBk
         YdoskQ6fDsGhzAV1Z7U0HEQvs0GjbpXI/zdix8D09UGJRWRJE0lf2uPz34d0qoqxUtpU
         +UaDy0D2pQXnuFfGkXcGx8GYUy1BLtbINVNeiePCpX1g0A8Y5SzYHnT2vb/Avkw3uDGp
         0wEODcOKKnFHlWINt7AkOrAAHMJ+B9dKyZxWv3MvwNOr0yN+JmYb45E3/uj8vvRGWrLE
         87bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871640; x=1776476440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o8daiW/schijtf5yqsox2TubZEu9Yk4Ya5Y2HXK3bpU=;
        b=bhQs86dA2IDzYhs8FALZwEFmK//69y6NC66Re00h0JZYF2ad2kxPcOQ5TbYB9Yp0TF
         rPgPhFATRhV5kULxYdFWu4mFBCl54tiubmQJ8ye1XZN7yweMpBbUzhRjplgIDZLDoIC4
         zQ4MZEHRYMa/F5WHthjQTvpg8GROxoCns1GxPsxEoZv6GIjZEkLz0KbKX/Cxi4t1BsjO
         RPU+kRZGHKsa+2K152cSsU4oJLPV6tCk6My/9jLeajsEnh+oGyoeUzfHG/t1r0RU09Ih
         qdbaGLZRhz4VSUuT3wPWnI5TcIEQohznGGFyQGxPH6BNaN7NyChS/C8/YvYb/HNkELaV
         Mpng==
X-Gm-Message-State: AOJu0YyAVpaXYYKwBvRC2sOajjYG2l1h4WKiUQy6FBeqKVmygCCO/3cc
	1EjmZmo+AnwIbveqN5OncFGCkHm5A9jhc9rYy6EAGraZygPCrcTKy60w53oDsQ==
X-Gm-Gg: AeBDiev7xuNcRl+w7ZhWi+EMRBv4jTdOMz7BaSmic7ZCgYInCnub+rHx+Gz/Otf0UQK
	U/iHX0UzZMN3zvi/6HQuKg3exJVT0BovIYI6VJcc7CFwgohrKWRW+qb8M+yAPcQuKwfTyEZbVPD
	9qHeu5N2Xdr4a4COS/8q3aiJ0ZK0ijIEv23DJQvqo10GLuLxLQzZ1mrRzcjvDgBUxrVf+RpHHWu
	I3fWu2AN6bz1QxpY5dw7lIvk8aPUfZCiAPqBvCjAkZLfJJi5iOhTnv092GA4hO6z12dQqIuNVs0
	/Z1Y09X7IGwtSrUKKgdL7hs+mSJMBaIpkXQRf9dhrsn5/FUfXAFtdebakVDNXnVcyBCchcVEA6J
	wb9pgd33vTUTV/T+AOeSH2NASuJkieWcPQKEyqlplSgeE99UroJ4zIO0+45URvfOfpI4z1zpH7z
	Mqx0LJ0AH0M5FbMQ4w5awu2gZTIYyWbq1dUrQParu7kQ==
X-Received: by 2002:a05:690c:a041:b0:798:e281:a51d with SMTP id 00721157ae682-7af7108b93bmr47172157b3.32.1775871640283;
        Fri, 10 Apr 2026 18:40:40 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:40 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 10/20] cxl/mem: Configure dynamic capacity interrupts
Date: Fri, 10 Apr 2026 18:23:05 -0700
Message-ID: <20260411013958.47422-11-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
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

Based on an original patch by Navneet Singh.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
---
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/pci.c    | 73 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a933b6f5454f..88bcc69f22c2 100644
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
index 8d12c684d670..622252ae0ed8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -569,23 +569,34 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
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
@@ -632,6 +643,30 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
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
@@ -657,18 +692,26 @@ static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
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
 
@@ -676,10 +719,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	if (!cxl_event_validate_mem_policy(mds, &policy))
+	if (native_cxl && !cxl_event_validate_mem_policy(mds, &policy))
 		return -EBUSY;
 
-	rc = cxl_event_config_msgnums(mds, &policy);
+	rc = cxl_event_config_msgnums(mds, &policy, native_cxl);
 	if (rc)
 		return rc;
 
@@ -687,12 +730,16 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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


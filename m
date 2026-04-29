Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7939BFEE
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471089; cv=none; b=a4USTjzOyVHGinBiXRTuCNo/jOjOkDLNysDhMB6FeUWChJVG51Z9DWrBj4VcwcpZBirANK4kB8t9ldK23QttHK6tn7T0yTeHqDHZiI1TyT52HQtOJiaj77l6r+SK6S1NQo/A0eb+YNocFt0I4hxErUSV5HoVbe60sIHrP2U3mps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471089; c=relaxed/simple;
	bh=Gss9LTMrP0ETUFWCAbD1BlQXVwdHaSCI6p/Kydc/rGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5VvFnm+4jwuH2Gwa7qAEIppg44OQAxIhrW/NB3aX8uYe07hp6yqR/Dzw+osKwUnIaJuKmnnEllgsqSgb09kaNbYBI8zMkBEp+dk80nhNq2Io3dBrt3fyzgidrMBo/Jambju/0GUTpja4QpGC0wwX/9dlchaizY7EdWOk1Spkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe7p76PI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe7p76PI"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe608cb92so8498995f8f.2
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471085; x=1778075885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dISlLOgELyvKWF7YlFcG2dTrk3AD7+Q7q5PPE/Lrnp4=;
        b=Xe7p76PI/DRpSrJNm2nmdW7UH7dihB1iXH76ZuhDCveUwvx4QJ7DksZf8vCLj1UT8m
         /eRWsKexdHDGOto2mUiCF5BZtzLXr/x2S9mazjDzRBdq2aeZRPD9umMxG1ybjw9GVeAf
         8kn4ElX/owbi+PRp8VneH94ejSEbKr+HgGdH+7Lxl7oP3nSAJBU9iHnocC6LG023hdHI
         HCelcMFUbu7VK3Z+jyFGEeHltpKNcgEPwsLZw/49QrpWsfUTWh6v24QbT0VzFgnVmBnR
         eA2ltzDMuz5RuinLT2LcCpLgCc2Vr4ZVTSLTm13V5lt1H6nnRDaSp0GCABS9Wz7nx07z
         WYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471085; x=1778075885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dISlLOgELyvKWF7YlFcG2dTrk3AD7+Q7q5PPE/Lrnp4=;
        b=qm47IWDxdkH6Ap6MEGl3X75gqRgxCVezCcfQdEkBc7t51roK51PAFfoAskjtszRwaU
         MRbLgqS4eG68kqYj4nFTsBbvKRiR6QHEaisQC53ewLsWhm3o7P+YvInFV5dZhZbKiPL/
         /AGCIF5+h1/7JLB/RxZxAcgZu+2UY+D8VxvVQcBIbJ+IAkEgWS3Kp+T+NKL6gd5NUlmQ
         LsbrNjrDh3YgvhrEjESNn8k0s3tpT4YE/Nq6txsOQrwNmE4ovCnC7psSQaJNT5pdRcLW
         M7lCqJa0kPf5Ke8S8yIdb6pUe2hyI0uIBos5lRzR4TYXGx1/4Xp3p6p0xNkBALSLtIGu
         DRrg==
X-Gm-Message-State: AOJu0Ywhkq/Nl/Tfjl/Iaq5uIdqT+unCPItvlT+i5VhCVKkcrb9aH2Mz
	GG6NNDTEwxkwVwXJOFG8WR9oKosqY9Rz/C9usVDeGyQkCcv/hsnzW5PqxjTgIQW/
X-Gm-Gg: AeBDievgIJVmdakK93HAJoz8XemMDGPzLmCszg37Pi9ADr0b7mDjHPb7XHIPqEBtIWj
	7g6pp/r5BaJbgbFy7Eg+yL7DBTvWVucoz4mxlZ9GK/F62LM8oUymLWlezUQI5LKKKNGXLfMIojb
	vwdSRz/Bw4ZXJft0B4TfQWTfrCMca4nCd3MrVV/2ES1TY1coqJXgUkhZKG7BHdCJuJ9Dxx1Qstx
	UgeLg8bYp0pPXQdRA+WDfvOIqSziXdXF4AQMNzWLJ0qrr50y/E8/w2CLvxdIJ2+O6SwQzs3qERk
	+D5FpV1ic9sTBXZPtcmQrCr3gNPM3gSw6XMSwInj1+XRShZdnCxV6EWzDBJJ7auLCbiBTNJ2x/v
	sOq6ACQ/QKjtV4S215Np9sy1/gWgfpsucAGC8y3MtjEXBod8v8WcSVNmTyhRkF/0C9ryFU5vs90
	ohQEUQlgBnP1RwNIPfmuHg3zPkG0ZVmveW0s8KEBoPvbB/BVb7JxwJiZ51MjmnE6sh9X7GWQqVZ
	mUtJsFVvVc=
X-Received: by 2002:a5d:5848:0:b0:441:2473:c30a with SMTP id ffacd0b85a97d-446496d79aemr13966246f8f.31.1777471085059;
        Wed, 29 Apr 2026 06:58:05 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:58:04 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com,
	arpit1.kumar@samsung.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 08/10] cxl-cci-mailbox: Add support for targeting a VCS switch
Date: Wed, 29 Apr 2026 14:48:42 +0100
Message-ID: <20260429135717.3048713-9-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows a cci mailbox and mctp device to target a cxl-vcs-switch. The
target needs to be changed from a PCIDevice to a more generic Object,
since the target can now also be a cxl-vcs-switch, as well as USP or
type3 device. The VCS is an object which is composed of many
PCI devices, but cannot be classed as one itself (since it is busless).

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 44 +++++++++++++++++++++++--------------
 hw/cxl/switch-mailbox-cci.c | 33 ++++++++++++++++++++++------
 hw/usb/dev-mctp.c           | 23 ++++++++++++++++---
 include/hw/cxl/cxl_device.h | 10 ++++++++-
 4 files changed, 83 insertions(+), 27 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f12e42a648..779138cdc8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4600,22 +4600,24 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     /* forbid any selected commands while the media is disabled */
-    if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
-        cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
-
-        if (cxl_dev_media_disabled(cxl_dstate)) {
-            if (h == cmd_events_get_records ||
-                h == cmd_ccls_get_partition_info ||
-                h == cmd_ccls_set_lsa ||
-                h == cmd_ccls_get_lsa ||
-                h == cmd_logs_get_log ||
-                h == cmd_media_get_poison_list ||
-                h == cmd_media_inject_poison ||
-                h == cmd_media_clear_poison ||
-                h == cmd_sanitize_overwrite ||
-                h == cmd_firmware_update_transfer ||
-                h == cmd_firmware_update_activate) {
-                return CXL_MBOX_MEDIA_DISABLED;
+    if(cci->d) {
+        if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+            cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+
+            if (cxl_dev_media_disabled(cxl_dstate)) {
+                if (h == cmd_events_get_records ||
+                    h == cmd_ccls_get_partition_info ||
+                    h == cmd_ccls_set_lsa ||
+                    h == cmd_ccls_get_lsa ||
+                    h == cmd_logs_get_log ||
+                    h == cmd_media_get_poison_list ||
+                    h == cmd_media_inject_poison ||
+                    h == cmd_media_clear_poison ||
+                    h == cmd_sanitize_overwrite ||
+                    h == cmd_firmware_update_transfer ||
+                    h == cmd_firmware_update_activate) {
+                    return CXL_MBOX_MEDIA_DISABLED;
+                }
             }
         }
     }
@@ -4909,3 +4911,13 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
 }
+
+void cxl_initialize_vcs_mctpcci(CXLCCI *cci, CXLVCSSwitch *vcs, DeviceState *d,
+        DeviceState *intf, size_t payload_max)
+{
+    cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
+    cci->vcs = vcs;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 223f220433..73f76484cc 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -16,6 +16,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "hw/cxl/cxl.h"
+#include "include/hw/cxl/cxl_vcs_switch.h"
 
 #define CXL_SWCCI_MSIX_MBOX 3
 
@@ -32,17 +33,26 @@ static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
     CXLDeviceState *cxl_dstate = &cswmb->cxl_dstate;
     CXLDVSECRegisterLocator *regloc_dvsec;
     CXLUpstreamPort *usp;
+    CXLVCSSwitch *vcs = 0;
 
     if (!cswmb->target) {
-        error_setg(errp, "Target not set");
+        error_setg(errp, "No target or vcs has been set...");
         return;
     }
-    usp = CXL_USP(cswmb->target);
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
     cxl_cstate->dvsec_offset = 0x100;
     cxl_cstate->pdev = pci_dev;
-    cswmb->cci = &usp->swcci;
+    if (object_dynamic_cast(cswmb->target, TYPE_CXL_VCS_SWITCH)) {
+	vcs = CXL_VCS_SWITCH(cswmb->target);
+	cswmb->cci = &vcs->swcci;
+    } else if (object_dynamic_cast(cswmb->target, TYPE_CXL_USP)) {
+	usp = CXL_USP(cswmb->target);
+	cswmb->cci = &usp->swcci;
+    } else {
+	error_setg(errp, "Target must be a VCS switch or USP");
+	return;
+    }
     cxl_device_register_block_init(OBJECT(pci_dev), cxl_dstate, cswmb->cci);
     pci_register_bar(pci_dev, 0,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
@@ -57,9 +67,18 @@ static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
                                REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
 
-    cxl_initialize_mailbox_swcci(cswmb->cci, DEVICE(pci_dev),
-                                 DEVICE(cswmb->target),
-                                 CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+    if(vcs) {
+	if(vcs->usp_ppbs[0]) {
+	    cxl_initialize_vcs_mctpcci(cswmb->cci,
+		vcs, DEVICE(vcs->usp_ppbs[0]->usp), DEVICE(pci_dev), CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+	} else {
+	    error_setg(errp, "The VCS requires a master USP...");
+	}
+    } else {
+	cxl_initialize_mailbox_swcci(cswmb->cci, DEVICE(pci_dev),
+				     DEVICE(CXL_USP(cswmb->target)),
+				     CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+    }
 }
 
 static void cswmbcci_exit(PCIDevice *pci_dev)
@@ -69,7 +88,7 @@ static void cswmbcci_exit(PCIDevice *pci_dev)
 
 static const Property cxl_switch_cci_props[] = {
     DEFINE_PROP_LINK("target", CSWMBCCIDev,
-                     target, TYPE_CXL_USP, PCIDevice *),
+                     target, TYPE_OBJECT, Object *),
 };
 
 static void cswmbcci_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/usb/dev-mctp.c b/hw/usb/dev-mctp.c
index aafb9e7e96..792a375245 100644
--- a/hw/usb/dev-mctp.c
+++ b/hw/usb/dev-mctp.c
@@ -25,6 +25,7 @@
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "net/mctp.h"
+#include "include/hw/cxl/cxl_vcs_switch.h"
 
 /* TODO: Move to header */
 
@@ -77,7 +78,7 @@ enum cxl_dev_type {
 
 typedef struct USBCXLMCTPState {
     USBDevice dev;
-    PCIDevice *target;
+    Object *target;
     CXLCCI *cci;
     enum cxl_dev_type type;
     USBPacket *cached_tohost;
@@ -600,12 +601,28 @@ static void usb_cxl_mctp_realize(USBDevice *dev, Error **errp)
         return;
     }
 
+    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_VCS_SWITCH)) {
+        CXLVCSSwitch *sw = CXL_VCS_SWITCH(s->target);
+
+        s->type = cxl_switch;
+        s->cci = &sw->mctpcci;
+	s->cci->vcs = sw;
+
+	if(sw->usp_ppbs[0]) {
+	    cxl_initialize_vcs_mctpcci(s->cci, CXL_VCS_SWITCH(s->target),
+		DEVICE(sw->usp_ppbs[0]->usp), DEVICE(dev), MCTP_CXL_MAILBOX_BYTES);
+	} else {
+	    error_setg(errp, "No master USP associated with the VCS");
+	}
+        return;
+    }
+
     error_setg(errp, "Unhandled target type for CXL MCTP EP");
 }
 
 static const Property usb_cxl_mctp_properties[] = {
-    DEFINE_PROP_LINK("target", USBCXLMCTPState, target, TYPE_PCI_DEVICE,
-                     PCIDevice *),
+    DEFINE_PROP_LINK("target", USBCXLMCTPState, target, TYPE_OBJECT,
+                     Object *),
 };
 
 static void usb_cxl_mctp_class_initfn(ObjectClass *klass, const void *data)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 6158560e6c..5d9f537a03 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -143,6 +143,7 @@ typedef enum {
 } CXLDSMASFlags;
 
 typedef struct CXLCCI CXLCCI;
+typedef struct CXLVCSSwitch CXLVCSSwitch;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
 typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
@@ -212,6 +213,8 @@ typedef struct CXLCCI {
     DeviceState *d;
     /* Pointer to the device hosting the protocol conversion */
     DeviceState *intf;
+    /* Pointer to the vcs hosting the CCI (if used) */
+    CXLVCSSwitch *vcs;
     bool initialized;
 } CXLCCI;
 
@@ -349,6 +352,10 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                 size_t payload_max);
 
+void cxl_initialize_vcs_mctpcci(CXLCCI *cci, CXLVCSSwitch *vcs,
+	DeviceState *d, DeviceState *intf, size_t payload_max);
+
+
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
         uint32_t *cap_hdrs = dstate->caps_reg_state32;                     \
@@ -820,9 +827,10 @@ struct CXLType3Class {
                           uint8_t *data);
 };
 
+
 struct CSWMBCCIDev {
     PCIDevice parent_obj;
-    PCIDevice *target;
+    Object *target;
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
     CXLCCI *cci;
-- 
2.47.3


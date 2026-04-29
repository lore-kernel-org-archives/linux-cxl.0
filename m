Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664232FE560
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471087; cv=none; b=n5cLvapkE5qSDu5HdeuNpjkph7YuEpX09KZy0UIZhCi/PKFj0AzLtfGlXRIigpOe0WWUy2EomgmeVzGaBIDhTJa6qYXInurFH99li7ILK4JxWUD+D7T0cjN4ps06eDBhByRtMSszuVkO32BBhhx6rIeYMF0GTQg82SEeBcGrFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471087; c=relaxed/simple;
	bh=kyi+fw2biqZiiLQrU5LUZVxiibSA2sVTChD0Fhjl0ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFS9j/x6zZxE4rVowrrKKmyIzBUwxYhnBnehYQdqIvyt74rp3ekTI0lki1Zb3IGlDNLZSZSYFL7t2NFKnT3PItWuTE7kb8vB8NrQo4DdyauydjKw69nw7KR4L35+SgClqgbTFN1jeDVsDmulsu4m5APAftmADoJbtuXuIPDP1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTdVvUC5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTdVvUC5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so108817505e9.2
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471082; x=1778075882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwHA3nK3tLpyQIT1y1aThj/ymGzWpwwSiiTYweRTIgw=;
        b=XTdVvUC5N+KXNs40Na57DfzRWgbH/z9ScPDbv+8wkUKcKB0FERB4yWPsvV0t5G5s1c
         13R6lk8ntAys8Zc08GM8/cnclPjo5CgP7NRT1I/Qz+vBWMRdAx24iaWVAY39bQHWlapQ
         UYxmMnlMFuTDwAOyCVZFIGw5PKPL0Nkt2oP5HIvmh5p18xl4Qog11lPYtH4fMnA7Bqat
         3OPc/Aus0rGL593UkZNYBsN1YoJ2dPAOZRq9fLo30XHLv8LxGttJPJegEQ+B9kePopmA
         QuBsc+XFZJFgxqG4LcdqhOccl8oBKO8rv+XXmr8StZuFDpSL/ymhwXsLu2rHjGxcVRS+
         N+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471082; x=1778075882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwHA3nK3tLpyQIT1y1aThj/ymGzWpwwSiiTYweRTIgw=;
        b=KI1qnOk5VEir3sVjHKkOsxNK4csXV4Tnr3KWs+WZuOh+OyqIQvZnHZ+XOp+1k3aPDJ
         WRA7QbBmTwVaAKNPngMaPOHQdlxt39rZI1C/3UL7NzzWA5LZDDQp9P64UunNqpTgcKOw
         NHl1cCkk1wcbh27eT3k1hYqVAKZcD1CnBZmRFDSKyCVDoNDVmkOuAmvXIE1cOpQNChJD
         lcwjIzkotPb1WDoAT5SjIOZyEVHawyRSYiXiC+PwNL2UyayyIlJMaeZYjpTjWCFOG3mD
         lri0BUg5Rl6JvlMg4/BS7WHX0ppL57ZZv6JMPwjLDIpQkNNzIwae1fRUMOYVK7G6WXGi
         GBxg==
X-Gm-Message-State: AOJu0YwRYzUiaq0aeSmFi8Xgz6PusOcijcWRE6ns+Uv9w+PGHXsZ/8TQ
	whzkDNRJhnEoXmsziXyzNTYto2moQbSNnRQftUdStO1GSSWiImb436cvdvNjx9xx
X-Gm-Gg: AeBDievhBaB9MUROwxbG5mgefx1GmJppe4/OmcLye4+yn8P/6X4jc8o0K7DdzinLtXh
	HgU8CYzhONX9CS59WeDwofVvxftlKL3Cgg9IxmqKvQ4OAGjeVvXRIIAesxZjI8tfnAxrGh3G3vo
	9Ace7sgeDI9HY9/NxRZW1C3GwqTsmuYi9AbSts+8JH74S87RzdkcgH5LmGssLZa+QI1A07nCaJH
	jqh0KCX8cMMIzPSx0fGbKXMqQv0ZCQ9w/FIMpRHKV0klXtd8xXGjHt3+aRKv4GDBlQvc2wvAmbn
	IgvVoyTMALq8qlfVzRSjg2zamZYbFLGzPSTI0U0HEZ4smcaPdQAMn5jCe1s1icNiPTWLybX2OxD
	b0ncWO1GGNeeYpMG1E+v8G6CIt8042RjUqoFdChI9uPa0A60T2qPRFX0zDuUk7q+4Gz+lphu1DG
	jNQ3nul6LG1n+fA3crJ9ZSsjMwVn8ubzBIiZqlB6OqPee9yUUOeQdNWW9WjfuPtgrLyYsdkYBk
X-Received: by 2002:a05:600c:3f18:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-48a7b51beebmr72235865e9.10.1777471082058;
        Wed, 29 Apr 2026 06:58:02 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:58:01 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com,
	arpit1.kumar@samsung.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 05/10] cxl-vcs-switch: Initial support for CXL VCS.
Date: Wed, 29 Apr 2026 14:48:39 +0100
Message-ID: <20260429135717.3048713-6-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add initial support for VCS (multi-USP/multi-logic-device) switch
emulation in CXL. Currently the object only supports the identify/bind/unbind
commands (0x5200/0x5201/0x5202), as well as support for device hiding
listeners. This enables preliminary testing of the VCS capability,
but will not allow for complete emulated flow as described in
spec (CXL v3.2, 7.2.3). Nor will it allow for multiple USP's to be
disributed over multiple QEMU instances.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/cxl/cxl-vcs-switch.c         | 524 ++++++++++++++++++++++++++++++++
 hw/cxl/meson.build              |   1 +
 include/hw/cxl/cxl_vcs_switch.h | 134 ++++++++
 qapi/qom.json                   |  19 ++
 4 files changed, 678 insertions(+)
 create mode 100644 hw/cxl/cxl-vcs-switch.c
 create mode 100644 include/hw/cxl/cxl_vcs_switch.h

diff --git a/hw/cxl/cxl-vcs-switch.c b/hw/cxl/cxl-vcs-switch.c
new file mode 100644
index 0000000000..9a492330cc
--- /dev/null
+++ b/hw/cxl/cxl-vcs-switch.c
@@ -0,0 +1,524 @@
+/*
+ * CXL VCS Capable Switch Object
+ *
+ * Copyright(C) 2026 University of Manchester.
+ * Author: Joshua Lant <joshualant@gmail.com>.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-v2-only
+ */
+#include "hw/cxl/cxl_vcs_switch.h"
+#include "qobject/qdict.h"
+#include "monitor/qdev.h"
+
+/* Primary FM here is used when the FM is local to the QEMU instance. Setting
+ * local-fm=false in cli results in instantiation of remote listener for FM
+ * commands (TODO: to be implemented) */
+static bool cxl_vcs_get_local_fm(Object *obj, Error **errp)
+{
+    CXLVCSSwitch *vcs = CXL_VCS_SWITCH(obj);
+    return vcs->local_fm;
+}
+static void cxl_vcs_set_local_fm(Object *obj, bool value, Error **errp)
+{
+    CXLVCSSwitch *vcs = CXL_VCS_SWITCH(obj);
+    vcs->local_fm = value;
+}
+
+/* Binds an already realized MLD to a VPPB in the switch */
+static CXLRetCode cxl_vcs_bind_realized_vppb(CXLVCSSwitch *sw, uint8_t vcs_id,
+        uint8_t vppb_id, uint8_t dsp_ppb_id, uint8_t ld_id)
+{
+    /* TODO: Implement... Required for handling MLD devices... */
+    return CXL_MBOX_UNSUPPORTED;
+}
+
+/* Binds a hidden device (simple SLD) to a VPPB in the switch */
+static CXLRetCode cxl_vcs_bind_qdict_vppb(CXLVCSSwitch *sw, uint8_t vcs_id,
+        uint8_t vppb_id, uint8_t dsp_ppb_id, uint8_t ld_id)
+{
+    Error *local_err = NULL;
+    CXLVPPBInfo *vppb;
+    CXLDownstreamPPB *dspppb;
+    QDict *bind_opts;
+    DeviceState *dev;
+
+    // Upstream to bind
+    if(!sw->usp_ppbs[vcs_id]) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    vppb = sw->usp_ppbs[vcs_id]->info->vppbs[vppb_id];
+    if(!vppb) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    PCIDevice *vppb_dev = PCI_DEVICE(vppb->dsp);
+
+    //Downstream to bind
+    dspppb = sw->dsp_ppbs[dsp_ppb_id];
+    if(!dspppb) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    // Get DSP bus id from qdev
+    bind_opts = qdict_clone_shallow(dspppb->opts);
+    qdict_put_str(bind_opts, "bus", vppb_dev->qdev.id);
+    qdict_del(bind_opts, "vcs");
+    qdict_del(bind_opts, "dsppb");
+
+    uint8_t prev_binding_status = vppb->binding_status;
+    vppb->binding_status = CXL_VPPB_BINDING_STATUS_IN_PROGRESS;
+    dev = qdev_device_add_from_qdict(bind_opts, dspppb->from_json, &local_err);
+    if(!dev || local_err) {
+        vppb->binding_status = prev_binding_status;
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    vppb->bound_port_id = dsp_ppb_id;
+    vppb->bound_ld_id = CXL_INVALID_BOUND_LD_ID; // TODO: support MLDs.
+    vppb->binding_status = CXL_VPPB_BINDING_STATUS_BOUND_PORT;
+    dspppb->dev = dev;
+    dspppb->is_bound = true;
+    dspppb->bound_vcs_id = vcs_id;
+    dspppb->bound_vppb_id = vppb_id;
+    qobject_unref(bind_opts);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+CXLRetCode cxl_vcs_bind_vppb(CXLVCSSwitch *sw, uint8_t vcs_id, uint8_t vppb_id,
+        uint8_t dsp_ppb_id, uint16_t ld_id)
+{
+    if(cxl_vcs_get_local_fm(OBJECT(sw), NULL)) {
+        if(ld_id == CXL_UNSUPPORTED_LD_ID) {
+            return cxl_vcs_bind_qdict_vppb(sw, vcs_id, vppb_id,
+                    dsp_ppb_id, ld_id);
+        } else {
+            // TODO: Connect up already realized device
+            // (needed for MLD support).
+            return cxl_vcs_bind_realized_vppb(sw, vcs_id, vppb_id,
+                    dsp_ppb_id, ld_id);
+        }
+    }
+    else {
+        // TODO: Send bind command to remote QEMU process...
+        return CXL_MBOX_UNSUPPORTED;
+    }
+}
+
+static CXLRetCode cxl_vcs_unbind_qdict_vppb(CXLVCSSwitch *sw, uint8_t vcs_id,
+                                       uint8_t vppb_id, uint8_t options)
+{
+    Error *local_err = NULL;
+    CXLVPPBInfo *vppb_info;
+    CXLDownstreamPPB *dspppb = NULL;
+
+    if(!sw->usp_ppbs[vcs_id]) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    vppb_info = sw->usp_ppbs[vcs_id]->info->vppbs[vppb_id];
+    if (!vppb_info ||
+        (vppb_info->binding_status == CXL_VPPB_BINDING_STATUS_UNBOUND) ||
+        (vppb_info->binding_status == CXL_VPPB_BINDING_STATUS_IN_PROGRESS)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    for (int i = 0; i < sw->num_dsp_ppbs; i++) {
+        if (sw->dsp_ppbs[i] &&
+                sw->dsp_ppbs[i]->is_bound &&
+                sw->dsp_ppbs[i]->bound_vcs_id == vcs_id &&
+                sw->dsp_ppbs[i]->bound_vppb_id == vppb_id) {
+            dspppb = sw->dsp_ppbs[i];
+            break;
+        }
+    }
+
+    if (!dspppb) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (!dspppb->dev) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /* Options from cxl v3.2 (Table 7-34), Bits[3:0].
+      — 0h = Wait for port Link Down before unbinding
+      — 1h = Simulate Managed Hot-Remove
+      — 2h = Simulate Surprise Hot-Remove */
+    options = options & 0x0F;
+    if (options == CXL_VPPB_UNBIND_WAIT_FOR_LINK_DOWN) {
+        // TODO: implement
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    else if(options == CXL_VPPB_UNBIND_MANAGED_HOT_REMOVE) {
+        // unrealize listener will fire once guest notifies the port...
+        qdev_unplug(dspppb->dev, &local_err);
+        vppb_info->binding_status = CXL_VPPB_BINDING_STATUS_IN_PROGRESS;
+        if (local_err) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+        return CXL_MBOX_SUCCESS;
+    }
+    else if (options == CXL_VPPB_UNBIND_SURPRISE_HOT_REMOVE) {
+        // TODO: implement, This isn't a true surprise removal...
+        qdev_unplug(dspppb->dev, &local_err);
+        if (local_err) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+        object_unparent(OBJECT(dspppb->dev));
+        dspppb->is_bound      = false;
+        dspppb->bound_vcs_id  = 0;
+        dspppb->bound_vppb_id = 0;
+
+        /* Clear VPPB binding state so Get Virtual Switch Info reflects unbound */
+        vppb_info->binding_status = CXL_VPPB_BINDING_STATUS_UNBOUND;
+        vppb_info->bound_port_id  = 0;
+        vppb_info->bound_ld_id    = CXL_INVALID_BOUND_LD_ID;
+        dspppb->dev = NULL;
+        /* TODO: Generate Virtual CXL Switch Event Record per CXL spec
+         * section 7.6.6.6  */
+        return CXL_MBOX_SUCCESS;
+    }
+    else {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+}
+
+CXLRetCode cxl_vcs_unbind_vppb(CXLVCSSwitch *sw, uint8_t vcs_id,
+        uint8_t vppb_id, uint16_t option)
+{
+    /*TODO: Only currently unbinding an unrealizing whole device.
+     * Implement for MLD partial unbinding of single extents etc.
+     * */
+    return cxl_vcs_unbind_qdict_vppb(sw, vcs_id, vppb_id, option);
+}
+
+void cxl_vcs_identify_switch_device(CXLVCSSwitch *sw)
+{
+    //TODO: implement
+}
+void cxl_vcs_get_physical_port_state(CXLVCSSwitch *sw)
+{
+    //TODO: implement
+}
+void cxl_vcs_physical_port_control(CXLVCSSwitch *sw)
+{
+    //TODO: implement
+}
+void cxl_vcs_get_virtual_switch_info(CXLVCSSwitch *sw)
+{
+    //TODO: implement
+}
+
+void cxl_vcs_register_usp(CXLVCSSwitch *sw, CXLUpstreamPort *usp,
+        Error **errp)
+{
+    uint8_t ppb = usp->ppb;
+
+    if(strcmp(object_get_canonical_path_component(OBJECT(sw)), usp->vcs_name)) {
+        error_setg(errp, "VCS id for USP and switch do not match...\n");
+    }
+
+    if (ppb >= sw->num_usp_ppbs) {
+        error_setg(errp, "vcs '%s': ppb %u >= usp-ppbs %u",
+                   object_get_canonical_path_component(OBJECT(sw)),
+                   ppb, sw->num_usp_ppbs);
+        return;
+    }
+    if (sw->usp_ppbs[ppb]) {
+        error_setg(errp, "vcs '%s': USP slot %u already registered",
+                   object_get_canonical_path_component(OBJECT(sw)), ppb);
+        return;
+    }
+
+    sw->usp_ppbs[ppb] = g_new0(CXLUpstreamPPB, 1);
+    sw->usp_ppbs[ppb]->usp = usp;
+    sw->usp_ppbs[ppb]->info = g_new0(CXLVCSInfoBlock, 1);
+    sw->usp_ppbs[ppb]->info->vcs_id = ppb;
+    sw->usp_ppbs[ppb]->info->usp_id = ppb;
+    sw->usp_ppbs[ppb]->info->num_vppbs = 0;
+    sw->usp_ppbs[ppb]->info->vcs_state = CXL_VCS_STATE_ENABLED;
+    usp->swcci.vcs = sw;
+}
+
+void cxl_vcs_register_vppb(CXLVCSSwitch *sw, CXLUpstreamPort *usp,
+        CXLDownstreamPort *dsp, Error **errp)
+{
+    CXLUpstreamPPB *vcs;
+
+    for(int i = 0; i < CXL_MAX_VCS_PORTS; i++) {
+        if(sw->usp_ppbs[i]) {
+            if(usp == sw->usp_ppbs[i]->usp) {
+                vcs = sw->usp_ppbs[i];
+                break;
+            }
+        } else {
+            error_setg(errp, "The USP was not found in the VCS list...");
+            return;
+        }
+    }
+
+    for(int i = 0; i < CXL_MAX_VPPB_PER_VCS; i++) {
+        if(!vcs->info->vppbs[i]) {
+            // Free vppb slot.. lets allocate and populate it...
+            CXLVPPBInfo *vppb = g_new0(CXLVPPBInfo, 1);
+            vppb->dsp = PCI_DEVICE(dsp);
+            vppb->binding_status = CXL_VPPB_BINDING_STATUS_UNBOUND;
+            vcs->info->vppbs[i] = vppb;
+            vcs->info->num_vppbs = vcs->info->num_vppbs + 1;
+            return;
+        }
+    }
+
+    error_setg(errp, "No free VPPB slots in the VCS...");
+    return;
+}
+
+void cxl_vcs_register_qdict_dsppb(CXLVCSSwitch *sw, const QDict *opts,
+        bool from_json, Error **errp)
+{
+    QDict *dev_opts;
+    int ppb;
+    const char *ppb_str = qdict_get_try_str(opts, "dsppb");
+    ppb = atoi(ppb_str);
+    if(ppb == -1) {
+        error_setg(errp, "No ppb id given in cli.");
+        return;
+    }
+
+    if (ppb >= sw->num_dsp_ppbs) {
+        error_setg(errp, "vcs '%s': dsppb %u >= dsp-ppbs %u",
+                   object_get_canonical_path_component(OBJECT(sw)),
+                   ppb, sw->num_dsp_ppbs);
+        return;
+    }
+    if (sw->dsp_ppbs[ppb]) {
+        error_setg(errp, "vcs '%s': DSP PPB slot %u already occupied",
+                   object_get_canonical_path_component(OBJECT(sw)), ppb);
+        return;
+    }
+
+    dev_opts = qdict_clone_shallow(opts);
+    qdict_del(dev_opts, "vcs");
+    qdict_del(dev_opts, "dsppb");
+    qdict_del(dev_opts, "bus");
+
+    sw->dsp_ppbs[ppb] = g_new0(CXLDownstreamPPB, 1);
+    sw->dsp_ppbs[ppb]->opts      = dev_opts;
+    sw->dsp_ppbs[ppb]->from_json = from_json;
+    sw->dsp_ppbs[ppb]->is_bound  = false;
+}
+
+void cxl_vcs_register_dsppb(CXLVCSSwitch *sw, const QDict *opts,
+        bool from_json, Error **errp)
+{
+
+    DeviceState *dev = qdev_new(qdict_get_str(opts, "driver"));
+    qdev_set_id(dev, g_strdup(qdict_get_try_str(opts, "id")), errp);
+    int ppb;
+    const char *ppb_str = qdict_get_try_str(opts, "dsppb");
+    ppb = atoi(ppb_str);
+    if(ppb == -1) {
+        error_setg(errp, "No ppb id given in cli.");
+        return;
+    }
+
+    QDict *dev_opts = qdict_clone_shallow(opts);
+    qdict_del(dev_opts, "driver");
+    qdict_del(dev_opts, "bus");
+    qdict_del(dev_opts, "id");
+    qdict_del(dev_opts, "vcs");
+    qdict_del(dev_opts, "dsppb");
+    object_set_properties_from_keyval(OBJECT(dev), dev_opts, from_json, errp);
+    qobject_unref(dev_opts);
+    // store, don't realize
+    sw->dsp_ppbs[ppb]->dev = dev;
+}
+
+static bool cxl_vcs_switch_can_be_deleted(UserCreatable *uc)
+{
+    return false;
+}
+
+/* When a device is instantiated downstream of a VCS's PPB, we
+ * store the qdicts from the CLI, to realize the device at a
+ * future time.
+ */
+bool cxl_vcs_hide_device_listener(DeviceListener *listener, const QDict *opts,
+                        bool from_json, Error **errp)
+{
+    CXLVCSSwitch *vcs = container_of(listener, CXLVCSSwitch, listener);
+    const char *vcs_id_str   = qdict_get_try_str(opts, "vcs");
+    const char *ppb_str = qdict_get_try_str(opts, "dsppb");
+    int ppb;
+
+    /* Not our device — don't claim it */
+    if (!vcs_id_str || !ppb_str) {
+        return false;
+    }
+    if(vcs_id_str) {
+        if(strcmp(vcs_id_str,
+                    object_get_canonical_path_component(OBJECT(vcs)))) {
+            return false;
+        }
+    }
+    if(ppb_str) {
+        ppb = atoi(ppb_str);
+        if(vcs->dsp_ppbs[ppb]) {
+            error_setg(errp,
+                "The ppb %s is already populated by another device.", ppb_str);
+            return false;
+        }
+    }
+
+    cxl_vcs_register_qdict_dsppb(vcs, opts, from_json, errp);
+
+    return true;
+}
+
+/*
+ * Listener is added for unbinding. When a device is unbound using the
+ * Fabric Manager with 'managed' hot-remove option, a notificaiton is
+ * sent to the guest, which should perform a graceful teardown and notify
+ * the port of completion. At this point this listener unrealizes the device.
+ */
+static void cxl_vcs_ppb_unrealize_listener(DeviceListener *listener,
+        DeviceState *dev)
+{
+    CXLVCSSwitch *sw = container_of(listener, CXLVCSSwitch, listener);
+    CXLDownstreamPPB *dspppb;
+    CXLVPPBInfo *vppb_info;
+
+    for (int i = 0; i < sw->num_dsp_ppbs; i++) {
+        if (sw->dsp_ppbs[i] && (sw->dsp_ppbs[i]->dev == dev)) {
+            dspppb = sw->dsp_ppbs[i];
+            break;
+        }
+    }
+    if(!dspppb) {
+        return;
+    }
+
+    vppb_info =
+        sw->usp_ppbs[dspppb->bound_vcs_id]->info->vppbs[dspppb->bound_vppb_id];
+    object_unparent(OBJECT(dspppb->dev));
+    dspppb->dev = NULL;
+    dspppb->is_bound      = false;
+    dspppb->bound_vcs_id  = 0;
+    dspppb->bound_vppb_id = 0;
+    vppb_info->binding_status = CXL_VPPB_BINDING_STATUS_UNBOUND;
+    vppb_info->bound_port_id  = 0;
+    vppb_info->bound_ld_id    = CXL_INVALID_BOUND_LD_ID;
+    /* TODO: generate Virtual CXL Switch Event Record */
+}
+
+static void cxl_vcs_switch_complete(UserCreatable *uc, Error **errp)
+{
+    CXLVCSSwitch *sw = CXL_VCS_SWITCH(uc);
+    sw->listener.hide_device = cxl_vcs_hide_device_listener;
+    sw->listener.unrealize = cxl_vcs_ppb_unrealize_listener;
+    device_listener_register(&sw->listener);
+}
+
+static void vcs_get_usp_ppbs(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    CXLVCSSwitch *vcs = CXL_VCS_SWITCH(obj);
+    uint8_t val = vcs->num_usp_ppbs;
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void vcs_set_usp_ppbs(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    CXLVCSSwitch *vcs = CXL_VCS_SWITCH(obj);
+    uint8_t val;
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+    vcs->num_usp_ppbs = val;
+}
+static void vcs_get_dsp_ppbs(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    CXLVCSSwitch *vcs = CXL_VCS_SWITCH(obj);
+    uint8_t val = vcs->num_dsp_ppbs;
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void vcs_set_dsp_ppbs(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    CXLVCSSwitch *vcs = CXL_VCS_SWITCH(obj);
+    uint8_t val;
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+    vcs->num_dsp_ppbs = val;
+}
+
+static void cxl_vcs_class_init(ObjectClass *oc, const void *data)
+{
+    CXLVCSSwitchClass *cc = CXL_VCS_SWITCH_CLASS(oc);
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    ucc->complete = cxl_vcs_switch_complete;
+    ucc->can_be_deleted = cxl_vcs_switch_can_be_deleted;
+    cc->identify_switch_device = cxl_vcs_identify_switch_device;
+    cc->get_physical_port_state = cxl_vcs_get_physical_port_state;
+    cc->physical_port_control = cxl_vcs_physical_port_control;
+    cc->get_virtual_switch_info = cxl_vcs_get_virtual_switch_info;
+    cc->bind_vppb = cxl_vcs_bind_vppb;
+    cc->unbind_vppb = cxl_vcs_unbind_vppb;
+
+    object_class_property_add_bool(oc, "local-fm",
+                              cxl_vcs_get_local_fm, cxl_vcs_set_local_fm);
+    object_class_property_set_description(oc, "local-fm",
+        "true = FM authority (mctp connected guest), \
+        false = slave listener (IPC)");
+    object_class_property_add(oc, "usp-ppbs", "uint8",
+                          vcs_get_usp_ppbs, vcs_set_usp_ppbs,
+                          NULL, NULL);
+    object_class_property_set_description(oc, "usp-ppbs",
+        "Number of upstream ports in the switch");
+    object_class_property_add(oc, "dsp-ppbs", "uint8",
+                          vcs_get_dsp_ppbs, vcs_set_dsp_ppbs,
+                          NULL, NULL);
+    object_class_property_set_description(oc, "dsp-ppbs",
+        "Number of downstream ports in the switch");
+}
+
+static void cxl_vcs_instance_init(Object *obj)
+{
+    // TODO: Nothing here yet...
+}
+
+static void cxl_vcs_instance_finalize(Object *obj)
+{
+    // TODO: Nothing here yet...
+}
+
+static const InterfaceInfo cxl_vcs_interfaces[] = {
+    { TYPE_USER_CREATABLE },
+    { }
+};
+
+static const TypeInfo cxl_vcs_info = {
+    .name = TYPE_CXL_VCS_SWITCH,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(CXLVCSSwitch),
+    .class_size = sizeof(CXLVCSSwitchClass),
+    .class_init = cxl_vcs_class_init,
+    .instance_init = cxl_vcs_instance_init,
+    .instance_finalize = cxl_vcs_instance_finalize,
+    .interfaces = cxl_vcs_interfaces,
+};
+
+static void cxl_vcs_register(void)
+{
+    type_register_static(&cxl_vcs_info);
+}
+
+type_init(cxl_vcs_register)
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index ccad565c5c..c37563cd05 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -7,6 +7,7 @@ system_ss.add(when: 'CONFIG_CXL',
                    'cxl-cdat.c',
                    'cxl-events.c',
                    'switch-mailbox-cci.c',
+                   'cxl-vcs-switch.c',
                ),
                if_false: files(
                    'cxl-host-stubs.c',
diff --git a/include/hw/cxl/cxl_vcs_switch.h b/include/hw/cxl/cxl_vcs_switch.h
new file mode 100644
index 0000000000..6576870bf3
--- /dev/null
+++ b/include/hw/cxl/cxl_vcs_switch.h
@@ -0,0 +1,134 @@
+/*
+ * CXL VCS Capable Switch Object Header
+ *
+ * Copyright(C) 2026 University of Manchester
+ * Author: Joshua Lant <joshualant@gmail.com>.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-v2-only
+ */
+
+#ifndef CXL_VCS_SWITCH_H
+#define CXL_VCS_SWITCH_H
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/object.h"
+#include "qom/object_interfaces.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
+#include "hw/pci-bridge/cxl_downstream_port.h"
+#include "include/hw/cxl/cxl_device.h"
+
+#define TYPE_CXL_VCS_SWITCH "cxl-vcs-switch"
+OBJECT_DECLARE_TYPE(CXLVCSSwitch, CXLVCSSwitchClass, CXL_VCS_SWITCH);
+
+#define CXL_VPPB_BINDING_STATUS_UNBOUND        0x00
+#define CXL_VPPB_BINDING_STATUS_IN_PROGRESS    0x01
+#define CXL_VPPB_BINDING_STATUS_BOUND_PORT     0x02
+#define CXL_VPPB_BINDING_STATUS_BOUND_LD       0x03
+#define CXL_VPPB_BINDING_STATUS_BOUND_PID      0x04
+
+#define CXL_VPPB_UNBIND_WAIT_FOR_LINK_DOWN      0x0
+#define CXL_VPPB_UNBIND_MANAGED_HOT_REMOVE      0x1
+#define CXL_VPPB_UNBIND_SURPRISE_HOT_REMOVE     0x2
+
+#define CXL_UNSUPPORTED_LD_ID 0xFFFF
+#define CXL_INVALID_BOUND_LD_ID 0xFF
+
+#define CXL_VCS_STATE_INVALID_ID        0xFF
+#define CXL_VCS_STATE_DISABLED 0x0
+#define CXL_VCS_STATE_ENABLED 0x1
+
+#define CXL_MAX_VCS_PORTS 0x8
+#define CXL_MAX_VPPB_PER_VCS 0x8
+#define CXL_MAX_USP_PPBS CXL_MAX_VCS_PORTS
+#define CXL_MAX_DSP_PPBS CXL_MAX_VPPB_PER_VCS
+
+#define CXL_MAX_PPBS (CXL_MAX_USP_PPBS + CXL_MAX_DSP_PPBS)
+#define VPPB_LIST_LIMIT 8
+
+struct CXLVCSSwitchClass {
+    ObjectClass parent_class;
+    void (*identify_switch_device)(CXLVCSSwitch *sw);
+    void (*get_physical_port_state)(CXLVCSSwitch *sw);
+    void (*physical_port_control)(CXLVCSSwitch *sw);
+    void (*get_virtual_switch_info)(CXLVCSSwitch *sw);
+    CXLRetCode (*bind_vppb)(CXLVCSSwitch *sw, uint8_t vcs_id, uint8_t vppb_id,
+            uint8_t dsppb_id, uint16_t ld_id);
+    CXLRetCode (*unbind_vppb)(CXLVCSSwitch *sw, uint8_t vcs_id, uint8_t vppb_id,
+            uint16_t option);
+};
+
+/* CXL r3.2 Table 7-32: Get Virtual CXL Switch Info VCS Info Block Format */
+typedef struct CXLVPPBInfo {
+        PCIDevice *dsp;
+        uint8_t binding_status;
+        uint8_t bound_port_id;
+        uint8_t bound_ld_id;
+        uint8_t rsv1;
+} CXLVPPBInfo;
+
+typedef struct CXLVCSInfoBlock {
+        uint8_t vcs_id;
+        uint8_t vcs_state;
+        uint8_t usp_id;
+        uint8_t num_vppbs;
+        struct CXLVPPBInfo *vppbs[CXL_MAX_VPPB_PER_VCS];
+} CXLVCSInfoBlock;
+
+/* Physical Upstream and Downstream PCI-PCI Bridge (PPBs) structs */
+typedef struct CXLUpstreamPPB {
+    CXLUpstreamPort   *usp;
+    struct CXLVCSInfoBlock *info;
+} CXLUpstreamPPB;
+
+typedef struct CXLDownstreamPPB {
+    DeviceState *dev;
+    PCIDevice   *pdev;
+    // store opts and json in case of simple device hiding.
+    QDict       *opts;
+    bool        from_json;
+    bool        is_bound;
+    uint8_t     bound_vcs_id;
+    uint8_t     bound_vppb_id;
+} CXLDownstreamPPB;
+
+typedef struct CXLVCSSwitch {
+    Object parent;
+    uint8_t num_usp_ppbs;
+    uint8_t num_dsp_ppbs;
+    uint8_t num_vppbs_per_vcs;
+    CXLCCI swcci;
+    CXLCCI mctpcci;
+    DeviceListener listener;
+    CXLUpstreamPPB *usp_ppbs[CXL_MAX_USP_PPBS];
+    CXLDownstreamPPB *dsp_ppbs[CXL_MAX_DSP_PPBS];
+    // true if FM is in this guest, false if remote FM.
+    bool local_fm;
+} CXLVCSSwitch;
+
+// Called by USP/DSP/EP CXL devices to build the VCS structures.
+void cxl_vcs_register_usp(CXLVCSSwitch *sw, CXLUpstreamPort *usp, Error **errp);
+void cxl_vcs_register_vppb(CXLVCSSwitch *sw, CXLUpstreamPort *usp,
+        CXLDownstreamPort *dsp, Error **errp);
+void cxl_vcs_register_dsppb(CXLVCSSwitch *sw, const QDict *opts,
+        bool from_json, Error **errp);
+void cxl_vcs_register_qdict_dsppb(CXLVCSSwitch *sw, const QDict *opts,
+        bool from_json, Error **errp);
+bool cxl_vcs_hide_device_listener(DeviceListener *listener,
+        const QDict *device_opts, bool from_json, Error **errp);
+
+
+// Called by the CCI mailbox utils for FMAPI control of VCS.
+CXLRetCode cxl_vcs_bind_vppb(CXLVCSSwitch *sw, uint8_t vcs_id, uint8_t vppb_id,
+        uint8_t dsppb_id, uint16_t ld_id);
+CXLRetCode cxl_vcs_unbind_vppb(CXLVCSSwitch *sw, uint8_t vcs_id,
+        uint8_t vppb_id, uint16_t option);
+void cxl_vcs_identify_switch_device(CXLVCSSwitch *sw);
+void cxl_vcs_get_physical_port_state(CXLVCSSwitch *sw);
+void cxl_vcs_physical_port_control(CXLVCSSwitch *sw);
+void cxl_vcs_get_virtual_switch_info(CXLVCSSwitch *sw);
+
+#endif /* CXL_VCS_SWITCH_H */
diff --git a/qapi/qom.json b/qapi/qom.json
index 6f5c9de0f0..f66ef6b68b 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -357,6 +357,23 @@
   'data': { 'chardev': 'str' },
   'if': 'CONFIG_VHOST_CRYPTO' }
 
+##
+# @CXLVCSSwitchProperties:
+#
+# Properties for cxl-vcs-switch objects.
+#
+# @usp-ppbs: number of physical upstream PPBs in the switch
+# @dsp-ppbs: number of physical downstream PPBs in the switch
+# @local-fm: true if this instance of qemu contains the MCTP device
+# (FM capabilities), false if vcs will listen for incoming traffic
+# from the remote FM.
+##
+{ 'struct': 'CXLVCSSwitchProperties',
+  'data': {
+    '*usp-ppbs': 'uint8',
+    '*dsp-ppbs': 'uint8',
+    '*local-fm':   'bool'} }
+
 ##
 # @DBusVMStateProperties:
 #
@@ -1194,6 +1211,7 @@
     'cryptodev-backend-lkcf',
     { 'name': 'cryptodev-vhost-user',
       'if': 'CONFIG_VHOST_CRYPTO' },
+    'cxl-vcs-switch',
     'dbus-vmstate',
     'filter-buffer',
     'filter-dump',
@@ -1272,6 +1290,7 @@
       'cryptodev-backend-lkcf':     'CryptodevBackendProperties',
       'cryptodev-vhost-user':       { 'type': 'CryptodevVhostUserProperties',
                                       'if': 'CONFIG_VHOST_CRYPTO' },
+      'cxl-vcs-switch':             'CXLVCSSwitchProperties',
       'dbus-vmstate':               'DBusVMStateProperties',
       'filter-buffer':              'FilterBufferProperties',
       'filter-dump':                'FilterDumpProperties',
-- 
2.47.3


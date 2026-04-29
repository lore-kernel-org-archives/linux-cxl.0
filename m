Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDF149C7B
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471089; cv=none; b=IWoNWva2N4w/MDVybVAj+Y1IjX8uNRcQZvfJ/C7Tip9i/p2i9uHCaXA6tps/X2l0JLXPXshP03EFivLkEUhUG0AjpHDZrVDC6cpN+Kih9zRXDANPZnzEu8dFxyF/SIrmrNFDKdfEGtqm8EG2UM+7fCYxIu5JTs2EQBGW8GkzDLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471089; c=relaxed/simple;
	bh=AlYJNf4S6cNo+uTNwY0uxj3LsIAkOGUrIcBX3UMGfVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVKoeB9XJXnW7CUqr9E8TxW+31rfctH9ylWnAUHcqWe2FtL3h+bneS7Vqqy0EA6B4/X5O3k8s5Z9tb/B83XSL22Xx3y5r2mzIxJbxgHYLKLSgB4duOi6I5U8ppgdFoax9m5Rf8Nxyc2xYflMiG7TFdEZuhdkD5bSelP09Ai+0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhrtG3/o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhrtG3/o"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so91854335e9.0
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471086; x=1778075886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+pbmHQ9yiYCeLpJXoN1CgDASSe1tTJT9TMuxTLM8RU=;
        b=PhrtG3/o2ZwZrntUPRomxV+zfKaCT9EuD4PfxCzCglYaOiLXkwjNrYort6d5eBywJD
         xM1ZZ+1oWyytX3JfzcvXrwFPw4Rc0K356ufXfcUKEuQ9Hb60eTi1wDCkhdvzRG72kxpM
         QcpKYVpC9HxV12HMVogAg85ng4oMnef/YkvU1bKZZDa8K0i+PktEG8Fs7c70FZHeeSWp
         0W6aBGKeUZgwPjFMXhNcRPokv8dgpUirfmsB29ZBSWWqvQnJqGouSXMB7Jk0P8m4wL88
         Q31o85ZW0yoyaAPtTk7CHBcOr9qWsITMEjrgillXg2w/eAHeZUl4UbEfOx2m9NN2QeBk
         WTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471086; x=1778075886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M+pbmHQ9yiYCeLpJXoN1CgDASSe1tTJT9TMuxTLM8RU=;
        b=s5jo6xWOMpG2YUu4qSI7z38VbuX/f/+/oQaZ/T8lo5L2B+FYeUPIZHgQC6m24mlqta
         wsFXu0lcHq/HClKBUT6TlKhudYYw1nqxlYwuP4gW91A9mUnfS2g/4msh8mcIJ4aoWsKS
         XuTj8tjBGR46dtaum4GdiZUvYi9a3isSi0BlQDldiC3M90B+iH+jwR3SgFhFLtACCtpK
         PeVLrR3RhrJyCmuaE2ag66oRclPa5b4ZHro/wkuxdjLUSELwT9CPnsGDzSpf7kpgqVOq
         bqor/Psa/R6YBmq3JVth6cp+H+oFSWYmvamZpXnTRe9nsXJWVMkLV2MhsdOqyPuaTHLA
         o45g==
X-Gm-Message-State: AOJu0YwGVdrT0ID2Hm/GZcufpQfwxQdmQrls4/b2wpipyE/T84Svyx3Q
	hfNdO/QWVw9Mfo/Az+ViUpCDfwshgVJzwpXjBFVopQsMRjHkyWTlwHtrOSxSrhN8
X-Gm-Gg: AeBDievUZteJCmiIi83/UQtZ/GEbOe4AGEdTKMeJBmPCSgy3hRVvwG1xMAIvpc1brHh
	zJHrO7eh9EqbW80clSV2KrHgqCaMk7WVwp+LG313s4Rx4MvczeYXX4Ecwc+MyKu9U2GZ1hNOGff
	dgNwu4jxHtU1NjHiKDSyuM7JNFxtvh7aSuxgBrqSrzyLhQWiSNDLz8UnI7WgJFukbIne330g0pz
	OfcT5FESq83sNlYOH/YjLp2IhiNWjFnFFxah1he5DW/jlOnyNvQQnLP/F0PBLnPmwB+EzJa0Rt2
	jI4wEklESoDjiRyl3WpT7ma+8/wd3jIBUs58qsgoC/AaOQQlTkq1gFvWMEtniSOOmjeRDNILH/K
	uN7sEHWYCDuxM8K91ehiynESi4WvPcHmjtGJdc0QAl12lQr4YOs3S0vmIn6DX1pMziTSQpt6JJq
	JCvJ04t3cbJmw+WfJnolnJTv0etEb1W7wLswWfjcpHHqLPlGFK8SKj26eFH1YsNJh+9Ogd53Pr
X-Received: by 2002:a05:600c:630a:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-48a77b19d7dmr144546745e9.22.1777471085901;
        Wed, 29 Apr 2026 06:58:05 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:58:05 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com,
	arpit1.kumar@samsung.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 09/10] cxl-mailbox-utils: Add support for VCS bind/unbind commands.
Date: Wed, 29 Apr 2026 14:48:43 +0100
Message-ID: <20260429135717.3048713-10-joshualant@gmail.com>
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

Adds support for FMAPI commands 0x5201 and 0x5202, for more
information see CXL Specification v3.2 (7.6.7.2.2 and 7.6.7.2.3).

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 81 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 779138cdc8..cf6cb65eb6 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -27,6 +27,7 @@
 #include "system/hostmem.h"
 #include "qemu/range.h"
 #include "qapi/qapi-types-cxl.h"
+#include "hw/cxl/cxl_vcs_switch.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -121,6 +122,9 @@ enum {
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
         #define PHYSICAL_PORT_CONTROL       0x2
+    VIRTUAL_SWITCH = 0x52,
+        #define BIND_VPPB     0x1
+        #define UNBIND_VPPB       0x2
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
     FMAPI_DCD_MGMT = 0x56,
@@ -821,6 +825,51 @@ static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
     }
 }
 
+/* CXL r3.2 Section 7.6.7.2.2: Bind vPPB (Opcode 5201h) */
+static CXLRetCode cmd_bind_vppb(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    struct cxl_fmapi_bind_vppb_req_pl {
+        uint8_t vcs_id;
+        uint8_t vppb_id;
+        uint8_t physp_id;
+        uint8_t rsvd;
+        uint16_t ld_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    if(!cci->vcs) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    // Multi-logical device currently not supported (force 0xFFFF).
+    if(in->ld_id != CXL_UNSUPPORTED_LD_ID) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    return cxl_vcs_bind_vppb(cci->vcs, in->vcs_id, in->vppb_id,
+            in->physp_id, CXL_UNSUPPORTED_LD_ID);
+}
+
+/* CXL r3.2 Section 7.6.7.2.3: Unbind vPPB (Opcode 5202h) */
+static CXLRetCode cmd_unbind_vppb(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    struct cxl_fmapi_bind_vppb_req_pl {
+        uint8_t vcs_id;
+        uint8_t vppb_id;
+        uint16_t option;
+    } QEMU_PACKED *in = (void *)payload_in;
+    if(!cci->vcs) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    return cxl_vcs_unbind_vppb(cci->vcs, in->vcs_id, in->vppb_id, in->option);
+}
+
 /* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
 static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
@@ -4903,6 +4952,36 @@ static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_vcs_mctp[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
+    [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
+        cmd_infostat_bg_op_sts, 0, 0 },
+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
+        cmd_infostat_bg_op_abort, 0, 0 },
+    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
+    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
+                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
+                              0, 0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = { "IDENTIFY_SWITCH_DEVICE",
+        cmd_identify_switch_device, 0, 0 },
+    [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
+        cmd_get_physical_port_state, ~0, 0 },
+    [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
+        cmd_physical_port_control, 2, 0 },
+    [VIRTUAL_SWITCH][BIND_VPPB] = { "BIND_VPPB",
+        cmd_bind_vppb, ~0, 0 },
+    [VIRTUAL_SWITCH][UNBIND_VPPB] = { "UNBIND_VPPB",
+        cmd_unbind_vppb, ~0, 0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, 0 },
+};
+
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                 size_t payload_max)
 {
@@ -4915,7 +4994,7 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
 void cxl_initialize_vcs_mctpcci(CXLCCI *cci, CXLVCSSwitch *vcs, DeviceState *d,
         DeviceState *intf, size_t payload_max)
 {
-    cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
+    cxl_copy_cci_commands(cci, cxl_cmd_set_vcs_mctp);
     cci->vcs = vcs;
     cci->d = d;
     cci->intf = intf;
-- 
2.47.3


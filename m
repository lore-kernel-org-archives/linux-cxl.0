Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002737D11E
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471090; cv=none; b=iKpSjYKjw5b43iXBKvLS4d2fHcsaZ+tSWVFU8fVbungoWtR2MYK27G81uNqso2gElLuP8t33CXhKOmrCDzSEqO1u1JCHdxQA4XtfRRekUXaV9MZmgKZbsR3M24BRNuCQo4LZe0OczbeQ345wXoyVCpnSZHP7QC1Ixw8K4yZmSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471090; c=relaxed/simple;
	bh=U5WeJ7YWb6BTaKeQvIe4vaMtHXrdiAfjQMJvbersvXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXUYQqsfaqdjh7e/a370gQ0BdtL2S/UHD4+VBBp1dbmEg5HvetPGvhobQQxHW45ow/5w5SHCEufpeld0zb4grv8SAIu3pjUwo3DqEMJV3IrCdXBww/jNBZ72+ZGKrYJMWwB5zUfQOuWQ8yaixLHXyH0vPRrHZyxRL1mP0VQj4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwbjBRVG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwbjBRVG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso6227935f8f.2
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471087; x=1778075887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GFfGXV4KJXeG6fIZzHANOu097akFBzGO6N4Zi5g/KA=;
        b=GwbjBRVGauTnXA6O2LXtERa34OX6s5NpIFeDS2C5z7uqki0RLE1rxlMZoaKIzf1+XI
         1NnJFvyjCJT4WFLAiioaTKfcGkjzVFUVTrfEQfCkR12Xap3VoSc5CxjIZzdWLnYdzF7t
         Hmuu4cObBNVzp52iLzJG4XXNwFcxAHKDEUHX/OyMYeGoRvAkSx2Ud/vDWaxHNHZW2MNw
         VHfrT9eext/yKyXMR2YmAYZdVNq2Le1RWyn819WuvtWQZ/+2sIveMyniS7m5Hv76xJJB
         RNVMp3O/m9Ek/T8t7wuYBCWmzULVlactFB74SWOZN56hKRhILQ3P3DHKaQdsEc1MGPUM
         kDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471087; x=1778075887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1GFfGXV4KJXeG6fIZzHANOu097akFBzGO6N4Zi5g/KA=;
        b=mILyCn5vskUtpmwMeAYbAFZXOTvZxtU3//A7RX4Wi2QCFSAeVFrHUfNkArc1yAQYnv
         IhHK8B3YZRJBVlbxswMUq/PP7BIs85pUBXP5qQjmF7ixw4XD+ok6nXKkNL/eG4kGAyvr
         ttB7BWZ68Ix/Tu7KsGSFITxxFeZDkiI6xDCSqVTqKpplJ9bgr2sdKSdApHT4fqxlqAsG
         kDGSR8hVDreJOs4hIlGU8sr7Q8GQ2lQohtrxvJvpYoeqDXs2QfYDHIrvWA6WOFl8b1pZ
         S+OKAgeb6PmA8vil/U0O/VgtdGHIVoqlBcSYF2O8Ez4bb8rdT4dJdnfsDOvpJgksg/sH
         /N7A==
X-Gm-Message-State: AOJu0YwzVm63QK6b2DO08Z6n4LGPvMCL51oXCY17mGbFSmWqOJamZMmr
	TchqBJ0FcCPySGc65BedCkPk+oAFsleOgCRB/fmQHVup/t2PQ9EnRYfC+IpPREif
X-Gm-Gg: AeBDieuMraiDejOhwAKsl9bUf5rrlHTgEBrJ90VtEgRW6mGLZgucBgtpwBZMAmJGw2m
	qejm41eMddCvkROCwjOAnm8M+JY6QMbrT4qz+1YZUgfPCxcd/UCLUHC3F79qpV1/FAxHn63em0h
	sFwbLR+yOpiLbOqT6w7007Ra5zlXF3b0HN34J+N6FOuVNomMYRJg143ugCkcY1lPr/CnWxJnLGM
	XnWj8Sx0xxc1rA46BySGrcNZCXFlbsQt/Kj1gcGBx6osFG14rFYdurmMFT6AIIFWe7TppmJG6Cw
	dQbg9VYk1N43dpu/2CuZDwruvJNl86ErhmcyfFEyQmPyTQ1SjoHTpwm2ph/OtzsgUpmRACZvrmH
	eqgKp0I2Ix5uZbLjvZQ2hCperBiZb6nbDmC9mXJb+GFD45r2Ql7FvRshELRY8apaKa5KEO/8+Ti
	0ZPUWlZbKy/7Vb9OpNXRWrOo9Kqo+UWE1weSR74k3x+rb/BHR0zHvnwC2tWzgIOVsptcZC4Ob48
	LQCknPNdMU=
X-Received: by 2002:a05:6000:2584:b0:43c:ff58:35c2 with SMTP id ffacd0b85a97d-44648b511c6mr14263882f8f.20.1777471086695;
        Wed, 29 Apr 2026 06:58:06 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:58:06 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com,
	arpit1.kumar@samsung.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 10/10] cxl-mailbox-utils: Add support for VCS Get Virtual CXL Switch Info command.
Date: Wed, 29 Apr 2026 14:48:44 +0100
Message-ID: <20260429135717.3048713-11-joshualant@gmail.com>
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

Adds support for FMAPI command 0x5200, for more
information see CXL Specification v3.2 (7.6.7.2.1).

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 84 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index cf6cb65eb6..825ef35179 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -123,6 +123,7 @@ enum {
         #define GET_PHYSICAL_PORT_STATE     0x1
         #define PHYSICAL_PORT_CONTROL       0x2
     VIRTUAL_SWITCH = 0x52,
+        #define GET_VIRTUAL_SWITCH_INFO      0x0
         #define BIND_VPPB     0x1
         #define UNBIND_VPPB       0x2
     TUNNEL = 0x53,
@@ -825,6 +826,87 @@ static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
     }
 }
 
+/* CXL r3.2 Section 7.6.7.2.1: Get Virtual CXL Switch Info (Opcode 5200h) */
+static CXLRetCode cmd_get_virtual_switch_info(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    struct cxl_fmapi_get_virtual_switch_info_req_pl {
+        uint8_t start_vppb;
+        uint8_t vppb_list_limit;
+        uint8_t number_of_vcs;
+        uint8_t vcs_id_list[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct vppb_info {
+            uint8_t binding_status;
+            uint8_t bound_port_id;
+            uint8_t bound_ld_id;
+            uint8_t rsv1;
+    } QEMU_PACKED;
+    struct vcs_info_block {
+            uint8_t vcs_id;
+            uint8_t vcs_state;
+            uint8_t usp_id;
+            uint8_t num_vppbs;
+            struct vppb_info vppbs[];
+    } QEMU_PACKED;
+    struct cxl_fmapi_get_virtual_switch_info_rsp_pl {
+            uint8_t num_vcs;
+            uint8_t rsv1[3];
+            struct vcs_info_block vcs_info_list[];
+    } QEMU_PACKED *out = (void *)payload_out;
+
+    uint8_t num_vcs_ret = cci->vcs->num_usp_ppbs;
+    uint8_t num_vppbs_ret;
+    ssize_t len_out_tmp = *len_out;
+    len_out_tmp = sizeof(struct cxl_fmapi_get_virtual_switch_info_rsp_pl) +
+        (num_vcs_ret * sizeof(*out->vcs_info_list));
+    for(int i = 0; i < num_vcs_ret; i++) {
+        //num_vppbs_ret = get_num_vppbs_in_vcs(cci->d, i);
+        num_vppbs_ret = cci->vcs->usp_ppbs[i]->info->num_vppbs;
+        //vPPB List Entry Count=min(vPPB List Limit, Number of vPPBs).
+        len_out_tmp = (num_vppbs_ret <= VPPB_LIST_LIMIT) ?
+                len_out_tmp + (num_vppbs_ret * sizeof(struct vppb_info)) :
+                len_out_tmp + (VPPB_LIST_LIMIT * sizeof(struct vppb_info));
+    }
+    *len_out = len_out_tmp;
+
+    out->num_vcs = num_vcs_ret;
+    out->rsv1[0] = 0;
+    out->rsv1[1] = 0;
+    out->rsv1[2] = 0;
+
+    uint8_t *ptr = (uint8_t *)out->vcs_info_list;
+
+    for (int i = 0; i < num_vcs_ret; i++) {
+        CXLVCSInfoBlock *info = cci->vcs->usp_ppbs[i]->info;
+        uint8_t num_vppbs = info->num_vppbs;
+        uint8_t vppb_count = MIN(num_vppbs - in->start_vppb,
+                                 in->vppb_list_limit);
+
+        /* write fixed vcs_info_block header (4 bytes) */
+        *ptr++ = info->vcs_id;
+        *ptr++ = info->vcs_state;
+        *ptr++ = info->usp_id;
+        *ptr++ = num_vppbs;
+
+        /* write vppb entries for current vcs */
+        for (int j = in->start_vppb; j < in->start_vppb + vppb_count; j++) {
+            struct vppb_info *v = (struct vppb_info *)ptr;
+            v->binding_status = info->vppbs[j]->binding_status;
+            v->bound_port_id  = info->vppbs[j]->bound_port_id;
+            v->bound_ld_id    = info->vppbs[j]->bound_ld_id;
+            v->rsv1           = 0;
+            ptr += sizeof(struct vppb_info);
+        }
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.2 Section 7.6.7.2.2: Bind vPPB (Opcode 5201h) */
 static CXLRetCode cmd_bind_vppb(const struct cxl_cmd *cmd,
                                             uint8_t *payload_in,
@@ -4974,6 +5056,8 @@ static const struct cxl_cmd cxl_cmd_set_vcs_mctp[256][256] = {
         cmd_get_physical_port_state, ~0, 0 },
     [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
         cmd_physical_port_control, 2, 0 },
+    [VIRTUAL_SWITCH][GET_VIRTUAL_SWITCH_INFO] = { "GET_VIRTUAL_SWITCH_INFO",
+        cmd_get_virtual_switch_info, ~0, 0 },
     [VIRTUAL_SWITCH][BIND_VPPB] = { "BIND_VPPB",
         cmd_bind_vppb, ~0, 0 },
     [VIRTUAL_SWITCH][UNBIND_VPPB] = { "UNBIND_VPPB",
-- 
2.47.3


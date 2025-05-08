Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804C4AEE0
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663542; cv=none; b=LTqlTMwD/1o9K2/7s7tJdKmpxTmOZnIHrB2P5T4e+bz/lwSgG8IFetbGK5VxugzRL6sidSelA066HH33c/WYO9YqWY84Y4I5+eJvVRyhjTOyR+t38SZoOnXfnaNUi+RzQfSHM/Y+1hfaRIoXXREzRogPxIQ990DW/vl6EVwn+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663542; c=relaxed/simple;
	bh=ONy1SuDXFkiJoezXHWEMk6/r46yMZ6r7KRY0vZr24uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2wlYnf92tD4SQDJMMn4T5vVJmB9KlNqxs7/FHQ10Cl+jEww4vmUeaiBnEAJBIixMEIWXHST/N7HiUK5Xdd5rEThE7eloh4J5y9VMdDiwi+3OzGRE1WGEFRvCUk+xYnQEcz2XyJmcpc19iKrySpbisYDVG1LeM1Gf0K3rdoNDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho0O42qX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho0O42qX"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-739be717eddso393829b3a.2
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663540; x=1747268340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A8Zt1gtvNZ8hmAUUEFU2ZRiAZPfj22eHGeqJsXNBa4=;
        b=ho0O42qXVa982a5qcLop/ysg9gethq0J3hk0hJAsa8VZxGf28VQHrUoxKxDeYYaqZS
         xubhaLN95cp4il+kaHwpZwlCFPyjYADWCLTPNmrxDY30znQpo3dkG8SJ3Qtp1CCE3kut
         Itoc0lu5GdsPxT1Dve0cNsjZlGcHFDSvA6ewIoXMkzdcxobOUH7f2bs+6BkUUPZE1c6N
         wWCDe67GqPGgK5hfLAp3d17pHpXJMeBugijdT11vYzPh68C7nono0dyBTcrYPkM7s51i
         Gpqmi16+UZfPzDEEYueLOV9C8/h52U8cvgI+1Entapca3M7kuyms7iCUFJ1JvOKG+KAd
         yhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663540; x=1747268340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A8Zt1gtvNZ8hmAUUEFU2ZRiAZPfj22eHGeqJsXNBa4=;
        b=woRHzxne0dk+WioEJ0a5DNvjDa4Q+lLQe+cbcI2B8jh3fy4ve5XKAsP7DJcx1kUfs+
         XiJ6Rf0/YUiTUTIM70WD3BSC+hcVLTexO9bwFJ1hUieg2qtgDPRBQ0jjkpGgN5Uxn2UX
         cP/wqT41Yq85Yc6noXhJopEIafRQlJEEBCrq/JFzjArEkX14rGNlnpl4Je8d0FGJ06yr
         PP8un80czcMW7OzOQyKpdr9f91gerBnoynJ2SA+Z8rjEsUOvNWshnhFZOwjBsy/pa/8m
         gqwpy5GE4yVPlkwEjuXH62WFaKx2VKzj+i2gtl2lhAAh3knEeQ8CBE47GdB+DX6B0IwV
         Mhzw==
X-Forwarded-Encrypted: i=1; AJvYcCWmcRyrwIe3/c1LLFsm+iCjYEhfgRmK455hVpde5vJ4OZwn/L3m1vKcw3I7iSrPc+l0cVOj5e4tJnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0wm3z0U/q+2PM2BXErWXz7TEja+DrE7NaRw3Wv7m+5CpIemha
	Ru88y3lilYR9loVFzUE4w2WTotgo8oGaW3ZLl4cYaJo1Tr5YPPcn
X-Gm-Gg: ASbGnctzueZHnMfevD4dGI9pzvwyf/xuiFGS+zLlnx/XhLxU871dfUrKtCRX9MnQpLD
	dMAVeOWNzQ9TaehhYNNykJg97vf3A5v1INVGidQ5TFShnEM/0YxFx89aOePmgedmiOkMIeF9Fo4
	saM6XHz4qyUlEm4+OGGN5gs+etqWef06Qr2dp34AzsWhALFUTbfffxc0J83Y8VxuTO/otgnA5+d
	n9k38JQTAbdQiTJhYdj1ygBth8mUFtnI8EWtYVX8YLRtfrU3c+oH9FFl7/cUYQfHU567r4Fkkm4
	k03vvrqG4y2c9RsTXn1g+kZCKJGYfLjUdoVOle3+Bcpa+4TG/Wg0UB8kK6jAdqYUnOIL3Ipz
X-Google-Smtp-Source: AGHT+IEi42U6TnplQIeu2dkTaoQ02oUhOLfxnPpKuuJgEx9azbuVWKbt4/AhpRMe6fmR3FqpUB7tfA==
X-Received: by 2002:a05:6a00:ad8f:b0:739:4a30:b900 with SMTP id d2e1a72fcca58-7409cef9989mr6628104b3a.7.1746663539784;
        Wed, 07 May 2025 17:18:59 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:59 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 10/10] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
Date: Thu,  8 May 2025 00:01:06 +0000
Message-ID: <20250508001754.122180-11-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 56 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_opcodes.h |  1 +
 2 files changed, 57 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9b176dea08..28266b16f7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3638,6 +3638,10 @@ static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
                                                ext.start_dpa, ext.len)) {
                 return CXL_MBOX_INVALID_EXTENT_LIST;
             }
+        } else if (type == DC_EVENT_RELEASE_CAPACITY) {
+            if (!ct3_test_region_block_backed(dcd, ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_PA;
+            }
         }
     }
 
@@ -3777,6 +3781,51 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x7
+/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
+static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t flags;
+        uint8_t reg_num;
+        uint64_t length;
+        uint8_t tag[0x10];
+        uint32_t ext_count;
+        CXLDCExtentRaw extents[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    int rc;
+
+    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
+    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
+        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
+                                                   in->host_id,
+                                                   in->ext_count,
+                                                   in->extents,
+                                                   DC_EVENT_RELEASE_CAPACITY);
+        if (rc) {
+            return rc;
+        }
+        cxl_mbox_create_dc_event_records_for_extents(ct3d,
+                                                     DC_EVENT_RELEASE_CAPACITY,
+                                                     in->extents,
+                                                     in->ext_count);
+        return CXL_MBOX_SUCCESS;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+            "CXL extent selection policy not supported.\n");
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3919,6 +3968,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
+        cmd_fm_initiate_dc_release, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index 72ea0a7d44..7ac6cb9f34 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -67,5 +67,6 @@ enum {
         #define SET_DC_REGION_CONFIG 0x2
         #define GET_DC_REGION_EXTENT_LIST 0x3
         #define INITIATE_DC_ADD           0x4
+        #define INITIATE_DC_RELEASE       0x5
     GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2


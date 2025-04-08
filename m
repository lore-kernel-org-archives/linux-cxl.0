Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1D35973
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086723; cv=none; b=ZRrNLQ4XFTpmILEQOTj7owvA3DfqsCQnL7grxDL7ZdSsF+o9QEOGNt40Pe9u/9BmLoP21QW2jgeDGPYDDB+kLXleIE/9ArhkvocUe0hFtqbtEU/7L/8pR8UAM5WQnUao+gjVZXCGHgVO6LhReer3bOZSoVeQXiZJhuquGeCwfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086723; c=relaxed/simple;
	bh=Mv1uaPeOvXggx9BSRK4Jh0TCI4Lypi5hka+PMbJ0Tiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nx7vI8WEzybrt8WSI8psvNXSjEL9esyRdUo+ReBl9eA3BmGdubzI/nz9CJM0D3gRs2EeDVcptOk94+rVa50IeF9nwtWxgNVn2tHVG6SP4mEfdHWNZefiIWXyWi6bvf+1brE1Sv+7OrViJUJAi9rKcG8FBDMrujs9sA8rRa8JFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf7L3aEr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf7L3aEr"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227b828de00so49295955ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 07 Apr 2025 21:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744086721; x=1744691521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFsyiFKRhSvGR0pMC95Wd+px084AVEIKUIaNuSDojhQ=;
        b=Pf7L3aErVCmrcD9v4JUk3ir/pRRs8Xn2zAP10LFA/9G/x2AGKh+/skayPRcfW2Av2J
         MWkd+VaY6OMwQzq2bIvNlA7rLu4NoIUMlGTbtrvvBqpqw/f3hSFkbgYdUfAZmCky7aC3
         MwJ/IM7l6v9dR9f6rcs7QdrXabdTr5HwzLRo8sZfi4bW9yjKjHAnA3pGul0KDn9xqDPf
         lKJHHWikXFZ39S7LjUq+irKvFgWgJdgZQKZwaRCFzlQXwJVnAE5/xqrPbTO6bxvZiw3M
         vOD5r4Bdj/kHZXJD9WEjiNdn7jsnbkYX+n9QP5ewIHAk8o72wwskDVDM6rU9zMTG5Hwi
         vGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744086721; x=1744691521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFsyiFKRhSvGR0pMC95Wd+px084AVEIKUIaNuSDojhQ=;
        b=vz/FwOvlF9RfnemTHL7x6/Wjw22C7a65wk5/SNGOBSc30cGhWCm6r7xl1vTuAdRTxf
         KU/u+2rbyaBokGIr2pnFgg31OyZ6Cg/5OCW7kzS2H3SpkcpafHS0/OUInVSGGxyorE0D
         /XRjcGHIz0kTYQj0zDzjtcX+HA3gFBDHMH17udFGj/1K8pjtcxFpV2KXxDuf9BhysqqE
         y9av6ua8iVmdJEreeaG9jO9SREsae8LQDxwd9vtdWxLpzOrwh+NSNDs4aqrGgKb2sw0n
         Sd7nun94sG4spk2tnEe5UQaxpA0u/MIlmDYQ8Agk1VwtuO/lc3iY1/1STdT/eBYWeF0B
         3l4A==
X-Gm-Message-State: AOJu0YxQ9sijOcm5q8bXeyd75GlLDp+WNvgp1AwtqzB4vPOEFUdEJh6V
	EW5M8JLq7ZDJSMxLBRvIpz4zxxG6s4RSYL804IwJbcMBB9O9HdrU
X-Gm-Gg: ASbGncux4VWqfu2F4acjypDOz5bxN+wbyc97fvlR1CxDvBswcygU1r8UXFUhPslpiYF
	NIhba81LPyRWjUNzUoEsGnFEFNvQ66jwBfHhTAYX8H0JYC/Dz0jq8mT3aG5K62XfqlDmUGQFrSr
	UjQsxezq1XTh39yKLITIyi5zy4/gqS6zOBXiavNZMtj+ycw/f/O4kUSyEVh5OViW/NbgY/8oFMp
	ocTYCZnmg0L4vrqvSh3G3/nFkiIQVNUDRqCF5vbwgJ0vnas4Ho7xPdsNEDmBQlDc2RQstpT7NZ/
	OdeLmkl9oeUcOXHegiI+R5L/F0s9ycQijx5l2DhRG1/pupK1VUks8cWnWMCKlA==
X-Google-Smtp-Source: AGHT+IGGOYorAenJf9WDhLYuxrPuFrkDogX1/FSN2ZuwsnOPs6m3hMh2XFNgWY70xxDdmBZ82edybw==
X-Received: by 2002:a17:902:f610:b0:223:3396:15e8 with SMTP id d9443c01a7336-22a9552b6damr173880685ad.22.1744086720905;
        Mon, 07 Apr 2025 21:32:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e0a9sm90055385ad.149.2025.04.07.21.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 21:32:00 -0700 (PDT)
From: nifan.cxl@gmail.com
To: jonathan.cameron@huawei.com,
	qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	anisa.su887@gmail.com,
	gourry@gourry.net,
	Fan Ni <fan.ni@samsung.com>
Subject: [RFC 1/3] cxl_type3: Preparing information sharing between VMs
Date: Mon,  7 Apr 2025 21:20:28 -0700
Message-ID: <20250408043051.430340-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250408043051.430340-1-nifan.cxl@gmail.com>
References: <20250408043051.430340-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Add two data structures for sharing information between multiple VMs.
The global cci_map_buf is used to provide mappings between cci name and cci
pointer.
Each VM has its own cci_map_buf. However, since we expect the two VMs share
the same configuration, the same CCI name should points to its own CCI.
On the FM, we need to use the cci pointer to find the cci name.
While on the test VM, we use the name to find cci pointer for MCTP
message process.
The mctp_shared_buffer is used to pass MCTP command information between
FM and test VM for QMP command process.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c                | 125 +++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h       |   6 ++
 include/hw/cxl/cxl_mctp_message.h |  40 ++++++++++
 3 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/cxl/cxl_mctp_message.h

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 11c38a9292..7f85616ca1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -29,6 +29,9 @@
 #include "system/numa.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
+#include "hw/cxl/cxl_mctp_message.h"
+
+struct CXLCCINamePtrMaps *cci_map_buf;
 
 /* type3 device private */
 enum CXL_T3_MSIX_VECTOR {
@@ -998,6 +1001,97 @@ static void init_alert_config(CXLType3Dev *ct3d)
     };
 }
 
+static int ct3_mctp_buf_open(const char *filename, int flags)
+{
+    char name[128];
+    snprintf(name, sizeof(name), "/%s", filename);
+    return shm_open(name, flags, 0666);
+}
+
+static int ct3_mctp_buf_unlink(const char *filename)
+{
+    char name[128];
+    snprintf(name, sizeof(name), "/%s", filename);
+    return shm_unlink(name);
+}
+
+static struct CXLMCTPSharedBuf *ct3_mctp_buf_map(int fd, int size)
+{
+    void *map;
+
+    if (fd < 0) {
+        return NULL;
+    }
+
+    map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+    if (map == MAP_FAILED) {
+        return NULL;
+    }
+
+    return (CXLMCTPSharedBuf *)map;
+}
+
+
+static int ct3_mctp_buf_create(const char *filename, size_t size)
+{
+    int fd, rc;
+
+    fd = ct3_mctp_buf_open(filename, O_RDWR | O_CREAT);
+    if (fd == -1) {
+        return -1;
+    }
+
+    rc = ftruncate(fd, size);
+
+    if (rc) {
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
+
+static int ct3_setup_mctp_command_share_buffer(CXLType3Dev *ct3d, bool create)
+{
+    int fd;
+    int size = sizeof(*ct3d->mctp_shared_buffer);
+    sprintf(ct3d->mctp_buf_name, MCTP_MESSAGE_BUF_NAME);
+
+    if (create) {
+        fd = ct3_mctp_buf_create(ct3d->mctp_buf_name, size);
+    } else {
+        fd = ct3_mctp_buf_open(ct3d->mctp_buf_name, O_RDWR | O_CREAT);
+    }
+
+    if (fd == -1) {
+        return fd;
+    }
+    ct3d->mctp_buf_fd = fd;
+    ct3d->mctp_shared_buffer = ct3_mctp_buf_map(ct3d->mctp_buf_fd, size);
+    if (ct3d->mctp_shared_buffer) {
+        return 0;
+    }
+    return -1;
+}
+
+static int init_cci_name_ptr_mapping(void)
+{
+    if (!cci_map_buf) {
+        cci_map_buf = g_malloc(sizeof(*cci_map_buf));
+    }
+    return 0;
+}
+
+static void add_cci_name_ptr_mapping(const char *name, void *p)
+{
+    int n = cci_map_buf->num_mappings;
+    struct CXLCCINamePtrMap *map = &cci_map_buf->maps[n];
+
+    strcpy(map->cci_name, name);
+    map->cci_pointer = p;
+    cci_map_buf->num_mappings++;
+}
+
 void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -1108,6 +1202,14 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
         ct3d->ecs_attrs.fru_attrs[count].ecs_flags = 0;
     }
 
+    if (ct3d->allow_fm_attach) {
+        init_cci_name_ptr_mapping();
+        if (ct3d->mctp_buf_init) {
+            ct3_setup_mctp_command_share_buffer(ct3d, true);
+        } else {
+            ct3_setup_mctp_command_share_buffer(ct3d, false);
+        }
+    }
     return;
 
 err_release_cdat:
@@ -1150,6 +1252,15 @@ void ct3_exit(PCIDevice *pci_dev)
     if (ct3d->hostvmem) {
         address_space_destroy(&ct3d->hostvmem_as);
     }
+
+    if (ct3d->mctp_shared_buffer) {
+        munmap(ct3d->mctp_shared_buffer, sizeof(*ct3d->mctp_shared_buffer));
+        close(ct3d->mctp_buf_fd);
+        ct3_mctp_buf_unlink(ct3d->mctp_buf_name);
+        ct3d->mctp_shared_buffer = NULL;
+    }
+    g_free(cci_map_buf);
+    cci_map_buf = NULL;
 }
 
 /*
@@ -1352,6 +1463,16 @@ void ct3d_reset(DeviceState *dev)
     }
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
+    if (ct3d->allow_fm_attach) {
+        char name[64];
+
+        memset(name, 0, 64);
+        sprintf(name, "%lu:%s", ct3d->sn, "oob_mctp_cci");
+        add_cci_name_ptr_mapping(name, &ct3d->oob_mctp_cci);
+        cxl_initialize_t3_fm_owned_ld_mctpcci(&ct3d->oob_mctp_cci,
+                                              DEVICE(ct3d), DEVICE(ct3d),
+                                              MCTP_CXL_MAILBOX_BYTES);
+    }
 }
 
 static const Property ct3_props[] = {
@@ -1372,7 +1493,9 @@ static const Property ct3_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
                                 width, PCIE_LINK_WIDTH_16),
-    DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0), 
+    DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
+    DEFINE_PROP_BOOL("allow-fm-attach", CXLType3Dev, allow_fm_attach, false),
+    DEFINE_PROP_BOOL("mctp-buf-init", CXLType3Dev, mctp_buf_init, false),
 };
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca515cab13..9a00ef7a1e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -707,6 +707,12 @@ struct CXLType3Dev {
     } dc;
 
     struct CXLSanitizeInfo *media_op_sanitize;
+
+    bool allow_fm_attach;
+    bool mctp_buf_init;
+    struct CXLMCTPSharedBuf *mctp_shared_buffer;
+    char mctp_buf_name[64];
+    int mctp_buf_fd;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
diff --git a/include/hw/cxl/cxl_mctp_message.h b/include/hw/cxl/cxl_mctp_message.h
new file mode 100644
index 0000000000..85b3664cf7
--- /dev/null
+++ b/include/hw/cxl/cxl_mctp_message.h
@@ -0,0 +1,40 @@
+#ifndef CXL_MCTP_MESSAGE_H_H
+#define CXL_MCTP_MESSAGE_H_H
+#include<stdint.h>
+
+#define MCTP_CXL_MAILBOX_BYTES 512
+#define MCTP_MESSAGE_BUF_NAME "mctp-message-buf"
+
+struct CXLMCTPCommandBuf {
+    /* uint8_t cci_name[64]; */
+    uint8_t command_set;
+    uint8_t command;
+    size_t len_in;
+    size_t len_out;
+    uint8_t payload[MCTP_CXL_MAILBOX_BYTES];
+    uint8_t payload_out[MCTP_CXL_MAILBOX_BYTES];
+    bool bg_started;
+    int ret_val;
+};
+
+typedef struct CXLMCTPCommandBuf CXLMCTPCommandBuf;
+
+struct CXLCCINamePtrMap {
+    char cci_name[64];
+    void *cci_pointer; /* This should be filled by the target VM */
+};
+
+struct CXLCCINamePtrMaps {
+    int num_mappings;
+    struct CXLCCINamePtrMap maps[32];
+};
+
+struct CXLMCTPSharedBuf {
+    /* set to 1 when sent to target VM and wait for 0 as it completes */
+    int status;
+    CXLMCTPCommandBuf command_buf;
+};
+
+typedef struct CXLMCTPSharedBuf CXLMCTPSharedBuf;
+extern struct CXLCCINamePtrMaps *cci_map_buf;
+#endif
-- 
2.47.2


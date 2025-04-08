Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2535973
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 04:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086729; cv=none; b=A2uomdN941uA93ymBQOlHwZfSgh+fWfhBOJPInDMctvmjSAG+3XhZ6o1JUTGCO50pyaNILBOjH9iRxujpPPQl1hzdKQFt6QH5AmZdTZ9RAcu3ZuCp2F46SIalC1/Cn88jj7vOLAin759oVKauMeBPlSXMQVM8AyEKcPQuq3yH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086729; c=relaxed/simple;
	bh=+rnO808ap5lHjTUneGB/hC1EojP16FWa3rQzJaKUx+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yy1Okc4pd4jOBARO6uJd24ziOPAYvoRwjOgWwIASrVOWvIgvuTCQXI0iJDnh6+gcBO6jTftzopEnE5P+kKgFY7DnSpNkPYq3K6p2yj2zemczZTNskjZu6i2LZ4T7ST3Y685NnfNtP+mYeQ7oCY3GcplkqShNTLkrMHaeRjZ6N0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTO6+hVU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTO6+hVU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227c7e57da2so43135405ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 07 Apr 2025 21:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744086727; x=1744691527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSwDEvS3Dbs2+SGvBtHxNnFhnzrC6dneDlWiT9TyqTk=;
        b=aTO6+hVU3G70ZTfS3c+BYhAl/mdkUTQ0Yy2QGyAXiCwI+9BgKPnjuqotKB1rWm1LC5
         /U865urSMqfpsLX1QE4G3VhKXROA1aGE+lg3dqAWMAC5HopUAA6wi5Ja0Opnb2UIeYpt
         jlbppDy5byAKQBzqC48dLT2L/Ks0xskMbNKhq74tQjzZT+ioLoe54OA9tGrQKWzqRVGJ
         Aaqlv880T3B5eTpBeJjX6P/tqUJgk5/g2+BFQlKxy9BLzLArViA1O6CfQ7qFI4qakhYL
         47MDAl74BFOKCmGX6kPIWnXQq9WRfYDdVwRMRdLR4nBEuw4n6j2dErfRl9NEsQjgj9u6
         +BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744086727; x=1744691527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSwDEvS3Dbs2+SGvBtHxNnFhnzrC6dneDlWiT9TyqTk=;
        b=D2EP1WEI6QDqjoPT41jeHYykrLCSqjp40KDrIEdvYsM7tOPK1d1o6Dx32TbLI7sirp
         Bl2F8cKj2d8lVjKefBH6dSr0hrFVasphd4nlJQfPHjVxbL4D1NUdFZ1Ehf5U/ewqV3Zr
         fbejxm+J9hJobaIcmVrP2d4CP0vPEak/pLKspkGGyoD0Q/1dBFAC+y7TDqjZmm9TJG3W
         1Xmedaoe1hnvjzy1kYggXKjNUvNBchADVGZARZv2JYrsyr9cDRFO6H47V99gfqQ/+xy7
         wRr1/HDecsgbyoUJ6+pHJ8+w9q0pVZiGxSEwev8i9tdZd9SyocLm3b5RTikehOT9BvRp
         CH+A==
X-Gm-Message-State: AOJu0YxGvH8IsrRoYcJ3EI0bhK+sJ4puE0VSdoO8N2UZDCxlj743Ithd
	aUNz1kN5WfHWYuMG0MutxGIA89EeNbtUyW7mMAM6rjrmkvVdSr70
X-Gm-Gg: ASbGncsys3w9p/NfgjTN+XBwx72pXeGSmJ8ZhgdxL/VyncjqMt0K81KmXv++7HQUzJ1
	CFHoqQrRX007AsVnioyEpLJGpArPZgVbW/BxYTzlTrRmCjbtcsCPEqY7kpQxt70lVXQ9igarTvW
	+Og8gg1otPb2DJI1ECrvF99IhXBUqs46twHTMcNBImSltVoNzcMUsKDxJ/csfIJJAjmUhUu/sLu
	rNGbige2dUo/LZJVqMIeyjMVjih0VY+JyLjtkEaC9Ya1Chy6GYvY2h3KldLLG2XEe1vIyLVgcL2
	qKNxZvgkeRBJff1YPsVe7FWFQCn9H4xZHnMOovCwJkxVoLwi5/5FA3ZPdcTmTA==
X-Google-Smtp-Source: AGHT+IHTrhx2ufYDrPtqjHltrCsDJfR6eJB3pAwZNwVKO9HzcZM80ak/RiIojJdvYuZp7wsaTHC+3Q==
X-Received: by 2002:a17:902:da85:b0:224:f12:3735 with SMTP id d9443c01a7336-22a8a06b38dmr161533425ad.31.1744086727355;
        Mon, 07 Apr 2025 21:32:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e0a9sm90055385ad.149.2025.04.07.21.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 21:32:06 -0700 (PDT)
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
Subject: [RFC 3/3] cxl/i2c_mctp_cxl: Add support to process MCTP command remotely
Date: Mon,  7 Apr 2025 21:20:30 -0700
Message-ID: <20250408043051.430340-4-nifan.cxl@gmail.com>
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

With the change, if "mctp-msg-forward" property is turned on for
i2c_mctp_cxl device, we setup a QMP connection to the other VM identified
by the "qmp" property, and forward the MCTP requests to the VM for processing.

Note:
1. The VM with "mctp-msg-forward=on" acts as a FM VM.
2. Before the FM VM is started, the target VM to connect to must be on
   and ready to connect.
3. For the FM VM instance, it needs to share the same CXL topology with
   the VM we want to connect to, and the cxl device to connect needs to
   have "allow-fm-attach=on".

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mctp-qmp.c             | 85 +++++++++++++++++++++++++++++++
 hw/cxl/i2c_mctp_cxl.c             | 68 ++++++++++++++++++++++---
 hw/cxl/meson.build                |  2 +-
 hw/mem/cxl_type3.c                |  4 +-
 include/hw/cxl/cxl_device.h       |  2 +
 include/hw/cxl/cxl_mctp_message.h |  3 ++
 6 files changed, 155 insertions(+), 9 deletions(-)
 create mode 100644 hw/cxl/cxl-mctp-qmp.c

diff --git a/hw/cxl/cxl-mctp-qmp.c b/hw/cxl/cxl-mctp-qmp.c
new file mode 100644
index 0000000000..f0ea5e2cc0
--- /dev/null
+++ b/hw/cxl/cxl-mctp-qmp.c
@@ -0,0 +1,85 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <sys/socket.h>
+#include <stdbool.h>
+
+#include "hw/cxl/cxl_mctp_message.h"
+
+#define BUFFER_SIZE 4096
+
+void read_qmp_response(int sockfd)
+{
+    char buffer[BUFFER_SIZE];
+    memset(buffer, 0, BUFFER_SIZE);
+    int len = read(sockfd, buffer, BUFFER_SIZE - 1);
+    if (len > 0) {
+        printf("QMP Response:\n%s\n", buffer);
+    }
+}
+
+static void send_qmp_command(int sockfd, const char *cmd)
+{
+    send(sockfd, cmd, strlen(cmd), 0);
+}
+
+static void send_qmp_cap_command(int sockfd)
+{
+    const char *cap_cmd = "{ \"execute\": \"qmp_capabilities\" }\n";
+    send_qmp_command(sockfd, cap_cmd);
+    read_qmp_response(sockfd);
+}
+
+static int connect_to_qmp(const char *server, uint16_t port)
+{
+    int sockfd;
+    struct sockaddr_in serv_addr;
+
+    sockfd = socket(AF_INET, SOCK_STREAM, 0);
+    if (sockfd < 0) {
+        return -1;
+    }
+
+    serv_addr.sin_family = AF_INET;
+    serv_addr.sin_port = htons(port);
+
+    if (inet_pton(AF_INET, server, &serv_addr.sin_addr) <= 0) {
+        return -1;
+    }
+
+    if (connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
+        return -1;
+    }
+
+    send_qmp_cap_command(sockfd);
+
+    return sockfd;
+}
+
+int setup_mctp_qmp_connection(const char *qmp_str)
+{
+    char host[256];
+    uint16_t port;
+
+    memset(host, 0, 256);
+    if (sscanf(qmp_str, "%255[^:]:%hu", host, &port) != 2) {
+        return -1;
+    }
+
+    return connect_to_qmp(host, port);
+}
+
+void qmp_cxl_mctp_process_cci_message(const int sockfd, const char *cci_name)
+{
+    char command[256];
+
+    memset(command, 0, 256);
+    sprintf(command, "{ \"execute\": \"cxl-process-mctp-message\", \
+                             \"arguments\": { \
+                             \"cci-name\": \"%s\" \
+}}\n", cci_name);
+    send_qmp_command(sockfd, command);
+    read_qmp_response(sockfd);
+}
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
index 7d2cbc3b75..e146fa2039 100644
--- a/hw/cxl/i2c_mctp_cxl.c
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
+#include "hw/cxl/cxl_mctp_message.h"
 
 #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
 
@@ -83,6 +84,10 @@ struct I2C_MCTP_CXL_State {
     int64_t pos;
     uint8_t buffer[MCTP_CXL_MAX_MSG_LEN];
     uint8_t scratch[MCTP_CXL_MAX_MSG_LEN];
+    char *qmp_str;
+    int qmp_fd;
+
+    bool mctp_msg_forward;
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(I2C_MCTP_CXL_State, I2C_MCTP_CXL)
@@ -90,6 +95,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(I2C_MCTP_CXL_State, I2C_MCTP_CXL)
 static const Property i2c_mctp_cxl_props[] = {
     DEFINE_PROP_LINK("target", I2C_MCTP_CXL_State,
                      target, TYPE_PCI_DEVICE, PCIDevice *),
+    DEFINE_PROP_STRING("qmp", I2C_MCTP_CXL_State, qmp_str),
+    DEFINE_PROP_BOOL("mctp-msg-forward", I2C_MCTP_CXL_State,
+                     mctp_msg_forward, false),
 };
 
 static size_t i2c_mctp_cxl_get_buf(MCTPI2CEndpoint *mctp,
@@ -211,12 +219,46 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
 
         len_in = msg->pl_length[2] << 16 | msg->pl_length[1] << 8 |
             msg->pl_length[0];
-
-        rc = cxl_process_cci_message(s->cci, msg->command_set, msg->command,
-                                     len_in, msg->payload,
-                                     &len_out,
-                                     s->scratch + sizeof(CXLMCTPMessage),
-                                     &bg_started);
+        if (s->mctp_msg_forward) {
+            CXLType3Dev *ct3d = CXL_TYPE3(s->target);
+            CXLMCTPCommandBuf *mctp_buf;
+            int i;
+            char *cci_name = NULL;
+
+            g_assert(cci_map_buf);
+            g_assert(ct3d->mctp_shared_buffer);
+
+            for (i = 0; i < cci_map_buf->num_mappings; i++) {
+                if (cci_map_buf->maps[i].cci_pointer == s->cci) {
+                    break;
+                }
+            }
+
+            g_assert(i < cci_map_buf->num_mappings);
+            cci_name = cci_map_buf->maps[i].cci_name;
+
+            mctp_buf = &ct3d->mctp_shared_buffer->command_buf;
+            g_assert(mctp_buf);
+
+            mctp_buf->command_set = msg->command_set;
+            mctp_buf->command = msg->command;
+            mctp_buf->len_in = len_in;
+            memcpy(mctp_buf->payload, msg->payload, len_in);
+            ct3d->mctp_shared_buffer->status = 1;
+            qmp_cxl_mctp_process_cci_message(s->qmp_fd, cci_name);
+            if (mctp_buf->len_out) {
+                memcpy(s->scratch + sizeof(CXLMCTPMessage),
+                       mctp_buf->payload_out, mctp_buf->len_out);
+            }
+            rc = mctp_buf->ret_val;
+            len_out = mctp_buf->len_out;
+        } else {
+            rc = cxl_process_cci_message(s->cci, msg->command_set, msg->command,
+                                         len_in, msg->payload,
+                                         &len_out,
+                                         s->scratch + sizeof(CXLMCTPMessage),
+                                         &bg_started);
+        }
         buf->rc = rc;
         s->pos += len_out;
         s->len = s->pos;
@@ -253,6 +295,20 @@ static void i2c_mctp_cxl_realize(DeviceState *d, Error **errp)
 
         cxl_initialize_t3_fm_owned_ld_mctpcci(s->cci, DEVICE(s->target), d,
                                               MCTP_CXL_MAILBOX_BYTES);
+        if (s->mctp_msg_forward) {
+            g_assert(s->qmp_str);
+            s->qmp_fd = setup_mctp_qmp_connection(s->qmp_str);
+            if (s->qmp_fd < 0) {
+                error_setg(errp, "setup connection to qmp server failed");
+            } else {
+                read_qmp_response(s->qmp_fd);
+            }
+
+            init_cci_name_ptr_mapping();
+            ct3_setup_mctp_command_share_buffer(ct3d, false);
+        } else {
+            s->qmp_fd = -1;
+        }
         return;
     }
 
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index e780344d85..d0a8f78462 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -13,7 +13,7 @@ system_ss.add(when: 'CONFIG_CXL',
                if_false: files(
                    'cxl-host-stubs.c',
                ))
-system_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c'))
+system_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c', 'cxl-mctp-qmp.c'))
 
 system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f7ac8e8da7..d44b1b6dc6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1051,7 +1051,7 @@ static int ct3_mctp_buf_create(const char *filename, size_t size)
     return fd;
 }
 
-static int ct3_setup_mctp_command_share_buffer(CXLType3Dev *ct3d, bool create)
+int ct3_setup_mctp_command_share_buffer(CXLType3Dev *ct3d, bool create)
 {
     int fd;
     int size = sizeof(*ct3d->mctp_shared_buffer);
@@ -1074,7 +1074,7 @@ static int ct3_setup_mctp_command_share_buffer(CXLType3Dev *ct3d, bool create)
     return -1;
 }
 
-static int init_cci_name_ptr_mapping(void)
+int init_cci_name_ptr_mapping(void)
 {
     if (!cci_map_buf) {
         cci_map_buf = g_malloc(sizeof(*cci_map_buf));
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9a00ef7a1e..5c8813af20 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -810,4 +810,6 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
+int ct3_setup_mctp_command_share_buffer(CXLType3Dev *ct3d, bool create);
+int init_cci_name_ptr_mapping(void);
 #endif
diff --git a/include/hw/cxl/cxl_mctp_message.h b/include/hw/cxl/cxl_mctp_message.h
index 85b3664cf7..718dc8c0a2 100644
--- a/include/hw/cxl/cxl_mctp_message.h
+++ b/include/hw/cxl/cxl_mctp_message.h
@@ -37,4 +37,7 @@ struct CXLMCTPSharedBuf {
 
 typedef struct CXLMCTPSharedBuf CXLMCTPSharedBuf;
 extern struct CXLCCINamePtrMaps *cci_map_buf;
+int setup_mctp_qmp_connection(const char *qmp_str);
+void read_qmp_response(int sockfd);
+void qmp_cxl_mctp_process_cci_message(const int sockfd, const char *cci_name);
 #endif
-- 
2.47.2


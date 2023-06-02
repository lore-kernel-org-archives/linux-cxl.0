Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE8C7EE2C
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 21:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjFBViY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 17:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbjFBViX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 17:38:23 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A531B9
        for <linux-cxl@vger.kernel.org>; Fri,  2 Jun 2023 14:38:21 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5689335d2b6so24058957b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 02 Jun 2023 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20221208.gappssmtp.com; s=20221208; t=1685741900; x=1688333900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUttbGMWg8BpWC+Vm7ZfT+DefCx6yfVzGkw4JbA8/ek=;
        b=XKQ2oYtN3catPOhXhfzYGLX1dQ5tSxdnfDLLoR+iVM7rKMbSol9Y7jDB3bxgkDsiPM
         DEEHXHCO9P8+2VFPY3xvCm3Gq5UfKp8O7+3eWb/TEON9JOgOrskoWkRLOQHAaMnW9u+5
         gUuoItVf49X8HMnZ4egSN4hOzg7EPsSQZC6Hrmtmb5xs3drwaycIEgIPkNw8bZDXTisZ
         RL6ctI/xT3LUewc9dTYxTmLrVFug6Lo63YOIN3WPGSZloliP7IT6xYMCpA8JawitWIH0
         A8zhiNsVswLIkneyjyictx/S9Gps7B/nozh8JjrRWFoBuQcnYldJN3bsppOo7j58QAcs
         Dh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685741900; x=1688333900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUttbGMWg8BpWC+Vm7ZfT+DefCx6yfVzGkw4JbA8/ek=;
        b=C6kz0IMWb9ctHECllxOBIqmN9ZaKtEDdBtG99I44XvyQ54xCtsN8BF5okM7UPM290c
         fuL9x9ecTWg0M9D1EKLYGxYQpX24cFwnHiHMJggpMkpF0ovR5xMK4N+JLu+KAW2xgZEx
         3kVtFa05k+faOfeHsb2HSZXsNP8kxRk/qbivPVNeUFXy0m2Px/hw08vuhi/u1NAO2ei5
         57GkqwjcchGX8j8LppMR2DjLgmKN+7l9YFEESOHVWR1NXcwiMrlk6a93JDLi4+SMwahC
         0M6vBNXc97VED0EKlhHgBRXE2TrxAdz2P8Ji/4Dz03NJ7OQTGcPnGtP0p9NwGKJ5mOUS
         IFnQ==
X-Gm-Message-State: AC+VfDwvhXFXFn/SZK6ey7CTgQ5geCuO9/J1EGMy4W0J7n2ccjSjP/TZ
        tUE14Cbeb5oiZIxvrZZAi23YC2IczOB7unRXSB97TQ==
X-Google-Smtp-Source: ACHHUZ4ay+9JXPoKDTwHOfBR2mxBhAHjqNO1SCtEFFh+KrYjBU6bZRw/AC5FxiFKRd4Vtcdb65f3+Q==
X-Received: by 2002:a0d:ccca:0:b0:561:7ec:cf90 with SMTP id o193-20020a0dccca000000b0056107eccf90mr1220766ywd.42.1685741899805;
        Fri, 02 Jun 2023 14:38:19 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:42f0:6600:901f:39a8:fe3f:30e2])
        by smtp.gmail.com with ESMTPSA id v1-20020a0dd301000000b00559d9989490sm856302ywd.41.2023.06.02.14.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:38:19 -0700 (PDT)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-cxl@vger.kernel.org
Cc:     a.manzanares@samsung.com, Jonathan.Cameron@huawei.com,
        nilesh.shah@zptcorp.com, slava@dubeiko.com,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 2/5] CXL FM: [lib] introduce CXL FM library
Date:   Fri,  2 Jun 2023 14:37:34 -0700
Message-Id: <20230602213737.494750-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602213737.494750-1-slava@dubeyko.com>
References: <20230602213737.494750-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This patch creates the CXL FM library.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Adam Manzanares <a.manzanares@samsung.com>
---
 .gitignore            |   1 +
 Cargo.toml            |  12 ++++
 fm_library/Cargo.lock |   7 +++
 fm_library/Cargo.toml |  12 ++++
 fm_library/src/lib.rs | 133 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 165 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 Cargo.toml
 create mode 100644 fm_library/Cargo.lock
 create mode 100644 fm_library/Cargo.toml
 create mode 100644 fm_library/src/lib.rs

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..ea8c4bf
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1 @@
+/target
diff --git a/Cargo.toml b/Cargo.toml
new file mode 100644
index 0000000..96fc75e
--- /dev/null
+++ b/Cargo.toml
@@ -0,0 +1,12 @@
+[package]
+name = "fabric_manager"
+version = "0.1.0"
+edition = "2021"
+
+# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
+
+[lib]
+name = "fm_library"
+path = "fm_library/src/lib.rs"
+
+[dependencies]
diff --git a/fm_library/Cargo.lock b/fm_library/Cargo.lock
new file mode 100644
index 0000000..de5870a
--- /dev/null
+++ b/fm_library/Cargo.lock
@@ -0,0 +1,7 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "fm_communication"
+version = "0.1.0"
diff --git a/fm_library/Cargo.toml b/fm_library/Cargo.toml
new file mode 100644
index 0000000..79dc6c4
--- /dev/null
+++ b/fm_library/Cargo.toml
@@ -0,0 +1,12 @@
+[package]
+name = "fm_communication"
+version = "0.1.0"
+edition = "2021"
+
+# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
+
+[lib]
+name = "fm_communication"
+path = "src/lib.rs"
+
+[dependencies]
diff --git a/fm_library/src/lib.rs b/fm_library/src/lib.rs
new file mode 100644
index 0000000..c06fd9c
--- /dev/null
+++ b/fm_library/src/lib.rs
@@ -0,0 +1,133 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM library implementation.
+ *
+ * Copyright (c) 2023 Viacheslav Dubeyko <slava@dubeyko.com>,
+ * All rights reserved.
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *     http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+pub mod cxl_fm_lib {
+	use std::net::{TcpStream};
+	use std::io::Write;
+	use std::io::BufReader;
+	use std::io::BufRead;
+
+	/*
+	 * Available commands
+	 */
+	pub const CXL_FM_DISCOVER_FM_COMMAND: &str		= "DISCOVER_FM";
+	pub const CXL_FM_DISCOVER_CXL_DEVICE_COMMAND: &str	= "DISCOVER_CXL_DEVICE";
+	pub const CXL_FM_DISCOVER_CXL_SWITCH_COMMAND: &str	= "DISCOVER_CXL_SWITCH";
+	pub const CXL_FM_DISCOVER_LD_COMMAND: &str		= "DISCOVER_LOGICAL_DEVICE";
+
+	pub const CXL_FM_GET_FM_INFO_COMMAND: &str		= "GET_FM_INFO";
+	pub const CXL_FM_START_FM_COMMAND: &str			= "START_FM";
+	pub const CXL_FM_RESTART_FM_COMMAND: &str		= "RESTART_FM";
+	pub const CXL_FM_STOP_FM_COMMAND: &str			= "STOP_FM";
+	pub const CXL_FM_GET_FM_CONFIG_COMMAND: &str		= "GET_FM_CONFIG";
+	pub const CXL_FM_SET_FM_CONFIG_COMMAND: &str		= "SET_FM_CONFIG";
+	pub const CXL_FM_GET_FM_EVENTS_COMMAND: &str		= "GET_FM_EVENTS";
+
+	pub const CXL_FM_GET_SWITCH_INFO_COMMAND: &str		= "GET_SWITCH_INFO";
+	pub const CXL_FM_GET_SWITCH_CONFIG_COMMAND: &str	= "GET_SWITCH_CONFIG";
+	pub const CXL_FM_SET_SWITCH_CONFIG_COMMAND: &str	= "SET_SWITCH_CONFIG";
+
+	pub const CXL_FM_GET_MHD_INFO_COMMAND: &str		= "GET_MHD_INFO";
+
+	pub const CXL_FM_BIND_LD_COMMAND: &str			= "BIND_LOGICAL_DEVICE";
+	pub const CXL_FM_UNBIND_LD_COMMAND: &str		= "UNBIND_LOGICAL_DEVICE";
+	pub const CXL_FM_CONNECT_MLD_COMMAND: &str		= "CONNECT_MLD";
+	pub const CXL_FM_DISCONNECT_MLD_COMMAND: &str		= "DISCONNECT_MLD";
+	pub const CXL_FM_GET_LD_ALLOCATION_COMMAND: &str	= "GET_LD_ALLOCATION";
+	pub const CXL_FM_SET_LD_ALLOCATION_COMMAND: &str	= "SET_LD_ALLOCATION";
+	pub const CXL_FM_GET_QOS_CONTROL_COMMAND: &str		= "GET_LD_QOS_CONTROL";
+	pub const CXL_FM_SET_QOS_CONTROL_COMMAND: &str		= "SET_LD_QOS_CONTROL";
+	pub const CXL_FM_GET_QOS_STATUS_COMMAND: &str		= "GET_LD_QOS_STATUS";
+	pub const CXL_FM_GET_QOS_BANDWIDTH_COMMAND: &str	= "GET_LD_QOS_BANDWIDTH";
+	pub const CXL_FM_SET_QOS_BANDWIDTH_COMMAND: &str	= "SET_LD_QOS_BANDWIDTH";
+	pub const CXL_FM_GET_QOS_BANDWIDTH_LIMIT_COMMAND: &str	= "GET_LD_QOS_BANDWIDTH_LIMIT";
+	pub const CXL_FM_SET_QOS_BANDWIDTH_LIMIT_COMMAND: &str	= "SET_LD_QOS_BANDWIDTH_LIMIT";
+	pub const CXL_FM_LD_ERASE: &str				= "LD_ERASE";
+
+	pub const CXL_FM_GET_PPB_CONFIG_COMMAND: &str		= "GET_PPB_CONFIG";
+	pub const CXL_FM_PPB_BIND_COMMAND: &str			= "PPB_BIND";
+	pub const CXL_FM_PPB_UNBIND_COMMAND: &str		= "PPB_UNBIND";
+
+	pub const CXL_FM_GET_PHYSICAL_PORT_INFO_COMMAND: &str	= "GET_PHYSICAL_PORT_INFO";
+	pub const CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND: &str	= "PHYSICAL_PORT_CONTROL";
+	pub const CXL_FM_BIND_PHYSICAL_PORT_COMMAND: &str	= "BIND_PHYSICAL_PORT";
+	pub const CXL_FM_UNBIND_PHYSICAL_PORT_COMMAND: &str	= "UNBIND_PHYSICAL_PORT";
+
+	pub const CXL_FM_MLD_PORT_TUNNEL_COMMAND: &str		= "MLD_PORT_TUNNEL";
+	pub const CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND: &str	= "MLD_PORT_SEND_CONFIG";
+	pub const CXL_FM_MLD_PORT_SEND_MEM_REQ_COMMAND: &str	= "MLD_PORT_SEND_MEM_REQ";
+
+	pub const CXL_FM_DCD_GET_INFO_COMMAND: &str		= "DCD_GET_INFO";
+	pub const CXL_FM_DCD_GET_CONFIG_COMMAND: &str		= "DCD_GET_CONFIG";
+	pub const CXL_FM_DCD_SET_CONFIG_COMMAND: &str		= "DCD_SET_CONFIG";
+	pub const CXL_FM_DCD_GET_EXTENT_COMMAND: &str		= "DCD_GET_EXTENT";
+	pub const CXL_FM_DCD_ADD_CAPACITY_COMMAND: &str		= "DCD_ADD_CAPACITY";
+	pub const CXL_FM_DCD_RELEASE_CAPACITY_COMMAND: &str	= "DCD_RELEASE_CAPACITY";
+
+	/*
+	 * Service responces
+	 */
+	pub const CXL_FM_UNKNOWN_COMMAND: &str			= "UNKNOWN_COMMAND";
+	pub const CXL_FM_NO_DATA: &str				= "NO_DATA";
+
+	/*
+	 * struct CxlFmOptions - configuration options
+	 * @ip_port: IP address + port
+	 * @is_debug: does it need to show debug output?
+	 */
+	pub struct CxlFmOptions {
+		pub ip_port: String,
+		pub is_debug: bool,
+	}
+
+	/*
+	 * Send command to FM
+	 */
+	pub fn send_command(mut stream: &TcpStream, command: &str, env: &CxlFmOptions) {
+		let full_command = format!("{command}\n");
+
+		if env.is_debug {
+			println!("COMMAND: {:#?}", full_command);
+		}
+
+		stream.write_all(full_command.as_bytes()).unwrap();
+
+		let buf_reader = BufReader::new(&mut stream);
+		let mut response_line = buf_reader.lines();
+
+		if env.is_debug {
+			println!("RESPONCE: {:#?}", response_line.next().unwrap().unwrap());
+		}
+	}
+
+	/*
+	 * Send responce from FM
+	 */
+	pub fn send_responce(mut stream: &TcpStream, responce: &str, env: &CxlFmOptions) {
+		let full_responce = format!("{responce}\n");
+
+		if env.is_debug {
+			println!("RESPONCE: {:#?}", full_responce);
+		}
+
+		stream.write_all(full_responce.as_bytes()).unwrap();
+	}
+}
-- 
2.34.1


Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC0BC7EE2D
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 21:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbjFBVi2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 17:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbjFBVi2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 17:38:28 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE7BE44
        for <linux-cxl@vger.kernel.org>; Fri,  2 Jun 2023 14:38:23 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-568900c331aso27181797b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 02 Jun 2023 14:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20221208.gappssmtp.com; s=20221208; t=1685741902; x=1688333902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg0lKg63MHm35YjvNFvT8fZVkuE4Ra3soz7c4tZx9Ck=;
        b=N61IcpFh/vd0HeyRU98c6oHywvpXQ9ITNHBtvfSKXgIY1biMmRiXax9sr+dUkpU7q+
         mBtbDVs/ytk05Lca5KqYCMEcWLjpVzp5ps5KpXbPEFuxIBbnnrIglckVWAfF7s+FW8c4
         RMftXY6KfXPVy4z/HGxMLOtNa7wGlTk8PKaZflYoHjYOV+0K9BlSbk9evQOlbEOD8sh8
         N6UoLUR3cGhEnLciCpbkn6cJLw0BnaLi16Pba0O4K3jMsR3VMJS8bxpzJH6spF1rpXAC
         Uxo3O4cM6eqVOcdzaMhxW1NIKldzZOqaZJQYr88gl1vim5dfJ0Jr36eoSyosllOh5lOL
         SmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685741902; x=1688333902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mg0lKg63MHm35YjvNFvT8fZVkuE4Ra3soz7c4tZx9Ck=;
        b=jnf5Yxkxfe/pYMq7WOsTRkSxUmCN2aHudSf3i6BVm6gHVOzws7Qjezq4dtaMEqesip
         OprrPe+RpnHUpD6a27v7o1likF6RYdM4egMGkX9vSNnL9kiwsECpMxWKEH4osopgnegK
         91PmzRYPLdUxc594Gcbp+jOuPHZiwDQ1pv0CBn+LwSENUM5s9zpup8DehHXk/lvWKXMv
         vtKXuEiwdxzzDomVQACuQZ55G+Cs5u3MbwBru79tY1IKkW2nBeqXp8onUJr2CGrt2Pcs
         myMh90vY8Plezp53PrSKJLv37ps0kOH6N6e0yKMtoqnpCXhcVArDbIw9ADYiXy973cDk
         FlVg==
X-Gm-Message-State: AC+VfDwqgVF1Va+z6HzcK2M9EPwNjUs0A2mKY4yWmtw0h5uYEp2oXeTa
        L5+0AlxO3S1Bi+Ird5ouQj5kTBbn3U2w0AzUlTDDmA==
X-Google-Smtp-Source: ACHHUZ4jNEKGfyYblnGwQsgVwuVzcIm3thoJz0oXHwxkZIHkW9h2v9lfRCFuI0DLeCAqKGiHPvPSNQ==
X-Received: by 2002:a0d:e897:0:b0:55d:dc4d:cbd3 with SMTP id r145-20020a0de897000000b0055ddc4dcbd3mr1375453ywe.23.1685741901856;
        Fri, 02 Jun 2023 14:38:21 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:42f0:6600:901f:39a8:fe3f:30e2])
        by smtp.gmail.com with ESMTPSA id v1-20020a0dd301000000b00559d9989490sm856302ywd.41.2023.06.02.14.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:38:21 -0700 (PDT)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-cxl@vger.kernel.org
Cc:     a.manzanares@samsung.com, Jonathan.Cameron@huawei.com,
        nilesh.shah@zptcorp.com, slava@dubeiko.com,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 3/5] CXL FM: [fm_daemon] introduce CXL FM daemon
Date:   Fri,  2 Jun 2023 14:37:35 -0700
Message-Id: <20230602213737.494750-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602213737.494750-1-slava@dubeyko.com>
References: <20230602213737.494750-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This patch creates the intial state of CXL FM daemon.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Adam Manzanares <a.manzanares@samsung.com>
---
 Cargo.toml                               |   6 +
 fm_daemon/Cargo.toml                     |  10 +
 fm_daemon/src/discover.rs                |  63 +++++
 fm_daemon/src/dynamic_capacity_device.rs |  99 ++++++++
 fm_daemon/src/fm.rs                      |  75 ++++++
 fm_daemon/src/logical_device.rs          | 195 ++++++++++++++
 fm_daemon/src/main.rs                    | 307 +++++++++++++++++++++++
 fm_daemon/src/mld_port.rs                |  63 +++++
 fm_daemon/src/multi_headed_device.rs     |  39 +++
 fm_daemon/src/pci2pci_bridge.rs          |  63 +++++
 fm_daemon/src/physical_port.rs           |  75 ++++++
 fm_daemon/src/switch.rs                  |  63 +++++
 12 files changed, 1058 insertions(+)
 create mode 100644 fm_daemon/Cargo.toml
 create mode 100644 fm_daemon/src/discover.rs
 create mode 100644 fm_daemon/src/dynamic_capacity_device.rs
 create mode 100644 fm_daemon/src/fm.rs
 create mode 100644 fm_daemon/src/logical_device.rs
 create mode 100644 fm_daemon/src/main.rs
 create mode 100644 fm_daemon/src/mld_port.rs
 create mode 100644 fm_daemon/src/multi_headed_device.rs
 create mode 100644 fm_daemon/src/pci2pci_bridge.rs
 create mode 100644 fm_daemon/src/physical_port.rs
 create mode 100644 fm_daemon/src/switch.rs

diff --git a/Cargo.toml b/Cargo.toml
index 96fc75e..b8d169d 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -9,4 +9,10 @@ edition = "2021"
 name = "fm_library"
 path = "fm_library/src/lib.rs"
 
+[[bin]]
+name = "fm_daemon"
+path = "fm_daemon/src/main.rs"
+
 [dependencies]
+clap = { version = "4.0.32", features = ["derive"] }
+daemonize = "0.5.0"
diff --git a/fm_daemon/Cargo.toml b/fm_daemon/Cargo.toml
new file mode 100644
index 0000000..70e2f28
--- /dev/null
+++ b/fm_daemon/Cargo.toml
@@ -0,0 +1,10 @@
+[package]
+name = "fm_daemon"
+version = "0.1.0"
+edition = "2021"
+
+# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
+
+[dependencies]
+daemonize = "0.5.0"
+fm_library = { path = "../fm_library/" }
diff --git a/fm_daemon/src/discover.rs b/fm_daemon/src/discover.rs
new file mode 100644
index 0000000..6bda43d
--- /dev/null
+++ b/fm_daemon/src/discover.rs
@@ -0,0 +1,63 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM daemon implementation.
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
+pub mod cxl_fm_discover_command {
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_responce;
+	use fm_library::cxl_fm_lib::CXL_FM_DISCOVER_CXL_DEVICE_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DISCOVER_CXL_SWITCH_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DISCOVER_LD_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_NO_DATA;
+
+	/*
+	 * Discover available CXL devices
+	 */
+	pub fn discover_cxl_devices(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_DISCOVER_CXL_DEVICE_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Discover available CXL switches
+	 */
+	pub fn discover_cxl_switches(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_DISCOVER_CXL_SWITCH_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Discover available logical devices
+	 */
+	pub fn discover_logical_devices(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_DISCOVER_LD_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+}
diff --git a/fm_daemon/src/dynamic_capacity_device.rs b/fm_daemon/src/dynamic_capacity_device.rs
new file mode 100644
index 0000000..6926ec7
--- /dev/null
+++ b/fm_daemon/src/dynamic_capacity_device.rs
@@ -0,0 +1,99 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM configuration tool implementation.
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
+pub mod cxl_dcd_command {
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_responce;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_GET_INFO_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_GET_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_SET_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_GET_EXTENT_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_ADD_CAPACITY_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_RELEASE_CAPACITY_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_NO_DATA;
+
+	/*
+	 * Get Dynamic Capacity Device (DCD) info
+	 */
+	pub fn get_info(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_DCD_GET_INFO_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Get dynamic capacity region configuration
+	 */
+	pub fn get_capacity_config(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_DCD_GET_CONFIG_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Set dynamic capacity region configuration
+	 */
+	pub fn set_capacity_config(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_DCD_SET_CONFIG_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Get Dynamic Capacity Device (DCD) extent list
+	 */
+	pub fn get_extent_list(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_DCD_GET_EXTENT_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Initiate dynamic capacity add
+	 */
+	pub fn add_capacity(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_DCD_ADD_CAPACITY_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Initiate dynamic capacity release
+	 */
+	pub fn release_capacity(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_DCD_RELEASE_CAPACITY_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+}
diff --git a/fm_daemon/src/fm.rs b/fm_daemon/src/fm.rs
new file mode 100644
index 0000000..b40abb3
--- /dev/null
+++ b/fm_daemon/src/fm.rs
@@ -0,0 +1,75 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM daemon implementation.
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
+pub mod cxl_fm_command {
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_responce;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_FM_INFO_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_FM_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_SET_FM_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_FM_EVENTS_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_NO_DATA;
+
+	/*
+	 * Get Fabric Manager (FM) status/info
+	 */
+	pub fn get_info(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_FM_INFO_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Get Fabric Manager (FM) configuration
+	 */
+	pub fn get_config(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_FM_CONFIG_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Set Fabric Manager (FM) configuration
+	 */
+	pub fn set_config(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_SET_FM_CONFIG_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Get Fabric Manager (FM) event records
+	 */
+	pub fn get_events(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_FM_EVENTS_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+}
diff --git a/fm_daemon/src/logical_device.rs b/fm_daemon/src/logical_device.rs
new file mode 100644
index 0000000..c62727c
--- /dev/null
+++ b/fm_daemon/src/logical_device.rs
@@ -0,0 +1,195 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM configuration tool implementation.
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
+pub mod cxl_logical_device_command {
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_responce;
+	use fm_library::cxl_fm_lib::CXL_FM_BIND_LD_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_UNBIND_LD_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_CONNECT_MLD_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DISCONNECT_MLD_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_LD_ALLOCATION_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_SET_LD_ALLOCATION_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_QOS_CONTROL_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_SET_QOS_CONTROL_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_QOS_STATUS_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_QOS_BANDWIDTH_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_SET_QOS_BANDWIDTH_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_QOS_BANDWIDTH_LIMIT_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_SET_QOS_BANDWIDTH_LIMIT_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_LD_ERASE;
+	use fm_library::cxl_fm_lib::CXL_FM_NO_DATA;
+
+	/*
+	 * Bind Logical Device (LD)
+	 */
+	pub fn bind(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_BIND_LD_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Unbind Logical Device (LD)
+	 */
+	pub fn unbind(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_UNBIND_LD_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Connect Multi Logical Device (MLD) to CXL switch
+	 */
+	pub fn connect(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_CONNECT_MLD_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Disconnect Multi Logical Device (MLD) from CXL switch
+	 */
+	pub fn disconnect(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_DISCONNECT_MLD_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Get Logical Device (LD) allocations
+	 */
+	pub fn get_allocation(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_LD_ALLOCATION_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Set Logical Device (LD) allocations
+	 */
+	pub fn set_allocation(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_SET_LD_ALLOCATION_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Get QoS control
+	 */
+	pub fn get_qos_control(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_QOS_CONTROL_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Set QoS control
+	 */
+	pub fn set_qos_control(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_SET_QOS_CONTROL_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Get QoS status
+	 */
+	pub fn get_qos_status(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_QOS_STATUS_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Get QoS allocated bandwidth
+	 */
+	pub fn get_qos_bandwidth(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_QOS_BANDWIDTH_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Set QoS allocated bandwidth
+	 */
+	pub fn set_qos_bandwidth(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_SET_QOS_BANDWIDTH_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Get QoS bandwidth limit
+	 */
+	pub fn get_qos_bandwidth_limit(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_QOS_BANDWIDTH_LIMIT_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Set QoS bandwidth limit
+	 */
+	pub fn set_qos_bandwidth_limit(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_SET_QOS_BANDWIDTH_LIMIT_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Secure erase after unbinding
+	 */
+	pub fn erase(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_LD_ERASE);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+}
diff --git a/fm_daemon/src/main.rs b/fm_daemon/src/main.rs
new file mode 100644
index 0000000..fef4997
--- /dev/null
+++ b/fm_daemon/src/main.rs
@@ -0,0 +1,307 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM daemon implementation.
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
+mod discover;
+mod fm;
+mod switch;
+mod multi_headed_device;
+mod logical_device;
+mod pci2pci_bridge;
+mod physical_port;
+mod mld_port;
+mod dynamic_capacity_device;
+
+extern crate daemonize;
+
+use std::fs::File;
+use daemonize::Daemonize;
+use clap::{Arg, Command};
+use std::{
+	io::{prelude::*, BufReader},
+	net::{TcpListener, TcpStream},
+};
+pub use crate::discover::cxl_fm_discover_command;
+pub use crate::fm::cxl_fm_command;
+pub use crate::switch::cxl_switch_command;
+pub use crate::multi_headed_device::cxl_mh_device_command;
+pub use crate::logical_device::cxl_logical_device_command;
+pub use crate::pci2pci_bridge::cxl_ppb_command;
+pub use crate::physical_port::cxl_physical_port_command;
+pub use crate::mld_port::cxl_mld_port_command;
+pub use crate::dynamic_capacity_device::cxl_dcd_command;
+pub use fm_library::cxl_fm_lib::send_responce;
+pub use fm_library::cxl_fm_lib::CxlFmOptions;
+
+/*
+ * CXL FM daemon version
+ */
+const CXL_FM_DAEMON_VERSION: &str = "0.0.1";
+
+/*
+ * CXL FM daemon strings
+ */
+const CXL_FM_DAEMON_NAME: &str = "fm_daemon";
+const CXL_FM_DAEMON_DESCRIPTOR: &str = "CXL Fabric Manager (FM) daemon";
+const CXL_FM_DAEMON_DEBUG_OPTION: &str = "debug";
+const CXL_FM_DAEMON_DEBUG_OPTION_SHORT: char = 'd';
+const CXL_FM_DAEMON_IP_ADDRESS_OPTION: &str = "ip";
+const CXL_FM_DAEMON_IP_ADDRESS_OPTION_SHORT: char = 'i';
+const CXL_FM_DAEMON_PORT_OPTION: &str = "port";
+const CXL_FM_DAEMON_PORT_OPTION_SHORT: char = 'p';
+
+const CXL_FM_DAEMON_WORKING_DIRECTORY: &str = "/tmp";
+const CXL_FM_DAEMON_LOG_FILE_PATH: &str = "/tmp/fm_daemon.log";
+const CXL_FM_DAEMON_ERROR_MESSAGES_FILE_PATH: &str = "/tmp/fm_daemon.err";
+const CXL_FM_DAEMON_USER: &str = "nobody";
+const CXL_FM_DAEMON_GROUP: &str = "bin";
+const CXL_FM_DAEMON_GROUP_ID: u32 = 2;
+const CXL_FM_DAEMON_UMASK: u32 = 0o777;
+
+/*
+ * Command line interface definition
+ */
+fn cli() -> Command {
+	Command::new(CXL_FM_DAEMON_NAME)
+		.about(CXL_FM_DAEMON_DESCRIPTOR)
+		.version(CXL_FM_DAEMON_VERSION)
+		.arg_required_else_help(true)
+		.arg(Arg::new(CXL_FM_DAEMON_DEBUG_OPTION)
+			.short(CXL_FM_DAEMON_DEBUG_OPTION_SHORT)
+			.long(CXL_FM_DAEMON_DEBUG_OPTION)
+			.action(clap::ArgAction::SetTrue))
+		.arg(Arg::new(CXL_FM_DAEMON_IP_ADDRESS_OPTION)
+			.short(CXL_FM_DAEMON_IP_ADDRESS_OPTION_SHORT)
+			.long(CXL_FM_DAEMON_IP_ADDRESS_OPTION)
+			.action(clap::ArgAction::Set)
+			.required(true))
+		.arg(Arg::new(CXL_FM_DAEMON_PORT_OPTION)
+			.short(CXL_FM_DAEMON_PORT_OPTION_SHORT)
+			.long(CXL_FM_DAEMON_PORT_OPTION)
+			.action(clap::ArgAction::Set)
+			.required(true))
+}
+
+/*
+OD * Connection request processing logic
+ */
+fn handle_connection(mut stream: &TcpStream, env: &CxlFmOptions) {
+	if env.is_debug {
+		println!("Process request...");
+	}
+
+	let buf_reader = BufReader::new(&mut stream);
+	let request_line = buf_reader.lines().next().unwrap().unwrap();
+
+	if env.is_debug {
+		println!("Request: {:#?}", request_line);
+	}
+
+	match request_line.as_str() {
+		fm_library::cxl_fm_lib::CXL_FM_DISCOVER_CXL_DEVICE_COMMAND => {
+			cxl_fm_discover_command::discover_cxl_devices(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_DISCOVER_CXL_SWITCH_COMMAND => {
+			cxl_fm_discover_command::discover_cxl_switches(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_DISCOVER_LD_COMMAND => {
+			cxl_fm_discover_command::discover_logical_devices(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_FM_INFO_COMMAND => {
+			cxl_fm_command::get_info(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_FM_CONFIG_COMMAND => {
+			cxl_fm_command::get_config(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_SET_FM_CONFIG_COMMAND => {
+			cxl_fm_command::set_config(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_FM_EVENTS_COMMAND => {
+			cxl_fm_command::get_events(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_SWITCH_INFO_COMMAND => {
+			cxl_switch_command::get_info(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_SWITCH_CONFIG_COMMAND => {
+			cxl_switch_command::get_config(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_SET_SWITCH_CONFIG_COMMAND => {
+			cxl_switch_command::set_config(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_MHD_INFO_COMMAND => {
+			cxl_mh_device_command::get_info(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_BIND_LD_COMMAND => {
+			cxl_logical_device_command::bind(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_UNBIND_LD_COMMAND => {
+			cxl_logical_device_command::unbind(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_CONNECT_MLD_COMMAND => {
+			cxl_logical_device_command::connect(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_DISCONNECT_MLD_COMMAND => {
+			cxl_logical_device_command::disconnect(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_LD_ALLOCATION_COMMAND => {
+			cxl_logical_device_command::get_allocation(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_SET_LD_ALLOCATION_COMMAND => {
+			cxl_logical_device_command::set_allocation(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_QOS_CONTROL_COMMAND => {
+			cxl_logical_device_command::get_qos_control(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_SET_QOS_CONTROL_COMMAND => {
+			cxl_logical_device_command::set_qos_control(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_QOS_STATUS_COMMAND => {
+			cxl_logical_device_command::get_qos_status(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_QOS_BANDWIDTH_COMMAND => {
+			cxl_logical_device_command::get_qos_bandwidth(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_SET_QOS_BANDWIDTH_COMMAND => {
+			cxl_logical_device_command::set_qos_bandwidth(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_QOS_BANDWIDTH_LIMIT_COMMAND => {
+			cxl_logical_device_command::get_qos_bandwidth_limit(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_SET_QOS_BANDWIDTH_LIMIT_COMMAND => {
+			cxl_logical_device_command::set_qos_bandwidth_limit(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_LD_ERASE => {
+			cxl_logical_device_command::erase(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_PPB_CONFIG_COMMAND => {
+			cxl_ppb_command::config(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_PPB_BIND_COMMAND => {
+			cxl_ppb_command::bind(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_PPB_UNBIND_COMMAND => {
+			cxl_ppb_command::unbind(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_GET_PHYSICAL_PORT_INFO_COMMAND => {
+			cxl_physical_port_command::get_info(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND => {
+			cxl_physical_port_command::control(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_BIND_PHYSICAL_PORT_COMMAND => {
+			cxl_physical_port_command::bind(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_UNBIND_PHYSICAL_PORT_COMMAND => {
+			cxl_physical_port_command::unbind(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_MLD_PORT_TUNNEL_COMMAND => {
+			cxl_mld_port_command::tunnel(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND => {
+			cxl_mld_port_command::send_config(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_MLD_PORT_SEND_MEM_REQ_COMMAND => {
+			cxl_mld_port_command::send_memory_request(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_DCD_GET_INFO_COMMAND => {
+			cxl_dcd_command::get_info(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_DCD_GET_CONFIG_COMMAND => {
+			cxl_dcd_command::get_capacity_config(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_DCD_SET_CONFIG_COMMAND => {
+			cxl_dcd_command::set_capacity_config(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_DCD_GET_EXTENT_COMMAND => {
+			cxl_dcd_command::get_extent_list(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_DCD_ADD_CAPACITY_COMMAND => {
+			cxl_dcd_command::add_capacity(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_DCD_RELEASE_CAPACITY_COMMAND => {
+			cxl_dcd_command::release_capacity(stream, env);
+		},
+		_ => send_responce(stream, fm_library::cxl_fm_lib::CXL_FM_UNKNOWN_COMMAND, env),
+	}
+}
+
+/*
+ * Main logic of daemon
+ */
+fn fm_daemon_logic(env: &CxlFmOptions) {
+	if env.is_debug {
+		println!("{} {}: Daemonized!",
+			 CXL_FM_DAEMON_NAME, CXL_FM_DAEMON_VERSION);
+	}
+
+	loop {
+		let listener = TcpListener::bind(&env.ip_port).unwrap();
+
+		if env.is_debug {
+			println!("Ready to accept connections: {}",
+				 env.ip_port);
+		}
+
+		for stream in listener.incoming() {
+			handle_connection(&stream.unwrap(), env);
+		}
+	};
+}
+
+/*
+ * Application logic
+ */
+fn main() {
+	let stdout = File::create(CXL_FM_DAEMON_LOG_FILE_PATH).unwrap();
+	let stderr = File::create(CXL_FM_DAEMON_ERROR_MESSAGES_FILE_PATH).unwrap();
+
+	let matches = cli().get_matches();
+
+	let ip = matches.get_one::<String>(CXL_FM_DAEMON_IP_ADDRESS_OPTION).unwrap();
+	let port = matches.get_one::<String>(CXL_FM_DAEMON_PORT_OPTION).unwrap();
+	let ip_port = format!("{ip}:{port}");
+
+	let options = CxlFmOptions {
+		ip_port: String::from(ip_port),
+		is_debug: matches.get_flag(CXL_FM_DAEMON_DEBUG_OPTION) == true,
+	};
+
+	if options.is_debug {
+		println!("{} {}", CXL_FM_DAEMON_NAME, CXL_FM_DAEMON_VERSION);
+	}
+
+	let daemonize = Daemonize::new()
+			// Every method except `new` and `start`
+			// is optional, see `Daemonize` documentation
+			// for default behaviour.
+			.working_directory(CXL_FM_DAEMON_WORKING_DIRECTORY)
+			.user(CXL_FM_DAEMON_USER)
+			.group(CXL_FM_DAEMON_GROUP)	// Group name
+			.group(CXL_FM_DAEMON_GROUP_ID)	// or group id.
+			.umask(CXL_FM_DAEMON_UMASK)	// Set umask, `0o027` by default.
+			.stdout(stdout)			// Redirect stdout to log file.
+			.stderr(stderr)			// Redirect stderr to error messages file.
+			.privileged_action(|| "Executed before drop privileges");
+
+	match daemonize.start() {
+		Ok(_) => fm_daemon_logic(&options),
+		Err(e) => eprintln!("Error, {}", e),
+	}
+}
diff --git a/fm_daemon/src/mld_port.rs b/fm_daemon/src/mld_port.rs
new file mode 100644
index 0000000..ce1cb3d
--- /dev/null
+++ b/fm_daemon/src/mld_port.rs
@@ -0,0 +1,63 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM configuration tool implementation.
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
+pub mod cxl_mld_port_command {
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_responce;
+	use fm_library::cxl_fm_lib::CXL_FM_MLD_PORT_TUNNEL_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_MLD_PORT_SEND_MEM_REQ_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_NO_DATA;
+
+	/*
+	 * Tunnel Management Command
+	 */
+	pub fn tunnel(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_MLD_PORT_TUNNEL_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Send CXL.io configuration request
+	 */
+	pub fn send_config(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Send CXL.io memory request
+	 */
+	pub fn send_memory_request(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_MLD_PORT_SEND_MEM_REQ_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+}
diff --git a/fm_daemon/src/multi_headed_device.rs b/fm_daemon/src/multi_headed_device.rs
new file mode 100644
index 0000000..1b63797
--- /dev/null
+++ b/fm_daemon/src/multi_headed_device.rs
@@ -0,0 +1,39 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM configuration tool implementation.
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
+pub mod cxl_mh_device_command {
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_responce;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_MHD_INFO_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_NO_DATA;
+
+	/*
+	 * Get Multi Headed Device (MHD) status/info
+	 */
+	pub fn get_info(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_MHD_INFO_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+}
diff --git a/fm_daemon/src/pci2pci_bridge.rs b/fm_daemon/src/pci2pci_bridge.rs
new file mode 100644
index 0000000..8b40a44
--- /dev/null
+++ b/fm_daemon/src/pci2pci_bridge.rs
@@ -0,0 +1,63 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM configuration tool implementation.
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
+pub mod cxl_ppb_command {
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_responce;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_PPB_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_PPB_BIND_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_PPB_UNBIND_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_NO_DATA;
+
+	/*
+	 * Send PCI-to-PCI Bridge (PPB) configuration request
+	 */
+	pub fn config(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_PPB_CONFIG_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Bind Virtual PCI-to-PCI Bridge (vPPB) inside a CXL switch
+	 */
+	pub fn bind(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_PPB_BIND_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Unbind Virtual PCI-to-PCI Bridge (vPPB) inside a CXL switch
+	 */
+	pub fn unbind(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_PPB_UNBIND_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+}
diff --git a/fm_daemon/src/physical_port.rs b/fm_daemon/src/physical_port.rs
new file mode 100644
index 0000000..bc8b55d
--- /dev/null
+++ b/fm_daemon/src/physical_port.rs
@@ -0,0 +1,75 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM configuration tool implementation.
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
+pub mod cxl_physical_port_command {
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_responce;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_PHYSICAL_PORT_INFO_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_BIND_PHYSICAL_PORT_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_UNBIND_PHYSICAL_PORT_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_NO_DATA;
+
+	/*
+	 * Get state of physical port
+	 */
+	pub fn get_info(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_PHYSICAL_PORT_INFO_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Control physical port
+	 */
+	pub fn control(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Bind physical port to Virtual PCI-to-PCI Bridge (vPPB)
+	 */
+	pub fn bind(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_BIND_PHYSICAL_PORT_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Unbind physical port from Virtual PCI-to-PCI Bridge (vPPB)
+	 */
+	pub fn unbind(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_UNBIND_PHYSICAL_PORT_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+}
diff --git a/fm_daemon/src/switch.rs b/fm_daemon/src/switch.rs
new file mode 100644
index 0000000..acbb923
--- /dev/null
+++ b/fm_daemon/src/switch.rs
@@ -0,0 +1,63 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM configuration tool implementation.
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
+pub mod cxl_switch_command {
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_responce;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_SWITCH_INFO_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_SWITCH_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_SET_SWITCH_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_NO_DATA;
+
+	/*
+	 * Get CXL switch status/info
+	 */
+	pub fn get_info(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_SWITCH_INFO_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Get CXL switch configuration
+	 */
+	pub fn get_config(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_GET_SWITCH_CONFIG_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+
+	/*
+	 * Set CXL switch configuration
+	 */
+	pub fn set_config(stream: &TcpStream, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", CXL_FM_SET_SWITCH_CONFIG_COMMAND);
+		}
+
+		send_responce(stream, CXL_FM_NO_DATA, env);
+	}
+}
-- 
2.34.1


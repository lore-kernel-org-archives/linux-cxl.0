Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A401C7EE29
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 21:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjFBVie (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbjFBVid (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 17:38:33 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20BA3
        for <linux-cxl@vger.kernel.org>; Fri,  2 Jun 2023 14:38:29 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565e8d575cbso25207707b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 02 Jun 2023 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20221208.gappssmtp.com; s=20221208; t=1685741907; x=1688333907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o+1WIPrmcRejwDgrU3htUqmLM90ekDoTN23FiH6nXY=;
        b=Py9TUrhDBhvj1xSmStm5nOTU1hqZSP/s1KjAbfD+iYrxu0vErgVeZ0PlQLjyasmFWD
         gOLM5tCOP4fbSwzgrPpxtl7G2jXp13a5jCpgzxhTjRBatkXFAqhmrGJzzlDU7uWnVJEW
         xRms4BxkzWjFxPbEb5Jm1Jee6J6pgxZJoOlzGLHFwsKNdPM0u7rvC7yfqpcJ6dwgQyQp
         eHT/7Inj6oOeaL3L90oVvJS15CnHsT727fwTBxXdNF6U06c9TQWGq8KvSaAiSAobtwzV
         uARjquGNrn+0NdxDxcpvf2zkeTnL+PVdma2unFwf8vUKgMHrsQUtL+K0Q2R985OEaqf6
         FT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685741907; x=1688333907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o+1WIPrmcRejwDgrU3htUqmLM90ekDoTN23FiH6nXY=;
        b=k0JqhNnwFbNisx5jAM3i9LSarZ2XbB78otrKsF+/usPBY98BGpMqc8R+gmuE+Sa+un
         h61NeKN9mlCSyFFSCefcKZpOP9on+D2ZmhPcguyfAw8HBCwWoUgbhgFcHb9Gq89Sf/Yv
         vAZB8SsEomALBNtXiCbJZuHuTdJGXC1MGUR0KqvqDkq5ghMiEOFoCjkvBX8relTi30s+
         hIoBZDWfcZtzxiLA2c02nCpGWQcTZe5ycY2nB5gXfRLqO7q7E4yGaARx9hmEyr5e7jPh
         LtD6BlRGavQJl/CS8DNkHxUlzkeXll8wx2/jUkGFn3Y3vn9I4fporo1BEUv6+Y7H4B/D
         kJlg==
X-Gm-Message-State: AC+VfDxRFGQXcNpYhKuncCgRhWtVaLHjLRrjFRwNh4OfNuI4lNuVP6cc
        yM+OiZ3jpDvC15Pk1UprXwCvobR3LYyaYkdsC0eHQg==
X-Google-Smtp-Source: ACHHUZ66gQjqoDsuMFs5Vxhym7NBq6hrJZ1jTCCQ9Xg1QmW3lvFHa8e/3ObR53UsXO5RikPcj+k6bw==
X-Received: by 2002:a0d:e884:0:b0:565:7dbf:a532 with SMTP id r126-20020a0de884000000b005657dbfa532mr1381692ywe.26.1685741905981;
        Fri, 02 Jun 2023 14:38:25 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:42f0:6600:901f:39a8:fe3f:30e2])
        by smtp.gmail.com with ESMTPSA id v1-20020a0dd301000000b00559d9989490sm856302ywd.41.2023.06.02.14.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:38:25 -0700 (PDT)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-cxl@vger.kernel.org
Cc:     a.manzanares@samsung.com, Jonathan.Cameron@huawei.com,
        nilesh.shah@zptcorp.com, slava@dubeiko.com,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 5/5] CXL FM: [fm_cli] introduce CXL FM CLI tool
Date:   Fri,  2 Jun 2023 14:37:37 -0700
Message-Id: <20230602213737.494750-6-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602213737.494750-1-slava@dubeyko.com>
References: <20230602213737.494750-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This patch creates the initial state of CXL FM CLI tool.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Adam Manzanares <a.manzanares@samsung.com>
---
 Cargo.toml                            |   4 +
 ChangeLog                             |   6 +
 README                                | 226 ++++++++
 fm_cli/Cargo.toml                     |  10 +
 fm_cli/src/discover.rs                | 159 ++++++
 fm_cli/src/dynamic_capacity_device.rs | 225 ++++++++
 fm_cli/src/fm.rs                      | 258 +++++++++
 fm_cli/src/logical_device.rs          | 489 +++++++++++++++++
 fm_cli/src/main.rs                    | 721 ++++++++++++++++++++++++++
 fm_cli/src/mld_port.rs                | 126 +++++
 fm_cli/src/multi_headed_device.rs     |  60 +++
 fm_cli/src/pci2pci_bridge.rs          | 126 +++++
 fm_cli/src/physical_port.rs           | 159 ++++++
 fm_cli/src/switch.rs                  | 126 +++++
 14 files changed, 2695 insertions(+)
 create mode 100644 ChangeLog
 create mode 100644 README
 create mode 100644 fm_cli/Cargo.toml
 create mode 100644 fm_cli/src/discover.rs
 create mode 100644 fm_cli/src/dynamic_capacity_device.rs
 create mode 100644 fm_cli/src/fm.rs
 create mode 100644 fm_cli/src/logical_device.rs
 create mode 100644 fm_cli/src/main.rs
 create mode 100644 fm_cli/src/mld_port.rs
 create mode 100644 fm_cli/src/multi_headed_device.rs
 create mode 100644 fm_cli/src/pci2pci_bridge.rs
 create mode 100644 fm_cli/src/physical_port.rs
 create mode 100644 fm_cli/src/switch.rs

diff --git a/Cargo.toml b/Cargo.toml
index ed50825..6eac9cd 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -9,6 +9,10 @@ edition = "2021"
 name = "fm_library"
 path = "fm_library/src/lib.rs"
 
+[[bin]]
+name = "fm_cli"
+path = "fm_cli/src/main.rs"
+
 [[bin]]
 name = "fm_daemon"
 path = "fm_daemon/src/main.rs"
diff --git a/ChangeLog b/ChangeLog
new file mode 100644
index 0000000..590513a
--- /dev/null
+++ b/ChangeLog
@@ -0,0 +1,6 @@
+********************************************************************************
+*                            CHANGELOG SECTION                                 *
+********************************************************************************
+
+v.0.01 [June 02, 2023]
+    (*) Create initial state [Viacheslav Dubeyko].
diff --git a/README b/README
new file mode 100644
index 0000000..b93d2af
--- /dev/null
+++ b/README
@@ -0,0 +1,226 @@
+CXL Fabric Manager (FM) infrastructure
+
+CXL Fabric Manager (FM) is the application logic responsible for
+system composition and allocation of resources. The FM can be embedded
+in the firmware of a device such as a CXL switch, reside on a host,
+or could be run on a Baseboard Management Controller (BMC).
+CXL Specification 3.0 defines Fabric Management as: "CXL devices can be
+configured statically or dynamically via a Fabric Manager (FM),
+an external logical process that queries and configures the system’s
+operational state using the FM commands defined in this specification.
+The FM is defined as the logical process that decides when
+reconfiguration is necessary and initiates the commands to perform
+configurations. It can take any form, including, but not limited to,
+software running on a host machine, embedded software running on a BMC,
+embedded firmware running on another CXL device or CXL switch,
+or a state machine running within the CXL device itself.".
+
+CXL devices are configured by FM through the Fabric Manager Application
+Programming Interface (FM API) command sets through a CCI (Component
+Command Interface). A CCI is exposed through a device’s Mailbox registers
+or through an MCTP-capable (Management Component Transport Protocol)
+interface.
+
+FM API Commands (defined by CXL Specification 3.0):
+(1) Physical switch
+    - Identify Switch Device,
+    - Get Physical Port State,
+    - Physical Port Control,
+    - Send PPB (PCI-to-PCI Bridge) CXL.io Configuration Request.
+(2) Virtual Switch
+    - Get Virtual CXL Switch Info,
+    - Bind vPPB (Virtual PCI-to-PCI Bridge),
+    - Unbind vPPB,
+    - Generate AER (Advanced Error Reporting Event).
+(3) MLD Port
+    - Tunnel Management Command,
+    - Send LD (Logical Device) or FMLD (Fabric Manager-owned Logical Device)
+      CXL.io Configuration Request,
+    - Send LD CXL.io Memory Request.
+(4) MLD Components
+    - Get LD (Logical Device) Info,
+    - Get LD Allocations,
+    - Set LD Allocations,
+    - Get QoS Control,
+    - Set QoS Control,
+    - Get QoS Status,
+    - Get QoS Allocated Bandwidth,
+    - Set QoS Allocated Bandwidth,
+    - Get QoS Bandwidth Limit,
+    - Set QoS Bandwidth Limit.
+(5) Multi- Headed Devices (Get Multi-Headed Info).
+(6) DCD (Dynamic Capacity Device) Management
+    - Get DCD Info,
+    - Get Host Dynamic Capacity Region Configuration,
+    - Set Dynamic Capacity Region Configuration,
+    - Get DCD Extent Lists,
+    - Initiate Dynamic Capacity Add,
+    - Initiate Dynamic Capacity Release.
+
+After the initial configuration is complete and a CCI on the switch is
+operational, an FM can send Management Commands to the switch.
+
+An FM may perform the following dynamic management actions on a CXL switch:
+(1) Query switch information and configuration details,
+(2) Bind or Unbind ports,
+(3) Register to receive and handle event notifications from the switch
+    (e.g., hot plug, surprise removal, and failures).
+
+A switch with MLD (Multi-Logical Device) requires an FM to perform
+the following management activities:
+(1) MLD discovery,
+(2) LD (Logical Device) binding/unbinding,
+(3) Management Command Tunneling.
+
+The FM can connect to an MLD (Multi-Logical Device) over a direct connection or
+by tunneling its management commands through the CCI of the CXL switch
+to which the device is connected. The FM can perform the following
+operations:
+(1) Memory allocation and QoS Telemetry management,
+(2) Security (e.g., LD erasure after unbinding),
+(3) Error handling.
+
+fm_cli - FM configuration tool
+Commands:
+
+Discover - discover available agents
+Subcommands:
+    - fm_cli discover fm
+         (discover FM instances)
+    - fm_cli discover cxl_devices
+         (discover CXL devices)
+    - fm_cli discover cxl_switches
+         (discover CXL switches)
+    - fm_cli discover logical_devices
+         (discover logical devices)
+
+FM - manage Fabric Manager
+Subcommands:
+    - fm_cli fm get_info
+         (get FM status/info)
+    - fm_cli fm start
+         (start FM instance)
+    - fm_cli fm restart
+         (restart FM instance)
+    - fm_cli fm stop
+         (stop FM instance)
+    - fm_cli fm get_config
+         (get FM configuration)
+    - fm_cli fm set_config
+         (set FM configuration)
+    - fm_cli fm get_events
+         (get event records)
+
+Switch - manage CXL switch
+Subcommands:
+    - fm_cli switch get_info
+         (get CXL switch info/status)
+    - fm_cli switch get_config
+         (get switch configuraiton)
+    - fm_cli switch set_config
+         (set switch configuration)
+
+Logical Device - manage logical devices
+Subcommands:
+    - fm_cli multi_headed_device info
+         (retrieves the number of heads, number of supported LDs,
+          and Head-to-LD mapping of a Multi-Headed device)
+    - fm_cli logical_device bind
+         (bind logical device)
+    - fm_cli logical_device unbind
+         (unbind logical device)
+    - fm_cli logical_device connect
+         (connect Multi Logical Device to CXL switch)
+    - fm_cli logical_device disconnect
+         (disconnect Multi Logical Device from CXL switch)
+    - fm_cli logical_device get_allocation
+         (Get LD Allocations: retrieves the memory allocations of the MLD)
+    - fm_cli logical_device set_allocation
+         (Set LD Allocations: sets the memory allocation for each LD)
+    - fm_cli logical_device get_qos_control
+         (Get QoS Control: retrieves the MLD’s QoS control parameters)
+    - fm_cli logical_device set_qos_control
+         (Set QoS Control: sets the MLD’s QoS control parameters)
+    - fm_cli logical_device get_qos_status
+         (Get QoS Status: retrieves the MLD’s QoS Status)
+    - fm_cli logical_device get_qos_allocated_bandwidth
+         (Get QoS Allocated Bandwidth: retrieves the MLD’s QoS allocated
+          bandwidth on a per-LD basis)
+    - fm_cli logical_device set_qos_allocated_bandwidth
+         (Set QoS Allocated Bandwidth: sets the MLD’s QoS allocated bandwidth
+          on a per-LD basis)
+    - fm_cli logical_device get_qos_bandwidth_limit
+         (Get QoS Bandwidth Limit: retrieves the MLD’s QoS bandwidth limit
+          on a per-LD basis)
+    - fm_cli logical_device set_qos_bandwidth_limit
+         (Set QoS Bandwidth Limit: sets the MLD’s QoS bandwidth limit
+          on a per-LD basis)
+    - fm_cli logical_device erase
+         (secure erase after unbinding)
+
+PCI-to-PCI Bridge - manage PPB (PCI-to-PCI Bridge)
+Subcommands:
+    - fm_cli ppb config
+         (Send PPB (PCI-to-PCI Bridge) CXL.io Configuration Request)
+    - fm_cli ppb bind
+         (Bind vPPB: Virtual PCI-to-PCI Bridge inside a CXL switch
+          that is host-owned)
+    - fm_cli ppb unbind
+         (Unbind vPPB: unbinds the physical port or LD from the virtual
+          hierarchy PPB)
+
+Physical Port - manage physical ports
+Subcommands:
+    - fm_cli physical_port get_info
+         (get state of physical port)
+    - fm_cli physical_port control
+         (control unbound ports and MLD ports, including issuing
+          resets and controlling sidebands)
+    - fm_cli physical_port bind
+         (bind physical port to vPPB (Virtual PCI-to-PCI Bridge))
+    - fm_cli physical_port unbind
+         (unbind physical port from vPPB (Virtual PCI-to-PCI Bridge))
+
+MLD (Multi-Logical Device) Port - manage Multi-Logical Device ports
+Subcommands:
+    - fm_cli mld_port tunnel
+         (Tunnel Management Command: tunnels the provided command to
+          LD FFFFh of the MLD on the specified port)
+    - fm_cli mld_port send_config
+         (Send LD (Logical Device) or FMLD (Fabric Manager-owned
+          Logical Device) CXL.io Configuration Request)
+    - fm_cli mld_port send_memory_request
+         (Send LD CXL.io Memory Request)
+
+DCD (Dynamic Capacity Device) - manage Dynamic Capacity Device
+Subcommands:
+    - fm_cli dcd get_info
+         (Get DCD Info: retrieves the number of supported hosts,
+          total Dynamic Capacity of the device, and supported region
+          configurations)
+    - fm_cli dcd get_capacity_config
+         (Get Host Dynamic Capacity Region Configuration: retrieves
+          the Dynamic Capacity configuration for a specified host)
+    - fm_cli dcd set_capacity_config
+         (Set Dynamic Capacity Region Configuration: sets
+          the configuration of a DC Region)
+    - fm_cli dcd get_extent_list
+         (Get DCD Extent Lists: retrieves the Dynamic Capacity Extent
+          List for a specified host)
+    - fm_cli dcd add_capacity
+         (Initiate Dynamic Capacity Add: initiates the addition of
+          Dynamic Capacity to the specified region on a host)
+    - fm_cli dcd release_capacity
+         (Initiate Dynamic Capacity Release: initiates the release of
+          Dynamic Capacity from a host)
+
+FM daemon receives requests from configuration tool and executes
+commands by means of interaction with kernel-space subsystems.
+The responsibility of FM daemon:
+    - Execute configuration tool commands
+    - Manage hot-add and hot-removal of devices
+    - Manage surprise removal of devices
+    - Receive and handle even notifications from the CXL switch
+    - Logging events
+    - Memory allocation and QoS Telemetry management
+    - Error/Failure handling
diff --git a/fm_cli/Cargo.toml b/fm_cli/Cargo.toml
new file mode 100644
index 0000000..e619a63
--- /dev/null
+++ b/fm_cli/Cargo.toml
@@ -0,0 +1,10 @@
+[package]
+name = "fm_cli"
+version = "0.1.0"
+edition = "2021"
+
+# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
+
+[dependencies]
+clap = { version = "4.0.32", features = ["derive"] }
+fm_library = { path = "../fm_library/" }
\ No newline at end of file
diff --git a/fm_cli/src/discover.rs b/fm_cli/src/discover.rs
new file mode 100644
index 0000000..a06889f
--- /dev/null
+++ b/fm_cli/src/discover.rs
@@ -0,0 +1,159 @@
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
+pub mod cxl_fm_discover_command {
+	use clap::{ArgMatches};
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_command;
+	use fm_library::cxl_fm_lib::CXL_FM_DISCOVER_FM_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DISCOVER_CXL_DEVICE_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DISCOVER_CXL_SWITCH_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DISCOVER_LD_COMMAND;
+
+	/*
+	 * Discover available FM instances
+	 */
+	pub fn discover_fms(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_DISCOVER_FM_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DISCOVER_FM_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Discover available CXL devices
+	 */
+	pub fn discover_cxl_devices(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_DISCOVER_DEVICES_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DISCOVER_CXL_DEVICE_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Discover available CXL switches
+	 */
+	pub fn discover_cxl_switches(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_DISCOVER_SWITCHES_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DISCOVER_CXL_SWITCH_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Discover available logical devices
+	 */
+	pub fn discover_logical_devices(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_DISCOVER_LOGICAL_DEVICES_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DISCOVER_LD_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+}
diff --git a/fm_cli/src/dynamic_capacity_device.rs b/fm_cli/src/dynamic_capacity_device.rs
new file mode 100644
index 0000000..db4692f
--- /dev/null
+++ b/fm_cli/src/dynamic_capacity_device.rs
@@ -0,0 +1,225 @@
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
+	use clap::{ArgMatches};
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_command;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_GET_INFO_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_GET_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_SET_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_GET_EXTENT_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_ADD_CAPACITY_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_DCD_RELEASE_CAPACITY_COMMAND;
+
+	/*
+	 * Get Dynamic Capacity Device (DCD) info
+	 */
+	pub fn get_info(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_DCD_GET_INFO_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DCD_GET_INFO_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Get dynamic capacity region configuration
+	 */
+	pub fn get_capacity_config(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_DCD_GET_CONFIG_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DCD_GET_CONFIG_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Set dynamic capacity region configuration
+	 */
+	pub fn set_capacity_config(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_DCD_SET_CONFIG_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DCD_SET_CONFIG_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Get Dynamic Capacity Device (DCD) extent list
+	 */
+	pub fn get_extent_list(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_DCD_GET_EXTENT_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DCD_GET_EXTENT_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Initiate dynamic capacity add
+	 */
+	pub fn add_capacity(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_DCD_ADD_CAPACITY_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DCD_ADD_CAPACITY_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Initiate dynamic capacity release
+	 */
+	pub fn release_capacity(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_DCD_RELEASE_CAPACITY_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DCD_RELEASE_CAPACITY_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+}
diff --git a/fm_cli/src/fm.rs b/fm_cli/src/fm.rs
new file mode 100644
index 0000000..c6ce77d
--- /dev/null
+++ b/fm_cli/src/fm.rs
@@ -0,0 +1,258 @@
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
+pub mod cxl_fm_command {
+	use clap::{ArgMatches};
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_command;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_FM_INFO_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_START_FM_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_RESTART_FM_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_STOP_FM_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_FM_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_SET_FM_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_FM_EVENTS_COMMAND;
+
+	/*
+	 * Get Fabric Manager (FM) status/info
+	 */
+	pub fn get_info(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_GET_INFO_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_FM_INFO_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Start Fabric Manager (FM) instance
+	 */
+	pub fn start(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_START_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_START_FM_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Restart Fabric Manager (FM) instance
+	 */
+	pub fn restart(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_RESTART_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_RESTART_FM_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Stop Fabric Manager (FM) instance
+	 */
+	pub fn stop(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_STOP_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_STOP_FM_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Get Fabric Manager (FM) configuration
+	 */
+	pub fn get_config(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_GET_CONFIG_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_FM_CONFIG_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Set Fabric Manager (FM) configuration
+	 */
+	pub fn set_config(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_SET_CONFIG_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_SET_FM_CONFIG_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Get Fabric Manager (FM) event records
+	 */
+	pub fn get_events(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_GET_EVENTS_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_FM_EVENTS_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+}
diff --git a/fm_cli/src/logical_device.rs b/fm_cli/src/logical_device.rs
new file mode 100644
index 0000000..9ef7ddb
--- /dev/null
+++ b/fm_cli/src/logical_device.rs
@@ -0,0 +1,489 @@
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
+	use clap::{ArgMatches};
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_command;
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
+
+	/*
+	 * Bind Logical Device (LD)
+	 */
+	pub fn bind(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_BIND_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_BIND_LD_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Unbind Logical Device (LD)
+	 */
+	pub fn unbind(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_UNBIND_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_UNBIND_LD_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Connect Multi Logical Device (MLD) to CXL switch
+	 */
+	pub fn connect(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_CONNECT_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_CONNECT_MLD_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Disconnect Multi Logical Device (MLD) from CXL switch
+	 */
+	pub fn disconnect(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_DISCONNECT_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_DISCONNECT_MLD_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Get Logical Device (LD) allocations
+	 */
+	pub fn get_allocation(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_GET_ALLOCATION_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_LD_ALLOCATION_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Set Logical Device (LD) allocations
+	 */
+	pub fn set_allocation(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_SET_ALLOCATION_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_SET_LD_ALLOCATION_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Get QoS control
+	 */
+	pub fn get_qos_control(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_GET_QOS_CONTROL_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_QOS_CONTROL_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Set QoS control
+	 */
+	pub fn set_qos_control(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_SET_QOS_CONTROL_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_SET_QOS_CONTROL_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Get QoS status
+	 */
+	pub fn get_qos_status(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_GET_QOS_STATUS_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_QOS_STATUS_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Get QoS allocated bandwidth
+	 */
+	pub fn get_qos_bandwidth(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_QOS_BANDWIDTH_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Set QoS allocated bandwidth
+	 */
+	pub fn set_qos_bandwidth(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_SET_QOS_BANDWIDTH_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Get QoS bandwidth limit
+	 */
+	pub fn get_qos_bandwidth_limit(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_LIMIT_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_QOS_BANDWIDTH_LIMIT_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Set QoS bandwidth limit
+	 */
+	pub fn set_qos_bandwidth_limit(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_LIMIT_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_SET_QOS_BANDWIDTH_LIMIT_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Secure erase after unbinding
+	 */
+	pub fn erase(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_LOGICAL_DEVICE_ERASE_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_LD_ERASE,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+}
diff --git a/fm_cli/src/main.rs b/fm_cli/src/main.rs
new file mode 100644
index 0000000..b580a84
--- /dev/null
+++ b/fm_cli/src/main.rs
@@ -0,0 +1,721 @@
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
+use clap::{Arg, Command};
+pub use crate::discover::cxl_fm_discover_command;
+pub use crate::fm::cxl_fm_command;
+pub use crate::switch::cxl_switch_command;
+pub use crate::multi_headed_device::cxl_mh_device_command;
+pub use crate::logical_device::cxl_logical_device_command;
+pub use crate::pci2pci_bridge::cxl_ppb_command;
+pub use crate::physical_port::cxl_physical_port_command;
+pub use crate::mld_port::cxl_mld_port_command;
+pub use crate::dynamic_capacity_device::cxl_dcd_command;
+pub use fm_library::cxl_fm_lib::CxlFmOptions;
+
+/*
+ * CXL FM configuration tool version
+ */
+const CXL_FM_TOOL_VERSION: &str = "0.0.1";
+
+/*
+ * CXL FM configuration tool strings
+ */
+const CXL_FM_TOOL_NAME: &str = "fm_cli";
+const CXL_FM_TOOL_DESCRIPTOR: &str = "CXL Fabric Manager (FM) CLI";
+const CXL_FM_TOOL_DEBUG_OPTION: &str = "debug";
+const CXL_FM_TOOL_DEBUG_OPTION_SHORT: char = 'd';
+const CXL_FM_TOOL_IP_ADDRESS_OPTION: &str = "ip";
+const CXL_FM_TOOL_IP_ADDRESS_OPTION_SHORT: char = 'i';
+const CXL_FM_TOOL_PORT_OPTION: &str = "port";
+const CXL_FM_TOOL_PORT_OPTION_SHORT: char = 'p';
+
+/*
+ * Discover command strings
+ */
+const CXL_FM_DISCOVER_COMMAND: &str = "discover";
+const CXL_FM_DISCOVER_COMMAND_DESCRIPTOR: &str = "Discover available CXL agents";
+const CXL_FM_DISCOVER_FM_COMMAND: &str = "fm";
+const CXL_FM_DISCOVER_FM_COMMAND_DESCRIPTOR: &str = "Discover FM instances";
+const CXL_FM_DISCOVER_DEVICES_COMMAND: &str = "cxl_devices";
+const CXL_FM_DISCOVER_DEVICES_COMMAND_DESCRIPTOR: &str = "Discover CXL devices";
+const CXL_FM_DISCOVER_SWITCHES_COMMAND: &str = "cxl_switch";
+const CXL_FM_DISCOVER_SWITCHES_COMMAND_DESCRIPTOR: &str = "Discover CXL switches";
+const CXL_FM_DISCOVER_LOGICAL_DEVICES_COMMAND: &str = "logical_devices";
+const CXL_FM_DISCOVER_LOGICAL_DEVICES_COMMAND_DESCRIPTOR: &str = "Discover logical devices";
+
+/*
+ * FM command strings
+ */
+const CXL_FM_COMMAND: &str = "fm";
+const CXL_FM_COMMAND_DESCRIPTOR: &str = "Manage Fabric Manager (FM)";
+const CXL_FM_GET_INFO_COMMAND: &str = "get_info";
+const CXL_FM_GET_INFO_COMMAND_DESCRIPTOR: &str = "Get Fabric Manager (FM) status/info";
+const CXL_FM_START_COMMAND: &str = "start";
+const CXL_FM_START_COMMAND_DESCRIPTOR: &str = "Start Fabric Manager (FM) instance";
+const CXL_FM_RESTART_COMMAND: &str = "restart";
+const CXL_FM_RESTART_COMMAND_DESCRIPTOR: &str = "Restart Fabric Manager (FM) instance";
+const CXL_FM_STOP_COMMAND: &str = "stop";
+const CXL_FM_STOP_COMMAND_DESCRIPTOR: &str = "Stop Fabric Manager (FM) instance";
+const CXL_FM_GET_CONFIG_COMMAND: &str = "get_config";
+const CXL_FM_GET_CONFIG_COMMAND_DESCRIPTOR: &str = "Get Fabric Manager (FM) configuration";
+const CXL_FM_SET_CONFIG_COMMAND: &str = "set_config";
+const CXL_FM_SET_CONFIG_COMMAND_DESCRIPTOR: &str = "Set Fabric Manager (FM) configuration";
+const CXL_FM_GET_EVENTS_COMMAND: &str = "get_events";
+const CXL_FM_GET_EVENTS_COMMAND_DESCRIPTOR: &str = "Get Fabric Manager (FM) event records";
+
+/*
+ * Switch command strings
+ */
+const CXL_FM_SWITCH_COMMAND: &str = "switch";
+const CXL_FM_SWITCH_COMMAND_DESCRIPTOR: &str = "Manage CXL switch";
+const CXL_FM_SWITCH_GET_INFO_COMMAND: &str = "get_info";
+const CXL_FM_SWITCH_GET_INFO_COMMAND_DESCRIPTOR: &str = "Get CXL switch status/info";
+const CXL_FM_SWITCH_GET_CONFIG_COMMAND: &str = "get_config";
+const CXL_FM_SWITCH_GET_CONFIG_COMMAND_DESCRIPTOR: &str = "Get CXL switch configuration";
+const CXL_FM_SWITCH_SET_CONFIG_COMMAND: &str = "set_config";
+const CXL_FM_SWITCH_SET_CONFIG_COMMAND_DESCRIPTOR: &str = "Set CXL switch configuration";
+
+/*
+ * Multi Headed Device (MHD) command strings
+ */
+const CXL_FM_MH_DEVICE_COMMAND: &str = "mh_device";
+const CXL_FM_MH_DEVICE_COMMAND_DESCRIPTOR: &str = "Manage Multi Headed Device (MHD)";
+const CXL_FM_MH_DEVICE_GET_INFO_COMMAND: &str = "get_info";
+const CXL_FM_MH_DEVICE_GET_INFO_COMMAND_DESCRIPTOR: &str = "Get Multi Headed Device (MHD) status/info";
+
+/*
+ * Logical Device (LD) command strings
+ */
+const CXL_FM_LOGICAL_DEVICE_COMMAND: &str = "logical_device";
+const CXL_FM_LOGICAL_DEVICE_COMMAND_DESCRIPTOR: &str = "Manage Logical Device (LD)";
+const CXL_FM_LOGICAL_DEVICE_BIND_COMMAND: &str = "bind";
+const CXL_FM_LOGICAL_DEVICE_BIND_COMMAND_DESCRIPTOR: &str = "Bind Logical Device (LD)";
+const CXL_FM_LOGICAL_DEVICE_UNBIND_COMMAND: &str = "unbind";
+const CXL_FM_LOGICAL_DEVICE_UNBIND_COMMAND_DESCRIPTOR: &str = "Unbind Logical Device (LD)";
+const CXL_FM_LOGICAL_DEVICE_CONNECT_COMMAND: &str = "connect";
+const CXL_FM_LOGICAL_DEVICE_CONNECT_COMMAND_DESCRIPTOR: &str = "Connect Multi Logical Device (MLD) to CXL switch";
+const CXL_FM_LOGICAL_DEVICE_DISCONNECT_COMMAND: &str = "disconnect";
+const CXL_FM_LOGICAL_DEVICE_DISCONNECT_COMMAND_DESCRIPTOR: &str = "Disconnect Multi Logical Device (MLD) from CXL switch";
+const CXL_FM_LOGICAL_DEVICE_GET_ALLOCATION_COMMAND: &str = "get_allocation";
+const CXL_FM_LOGICAL_DEVICE_GET_ALLOCATION_COMMAND_DESCRIPTOR: &str = "Get Logical Device (LD) allocations";
+const CXL_FM_LOGICAL_DEVICE_SET_ALLOCATION_COMMAND: &str = "set_allocation";
+const CXL_FM_LOGICAL_DEVICE_SET_ALLOCATION_COMMAND_DESCRIPTOR: &str = "Set Logical Device (LD) allocations";
+const CXL_FM_LOGICAL_DEVICE_GET_QOS_CONTROL_COMMAND: &str = "get_qos_control";
+const CXL_FM_LOGICAL_DEVICE_GET_QOS_CONTROL_COMMAND_DESCRIPTOR: &str = "Get QoS control";
+const CXL_FM_LOGICAL_DEVICE_SET_QOS_CONTROL_COMMAND: &str = "set_qos_control";
+const CXL_FM_LOGICAL_DEVICE_SET_QOS_CONTROL_COMMAND_DESCRIPTOR: &str = "Set QoS control";
+const CXL_FM_LOGICAL_DEVICE_GET_QOS_STATUS_COMMAND: &str = "get_qos_status";
+const CXL_FM_LOGICAL_DEVICE_GET_QOS_STATUS_COMMAND_DESCRIPTOR: &str = "Get QoS status";
+const CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_COMMAND: &str = "get_qos_allocated_bandwidth";
+const CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_COMMAND_DESCRIPTOR: &str = "Get QoS allocated bandwidth";
+const CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_COMMAND: &str = "set_qos_allocated_bandwidth";
+const CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_COMMAND_DESCRIPTOR: &str = "Set QoS allocated bandwidth";
+const CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_LIMIT_COMMAND: &str = "get_qos_bandwidth_limit";
+const CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_LIMIT_COMMAND_DESCRIPTOR: &str = "Get QoS bandwidth limit";
+const CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_LIMIT_COMMAND: &str = "set_qos_bandwidth_limit";
+const CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_LIMIT_COMMAND_DESCRIPTOR: &str = "Set QoS bandwidth limit";
+const CXL_FM_LOGICAL_DEVICE_ERASE_COMMAND: &str = "erase";
+const CXL_FM_LOGICAL_DEVICE_ERASE_COMMAND_DESCRIPTOR: &str = "Secure erase after unbinding";
+
+/*
+ * PCI-to-PCI Bridge (PPB) command strings
+ */
+const CXL_FM_PPB_COMMAND: &str = "ppb";
+const CXL_FM_PPB_COMMAND_DESCRIPTOR: &str = "Manage PCI-to-PCI Bridge (PPB)";
+const CXL_FM_PPB_CONFIG_COMMAND: &str = "config";
+const CXL_FM_PPB_CONFIG_COMMAND_DESCRIPTOR: &str = "Send PCI-to-PCI Bridge (PPB) configuration request";
+const CXL_FM_PPB_BIND_COMMAND: &str = "bind";
+const CXL_FM_PPB_BIND_COMMAND_DESCRIPTOR: &str = "Bind Virtual PCI-to-PCI Bridge (vPPB) inside a CXL switch";
+const CXL_FM_PPB_UNBIND_COMMAND: &str = "unbind";
+const CXL_FM_PPB_UNBIND_COMMAND_DESCRIPTOR: &str = "Unbind Virtual PCI-to-PCI Bridge (vPPB) inside a CXL switch";
+
+/*
+ * Physical port command strings
+ */
+const CXL_FM_PHYSICAL_PORT_COMMAND: &str = "physical_port";
+const CXL_FM_PHYSICAL_PORT_COMMAND_DESCRIPTOR: &str = "Manage physical ports";
+const CXL_FM_PHYSICAL_PORT_GET_INFO_COMMAND: &str = "get_info";
+const CXL_FM_PHYSICAL_PORT_GET_INFO_COMMAND_DESCRIPTOR: &str = "Get state of physical port";
+const CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND: &str = "control";
+const CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND_DESCRIPTOR: &str = "Control physical port";
+const CXL_FM_PHYSICAL_PORT_BIND_COMMAND: &str = "bind";
+const CXL_FM_PHYSICAL_PORT_BIND_COMMAND_DESCRIPTOR: &str = "Bind physical port to Virtual PCI-to-PCI Bridge (vPPB)";
+const CXL_FM_PHYSICAL_PORT_UNBIND_COMMAND: &str = "unbind";
+const CXL_FM_PHYSICAL_PORT_UNBIND_COMMAND_DESCRIPTOR: &str = "Unbind physical port from Virtual PCI-to-PCI Bridge (vPPB)";
+
+/*
+ * Multi-Logical Device (MLD) ports command strings
+ */
+const CXL_FM_MLD_PORT_COMMAND: &str = "mld_port";
+const CXL_FM_MLD_PORT_COMMAND_DESCRIPTOR: &str = "Manage Multi-Logical Device (MLD) ports";
+const CXL_FM_MLD_PORT_TUNNEL_COMMAND: &str = "tunnel";
+const CXL_FM_MLD_PORT_TUNNEL_COMMAND_DESCRIPTOR: &str = "Tunnel Management Command";
+const CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND: &str = "send_config";
+const CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND_DESCRIPTOR: &str = "Send CXL.io configuration request";
+const CXL_FM_MLD_PORT_SEND_MEM_REQUEST_COMMAND: &str = "send_memory_request";
+const CXL_FM_MLD_PORT_SEND_MEM_REQUEST_COMMAND_DESCRIPTOR: &str = "Send CXL.io memory request";
+
+/*
+ * Dynamic Capacity Device (DCD) command strings
+ */
+const CXL_FM_DCD_COMMAND: &str = "dcd";
+const CXL_FM_DCD_COMMAND_DESCRIPTOR: &str = "Manage Dynamic Capacity Device (DCD)";
+const CXL_FM_DCD_GET_INFO_COMMAND: &str = "get_info";
+const CXL_FM_DCD_GET_INFO_COMMAND_DESCRIPTOR: &str = "Get Dynamic Capacity Device (DCD) info";
+const CXL_FM_DCD_GET_CONFIG_COMMAND: &str = "get_capacity_config";
+const CXL_FM_DCD_GET_CONFIG_COMMAND_DESCRIPTOR: &str = "Get dynamic capacity region configuration";
+const CXL_FM_DCD_SET_CONFIG_COMMAND: &str = "set_capacity_config";
+const CXL_FM_DCD_SET_CONFIG_COMMAND_DESCRIPTOR: &str = "Set dynamic capacity region configuration";
+const CXL_FM_DCD_GET_EXTENT_COMMAND: &str = "get_extent_list";
+const CXL_FM_DCD_GET_EXTENT_COMMAND_DESCRIPTOR: &str = "Get Dynamic Capacity Device (DCD) extent list";
+const CXL_FM_DCD_ADD_CAPACITY_COMMAND: &str = "add_capacity";
+const CXL_FM_DCD_ADD_CAPACITY_COMMAND_DESCRIPTOR: &str = "Initiate dynamic capacity add";
+const CXL_FM_DCD_RELEASE_CAPACITY_COMMAND: &str = "release_capacity";
+const CXL_FM_DCD_RELEASE_CAPACITY_COMMAND_DESCRIPTOR: &str = "Initiate dynamic capacity release";
+
+/*
+ * Command line interface definition
+ */
+fn cli() -> Command {
+	Command::new(CXL_FM_TOOL_NAME)
+		.about(CXL_FM_TOOL_DESCRIPTOR)
+		.version(CXL_FM_TOOL_VERSION)
+		.subcommand_required(true)
+		.arg_required_else_help(true)
+		.allow_external_subcommands(true)
+		.arg(Arg::new(CXL_FM_TOOL_DEBUG_OPTION)
+			.short(CXL_FM_TOOL_DEBUG_OPTION_SHORT)
+			.long(CXL_FM_TOOL_DEBUG_OPTION)
+			.action(clap::ArgAction::SetTrue))
+		.arg(Arg::new(CXL_FM_TOOL_IP_ADDRESS_OPTION)
+			.short(CXL_FM_TOOL_IP_ADDRESS_OPTION_SHORT)
+			.long(CXL_FM_TOOL_IP_ADDRESS_OPTION)
+			.action(clap::ArgAction::Set)
+			.required(true))
+		.arg(Arg::new(CXL_FM_TOOL_PORT_OPTION)
+			.short(CXL_FM_TOOL_PORT_OPTION_SHORT)
+			.long(CXL_FM_TOOL_PORT_OPTION)
+			.action(clap::ArgAction::Set)
+			.required(true))
+		.subcommand(
+			Command::new(CXL_FM_DISCOVER_COMMAND)
+				.about(CXL_FM_DISCOVER_COMMAND_DESCRIPTOR)
+				.subcommand_required(true)
+				.arg_required_else_help(true)
+				.allow_external_subcommands(true)
+				.subcommand(
+					Command::new(CXL_FM_DISCOVER_FM_COMMAND)
+						.about(CXL_FM_DISCOVER_FM_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_DISCOVER_DEVICES_COMMAND)
+						.about(CXL_FM_DISCOVER_DEVICES_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_DISCOVER_SWITCHES_COMMAND)
+						.about(CXL_FM_DISCOVER_SWITCHES_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_DISCOVER_LOGICAL_DEVICES_COMMAND)
+						.about(CXL_FM_DISCOVER_LOGICAL_DEVICES_COMMAND_DESCRIPTOR)
+				)
+		)
+		.subcommand(
+			Command::new(CXL_FM_COMMAND)
+				.about(CXL_FM_COMMAND_DESCRIPTOR)
+				.subcommand_required(true)
+				.arg_required_else_help(true)
+				.allow_external_subcommands(true)
+				.subcommand(
+					Command::new(CXL_FM_GET_INFO_COMMAND)
+						.about(CXL_FM_GET_INFO_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_START_COMMAND)
+						.about(CXL_FM_START_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_RESTART_COMMAND)
+						.about(CXL_FM_RESTART_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_STOP_COMMAND)
+						.about(CXL_FM_STOP_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_GET_CONFIG_COMMAND)
+						.about(CXL_FM_GET_CONFIG_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_SET_CONFIG_COMMAND)
+						.about(CXL_FM_SET_CONFIG_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_GET_EVENTS_COMMAND)
+						.about(CXL_FM_GET_EVENTS_COMMAND_DESCRIPTOR)
+				)
+		)
+		.subcommand(
+			Command::new(CXL_FM_SWITCH_COMMAND)
+				.about(CXL_FM_SWITCH_COMMAND_DESCRIPTOR)
+				.subcommand_required(true)
+				.arg_required_else_help(true)
+				.allow_external_subcommands(true)
+				.subcommand(
+					Command::new(CXL_FM_SWITCH_GET_INFO_COMMAND)
+						.about(CXL_FM_SWITCH_GET_INFO_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_SWITCH_GET_CONFIG_COMMAND)
+						.about(CXL_FM_SWITCH_GET_CONFIG_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_SWITCH_SET_CONFIG_COMMAND)
+						.about(CXL_FM_SWITCH_SET_CONFIG_COMMAND_DESCRIPTOR)
+				)
+		)
+		.subcommand(
+			Command::new(CXL_FM_MH_DEVICE_COMMAND)
+				.about(CXL_FM_MH_DEVICE_COMMAND_DESCRIPTOR)
+				.subcommand_required(true)
+				.arg_required_else_help(true)
+				.allow_external_subcommands(true)
+				.subcommand(
+					Command::new(CXL_FM_MH_DEVICE_GET_INFO_COMMAND)
+						.about(CXL_FM_MH_DEVICE_GET_INFO_COMMAND_DESCRIPTOR)
+				)
+		)
+		.subcommand(
+			Command::new(CXL_FM_LOGICAL_DEVICE_COMMAND)
+				.about(CXL_FM_LOGICAL_DEVICE_COMMAND_DESCRIPTOR)
+				.subcommand_required(true)
+				.arg_required_else_help(true)
+				.allow_external_subcommands(true)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_BIND_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_BIND_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_UNBIND_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_UNBIND_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_CONNECT_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_CONNECT_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_DISCONNECT_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_DISCONNECT_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_GET_ALLOCATION_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_GET_ALLOCATION_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_SET_ALLOCATION_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_SET_ALLOCATION_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_GET_QOS_CONTROL_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_GET_QOS_CONTROL_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_SET_QOS_CONTROL_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_SET_QOS_CONTROL_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_GET_QOS_STATUS_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_GET_QOS_STATUS_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_LIMIT_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_LIMIT_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_LIMIT_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_LIMIT_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_LOGICAL_DEVICE_ERASE_COMMAND)
+						.about(CXL_FM_LOGICAL_DEVICE_ERASE_COMMAND_DESCRIPTOR)
+				)
+		)
+		.subcommand(
+			Command::new(CXL_FM_PPB_COMMAND)
+				.about(CXL_FM_PPB_COMMAND_DESCRIPTOR)
+				.subcommand_required(true)
+				.arg_required_else_help(true)
+				.allow_external_subcommands(true)
+				.subcommand(
+					Command::new(CXL_FM_PPB_CONFIG_COMMAND)
+						.about(CXL_FM_PPB_CONFIG_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_PPB_BIND_COMMAND)
+						.about(CXL_FM_PPB_BIND_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_PPB_UNBIND_COMMAND)
+						.about(CXL_FM_PPB_UNBIND_COMMAND_DESCRIPTOR)
+				)
+		)
+		.subcommand(
+			Command::new(CXL_FM_PHYSICAL_PORT_COMMAND)
+				.about(CXL_FM_PHYSICAL_PORT_COMMAND_DESCRIPTOR)
+				.subcommand_required(true)
+				.arg_required_else_help(true)
+				.allow_external_subcommands(true)
+				.subcommand(
+					Command::new(CXL_FM_PHYSICAL_PORT_GET_INFO_COMMAND)
+						.about(CXL_FM_PHYSICAL_PORT_GET_INFO_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND)
+						.about(CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_PHYSICAL_PORT_BIND_COMMAND)
+						.about(CXL_FM_PHYSICAL_PORT_BIND_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_PHYSICAL_PORT_UNBIND_COMMAND)
+						.about(CXL_FM_PHYSICAL_PORT_UNBIND_COMMAND_DESCRIPTOR)
+				)
+		)
+		.subcommand(
+			Command::new(CXL_FM_MLD_PORT_COMMAND)
+				.about(CXL_FM_MLD_PORT_COMMAND_DESCRIPTOR)
+				.subcommand_required(true)
+				.arg_required_else_help(true)
+				.allow_external_subcommands(true)
+				.subcommand(
+					Command::new(CXL_FM_MLD_PORT_TUNNEL_COMMAND)
+						.about(CXL_FM_MLD_PORT_TUNNEL_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND)
+						.about(CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_MLD_PORT_SEND_MEM_REQUEST_COMMAND)
+						.about(CXL_FM_MLD_PORT_SEND_MEM_REQUEST_COMMAND_DESCRIPTOR)
+				)
+		)
+		.subcommand(
+			Command::new(CXL_FM_DCD_COMMAND)
+				.about(CXL_FM_DCD_COMMAND_DESCRIPTOR)
+				.subcommand_required(true)
+				.arg_required_else_help(true)
+				.allow_external_subcommands(true)
+				.subcommand(
+					Command::new(CXL_FM_DCD_GET_INFO_COMMAND)
+						.about(CXL_FM_DCD_GET_INFO_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_DCD_GET_CONFIG_COMMAND)
+						.about(CXL_FM_DCD_GET_CONFIG_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_DCD_SET_CONFIG_COMMAND)
+						.about(CXL_FM_DCD_SET_CONFIG_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_DCD_GET_EXTENT_COMMAND)
+						.about(CXL_FM_DCD_GET_EXTENT_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_DCD_ADD_CAPACITY_COMMAND)
+						.about(CXL_FM_DCD_ADD_CAPACITY_COMMAND_DESCRIPTOR)
+				)
+				.subcommand(
+					Command::new(CXL_FM_DCD_RELEASE_CAPACITY_COMMAND)
+						.about(CXL_FM_DCD_RELEASE_CAPACITY_COMMAND_DESCRIPTOR)
+				)
+		)
+}
+
+/*
+ * Application logic
+ */
+fn main() {
+	let matches = cli().get_matches();
+
+	let ip = matches.get_one::<String>(CXL_FM_TOOL_IP_ADDRESS_OPTION).unwrap();
+	let port = matches.get_one::<String>(CXL_FM_TOOL_PORT_OPTION).unwrap();
+	let ip_port = format!("{ip}:{port}");
+
+	let options = CxlFmOptions {
+		ip_port: String::from(ip_port),
+		is_debug: matches.get_flag(CXL_FM_TOOL_DEBUG_OPTION) == true,
+	};
+
+	if options.is_debug {
+		println!("{} {}", CXL_FM_TOOL_NAME, CXL_FM_TOOL_VERSION);
+	}
+
+	match matches.subcommand() {
+		Some((CXL_FM_DISCOVER_COMMAND, discover)) => {
+			match discover.subcommand() {
+				Some((CXL_FM_DISCOVER_FM_COMMAND, fm)) => {
+					cxl_fm_discover_command::discover_fms(&fm,
+									      &options);
+				},
+				Some((CXL_FM_DISCOVER_DEVICES_COMMAND, devices)) => {
+					cxl_fm_discover_command::discover_cxl_devices(&devices,
+										      &options);
+				},
+				Some((CXL_FM_DISCOVER_SWITCHES_COMMAND, switch)) => {
+					cxl_fm_discover_command::discover_cxl_switches(&switch,
+											&options);
+				},
+				Some((CXL_FM_DISCOVER_LOGICAL_DEVICES_COMMAND, logical_devices)) => {
+					cxl_fm_discover_command::discover_logical_devices(&logical_devices,
+											  &options);
+				},
+				_ => unreachable!(),
+			}
+		},
+		Some((CXL_FM_COMMAND, fm)) => {
+			match fm.subcommand() {
+				Some((CXL_FM_GET_INFO_COMMAND, get_info)) => {
+					cxl_fm_command::get_info(&get_info,
+								 &options);
+				},
+				Some((CXL_FM_START_COMMAND, start)) => {
+					cxl_fm_command::start(&start,
+							      &options);
+				},
+				Some((CXL_FM_RESTART_COMMAND, restart)) => {
+					cxl_fm_command::restart(&restart,
+								&options);
+				},
+				Some((CXL_FM_STOP_COMMAND, stop)) => {
+					cxl_fm_command::stop(&stop,
+							     &options);
+				},
+				Some((CXL_FM_GET_CONFIG_COMMAND, get_config)) => {
+					cxl_fm_command::get_config(&get_config,
+								   &options);
+				},
+				Some((CXL_FM_SET_CONFIG_COMMAND, set_config)) => {
+					cxl_fm_command::set_config(&set_config,
+								   &options);
+				},
+				Some((CXL_FM_GET_EVENTS_COMMAND, get_events)) => {
+					cxl_fm_command::get_events(&get_events,
+								   &options);
+				},
+				_ => unreachable!(),
+			}
+		},
+		Some((CXL_FM_SWITCH_COMMAND, switch)) => {
+			match switch.subcommand() {
+				Some((CXL_FM_SWITCH_GET_INFO_COMMAND, get_info)) => {
+					cxl_switch_command::get_info(&get_info,
+								     &options);
+				},
+				Some((CXL_FM_SWITCH_GET_CONFIG_COMMAND, get_config)) => {
+					cxl_switch_command::get_config(&get_config,
+								       &options);
+				},
+				Some((CXL_FM_SWITCH_SET_CONFIG_COMMAND, set_config)) => {
+					cxl_switch_command::set_config(&set_config,
+									&options);
+				},
+				_ => unreachable!(),
+			}
+		},
+		Some((CXL_FM_MH_DEVICE_COMMAND, mh_device)) => {
+			match mh_device.subcommand() {
+				Some((CXL_FM_MH_DEVICE_GET_INFO_COMMAND, get_info)) => {
+					cxl_mh_device_command::get_info(&get_info,
+									&options);
+				},
+				_ => unreachable!(),
+			}
+		},
+		Some((CXL_FM_LOGICAL_DEVICE_COMMAND, logical_device)) => {
+			match logical_device.subcommand() {
+				Some((CXL_FM_LOGICAL_DEVICE_BIND_COMMAND, bind)) => {
+					cxl_logical_device_command::bind(&bind,
+									 &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_UNBIND_COMMAND, unbind)) => {
+					cxl_logical_device_command::unbind(&unbind,
+									   &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_CONNECT_COMMAND, connect)) => {
+					cxl_logical_device_command::connect(&connect,
+									    &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_DISCONNECT_COMMAND, disconnect)) => {
+					cxl_logical_device_command::disconnect(&disconnect,
+										&options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_GET_ALLOCATION_COMMAND, get_allocation)) => {
+					cxl_logical_device_command::get_allocation(&get_allocation,
+										   &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_SET_ALLOCATION_COMMAND, set_allocation)) => {
+					cxl_logical_device_command::set_allocation(&set_allocation,
+										   &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_GET_QOS_CONTROL_COMMAND, get_qos_control)) => {
+					cxl_logical_device_command::get_qos_control(&get_qos_control,
+										    &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_SET_QOS_CONTROL_COMMAND, set_qos_control)) => {
+					cxl_logical_device_command::set_qos_control(&set_qos_control,
+										    &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_GET_QOS_STATUS_COMMAND, get_qos_status)) => {
+					cxl_logical_device_command::get_qos_status(&get_qos_status,
+										   &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_COMMAND, get_qos_bandwidth)) => {
+					cxl_logical_device_command::get_qos_bandwidth(&get_qos_bandwidth,
+										      &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_COMMAND, set_qos_bandwidth)) => {
+					cxl_logical_device_command::set_qos_bandwidth(&set_qos_bandwidth,
+										      &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_GET_QOS_BANDWIDTH_LIMIT_COMMAND, get_qos_bandwidth_limit)) => {
+					cxl_logical_device_command::get_qos_bandwidth_limit(&get_qos_bandwidth_limit,
+											    &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_SET_QOS_BANDWIDTH_LIMIT_COMMAND, set_qos_bandwidth_limit)) => {
+					cxl_logical_device_command::set_qos_bandwidth_limit(&set_qos_bandwidth_limit,
+											    &options);
+				},
+				Some((CXL_FM_LOGICAL_DEVICE_ERASE_COMMAND, erase)) => {
+					cxl_logical_device_command::erase(&erase,
+									  &options);
+				},
+				_ => unreachable!(),
+			}
+		},
+		Some((CXL_FM_PPB_COMMAND, ppb)) => {
+			match ppb.subcommand() {
+				Some((CXL_FM_PPB_CONFIG_COMMAND, config)) => {
+					cxl_ppb_command::config(&config,
+								&options);
+				},
+				Some((CXL_FM_PPB_BIND_COMMAND, bind)) => {
+					cxl_ppb_command::bind(&bind,
+							      &options);
+				},
+				Some((CXL_FM_PPB_UNBIND_COMMAND, unbind)) => {
+					cxl_ppb_command::unbind(&unbind,
+								&options);
+				},
+				_ => unreachable!(),
+			}
+		},
+		Some((CXL_FM_PHYSICAL_PORT_COMMAND, physical_port)) => {
+			match physical_port.subcommand() {
+				Some((CXL_FM_PHYSICAL_PORT_GET_INFO_COMMAND, get_info)) => {
+					cxl_physical_port_command::get_info(&get_info,
+									    &options);
+				},
+				Some((CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND, control)) => {
+					cxl_physical_port_command::control(&control,
+									   &options);
+				},
+				Some((CXL_FM_PHYSICAL_PORT_BIND_COMMAND, bind)) => {
+					cxl_physical_port_command::bind(&bind,
+									&options);
+				},
+				Some((CXL_FM_PHYSICAL_PORT_UNBIND_COMMAND, unbind)) => {
+					cxl_physical_port_command::unbind(&unbind,
+									  &options);
+				},
+				_ => unreachable!(),
+			}
+		},
+		Some((CXL_FM_MLD_PORT_COMMAND, mld_port)) => {
+			match mld_port.subcommand() {
+				Some((CXL_FM_MLD_PORT_TUNNEL_COMMAND, tunnel)) => {
+					cxl_mld_port_command::tunnel(&tunnel,
+								     &options);
+				},
+				Some((CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND, send_config)) => {
+					cxl_mld_port_command::send_config(&send_config,
+									  &options);
+				},
+				Some((CXL_FM_MLD_PORT_SEND_MEM_REQUEST_COMMAND, send_memory_request)) => {
+					cxl_mld_port_command::send_memory_request(&send_memory_request,
+										  &options);
+				},
+				_ => unreachable!(),
+			}
+		},
+		Some((CXL_FM_DCD_COMMAND, dcd)) => {
+			match dcd.subcommand() {
+				Some((CXL_FM_DCD_GET_INFO_COMMAND, get_info)) => {
+					cxl_dcd_command::get_info(&get_info,
+								  &options);
+				},
+				Some((CXL_FM_DCD_GET_CONFIG_COMMAND, get_capacity_config)) => {
+					cxl_dcd_command::get_capacity_config(&get_capacity_config,
+									     &options);
+				},
+				Some((CXL_FM_DCD_SET_CONFIG_COMMAND, set_capacity_config)) => {
+					cxl_dcd_command::set_capacity_config(&set_capacity_config,
+									     &options);
+				},
+				Some((CXL_FM_DCD_GET_EXTENT_COMMAND, get_extent_list)) => {
+					cxl_dcd_command::get_extent_list(&get_extent_list,
+									 &options);
+				},
+				Some((CXL_FM_DCD_ADD_CAPACITY_COMMAND, add_capacity)) => {
+					cxl_dcd_command::add_capacity(&add_capacity,
+								      &options);
+				},
+				Some((CXL_FM_DCD_RELEASE_CAPACITY_COMMAND, release_capacity)) => {
+					cxl_dcd_command::release_capacity(&release_capacity,
+									  &options);
+				},
+				_ => unreachable!(),
+			}
+		},
+		_ => unreachable!(),
+	}
+}
diff --git a/fm_cli/src/mld_port.rs b/fm_cli/src/mld_port.rs
new file mode 100644
index 0000000..f8ecbb3
--- /dev/null
+++ b/fm_cli/src/mld_port.rs
@@ -0,0 +1,126 @@
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
+	use clap::{ArgMatches};
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_command;
+	use fm_library::cxl_fm_lib::CXL_FM_MLD_PORT_TUNNEL_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_MLD_PORT_SEND_MEM_REQ_COMMAND;
+
+	/*
+	 * Tunnel Management Command
+	 */
+	pub fn tunnel(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_MLD_PORT_TUNNEL_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_MLD_PORT_TUNNEL_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Send CXL.io configuration request
+	 */
+	pub fn send_config(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_MLD_PORT_SEND_CONFIG_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Send CXL.io memory request
+	 */
+	pub fn send_memory_request(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_MLD_PORT_SEND_MEM_REQUEST_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_MLD_PORT_SEND_MEM_REQ_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+}
diff --git a/fm_cli/src/multi_headed_device.rs b/fm_cli/src/multi_headed_device.rs
new file mode 100644
index 0000000..00563fe
--- /dev/null
+++ b/fm_cli/src/multi_headed_device.rs
@@ -0,0 +1,60 @@
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
+	use clap::{ArgMatches};
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_command;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_MHD_INFO_COMMAND;
+
+	/*
+	 * Get Multi Headed Device (MHD) status/info
+	 */
+	pub fn get_info(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_MH_DEVICE_GET_INFO_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_MHD_INFO_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+}
diff --git a/fm_cli/src/pci2pci_bridge.rs b/fm_cli/src/pci2pci_bridge.rs
new file mode 100644
index 0000000..e7b82a5
--- /dev/null
+++ b/fm_cli/src/pci2pci_bridge.rs
@@ -0,0 +1,126 @@
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
+	use clap::{ArgMatches};
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_command;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_PPB_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_PPB_BIND_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_PPB_UNBIND_COMMAND;
+
+	/*
+	 * Send PCI-to-PCI Bridge (PPB) configuration request
+	 */
+	pub fn config(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_PPB_CONFIG_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_PPB_CONFIG_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Bind Virtual PCI-to-PCI Bridge (vPPB) inside a CXL switch
+	 */
+	pub fn bind(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_PPB_BIND_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_PPB_BIND_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Unbind Virtual PCI-to-PCI Bridge (vPPB) inside a CXL switch
+	 */
+	pub fn unbind(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_PPB_UNBIND_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_PPB_UNBIND_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+}
diff --git a/fm_cli/src/physical_port.rs b/fm_cli/src/physical_port.rs
new file mode 100644
index 0000000..6e887ed
--- /dev/null
+++ b/fm_cli/src/physical_port.rs
@@ -0,0 +1,159 @@
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
+	use clap::{ArgMatches};
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_command;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_PHYSICAL_PORT_INFO_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_BIND_PHYSICAL_PORT_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_UNBIND_PHYSICAL_PORT_COMMAND;
+
+	/*
+	 * Get state of physical port
+	 */
+	pub fn get_info(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_PHYSICAL_PORT_GET_INFO_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_PHYSICAL_PORT_INFO_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Control physical port
+	 */
+	pub fn control(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_PHYSICAL_PORT_CONTROL_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Bind physical port to Virtual PCI-to-PCI Bridge (vPPB)
+	 */
+	pub fn bind(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_PHYSICAL_PORT_BIND_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_BIND_PHYSICAL_PORT_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Unbind physical port from Virtual PCI-to-PCI Bridge (vPPB)
+	 */
+	pub fn unbind(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_PHYSICAL_PORT_UNBIND_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_UNBIND_PHYSICAL_PORT_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+}
diff --git a/fm_cli/src/switch.rs b/fm_cli/src/switch.rs
new file mode 100644
index 0000000..404bb07
--- /dev/null
+++ b/fm_cli/src/switch.rs
@@ -0,0 +1,126 @@
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
+	use clap::{ArgMatches};
+	use std::net::{TcpStream};
+	use fm_library::cxl_fm_lib::CxlFmOptions;
+	use fm_library::cxl_fm_lib::send_command;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_SWITCH_INFO_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_GET_SWITCH_CONFIG_COMMAND;
+	use fm_library::cxl_fm_lib::CXL_FM_SET_SWITCH_CONFIG_COMMAND;
+
+	/*
+	 * Get CXL switch status/info
+	 */
+	pub fn get_info(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_SWITCH_GET_INFO_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_SWITCH_INFO_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Get CXL switch configuration
+	 */
+	pub fn get_config(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_SWITCH_GET_CONFIG_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_GET_SWITCH_CONFIG_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+
+	/*
+	 * Set CXL switch configuration
+	 */
+	pub fn set_config(options: &ArgMatches, env: &CxlFmOptions) {
+		if env.is_debug {
+			println!("{}", crate::CXL_FM_SWITCH_SET_CONFIG_COMMAND_DESCRIPTOR);
+		}
+
+		if options.args_present() {
+			/*
+			 * Ignore currently.
+			 * Add code later.
+			 */
+		}
+
+		match TcpStream::connect(&env.ip_port) {
+			Ok(mut stream) => {
+				if env.is_debug {
+					println!("Successfully connected to server: {}",
+						 env.ip_port);
+				}
+
+				send_command(&mut stream,
+					     CXL_FM_SET_SWITCH_CONFIG_COMMAND,
+					     &env);
+			},
+			Err(e) => {
+				println!("Failed to connect: {}", e);
+			}
+		}
+	}
+}
-- 
2.34.1


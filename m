Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BC5C7EE29
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 21:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjFBVi2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 17:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbjFBVi1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 17:38:27 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C8FE48
        for <linux-cxl@vger.kernel.org>; Fri,  2 Jun 2023 14:38:25 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so2745372276.2
        for <linux-cxl@vger.kernel.org>; Fri, 02 Jun 2023 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20221208.gappssmtp.com; s=20221208; t=1685741904; x=1688333904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRmfyXecY25gL49zuje7ul5XB5Erxdmv0gNgjxc7/HA=;
        b=tEy715H+04wofUy6BMCLgJ6Sft5axd4K+36McJRrglZpuxSDM8W5NVtPKUFsa7+NHH
         DC7fzQBCuSPBb4nldOqq7fjAQzzUozviH5Cu/1zopKCJCtJGRJ5fJWYPFc3rMVsqCPZO
         rlEdLzNd0zFE0PZ6wdhgcF+rYHAq0jiNMkuhRx46wHSRuAayO1fw6hrAdGa5D9SDf1eA
         4qjswDYpaq5U5U+tFXtKyISa6JCe1/dd3YKrokybTDw/cFw5k1jZoIY+lUX3dhGKQbmd
         hbLsmQqZ4MwGXPfOAhTw4co7Nv1bs61yxSEVDjuaN6fTm6XvG6KAX1s1EV67VSdqt+vB
         /Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685741904; x=1688333904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRmfyXecY25gL49zuje7ul5XB5Erxdmv0gNgjxc7/HA=;
        b=eik0SFkPL0KgGTok1tP0jr1BV0X+1eqbiYo9GZ4qDWaIAE8JTBYo/bIrdMLwwsRP8p
         vtKdO1Xmb1Pqyj8pM9W26CW7vZJsgXyET90SagBS0IWV1TeyGY8OZzzFiMSkQvYezbpS
         Tcb3DE5PQxA5rmVKgK1weSTt+Pu4LBiITp/qNr4dzrT7QSFC4j0x20pPlgkQh4HMmew5
         IqRUCgL9v3Z/T1Qts4mzGhOZKMPBidMa56a/3hXjwezzyoSFw11EzAtG8Rtv4X0HMWgw
         EZHUTTrMXD4RU0jDZXgM3sJTmbHEG1GRXmj8COCai4GpN1S/PtAtfsS/M94rShFUZy06
         75wg==
X-Gm-Message-State: AC+VfDxKFA00USTCVaIHTf8suN2iREXmISCmy5a+/AX4fl1PneQzw1is
        3gYbF2w051ZNMVLTWjCiRPSV8iuAfJsYJGHPdlOngQ==
X-Google-Smtp-Source: ACHHUZ61YWOBoVww0w7WLvrInZtHdiD+iNni36xNt406VB56VvrzrLfiR4by6YluYGGRZ5JQDGA42Q==
X-Received: by 2002:a81:844f:0:b0:565:b22c:4165 with SMTP id u76-20020a81844f000000b00565b22c4165mr1319736ywf.11.1685741903717;
        Fri, 02 Jun 2023 14:38:23 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:42f0:6600:901f:39a8:fe3f:30e2])
        by smtp.gmail.com with ESMTPSA id v1-20020a0dd301000000b00559d9989490sm856302ywd.41.2023.06.02.14.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:38:22 -0700 (PDT)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-cxl@vger.kernel.org
Cc:     a.manzanares@samsung.com, Jonathan.Cameron@huawei.com,
        nilesh.shah@zptcorp.com, slava@dubeiko.com,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 4/5] CXL FM: [fm_orchestrator] introduce CXL FM orchestrator
Date:   Fri,  2 Jun 2023 14:37:36 -0700
Message-Id: <20230602213737.494750-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602213737.494750-1-slava@dubeyko.com>
References: <20230602213737.494750-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This patch creates the initial state of CXL FM orchestrator.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Adam Manzanares <a.manzanares@samsung.com>
---
 Cargo.toml               |   4 +
 orchestrator/Cargo.toml  |  10 ++
 orchestrator/src/main.rs | 221 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+)
 create mode 100644 orchestrator/Cargo.toml
 create mode 100644 orchestrator/src/main.rs

diff --git a/Cargo.toml b/Cargo.toml
index b8d169d..ed50825 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -13,6 +13,10 @@ path = "fm_library/src/lib.rs"
 name = "fm_daemon"
 path = "fm_daemon/src/main.rs"
 
+[[bin]]
+name = "orchestrator"
+path = "orchestrator/src/main.rs"
+
 [dependencies]
 clap = { version = "4.0.32", features = ["derive"] }
 daemonize = "0.5.0"
diff --git a/orchestrator/Cargo.toml b/orchestrator/Cargo.toml
new file mode 100644
index 0000000..64fe7a4
--- /dev/null
+++ b/orchestrator/Cargo.toml
@@ -0,0 +1,10 @@
+[package]
+name = "orchestrator"
+version = "0.1.0"
+edition = "2021"
+
+# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
+
+[dependencies]
+daemonize = "0.5.0"
+fm_library = { path = "../fm_library/" }
diff --git a/orchestrator/src/main.rs b/orchestrator/src/main.rs
new file mode 100644
index 0000000..f4cec1a
--- /dev/null
+++ b/orchestrator/src/main.rs
@@ -0,0 +1,221 @@
+/*
+ * CXL FM Infrastructure -- CXl Fabric Manager (FM) Infrastructure.
+ *
+ * CXL FM orchestrator implementation.
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
+extern crate daemonize;
+
+use std::fs::File;
+use daemonize::Daemonize;
+use clap::{Arg, Command};
+use std::{
+	io::{prelude::*, BufReader},
+	net::{TcpListener, TcpStream},
+};
+pub use fm_library::cxl_fm_lib::send_responce;
+pub use fm_library::cxl_fm_lib::CxlFmOptions;
+
+/*
+ * CXL FM orchestrator version
+ */
+const CXL_FM_ORCHESTRATOR_VERSION: &str = "0.0.1";
+
+/*
+ * CXL FM orchestrator strings
+ */
+const CXL_FM_ORCHESTRATOR_NAME: &str = "fm_orchestrator";
+const CXL_FM_ORCHESTRATOR_DESCRIPTOR: &str = "CXL Fabric Manager (FM) orchestrator";
+const CXL_FM_ORCHESTRATOR_DEBUG_OPTION: &str = "debug";
+const CXL_FM_ORCHESTRATOR_DEBUG_OPTION_SHORT: char = 'd';
+const CXL_FM_ORCHESTRATOR_IP_ADDRESS_OPTION: &str = "ip";
+const CXL_FM_ORCHESTRATOR_IP_ADDRESS_OPTION_SHORT: char = 'i';
+const CXL_FM_ORCHESTRATOR_PORT_OPTION: &str = "port";
+const CXL_FM_ORCHESTRATOR_PORT_OPTION_SHORT: char = 'p';
+
+const CXL_FM_ORCHESTRATOR_WORKING_DIRECTORY: &str = "/tmp";
+const CXL_FM_ORCHESTRATOR_LOG_FILE_PATH: &str = "/tmp/fm_orchestrator.log";
+const CXL_FM_ORCHESTRATOR_ERROR_MESSAGES_FILE_PATH: &str = "/tmp/fm_orchestrator.err";
+const CXL_FM_ORCHESTRATOR_USER: &str = "nobody";
+const CXL_FM_ORCHESTRATOR_GROUP: &str = "bin";
+const CXL_FM_ORCHESTRATOR_GROUP_ID: u32 = 2;
+const CXL_FM_ORCHESTRATOR_UMASK: u32 = 0o777;
+
+/*
+ * Command line interface definition
+ */
+fn cli() -> Command {
+	Command::new(CXL_FM_ORCHESTRATOR_NAME)
+		.about(CXL_FM_ORCHESTRATOR_DESCRIPTOR)
+		.version(CXL_FM_ORCHESTRATOR_VERSION)
+		.arg_required_else_help(true)
+		.arg(Arg::new(CXL_FM_ORCHESTRATOR_DEBUG_OPTION)
+			.short(CXL_FM_ORCHESTRATOR_DEBUG_OPTION_SHORT)
+			.long(CXL_FM_ORCHESTRATOR_DEBUG_OPTION)
+			.action(clap::ArgAction::SetTrue))
+		.arg(Arg::new(CXL_FM_ORCHESTRATOR_IP_ADDRESS_OPTION)
+			.short(CXL_FM_ORCHESTRATOR_IP_ADDRESS_OPTION_SHORT)
+			.long(CXL_FM_ORCHESTRATOR_IP_ADDRESS_OPTION)
+			.action(clap::ArgAction::Set)
+			.required(true))
+		.arg(Arg::new(CXL_FM_ORCHESTRATOR_PORT_OPTION)
+			.short(CXL_FM_ORCHESTRATOR_PORT_OPTION_SHORT)
+			.long(CXL_FM_ORCHESTRATOR_PORT_OPTION)
+			.action(clap::ArgAction::Set)
+			.required(true))
+}
+
+/*
+ * Discover available FM instances
+ */
+pub fn discover_fm(stream: &TcpStream, env: &CxlFmOptions) {
+	if env.is_debug {
+		println!("{}", fm_library::cxl_fm_lib::CXL_FM_DISCOVER_FM_COMMAND);
+	}
+
+	send_responce(stream, fm_library::cxl_fm_lib::CXL_FM_NO_DATA, env);
+}
+
+/*
+ * Start FM instance
+ */
+pub fn start_fm(stream: &TcpStream, env: &CxlFmOptions) {
+	if env.is_debug {
+		println!("{}", fm_library::cxl_fm_lib::CXL_FM_START_FM_COMMAND);
+	}
+
+	send_responce(stream, fm_library::cxl_fm_lib::CXL_FM_NO_DATA, env);
+}
+
+/*
+ * Restart FM instance
+ */
+pub fn restart_fm(stream: &TcpStream, env: &CxlFmOptions) {
+	if env.is_debug {
+		println!("{}", fm_library::cxl_fm_lib::CXL_FM_RESTART_FM_COMMAND);
+	}
+
+	send_responce(stream, fm_library::cxl_fm_lib::CXL_FM_NO_DATA, env);
+}
+
+/*
+ * Stop FM instance
+ */
+pub fn stop_fm(stream: &TcpStream, env: &CxlFmOptions) {
+	if env.is_debug {
+		println!("{}", fm_library::cxl_fm_lib::CXL_FM_STOP_FM_COMMAND);
+	}
+
+	send_responce(stream, fm_library::cxl_fm_lib::CXL_FM_NO_DATA, env);
+}
+
+/*
+ * Connection request processing logic
+ */
+fn handle_connection(stream: &TcpStream, env: &CxlFmOptions) {
+	if env.is_debug {
+		println!("Process request...");
+	}
+
+	let buf_reader = BufReader::new(stream);
+	let request_line = buf_reader.lines().next().unwrap().unwrap();
+
+	if env.is_debug {
+		println!("Request: {:#?}", request_line);
+	}
+
+	match request_line.as_str() {
+		fm_library::cxl_fm_lib::CXL_FM_DISCOVER_FM_COMMAND => {
+			discover_fm(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_START_FM_COMMAND => {
+			start_fm(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_RESTART_FM_COMMAND => {
+			restart_fm(stream, env);
+		},
+		fm_library::cxl_fm_lib::CXL_FM_STOP_FM_COMMAND => {
+			stop_fm(stream, env);
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
+			 CXL_FM_ORCHESTRATOR_NAME, CXL_FM_ORCHESTRATOR_VERSION);
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
+	let stdout = File::create(CXL_FM_ORCHESTRATOR_LOG_FILE_PATH).unwrap();
+	let stderr = File::create(CXL_FM_ORCHESTRATOR_ERROR_MESSAGES_FILE_PATH).unwrap();
+
+	let matches = cli().get_matches();
+
+	let ip = matches.get_one::<String>(CXL_FM_ORCHESTRATOR_IP_ADDRESS_OPTION).unwrap();
+	let port = matches.get_one::<String>(CXL_FM_ORCHESTRATOR_PORT_OPTION).unwrap();
+	let ip_port = format!("{ip}:{port}");
+
+	let options = CxlFmOptions {
+		ip_port: String::from(ip_port),
+		is_debug: matches.get_flag(CXL_FM_ORCHESTRATOR_DEBUG_OPTION) == true,
+	};
+
+	if options.is_debug {
+		println!("{} {}", CXL_FM_ORCHESTRATOR_NAME, CXL_FM_ORCHESTRATOR_VERSION);
+	}
+
+	let daemonize = Daemonize::new()
+			// Every method except `new` and `start`
+			// is optional, see `Daemonize` documentation
+			// for default behaviour.
+			.working_directory(CXL_FM_ORCHESTRATOR_WORKING_DIRECTORY)
+			.user(CXL_FM_ORCHESTRATOR_USER)
+			.group(CXL_FM_ORCHESTRATOR_GROUP)	// Group name
+			.group(CXL_FM_ORCHESTRATOR_GROUP_ID)	// or group id.
+			.umask(CXL_FM_ORCHESTRATOR_UMASK)	// Set umask, `0o027` by default.
+			.stdout(stdout)				// Redirect stdout to log file.
+			.stderr(stderr)				// Redirect stderr to error messages file.
+			.privileged_action(|| "Executed before drop privileges");
+
+	match daemonize.start() {
+		Ok(_) => fm_daemon_logic(&options),
+		Err(e) => eprintln!("Error, {}", e),
+	}
+}
-- 
2.34.1


Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C0EC7EE29
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjFBViX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 17:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjFBViW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 17:38:22 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CE719B
        for <linux-cxl@vger.kernel.org>; Fri,  2 Jun 2023 14:38:19 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-568ba7abc11so26528597b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 02 Jun 2023 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20221208.gappssmtp.com; s=20221208; t=1685741898; x=1688333898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iq5M96myIuZ5hnBzFFnMsXIyr+V/sBlVH/FUrd/tsA=;
        b=KlvUmCeLS808ZA9crE/vviqZE8T6OorndPO1Pvb6sa9o3ZUri32mnvYpqegnVEgL2J
         X1l3Tqk0Rb/Okm+0Y6bKiuIStj3qJ9B6kJwVRx19jqYjqhGAGURzyHWGnaQNo12Ss4us
         sJ9y4dbikrTXPsyaX9V1/I61bsDj9sBIHk0llYLO8fiVRUJxcxhwzmI+6WjU300/quGz
         zQqjPxs4lj1RkQ7bOS1BtINLgvrE3toUr1+TDUDEIEqVnnqCww3qkn1Es+W5OB7BiN0Y
         tXSt+NF/f8OEYIr1r6UqkzW7mlx/Ld1Y6xl3swfMrFOhHU+KGW601AbgeQG9LJeFfnL+
         qmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685741898; x=1688333898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iq5M96myIuZ5hnBzFFnMsXIyr+V/sBlVH/FUrd/tsA=;
        b=FTKodWQ1UL8doxg43K8FgzjZm1rLR3qsWQuJ7HOdjuNlQtzqP3XDuoO/5QLQmrxqJh
         j8/Ldgo/07yZsjh6E6gR1QAcVSHjFfQBILeKy7ZOX8l09zbD6rI4D/fhvwJ8PgiMulMl
         xL95jZbCPJwD0zF0pEJZKumH7jzaOZTzDWSui2y0RsSo19mEVQo5W08UkUlOQF2oE5nS
         mXsVA9x1Q7Ggeu73zA1ShRPlZobogNlnwgM3qi72LlFgaveIPauU4ZKKiB65ZZqHS2ku
         unvH6VBBGvIMEttRWMJo3EMc4Kvp+h+E+WDn8+oSgHtP4q2HyfMJYNrLmB6uSAJYfsiE
         xsSw==
X-Gm-Message-State: AC+VfDy61sMbp9KCL/XP5STcY82iB86hK+dm2A/fBfNm/aE0VPMdad5U
        gig5vLftVyQN6+UOgiGbDvEnHDX3V+h9+4An6ISL/w==
X-Google-Smtp-Source: ACHHUZ6URC2XsDGDEjwPOT0vRY47XWHC4AmfD3OYkchMmYHWH13c1uLMm6fA8mwqKxAy/rTVNpI/iw==
X-Received: by 2002:a81:5286:0:b0:565:5478:713a with SMTP id g128-20020a815286000000b005655478713amr1328891ywb.49.1685741897543;
        Fri, 02 Jun 2023 14:38:17 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:42f0:6600:901f:39a8:fe3f:30e2])
        by smtp.gmail.com with ESMTPSA id v1-20020a0dd301000000b00559d9989490sm856302ywd.41.2023.06.02.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:38:16 -0700 (PDT)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-cxl@vger.kernel.org
Cc:     a.manzanares@samsung.com, Jonathan.Cameron@huawei.com,
        nilesh.shah@zptcorp.com, slava@dubeiko.com,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 1/5] CXL FM: create initial project infrastructure
Date:   Fri,  2 Jun 2023 14:37:33 -0700
Message-Id: <20230602213737.494750-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602213737.494750-1-slava@dubeyko.com>
References: <20230602213737.494750-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This patch creates the initial project infrastructure.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Adam Manzanares <a.manzanares@samsung.com>
---
 AUTHORS    |   1 +
 COPYING    |  14 +++
 Cargo.lock | 333 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 LICENSE    | 201 ++++++++++++++++++++++++++++++++
 4 files changed, 549 insertions(+)
 create mode 100644 AUTHORS
 create mode 100644 COPYING
 create mode 100644 Cargo.lock
 create mode 100644 LICENSE

diff --git a/AUTHORS b/AUTHORS
new file mode 100644
index 0000000..8a6d84b
--- /dev/null
+++ b/AUTHORS
@@ -0,0 +1 @@
+Authors: Viacheslav Dubeyko <slava@dubeyko.com>
diff --git a/COPYING b/COPYING
new file mode 100644
index 0000000..28f81b7
--- /dev/null
+++ b/COPYING
@@ -0,0 +1,14 @@
+Copyright (c) 2023 Viacheslav Dubeyko <slava@dubeyko.com>,
+All rights reserved.
+
+Licensed under the Apache License, Version 2.0 (the "License");
+you may not use this file except in compliance with the License.
+You may obtain a copy of the License at
+
+http://www.apache.org/licenses/LICENSE-2.0
+
+Unless required by applicable law or agreed to in writing, software
+distributed under the License is distributed on an "AS IS" BASIS,
+WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+See the License for the specific language governing permissions and
+limitations under the License.
diff --git a/Cargo.lock b/Cargo.lock
new file mode 100644
index 0000000..52b556e
--- /dev/null
+++ b/Cargo.lock
@@ -0,0 +1,333 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "bitflags"
+version = "1.3.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
+
+[[package]]
+name = "cc"
+version = "1.0.78"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a20104e2335ce8a659d6dd92a51a767a0c062599c73b343fd152cb401e828c3d"
+
+[[package]]
+name = "clap"
+version = "4.0.32"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a7db700bc935f9e43e88d00b0850dae18a63773cfbec6d8e070fccf7fef89a39"
+dependencies = [
+ "bitflags",
+ "clap_derive",
+ "clap_lex",
+ "is-terminal",
+ "once_cell",
+ "strsim",
+ "termcolor",
+]
+
+[[package]]
+name = "clap_derive"
+version = "4.0.21"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0177313f9f02afc995627906bbd8967e2be069f5261954222dac78290c2b9014"
+dependencies = [
+ "heck",
+ "proc-macro-error",
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "clap_lex"
+version = "0.3.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0d4198f73e42b4936b35b5bb248d81d2b595ecb170da0bac7655c54eedfa8da8"
+dependencies = [
+ "os_str_bytes",
+]
+
+[[package]]
+name = "daemonize"
+version = "0.5.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ab8bfdaacb3c887a54d41bdf48d3af8873b3f5566469f8ba21b92057509f116e"
+dependencies = [
+ "libc",
+]
+
+[[package]]
+name = "errno"
+version = "0.2.8"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f639046355ee4f37944e44f60642c6f3a7efa3cf6b78c78a0d989a8ce6c396a1"
+dependencies = [
+ "errno-dragonfly",
+ "libc",
+ "winapi",
+]
+
+[[package]]
+name = "errno-dragonfly"
+version = "0.1.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "aa68f1b12764fab894d2755d2518754e71b4fd80ecfb822714a1206c2aab39bf"
+dependencies = [
+ "cc",
+ "libc",
+]
+
+[[package]]
+name = "fabric_manager"
+version = "0.1.0"
+dependencies = [
+ "clap",
+ "daemonize",
+]
+
+[[package]]
+name = "heck"
+version = "0.4.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "2540771e65fc8cb83cd6e8a237f70c319bd5c29f78ed1084ba5d50eeac86f7f9"
+
+[[package]]
+name = "hermit-abi"
+version = "0.2.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ee512640fe35acbfb4bb779db6f0d80704c2cacfa2e39b601ef3e3f47d1ae4c7"
+dependencies = [
+ "libc",
+]
+
+[[package]]
+name = "io-lifetimes"
+version = "1.0.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "46112a93252b123d31a119a8d1a1ac19deac4fac6e0e8b0df58f0d4e5870e63c"
+dependencies = [
+ "libc",
+ "windows-sys",
+]
+
+[[package]]
+name = "is-terminal"
+version = "0.4.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "28dfb6c8100ccc63462345b67d1bbc3679177c75ee4bf59bf29c8b1d110b8189"
+dependencies = [
+ "hermit-abi",
+ "io-lifetimes",
+ "rustix",
+ "windows-sys",
+]
+
+[[package]]
+name = "libc"
+version = "0.2.139"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "201de327520df007757c1f0adce6e827fe8562fbc28bfd9c15571c66ca1f5f79"
+
+[[package]]
+name = "linux-raw-sys"
+version = "0.1.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f051f77a7c8e6957c0696eac88f26b0117e54f52d3fc682ab19397a8812846a4"
+
+[[package]]
+name = "once_cell"
+version = "1.17.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "6f61fba1741ea2b3d6a1e3178721804bb716a68a6aeba1149b5d52e3d464ea66"
+
+[[package]]
+name = "os_str_bytes"
+version = "6.4.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9b7820b9daea5457c9f21c69448905d723fbd21136ccf521748f23fd49e723ee"
+
+[[package]]
+name = "proc-macro-error"
+version = "1.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c"
+dependencies = [
+ "proc-macro-error-attr",
+ "proc-macro2",
+ "quote",
+ "syn",
+ "version_check",
+]
+
+[[package]]
+name = "proc-macro-error-attr"
+version = "1.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "version_check",
+]
+
+[[package]]
+name = "proc-macro2"
+version = "1.0.49"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "57a8eca9f9c4ffde41714334dee777596264c7825420f521abc92b5b5deb63a5"
+dependencies = [
+ "unicode-ident",
+]
+
+[[package]]
+name = "quote"
+version = "1.0.23"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8856d8364d252a14d474036ea1358d63c9e6965c8e5c1885c18f73d70bff9c7b"
+dependencies = [
+ "proc-macro2",
+]
+
+[[package]]
+name = "rustix"
+version = "0.36.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "4feacf7db682c6c329c4ede12649cd36ecab0f3be5b7d74e6a20304725db4549"
+dependencies = [
+ "bitflags",
+ "errno",
+ "io-lifetimes",
+ "libc",
+ "linux-raw-sys",
+ "windows-sys",
+]
+
+[[package]]
+name = "strsim"
+version = "0.10.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "73473c0e59e6d5812c5dfe2a064a6444949f089e20eec9a2e5506596494e4623"
+
+[[package]]
+name = "syn"
+version = "1.0.107"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "1f4064b5b16e03ae50984a5a8ed5d4f8803e6bc1fd170a3cda91a1be4b18e3f5"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "termcolor"
+version = "1.1.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "bab24d30b911b2376f3a13cc2cd443142f0c81dda04c118693e35b3835757755"
+dependencies = [
+ "winapi-util",
+]
+
+[[package]]
+name = "unicode-ident"
+version = "1.0.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "84a22b9f218b40614adcb3f4ff08b703773ad44fa9423e4e0d346d5db86e4ebc"
+
+[[package]]
+name = "version_check"
+version = "0.9.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
+
+[[package]]
+name = "winapi"
+version = "0.3.9"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+dependencies = [
+ "winapi-i686-pc-windows-gnu",
+ "winapi-x86_64-pc-windows-gnu",
+]
+
+[[package]]
+name = "winapi-i686-pc-windows-gnu"
+version = "0.4.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+
+[[package]]
+name = "winapi-util"
+version = "0.1.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
+dependencies = [
+ "winapi",
+]
+
+[[package]]
+name = "winapi-x86_64-pc-windows-gnu"
+version = "0.4.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+
+[[package]]
+name = "windows-sys"
+version = "0.42.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5a3e1820f08b8513f676f7ab6c1f99ff312fb97b553d30ff4dd86f9f15728aa7"
+dependencies = [
+ "windows_aarch64_gnullvm",
+ "windows_aarch64_msvc",
+ "windows_i686_gnu",
+ "windows_i686_msvc",
+ "windows_x86_64_gnu",
+ "windows_x86_64_gnullvm",
+ "windows_x86_64_msvc",
+]
+
+[[package]]
+name = "windows_aarch64_gnullvm"
+version = "0.42.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "41d2aa71f6f0cbe00ae5167d90ef3cfe66527d6f613ca78ac8024c3ccab9a19e"
+
+[[package]]
+name = "windows_aarch64_msvc"
+version = "0.42.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "dd0f252f5a35cac83d6311b2e795981f5ee6e67eb1f9a7f64eb4500fbc4dcdb4"
+
+[[package]]
+name = "windows_i686_gnu"
+version = "0.42.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "fbeae19f6716841636c28d695375df17562ca208b2b7d0dc47635a50ae6c5de7"
+
+[[package]]
+name = "windows_i686_msvc"
+version = "0.42.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "84c12f65daa39dd2babe6e442988fc329d6243fdce47d7d2d155b8d874862246"
+
+[[package]]
+name = "windows_x86_64_gnu"
+version = "0.42.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "bf7b1b21b5362cbc318f686150e5bcea75ecedc74dd157d874d754a2ca44b0ed"
+
+[[package]]
+name = "windows_x86_64_gnullvm"
+version = "0.42.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "09d525d2ba30eeb3297665bd434a54297e4170c7f1a44cad4ef58095b4cd2028"
+
+[[package]]
+name = "windows_x86_64_msvc"
+version = "0.42.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f40009d85759725a34da6d89a94e63d7bdc50a862acf0dbc7c8e488f1edcb6f5"
diff --git a/LICENSE b/LICENSE
new file mode 100644
index 0000000..261eeb9
--- /dev/null
+++ b/LICENSE
@@ -0,0 +1,201 @@
+                                 Apache License
+                           Version 2.0, January 2004
+                        http://www.apache.org/licenses/
+
+   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
+
+   1. Definitions.
+
+      "License" shall mean the terms and conditions for use, reproduction,
+      and distribution as defined by Sections 1 through 9 of this document.
+
+      "Licensor" shall mean the copyright owner or entity authorized by
+      the copyright owner that is granting the License.
+
+      "Legal Entity" shall mean the union of the acting entity and all
+      other entities that control, are controlled by, or are under common
+      control with that entity. For the purposes of this definition,
+      "control" means (i) the power, direct or indirect, to cause the
+      direction or management of such entity, whether by contract or
+      otherwise, or (ii) ownership of fifty percent (50%) or more of the
+      outstanding shares, or (iii) beneficial ownership of such entity.
+
+      "You" (or "Your") shall mean an individual or Legal Entity
+      exercising permissions granted by this License.
+
+      "Source" form shall mean the preferred form for making modifications,
+      including but not limited to software source code, documentation
+      source, and configuration files.
+
+      "Object" form shall mean any form resulting from mechanical
+      transformation or translation of a Source form, including but
+      not limited to compiled object code, generated documentation,
+      and conversions to other media types.
+
+      "Work" shall mean the work of authorship, whether in Source or
+      Object form, made available under the License, as indicated by a
+      copyright notice that is included in or attached to the work
+      (an example is provided in the Appendix below).
+
+      "Derivative Works" shall mean any work, whether in Source or Object
+      form, that is based on (or derived from) the Work and for which the
+      editorial revisions, annotations, elaborations, or other modifications
+      represent, as a whole, an original work of authorship. For the purposes
+      of this License, Derivative Works shall not include works that remain
+      separable from, or merely link (or bind by name) to the interfaces of,
+      the Work and Derivative Works thereof.
+
+      "Contribution" shall mean any work of authorship, including
+      the original version of the Work and any modifications or additions
+      to that Work or Derivative Works thereof, that is intentionally
+      submitted to Licensor for inclusion in the Work by the copyright owner
+      or by an individual or Legal Entity authorized to submit on behalf of
+      the copyright owner. For the purposes of this definition, "submitted"
+      means any form of electronic, verbal, or written communication sent
+      to the Licensor or its representatives, including but not limited to
+      communication on electronic mailing lists, source code control systems,
+      and issue tracking systems that are managed by, or on behalf of, the
+      Licensor for the purpose of discussing and improving the Work, but
+      excluding communication that is conspicuously marked or otherwise
+      designated in writing by the copyright owner as "Not a Contribution."
+
+      "Contributor" shall mean Licensor and any individual or Legal Entity
+      on behalf of whom a Contribution has been received by Licensor and
+      subsequently incorporated within the Work.
+
+   2. Grant of Copyright License. Subject to the terms and conditions of
+      this License, each Contributor hereby grants to You a perpetual,
+      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
+      copyright license to reproduce, prepare Derivative Works of,
+      publicly display, publicly perform, sublicense, and distribute the
+      Work and such Derivative Works in Source or Object form.
+
+   3. Grant of Patent License. Subject to the terms and conditions of
+      this License, each Contributor hereby grants to You a perpetual,
+      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
+      (except as stated in this section) patent license to make, have made,
+      use, offer to sell, sell, import, and otherwise transfer the Work,
+      where such license applies only to those patent claims licensable
+      by such Contributor that are necessarily infringed by their
+      Contribution(s) alone or by combination of their Contribution(s)
+      with the Work to which such Contribution(s) was submitted. If You
+      institute patent litigation against any entity (including a
+      cross-claim or counterclaim in a lawsuit) alleging that the Work
+      or a Contribution incorporated within the Work constitutes direct
+      or contributory patent infringement, then any patent licenses
+      granted to You under this License for that Work shall terminate
+      as of the date such litigation is filed.
+
+   4. Redistribution. You may reproduce and distribute copies of the
+      Work or Derivative Works thereof in any medium, with or without
+      modifications, and in Source or Object form, provided that You
+      meet the following conditions:
+
+      (a) You must give any other recipients of the Work or
+          Derivative Works a copy of this License; and
+
+      (b) You must cause any modified files to carry prominent notices
+          stating that You changed the files; and
+
+      (c) You must retain, in the Source form of any Derivative Works
+          that You distribute, all copyright, patent, trademark, and
+          attribution notices from the Source form of the Work,
+          excluding those notices that do not pertain to any part of
+          the Derivative Works; and
+
+      (d) If the Work includes a "NOTICE" text file as part of its
+          distribution, then any Derivative Works that You distribute must
+          include a readable copy of the attribution notices contained
+          within such NOTICE file, excluding those notices that do not
+          pertain to any part of the Derivative Works, in at least one
+          of the following places: within a NOTICE text file distributed
+          as part of the Derivative Works; within the Source form or
+          documentation, if provided along with the Derivative Works; or,
+          within a display generated by the Derivative Works, if and
+          wherever such third-party notices normally appear. The contents
+          of the NOTICE file are for informational purposes only and
+          do not modify the License. You may add Your own attribution
+          notices within Derivative Works that You distribute, alongside
+          or as an addendum to the NOTICE text from the Work, provided
+          that such additional attribution notices cannot be construed
+          as modifying the License.
+
+      You may add Your own copyright statement to Your modifications and
+      may provide additional or different license terms and conditions
+      for use, reproduction, or distribution of Your modifications, or
+      for any such Derivative Works as a whole, provided Your use,
+      reproduction, and distribution of the Work otherwise complies with
+      the conditions stated in this License.
+
+   5. Submission of Contributions. Unless You explicitly state otherwise,
+      any Contribution intentionally submitted for inclusion in the Work
+      by You to the Licensor shall be under the terms and conditions of
+      this License, without any additional terms or conditions.
+      Notwithstanding the above, nothing herein shall supersede or modify
+      the terms of any separate license agreement you may have executed
+      with Licensor regarding such Contributions.
+
+   6. Trademarks. This License does not grant permission to use the trade
+      names, trademarks, service marks, or product names of the Licensor,
+      except as required for reasonable and customary use in describing the
+      origin of the Work and reproducing the content of the NOTICE file.
+
+   7. Disclaimer of Warranty. Unless required by applicable law or
+      agreed to in writing, Licensor provides the Work (and each
+      Contributor provides its Contributions) on an "AS IS" BASIS,
+      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
+      implied, including, without limitation, any warranties or conditions
+      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
+      PARTICULAR PURPOSE. You are solely responsible for determining the
+      appropriateness of using or redistributing the Work and assume any
+      risks associated with Your exercise of permissions under this License.
+
+   8. Limitation of Liability. In no event and under no legal theory,
+      whether in tort (including negligence), contract, or otherwise,
+      unless required by applicable law (such as deliberate and grossly
+      negligent acts) or agreed to in writing, shall any Contributor be
+      liable to You for damages, including any direct, indirect, special,
+      incidental, or consequential damages of any character arising as a
+      result of this License or out of the use or inability to use the
+      Work (including but not limited to damages for loss of goodwill,
+      work stoppage, computer failure or malfunction, or any and all
+      other commercial damages or losses), even if such Contributor
+      has been advised of the possibility of such damages.
+
+   9. Accepting Warranty or Additional Liability. While redistributing
+      the Work or Derivative Works thereof, You may choose to offer,
+      and charge a fee for, acceptance of support, warranty, indemnity,
+      or other liability obligations and/or rights consistent with this
+      License. However, in accepting such obligations, You may act only
+      on Your own behalf and on Your sole responsibility, not on behalf
+      of any other Contributor, and only if You agree to indemnify,
+      defend, and hold each Contributor harmless for any liability
+      incurred by, or claims asserted against, such Contributor by reason
+      of your accepting any such warranty or additional liability.
+
+   END OF TERMS AND CONDITIONS
+
+   APPENDIX: How to apply the Apache License to your work.
+
+      To apply the Apache License to your work, attach the following
+      boilerplate notice, with the fields enclosed by brackets "[]"
+      replaced with your own identifying information. (Don't include
+      the brackets!)  The text should be enclosed in the appropriate
+      comment syntax for the file format. We also recommend that a
+      file or class name and description of purpose be included on the
+      same "printed page" as the copyright notice for easier
+      identification within third-party archives.
+
+   Copyright [yyyy] [name of copyright owner]
+
+   Licensed under the Apache License, Version 2.0 (the "License");
+   you may not use this file except in compliance with the License.
+   You may obtain a copy of the License at
+
+       http://www.apache.org/licenses/LICENSE-2.0
+
+   Unless required by applicable law or agreed to in writing, software
+   distributed under the License is distributed on an "AS IS" BASIS,
+   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+   See the License for the specific language governing permissions and
+   limitations under the License.
-- 
2.34.1


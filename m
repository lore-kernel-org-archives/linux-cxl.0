Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD86C0015E
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Jul 2023 11:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGCL3k (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Jul 2023 07:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjGCL3i (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 3 Jul 2023 07:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2FB3;
        Mon,  3 Jul 2023 04:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AEE060EE0;
        Mon,  3 Jul 2023 11:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89434C433C7;
        Mon,  3 Jul 2023 11:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688383777;
        bh=d2wojFlzaictF79/C2eTIPrC5M/dnRiRjfUH/Mw1eoo=;
        h=From:To:Cc:Subject:Date:From;
        b=nUMahLo3r+VIBhhgw9EZM1lZPLtdrSjd5nL0oOxGjM2Jz6jszOesNV97kv1l7t+/v
         VoKda7YgnUEpyZrg9z9A0P85FktwcBN8nYW4pgeSL97Fs2CPCzkqr+ovp/EwvyU4mz
         N4AzVgEhAIErNjFKCnK6FvUUs786Cw1+m/AwIcJSn0e614iJSfHOBvwFRlKPkFLBko
         8c8ifAKmo3gCEs1RDoN5JIBRH+tLTDTw5XNh9bKcw4UsUknkqF8RPP4zK2eMQpKBuK
         v8Y1YMqsn3Ojv52wSxQeXW24vXx+TFXLTGcIe2AoMZUlt31Veo5ppoPqI1F+7xXnih
         TEuddLZi8VTSg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl: fix CONFIG_FW_LOADER dependency
Date:   Mon,  3 Jul 2023 13:29:13 +0200
Message-Id: <20230703112928.332321-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When FW_LOADER is disabled, cxl fails to link:

arm-linux-gnueabi-ld: drivers/cxl/core/memdev.o: in function `cxl_memdev_setup_fw_upload':
memdev.c:(.text+0x90e): undefined reference to `firmware_upload_register'
memdev.c:(.text+0x93c): undefined reference to `firmware_upload_unregister'

In order to use the firmware_upload_register() function, both FW_LOADER
and FW_UPLOAD have to be enabled, which is a bit confusing. In addition,
the dependency is on the wrong symbol, as the caller is part of the
cxl_core.ko module, not the cxl_mem.ko module.

Fixes: 9521875bbe005 ("cxl: add a firmware update mechanism using the sysfs firmware loader")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cxl/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index fcbf8295fde37..8ea1d340e4385 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -2,6 +2,8 @@
 menuconfig CXL_BUS
 	tristate "CXL (Compute Express Link) Devices Support"
 	depends on PCI
+	select FW_LOADER
+	select FW_UPLOAD
 	select PCI_DOE
 	help
 	  CXL is a bus that is electrically compatible with PCI Express, but
@@ -82,7 +84,6 @@ config CXL_PMEM
 config CXL_MEM
 	tristate "CXL: Memory Expansion"
 	depends on CXL_PCI
-	select FW_UPLOAD
 	default CXL_BUS
 	help
 	  The CXL.mem protocol allows a device to act as a provider of "System
-- 
2.39.2


Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A41C04AA7
	for <linux-cxl@archiver.kernel.org>; Wed, 20 Sep 2023 15:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjITPuj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbjITPuh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 20 Sep 2023 11:50:37 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19531A3
        for <linux-cxl@vger.kernel.org>; Wed, 20 Sep 2023 08:50:32 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-59bdb3d03b1so71394687b3.3
        for <linux-cxl@vger.kernel.org>; Wed, 20 Sep 2023 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225031; x=1695829831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0yU656d1t/TjZmcxFzpoR2akTkNkjre8EsuhC9IRXfk=;
        b=OibhjbL8KrRXue4MucKeadMeYSp2Ow52Ixqn2IPM1hRattB3oA38tpNQQuPS60J/Yl
         RrpsEOnk0lyaRvnR3Daa5Z6I2z6GEMd+Lq5e5FkmA1ieuNrLMVAc4pN3zPd9/W7KPUPB
         9Uys6pTJw9ett9jepT8RgfRb7/CzwSV/K6YLc8hmh5r2ib24VRZkd0ru1LgRzfAfUg17
         G/TbvZNSr/7P4xM7AmfriUia14XvpEmjlTmRq6PaZjGtKgUFMnKWuxLdP70NugRwXM8+
         rzaDCIUBWYt5hYDK4HPiXmQiOvsvrQsnChWJn+n7+FOnY/tLqLJRDYeoatLoPaPHPe3m
         nS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225031; x=1695829831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yU656d1t/TjZmcxFzpoR2akTkNkjre8EsuhC9IRXfk=;
        b=M+hvEosyYkPDzwpldLk7gesaa1QTb8CDdurJVAP0lwOE/NsDzs3s8O0PjlXJZh88E+
         jFYm/rX80e2jOkXC4twHu421wiiSUOZsDQAs76OBnGb0q7YxXJrPgqcz0zhS8cYXqA+p
         xam+wzs8/Q3iLHSDSBfk9THo5VKmoEfXtrNB7YnVIt88EZW0Wze8DU+eZm3tYNvDZTO4
         rHhEUdnW6RkSPeLhODOS+HgTnvtzB7WNs1pkty3S96lJiTRt1Tv/d3zrfb/TuxMdZZex
         FDbKq3Dibg4l8Wd4fIaOwAQ7ClySqvuxvnC8ERw5YUtI3MTDPnrKYtwjSvtjYohu1uVs
         3AfA==
X-Gm-Message-State: AOJu0Yyw8z6PVDx92VKYVOidjiqb4Cy/DNVWZluiEfamuC9DDTLvf0bM
        2fAcnYub+ADzzpXLNlf1lYdofykc4LKiz/8=
X-Google-Smtp-Source: AGHT+IFIPb+1AxCwDMQ89xjXqhUbk85X53zDka8do1dS/5B+V1T/ag0zst8Y6q58ESZbkMqQAn/Nwg==
X-Received: by 2002:a0d:e3c3:0:b0:599:da80:e1e6 with SMTP id m186-20020a0de3c3000000b00599da80e1e6mr2668510ywe.34.1695225031262;
        Wed, 20 Sep 2023 08:50:31 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id l6-20020a819406000000b0057085b18cddsm3861323ywg.54.2023.09.20.08.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:50:30 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH] cxl/vendor: update niagara to only build on linux, add KConfig options
Date:   Wed, 20 Sep 2023 11:50:21 -0400
Message-Id: <20230920155020.550112-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Niagara uses <sys/shm.h> which presently limits its compatibility to
linux hosts.  Change build to only build it on linux.

Add Kconfig file for skhynix directory, and make niagara depend on
CXL_MEM_DEVICE.  Add an explicit flag for niagara.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/Kconfig                    | 2 ++
 hw/cxl/vendor/Kconfig             | 1 +
 hw/cxl/vendor/skhynix/Kconfig     | 4 ++++
 hw/cxl/vendor/skhynix/meson.build | 4 +++-
 4 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 hw/cxl/vendor/Kconfig
 create mode 100644 hw/cxl/vendor/skhynix/Kconfig

diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
index dd6c54b54d..88022008c7 100644
--- a/hw/cxl/Kconfig
+++ b/hw/cxl/Kconfig
@@ -1,3 +1,5 @@
+source vendor/Kconfig
+
 config CXL
     bool
     default y if PCI_EXPRESS
diff --git a/hw/cxl/vendor/Kconfig b/hw/cxl/vendor/Kconfig
new file mode 100644
index 0000000000..aa23bb051b
--- /dev/null
+++ b/hw/cxl/vendor/Kconfig
@@ -0,0 +1 @@
+source skhynix/Kconfig
diff --git a/hw/cxl/vendor/skhynix/Kconfig b/hw/cxl/vendor/skhynix/Kconfig
new file mode 100644
index 0000000000..382fa0cd6c
--- /dev/null
+++ b/hw/cxl/vendor/skhynix/Kconfig
@@ -0,0 +1,4 @@
+config CXL_SKHYNIX_NIAGARA
+    bool
+    depends on CXL_MEM_DEVICE
+    default y if CXL_VENDOR
diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
index 4e57db65f1..6f194aa517 100644
--- a/hw/cxl/vendor/skhynix/meson.build
+++ b/hw/cxl/vendor/skhynix/meson.build
@@ -1 +1,3 @@
-system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
+if targetos == 'linux'
+    system_ss.add(when: 'CONFIG_CXL_SKHYNIX_NIAGARA', if_true: files('skhynix_niagara.c',))
+endif
-- 
2.39.1


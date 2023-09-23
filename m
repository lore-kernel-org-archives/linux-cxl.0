Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261AFCE7A88
	for <linux-cxl@archiver.kernel.org>; Sat, 23 Sep 2023 00:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjIWAGZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Sep 2023 20:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIWAGY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Sep 2023 20:06:24 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE481A5
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 17:06:19 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-59c0442a359so35829397b3.0
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695427578; x=1696032378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BblDtyq6+zOk7FwEfAtvrtpIxNgkfCtaoxoUkBjZCfE=;
        b=WZ/rN+S+4T4dhAv1ivmsQKcXeiewJn6Kos/nehiFiwZR+jJylFxiHRK2KfjwGVmjxq
         GZ+5DFeLAfyrkmUXml7Ahe0VUyJsef0V2AIlC+lAHW/jCXzs1gMtag9yjBlENBdHuP9G
         D5sS41VwyLRtfM5NLy6kT4SVGRaNvuvynRgD6AtwrbbLB2+0J+rvcwFq7lcb0ZRs85qE
         cusQt9rvj15q9z2T18DogPaPs2gavzcO4lXrAXhlUTDa6oJtkeQWGdG1S7FbIiytqazY
         67Epvcj6/7et/SVBd/BP/YG5VR6GNALNHfx82GcezKSBi+ogkM5+IPvAKvcBp+lzJpny
         QNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695427578; x=1696032378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BblDtyq6+zOk7FwEfAtvrtpIxNgkfCtaoxoUkBjZCfE=;
        b=hH3xk4eGstuU22Z06kT4CIUEI2BmjlSTZOaBYnvYsFQQFuuc+UNjyZTWrBfcU+sIZ2
         bU38L/+PoxoSI4jto42Th4+r2RKQf/bgGtf6bcjrhMSM6tevlE/x3ePTjwfpvALQEH3g
         Qij39Vm54lFn8+VT1/BqRArTucR+st9ngLqoUxX3KchCp9koBgb7m8kYws2+OTjWOivl
         rud38tf6l2A7+9EpwUk2TahBKNo8ZtEM1nXcK9dqizb1xIfgEe79afzEe5pNwPjzFv4y
         fLqffBvMg+apb+X4eRnhcLXvL6oQfCD0evkYe06XXUEaghS396Gir7z4Hdq2QvYXRoeI
         hlKA==
X-Gm-Message-State: AOJu0YwC9Sz5MPrIO4BWf6J+ewsrgMnxRMrZfgUZiiKqqL4+5NqYyNsb
        EFgYtne48BZKj9TB9Y7oqH+rzXYBUprxBYY=
X-Google-Smtp-Source: AGHT+IE1QkKcBHxJqbhffV3fi3mCdasHAS6LUeQMM/2Scc3A+uq4eIPgDRVGvdKu+jS1jth8EFZV1Q==
X-Received: by 2002:a0d:cc0a:0:b0:59b:e622:f820 with SMTP id o10-20020a0dcc0a000000b0059be622f820mr1194437ywd.13.1695427578190;
        Fri, 22 Sep 2023 17:06:18 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id a198-20020a0dd8cf000000b0059b3c406af3sm1168006ywe.82.2023.09.22.17.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 17:06:17 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v2] cxl/vendor: update niagara to only build on linux, add KConfig options
Date:   Fri, 22 Sep 2023 20:05:44 -0400
Message-Id: <20230923000543.598681-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Niagara uses <sys/shm.h> which presently limits its compatibility to
linux hosts.  Change build to only build it on linux.

Add Kconfig file for skhynix directory, and make niagara depend on
CXL_MEM_DEVICE and LINUX.  Add an explicit flag for niagara.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/Kconfig                    | 2 ++
 hw/cxl/vendor/Kconfig             | 1 +
 hw/cxl/vendor/skhynix/Kconfig     | 4 ++++
 hw/cxl/vendor/skhynix/meson.build | 2 +-
 4 files changed, 8 insertions(+), 1 deletion(-)
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
index 0000000000..20942cffc2
--- /dev/null
+++ b/hw/cxl/vendor/skhynix/Kconfig
@@ -0,0 +1,4 @@
+config CXL_SKHYNIX_NIAGARA
+    bool
+    depends on CXL_MEM_DEVICE && LINUX
+    default y if CXL_VENDOR
diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
index 4e57db65f1..e3cb00e848 100644
--- a/hw/cxl/vendor/skhynix/meson.build
+++ b/hw/cxl/vendor/skhynix/meson.build
@@ -1 +1 @@
-system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
+system_ss.add(when: 'CONFIG_CXL_SKHYNIX_NIAGARA', if_true: files('skhynix_niagara.c',))
-- 
2.39.1


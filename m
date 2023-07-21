Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AE1C0015E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Jul 2023 16:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGUQiC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjGUQhc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Jul 2023 12:37:32 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A603C11
        for <linux-cxl@vger.kernel.org>; Fri, 21 Jul 2023 09:36:18 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 3f1490d57ef6-cfd4a94364fso2049966276.1
        for <linux-cxl@vger.kernel.org>; Fri, 21 Jul 2023 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689957369; x=1690562169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rQeMRhVWs0eiVqTBZAihMyI0OBjLqk1MiSDA6bw+so=;
        b=GxoaygpJp4E71e5V5mMh0Kl+CGi7YLTC1mvll0v6YWmm+tCnStH6BXxjbKvxXTBqrm
         UgkqW0OTlO5ZUmR62MOHprzWHaThMLbwR+XvLtUmYhyEE+ahm/BJY1Tlchj//PricvC/
         5UPSfIq/v2+ajTgyDK18T3qZOfCdf5WqaVP+abqlnbyJSWisqt6QZMycj4fg6/ShiOi7
         L8LgzV3muOYA+sGvNJ5sP5rwlftTD3WCshVlkPiueBDR59aTPFoRKWu8Y9wU0T2oOYwX
         TQbPT7bHRN595duFohjfbNDoZapzfICKjeVcX3THVMJVMnYlHW4mhdLrGcQ2O6uHswYa
         2p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689957369; x=1690562169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rQeMRhVWs0eiVqTBZAihMyI0OBjLqk1MiSDA6bw+so=;
        b=dtJz8isDb77rd+N8DhWORn34gdeOvOZtO+f6n/HL66hW3mkyT+Sdsto5bzwIsNfKHT
         psJQzAKBvBqK9y2Rn/hCnjiDrhWeJURU2PrD7xZ0/HsU55hIagnyX65yHqK+PxZRrWdh
         cAXd8nNWGT59s/1HTlOmVWw+R1B2603T+1hnh5Sb4glqkGD59doPGbEUEw2RxsN3PXgP
         NVe06+Uh5/EqjiiFyLavTK7PPti0Vcg8bV4KHLjfCceTIz2CM9CUZTFSPLH3HURbQK16
         IU/6y8p20PezPqVmZhnlSaIeAe7m7lkf2jVQkrtbRH+/63xRwZ0Y1SJm9u3PGz2BEQ0E
         Sk6Q==
X-Gm-Message-State: ABy/qLbjCrptjfohRrx7/z0LGitHS55GKlgeG148q46SSQdahXh/5r0h
        fR+7ochwILjQU1VKVKAXVmBKmyUo6Wbl
X-Google-Smtp-Source: APBJJlHUwggFGGQBNgvYjfw2hrMIRSMQZokR92BRP0PjgSI962CclfYmAsRmDEbH7rHCELzioUlPAg==
X-Received: by 2002:a25:8e0d:0:b0:ced:ab16:15ee with SMTP id p13-20020a258e0d000000b00cedab1615eemr2050006ybl.17.1689957369466;
        Fri, 21 Jul 2023 09:36:09 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v196-20020a25c5cd000000b00c62e0df7ca8sm863822ybe.24.2023.07.21.09.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:36:09 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 0/4] CXL: SK hynix Niagara MHSLD Device
Date:   Fri, 21 Jul 2023 12:35:02 -0400
Message-Id: <20230721163505.1910-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Base repo: https://gitlab.com/jic23/qemu
Base branch: cxl-2023-07-17

This patch set includes an emulation of the SK hynix Niagara MHSLD
platform with custom CCI commands that allow for isolation of memory
blocks between attached hosts.

There are 4 total patches in this set:
1 & 2: Modifications to the CCI interface to allow the addition of
       custom CCI commands to an existing CCI command set.
3: Minimum MHD cci support for a type-3 device
4: The SK hynix Niagara Device

The changes to the core device and cci interface are very limited,
and this provides a clean way for developers to add custom CCI commands
to a device while retaining the possiblity to upstream the model.

This device allows hosts to request memory blocks directly from the
device, rather than requiring full the DCD command set.  As a matter of
simplicity, this is beneficial to for testing and applications of 
dynamic memory pooling on top of the 1.1 and 2.0 specification.

Note that these CCI commands are not servicable without the kernel
allowing raw CXL commands to be passed through the mailbox driver,
so users should enable `CONFIG_CXL_MEM_RAW_COMMANDS=y` on the kernel
of their QEMU instance.

Signed-off-by: Gregory Price <gregory.price@memverge.com>

Gregory Price (4):
  cxl/mailbox: change CCI cmd set structure to be a member, not a
    refernce
  cxl/mailbox: interface to add CCI commands to an existing CCI
  cxl/type3: minimum MHD cci support
  cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

 hw/cxl/Kconfig                          |   4 +
 hw/cxl/cxl-mailbox-utils.c              |  90 +++-
 hw/cxl/meson.build                      |   2 +
 hw/cxl/vendor/meson.build               |   1 +
 hw/cxl/vendor/skhynix/.gitignore        |   1 +
 hw/cxl/vendor/skhynix/init_niagara.c    |  99 +++++
 hw/cxl/vendor/skhynix/meson.build       |   1 +
 hw/cxl/vendor/skhynix/skhynix_niagara.c | 521 ++++++++++++++++++++++++
 hw/mem/cxl_type3.c                      |  67 +++
 include/hw/cxl/cxl_device.h             |  18 +-
 tools/cxl/cxl_mhd_init.c                |  63 +++
 tools/cxl/meson.build                   |   3 +
 tools/meson.build                       |   1 +
 13 files changed, 866 insertions(+), 5 deletions(-)
 create mode 100644 hw/cxl/vendor/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/.gitignore
 create mode 100644 hw/cxl/vendor/skhynix/init_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.c
 create mode 100644 tools/cxl/cxl_mhd_init.c
 create mode 100644 tools/cxl/meson.build

-- 
2.39.1


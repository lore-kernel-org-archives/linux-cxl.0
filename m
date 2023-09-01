Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B723CA0FE3
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Sep 2023 01:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348055AbjIAB3Y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Aug 2023 21:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjIAB3Y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Aug 2023 21:29:24 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D44FE76
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 18:29:21 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-58d40c2debeso16481837b3.2
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 18:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693531760; x=1694136560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96oDStEkTcK9mh6qUlrCVMfurdmTa5bB9l1cRASZKOA=;
        b=qQLV3AQjdDvP+jkrq/BpqtXL8ldMCtJlgvGAFfJtSlbhZIoOSiZA0d2VM5EDExb9RC
         /46RESzDq7q1wRCMm8sT0Ua+dP6SSrqbfxloeNhl1QW87Be+mioa7ssHRDDiXYivz6kn
         XM/J9sV5GKYuLVrUsajjVXzTX36atD2s6SQ+qdiZcx2A2aMcOoe+RLfiE/wxh0o/u1/B
         hkuZAZBgYQ0eJQdDFVUYIEFo3chvtxL8cFj1NxyRd/OdXfWEQC0/NToCxPF9VOGd6yFa
         q3o5cZDFIZ8NvQUqAbdah6RjMMNJwwE60mNPOdudRO3ckTCPx43m/ChFgc1/2H1MyU99
         X45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693531760; x=1694136560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96oDStEkTcK9mh6qUlrCVMfurdmTa5bB9l1cRASZKOA=;
        b=aXyQBtKN5EmQpmEn+SvNL9t3WaWZp+d20QYwa2Yzt9wsgOGOr+EI+kq03p2t+cLFrH
         X8Rt9qYJFivlq4oCJy52QjfzUxGMj4kUUrK4JOrMDgMTDvZbGfxBtU0BHIKUUj9Th0Xy
         CD6Q8xL6mnF4zGPZUabqHpBBU+UDqx6i9XPb6Yx2yLOvpyDGo/ZvVRK5ppFT8zlM10aK
         XjaXtKfnzlwoEN+xFi7R4mbbU24skiwM5yuXRfnbOpLKtYp9t4NfVIoihzTlzQi9gPb7
         m2+/AVGmUcOEudnNYmwLrkKDhXXFzA1y+wXLaJqvoAJtAIH6JVZICTfAm43U0AubidNM
         BkNQ==
X-Gm-Message-State: AOJu0YyhfCmVcf15Tlr603aFfzP1bU0UnyCeI343ljxpy+Y3uhSD5AED
        vwt/+69CvqUgugIzWBS1G0A0XmopqrAf
X-Google-Smtp-Source: AGHT+IHhgRM1lPYrHzbBPEnE0k1U7QwkrUld4HN9k6VkBh/dH1y33w7R0uxT9Jg3Yt7YMQREM6Np9w==
X-Received: by 2002:a0d:ca87:0:b0:589:fc81:952e with SMTP id m129-20020a0dca87000000b00589fc81952emr1177260ywd.7.1693531760254;
        Thu, 31 Aug 2023 18:29:20 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g186-20020a0df6c3000000b00559fb950d9fsm810447ywf.45.2023.08.31.18.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 18:29:19 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 0/5 v2] CXL: SK hynix Niagara MHSLD Device
Date:   Thu, 31 Aug 2023 21:29:09 -0400
Message-Id: <20230901012914.226527-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v2:
- 5 patch series, first 4 are pull-aheads that can be merged separately
- cci: rebased on 8-30 branch from jic23, dropped cci patches
- mailbox: dropped MHD commands, integrated into niagara (for now)
- mailbox: refactor CCI defines to avoid redefinition in niagara
- type3: cleanup duplicate typecasting
- type3: expose ct3 functions so inheriting devices may access them
- type3: add optional mhd validation function for memory access
- niagara: refactor to make niagara inherit type3 and override behavior
- niagara: refactor command definitions and types into header to make
           understanding the device a bit easier for users
- style and formatting

This patch set includes an emulation of the SK hynix Niagara MHSLD
platform with custom CCI commands that allow for isolation of memory
blocks between attached hosts.

This device allows hosts to request memory blocks directly from the device,
rather than requiring full the DCD command set.  As a matter of simplicity,
this is beneficial to for testing and applications of dynamic memory
pooling on top of the 1.1 and 2.0 specification.

Note that these CCI commands are not servicable without a proper driver or
the kernel allowing raw CXL commands to be passed through the mailbox
driver, so users should enable `CONFIG_CXL_MEM_RAW_COMMANDS=y` on the
kernel of their QEMU instance if they wish to test it

Signed-off-by: Gregory Price <gregory.price@memverge.com>

Gregory Price (5):
  cxl/mailbox: move mailbox effect definitions to a header
  cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write functions
  cxl/type3: Expose ct3 functions so that inheriters can call them
  cxl/type3: add an optional mhd validation function for memory accesses
  cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

 hw/cxl/Kconfig                          |   4 +
 hw/cxl/cxl-mailbox-utils.c              |  35 +-
 hw/cxl/meson.build                      |   2 +
 hw/cxl/vendor/meson.build               |   1 +
 hw/cxl/vendor/skhynix/.gitignore        |   1 +
 hw/cxl/vendor/skhynix/init_niagara.c    |  99 +++++
 hw/cxl/vendor/skhynix/meson.build       |   1 +
 hw/cxl/vendor/skhynix/skhynix_niagara.c | 516 ++++++++++++++++++++++++
 hw/cxl/vendor/skhynix/skhynix_niagara.h | 169 ++++++++
 hw/mem/cxl_type3.c                      |  33 +-
 include/hw/cxl/cxl_device.h             |   8 +
 include/hw/cxl/cxl_mailbox.h            |  18 +
 12 files changed, 863 insertions(+), 24 deletions(-)
 create mode 100644 hw/cxl/vendor/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/.gitignore
 create mode 100644 hw/cxl/vendor/skhynix/init_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.h
 create mode 100644 include/hw/cxl/cxl_mailbox.h

-- 
2.39.1


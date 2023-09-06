Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD60BEE14AA
	for <linux-cxl@archiver.kernel.org>; Wed,  6 Sep 2023 23:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbjIFXtD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIFXtD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 6 Sep 2023 19:49:03 -0400
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87C810CF
        for <linux-cxl@vger.kernel.org>; Wed,  6 Sep 2023 16:48:59 -0700 (PDT)
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-579de633419so4045117b3.3
        for <linux-cxl@vger.kernel.org>; Wed, 06 Sep 2023 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694044079; x=1694648879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4nG8OGAmHGIu2LAdsS8Gsh+p3EeoyBi8CsqSTMWnPc=;
        b=l2fp2yp3IKNhLhE9+9XdH7ZDQ2X7yien0L8FC7VLLqfNglQs5OsazFV5R1UqMXqJ9N
         NlDWnQCVk0l6LfcgywYK0mZuoT5UV44/tSxK/mbm6mAx7rjmITcQDwYQjqGUuta9FVso
         v/OrMcKU2Cl03+yRP7Xy4gqYfArCHJ+l1T9/F74BFKMdRnQ0Qj1vDoWIQNIFZtpKmdYP
         OV7UDPRM+Un010BjCxFvYXWMQrNb/ciTlTqRdXPUDy7bJ10MtXKDSuZVu9c3g4STxOHC
         uS8sg/v0ZSHBbUwFCG64Nn+OUNVXDAb1SnLNv7ddstR3hgsecPJDfYXuWaZxFQ9YetxT
         JGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694044079; x=1694648879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4nG8OGAmHGIu2LAdsS8Gsh+p3EeoyBi8CsqSTMWnPc=;
        b=YKmaHdF7DK4DnDG9shwwESJgOTnqERmTqclpEupo5mwokBbKpr86d4as3xD1b6gyXN
         pAhS/f2S0fjM1pnyalG/qJHk91rv1NSsCMZ7FMda911wZL4lMMfySnsO2pvpmJpJiEcz
         rZsdAGrTnSgiuntA8TimeME3xyc3uAr/prfgpYE+Y9xaTbuPfhjIpr3EDicdbig1iuzO
         jaVk78zKrAvdRMQXfBH1NVfaOlUi94QKqXEwtI19d2Q8dO7HKgnQ5Ru+JcSFtWGe988X
         1Uu2YU0ix32X9MnuNSma5gU1mry29CPUdtozXxNVyuSpQ6n3GsIMhVhZXjl4ZlEgkqLk
         FZLw==
X-Gm-Message-State: AOJu0YwkPuh9tSybp+EF1db8DWkT5itbi0qP9iYthIrxYu9mhUPHloC1
        aW2WwaCcrIrsAbslDsFN1aK37vvpCN7D
X-Google-Smtp-Source: AGHT+IHNvSjGbR2p4qbJK2NnbStjC57wh6s06URj06y93LD9nrT9T7veSbE7+WSF9cr17bT6hWq7hg==
X-Received: by 2002:a0d:d341:0:b0:58c:b8b4:2785 with SMTP id v62-20020a0dd341000000b0058cb8b42785mr17413200ywd.45.1694044078966;
        Wed, 06 Sep 2023 16:47:58 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:47:58 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 0/6] CXL: SK hynix Niagara MHSLD Device
Date:   Tue,  5 Sep 2023 20:15:11 -0400
Message-Id: <20230906001517.324380-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v3:
- 6 patch series, first 5 are pull-aheads that can be merged separately
- cci: added MHD back into main mailbox, but implemented a callback
       pattern.  type-3 devices leave the callback null by default and
       report unsupported if nothing implements it.
- cleanup and formatting

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

This device allows hosts to request memory blocks directly from the
device, rather than requiring full the DCD command set.  As a matter
of simplicity, this is beneficial to for testing and applications of
dynamic memory pooling on top of the 1.1 and 2.0 specification.

Note that these CCI commands are not servicable without a proper
driver or the kernel allowing raw CXL commands to be passed through
the mailbox driver, so users should enable
`CONFIG_CXL_MEM_RAW_COMMANDS=y` on the kernel of their QEMU instance
if they wish to test it.

Signed-off-by: Gregory Price <gregory.price@memverge.com>


Gregory Price (6):
  cxl/mailbox: move mailbox effect definitions to a header
  cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write functions
  cxl/type3: Expose ct3 functions so that inheriters can call them
  cxl/type3: add an optional mhd validation function for memory accesses
  cxl/mailbox,type3: Implement MHD get info command callback
  cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

 hw/cxl/Kconfig                          |   4 +
 hw/cxl/cxl-mailbox-utils.c              |  51 ++-
 hw/cxl/meson.build                      |   2 +
 hw/cxl/vendor/meson.build               |   1 +
 hw/cxl/vendor/skhynix/.gitignore        |   1 +
 hw/cxl/vendor/skhynix/init_niagara.c    |  99 +++++
 hw/cxl/vendor/skhynix/meson.build       |   1 +
 hw/cxl/vendor/skhynix/skhynix_niagara.c | 514 ++++++++++++++++++++++++
 hw/cxl/vendor/skhynix/skhynix_niagara.h | 161 ++++++++
 hw/mem/cxl_type3.c                      |  32 +-
 include/hw/cxl/cxl_device.h             |  13 +
 include/hw/cxl/cxl_mailbox.h            |  18 +
 12 files changed, 873 insertions(+), 24 deletions(-)
 create mode 100644 hw/cxl/vendor/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/.gitignore
 create mode 100644 hw/cxl/vendor/skhynix/init_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.h
 create mode 100644 include/hw/cxl/cxl_mailbox.h

-- 
2.39.1


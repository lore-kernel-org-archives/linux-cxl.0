Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C958C46CA1
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Sep 2023 17:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjIRRhG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 18 Sep 2023 13:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIRRhF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 18 Sep 2023 13:37:05 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A50FB
        for <linux-cxl@vger.kernel.org>; Mon, 18 Sep 2023 10:37:00 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-59bbdb435bfso47660727b3.3
        for <linux-cxl@vger.kernel.org>; Mon, 18 Sep 2023 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695058619; x=1695663419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElFAYYNkJRNCt2dt0TpsJRoShLKSj6k2tGqTV+c4V5M=;
        b=a1A/IBm1xXILMG6e44XXy7CT5EAIneJfmudhvJjbyWW8Cn25bhvoGzlbBmr5dBUzfd
         unT+Z2EBddQYZadoBWMlaPcFqYpG63ATz7PWvh+AbOqeoBCKDtQKA2EHfHYaorh0c99d
         sIHpBz0vA8+1HBNTmEwP/3c91HqbCY9kxlFrsRqYqQ2CxdPyJeQ+/WS+kZFswyLMAO4Z
         Hz/e/sWqWF47vLUyxKC6pgx+3y/X1Vku6mqLpJZWRDV5XEQqGdfj9BUC+MPVLkrPPxHB
         1+im/ySAD+TQ6248G2goHVSloLvCs+yOy6As6Ga4BdovE3UCAYG7jumw6pylThGK4g5s
         9YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695058619; x=1695663419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElFAYYNkJRNCt2dt0TpsJRoShLKSj6k2tGqTV+c4V5M=;
        b=PyF5PddRSeD38HghBzYNBP27yFZRbok2e0reD2xV59YUrnk+hy2xg387sYAi1lZeL+
         02EXmdLnSIDUwfocLi37cwT1SHEpfMcNWsB9GpxfOOhd9ugZOi9lctyIRuRY9oodd7Ud
         QcAGA+1LncBr+1+424QOQWU771wTm1fPdx0tng0I3ocQEeVpN03bN7jc90rno5N/EmNA
         LDVCB628eSbk1VjNDWxu58YKlx+RToXJfV0JJHyqjyIbkkgvZmwlhBmkjncJz+JK50lF
         tmcfvpJ9XljUC123aJUlH+yYnGblQ+m3IVIv/zjveD1H/7Jm9FNdqujmu4w4Z4iPFess
         Ze8w==
X-Gm-Message-State: AOJu0Yz37xphC4yddi8Wb4Y2qcvB+mL9ve6pbnHUMyt8VTqWfDngtEIP
        Ny9HcvWD9JVwkb3WRJoV4TiGRJyKN2pc
X-Google-Smtp-Source: AGHT+IHA+i8+y/c+Uh4TfqYlAHY/UorGy2DGFcez195H+rnhowSOTPtmxgj047onc5oz4SUheg8SRQ==
X-Received: by 2002:a0d:eac7:0:b0:59c:bab:eb4f with SMTP id t190-20020a0deac7000000b0059c0babeb4fmr9721891ywe.16.1695058619492;
        Mon, 18 Sep 2023 10:36:59 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v66-20020a818545000000b005704c4d3579sm2720306ywf.40.2023.09.18.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:36:59 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v4 0/1] Niagara MHSLD
Date:   Mon, 18 Sep 2023 13:36:55 -0400
Message-Id: <20230918173656.504628-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v4 update: Kconfig and meson fixes

Since Niagara uses <shm.h>, it presently can only be built
for linux.  Also addings missing Kconfig files and options
to turn it off, and turns it off by default if VENDOR or
CXL_MEM_DEVICE are turned off.

Gregory Price (1):
  cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

 hw/cxl/Kconfig                          |   6 +
 hw/cxl/meson.build                      |   2 +
 hw/cxl/vendor/Kconfig                   |   1 +
 hw/cxl/vendor/meson.build               |   1 +
 hw/cxl/vendor/skhynix/.gitignore        |   1 +
 hw/cxl/vendor/skhynix/Kconfig           |   4 +
 hw/cxl/vendor/skhynix/init_niagara.c    |  99 +++++
 hw/cxl/vendor/skhynix/meson.build       |   3 +
 hw/cxl/vendor/skhynix/skhynix_niagara.c | 516 ++++++++++++++++++++++++
 hw/cxl/vendor/skhynix/skhynix_niagara.h | 162 ++++++++
 10 files changed, 795 insertions(+)
 create mode 100644 hw/cxl/vendor/Kconfig
 create mode 100644 hw/cxl/vendor/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/.gitignore
 create mode 100644 hw/cxl/vendor/skhynix/Kconfig
 create mode 100644 hw/cxl/vendor/skhynix/init_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.h

-- 
2.39.1


Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB05FC00140
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 00:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244688AbiHIAga (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiHIAg3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 20:36:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E3212AD5
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 17:36:28 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id m22so7693712qkm.12
        for <linux-cxl@vger.kernel.org>; Mon, 08 Aug 2022 17:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc;
        bh=5q29jZ7YIohjexRChosQZ7/940SvzAkassVFkEQEz3c=;
        b=DoPb6JiCtFQ0DGDV/8vigKik/45SgcVOJAhB4ifOO0DuaeuzyQubWYhoEn840dumXQ
         BG6LSj7JOrqHPesoMqppIHQdBgmSnnsykSZeJ1ahw/kfOKFvL9p2iHgUflHr8d2dNYjG
         ulSg2AvAhuE61pNmZwOeCYLX7j1+PbW6WKF/j0icZuR14+0AXWycpOy5mx244qRmbNRq
         BuZ+ae7zjKiQhXBIs6/7dKhPg6QADGAZL4ZjtmSKtrnfN+k/ajIWi0LbkzV30M1h5awU
         D1HszD3mQs1y44Nj3x8lz9Ohwt9dQq0pA/0MHbu4FA9MUkuL0bwZLDrhbJXWcZ0LZOoe
         thxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc;
        bh=5q29jZ7YIohjexRChosQZ7/940SvzAkassVFkEQEz3c=;
        b=DEHDSjN80lkLsEBe8SP3rBIDiwOSQJJJHaa+QHeAnj6XLyM39DZTGdGoEyk0KY4wrr
         7Zr+ui/iLtc/DLAiQCEWDNENOFwpL0fdAq/mdSrQKjUUpWUqHxoRxUlpQX9SMKephJmj
         YRAs5ZVxZxrJbpcKNEEcBYIDQ45Va3UfVDOYmHMtau/utZpMlfxjL0WT+L9K+BC68ZR6
         DGWDZmgzursV7oZlTENHt5Dlswp0ILaoHd3IT92T0+JXA+82DE3uEd+mxrQWj0GhsO4s
         51mP3PFN13lOIv1D0EldVwTyZHvcEEycB1gTmtykvvFWDHkSFkGEPgSaIkYiWiQxUl1M
         fLHw==
X-Gm-Message-State: ACgBeo0apjLVCAJYTkVJWx32LnU2D+RhAKgrZxxBjvpW43iGEwT39bar
        gr1TTAd08f6yjn6llXDE4wjDnh8jEfI=
X-Google-Smtp-Source: AA6agR5MBdPukLFh/8uMnhFeKQlfp7pRtR1VVZHIEhbFj6BfWm0aOFFX2PWRRep+Qq8oSa9bYp8fyQ==
X-Received: by 2002:a05:620a:f03:b0:6b6:6513:af63 with SMTP id v3-20020a05620a0f0300b006b66513af63mr15217954qkl.312.1660005387755;
        Mon, 08 Aug 2022 17:36:27 -0700 (PDT)
Received: from smtpclient.apple ([69.110.136.229])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006b627d42616sm10246853qko.35.2022.08.08.17.36.26
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2022 17:36:27 -0700 (PDT)
From:   Kannan Devarajan <dkannan@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: cxl_mem error with QEMU device: probe fails
Message-Id: <5DC0B2CF-B83C-45C5-AC6C-D86144D9F2D8@gmail.com>
Date:   Mon, 8 Aug 2022 17:36:25 -0700
To:     linux-cxl@vger.kernel.org
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,
I am trying to get familiar with the CXL devices and the CXL driver =
using the QEMU/CXL emulator. This is the configuration that I am =
testing:

Kernel : Linux version 5.18.16 on Fedora 36
QEMU : Built from qemu/qemu/tree/staging git

The QEMU parameters that I am using are as follows (to instantiate one =
type 3 device):

object memory-backend-ram,size=3D4G,id=3Dmem0 \
-numa node,nodeid=3D0,cpus=3D0-3,memdev=3Dmem0 \
-device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 \
-M cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.size=3D4G \
-device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,slot=3D2 \
-object =
memory-backend-file,id=3Dcxl-mem0,mem-path=3D/tmp/cxltest.raw,size=3D256M =
\
-object memory-backend-file,id=3Dlsa0,mem-path=3D/tmp/lsa.raw,size=3D256M =
\
-device cxl-type3,bus=3Drp0,memdev=3Dcxl-mem0,lsa=3Dlsa0,id=3Dcxl-pmem0


When the VM comes up, I do not see any CXL device that is created.=20

dmesg has the following:


[ 5.193125] cxl_pci 0000:35:00.0: DVSEC ranges already programmed and =
HDM decoders not enabled.
[ 5.200500] cxl_mem mem0: Active DVSEC range registers in use. Will not =
bind.
[ 5.206712] cxl_mem: probe of mem0 failed with error -16


Browsing the drivers/cxl/mem.c code, it seems that =E2=80=9Cglobal_ctrl=E2=
=80=9D variable for HDM decode is not set. Perhaps I am missing some =
qemu flag to enable HDM decoder?

When I comment out  this block (at line 109)
      if (!global_enable && info->ranges) {

and rebuild, the mem device gets created.

Any help and pointers will be appreciated.

Thanks,
Kannan=

Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173CBC433F5
	for <linux-cxl@archiver.kernel.org>; Sat,  9 Apr 2022 23:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiDIXtQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 9 Apr 2022 19:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiDIXtQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 9 Apr 2022 19:49:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB85C71
        for <linux-cxl@vger.kernel.org>; Sat,  9 Apr 2022 16:47:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s8so11499774pfk.12
        for <linux-cxl@vger.kernel.org>; Sat, 09 Apr 2022 16:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MUbqjqroWUSuaCOjxZ4xcA3Ff9DzHo03eSpcfQTH7xs=;
        b=jd+dwSeiQNDcvKJh2B6IY6Tk/lOz864fH4P0sxe5iJIo67C/PpEHyeb4rvZ1TYblNz
         oyVI9ZXbEiaATFabXvynDPUOr5MarzmNgfogKr/e2hzv50KKXj+3Zi3UFjT0R+iPqZGR
         vFShBM7h6Sjyl2B9z5uow5OBCl5b63L8Dq1WSBzr6iZ7uwyOHjFPhYvrdICCv1j2135j
         f6JKaxvY62B8b/UwN+rOqJm8CgT84K6Q7bg9SDUOwc3OXMJgfm/QvM8iPOXK5Ul/8g/M
         91xmV6Gvnxe4zKxSdtxJ229slvTSjap6EucN0yzNBBH6B/ouVnl9b3AlE4G/Yn1/uD+p
         Fwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MUbqjqroWUSuaCOjxZ4xcA3Ff9DzHo03eSpcfQTH7xs=;
        b=nzX2y2dPY5Q2aAP/wLOduQCScmGFzzBcOfEkMmIIkh73TzeygtPMBo8iDtClz9vQjS
         OMm5h05Vw8q25bblJuaF9XDsPNvSHM9RaZdXaByHLRjSbFwZ/NEUm8EJSv5SRuz1EE9s
         D/vJLXPBsHGDWe92G039Xp9ZT82g2MFNHJUAt8YHCFjfEfkGyUgpJcjeM7JigTtpyklu
         yWHdMyYy6g1iuapuycxLIn0nuqPguABHD8FVR3ydp//DRrwkpk0diIo0yUVh/GTDzD1v
         C2lYMOM20hW24Mlj4BvHPGJBrAQKQzf2ufcAbX1hAxuUxgYRz7gyCWmxsdZ+6UUhRMBP
         vCgQ==
X-Gm-Message-State: AOAM531lhRzov/JPYblSD3G+4nGDwOFSmD65qFmVm78/18EN2HRAZOz1
        IGBiiX4AVDf10ZjWtMP2jGi07gk85NNpWeKvcycwlQ==
X-Google-Smtp-Source: ABdhPJz86brASdkpVzG2YkHEjnR4KziiLzs3+/7QlKPE4XvQD/ceEaQo/bpzGu2sg4zmcjVzHdKPij9WgcSkJea0IeQ=
X-Received: by 2002:a05:6a00:e14:b0:4fe:3cdb:23f with SMTP id
 bq20-20020a056a000e1400b004fe3cdb023fmr26408877pfb.86.1649548027242; Sat, 09
 Apr 2022 16:47:07 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 9 Apr 2022 16:46:56 -0700
Message-ID: <CAPcyv4gLVHZSJNPcxcb6tDD3z8DO_X49OvV-cudeziKfG_08mw@mail.gmail.com>
Subject: [GIT PULL] NVDIMM + CXL fixes for v5.18-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/cxl+nvdimm-for-5.18-rc2

...to pick up a couple fixups for code that went in during the merge
window. These did not appear in -next yet, but they have seen kbuild
robot exposure.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/cxl+nvdimm-for-5.18-rc2

for you to fetch changes up to d28820419ca332f856cdf8bef0cafed79c29ed05:

  cxl/pci: Drop shadowed variable (2022-04-08 12:59:43 -0700)

----------------------------------------------------------------
cxl + nvdimm fixes for v5.18-rc2

- Fix a compile error in the nvdimm unit tests

- Fix a shadowed variable warning in the CXL PCI driver

----------------------------------------------------------------
Dan Williams (2):
      tools/testing/nvdimm: Fix security_init() symbol collision
      cxl/pci: Drop shadowed variable

 drivers/cxl/pci.c                | 1 -
 tools/testing/nvdimm/test/nfit.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

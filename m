Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5C0C6FA8E
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjBXTrG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXTrG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:47:06 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9AF6C194
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:47:04 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CBF0B3E1F01;
        Fri, 24 Feb 2023 19:47:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 42B7A3E0713;
        Fri, 24 Feb 2023 19:47:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677268021; a=rsa-sha256;
        cv=none;
        b=Orq6m1Zt1Ya18LkPonoWgnC5ZtI/nLGy8SNrIJ3BNTWJOwNiHvrROQDCoXuwr3PEKL4xh2
        wzuQvkbFbnByny2JelYzXZChFyVofCTMKFDDtskZ/HsgYMj1D1yourj1MU40oqB5dFWMYw
        Zil26GkMOcxvpG90NYu6UnU2u6wPdwNr2eH7Bv1X06QJURVpltJTcIWBIZnnI3R0MiUtGV
        lwvBQE8tzr+j2GnAs2nQ18yFiTQpo2/9AGUK/fYbfaZiaDngm79aVar4+QiAJjZ+LcyODd
        +dqQscHbYw7TjyCqu/uBmZViMEjOb8Jxvp2oPdgcke5C0iS0nPfB9321TRGqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677268021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=F4Jc5TcKAbnR5DVr9J553kxy6Mm8mdJuCIjQXMkrxAU=;
        b=GVikO9IAlmt9y8HfcQj+Yc2di10LZ1mzRa/ds6jgIlZcpPev3RDIDCW6rEj5Adls0BcTdT
        oU9Ybs54Eaw9+ODTn67qm17dxl+xubTG6MXHT5kvX5S8AZikdqr23DihIMsoX/RDwN5kqh
        ow515vGVCRc4HjYJ79M7r1htyRIQalaCzYQ2WJguAPKiwj1J6jhx4r9NHDOru7QfkAGMr5
        kzpH+dIGqkmOxI/TAl66T5+uDmWOix8d6cwFWX4S5rZSFZ0oZGrnZ4vJR+Y9s2xgGM7dnD
        +pJGVfDyMvCPRvuTHAWa5uOgMUqeYs8gFg9owCZYmpijHfRbLH41AgOjxC8urQ==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-l9rxh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Stop: 40feec6a2c1f7c58_1677268021611_1383636726
X-MC-Loop-Signature: 1677268021611:2535244679
X-MC-Ingress-Time: 1677268021611
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.37 (trex/6.7.1);
        Fri, 24 Feb 2023 19:47:01 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgQB2vc9z2d;
        Fri, 24 Feb 2023 11:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677268020;
        bh=F4Jc5TcKAbnR5DVr9J553kxy6Mm8mdJuCIjQXMkrxAU=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=coFg6pqwJbzZZEPbjYHxVFuOnLO0A5+IbhQO/Nc5/bUulK3AUrhJNgZ+Xv7LDHSpd
         gSJT+/D99G9+UY0lFXSuLhnEIyWBpkDs8cTqtF6ke32R3b3Qg1CdLlPk+P6BmyzI26
         YPYe0AxM1Jk4hhnXdkk/+SAR6rchhWiamcN0bb4proXB755s/F4hfEhfqAGuFP7g6b
         9K3lKWCtUCdZ3T0c/2a4CcSEcMP0ttSQLwWiEUOFeM51ZTTPMy7UbwrDiFW7/LJbAS
         hqlZyvsGk1kXwCZFyPTuwr/0CAqZ+QAQHXDvdzOo/AKeFGCs9BCnNa1dEQdhgJm3bs
         Gy3sZPa3HWydQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH v3 0/7] cxl: Background cmds and device sanitation
Date:   Fri, 24 Feb 2023 11:46:45 -0800
Message-Id: <20230224194652.1990604-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

This series adds support for the rest of the security related cxl operations
which are not strictly dependent on PMEM.

Patch 1 adds the required background cmd handling bits (polling and irq).
This is really the main motivation of the series as there are various
features that will need this regardless of sanitation.

Patch 2 adds a new sysfs 'security/state' file, which shows "disabled" if
no security features are available - which is more intuitive than no showing
it.

Patch 3 adds a way to check if the device is actively used by tracking regions
with target the memdevice to sanitize. I realize this might not be what is
desired and wanted to get the expectations for this. This is more of a RFC
patch.

Patches 4-7 add the Sanitation and Secure Erase support, per CXL3.0 specs.

These changes have been tested with both the mock device as well as with qemu[0,1].

Changes from v2 (https://lore.kernel.org/linux-cxl/20221206011501.464916-1-dave@stgolabs.net/):
- Redid the bacground cmd handling to use a syncronous approach instead.
- Added cxl_memdev_active_region() to check if the memdevice is being used
  (actively decoding any HPA ranges).
- Create a new security sysfs directory with a 'state' file which is always visible.
- The sysfs files' to trigger the security commands is only visible if
  cpu_cache_has_invalidate_memregion().
- Added a sanitize test for the mock device.

Please consider for v6.4.

Thanks!

[0]: https://github.com/davidlohr/qemu/commit/64a93a5b824b59d3b547f06f7fbb1269fb4790ce
[1]: https://lore.kernel.org/linux-cxl/20230224194443.1990440-1-dave@stgolabs.net

Davidlohr Bueso (7):
  cxl/mbox: Add background cmd handling machinery
  cxl/security: Add security state sysfs ABI
  cxl/region: Add cxl_memdev_active_region()
  cxl/mem: Support Sanitation
  cxl/test: Add "Sanitize" opcode support
  cxl/mem: Support Secure Erase
  cxl/test: Add "Secure Erase" opcode support

 Documentation/ABI/testing/sysfs-bus-cxl |  34 +++++++
 drivers/cxl/core/mbox.c                 | 117 +++++++++++++++++++++++
 drivers/cxl/core/memdev.c               | 119 ++++++++++++++++++++++++
 drivers/cxl/core/region.c               |  33 ++++++-
 drivers/cxl/cxl.h                       |  13 +++
 drivers/cxl/cxlmem.h                    |  14 +++
 drivers/cxl/pci.c                       | 100 +++++++++++++++++++-
 tools/testing/cxl/test/mem.c            |  52 +++++++++++
 8 files changed, 476 insertions(+), 6 deletions(-)

--
2.39.2


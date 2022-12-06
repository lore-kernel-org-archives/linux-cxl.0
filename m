Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E984C4708C
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 01:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiLFBPa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLFBP3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 20:15:29 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4B01EEE1
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 17:15:18 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4360E6C0FEC;
        Tue,  6 Dec 2022 01:15:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a242.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2B6B96C1735;
        Tue,  6 Dec 2022 01:15:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670289309; a=rsa-sha256;
        cv=none;
        b=r9MAysBim4Vhb9LXux8P+AH/o5Q8sota3rGTNxdZy9EIK29KFeP9XrMblk7HjBP0cmN/59
        zeg1VkrDgmNgi+tfyZ2Wnd1TUcr4u3shDiWwBFV1j/soIuEyeFEEIPxXOtXS38vwWvHqN4
        D5j71fawkdMHk0x+f+dmcrimP60UwK8OZ0WABk4NcClNRXa4nFrIUkJ0Ga3zkajq+7NVcB
        XsFnRg0Ap3v+bzQ2CXpSiqPy7fkeuNxUJXT+o7KsorTQcssActwuzKnLdJ5SaDlDyo40KV
        uK+F6niLX2xsKbFSepVtZuQKL9t0X1H0RUE9BxkuNjaTaZwlj19wEJ2hQw17/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670289309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=dMcnoknNgD/gwZ6mskSCl6yseFviRXyzcFlb0YblDvk=;
        b=MwL0ZYkN+IId0bk+vJ9a2Uc4oxHKSHqG2CiCxUUZ4A5kSkNaIbPuJDmCEPMkBk6ZolK0UG
        zld7tDqRZa54bCfCksYWlVFhPfdpshcUbIC015mywf5QdwUPUNK2Wkv2lKlRgZvY4F3g1L
        fDuA0RowOL0oe06flWAcZxoe1GYTKgm9hC+8RG1xyPZWhQs8jcVevuJGfy2PjXRrsb3t+f
        WpmN9D+tQs7jagzOGZGuhbFFzpx/GiDha+vy+AKVLswbwxJaLBGXh0tc89hOpON4z3lr/o
        JRwZR8ht6jkuq7eBKi14Uv/0RENrHJFnpvHsqcf93bTgmTaXMdllJ2UiaSVaOg==
ARC-Authentication-Results: i=1;
        rspamd-7bd68c5946-dtxhm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Cooperative: 44549d8a12f09671_1670289309451_2274599994
X-MC-Loop-Signature: 1670289309451:270702469
X-MC-Ingress-Time: 1670289309451
Received: from pdx1-sub0-mail-a242.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.82 (trex/6.7.1);
        Tue, 06 Dec 2022 01:15:09 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a242.dreamhost.com (Postfix) with ESMTPSA id 4NR2XD2Ky8z3H;
        Mon,  5 Dec 2022 17:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670289308;
        bh=dMcnoknNgD/gwZ6mskSCl6yseFviRXyzcFlb0YblDvk=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=hqkDZFHelBtoQrjmDZTPnjX+sXlsfMJIauFMZkeerfLGim1VHXyD59+4MqDrCa9j+
         B1H45AW1+ed6AT+4o78FB98Xn+zxCVx4cEkVQOBXXPB/Ddc447ole3lOcoL9SRpGRI
         9jJ9aUKtM4qZIzEXIeDfk7TeWFRe1YE3rkKoIrPFz5I/IaSJXGPUmvfe4NYdOFiCuQ
         75wfhptI2s7k7YYLtO/l1J95wOuPVIWKoWFD/uxfWFQG9sgKYzPCj8DrcySi3zGeXV
         VvU9cZ3nmMJ6e90wk7jWEplInoGproOs2zTS6DyA6zw0l+mqmUOS8gb0WeWzR+7Sm+
         nc+0saoDqT+Lg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/3] cxl: BG operations and device sanitation
Date:   Mon,  5 Dec 2022 17:14:58 -0800
Message-Id: <20221206011501.464916-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

This series adds support for the rest of the security related cxl operation
which are not strictly dependent on PMEM.

Patch 1 adds the required background cmd handling bits. While this is currently
only polling support, the idea is to follow up with an irq support once the
bits land in Ira's event work. All polling-specific code has been marked
as __maybe_unused.

Patch 2 implements the sanitation commands (overwrite and secure erase).

Patch 3 adds a support for secure erase mocking.

As for testing, while I used the mock device to test the secure erase command, I
ended up hacking up a prototype[0] for qemu to support overwrite and bg commands.
So while the some of the paths this series introduces have been exercised, there
is of course a lot more to do.

Applies on top of the 'for-6.2/cxl-security' in cxl.git.

Changes from rfc (https://lore.kernel.org/linux-cxl/20220804045029.2905056-1-dave@stgolabs.net/):

* Patch 1:
 - Added a cxlds->mbox_irq flag in order to separate the polling-specific requirements.
 - Made bg workqueue concurrent.
 - Address iteration mem commands style (Jonathan). Now just rely on cxl_mem_find_command + check
   bg flag + callback.
 - Don't error in cxl_mbox_check_cmd_bgcmd() if conflicts() callback is not defined (Jonathan).
 - Error out in cxl_mbox_send_cmd() upon corruption in cxl_mbox_bgcmd_begin() (Jonathan).
 - Do not prematurely add all bg capable opcodes (Jonathan).

* Patch 2:
  - Rework polling delay hinting (Dave).
  - Rely on CEL to see if command is supported instead of unconditionally sending it (Jonathan).

* Added patch 3.

[0]: https://github.com/davidlohr/qemu/commit/64a93a5b824b59d3b547f06f7fbb1269fb4790ce

Thanks!

Davidlohr Bueso (3):
  cxl/mbox: Add background operation handling machinery
  cxl/mem: Support sanitation commands
  tools/testing/cxl: Add "Secure Erase" opcode support

 Documentation/ABI/testing/sysfs-bus-cxl |  19 ++
 drivers/cxl/core/core.h                 |   3 +-
 drivers/cxl/core/mbox.c                 | 317 +++++++++++++++++++++++-
 drivers/cxl/core/memdev.c               |  54 ++++
 drivers/cxl/core/port.c                 |   1 +
 drivers/cxl/cxl.h                       |   8 +
 drivers/cxl/cxlmem.h                    |  65 ++++-
 drivers/cxl/pci.c                       |   4 +
 drivers/cxl/pmem.c                      |   5 +-
 drivers/cxl/security.c                  |  13 +-
 include/uapi/linux/cxl_mem.h            |   2 +
 tools/testing/cxl/test/mem.c            |  27 ++
 12 files changed, 497 insertions(+), 21 deletions(-)

--
2.38.1


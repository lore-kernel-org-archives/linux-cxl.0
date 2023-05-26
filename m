Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B498C77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 04:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjEZEHa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 00:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEZEH1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 00:07:27 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E3E12F
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 21:07:25 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0B472761A32;
        Fri, 26 May 2023 04:07:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 77A18761AD6;
        Fri, 26 May 2023 04:07:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1685074044; a=rsa-sha256;
        cv=none;
        b=1s27S2eVZ7V7Ka9w5cRm1axFsJN2ky0dbLC7qaiy0uE9Idki5dMTGmrkzauG2IO/RFlP1o
        PQTvt4fAHjgTBsOoYIEkDarbvJk3qYf1YuYotE9bguC+zW1GlsFue+8d0L+WhRrUPFu/oL
        /agb7skKkOeTi9AVzGCLlZnDjHwJFv6Bc9z8aVkZjpKDXvqJmRnBDpnrALJ0d3fGGRyd5W
        MlCYe6Jq1GgYr7kIXSVWqsK+ayY7dX+8SaJzU1QxepNSQWu+8tkUD1GYYlGbQVz7ubIs5p
        S5VHfDl2xAAZMcUCXqFaWOHcKnKywQMmi3Ey2YmUfgPj11S9D0BEgSiQml8vRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1685074044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=sBAnhoQ2hrb+bLVCejMxmvhClozyZOqz1norKXjVpYc=;
        b=9aw0pcennjSbNRnfGuNvYqGAUmMGmgJx8cdPRz7V3ELrHI2nQgupJiXUaGLpxrJPjSLAlF
        ZdKIQwWPqmw09+KncAjCJH31RvGDIQNifDk0DSy+32FwQYoMknmnqdTzlowcS+cKwssAh4
        AaFGOuzipkAF5kNO3ySCjtHAJyepvR6Y/6/JB6oaJUUEDfy4gmyBtznI5KbBZFp2bHHhN/
        MSyC278sTPXrPCmFclNKLdu4287maP9Xzrh5sgFKTPM5jEBLtCqE6pjB2kVffxZNSe9++H
        /HdiFEJOY/OGuzh+et2HZoAV89cyZfL+hNRHeQh5J5CAe3hh09eXd0bYPLnnNg==
ARC-Authentication-Results: i=1;
        rspamd-7d4b855556-2z89p;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Troubled-Illustrious: 3dc25c3063e67b15_1685074044798_4265129333
X-MC-Loop-Signature: 1685074044798:560490212
X-MC-Ingress-Time: 1685074044798
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.46 (trex/6.8.1);
        Fri, 26 May 2023 04:07:24 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4QSBG35WSkz36;
        Thu, 25 May 2023 21:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1685074044;
        bh=sBAnhoQ2hrb+bLVCejMxmvhClozyZOqz1norKXjVpYc=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=NOLti9XnbXMBVwd1xW5DhsDMvgpveZtVChiiLOr/hKLTc7roRltxPXn4sq8QV40LJ
         SbulOkwgBP/CjbUVuI6iWdAwgKesofBVpyiorFCmkfQ4gCaEXt8nQxEjLLCX1xS6Zg
         jNbKJJBgSEi+Tidnpqw2iEsuMcyqHV7I1FPH89an90UWfJqHDp+1KS7qtuJ7IubwK7
         V6kvm4Au/L1Lj/62/PsMDz6tw1M7V2iN1pFDWTjkrk61pEoDYSR9rdx8ZkjsGYvdaW
         TnDY0w/O1YcAJZAnEB6em86I9ZaF+/TzoGn733oOkr96QMqa0hHKypeNjNN6/tVv+s
         +JTLIy3kt/zrg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 0/6] cxl: Support device sanitation
Date:   Thu, 25 May 2023 20:33:38 -0700
Message-Id: <20230526033344.17167-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

Changes from v4 (https://lore.kernel.org/linux-cxl/20230421092321.12741-1-dave@stgolabs.net/):
    o Added patch 1 'security/state' sysfs file which will be the placeholder
      for userspace to know about pmem security or an on-going sanitation op.
    o Renamed some of the sanitation polling variables.
    o Picked up review tags for mock device test patches.

This adds the sanitation part of the background command handling. Some noteworthy items:

    o Treating Sanitation as such a special beast can make the code a bit invasive,
      but couldn't find a decent alternative. For example I realize that this is really
      ad-hoc code in __cxl_pci_mbox_send_cmd(). A lot of this also comes from the fact
      that polling for sanitize is supported, so sw still needs to keep up and serialize.
      
    o Nothing depends explicitly on CPU cacheline management

    o All sysfs files/attributes in the security directory are visible.

    o Continue to use __ATTR() macros for sysfs attributes instead of the requested
      DEVICE_ATTR_*() ones because of the naming the security directory, otherwise
      names don't match.

Patch 1 adds a new security/state file.
Patch 2 paves the required sanitation handling code before actually using it.
Patch 3,4 wires up sanitation + unit test.
Patch 5,6 wires up secure erase + unit test.

Testing.
========

o There are the mock device tests for Sanitize and Secure Erase.

o The latest (v2) qemu bg/sanitize support series is posted here:
	https://lore.kernel.org/linux-cxl/20230418172337.19207-1-dave@stgolabs.net/

(1) Window where driver is out of sync with hw (Sanitation async polling).

[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
[  159.297482] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:37:00.0: Sending command: 0x4400
[  159.298648] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:37:00.0: Doorbell wait took 0ms
[  159.299908] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:37:00.0: Sanitation operation started
>>>> qemu informs sanitation is done <<<<<
[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
[  165.897345] cxl_pci 0000:37:00.0: Failed to sanitize device : -16
[  171.692050] cxl_pci:cxl_mbox_sanitize_work:147: cxl_pci 0000:37:00.0: Sanitation operation ended
[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
[  173.373337] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:37:00.0: Sending command: 0x4400
[  173.374498] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:37:00.0: Doorbell wait took 0ms
[  173.375727] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:37:00.0: Sanitation operation started

(2) Perform sanitation of more than one memdev at a time (Sanitation async polling).

[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem1/security/sanitize
[  351.287129] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:36:00.0: Sending command: 0x4400
[  351.288403] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:36:00.0: Doorbell wait took 0ms
[  351.289706] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:36:00.0: Sanitation operation started
[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
[  353.058614] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:37:00.0: Sending command: 0x4400
[  353.059854] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:37:00.0: Doorbell wait took 0ms
[  353.061126] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:37:00.0: Sanitation operation started
>>>>  qemu informs sanitation is done <<<<<
>>>>  qemu informs sanitation is done <<<<<
[  363.692138] cxl_pci:cxl_mbox_sanitize_work:147: cxl_pci 0000:36:00.0: Sanitation operation ended
[  365.227416] cxl_pci:cxl_mbox_sanitize_work:147: cxl_pci 0000:37:00.0: Sanitation operation ended

(3) Perform sanitation of more than one memdev at a time (Sanitation async irq).

[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem1/security/sanitize
[  193.729821] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:c1:00.0: Sending command: 0x4400
[  193.731071] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c1:00.0: Doorbell wait took 0ms
[  193.732360] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:c1:00.0: Sanitation operation started
[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
[  197.001466] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:36:00.0: Sending command: 0x4400
[  197.002694] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:36:00.0: Doorbell wait took 0ms
[  197.003956] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:36:00.0: Sanitation operation started
>>>> qemu says sanitation is done <<<<
[  197.731473] cxl_pci:cxl_pci_mbox_irq:119: cxl_pci 0000:c1:00.0: Sanitation operation ended
>>>> qemu says sanitation is done <<<<
[  201.003258] cxl_pci:cxl_pci_mbox_irq:119: cxl_pci 0000:36:00.0: Sanitation operation ended

(4) Forbid new sanitation while one is in progress (Sanitation async irq).
 
[root@fedora ~]# cat /sys/bus/cxl/devices/mem0/security/state
disabled
[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
[   39.284258] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:36:00.0: Sending command: 0x4400
[   39.285459] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:36:00.0: Doorbell wait took 0ms
[   39.286723] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:36:00.0: Sanitation operation started
[root@fedora ~]# cat /sys/bus/cxl/devices/mem0/security/state
sanitize
[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
[   42.697129] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:36:00.0: Sending command: 0x4400
[   42.698323] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:36:00.0: Doorbell wait took 0ms
[   42.699525] cxl_pci:__cxl_pci_mbox_send_cmd:335: cxl_pci 0000:36:00.0: Mailbox operation had an error: ongoing background operation
[   42.701119] cxl_pci 0000:36:00.0: Failed to sanitize device : -6
>>>> qemu says sanitation is done <<<<
[   43.285334] cxl_pci:cxl_pci_mbox_irq:119: cxl_pci 0000:36:00.0: Sanitation operation ended


Applies against 'for-6.5/cxl-background' from cxl.git.

Please consider for v6.5.

Thanks!

Davidlohr Bueso (6):
  cxl/mem: Introduce security state sysfs file
  cxl/mbox: Add sanitation handling machinery
  cxl/mem: Wire up Sanitation support
  cxl/test: Add Sanitize opcode support
  cxl/mem: Support Secure Erase
  cxl/test: Add Secure Erase opcode support

 Documentation/ABI/testing/sysfs-bus-cxl |  37 +++++++
 drivers/cxl/core/mbox.c                 |  59 ++++++++++
 drivers/cxl/core/memdev.c               | 139 ++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  26 +++++
 drivers/cxl/pci.c                       |  88 ++++++++++++++-
 drivers/cxl/security.c                  |   3 +
 tools/testing/cxl/test/mem.c            |  52 +++++++++
 7 files changed, 400 insertions(+), 4 deletions(-)

--
2.40.1


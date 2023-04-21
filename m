Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D855BC7618E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 09:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjDUJzn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjDUJzm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 05:55:42 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDF0AF0B
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 02:55:35 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0DE3854104D;
        Fri, 21 Apr 2023 09:55:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 773A3541027;
        Fri, 21 Apr 2023 09:55:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682070934; a=rsa-sha256;
        cv=none;
        b=SagEY77zeEStzbGiTDdWxofOb8kpozpdPxQWOCy9mlSFgNqMV0h5jOnVc5MzmTiuwEdezt
        78WxwVKtm8GCDoniCYhUxHmrlUZFj94I+VNHJfGz/JLN57vOPpQO9zOR1PtAojfmVXwYGk
        z7KqSXnJ4PyQ8uK6jZWtUGNy4jw2lwKSzD2WEGP1B5V0Bor2k06lg2PqZyEMc2ZdjoKD3G
        cy7uBfgDsEjuT7leUV6G5Gjj7ElcdvFrrI0LicQ9GKLdspTgjIMdcs8cx+JzTpWdMOJHki
        2nbi29Hrx0p9lkkaGGFpxWezE6dmQCg14lHIHNkcYpz67Stbf0/lxNovHhw1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682070934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=pchTm2S8FWJD7d+3Kpbf1NIR0qPNH4JVpK8c6XjHdSY=;
        b=BDwUvhfcVU1h5/FiHdhq/SFRd5EcVdy32aW91Ft/i8S70IJyqtkhAO8b45+I4WvXATtN+w
        32E4vJMYsqj8AjgwK8dJx/pbxPmuDpXEO4eySjPre5vIG5T6JUgdt3f0WZZTsuL/qvercw
        5mOSdXy1JoOcjE78SUqCITdhNGT09KKPBpdC/XOFmKQRCj2w7Oc+8Y9665i5NGtEQRGtlu
        9rDrlUR8lzcERBoEoCrI9eOzAO1UkI22JKNDP8BCM8LJJB++ETRH9q5DJBa0dgoNzexP0L
        APr6qMdmMY3AUhuf+Nu3trfx7g6cLgA3hmbUnWHvaSIda+Q2FBB2BDRNZcN8dg==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-tqw7k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harmony-Troubled: 7518bfd05fc1c621_1682070934821_2854566223
X-MC-Loop-Signature: 1682070934821:2581886874
X-MC-Ingress-Time: 1682070934820
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.65 (trex/6.7.2);
        Fri, 21 Apr 2023 09:55:34 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Q2qdx4jpwzRN;
        Fri, 21 Apr 2023 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682070934;
        bh=pchTm2S8FWJD7d+3Kpbf1NIR0qPNH4JVpK8c6XjHdSY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=VYGiI9OtZ4JN+UVViwpcvYcC2zAdnchUKyG8A1qfHMcyuKPFC0zCwbdf3mukHUdCz
         vs2IrypRMPAtvVYbRs6JIUbKBGBAi6dgmgkQS2Nr8k0JetSgBooM7O5u+STrl/L1Py
         NP2aVSMK5thZhFH4DIGfvPZhZn0L0+YRfpvy5rxaqArsdSJpnfstIsUpWuLziS09ca
         S0bHQFkqJtgz7yGtHpSUOs25yLrY+QWrhgV4EDrn6w/9tWolawd7/o4vZbbttH6S8A
         QMsba3iD+Re0BwlyaUtTc+zyISRepEFjHX1tiv1GPncZ3vNOPIXLm6CNuA9GAdcbQC
         9Yebe4TEU3ETw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/7] cxl: Background cmds and device sanitation
Date:   Fri, 21 Apr 2023 02:23:14 -0700
Message-Id: <20230421092321.12741-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

First thanks for the reviewing and feedback. It took me a while to get back to this in a
form of a new series between vacation, being sick and ensuring I (hopefully) covered all
your requirements. So all of this is intended for v6.5.

The first two patches can directly open the door for Scan Media, etc. and could be picked
up regardless of the rest of the series - I wouldn't want for Sanitize to hold up other
functionality, specially considering the special treatment it gets. That said, the synchronous
mbox bg handling code paths (patch 2) are the least tested in the series (for obvious reasons).

On that note, this series combines the original async semantics from the RFC/v2 specifically
for Sanitation while leaving the rest of the background-capable operations in the sync approach
from v3:
	https://lore.kernel.org/linux-cxl/20230224194652.1990604-1-dave@stgolabs.net/

Specifically, it's worth noting:

    o Supporting async polling for sanitation must protect against out-of-sync driver and hw.
      See testing (1) below.

    o Treating Sanitation as such a special beast can make the code a bit invasive imo,
      which I'm not crazy about but couldn't find a decent alternative. For example I realize
      that this is really ad-hoc code in __cxl_pci_mbox_send_cmd().

    o Regardless of the state of the irq setup, the probing never fails, and falls back to
      async polling as last resource.
      
    o Nothing depends explcitly on CPU cacheline management
      
    o All sysfs files/attributes in the security directory are visible.
    
    o I continue to use __ATTR() macros for sysfs attributes instead of the requested
      DEVICE_ATTR_*() ones because of the security directory (perhaps I'm missing something
      obvious).
    
    o I've dropped the 'security/state' sysfs file creation - I will use the a cached pmem
      security flags, but can be sent later once the rest is settled. The actual sanitize and
      erase commands do ask the hw about security - there is no risk of spamming the mailbox.

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

(4) Forbid new sanitation while one is in progress (Sanitation asyn irq).
 
[root@fedora ~]# cat /sys/bus/cxl/devices/mem0/security/sanitize
disabled
[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
[   39.284258] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:36:00.0: Sending command: 0x4400
[   39.285459] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:36:00.0: Doorbell wait took 0ms
[   39.286723] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:36:00.0: Sanitation operation started
[root@fedora ~]# cat /sys/bus/cxl/devices/mem0/security/sanitize
sanitize
[root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
[   42.697129] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:36:00.0: Sending command: 0x4400
[   42.698323] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:36:00.0: Doorbell wait took 0ms
[   42.699525] cxl_pci:__cxl_pci_mbox_send_cmd:335: cxl_pci 0000:36:00.0: Mailbox operation had an error: ongoing background operation
[   42.701119] cxl_pci 0000:36:00.0: Failed to sanitize device : -6
>>>> qemu says sanitation is done <<<<
[   43.285334] cxl_pci:cxl_pci_mbox_irq:119: cxl_pci 0000:36:00.0: Sanitation operation ended

Applies against 'fixes' branch from cxl.git. Please consider for v6.5. 

Thanks!

Davidlohr Bueso (7):
  cxl/pci: Allocate irq vectors earlier in pci probe
  cxl/mbox: Add background cmd handling machinery
  cxl/mbox: Add sanitation handling machinery
  cxl/mem: Wire up Sanitation support
  cxl/test: Add Sanitize opcode support
  cxl/mem: Support Secure Erase
  cxl/test: Add Secure Erase opcode support

 Documentation/ABI/testing/sysfs-bus-cxl |  29 ++++
 drivers/cxl/core/mbox.c                 |  63 +++++++-
 drivers/cxl/core/memdev.c               | 120 +++++++++++++++
 drivers/cxl/cxl.h                       |   7 +
 drivers/cxl/cxlmem.h                    |  26 ++++
 drivers/cxl/pci.c                       | 192 +++++++++++++++++++++++-
 tools/testing/cxl/test/mem.c            |  52 +++++++
 7 files changed, 483 insertions(+), 6 deletions(-)

--
2.40.0


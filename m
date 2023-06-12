Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04B9C88CB6
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Jun 2023 18:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjFLSpb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjFLSpa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Jun 2023 14:45:30 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2B5184
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jun 2023 11:45:26 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 43AAC10085B;
        Mon, 12 Jun 2023 18:45:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 80777100B98;
        Mon, 12 Jun 2023 18:45:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686595522; a=rsa-sha256;
        cv=none;
        b=CP6LbGq/u6SWgcIe8k7gsZhgA9/y1YZrXVSsToDJbuTa8KeRD3OVwIHZaNcYItz+k374wq
        PAZ2BKVKy4TS3Hf5rjtXaMsLp5wc0JqxKfyOT99ZzXM3h02j+ARJ3PQMeEB5mNwMn6lfqc
        63LysHR+YaMvdekzY5zhPGOgUB6HTZFZmkqiMPdhr9fRFEJC+ccyChRrk+9Y2S+09bc0G2
        E4Ld4No9CF5qTGo9/+092uV7B8da42vkR3WHmpR+Cok4XzoWqkrEgO9PDpTYYx/mfezfX7
        bU57ndVKj9JrOarwt4+ehUDosZJcq7JbqkIWuW06VZznnmp3/EiTnNhKls6bDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686595522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=p6fH8NvQgIzmDqEM/JZU+1fWv6DCo5CmbjF4my4Rkvc=;
        b=6CYHfwL8NVR/NnzaQamf/cCxZh1GprwOLy+YUfB/+m4tENNZYfgrbxWqe4F5r5w1VF0oPa
        IvmMgZGzj5DAHHSqiVeWfXJrhFX/K8ANib+LpL9J6yX1qZNB02+tFYtAF5spkIwf8DPf5v
        4oAa/ORLJIDC2db8hnRLu9Fl3bkxJyHGR0bNwk2FDQioUrumo8O4ir7vlKDq9m0SVq3ToZ
        wm172gVPu0/lYaYVCzFZ+2JZDaQDER5YKToFaEiBUYkaJfJKH6o6ABdzd/jHwiIdQMWpcZ
        55NG2qD1JetjpbFwaWkmA8hwVyhMLo+5sTd7f1qRGv2PO0G/9RPDsasnvkObaQ==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-49kw4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Abaft: 7b74f557460a748b_1686595522984_2600520566
X-MC-Loop-Signature: 1686595522984:1247224213
X-MC-Ingress-Time: 1686595522984
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.98 (trex/6.8.1);
        Mon, 12 Jun 2023 18:45:22 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4Qg0xF60S0z6Y;
        Mon, 12 Jun 2023 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686595522;
        bh=p6fH8NvQgIzmDqEM/JZU+1fWv6DCo5CmbjF4my4Rkvc=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=CjSNt0/BOQNou5/Vbvky9uCDTKyWQJ8PDhhqRbZrDVhwQpgPyRf6zWxhzdFfusGA8
         bcTH99RuomN+QFpp7OaiOuHAsejhHOVq7wfDcytVx8m8N1syQxgPgmHZK7Wghq41f1
         VVfFamBJQ9KJ0IWAujlO3a+R6X2HCn8BzMaBWHr9n5EY0E91HsyUmeRfgf5bNJwj5t
         hMu00r4+tpR6y6rVVpMh+l6rTPyvN6NgRh+NbzBaiC4k7OR+sRAawy2MGVaiWw3DGX
         Jis6MHbllNdlqgs8WKA2se3MwDx0mk8hLbjYsa/koS76DlLpF6bxNA38bE7MCeMhZG
         69Y+DvNnwr7YA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH v6 0/7] cxl: Support device sanitation
Date:   Mon, 12 Jun 2023 11:10:31 -0700
Message-ID: <20230612181038.14421-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

Changes from v5 (https://lore.kernel.org/linux-cxl/20230526033344.17167-1-dave@stgolabs.net/):
    o Added patch 1 which fixes bogus irq handled scenarios when it's not our interrupt.
      This should be picked up regardless of the rest of the series  (Jonathan)
    o Added security.poll boolean instead of using the timeout member (Dave, Jonathan).
    o Do not explicitly init security.state (Dave).
    o Misc cleanups (Jonathan).
    o Updated changelog in patch 4.
    o Picked up tags.

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

Patch 1 fixes mbox isr.
Patch 2: adds a new security/state file.
Patch 3 paves the required sanitation handling code before actually using it.
Patch 4,5 wires up sanitation + unit test.
Patch 6,7 wires up secure erase + unit test.

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

Davidlohr Bueso (7):
  cxl/mbox: Allow for IRQ_NONE case in the isr
  cxl/mem: Introduce security state sysfs file
  cxl/mbox: Add sanitation handling machinery
  cxl/mem: Wire up Sanitation support
  cxl/test: Add Sanitize opcode support
  cxl/mem: Support Secure Erase
  cxl/test: Add Secure Erase opcode support

 Documentation/ABI/testing/sysfs-bus-cxl |  37 +++++++
 drivers/cxl/core/mbox.c                 |  59 ++++++++++
 drivers/cxl/core/memdev.c               | 138 ++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  22 ++++
 drivers/cxl/pci.c                       |  85 ++++++++++++++-
 drivers/cxl/security.c                  |   3 +
 tools/testing/cxl/test/mem.c            |  52 +++++++++
 7 files changed, 393 insertions(+), 3 deletions(-)

--
2.41.0


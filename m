Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5692CC7EE22
	for <linux-cxl@archiver.kernel.org>; Tue,  2 May 2023 17:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjEBRvD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 May 2023 13:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBRvB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 May 2023 13:51:01 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEFE10D4
        for <linux-cxl@vger.kernel.org>; Tue,  2 May 2023 10:50:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 418236C1454;
        Tue,  2 May 2023 17:50:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B86796C16A8;
        Tue,  2 May 2023 17:50:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683049855; a=rsa-sha256;
        cv=none;
        b=jHs3dEPWRsQLoBt8g0A1cHRa9squUgczhLxoFal2zI7+FFmr9iYAXMdC0Mmb1Co96824LN
        bNF32qq8VV0SrcLq+LFP1NqjynbIdWtyjvK0uWhzD31Myg1h63ZOUmA+hJkmJMnUp+WWh6
        /DWlQpqOoNCTlOtSyP4mXmJvhMPgHZcB+q7YkdcRuFrQ6DdSBIDbWLBcEhjWO7uEslqhwl
        H1Z1qpmWV4blqBo8Q/XU7ADgpwLCuZoy3cUnGhIt/EaGn1saY7wVHXm5W8UI4PmOgCPzTp
        NVLb//wtU2hsr5ZvWCXV0SbMXj0kvG8r8xhgykZsJ281lFx/SjQZdlK/37EkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683049855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=/bt9CuxjdhTVVBFV5BQ8y8DZreX+ia8HfNI/ErNaBNc=;
        b=2WZGxfCv8Pf1i8H8GGYR1FIk4qde/j7wzqxmhUGb1aG1Of0anBzXjT2TWoGeI8QbrGh9hs
        /t7m01t5KDjfUTJkugGaP7dmQRzIkaJbIPAgzMn39CW7t2+7jQyeUCF2IzzYrFDrSPn1un
        ocJ6oDVyE7nuO9LAa72ohS+VIEDGF/ReTXgb/f7d/Vmv/Svc9iVCJvPaYD8dKtAavBRBFw
        ci7x+vSCKC1RP0K2Q6PsNCb68AbfcPj+FkQSHlcLfSYZfxgjuIN1gNB3B9aBTezSIoZ5Fh
        Tf4rpgoRmfJiOhOLCZeXtQdewayDKSOtmdo+jECZmk35wOAny9C0Id310DDpdQ==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-kp57k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Wide-Eyed: 54a72da05f05fcbc_1683049856056_3487379088
X-MC-Loop-Signature: 1683049856056:4128010173
X-MC-Ingress-Time: 1683049856056
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.109 (trex/6.7.2);
        Tue, 02 May 2023 17:50:56 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4Q9ngL6YLsz6d;
        Tue,  2 May 2023 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683049855;
        bh=/bt9CuxjdhTVVBFV5BQ8y8DZreX+ia8HfNI/ErNaBNc=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=V8wucD1gjoCpuf8nTjPYdKXHX+m4kRmYvI/ZlLgMPJ4LGKNZyryfSeJb2wDsXljyD
         MZeU24A2QO9dqIDx8Q7RTCDrOyo5anQGbplCdyJSdS2l6hVRj5Dj1DNiVvBAbqZrZ+
         SDaoB7Q4z3k67xb3KLDxO2JhWskRJWv5TOJqjToCX0PM1pONNQUp5im5m2l6onMsmC
         GVUaPT7EyrkPw5aflxBctEfcS1sGJ0HQg4FxtVVdqWy407VpsRSRDO09UV7Dq03u0m
         yA+qCE67nRSNNDWODkgOJBYDgWhCETBUS3UyWbZP3aYMVO+uuFM+YFb8d9M0WZ5gmG
         qUyXAofAxNq9g==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 0/3] cxl: Handle background commands
Date:   Tue,  2 May 2023 10:18:38 -0700
Message-Id: <20230502171841.21317-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

This decouples the general synchronous approach series to bg commands
from the sanitation changes[0], and is sent as a stand alone series with
the following changes:

o Introduced patch 1 which gives us the correct semantics to wait/wake without
  using queued wait flavors.

o Replaced global waitqueue with per-device wait. (Dave)

o The current tear down is left as is simply because kicking the wait doesn't
  necessarily mean that there is no further waits left (->poll_count), so it
  really doesn't gain us much -- if this is ever an actual issue it could be
  revisited.

o Removed bogus bg return code check at the end of __cxl_pci_mbox_send_cmd (Ming).

o Small cosmetic updates + picked up Dave's review for patch 2.

Currently there are no users, but it is expected that firmware update and scan
media be the first two to use it.

Applies against 'next' from cxl.git.

[0] https://lore.kernel.org/linux-cxl/20230421092321.12741-1-dave@stgolabs.net/

Thanks!

Davidlohr Bueso (3):
  rcuwait: Support timeouts
  cxl/pci: Allocate irq vectors earlier in pci probe
  cxl/mbox: Add background cmd handling machinery

 drivers/cxl/core/mbox.c |   3 +-
 drivers/cxl/cxl.h       |   7 +++
 drivers/cxl/cxlmem.h    |   7 +++
 drivers/cxl/pci.c       | 110 ++++++++++++++++++++++++++++++++++++++--
 include/linux/rcuwait.h |  23 +++++++--
 5 files changed, 142 insertions(+), 8 deletions(-)

--
2.40.1


Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECCBC64ED8
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBXTpA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBXTo7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:44:59 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0402C211FD
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:44:56 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 442845C1FA8;
        Fri, 24 Feb 2023 19:44:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B7A095C1E9A;
        Fri, 24 Feb 2023 19:44:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677267895; a=rsa-sha256;
        cv=none;
        b=z76WwZDlPjcFVwHxyy+RHr7jfSQODIR+wRrBX9Kt2KPBHJWVWins42K9VeEiReYOH4loTR
        SIfskHGP7ZtYrw6zprEwUQwDEPj53kcOGFvHeWzd4ZAJ/F83o9Vvhktvu8w8Yi8e/OGlJ6
        oyWuBcb+Mqs39NdwswmwUgUGi4Q4hBl/ri4Im4+En0lPqOrH49SNslyH7+RhCwHT0rWs5o
        /ZTdcSR27aFk6kc9yKmT4OqQ3l2AKQJgdKXjJN2VKdsYL7ArZdCxN8/d9+NQj2VlnEf3T8
        XRvkcy9sWxXOE9/U1LcIHazZvIUJb9+B3Uzx+VSMOb5M99AD4hC23xyrFOTsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677267895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=XP/ogyZXQ4a+4Sf/XaLCQWXW6WucceZV1WIsSmIb4dA=;
        b=bidiNJ7xc9ppANwSEYWLZLDEJIurrZpBVm5wKTCfFfEB3EZ0g3U5sROCUcmVpsG1oTUgxe
        TgLoaU5FB7vshs0JyRB+CopM7FHR0sKZuJrhZEDx0TbGvYYH7OTupR7Eq0lHHt6lOABGjt
        z+X1VS6DOW1usgARzBrC+D2cXmP+1qj1O/pM8ggqhuKujQT+fuCqSX2/nEqRqJoBvpbAor
        QneMpAqfcc02m7+zeGzOQrXJhI9BnMGgu7i1dxhmx+Xiwjas2uAhuiI4KDpHHPleAF90AT
        kJ7DjmLqtiP8O/AmJZyYFrfjEt/eOiFpbsuRRd2hJHiH7flZLOmi59M2kWbqSw==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-944mv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Society-Tank: 08a40a915daa4587_1677267896059_2320069277
X-MC-Loop-Signature: 1677267896059:1444526532
X-MC-Ingress-Time: 1677267896059
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.67 (trex/6.7.1);
        Fri, 24 Feb 2023 19:44:56 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgMp3GYTzMP;
        Fri, 24 Feb 2023 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677267895;
        bh=XP/ogyZXQ4a+4Sf/XaLCQWXW6WucceZV1WIsSmIb4dA=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=JxjQgwcQOspsLM9yjbgWYG2b8esMZ1j9B4ODQdEMdsQNVbP4k0lZzJGe2IDsCD4jG
         99+qWPkJDDyHSRHGSmV8pDuW1EN7g4arOkuuXGRa0/jph4VtXZZIiq892r/YoT1msR
         vnaAS5syPu36mAriXxSNDDMHNpwrjjud0vxJtWqoJFRPNaZKB4tRwIWF4XgbOzMm1A
         +SEHprU5qGyiDH2cB6kPu1C3/RywbvN1IJOyf/V1XIpwu/R7IsMEmYTnpw0ZPOd+T4
         Uxmd8GKwYk2yssYQNTwjgIheyKZbIiiNbbWsSN9Lk2I2FT2baOWT4yOYYsrUEffRq4
         BTo1y4Y9SrH0g==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jonathan.cameron@huawei.com
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH -qemu 0/3] cxl: Background commands and device sanitation
Date:   Fri, 24 Feb 2023 11:44:40 -0800
Message-Id: <20230224194443.1990440-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

While device sanitation makes little sense for virtual machines, I am
posting this series as it was used to test the driver equivalent in
a sane manner and might come in handy for others.

My hope is that in the future, the background mailbox handling (first
two patches) might be used when other bg-capable commands are introduced
(we already have cmd_infostat_bg_op_sts(), which while updated, it is
untested).

This applies on top of Jonathan's 'origin/cxl-2023-02-21' branch.

Thanks!

Davidlohr Bueso (3):
  cxl/mbox: Add support for background operations
  cxl/mbox: Wire up interrupts for background completion
  cxl: Add support for device sanitation

 hw/cxl/cxl-device-utils.c   |  13 +-
 hw/cxl/cxl-mailbox-utils.c  | 249 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |   9 +-
 include/hw/cxl/cxl_device.h |  28 ++++
 4 files changed, 291 insertions(+), 8 deletions(-)

--
2.39.2


Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87EEC001DC
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 05:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGZF6A (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 01:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGZF56 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 01:57:58 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06F8170D
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 22:57:56 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 20EAD80A2F;
        Wed, 26 Jul 2023 05:57:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9643880598;
        Wed, 26 Jul 2023 05:57:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690351075; a=rsa-sha256;
        cv=none;
        b=FZNb2e8gIDXKoM9eLDXsHFnVpaUKhHHPpwBq13Qt1NKTdEKGZzmRfaomAzI6aUnU16IP8I
        tIubnmzN60hAPT1vBGIgZRwttOEzqnZROK5xFzLKdVr2yy3P5Frz05H1f2ydO3dlkBA66E
        MzB+GDuEA5v03v9w1lCMO1xvDwbtfshfAxSIfLm6XTmSlALgAhWMdYHEG+gy9/78Xaq0X4
        tyKYPkBQDVFvbr8FO3Mxi2riyT6wnVdy5FcdPgjgJm5e6SuipCn3RvIiSL/kSeQWW3ig5k
        hRe1O9elTiBhgAx+fbPAekTeS2Qpv/DTD+T/x/KgBF0xOtAAk9Huz9/of5/EVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690351075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=XSZjBT0ihH3y56O3XcBFhBlnDLXvhpipdrlxCnpTACw=;
        b=SKz0gf9zKyoi3sVzIrX3AGB3/fdADle/CZv86vZu0O54Pa+npwg8FXDh038IuzHG4+w6t4
        LW472LfgYGRgXgewC/HQ5Q0Q5+lz5RoZy4vt3XUwvcxsw550x5f1rLGzV58zb4uP+MGunz
        P9vFrfo1qhYZw2/ceaM9CSk+FXBhveN6Cbm8V8sL5bxrVkFy8ZLPT+qvdpZ0pHWF2KmIyi
        yT+BzaxwgvaXF4eZZXxaLw3+fqmguyyXoWTuM0nt3wtpIfL5UmfLq5O6jIR8r5+EPPNMKi
        G7OGW/QVrnZluQgQ0f1vwAg8vBSCgoO40T0c9AC7kWLihQQIbNrxzmV3979fSw==
ARC-Authentication-Results: i=1;
        rspamd-d58c88954-lj4cp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Continue-Turn: 26b40dae1d2bef23_1690351075876_231895411
X-MC-Loop-Signature: 1690351075876:2852139368
X-MC-Ingress-Time: 1690351075876
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.128.32 (trex/6.9.1);
        Wed, 26 Jul 2023 05:57:55 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4R9jqQ6Jjbz1t;
        Tue, 25 Jul 2023 22:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690351075;
        bh=XSZjBT0ihH3y56O3XcBFhBlnDLXvhpipdrlxCnpTACw=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=L4ZnWIRACnZjbwvk9i0HRhkFT0jjibH+O2kBXOA5p+yIoCCYOZ5Miq/pp0fZBgGSl
         cy5ld7aSTZlc0of0xI6ca8wq56ipwAgMc2H+0Jqg9s21HxfmOOAt8TDjyI3C+uLgYw
         ahxtugyIJFD+7hxTaiJ8RWLg2DR84/PA197F6FZGqhYK2grNPDUBV+EFxo7v8/preG
         FBO2T2+Ev6lKwMPFeYGp6boDvaaLd2taYeDO48HMQ51VvTc304bMmKBVuTNG1sQR4g
         gjZKC5GmzY8gDLi03da1R3a3NHTEIJ0dXQu5K+mF/S7xAbDV9cTJPdjYL8fAutjkdr
         +OCKCHTeLY0YA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, jonathan.cameron@huawei.com,
        fan.ni@samsung.com, dave.jiang@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: [PATCH 0/3] cxl/memdev: Make sanitize interfaces conditionally available
Date:   Tue, 25 Jul 2023 22:19:37 -0700
Message-ID: <20230726051940.3570-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

This is a requested[0] follow up (patch 3). Patches 1,2 are additional doc updates.

Thanks!

[0]: https://lore.kernel.org/linux-cxl/6498c0ec8cc41_8e1782946e@dwillia2-xfh.jf.intel.com.notmuch/

Davidlohr Bueso (3):
  cxl/memdev: Improve sanitize ABI descriptions
  cxl/memdev: Document security state in kern-doc
  cxl/memdev: Only show sanitize sysfs files when supported

 Documentation/ABI/testing/sysfs-bus-cxl | 15 +++++++--
 drivers/cxl/core/mbox.c                 | 45 ++++++++++++++++++++++++-
 drivers/cxl/core/memdev.c               | 19 +++++++++++
 drivers/cxl/cxlmem.h                    | 16 +++++++++
 4 files changed, 92 insertions(+), 3 deletions(-)

-- 
2.41.0


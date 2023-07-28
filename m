Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B01C001DF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jul 2023 17:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjG1Rgy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjG1Rgk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jul 2023 13:36:40 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23754236
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jul 2023 10:36:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CE6DC6C06DF;
        Fri, 28 Jul 2023 17:35:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 630D06C06EE;
        Fri, 28 Jul 2023 17:35:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690565711; a=rsa-sha256;
        cv=none;
        b=AepGveDHwDeTek8jVfwp3gk0FHSkf5TJfeaiut7r2rcI9ZyGcGh51PurDH4jM9kyvKF8LY
        OgfSYJGCn7hJvnRJir3oeSvX1PUJOlLX44Ok8Q0Yti8TYAxdOjP/YBy+diAH72dGUQB9XV
        4JkFpwDRDdwjodo1l4ZC7QMwBetBW6rSU7DJSr5GIeialRXCmENcGQjCEZalTDXeXDM3jb
        geDWz8zFNXtZECr4/5PoXajffUifTN83PqtF2Qhz5WpxBW8m47+8KZuGrQME6n7nLjX2mQ
        8MU8nX0vwayyUDGdaBL0BngDBmLjbWAK6wvJVxeuEHRmtxsKiAnyKXQpywXWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690565711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=chbtMRs88MP1wCxRgYmkI66irEbaxOxhhZjOnTys9y0=;
        b=XdlvtbRzZX6AqbROfM9ZPNDXeUplFrUoxOVcdAqO7yfSt0xV2vrtVR9/UY/TGrPSMzyGt5
        j4rIJ0D3oS0bQycHNbbXpoYrkFd2Ba4ygqTBRj+58zhmOBRM+Jaubf5CchCZEJ0GS/yquM
        CaL9jmTcKCEAC4UoQ2hslqEoIsFhDFo/jREsFwJ8SbOn34YvuztcYEFLNI33fjVbir+/oQ
        409CWxd8Ngapk74VvWKdT9J2Q3n9D/Vs9qS6FGKdg71BTJJ47e8IIEDeLNByqy/sWEUGA9
        frLcT9+/q1otEEEm8St8SXUvwtQKFvVofgVwOQ/PSweE/4qEbZi8Dv+dRuamVw==
ARC-Authentication-Results: i=1;
        rspamd-d58c88954-r6wl8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Zesty-Bitter: 2a8ff9782d7a7764_1690565711657_2852145451
X-MC-Loop-Signature: 1690565711657:709656039
X-MC-Ingress-Time: 1690565711657
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.0.198 (trex/6.9.1);
        Fri, 28 Jul 2023 17:35:11 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4RCFC25yGDz59;
        Fri, 28 Jul 2023 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690565711;
        bh=chbtMRs88MP1wCxRgYmkI66irEbaxOxhhZjOnTys9y0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=KRTEVLJU7H9R3+5ySTGW3S5+6XRPnqodWij7UDWCc1p10YKTv8+tzTbO6eWs85bLz
         fTAxxOIEi24fnPEZzWiU+QW+YRIkQfiHvt/pU6fuINX6fnkmqrtWZy8wv8gctq9I/V
         g4brO4lm/oeqDGLXHRs9gqt4RkQBPMllEXBnNHVbQUkwepdlk/ydXPIajN/3jZTR2p
         5ksgg8t4whu+HzNC4paCAcieij+9bmvR/Chtf6BKJmRjpVr9pnhuJW93HJ3rU/XVyE
         LYv4ZBsVKpJUgdDtsUQDHr9wRAdHOaZhj2yvtA0Y42MPLYU0yF86l7vOuOwQyDpas0
         JqV/j0NX4yezg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jonathan.cameron@huawei.com
Cc:     dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [qemu PATCH 0/2] cxl: Handle GSL Sub-List
Date:   Fri, 28 Jul 2023 09:57:03 -0700
Message-ID: <20230728165705.5889-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

The following is an initial implementation for the GSL sublist
command, which came up while reviewing some of the switch cci
stuff in the kernel. I have not yet finished the kernel side of
this (for which sublist should be a first attempt then fallback
to full gsl upon error/no support), but wanted to get the qemu
side out there at least. Regular gsl remains unchanged.

Applies on top of Jonathan's tree:

https://gitlab.com/jic23/qemu/-/tree/cxl-2023-07-17

Thanks!

Davidlohr Bueso (2):
  hw/cxl: Update comments for Get Log
  hw/cxl: Add the Get Supported Logs Sub-List cmd

 hw/cxl/cxl-mailbox-utils.c | 111 ++++++++++++++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 15 deletions(-)

--
2.41.0


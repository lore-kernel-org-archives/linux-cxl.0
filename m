Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0266AC77B78
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 02:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDWCbP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 22:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDWCbO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 22:31:14 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C626A1BF0
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 19:31:11 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B9FAC881425;
        Sun, 23 Apr 2023 02:31:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 54C768815C4;
        Sun, 23 Apr 2023 02:31:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682217066; a=rsa-sha256;
        cv=none;
        b=E0BkUv9nC9seINFDLDuaiG2Fs+MCGP/9OIkyxM+rHM7EoR5AUACIRZiNs+ybiD/IhXUoKv
        0BmzgPilxI516QgB0nOKu0VTccBlEJ0kdEZ2wTLBuv9TyUm4aT55NDOShJhakN4GB8Gf2i
        tRU0d0QQsHmNXVOaA0cxCRLnXoKhKCln119jFK0WAczNDNzappu+typ6RsemDrfleArUDX
        qkH4cPLYI0PHsFMcdUTxR87iTqzj80AnErrObs51B5wmYnKhBEcvWRDq5dWa7dNgZ6adZI
        E61v1JS1zaOkaO3yihroEFj3K4WgNe4Ei8VRdyaG/b+7veeTndiXhAZ/TXCtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682217066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=kDiuXsfCrFQoHivoD1Sx5SMqldEXuN+tWGa2PMtkQZs=;
        b=FRUpt5vW9fitxy2skw3/RI0I167P/LA1L9cDZ29FM6us/jUZQfQ8yrxxuuym9P3ffnCV1x
        xCxmyKDncQUrG/p038YZ5yrHyk2rBz8dyC3R22HnFmSYikCjSiG+3tiLiIJNsTs7PLcO07
        s+GeCWRsEZtprawFo8GHLYv2+Adn5zi559vzUQ2vvn22n7DmDrRMdqgFBomNuVp61IxXhD
        IJAfkedjl67Vjy7pnjoBfuT3yJD6n+ByOACsVmaGIwmGBgkZbN3L9iSV0dxAOiAhURW8UW
        rhMKTk3Jnp2ZHOqWSXIFzOStRRMZqkVc2F2YOZ88fsvIKgbP9ypYJUzV6640dQ==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-tqw7k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Unite: 7be284793210baac_1682217067577_3635236038
X-MC-Loop-Signature: 1682217067576:3168587399
X-MC-Ingress-Time: 1682217067576
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.45 (trex/6.7.2);
        Sun, 23 Apr 2023 02:31:07 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4Q3sh96JvmzGX;
        Sat, 22 Apr 2023 19:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682217066;
        bh=kDiuXsfCrFQoHivoD1Sx5SMqldEXuN+tWGa2PMtkQZs=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Dxe62yOBZIhrca5bVHU42LwyS+gOr2JdavRMMggLLX/J5W3oa9ABS8EclBqUq/Fba
         Pe7o7F4DxLwBv9eAGh5gMDtO5jd0Tuj81y7aJvrqnrf7A7IGioQHKON5wBIJHQsInj
         541KXZGcVGWM7OdzA4U9+AkRqDJxQR41nfC9xwjDIlW3NsCidP6GCgoxomZuncM6oH
         vJPSYB91Tn9DUjFS1Dm6UBF3NRfjV3H9uaQzCAZy03CqOze+JKxG37LZboGQGCx5+O
         MUUnGYSfQ2x3FMFRmqaOVytRZN8XQk8Ts9lYTZwzdNEETL2thYeUqUt505SBfALtvW
         wglCN1827t8VA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH -ndctl 0/2] cxl: Support memdev sanitation
Date:   Sat, 22 Apr 2023 18:59:18 -0700
Message-Id: <20230423015920.11384-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

These are the cxl-tool new subcommands for device sanitation for the kernel
side equivalent (currently v4):
     https://lore.kernel.org/linux-cxl/20230421092321.12741-1-dave@stgolabs.net/

Obviously the naming of the interfaces are derived from what is currently there
for ndctl. However note that the new cxl wait-sanitize and sanitize-memdev
commands do not rely on pmem security, such as ndctl_dimm_get_security().
However, the kernel does consult pmem security before sending the approving
the operation, so no harm no foul.

This code is also available at:
     https://github.com/davidlohr/ndctl/tree/cxl-memdev-sanitation-v1

Thanks!

Davidlohr Bueso (2):
  cxl/memdev: Introduce wait-sanitize functionality
  cxl/memdev: Introduce sanitize-memdev functionality

 Documentation/cxl/cxl-sanitize-memdev.txt | 65 ++++++++++++++++
 Documentation/cxl/cxl-wait-sanitize.txt   | 39 ++++++++++
 Documentation/cxl/lib/libcxl.txt          |  2 +
 Documentation/cxl/meson.build             |  2 +
 cxl/builtin.h                             |  2 +
 cxl/cxl.c                                 |  2 +
 cxl/lib/libcxl.c                          | 94 +++++++++++++++++++++++
 cxl/lib/libcxl.sym                        |  2 +
 cxl/libcxl.h                              |  2 +
 cxl/memdev.c                              | 73 ++++++++++++++++++
 10 files changed, 283 insertions(+)
 create mode 100644 Documentation/cxl/cxl-sanitize-memdev.txt
 create mode 100644 Documentation/cxl/cxl-wait-sanitize.txt

--
2.40.0


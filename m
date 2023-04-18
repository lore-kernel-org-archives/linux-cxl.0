Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C4C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 17:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjDRRzK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjDRRzJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 13:55:09 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACC24688
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 10:55:05 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1E74F922999;
        Tue, 18 Apr 2023 17:55:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9BF8C922816;
        Tue, 18 Apr 2023 17:55:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681840504; a=rsa-sha256;
        cv=none;
        b=iVBXqL9mK2QEQhTeWUmIaZyahMKB4ntcSVCglSKhImBMRpnydT+sWze/CqWq+JpzSv5qKE
        X14zfBXBE33BUTVHcOW5VoZYDTyhcVDiUi62y6hzXxqEv1cggn8SNKoOp2BX3uhC7/Ikq5
        CdoRRy8RGremxnGsd/8GKCmnys7zPANkeda40+xWN5DnzqOfMSeHuiJjNH+mtAJJlyBScz
        xMpUs5OaFIFhljTr9BaMIJBcZyG3kXFRK+3s8TZ7kff7UaR6jea0uqjqDRPcVQlFcwszTU
        tNTKsKcYp2PPwd05oEqYgjYIckGSFW7k7RUVXXfI4MK2xVmlMv3D1Yjclbb+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681840504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=z6gApAQr1dXdXMOdzZETpM5yCF2kp1J5tmZo0BWYqkw=;
        b=yNGY51IfOOw3z0Jjq4oa06zT9Fl+ATsaDtfZAE+VOScLGio/RU6ZKtFCE5sYiPaYqAiAHn
        61XgDjLbuxnRVJGws9HzV3bxfH4Pf2cP8hAVjSBl7o1IYqRxMnN1d43Ms5eLdwsMhMFN0O
        rVuH/lZgc2vemytW5N4T8LbOI9rjb+wGOVq0YWlr3nZZWAiY+5X72XgZLpTimwAy3eqGKN
        ZMhWuOqjI3FRws4BrUaJJFyGinO3jvaC96npNPyPg++ViB7CpeCpJ/UvZLNYD9n8s8iM6I
        28pjljnzBDBOhW1QSq9DE4lAAGQOQyR5SSziMFPk7vNUE91zFSvd0pWIlsPteA==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-4vvzd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Left-Irritate: 5728cf11589def1e_1681840504918_3503772520
X-MC-Loop-Signature: 1681840504918:3378513722
X-MC-Ingress-Time: 1681840504918
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.102.66.36 (trex/6.7.2);
        Tue, 18 Apr 2023 17:55:04 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4Q1BQb6gtSzC2;
        Tue, 18 Apr 2023 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681840504;
        bh=z6gApAQr1dXdXMOdzZETpM5yCF2kp1J5tmZo0BWYqkw=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=WNlK8dBBbOYj6ydSnSxSoM66NHGOQVtA3HjiKRAIq5iYfAR46lvAbvI9csVs25DqY
         A8wwvXEzhQh4PYUljEG6oHeRbhZXSm79PZKIEXh8EmtCjCy9rH2NT/g4eXFdEZ0jLH
         ODgXg0iJJkkBrmm0/XTxnUpE0+tkjCyi57G7m1FTH8/J3kkUxWCye1BPyHXX1tW1vc
         JjvAUIYZiC2n+juYURihd0Bpl8Jq5UuG1ZBlGPZB/2dy7RZIZzWmJuPYzwCiOmXoJQ
         VhUSjLkueRSOtkXhUJCQrUaPPQ3rlLDLNya637vlySrjtGRXbKVbM3UcLSDczwgmUx
         GNg8uq888QFLw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave.jiang@intel.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 -qemu 0/5] cxl: Background commands and device Sanitation
Date:   Tue, 18 Apr 2023 10:23:32 -0700
Message-Id: <20230418172337.19207-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

This adds support for device Sanitation, per CXL 3.0 specs. While device
sanitation makes little sense for virtual machines, I am posting this
series as it was used to test the driver equivalent in a sane manner and
might come in handy for others.

Furthermore this adds core functionality requirements for the actual command,
the background mailbox handling (first two patches) will be needed anyway
for other bg-capable commands when introduced (we already have a
cmd_infostat_bg_op_sts(), which while updated, it is untested).

Changes from v1 (https://lore.kernel.org/all/20230224194443.1990440-1-dave@stgolabs.net/):

o Patch 1: added missing timer_free() in ct3_exit.
  	   removed define SECURITY_STATE_CHANGE (unused).
	   simplified some of the register handling in cxl_process_mailbox().
	   removed superfluous qemu_log() debugging splats.

o Patch 2: increased msi_n + use PCI_DEV().

o Patch 3 is new, which makes the Media Disabled handling separate from
  the implementation of the Sanitation functionality. This also considers
  arm64 and uses little endian reads and writes (the mbox processing updates
  could follow this series).

o Patch 4: s/overwrite/sanitize.
  	   __do_sanitization() rely on cmd effect (cel) for knowing bg effect.
	   __do_sanitization() uses address_space destroy+init.
	   remove sanitize_running() altogether, instead rely on media state.
	   remove superfluous references to scan media.

o Patch 5 is a new cleanup patch.

Applies on top of branch 'cxl-2023-02-21' of Jonathan's tree:
	https://gitlab.com/jic23/qemu/-/tree/cxl-2023-02-21

Davidlohr Bueso (5):
  cxl/mbox: Add support for background operations
  cxl/mbox: Wire up interrupts for background completion
  cxl/device: Handle Media Disabled state
  hw/cxl: Add support for device sanitation
  cxl/type3: Remove superfluous statements

 hw/cxl/cxl-device-utils.c   |  13 +-
 hw/cxl/cxl-mailbox-utils.c  | 244 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  18 ++-
 include/hw/cxl/cxl_device.h |  44 +++++++
 4 files changed, 309 insertions(+), 10 deletions(-)

--
2.40.0


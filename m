Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D991C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 23:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiCQXmc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 19:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiCQXmc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 19:42:32 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DC617F3C7
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 16:41:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 97D9762142F;
        Thu, 17 Mar 2022 23:41:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 52EE962120C;
        Thu, 17 Mar 2022 23:40:57 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.141.221 (trex/6.5.3);
        Thu, 17 Mar 2022 23:41:12 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hysterical-Abortive: 4f7816777f8bd41e_1647560472456_1919322372
X-MC-Loop-Signature: 1647560472456:931124805
X-MC-Ingress-Time: 1647560472455
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4KKNtw3xW9z23;
        Thu, 17 Mar 2022 16:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647560457;
        bh=eVgPuGpL0U7KhBsaG/37YkuDz2qSpH+gu/f6MFMGNUk=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=OBnaLJIAEXF3xGCD4hA0E4oGUWqdCB//JGg4wVIpOE+awrW+Y4KtjLK0f/ExtaAYG
         FRgZ/G1qo4UwbRMq4FLhW4fPcTZtR8Yl9UxrGdGeEvBv1tBAGBs6xcNkXvuQ9urVa0
         X04UWNc3z3+i93NpvWs08BnceDduJvqgLA7+5INjgsHaSw+2VfsCo9Nw20VChFjqFv
         guaIHWdIXjZnLfn+WLZx0y6MzBS5JS/tpciR5nzDeDP0g168+eF3nGczi3/7exq296
         KtiJN8Jw6qXpjIn6m2nu+J/ReO2GwD3M2v//vAskTBuFjARn4IHQgo78Qn3RwTQK4E
         Q1ytQ2Zid6OTw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net
Subject: [PATCH 0/5] cxl/mbox: Robustify handling of mbox_cmd.return_code
Date:   Thu, 17 Mar 2022 16:40:44 -0700
Message-Id: <20220317234049.69323-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

These are some patchlets that came up while going through the code.

Currently the return_code from a completed mbox command is handled as
either successful or not. This series teaches the driver to better deal
with the different returns from the hardware, allowing better debugging
and mapping to proper kernel errno semantics (which are left unchanged
for now) as well as more ad-hoc handling.

Patches 1 and 2 are small nits.
Patch 3, 4 and 5 implement and use the new calls.

Applies on top of linux-cxl's next branch but have not really been
very tested as I'm not sure how to actually send mbox commands but
thought I'd post regardless.

Davidlohr Bueso (5):
  cxl/mbox: Move mbox_mutex usage comment
  cxl/pci: Use CXL_MBOX_SUCCESS to check against mbox_cmd return code
  cxl/mbox: Improve handling of mbox_cmd return codes
  cxl/mbox: Use new return_code handling
  cxl/mbox: Retry sending mbox command upon RETRY return_code

 drivers/cxl/core/mbox.c | 23 +++++++----
 drivers/cxl/cxlmem.h    | 90 ++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/pci.c       |  7 ++--
 3 files changed, 108 insertions(+), 12 deletions(-)

--
2.26.2


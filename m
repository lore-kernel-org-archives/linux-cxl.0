Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547C8C433FE
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 02:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiDDCOe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 3 Apr 2022 22:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358063AbiDDCOd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 3 Apr 2022 22:14:33 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F125835DD4
        for <linux-cxl@vger.kernel.org>; Sun,  3 Apr 2022 19:12:37 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2C18920F4B;
        Mon,  4 Apr 2022 02:12:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 99D1620FD0;
        Mon,  4 Apr 2022 02:12:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649038356; a=rsa-sha256;
        cv=none;
        b=IMehUMJ+opWyBq6NbnpXm5jCDewMz+LDIM9PSZdofXumQnom/wQer+QCyoWw/cVttUJs7v
        YEPqJmrX8PcOB4xX5pb3GssKQnmOj5IXgvULWnZDpjGGY1Nrvsi69Sc3jtL2W9SJe0SbMc
        EuPxnMiZHulJvr4X7MsXRhidBEdaS76stliziQBMR3qxTjVO9GPf/wkV8oSCWM0wg0bk8B
        mzeQsDYpiBlZ/6wbO27hywF6EOnMm4CaEytDB6Lr+sZyaHFXtnjbuQfxx/Z59n8hiJ9v+z
        xVSVTD0q6a99mu9BlseoZgSiviUQUuQIO8D3IqiK+5x5oCImf/ovKFLd2FXJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649038356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=qPHw1P4q/wSSmLIBzAwFYo5L5ANp2nKQ1P+bskH0gSY=;
        b=xNFcHZqv/F29nF1Wh1Ts6MteHIMlPnzk1YlGIEv9ICN6HAtIiQ2ewgU62PGkm+lFUM0d34
        6f+4jziDDH344k1ein2KSgbCOFJabV4slRQ1oLZfQS/Auon8WeXKBJlaEWZPBg7O2EH4zM
        GwROiREVnivv8gWGszOVzkrhB99zTqwnDWXF5+utFGZ7Dt8NItimcKbq8T3OLxm6Xm5ZoP
        IOmq6KZ2Bpk7zmb2pfAJonq8K6sNrprvvxycWzQ1GZz3O+cLEKBqG10QG9paRFQPBkE0Oz
        Q780JsXzpP/xJnSIB8C1kTM4tVvWVZWAIKsJSsLC9PaoEWbsH3aXpbsmyy+I/g==
ARC-Authentication-Results: i=1;
        rspamd-786f77c8d-mqvpf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.97 (trex/6.7.1);
        Mon, 04 Apr 2022 02:12:37 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Cooperative: 1d43140e65533c1d_1649038356952_1615392169
X-MC-Loop-Signature: 1649038356952:2154232054
X-MC-Ingress-Time: 1649038356952
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4KWvS36KKdz1Pg;
        Sun,  3 Apr 2022 19:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649038356;
        bh=qPHw1P4q/wSSmLIBzAwFYo5L5ANp2nKQ1P+bskH0gSY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=e5bMjg/UoaH8rH31WoMlmJ/v5pk+SIxu0Qcbbx3Q6JfeS5rv1GLXe15fGwK9NF3PQ
         Ru5rg9tdz+qv+rAk1BhfcGh/PDc2afvwgCnXT0C0vM+kZsHyOyT/QjpN3zDTukn+o2
         OODfJWJtc2Tjr9KkPvyF1VqpzVMdLmVIzJ7CbAfIZuhmd5yVxMivwdX4CevyCu+zP0
         eLHNtb+i/ZhMcEBeO4Z1cliQ/ZXHyGhhFR31Lqu+i74lY4f08j0KGyqCv/sKF+lAiS
         HKTlaMoQ4O+AjqJmWyj6SnjNxSMUN3jCcHP9AhC08BpbVi2RXYhxGVGLi0FWNp9i2/
         XYDvnpEfy3aRQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net
Subject: [PATCH v2 0/4] cxl/mbox: Robustify handling of mbox_cmd.return_code
Date:   Sun,  3 Apr 2022 19:12:12 -0700
Message-Id: <20220404021216.66841-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

Changes from v1 (https://lore.kernel.org/all/20220317234049.69323-1-dave@stgolabs.net/):
 - Patch 1 now just removes the lock comment, instead of moving it. (Dan)
 - Modified pach 3 to use CPP hackery + misc table improvements. (Dan and Adam)
 - Dropped patch 5 per concerns about implications with FW. (Dan)
 - Picked up Adam's review tags.

Currently the return_code from a completed mbox command is handled as
either successful or not. This series teaches the driver to better deal
with the different returns from the hardware, allowing better debugging
and mapping to proper kernel errno semantics (which are left unchanged
for now) as well as more ad-hoc handling.

Applies against linux-cxl's next branch.

Patches 1 and 2 are small nits.
Patch 3 and 4 implement and use the new calls.

Thanks!

Davidlohr Bueso (4):
  cxl/mbox: Drop mbox_mutex comment
  cxl/pci: Use CXL_MBOX_SUCCESS to check against mbox_cmd return code
  cxl/mbox: Improve handling of mbox_cmd hw return codes
  cxl/mbox: Use new return_code handling

 drivers/cxl/core/mbox.c |  7 +++---
 drivers/cxl/cxlmem.h    | 53 ++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/pci.c       |  7 +++---
 3 files changed, 59 insertions(+), 8 deletions(-)

--
2.26.2


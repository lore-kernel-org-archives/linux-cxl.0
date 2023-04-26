Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2C3C77B61
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Apr 2023 02:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbjDZCqL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Apr 2023 22:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDZCqK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Apr 2023 22:46:10 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165B1A2
        for <linux-cxl@vger.kernel.org>; Tue, 25 Apr 2023 19:46:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 39749261727;
        Wed, 26 Apr 2023 02:46:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B3E4B261656;
        Wed, 26 Apr 2023 02:46:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682477166; a=rsa-sha256;
        cv=none;
        b=ezprDUC1RpQanbip99OhVTli/qNu0ctNVcXNHJe1k31I98h/VmNRIphQMBMBnRhnjQYDRx
        HpkTBmrlNX8nft/HKa18N0qBbJb6X97O3X/EzBe7ZckUy1hQ4TAEmuwvfCS1ski+OSOygA
        z6GV7q8+rF6KWOfB1MJgZ/+H88HrQS6hDiLEJnYK+RgpFJVFzylWHxMPYI7x5KxK8ZG3F5
        N6cHIkKXPxlAek97iAI8miO5tfRw2alDi2GzO8UloQBjAqT6FPvYE9CTdeYIPfpMFlEeTQ
        YegryfOr6RzewZY/CQ4fX5OTOjEEncFb9+HyAL1xQ9ilyVRDtife0NLkZbaXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682477166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=m7VC9htxFZeD6ozg65NyW08DkgqtisbifQ53rd5xpEU=;
        b=Wk7WuLxSRSiZgJu8VEY5FNLyCtauuia0EurqG4TYP2dgWmdSAT1iTBJIMuqiPknkCkQ7Z7
        MlW6jElNuWV8H6gdTBOuleGoumoqhntVijZgIGmF6hx0B4hTdYxAdWUxzul5OkDNdfOqbI
        bi3wbCTh5TkIxTFv47y+n/LetfWot1+eejrI2yeei4B1FQPnugBOcZaXT/lf7iUPwct8Pv
        8GUsLYo6KD/hcrNOadUEUx1tKH/BYm6J5SAqntsj2A43jT4C3hzksAexQ5OBHbMvLrrJU9
        kyZCFkSx8RsBvFDaS1EGWgL3OtMU/SnEKZCK2fCtmNIuCqcYlAuDIG4KSFvVYQ==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-qw5fh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Exultant: 1594d865425d9ae6_1682477167034_911889535
X-MC-Loop-Signature: 1682477167034:2684523828
X-MC-Ingress-Time: 1682477167033
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.62 (trex/6.7.2);
        Wed, 26 Apr 2023 02:46:07 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Q5jt601zyz9s;
        Tue, 25 Apr 2023 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682477166;
        bh=m7VC9htxFZeD6ozg65NyW08DkgqtisbifQ53rd5xpEU=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=GR6p1WddOeTWFFCjhdpWwI029Cb5CUBG2G3fzLMxrP7/bS49rItkxmVaWxwMLQbT2
         v0HRAuHomnKhyhsxmiHQJpE4SUtR7x58d0ZXB1ZUIrTy6VeK/QcJc16wDwgJ7j5+S5
         PavVIggaK3pVolvoPpoia0Q0X0AbcBu7kcfKNt4X4s8XhFJnra2o0oVeS4u5a6CnA+
         7+3BnrNEE33w4V/eOdwp70hInQLW7l00HLWIVc3Jrj7meS/5C+aGFslJTcjNBFZS6y
         TFH78wCPEO8Jans0ZzXs5zmZfAEXvHzKpwXf9yACj0pqxe7Bi/OP7vvHgxqCa2233+
         l3RVw4CgqItBA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     alison.schofield@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH -qemu rfc 0/3] hw/cxl: Add support for Scan Media
Date:   Tue, 25 Apr 2023 19:14:15 -0700
Message-Id: <20230426021418.10186-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

The following is a very early rfc for supporting the rest of the Media an Poison
mailbox commands, extending what is currently there for background command support
and making use of the poison list infrastructure. The kernel is also pretty much
at the same point, for which the motivation of this series is to help aid any
incoming driver support. Similarly testing is 0 but sending this early hoping for
feedback to at least know if I'm going in the right direction while the kernel bits
are developed.

A few general notes:
 o I have no particular affinity to the values provided for media scan hinting times.
   Feel free to suggest new ones.
 
 o Scan Media will directly update the poison list, with its own special type,
   based on random values (number of new poison entries and actual dpa).
   
 o As with the current poison commands, this needs proper checking of input dpa
   ranges to: 1) ensure it fits within the actual address space of the device
   (ie: compare query_start/len to memdev's  mr->addr through cxl_dstate->mem_size
   ranges). And 2) ensure that the passed range does not span both ram and pmem
   devices, albeit unlikely for the qemu cases.

 o DRAM Event Logs are not generated for every new poisoned dpa. afaict we will
   need to have a scan media version of the qmp event error injection interface,
   as I don't see qmp being usable for scan media.
 
 o Getting the scan results inherits the current get poison list limitations,
   such as limited number of records, so only one call is necessary.

Series applies on top of Jonathan's 'cxl-2023-04-19' branch, which fyi has the
v1 version of the bg cmd support (required for this series), so will require
rebasing eventually:
	https://gitlab.com/jic23/qemu/-/tree/cxl-2023-04-19

Thanks!

Davidlohr Bueso (3):
  hw/cxl: Add get scan media capabilities mailbox command support
  hw/cxl: Add scan media mailbox command support
  hw/cxl: Add scan media mailbox command support

 hw/cxl/cxl-mailbox-utils.c  | 225 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |   3 +
 include/hw/cxl/cxl_device.h |   8 ++
 3 files changed, 233 insertions(+), 3 deletions(-)

--
2.40.0


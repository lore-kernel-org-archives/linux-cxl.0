Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BEDEE57E0
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 07:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjIHHcF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 03:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIHHcE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 03:32:04 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F91BD2
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 00:31:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E173241EED;
        Fri,  8 Sep 2023 07:31:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6416241E3E;
        Fri,  8 Sep 2023 07:31:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694158318; a=rsa-sha256;
        cv=none;
        b=0JEiR7+SyyYcRTdN1ejjMDAl57qnD5nC1RdQzccBSVVKOXbke2Mv+K18f+1HIHKkCfJ75R
        /BjnAHbQ57ts+KRwGz75e6zYid4jZf+oumEuFlWUzR1FUYdmhQx3OfzhohsNgAOqC4ywYf
        y0pB/Ifnq/pyB3sN06ui2wS4LLJy3KiaifTXdXKeSqBZrCmAOO3jGx1EB864ZoXOIXV2rm
        jTR+TFn1OnSVVL5JnuTLLtqH84fIJBbQ+xNjVQ5W3Uzz5m0MQr0Q4ArYM7PgkdcKjsnylb
        DqRK3SdNy/HB8pga03K5Bu1mZzEeeA3GmnbFbEW1+0b3HDGKeNgImdJUXcrxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694158318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=rwfVY5qMYUEhxSrSTiDNYGyvBZzBGZAwUOFQO2GA3Sw=;
        b=ULWS5hjOZc2FTpIeicMggTrYb2gAESTvYlAGQsFJTTnCujHJcg9z98dvIzbrU+voNRyKk5
        k+KHmzeEzg/D0vxmZHEzduuYCMIXFhacBBPh5AJLhdgVHZbwvojexzg64c+GzYNPZZw1IA
        tZHl6PCwt0aKsiTzOJKlVHUeyBm5qJkHZRbfbc1+zGbSNWj0n4gQbWqv2cFh1XOu+33Xp9
        HTqYkKj8neguPGQsy8lVICUGBpbbboh56SpF2uMd0VUOKmZNSYI9gpHqZNhpQUK3xuaLdE
        mOn/ulVh6xm1gCuaojC8bb/lnn4MSFaMY++0eWABcrpeiMUcKbJ5w5YSaNOOQQ==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-6jtrk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Troubled: 3f0945f7502cef9a_1694158318703_731339323
X-MC-Loop-Signature: 1694158318703:3081047107
X-MC-Ingress-Time: 1694158318703
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.184.238 (trex/6.9.1);
        Fri, 08 Sep 2023 07:31:58 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Rhnqd58G5zK4;
        Fri,  8 Sep 2023 00:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694158318;
        bh=rwfVY5qMYUEhxSrSTiDNYGyvBZzBGZAwUOFQO2GA3Sw=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=FpdVTnmxIwH50UYr6uhckD/zWGY5gU13xX+LQpCvHL6kTsFpmd4ohqXHnjuKoZXpO
         RmfU65nqfgT8Dh/0gmvgrayZDwFm503EaQds/U7/F4532z7IOJlr5MkEPt+54Hfp/p
         C+/zMTqj5dSwB2LBiait4xC6AIyCceD+qHDI4ZYAEpd3vrIrmQ1wlEnVFt8uoxF3dw
         lcUwB2K/xinM9ZZ+vBpfg5DCwQy+DoKddnSC6S0VI7P8fA9YjzSozGLybRh6irpcIT
         5iy+BO2KR6eTh9bPAmIe3Z+eYqqn+7QTVAFwsWd+CHf6+2wKhZkaT0NreAGVrEkFwG
         6a8OI2thMhMGw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     fan.ni@samsung.com, dan.j.williams@intel.com,
        alison.schofield@intel.com, ayush.m55@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH -qemu 0/4] hw/cxl: Support for scan media
Date:   Fri,  8 Sep 2023 00:31:48 -0700
Message-ID: <20230908073152.4386-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

Patch 1 is a fix I found which should be picked up regardless of
the rest. As a side note, does it make sense to have a clear poison
equivalent for the qmp interface?

This is a (tardy) followup series to the rfc version[0]. With the
exception of the get scan media caps, the whole thing has been mostly
redone to 1) just use the qmp interface we have for poison injection and
extend it to add to a backup list when the poison limit is reached; and
2) The valid address range chunks obtained by scan media are moved from
the backup to a results list, which in turn is consumed by the get scan
media results operation.

As with the current state of things, DRAM Event Logs are not generated
for every new poisoned dpa.

Applies against https://gitlab.com/jic23/qemu/-/tree/cxl-2023-08-30

Testing - I hacked up kernel side equivalent to trigger the scan:

1. With an imaginary poison limit of 2 and 5 poisoned dpas.

<get-poison-list>
cxl_poison: memdev=mem1 host=0000:0d:00.0 serial=0 trace_type=List region= region_uuid=... hpa=0xffffffffffffffff dpa=0x800 dpa_length=0x40 source=Internal flags=Overflow  overflow_time=1694153028389446574
cxl_poison: memdev=mem1 host=0000:0d:00.0 serial=0 trace_type=List region= region_uuid=... hpa=0xffffffffffffffff dpa=0x200 dpa_length=0x40 source=Internal flags=Overflow overflow_time=1694153028389446574
<scan-media> + <get-poison-list>
cxl_poison: memdev=mem1 host=0000:0d:00.0 serial=0 trace_type=List region= region_uuid=... hpa=0xffffffffffffffff dpa=0x100 dpa_length=0x40 source=Internal flags=Overflow overflow_time=1694153028389446574
cxl_poison: memdev=mem1 host=0000:0d:00.0 serial=0 trace_type=List region= region_uuid=... hpa=0xffffffffffffffff dpa=0x80 dpa_length=0x40 source=Internal flags=Overflow overflow_time=1694153028389446574

2. With an imaginary poison limit of 2 and 3 poisoned dpas.
<get-poison-list>
cxl_poison: memdev=mem1 host=0000:0d:00.0 serial=0 trace_type=List region= region_uuid=... hpa=0xffffffffffffffff dpa=0x400 dpa_length=0x40 source=Internal flags=Overflow overflow_time=1694153398720616022
cxl_poison: memdev=mem1 host=0000:0d:00.0 serial=0 trace_type=List region= region_uuid=... hpa=0xffffffffffffffff dpa=0x80 dpa_length=0x40 source=Internal flags=Overflow overflow_time=1694153398720616022
<scan-media> + <get-poison-list>
cxl_poison: memdev=mem1 host=0000:0d:00.0 serial=0 trace_type=List region= region_uuid=... hpa=0xffffffffffffffff dpa=0x100 dpa_length=0x40 source=Internal flags= overflow_time=0

Thanks!

[0] https://lore.kernel.org/linux-cxl/20230426021418.10186-1-dave@stgolabs.net

Davidlohr Bueso (4):
  cxl/type3: Fix crash in set_cacheline()
  hw/cxl: Add get scan media capabilities cmd support
  hw/cxl: Add scan media cmd support
  hw/cxl: Add get scan media results cmd support

 hw/cxl/cxl-mailbox-utils.c  | 298 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  24 ++-
 include/hw/cxl/cxl_device.h |  10 ++
 3 files changed, 317 insertions(+), 15 deletions(-)

--
2.42.0


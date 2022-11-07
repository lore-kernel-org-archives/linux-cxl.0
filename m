Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5689C433FE
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Nov 2022 18:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiKGSbz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiKGSbx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Nov 2022 13:31:53 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CBF1F9E9
        for <linux-cxl@vger.kernel.org>; Mon,  7 Nov 2022 10:31:51 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6DBD4541A98;
        Mon,  7 Nov 2022 18:31:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a282 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B8F6F5421D7;
        Mon,  7 Nov 2022 18:31:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1667845909; a=rsa-sha256;
        cv=none;
        b=L8hDvy0NPDoPqGGOatYo3MdQS2UIplmhSj+El0dT+8CTnlOwXs+XnXodzen82+5vfgba6D
        H1pvTnLq04LUp/Kd84dDBpio1eU3CtJrK0QcuUlwX2y1luTmJJAj84oDdyFggJYZTIgILz
        uaTJwbD8gh7tPQtSqY6NdAIxG9Ym8UJYEF8SOUGQ5ykaheBJCdUQ057a/umDXnmm5V6Zhj
        OGBoenR/EYOmzfWPM/f282kjJR/ubgZJhqzooSGxo9ldW0zUM1Z2mlfi58H63+hL4jY6Xl
        T3T2I/4Y/wAYfYoVFu/L+2hLQzCjPrG9kYkTDgEB2XBlBhlVtnsvyCLYHdwe4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1667845909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=vvvSV3j86QKkTx8cOKSuOi44fpjajXBwkUWf7K/nmTk=;
        b=LG1Jsk1VF5Sk2daj5Q7/5hqE+O6cIaPP9skqUdFfKRyZx55oJAmVedhfpurPJq3fApF+oi
        12pecBc2zp8064Vw+AwzjMjq/NDB+Wurso+om7oHe6cN3wiucpBhtuW7yoSxTR5gL60INX
        SidiHZwjb9ako7gcZonRc+1vPbE6haOQAIbP36/uQ945MoEmBW4Holj0FZNcJkZJFg6BTD
        DZ5+hkPt3YR26roKhSnbPJPv9Cqs9trXiiVnF1qwSwy8ofw98lD4EBw39Z6VC4WeJdaexV
        KdLdO0R8sk0c73jVQw1dpDskn+5kvpJ3D24jaEABTv5wPk5nNUxRDTFZJL8kkg==
ARC-Authentication-Results: i=1;
        rspamd-5cb65d95c4-8pxgs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Arithmetic: 4a16206f1279a68a_1667845909226_1453098664
X-MC-Loop-Signature: 1667845909225:1472000495
X-MC-Ingress-Time: 1667845909225
Received: from pdx1-sub0-mail-a282 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.105.95.137 (trex/6.7.1);
        Mon, 07 Nov 2022 18:31:49 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a282 (Postfix) with ESMTPSA id 4N5fvm218Cz3V;
        Mon,  7 Nov 2022 10:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1667845908;
        bh=vvvSV3j86QKkTx8cOKSuOi44fpjajXBwkUWf7K/nmTk=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Ry7v9d/0wxN1jdUAfBREbHmutvXf3dhM3/ocsEhR891V8RezSQtsgc4+AYlpb0aTm
         meLZo0CiFzTpMAAipr9hkkacUO+FqjmW7CE7rOdU8Vehr511+J3E1A/czNc7bcGPTP
         ekC/o/WMHAwUktZvgPFMelg4d0d9WJipNwzpJ4uPGum/K7G9cYOeydabeZ9hv6ZzwD
         j92ghVDwoWm4ghUnsOyiaXEyT6JlD/JRhaYoD7xQ80G94i5959IOI12c4MOUVoAVAe
         mmX1enoOmgmTCqkSxpfrL+abnng4JmmTBmD1t4sZB1UmkeTnyebs84bl9qrZ3XpSLj
         QCU3tQ732vAnA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jonathan.cameron@huawei.com, mst@redhat.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH] docs/cxl: Fix some typos
Date:   Mon,  7 Nov 2022 10:09:23 -0800
Message-Id: <20221107180923.27072-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Found while reading the doc.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 docs/system/devices/cxl.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index abf7c1f24305..891bbd65d9d8 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -83,7 +83,7 @@ CXL Fixed Memory Windows (CFMW)
 A CFMW consists of a particular range of Host Physical Address space
 which is routed to particular CXL Host Bridges.  At time of generic
 software initialization it will have a particularly interleaving
-configuration and associated Quality of Serice Throtling Group (QTG).
+configuration and associated Quality of Service Throttling Group (QTG).
 This information is available to system software, when making
 decisions about how to configure interleave across available CXL
 memory devices.  It is provide as CFMW Structures (CFMWS) in
@@ -98,7 +98,7 @@ specification defined register interface called CXL Host Bridge
 Component Registers (CHBCR). The location of this CHBCR MMIO
 space is described to system software via a CXL Host Bridge
 Structure (CHBS) in the CEDT ACPI table.  The actual interfaces
-are identical to those used for other parts of the CXL heirarchy
+are identical to those used for other parts of the CXL hierarchy
 as CXL Component Registers in PCI BARs.
 
 Interfaces provided include:
@@ -111,7 +111,7 @@ Interfaces provided include:
 
 CXL Root Ports (CXL RP)
 ~~~~~~~~~~~~~~~~~~~~~~~
-A CXL Root Port servers te same purpose as a PCIe Root Port.
+A CXL Root Port servers the same purpose as a PCIe Root Port.
 There are a number of CXL specific Designated Vendor Specific
 Extended Capabilities (DVSEC) in PCIe Configuration Space
 and associated component register access via PCI bars.
@@ -143,7 +143,7 @@ CXL Memory Devices - Type 3
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 CXL type 3 devices use a PCI class code and are intended to be supported
 by a generic operating system driver. They have HDM decoders
-though in these EP devices, the decoder is reponsible not for
+though in these EP devices, the decoder is responsible not for
 routing but for translation of the incoming host physical address (HPA)
 into a Device Physical Address (DPA).
 
@@ -209,7 +209,7 @@ Notes:
     ranges of the system physical address map.  Each CFMW has
     particular interleave setup across the CXL Host Bridges (HB)
     CFMW0 provides uninterleaved access to HB0, CFW2 provides
-    uninterleaved acess to HB1. CFW1 provides interleaved memory access
+    uninterleaved access to HB1. CFW1 provides interleaved memory access
     across HB0 and HB1.
 
 (2) **Two CXL Host Bridges**. Each of these has 2 CXL Root Ports and
@@ -282,7 +282,7 @@ Example topology involving a switch::
             ---------------------------------------------------
            |    Switch 0  USP as PCI 0d:00.0                   |
            |    USP has HDM decoder which direct traffic to    |
-           |    appropiate downstream port                     |
+           |    appropriate downstream port                    |
            |    Switch BUS appears as 0e                       |
            |x__________________________________________________|
             |                  |               |              |
-- 
2.38.0


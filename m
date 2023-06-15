Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD71EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 00:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFOAwN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 20:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjFOAwM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 20:52:12 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694F1BE3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 17:52:10 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3FB6988290D;
        Thu, 15 Jun 2023 00:52:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a253.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 53738880D2C;
        Thu, 15 Jun 2023 00:52:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686790328; a=rsa-sha256;
        cv=none;
        b=1bnGn9TbHWQIbY1jCHeaYN23M3T3bNLPi39uj/eqaUQM4jW4IgeY//bCoyoUeI3yKvUp1i
        CxxdiqoDFnkS3fbbVkef6aRnzVyYA918PYZzVQYE/H18yxLIHAN3D1Z+GW2ESLTHfJfUG2
        P2wBoXjaMkVCGClD6orATMnMb2D+UNzpspfHCm2XRd+f50pfdQZsT6ZA2d+icChrMxtWmg
        MI2YtMw0wWfvJmI/bXp9IxHk8xuX/szKAy6qHOspRfE+ZUk4VGcm5uTPLNm4H3MqK7kHsl
        BKvOCD2Hv1yjK4xwdubtAyi/oc+J/dtkKQ5W3Iovm9bjhbVTL2P1T9rl0lG4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686790328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=i2BYmRcXV3UxeollC+fZ7Ou00wZ4822rq9LxA2bYzwg=;
        b=p92yufy4+76OAIuLWYbirqPoOgw/dQQ8rsl6NPcG56SCNKuMc5WaNf8nH6iq2Q0uSXd4K5
        R4GyhfdjWxuZ1dwBD62n/RgateC6NPlXjZlgTL6gUqFL3NJv3H0auHPPBKezTZDgrKmbOP
        SwqUPCzMxVlsEv1FG5CMsLT4qJBP/aJbdfasM55sKXRIzZMCxg7X1dRHTkfrCFKBr57hXD
        pI+7mMsMah2J99xOn3uy7VhawKj6oRXHzosHI1dMKcRoHaBpVDIUNbJ8zU7Tarm6U/aBi8
        R0X8Xzxv8x7oo7UcpeUbdHlsldryGvWnZ/cLAilxnK2qZTtK6kcnM9OyoMjM9g==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-vd55d;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Versed: 692d69bb41759f96_1686790329004_117822117
X-MC-Loop-Signature: 1686790329004:263332199
X-MC-Ingress-Time: 1686790329004
Received: from pdx1-sub0-mail-a253.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.120.43 (trex/6.9.1);
        Thu, 15 Jun 2023 00:52:09 +0000
Received: from offworld (unknown [172.58.19.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a253.dreamhost.com (Postfix) with ESMTPSA id 4QhNzV5wHPz9g;
        Wed, 14 Jun 2023 17:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686790328;
        bh=i2BYmRcXV3UxeollC+fZ7Ou00wZ4822rq9LxA2bYzwg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=dlURHfyDbn6RPndKmhlcRg8FQWqadycClVwEIvKfdQA2HIU+dXEMjNuQZ2bSpIEIh
         TorxAYHickdeKlldbpkgoIAB2W/79Sxe/4JxI16xB8q1z8GSguEy7MrM2+kTm1YwTj
         SV5cavyrN37AMRhZJYBvTsbwk3apo0L2X6HlCtfgB58WFcoMLvzlghWeO/92LjFdgF
         sCBtJw6l/QBJyxwqr4/AVkFwF3fOZ+QtuOJVdwBSUStXZoqEjLFKMIB6X/VMQKy8yU
         mHEboCV+9kWwzcD+14xbT2sKxpHbOyv6MuyWVZDdWVWIRX2BlaZEk0SPFM+5G7CS1c
         p0CyngN8jwULA==
Date:   Wed, 14 Jun 2023 17:17:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org, linux-mm@kvack.org
Cc:     dan.j.williams@intel.com, a.manzanares@samsung.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        dave.jiang@intel.com, vishal.l.verma@intel.com,
        gourry.memverge@gmail.com, terry.bowman@amd.com, rrichter@amd.com,
        viacheslav.dubeyko@bytedance.com, sheshas@marvell.com,
        dave@stgolabs.net
Subject: [ANNOUNCE/CFP] CXL Microconference at LPC 2023
Message-ID: <a4c2gx2tnm4ckax7qkx2trnvmqjssfytc45sb2zikuayd2marc@rpsjp4icgsvn>
Mail-Followup-To: linux-cxl@vger.kernel.org, linux-mm@kvack.org, 
        dan.j.williams@intel.com, a.manzanares@samsung.com, Jonathan.Cameron@huawei.com, 
        fan.ni@samsung.com, ira.weiny@intel.com, alison.schofield@intel.com, 
        dave.jiang@intel.com, vishal.l.verma@intel.com, gourry.memverge@gmail.com, 
        terry.bowman@amd.com, rrichter@amd.com, viacheslav.dubeyko@bytedance.com, 
        sheshas@marvell.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

I am pleased to announce that we will have a CXL MC this year at Plumbers,
and hereby invite the community in our call for participation.

https://lpc.events/event/17/abstracts/1453/

Compute Express Link is a cache coherent fabric that in recent years
has been gaining momentum in the industry. CXL 3.0 launched just before
Plumbers 2022 (where very early discussions were had), bringing new
challenges such as dynamic capacity devices and large scale fabrics,
two features that bring significant challenges to Linux. There has
also been controversy and confusion in the Linux kernel community
about the state and future of CXL, regarding its usage and integration
into, for example, the core memory management subsystem. Many concerns
have been put to rest through proper clarification and setting of
expectations.

The Compute Express Link microconference focuses on how to evolve the
Linux CXL kernel driver and userspace components for support of the
CXL 2.0 spec (and beyond). The microconference provides a space to open
the discussion, incorporate more perspectives, and grow the CXL community
with a goal that the CXL Linux plumbing serves the needs of the CXL
ecosystem while balancing the needs of the Linux project. Specifically,
this microconference welcomes submissions detailing industry and academia
use cases in order to develop usage model scenarios. Finally, it will
be a good opportunity to have existing upstream CXL developers available
in a forum to discuss current CXL support and to communicate areas that
need additional involvement.

Suggested topics:
- Ecosystem & Architectural review
- Dynamic Capacity Devices
- Fabric Management
- QEMU support
- Security (ie: IDE/SPDM)
- Managing vendor specificity
- Type 2 accelerator support (bias flip management)
- Coherence management of type2/3 memory (back-invalidation)
- P2P (UIO)
- RAS (GPF, AER)
- Hotplug (QoS throttling, policies, daxctl)
- Hot remove
- Documentation
- Memory tiering topics that can relate to cxl (out of scope of MM/performance MCs)
- Industry and academia use cases

Proposals can be submitted here, by August 6th:

https://lpc.events/event/17/abstracts/

For more information, feel free to contact the Compute Express Link MC Leads:
     Davidlohr Bueso <dave@stgolabs.net>
     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
     Adam Manzanares <a.manzanares@samsung.com>
     Dan Williams <dan.j.williams@intel.com>

Thank you.

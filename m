Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4F0E82CB7
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Sep 2023 01:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjI1BWJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Sep 2023 21:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BWI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 27 Sep 2023 21:22:08 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B134AAC
        for <linux-cxl@vger.kernel.org>; Wed, 27 Sep 2023 18:22:06 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CB7F714148A;
        Thu, 28 Sep 2023 01:22:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 01E611414EA;
        Thu, 28 Sep 2023 01:22:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1695864125; a=rsa-sha256;
        cv=none;
        b=j2+UrbeIhjCAQVxZH5ZiBbz7i6nw3tMtrzv+loVLjgSSJkRdCHX/AwZaRHmwwp/4/1rGZa
        eAY3R5ht55CfixWHrLjD44sXf/s7A1x1kG7MGFqEim6KuvZZ13SkvzBXnuX6tbkWVHUC87
        J6WMweTfLyqv1ivhS4oZMmwLNB4Mlu8JQOtYKlcdUfzzw5nSNDI2dxd6gFWQoiMxEmf4Hv
        pMHSjMiSoehEAo+ZphhqIHFsivR5uCLet40VRTfvPqOuoIr//xQbvTJDyBfIbj9K4AbVOs
        F/z5da4iUH2IKx9/U4VPaX8yORuCl6hnp5A68IsiWfVr2lSIum2dW3TI1TPm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1695864125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=JMHlC8xSeOnNJ7rzwM+nVeQVW8kpWm/uACyuS4OPuMo=;
        b=b6TOVdHWvCYFd/r+t+ObvS/8Ydf/xeeyUJc6rBZtX/rBiVtnszlu7eAq97zMs4Z8XNPJc7
        MWBFWOqk6ZTsycKh9N9WZdK0rjGErDj4ramXkFGatzOTY2j3YWTtjgK+PI1U/pUlBX5Uzb
        4zRzZsEv8pSyJsrGLg4WfkEJp7exdDzNl7EfqS4AtfCIS9oNNrow70h5jo7nAdrKVUEO4n
        qzIVd+10v4sPT+PvLDh14+7fIJa+XuVTZlXY/R/w/Y/Ncv+5LWRFa1Qjjiz9z06wk09eGm
        S4+7trJ03ZA2IdbA10amjcQCDAUXtSu06EDddV4ks/IeXpdLvD4eC45/5oNQwA==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-7f65v;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Befitting: 4045f01152e806d8_1695864125612_744855131
X-MC-Loop-Signature: 1695864125612:3739795391
X-MC-Ingress-Time: 1695864125611
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.94.6 (trex/6.9.1);
        Thu, 28 Sep 2023 01:22:05 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4Rwwgc11TnzDV;
        Wed, 27 Sep 2023 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1695864124;
        bh=JMHlC8xSeOnNJ7rzwM+nVeQVW8kpWm/uACyuS4OPuMo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=bO3dmebTx6Jtr89IN/gI6/hbTY2/IOtooSJxR77xU6oKojo/vwQ7z8hwd5l1FEVpL
         bb62vp5TM2PF46Hny9R5y3Yf5EPueEmESclukOsaohtoeLnYT3N5BVv3LDJ/qrUCS0
         QQatQQ7B8LrRqasPemL8BpFkjfEF6w400MbroLdwfGEgAyzRUrSkmzjJSHHW0CmmIy
         CdV/TChLsbGsNgaJcE5KjsV8bcS85LttPyQF5HnE9rkeeU6+yENrszCWU/Z69PO8Gx
         rDBk56vUyLKovZvawlisPkFpFprz8NIdqZp2c4Gm/lH3OdvQ1FCr6UnhLuBVH/7oMh
         b54Ose0isv62Q==
Date:   Wed, 27 Sep 2023 18:22:01 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, deepak.ukey@samsung.com, sathya.m@samsung.com,
        d.palani@samsung.com, fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: Add Support for Get Timestamp
Message-ID: <hnzwosb3ai52vo6pgn7l3nlwg7yw66khck5amo5oznrmwtudx7@oomtvpofu67r>
References: <20230829152014.15452-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230829152014.15452-1-dave@stgolabs.net>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

ping? Unless any objections, can this be picked up?

On Tue, 29 Aug 2023, Davidlohr Bueso wrote:

>Add the call to the UAPI such that userspace may corelate the
>timestamps from the device log with system wall time, if, for
>example there's any sort of inaccuracy or skew in the device.
>
>Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
3B>---
> drivers/cxl/core/mbox.c      | 1 +
> drivers/cxl/cxlmem.h         | 1 +
> include/uapi/linux/cxl_mem.h | 1 +
> 3 files changed, 3 insertions(+)
>
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>index ca60bb8114f2..2444faac1e4c 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -63,6 +63,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
>	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>+	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
> };
>
> /*
>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>index 706f8a6d1ef4..ec6dfcc7bb99 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -500,6 +500,7 @@ enum cxl_opcode {
>	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
>	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>+	CXL_MBOX_OP_GET_TIMESTAMP	= 0x0300,
>	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>	CXL_MBOX_OP_GET_LOG		= 0x0401,
>diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
>index 14bc6e742148..42066f4eb890 100644
>--- a/include/uapi/linux/cxl_mem.h
>+++ b/include/uapi/linux/cxl_mem.h
>@@ -46,6 +46,7 @@
>	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
>	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
>+	___C(GET_TIMESTAMP, "Get Timestamp"),                             \
>	___C(MAX, "invalid / last command")
>
> #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
>--
>2.41.0
>

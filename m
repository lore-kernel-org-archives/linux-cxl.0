Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6B2C678D4
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 21:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjCAVOQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCAVOP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 16:14:15 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BEA4615E
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 13:14:14 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4E467541DE3;
        Wed,  1 Mar 2023 21:14:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a269.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CCAE4541C41;
        Wed,  1 Mar 2023 21:14:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677705252; a=rsa-sha256;
        cv=none;
        b=6DGdzSIaRdHn+ZGYJJQitpFkTxhFYuRY8yhRmSgGU/g0DeZLW5JQM6QUthGsV07yhdhjII
        mft+o28pF0EPUZjaiZKR8wVyzvIDXIGZBovrUpU3iZnyqh4U8WQ6lEiY5uHfIpM0TKtzn5
        JtRF4sGsLb5zkn61eIBYHX8XCYm1ZeSfx/2V907xVtCcCyotbLbHxH1pRSKMbGMH0ryWaQ
        sOpb0BjM/2EDw2rtW3dEQujOEAqRQc6oX8w8Mu8XJCESJwj0TP/I7VpwkoddT/3OSNxBtA
        ZyZ7UHAvaUQrlLF0kzt0FyB0vrPZ+hTJINiy1+p6HB6P57qItksKAfMkBIrF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677705252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=24jgCb4xdeMvhuoKYDkTrPFC25b9Co9AlfsM3brxxnQ=;
        b=pUzhc8+uqL/EbxziVpePSksL4AQN9Vko0+M/9xvr1m4iopMTAFQWaBMIGzd6F06/3rN3yo
        CVKq5g5VAPCixGzDqrG/MgCph4U6qlXH0WQpSUZcGUwHMch6jgEs/vFlyWq3FKmqLVuoTE
        QgHUTh9dbVbTJyP7dU8o0zyqbbGefdZ7PSo7FK8AD9lXlBAKNAf0VYAsx1OWfuoRHu7pSa
        /zFnnsv3antFJVsVSG+0TUOboTWswmwVPvyHP1UDjchWQFp1e2ajKaLQeFlZqqQVbxVQHT
        hLKr4R68Vi5C8d8blEcFRhnIMtFDWXQ4p5PVI+VzDY4xZK0WHJxVmV2Y761yFw==
ARC-Authentication-Results: i=1;
        rspamd-fd4f5fb8c-mzkcs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Quick: 43a25d5d557a255e_1677705253108_2524863724
X-MC-Loop-Signature: 1677705253107:1112117442
X-MC-Ingress-Time: 1677705253107
Received: from pdx1-sub0-mail-a269.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.227.148 (trex/6.7.2);
        Wed, 01 Mar 2023 21:14:13 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a269.dreamhost.com (Postfix) with ESMTPSA id 4PRn6X1VDSz59;
        Wed,  1 Mar 2023 13:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677705252;
        bh=XoRwMkTCO36fVYwdSRndhRrFHDlR90xt3WeD89nRxN8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=C1Z5p7HVaCj3Ih7GXc0WfCbXVb+WHWFy/FtTiKsji0ipV9tLPqWoQkLLMMT7kUpM0
         OsiCvAMXPtaEH2Swmx8IbmoBk0G/UKUvWeGwixCuxwBfhODZIE7WUzPz09A4l6sNu1
         U8CDhknHATpQa7iN/hpp0actGDTBEq3LH8Fnz91wMRush7v0QclN+StbFjpwVk6iCQ
         jmOSkq1VZNManTu1Y7nmR1s19HLxRacMMQlFzVbh6U2Y63Wi7JkwLD95IwSjXhdHhu
         C/A/AZjoz2fHDfDRHltQ3Vicqy9/gAQW1uV+XNGLZYMxaL8sTIJn4PANmpRLxw2kh4
         T4XjjXzwiD6IQ==
Date:   Wed, 1 Mar 2023 12:45:27 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Fan Ni <fan.ni@samsung.com>
Cc:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mbox: Add support for background operations
Message-ID: <20230301204527.ug4wvciq6dvlvdmo@offworld>
References: <20230224194443.1990440-1-dave@stgolabs.net>
 <CGME20230224194502uscas1p2674510e3a54bddc824f5fcac7719f3ce@uscas1p2.samsung.com>
 <20230224194443.1990440-2-dave@stgolabs.net>
 <20230301190047.GA1421354@bgt-140510-bm03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230301190047.GA1421354@bgt-140510-bm03>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 01 Mar 2023, Fan Ni wrote:

>On Fri, Feb 24, 2023 at 11:44:41AM -0800, Davidlohr Bueso wrote:
>
>One minor thing. See below under bg_timercb.

Thanks for taking a look.

...

>> +
>> +        qemu_log("Background command %04xh finished: %s\n",
>> +                 cxl_dstate->bg.opcode,
>> +                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
>Seems ret will always be CXL_MBOX_SUCCESS, maybe bg_status_reg?

bg_status_reg is still set to ret, so it doesn't make any difference.
Overall I saw little reason to ever return anything other than success,
most of the code checking against CXL_MBOX_SUCCESS is mostly a formality,
for if this ever changes.

Thanks,
Davidlohr

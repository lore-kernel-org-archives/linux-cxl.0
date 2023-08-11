Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599D7C001DE
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 16:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjHKQhF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbjHKQg4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Aug 2023 12:36:56 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 09:36:54 PDT
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231C1114
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 09:36:53 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5F98E7A168C;
        Fri, 11 Aug 2023 16:28:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CBC2E7A0FF0;
        Fri, 11 Aug 2023 16:28:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1691771289; a=rsa-sha256;
        cv=none;
        b=7gnzb2t8wMHU0A2cS5RIyRAKoIWPCYXXMDOY/cHB1rkDM08UxJYJS0ivHh4YQdRkPvIBik
        FEaWyRGZV4MUZ6sRsw+/bE4wxZvzJpP/14KFTiHaTPVt+AVMFLey1UV4UfECKkhdMmeo0m
        UssCzrNxTuvVD4hDY2Q2ze28SCCVy3orR9MmFgU5xnkBbpJdSmURAHbsGpTNpIHv0iFwKi
        Ul61TgIxbl+NK+kEvZA9g1bkdAC8ef2tTBesvt85UHtqBu4uaWbWgIAcLq6jc+Yj/gAhCL
        A65SIxTPKjj1hy0IP2GMSSpLmx07uqSA7QPakXzmjUsojJtsy94E9ykTj97LTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1691771289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=C4g7z4/WJLDurewCEJvZ0ttPCUZycEGsj+JDCsmxwqk=;
        b=aTsiWWQ9QuaKFav7iyEB+JWNkIcKKFTnMgTpqo64Fg0QILzvn99n5nI4INLJaqnbKb4xai
        ijbTD8wcEMFiy44IuRR+BqpZzpzVqEdCRZyC9OKjeLKhNtcXT5jPRTdvJtG0EQMoHxg9Kx
        fHoUhpI6MY9Uw/h11LRlgS8N3tSipkMQu1NPy1IHFEJDxc5Vhob6LzXLaO4DshRvwv59j/
        GENr0LaOsKkkDt7u3IeN+m6w/ykKunik9B0+9jZTxn/VKNpSwTC0TmJiqdfJ4od3VWDzoF
        aoDDWVrG5hW1hgmxtd93wwDnMX00TDT8OfYNbg1c2xiIox2GJtcfAqFn0GQjgg==
ARC-Authentication-Results: i=1;
        rspamd-749bd77c9c-9789z;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Inform: 0ec899394ee3631e_1691771289218_3771470874
X-MC-Loop-Signature: 1691771289218:3299266039
X-MC-Ingress-Time: 1691771289218
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.240.200 (trex/6.9.1);
        Fri, 11 Aug 2023 16:28:09 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4RMq3C4NjTz2l;
        Fri, 11 Aug 2023 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1691771288;
        bh=C4g7z4/WJLDurewCEJvZ0ttPCUZycEGsj+JDCsmxwqk=;
        h=Date:From:To:Subject:Content-Type;
        b=ItbYHuMb6Ht2JZC4Q2nzsXbhzF4ZjP6PBnAJR5WcDtfyn/127s/sbYxGXlTc1h1LP
         /Nwl85EdafaCAhpYKV03Y964ZV8HNQexkZwUvQrUEuDj9PrvggTucv9l3Nnlvr3PQH
         O/kPNzEXTFQXUJ2k3vRm9ec7h2MKjw7tHciVEcN0AO+qiJUcITfbcwp4WoeDSY2V8z
         MBKB76/3/cL1dHcHyY4HCEECzEiulvYLN44xTZFeWWSEd77BL/f8OXF8SXqgyVsfrS
         mWrpYLt9p2L1SSL8eU17g8pgPxUXre0h/xsei76foEjoTfzZ+jkDMAm4FtVe4ugVIL
         zG3MoqfiX6vNg==
Date:   Fri, 11 Aug 2023 08:49:51 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, a.manzanares@samsung.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        dave.jiang@intel.com, vishal.l.verma@intel.com,
        gourry.memverge@gmail.com, terry.bowman@amd.com, rrichter@amd.com,
        viacheslav.dubeyko@bytedance.com, sheshas@marvell.com
Subject: Re: [ANNOUNCE/CFP] CXL Microconference at LPC 2023
Message-ID: <briwp5uk5dxmzgh7r5mzhvvjv5yuj5ngxjf67peviofxknpmvf@aad2qaihakju>
Mail-Followup-To: linux-cxl@vger.kernel.org, linux-mm@kvack.org, 
        dan.j.williams@intel.com, a.manzanares@samsung.com, Jonathan.Cameron@huawei.com, 
        fan.ni@samsung.com, ira.weiny@intel.com, alison.schofield@intel.com, 
        dave.jiang@intel.com, vishal.l.verma@intel.com, gourry.memverge@gmail.com, 
        terry.bowman@amd.com, rrichter@amd.com, viacheslav.dubeyko@bytedance.com, 
        sheshas@marvell.com
References: <a4c2gx2tnm4ckax7qkx2trnvmqjssfytc45sb2zikuayd2marc@rpsjp4icgsvn>
 <m7qmjtzl5ttg7tt2dn63i3yit6qeg6ap7sk4isuf7hibr4chpd@2lgv47hvwqia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <m7qmjtzl5ttg7tt2dn63i3yit6qeg6ap7sk4isuf7hibr4chpd@2lgv47hvwqia>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Jul 2023, Davidlohr Bueso wrote:

>>Suggested topics:
>>- Ecosystem & Architectural review
>>- Dynamic Capacity Devices
>>- Fabric Management
>>- QEMU support
>>- Security (ie: IDE/SPDM)
>>- Managing vendor specificity
>>- Type 2 accelerator support (bias flip management)
>>- Coherence management of type2/3 memory (back-invalidation)
>>- P2P (UIO)
>>- RAS (GPF, AER)
>>- Hotplug (QoS throttling, policies, daxctl)
>>- Hot remove
>>- Documentation
>>- Memory tiering topics that can relate to cxl (out of scope of MM/performance MCs)
>>- Industry and academia use cases
>>
>>Proposals can be submitted here, by August 6th:
>>
>>https://lpc.events/event/17/abstracts/
>
>A reminder that submissions are due on or before:
>
>  11:59PM UTC on Sunday, August 6, 2023.

There was a confusion on my part and this deadline was only for KS and Refereed
tracks, not the MCs. * Microconference topics are not closed and remain open for
the rest of the month, until August 31. * The site accidentally closed all new
submissions when the Refereed track was closed, but that's now fixed.

If necessary, there will be some room for late submissions until September 30 as
a hard deadline, but most of the schedule should be ready by then, so I highly
encourage people to get things submitted this month.

Thanks,
Davidlohr

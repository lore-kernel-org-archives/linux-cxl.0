Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3796C76196
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 19:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDKThM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 15:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDKThK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 15:37:10 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52E8170E
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 12:37:09 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3E1145C2171;
        Tue, 11 Apr 2023 19:37:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A15565C14C7;
        Tue, 11 Apr 2023 19:37:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681241827; a=rsa-sha256;
        cv=none;
        b=P3i/N8Ca7mWBJjN9xFNRFyGljQ/A5PB7E3GYiBoBJ8RA48x3c5B9Y9fawC1PmavKcWuwIl
        nHGhhihM9naihs/XJFC5Eh9P1sh2s0B+veW3Zb8M05nUyh8DV5yBTw+2PnDyIoNENq8kVu
        uA9LLxFe1d1ft1zWU2MwZa1MRvrbLIP6HOHbltO12yWhHqiT8s7V6TnrjG6a7TNQC9e4mO
        tHteMM904FG2bBY1ZLFlov9QOBVfnbJDhOxIx5Ptjy0GIFaRLJMdiB0vWEc5W8rfFnbs0E
        h1Rw0DklK9MIjsLRpjVdGaYDtPTpLDZLf9j4P4qOtYGx1er/rISRX2YDhYsfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681241827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=mF6rYkOKZBWCvm08A+392aGIpvmJHZbAhc3oZSHJ2M8=;
        b=mmE0NYRrjtNBwSB6b3GSNFbpNhk9QvbnWS7uoaNE3KtwYmKrztYGyKOzbCp+GkDevfVNtD
        rUYpi5mJpYcg4vpaCfmX5jIySRApmnR0FL6qEJdoDbo1HgVqfILPq3ULNgk7/4x7SF5rqr
        ub3/tpOogfobQoyw5cJrToMuA7sIMycRDz0uopCIrObBQocZDbuoOrK1QWVsxPiyrVFeiF
        +fjiGUffDcVRdg12V2AnyJROFm8qdCM/zW9d3ECGe8OO6Rt0ehEMfakm9smPPiIUpwzLeL
        cKumedF5jmxWTrvzeBlcYdIiRhwQeDUv6/JO1/Vj+Lm8F3daUdycespsa6xqkw==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-wm8vm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Hook: 17ffbc4d3f588913_1681241828011_3446462309
X-MC-Loop-Signature: 1681241828011:604405379
X-MC-Ingress-Time: 1681241828011
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.8.119 (trex/6.7.2);
        Tue, 11 Apr 2023 19:37:08 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Pwx1Z6Zl3zFr;
        Tue, 11 Apr 2023 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681241827;
        bh=mF6rYkOKZBWCvm08A+392aGIpvmJHZbAhc3oZSHJ2M8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=KTFDbmSS5Ut9Il+vkHkHdfVUrSIyajShgjwKj2EL0ilSOCoRGOzwI/858UFZJouO3
         wXtD8Px0GNXb9Lvr5FSVwHEVVogHmuoDe65BoNk6eLp3m7z1uFNe3R1SwirD56YY6L
         mTa9kpyt3m/SHuaNeqnoW0Og3ZPXXnne/UwiQBTBWF3DbGfggORXbO9RngUk3I8rrk
         hvwpluXhGtSSZ+s3DKOUsLFAPY5UKKTldC4Fpu5ghFban9IW6+hc1pvPd7nL1qKF7M
         4gRWvE4h6I7NbUKx7Eln/YIuIwahKU8ZqQsDfdhLBSWmx8mR2wW4m4O3XIOS5AQdG/
         UWWsFRYUQBsDw==
Date:   Tue, 11 Apr 2023 12:06:07 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/mbox: Add support for background operations
Message-ID: <6s2gtg7imyiyrkiq54rcxmidzkyfy4bvybfpjm5jikblnvluei@6trlbojork66>
References: <20230224194443.1990440-1-dave@stgolabs.net>
 <20230224194443.1990440-2-dave@stgolabs.net>
 <20230403174730.00003920@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230403174730.00003920@Huawei.com>
User-Agent: NeoMutt/20230322
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 03 Apr 2023, Jonathan Cameron wrote:

>On Fri, 24 Feb 2023 11:44:41 -0800
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>> +    } else {
>> +        /* estimate only */
>> +        cxl_dstate->bg.complete_pct = 100 * now / total_time;
>> +        timer_mod(cxl_dstate->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
>> +    }
>> +
>> +    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP,
>> +                               cxl_dstate->bg.complete_pct);
>> +    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
>> +
>> +    if (cxl_dstate->bg.complete_pct == 100) {
>> +        cxl_dstate->bg.starttime = 0;
>> +        /* registers are updated, allow new bg-capable cmds */
>> +        cxl_dstate->bg.runtime = 0;
>
>Looks like this could all move into the if (now >=..
>block above as I'm not seeing either of these fields being used after that.

I'd rather keep this branch. For one, the next patch will also add the msi
notifications here; and secondly, we don't want another incoming cmd to see
no bg command running (runtime is used to check CXL_MBOX_BUSY) and status
pct complete not at 100.

Thanks,
Davidlohr

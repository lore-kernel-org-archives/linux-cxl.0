Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD6C4708D
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 19:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLGTxv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 14:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGTxu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 14:53:50 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F935E3D3
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 11:53:49 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C88FD340C33;
        Wed,  7 Dec 2022 19:53:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 51830340EB5;
        Wed,  7 Dec 2022 19:53:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670442827; a=rsa-sha256;
        cv=none;
        b=UzphCOyU66EFTfTOrqf8m7cAuTSiLct0UTHniWTryQv6RfPSyuOSvM8cyOd6mF30w+q1Kz
        3yW4zrnBJzrSaQXRj6fVwkDUVBi5NjafItgfpFyrSnamvUlVJ0HuD/T6gsnVeh6Gej/toZ
        133W/LjjyO0PP3AZFDAsJsigssx/uYdR+l7V9pNEacI0Bw3e6h5eS0xtXagNqBySJsNJoC
        ptcUAiMTHHuO8nTAa1THaLkOgDyCN7MWkVtn6F5GmuwkgRKt6aZqthMZQ3XNOlund5Emxx
        VDhwnG1mhhPFpEs6ak7XxGf/SmlfX0dMiLpskv0PQLyycLq1cNGc64hlSKu4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670442827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=I6toRtVNCpq5NemGCaicT9s1NMdw2YmO/n2kZl/M7CI=;
        b=u923nF7XvpxQW3PX08NgsCr6nmXnMC4Ta4EeazOTXUHZH5vnTwkBOPadtGmrVCUqCe8RS2
        l90oFg1TNWp9V+uprWvrCbc+yzx9TJATVkcIVF9t7xDm1S9fLujiQpDFU0qa/OID8L22ne
        3b07qmSdEKxu22nL2vfYPKkaP2BjULOTdrQYOGcCzPBN9fHlZFxAxvibYFrLv8Jk9S5tT2
        3xIjmtBrodRUk/fUxSHncnUe5GYNKS71th2qqh7NDauuxBGcHFLr5BPc7S5aFoXrJZ8sKS
        RQBoRHQs+N6iTNDtLUO0eXwLCClFrhvQxPtzDFrM3QTgyUappTZuK6lwHc1jdQ==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-g574n;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Little-Celery: 414ff76608c455f2_1670442827611_11470763
X-MC-Loop-Signature: 1670442827611:2571042860
X-MC-Ingress-Time: 1670442827610
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.15 (trex/6.7.1);
        Wed, 07 Dec 2022 19:53:47 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4NS7JV3Y14z2G;
        Wed,  7 Dec 2022 11:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670442826;
        bh=I6toRtVNCpq5NemGCaicT9s1NMdw2YmO/n2kZl/M7CI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=UIO+mYxGkkvHb5bjKDSAFvvjy6fVaFt0flTDfAxUxSZPk/vnOP9FdDUVzPUeXdbEX
         NTD4rrYJwJ1KbqXpdRIGjuD0TK+k7KWs2jkTgAzcrKhAXpBPWYm6omBIadWLHQqgbD
         CRsGpTPEmbzYjfSZT7Qvr5UUDB2kxiOvI/hCzzkhuirGJLel6UglOxTUyOJGP/pmda
         L8r8xHck+3U/bWtzjFJzKvUonIfWqXh9ed2rpzsGaQz9ucyJJfAC0x2fbEn7Ou18+m
         scq+gEu5xbzDY+N0+K5SaseqLupVrDzLkTD5uSVkocntxp+sd1792Tt/WAE3glwu79
         P3YyH+19EaxPg==
Date:   Wed, 7 Dec 2022 11:29:42 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Message-ID: <20221207192942.hwcepeqtmtf5iplj@offworld>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-2-dave@stgolabs.net>
 <638ff285d426e_3cbe0294af@dwillia2-xfh.jf.intel.com.notmuch>
 <20221207161026.c2qpn4p7uplm5qkt@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221207161026.c2qpn4p7uplm5qkt@offworld>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 07 Dec 2022, Davidlohr Bueso wrote:

>>>+	/*
>>>+	 * With bg polling this can overlap a scenario where the
>>>+	 * hardware can receive new requests but the driver is
>>>+	 * not ready. Handle accordingly.
>>>+	 */
>>>+	if (!cxlds->mbox_irq) {
>>>+		rc = cxl_mbox_check_cmd_bgcmd(cxlds, opcode);
>>>+		if (rc)
>>>+			return rc;
>>>+	}
>>
>>Can't happen with the straight-line approach as all an interrupt will do
>>is wake up a wait_event_timeout() instance for the currently executing
>>background command.
>
>I don't follow here. Upon mbox irq support, getting an irq will have have
>the isr simply do a:
>
>    cxl_mbox_bgcmd_post();
>    put_device(cxlds->dev);
>    cxl_mbox_bgcmd_done(cxlds);
>
>    return IRQ_HANDLED;
>
>... to terminate the bg command and no wakeup is needed. But polling won't
>be able to do this hence the check above. Maybe I'm just missing your point.

Ok so I'm assuming here cxl_mbox_bgcmd_post() can run in irq context (this
would of course need to be documented). If for example doing a wbinvd_on_all_cpus()
requires a threaded irq (I have seen usage in the kernel that uses it is sleepable
contexts), then we cannot avoid the cxl_mbox_check_cmd_bgcmd() check. The same would
apply for any other bg command in the future that implements ->post() callback.

Thanks,
Davidlohr

Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8047C7EE23
	for <linux-cxl@archiver.kernel.org>; Tue,  9 May 2023 15:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjEIPIg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 May 2023 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbjEIPIf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 May 2023 11:08:35 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D920D40C4
        for <linux-cxl@vger.kernel.org>; Tue,  9 May 2023 08:08:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DF9C26C0B19;
        Tue,  9 May 2023 15:08:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a282.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3CFBF6C1228;
        Tue,  9 May 2023 15:08:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683644912; a=rsa-sha256;
        cv=none;
        b=EZgi1kgOV1E9+vyIZnBL5uIp9j5UalUwTFwtFo4GF6fw6OSK5tv41m2rtDLzjYS0N3+TCX
        PzdmrZzjERmLks8x869auc3mhbxYWQSFcc0KrPzQ6vcHDPIGhIAWsftsAn93wusctu67v/
        NxgTfS3RJl4alXF7OsLEI6mYsF+RKvNKYnkF89SjLSwHreeuDY9+3n/2wB32rr/YybsMTp
        nKkHGexiTp9Qk5S2xUM70fg/AsUSsJqJV0T8+XSNUAeF1x8ZFWwg059/l+AQqXu4cUaq3R
        RT4JNr6HHy17HzeZ8K9OdM+kvL8UFLfH/nnHXp9dhZuc62jcTZzx3EEV1B2WFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683644912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=3AMkfmMeXWWxpl04IFMw13Xa8HKtDvZXETznxlDzQH4=;
        b=ZEqeCuZNu9TT2nViwfNXRrqgCW0YdATDagvTluI/PBO2kzPSo4voQHkafdI1UWad/+O7cs
        b+9jTADwPnACkNDrUUsIxJ4rqwUfbZeBgybXgJsqevwP2Re1BtxDxDXa7sPsSbQoK1hH89
        hk93UtNg8V1MG7vaBiKqqPjZValNNZT5NiqEUbvFslDk3Yvfv9lhOSmMgc1ldN3+O0UKWE
        fYxd4DSLQwsKtdsGJTNNGT5E+tyF1MJ9O4Xrg/6JBSMUi3zCpD9HFNyUBtLG9DDqOqLIm6
        eelmGxQDMlHP6UKyVOC+pVAjIFPbS5wJO4xS+7Tj6LenaXI6tXKpYaAh41EfXg==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-pzkm2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Descriptive-Fearful: 74fad5c11eab12fe_1683644912637_1191774925
X-MC-Loop-Signature: 1683644912637:3777139787
X-MC-Ingress-Time: 1683644912636
Received: from pdx1-sub0-mail-a282.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.237 (trex/6.7.2);
        Tue, 09 May 2023 15:08:32 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a282.dreamhost.com (Postfix) with ESMTPSA id 4QG1kl4kxQz2P;
        Tue,  9 May 2023 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1683644912;
        bh=3AMkfmMeXWWxpl04IFMw13Xa8HKtDvZXETznxlDzQH4=;
        h=Date:Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
        b=aO8HgbFqUmjj28Gv4C3sdT3pvI82rgFOtA1UN7lmDXJANwpWwxP9kCn2L6mhZQeiU
         BvwZGfCTTpCyiPj6ULnDTRQl5hqLzBDO0+bPLkmpFu/RjiPJuPsOYE5WY8FWGrVjZW
         jFzKGmnsNf/IUngwXz50+vu1MgkKJXV3rBnLHFQCINjzcKMlrc8BBGHVjNGnknIx+N
         U9p9aVBQ4FbpNI+T9NwR9bcQDnh+LLAFnoKnEZi6TtTY0Z7MQ+H1qnjy/blRnVnxt5
         VdI/UBlxYnguF6mxn7hEvmZ5fadrwNurbHkG1qLZWrnd+i0exvrxQTLwS3xwx5aFzn
         Hex2EBSuxkN3g==
Message-ID: <88b80839-b0e7-4670-8939-8c3983867e59@stancevic.com>
Date:   Tue, 9 May 2023 10:08:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: =?UTF-8?Q?Re=3a_=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_C?=
 =?UTF-8?B?WEwgbWVtb3J54oCL?=
From:   Dragan Stancevic <dragan@stancevic.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     nil-migration@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
Content-Language: en-US
In-Reply-To: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hey folks-

to those that attended the BoF, just wanted to say thank you for your 
time and attention, I appreciate it.

It was a bit challenging being remote, getting choppy sound, and I 
already have hearing loss so I wasn't able to 100% hear what people were 
saying.

So if you asked me "how you like them apples" and I said "Yeah, bananas 
are cool", I apologize. Please feel free to email me with any additional 
thoughts or questions.

Thanks


On 4/7/23 16:05, Dragan Stancevic wrote:
> Hi folks-
> 
> if it's not too late for the schedule...
> 
> I am starting to tackle VM live migration and hypervisor clustering over 
> switched CXL memory[1][2], intended for cloud virtualization types of 
> loads.
> 
> I'd be interested in doing a small BoF session with some slides and get 
> into a discussion/brainstorming with other people that deal with VM/LM 
> cloud loads. Among other things to discuss would be page migrations over 
> switched CXL memory, shared in-memory ABI to allow VM hand-off between 
> hypervisors, etc...
> 
> A few of us discussed some of this under the ZONE_XMEM thread, but I 
> figured it might be better to start a separate thread.
> 
> If there is interested, thank you.
> 
> 
> [1]. High-level overview available at http://nil-migration.org/
> [2]. Based on CXL spec 3.0
> 
> -- 
> Peace can only come as a natural consequence
> of universal enlightenment -Dr. Nikola Tesla
> 


--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla


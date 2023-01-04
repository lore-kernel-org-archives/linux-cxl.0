Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E22C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 16:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbjADQwh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbjADQvp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 11:51:45 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28597431A8
        for <linux-cxl@vger.kernel.org>; Wed,  4 Jan 2023 08:47:25 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 29B449211C5;
        Wed,  4 Jan 2023 16:46:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A9E21921CD8;
        Wed,  4 Jan 2023 16:46:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1672850808; a=rsa-sha256;
        cv=none;
        b=sUMM7hbaQPRhpPMeMMOUA27UiUzAYfwicmW3OIvCl5KIADIdkRe40r2PijFLZntA5l5hUy
        iUiA2ywn9tP1tAPoHCtgG6ziEy4CF2RrVldOCKmqalHtfCv5k+kcR2QscVwy1/giqDL+ob
        aHsbp06SHub0L07JMi2YP+L7vDC60q71oKWGG9KNyI9AIfd/vFcKOEJo7sOMnQ3LDXKNXi
        pYXdOAvsuJ5/SAgm5P6OggC0UlWEUlqbTCCKMr35768XfUuq1goZCeG1QoTEdppsj4+E+4
        1ncLSI+Na9D21IkFyvXFVVTzF1Vu5xcz/3w+jjTbrJpVbTJTitqjrRsz3yMo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1672850808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=795pCdn+ftM1cD/pRz2NiqTbl3DiMr9sklhY5OWRNiU=;
        b=K+ubhM6j6J0ImK6nOQhvbpSR4tfDUn6f47W6hn79Im3Es6PQFmqvU3/BevafxmbMggNu7y
        IozwDQlwii0oHatbIklcVx8ZR5V89E2aGFuqqVt4Ys6nI/fHLlIvDe0T5UdbJUk1NzZs9H
        8jUuBKKsobPqmfInT3xIZ0J6m+blj4yQyj8ynPftUAJTwmRykGLaIR5YxQe7HXs2cXkbgu
        rim7Uap1oDAQNPIELRcisH2x9jzMyGYRJn6LxwWK3KW1yLPmCwki7BW6hW9VDzb4JLet3M
        y/TQBGqpHPY4oxwmaZo6o2eihcJYbDaxoxaOnvrdf3ZU3eJJO4Qorkcea/W4GA==
ARC-Authentication-Results: i=1;
        rspamd-774c5fc67c-bd629;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ski-Irritate: 589bbcdb5862d2ec_1672850808969_3318741332
X-MC-Loop-Signature: 1672850808969:1664500523
X-MC-Ingress-Time: 1672850808969
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.96 (trex/6.7.1);
        Wed, 04 Jan 2023 16:46:48 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4NnFqq6GbFz28;
        Wed,  4 Jan 2023 08:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1672850808;
        bh=795pCdn+ftM1cD/pRz2NiqTbl3DiMr9sklhY5OWRNiU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=W1A50lyOtdfVgbIVr7sS7wtQY6x4i9R1EvYGA3q0mSQW0VLF0+lzF2+QeuRF5zvur
         fjrEbFEoAWGlH8KnAIzeHEs5teX8ZoJY5IbhifdV/Wx9zxGDsvgbZapipm4+swydQ7
         UkULKQiAbjbTU5BJaA5SwvRnPE6PqXrefQoJa7feVbqg10HFEFqrn55GL0bjWJacE+
         b1BqMOtH/4Wo3Fpv3pJsNRNh/xL8gUY4dMz39ZveaQDbJM036YsfBWxSksJvVvNJux
         KVzky8lP9X/s8iCdF6fLvqoryj6g26KRBc0YSuyJ6Ay5RnLUYCp8EifXLMMx6E/mlz
         Fg9JHjcs468wQ==
Date:   Wed, 4 Jan 2023 08:21:11 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>,
        "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph images
Message-ID: <20230104162111.bxupdf3vm6ce6djw@offworld>
References: <CGME20221220182621uscas1p22da97d084545a7b00f7bf7ea4df7ee3c@uscas1p2.samsung.com>
 <20221220182510.2734032-1-fan.ni@samsung.com>
 <63b47c72a3cc4_5174129497@dwillia2-xfh.jf.intel.com.notmuch>
 <20230103214305.GA2878607@bgt-140510-bm03>
 <027f79b1d796fd0ad6c43d1e3fd8c02247e990bf.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <027f79b1d796fd0ad6c43d1e3fd8c02247e990bf.camel@intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 04 Jan 2023, Verma, Vishal L wrote:

>So maybe something like:
>  -o topo.png : outputs as a png (deduced from extension)
>  -o topo -f png : also outputs as a png
>                   (specified explicitly by -f / --format)
>  -o topo.png -f jpg : outputs as a jpg - i.e. -f overrides extension

Makes sense to me.

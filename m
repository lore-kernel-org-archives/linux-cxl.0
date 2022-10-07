Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3182BC433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Oct 2022 20:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJGUPo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Oct 2022 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJGUPm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Oct 2022 16:15:42 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713D42EF06
        for <linux-cxl@vger.kernel.org>; Fri,  7 Oct 2022 13:15:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 036715C1D10;
        Fri,  7 Oct 2022 20:15:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a282 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 13A785C1CFC;
        Fri,  7 Oct 2022 20:15:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665173736; a=rsa-sha256;
        cv=none;
        b=J3eEVvK1rQqJDhGpDDaoWN9Y795Ux0siatrzHlgWFn6JkAlPUnE0bGWu3Se0ZzRE+P/oYF
        ifT7hNgAIEh+7+QMxLneW0yauncUCYmiEkkqLtffbFncw7jsiQIKjxaE1TOlsUwhgFte9M
        b3Z0y/MinYuK8/J7+tcQatcsPD1Rc+XE/Pa7q97TubC0efyVJ4xCUjGnlpxrGqth/Mr9Yw
        YDH7FIGzg0Pkycw6o56cKUfe/p6mtNupyuMO9miNEs4Z4W8U/QxXkcaZWdpQ4Njc59UJp6
        DhBJhMB/XXFeDc2MzknVRymPlg/ozKoNaCqw1DW1JK4NH5ucRdrL+ghdBlPZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665173736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=kWTMwCZEl8Sl2dSHGCD0RchYuYGel7koCr5c3R5mKKI=;
        b=2Ni/AjfLr4WAL6pjP/ksy+BqQy0s8mM6+/erx6KQ/ppd+nihEmCWiRosQPtX4J8nLUzXt/
        e0OUs660F73quvhYqMmD4uMopDnKBt5N1deAL79m3d0Fvu5i8Z0Klzz6KfKHTyDTERiryn
        xtjIKQ696kiEO6BwcVVL/tt3iRjWMxyJkMnHw3RjS18OE8BA44VHMpfDmApA0jKGDBTIv7
        Wyn0x/EZIJ1WrSt8kDbbdniYLqS0XKReoOovBTvO3Wu8vEPedNRryAhYBJjUxLfP69bUbn
        LHuBCK+7dSAmGbRbdxTAC0zBt/uxcGRKv+S2Jx/yZuBsukK+MC9bsr2qGM4qqg==
ARC-Authentication-Results: i=1;
        rspamd-755f899884-xlz8w;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Cure: 778c06e865a77938_1665173736542_1123507666
X-MC-Loop-Signature: 1665173736542:2443067306
X-MC-Ingress-Time: 1665173736541
Received: from pdx1-sub0-mail-a282 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.34.80 (trex/6.7.1);
        Fri, 07 Oct 2022 20:15:36 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a282 (Postfix) with ESMTPSA id 4Mkfgq2RtPz2Z;
        Fri,  7 Oct 2022 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665173735;
        bh=kWTMwCZEl8Sl2dSHGCD0RchYuYGel7koCr5c3R5mKKI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=qvh+yi/6d0EcTHaWyKWAANlh6BNEQICbPSylZR7LNtrV3boqXEIM0s92z7NZ5ysi8
         Q4WUDtYP2XTW3W6RykVOwMzRBixESsv4i5kaLbSzWjVIDnu4YYebC10SxWsx/nRnO6
         uyhA5FkXH/LhD25QHdG3Xoo6pOjJ5WT6rMe6sAlBEZgmFlATbT9pSNk6MhpSFn1PJu
         mAPrx2v7Fz8CiRwrhZjAhOKUN0nyNIOGmqHNerEvALxF0uQC0c4T2+N3C2gZfIqoGT
         2wnoecLR1efQK/V6tv/NtLvpx7Gj1+WT/z8nbeKA4WmSREigmyqsB3kxig+V5EbyAG
         uURJs27dxS9DA==
Date:   Fri, 7 Oct 2022 12:55:00 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <20221007195500.37tpbrl533qmtng2@offworld>
References: <20221006000103.49542-1-gregory.price@memverge.com>
 <20221006094557.000035ab@huawei.com>
 <20221006095007.00001271@huawei.com>
 <Yz75ppPOwYCvNamy@fedora>
 <20221006174214.000059c7@huawei.com>
 <20221007181619.gumcab46ftnvhwbi@offworld>
 <Y0Bz7OrSxBYNGfNR@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y0Bz7OrSxBYNGfNR@memverge.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 07 Oct 2022, Gregory Price wrote:

>Spec says that volatile devices `may` implement an lsa.

Right you are.

>Get LSA (Opcode 4102h)
>The Label Storage Area (LSA) shall be supported by a memory device
>that provides persistent memory capacity and may be supported by a
>device that provides only volatile memory capacity. The format of
>the LSA is specified in Section 9.13.2. The size of the Label Storage
>Area is retrieved from the Identify Memory Device command.

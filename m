Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7404FC3DA6F
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Aug 2023 02:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjHYCVc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 24 Aug 2023 22:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHYCVL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 24 Aug 2023 22:21:11 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3201BE2
        for <linux-cxl@vger.kernel.org>; Thu, 24 Aug 2023 19:21:06 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 54F32941665;
        Fri, 25 Aug 2023 02:21:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a275.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D1C0C9411C0;
        Fri, 25 Aug 2023 02:21:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1692930061; a=rsa-sha256;
        cv=none;
        b=G56dngFMDiV5R1R4ji1WnIDHbz7kudB0RSaE5qAd3CL3XvtKNr9WZ7Di0NEVVHZhjsAe18
        w178LCakCVwhXsj0yMn5Lt6d1lokODJBC2a0cmMVOUHvFET09vPcRe2Y8rzo/pCoRtBynS
        Snnvwd8Tjjzuyi4gfiAEt5PBf8xWaP0hxZscyD99Lbpp3is/b2FHqQh08m4WgM00b6620I
        bP0Bid4/3s+nbeV6yiGl/AFToCsS6BuxbD/CokllDN2UEE+I934l9tNqvbjSMw0DLpTyvL
        LTYfZXcu0HnPRhFjttjqIb19Li0wUVPoy+l2Ogq2Ukob0NXTSPq9gmmpFtdONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1692930061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=uzU8FHbZyQrCmORicP8OT+/mKWUtWfVlpWzsL6KbZXY=;
        b=AlRk51Bfn3DTIfXhTTsG+0U4Pv7QeGuBgzhauyInswV4uWJpd43VnyxGT7DSjkygHeruW/
        D4Tb57JIwPbr6w8w8DnwnGJMIpodB/Y85KGejDkDLz1v0iMPWByI1eRjgIVgkqvCtHNF24
        lYY64c21xdMWgNzex0QpQo/g2YAbM9XS0yTGGB0KREhYgS6gACaPnEA8O6lG0wlelG5uw7
        n780Ma02dkAbgEFDOPq60YxM410K2b4pDYWiTtplD6t7puqfJrbD7dsW8ICz1kakbANbCO
        41FS0F8t4NS08eJDUW+wh+4mC1j3PeCb3TJIthmNmGmDcIgSJ2YuJaLS3GmEGA==
ARC-Authentication-Results: i=1;
        rspamd-849d547c58-fppbl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Well-Made-Broad: 2d83dfbf235d24b1_1692930062124_2410672464
X-MC-Loop-Signature: 1692930062124:2514086457
X-MC-Ingress-Time: 1692930062124
Received: from pdx1-sub0-mail-a275.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.108.72.15 (trex/6.9.1);
        Fri, 25 Aug 2023 02:21:02 +0000
Received: from offworld (unknown [104.36.30.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a275.dreamhost.com (Postfix) with ESMTPSA id 4RX3bK1tn2zGN;
        Thu, 24 Aug 2023 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1692930061;
        bh=uzU8FHbZyQrCmORicP8OT+/mKWUtWfVlpWzsL6KbZXY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=G25FFQKu3JA0jPmI17pR5yaBCjUGU0EFAxeoRo3nAkk4xqWZiwokl3D8huo02cFts
         RFZQzT+C9AR7j7mK1tR4gpxQGrqZ077yy+aIBxiRXG2TusKJ9wRPKcPi0f6yHBmF2q
         Ya8OwSNLFz4sVSIKwS8GpeJF1VARw/7J+v77/VDlIAOB6ag7CHmWIrlmcLiLOzo4De
         HqdxMe8iFyLp/dYPFOBAL7WIDTIlZW2Y/Kj0ktD9cY/Sq5S5XLPqLYJH6ZRHgLK+1a
         BEsJpc+U93Nn6gl6PqhsaJ7jX9XNvH3aoQL5AxOqgFQ1F92F+9Gcz8nxMKk0SwORKh
         5+dpbtoqu/9Bw==
Date:   Thu, 24 Aug 2023 18:42:00 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     alison.schofield@intel.com
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Match auto-discovered region decoders by
 HPA range
Message-ID: <yicxomblp3amh7axpcauhngfd2gojsjlbz4ax4ja7rgb7hwkuq@3h5ecsj6izq4>
References: <20230822014303.110509-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230822014303.110509-1-alison.schofield@intel.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 21 Aug 2023, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>Currently, when the region driver attaches a region to a port, it
>selects the ports next available decoder to program.
>
>With the addition of auto-discovered regions, a port decoder has
>already been programmed so grabbing the next available decoder can
>be a mismatch when there is more than one region using the port.
>
>The failure appears like this with CXL DEBUG enabled:
>
>[] cxl_core:alloc_region_ref:754: cxl region0: endpoint9: HPA order violation region0:[mem 0x14780000000-0x1478fffffff flags 0x200] vs [mem 0x880000000-0x185fffffff flags 0x200]
>[] cxl_core:cxl_port_attach_region:972: cxl region0: endpoint9: failed to allocate region reference
>
>When CXL DEBUG is not enabled, there is no failure message. The region
>just never materializes. Users can suspect this issue if they know their
>firmware has programmed decoders so that more than one region is using
>a port. Note that the problem may appear intermittently, ie not on
>every reboot.
>
>Add a matching method for auto-discovered regions that finds a decoder
>based on an HPA range. The decoder range must exactly match the region
>resource parameter.
>
>Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
>Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

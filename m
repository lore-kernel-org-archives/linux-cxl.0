Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89309C77B7F
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 19:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbjELTdg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 15:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbjELTde (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 15:33:34 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E75A8A76
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 12:33:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id ED6125C1C76;
        Fri, 12 May 2023 19:33:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 747745C1BE8;
        Fri, 12 May 2023 19:33:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683920011; a=rsa-sha256;
        cv=none;
        b=8/cqlAsFGZKtbvG8kknwRXByhDQA5iMggQcU9HiooYrAoNY1ysDSEw0anb4FVYxHENGlWN
        zfvsCHA/7UM8uOMTWtSOnGt5+wk3sB/JBCTCH9b4JRRvmgCsnmwurL/DDezrQBpmZjmvTZ
        WW9wj4BpxVuQGUv10hYxdEsJq27Sw8ZpTyt39j1z6oIIAp8QBjOyMGrYFtBjnruwKAP1jT
        CiqYzIoZ5yjkQOmrZ7Tux8PMxd8mqqGoJJjkQn632m4MG/SxaIHHT/wyAE5T6/4au5dO1Z
        cJ5LQDbAnvghGEo5i+i5IPDzFrbDihImez6Imgdk5UdaF8UZPja44ItfZbJHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683920011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=qH/jLt2bbCLFu3gJib3ZPpMM+/KerXzKAEHd6KOTO0g=;
        b=tDJB4wE/MBf71Kj3phO/6hqUmhVfiYNU4ACAHWjcmM4oEQ+XmQeaERkICu8I9XDjFAMkPG
        dekdSGe9MlWBwGGTL+b7cRoEOH4FGEtKmPH65BoDtMSaUQF6me2EPs0yCrgh3NJ05P0Xyj
        1qysWxuxdBAWylPJ0jtc+BGBBRlOlNnhiYZHwCTl/vpy48bWPGlL/4pa27LB82e5mX58sA
        EQBqhm3r1JK3x5xMWC889ZNFuvuXyyKiRPbywfNhiR5mwBJIi2Sv2rnTTnQRlJcQMEfL5r
        Pp0+8JbEjhGWgSXvaVr5NLyl0yuSF2sR8Uf/U9MpDfpgS4xrF7xIL1oJdrFiuw==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-2786f;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Interest-Industry: 7d7a7fe21327a857_1683920011749_796431284
X-MC-Loop-Signature: 1683920011749:4231511407
X-MC-Ingress-Time: 1683920011749
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.163.43 (trex/6.8.1);
        Fri, 12 May 2023 19:33:31 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4QHzT65nCMzDm;
        Fri, 12 May 2023 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683920011;
        bh=qH/jLt2bbCLFu3gJib3ZPpMM+/KerXzKAEHd6KOTO0g=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=FcGLJd3R+pM2G72pNQBOjs22oWXzovcM5M5j22oAmIvrYgRmgyDTKzHePcGJ/AzLN
         0QIYHc7bxRc/gHIvKkeKPLcPu/Wk6r6y5yGMuPiMXQ9QpcLHHCHNpbHWnioCZ0r3B8
         PR0DfS47DHO8iIfXjvjJIYC0B0GggQlhNEiOeDlj25SudElY+M8lTllENdfcR8LL+s
         EWRRVmJQ+tk7XfUy0J1UZ9FLVNWJasHxXWJOruCjF/OTjjqvxb5Bp35JdL3RcSLkGF
         9MVtNGL/ACQQRYHctmFPhVH3oZgG0DQ1kW8fpnQMK8enYWnLAu8qkD7WXqMzTqgi2I
         kGwZ0BZiMqYpQ==
Date:   Fri, 12 May 2023 12:00:42 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v2 0/4] cxl: Prep for QoS class support
Message-ID: <252xpwk2xkciqjyygsexklswk5ub73zbebtuogylthgwfaocvv@j7a2qvg5bg2z>
References: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023, Dave Jiang wrote:

>v2:
>- Set cdat.table at the end to keep consistency. (Davidlohr)
>- Split out error return for cdat_read(). (Davidlohr)

For the other two patches in the series:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

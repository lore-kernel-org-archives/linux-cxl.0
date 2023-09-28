Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECABE82CBC
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Sep 2023 01:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjI1BCQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Sep 2023 21:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1BCP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 27 Sep 2023 21:02:15 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9AF5
        for <linux-cxl@vger.kernel.org>; Wed, 27 Sep 2023 18:02:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B2E3D501386;
        Thu, 28 Sep 2023 01:02:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id F37A75015ED;
        Thu, 28 Sep 2023 01:02:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1695862933; a=rsa-sha256;
        cv=none;
        b=5MpPRKKMo1tvHN0kh7Dr4y2rM9qpcIsUvA1/lxZQHOizHP8CF+eUHsOoOZRS7ijSXy2LID
        GWdpv9JJ5icFTgtO1ViE4zZKycVlLl+HuMJKNF5zQx6FP/2Pq3as7b1Gc+7TyYxhHcjeuZ
        be/YWG9MUqaQQG319Q3NOkFTKdjfzuEAh2gNnVI2gTATaoYAaCbJ6/e62pia4CGbyQBhQD
        XSF/479cs+f6rV4IyLtIb+T8xRl0EdcnPffGPoH7CkJhF2LfHlHOwSO86S+BNp5fWA6u11
        B2fmlz7LIRxBGQI4pPcVh4tJpCRdlJM0+2nbca4OIz6ibzTwDY18xA40fPCjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1695862933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=9r8KJVi4kU259gaTx7co5T7sTaC8Vta1My/b7WZc8LI=;
        b=hlMtn//l79wRTgoHYOUPGOfvBRrJ+EWeiMKjOa6KnS7jawfwBoVyBOBwj0UzSeEmmUyu8J
        WYaVBmw9pDqycWvfZatcy/ZSmCoDPe/OtZO6M6HSAZaO61hkD/Tcq5XFcZZ2Bni1wQkd0z
        0+PjtPtPQueTg11VmEO96eHnetR5DJAnZA2vOzzZJsA3mHYlB1++e45yES3vFCCwS6idkQ
        21/MGMKmTzwbBowbC4bimmnRCKP/mkr7jmpYtLXUXNxSnNEG2uJ62KAolBdtFfyK2/EURG
        N6h9uIJRmsAn51cxwQEtw3MbzwDnTYIGz3Br/7cAo1zXocE4p/xENAd0GmC3Yg==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-dd77t;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Language-Arithmetic: 4520769463d83449_1695862933492_3994587097
X-MC-Loop-Signature: 1695862933492:637732998
X-MC-Ingress-Time: 1695862933492
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.140.241 (trex/6.9.1);
        Thu, 28 Sep 2023 01:02:13 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4RwwDg6VgZzDV;
        Wed, 27 Sep 2023 18:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1695862932;
        bh=9r8KJVi4kU259gaTx7co5T7sTaC8Vta1My/b7WZc8LI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=U2HjXVqu0t+fjVys7TVJy384+7eL/xshCdITcBBeixbUtbVGbHdNmoNglPdgPM8Hx
         Dr215NvD+A5IrRTLs0jBNelp4v0IX9W0m42YREsOGzxifYVEjCJwy5AIM7GEvt0aMP
         HRfLKps/bQlQBW4uwQUioiWiqZjmkk+sQeiwO7f8eMcJyMJq/ersJ+CnsW0fE8C9El
         fzXIsqbkeQ84eIWWQ/QS+AjZCb32LX2AFgZ7nUNdAmVFFWtVC7MNZUCB4zYexxr85u
         SuID3+f10ihUv0OYI29aWkDKX7V3ka+IX6fdQ9HlOGkBE0KSbl32e/u9NTX4PW5J5i
         6k0PqbEHwXJqw==
Date:   Wed, 27 Sep 2023 18:02:03 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jeongtae Park <jtp.park@samsung.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>
Subject: Re: [RFC PATCH 0/3] cxl: Fix background operation handling
Message-ID: <yuxcbtl6zjtas55y6d4x6q6jx267fjcsvhjodofk6sqsg25lhh@gcvpdf3j3bmi>
References: <CGME20230922130253epcas2p3112ca71e8a1dcf42967543063322df1e@epcas2p3.samsung.com>
 <20230922130528.3475445-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922130528.3475445-1-jtp.park@samsung.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 22 Sep 2023, Jeongtae Park wrote:

>Hello,
>
>We are currently trying to add background commands like
>fw-related and sanitize operation. However, as we modified
>the code, we found that there was a lot of duplication of
>code, so we would like to modify the existing background
>command handling a little bit. We want to make the most of
>the existing background command handling so that we can
>easily add other background commands in the future.

What code duplication? All you need to do is arm the
struct cxl_mbox_cmd with sensible timeouts. For example,
see 9521875bbe0 (cxl: add a firmware update mechanism using
the sysfs firmware loader).

>The first patch modifies the existing sanitize operation
>handling to allow other background commands to be used
>with it, and the second patch modifies sanitize to work
>with the modified code. Finally, the third patch adds a
>sysfs file related to the background operation.
>This sysfs entry is select/poll capable from userspace
>to notify upon completion of a background operation.

This says nothing about the motivation of these changes.
Specially when it has been well discussed in the past that
exactly because of its monopolizing nature, the driver will
_only_ do sanitize asynchronously. See the changelog of
ccadf1310fb (cxl/mbox: Add background cmd handling machinery).

Thanks,
Davidlohr

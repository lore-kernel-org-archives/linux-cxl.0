Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4E1C77B73
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 21:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjEVV7g (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 17:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjEVV7f (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 17:59:35 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAB5AF
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 14:59:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 031333C2914;
        Mon, 22 May 2023 21:59:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 826873C1E6D;
        Mon, 22 May 2023 21:59:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684792773; a=rsa-sha256;
        cv=none;
        b=tZxu+4oA4Jamtu+dqYtOawnZl7NfMHukTk0K8gyGB8P79PPwEst0pgAR2d5U8vVj0JZS/z
        T0w3xbQHW0MAX7wRjMDVj5UXlgurxcwWrfcQOo6BKB2zlfYBu1xorvStaD9F8cszlt18mJ
        Raua46Uf9w6W6f6NJ18NXdCEqmhUYuPV4PMyza8eMENUqQ6anTk5QvIqZAzelxYXDxsbMa
        IlOgdSgq6rKabHJXebpyL54tr1Fkpbl6wu3Bn6A6BGn32+LlStJArO3C95TfrgDgoYyxNe
        oyGAo3ibjy06P/kx4TrsTiN7QWRPFPKNJKGmBLGXJ1TPEpugK4xdArbtcDYLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684792773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=dtfYb/yMoBmCWLxrc3FVAjYYte8yB9y0OZYZKhEtWu0=;
        b=LXWHaRfESLsouDow8s76ob+5Uc7Xh0/zYm82k3n/1QhGnZl0H2WIh5mxwA/G2equlxMATP
        X+CtfpY4/apNjAcjvbfg1oyygmrTkDO07k/BpqqesV2aAdHJRID0XlXqrrfkXWqbam4I2C
        kkfegvkwps8UenKLrJjlaqvOpnGxsKSrxefWF+mWX6D+5fow5sDg7feiL5qXbYA1eaETHo
        Hx5OE+ys/DLN4A6Fv3PyiJx4XcDa8WGt61eQA0ueXGsjdUaxI8RRpIi+JFOb+iDMMC5bww
        u4W0hFx1fFbJpY7JbvvhqirT4C3Qg9ZBJHteLaGXqdgQYDS7iocBzQGS6gSm7g==
ARC-Authentication-Results: i=1;
        rspamd-79bb5575d7-wg5c7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Turn: 3b802d552c1d9838_1684792773823_2088000080
X-MC-Loop-Signature: 1684792773823:4050850260
X-MC-Ingress-Time: 1684792773823
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.193.157 (trex/6.8.1);
        Mon, 22 May 2023 21:59:33 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4QQBF00s9Jz2h;
        Mon, 22 May 2023 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684792772;
        bh=dtfYb/yMoBmCWLxrc3FVAjYYte8yB9y0OZYZKhEtWu0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=orrMWi4ypjL149sZXpfjII4hV03jicCY8uPd7fFjBFztZfXXEln1yMqHNHF0sn1Bq
         HDS2yhoMHZ9vkMJflJXo7fWD2V1qvK8ek9pkk5vjcUKhVziBtYH5SSSXaGbgBqxVr7
         y41vmTii6MAcNCEZTRuIlCCUDAM2mA8mCEzwXnafjGlWALL1HGnes6xa/cR4Y17oyd
         BM6hDDDIbSlOcbezhRe7MwrKPJMo4nzOuB1T9tfthhzaad3OYY8GNv989v6kMe18YG
         65T/UwxrNyqbnsaG2wLR7/iiK7xG9ySaFmjyswSJ5M9ybVriIOsO3KfsPxbceMuME5
         Idb9IfN5MpbOQ==
Date:   Mon, 22 May 2023 14:26:04 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <ra4parotyzuzbqitq4qdenquqhsi4yesl5yobrd7kj6wtyzhuh@vxou7lguxo6u>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
 <6468027e5d15b_682c12945b@dwillia2-xfh.jf.intel.com.notmuch>
 <64jusopypczmfmkeg5ulzw6gwbfv4mdnk2jilmja7iyr5dsukc@vkpwdjsjsbk5>
 <646bb221db164_33fb3294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <ps5l5kclllyhjfaelf6p7cl4vsq6v3lp5uxoqt6u5m4ha7adw5@6q4gjq7hlxpp>
 <646bcda53c22c_33fb3294fa@dwillia2-xfh.jf.intel.com.notmuch>
 <dbz7qo7rsbyc7r4vtcwc5lkpzpy2uz3q3cfd7qekhghp3amn3x@264xhf4swkda>
 <646bdce675b59_35a4829434@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <646bdce675b59_35a4829434@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 22 May 2023, Dan Williams wrote:

>So the choices are either allow the background command wait to be
>interruptible and then do an implied sync on the next submission, or
>make it uninterruptible where timeouts are either a real device problem
>or a driver issue that needs to reduce the size of the background
>operation to fit the timeout.

I obviously vote for the uninterruptible option and treat timeouts as
a rare occurrence. In my answers I was only mentioning timeout case
because of that uninterruptible wait context. The amount of bg capable
commands are limited, and would expect timeout parameters to be fairly
well inspected(?).

So if ok with you a v3 would have these semantics.

Thanks,
Davidlohr

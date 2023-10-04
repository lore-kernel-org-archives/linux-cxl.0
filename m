Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D25E7C4E2
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 16:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbjJDQVb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbjJDQVa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 12:21:30 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F0995
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 09:21:26 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 36A71901203;
        Wed,  4 Oct 2023 16:21:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BB730901098;
        Wed,  4 Oct 2023 16:21:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696436485; a=rsa-sha256;
        cv=none;
        b=bIOX4vqBgyVlp7ionhP3n6uhm3uDeSEWzC8spfHW7tVbNBQ3nmQfUBi70Qk7Sq26h9mWR2
        XYM2NzQoKmdG1r7hgV1bhKC09bTlknXqH+O9T+LSI0353ubgZsCyHmrbrkofW+gXSRn9mV
        A/rl9hzRDY7ehrhnRY9jDOD0/e41I3UxT/nCiXvImtsminRkfBO0RUVKHfzJEqjy2y5/xO
        ZgtNO38KkK/0hZT9xa0t/1/+8ivRNz2r3RHJieK24XS4cLsNk8kO1nEK56dBP2sfCdD0uz
        487tV87eyAAaUiOFYSsLEJ/VgRCyKC8/Dd9FV93arxRVwf6ox69RmY+mi43faA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696436485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=dZmEJfw++FWKwY64izAhAY2Tl7RJYq2NUvnj1M+ENNQ=;
        b=yjlnTGToaWhDhVyb6U6Dp4JBE153Eg+U3IVIkae/W4sAzAxWdLf3LmjqvokMhM+emqURiv
        muvIr2QH1Amk/h+GlXoi3yBjYOX81uqtM79bMA9ebNpb0KuVb0YUYn95of0HYVz94ecoeR
        vFO/W+i8NXRTmyKS4enBKQUXGFPRvRmRa/XX3qvCLC7gfmTyWZe31cxjCRuBe/GFBlM6Qw
        zNZmDZQPMKobxEuPBm/ObJhqrdpq18pLAKgDeZmExNuG34xxT2OScBOqSOe5lEBqeIoT05
        OTxD+JqM4CzxolPutoWsNn9rdGr8y/j+X/zWhWmynO5wi6bOY1qEeUoYfqxBNA==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-8p8lp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Scare: 78384ad73313b30b_1696436486026_843480592
X-MC-Loop-Signature: 1696436486025:2666128924
X-MC-Ingress-Time: 1696436486025
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.112.200 (trex/6.9.1);
        Wed, 04 Oct 2023 16:21:26 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4S10LX5Vgkz39;
        Wed,  4 Oct 2023 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1696436485;
        bh=dZmEJfw++FWKwY64izAhAY2Tl7RJYq2NUvnj1M+ENNQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Qt3mV7IF5QTcVW+nyzogwitdFnwfGB+i7fdnPS1Y85hgbCxEgTREIqUYng8/YiTY0
         16k2U3KdZrI8yIge0lAtIeh2/aRcsA1Y7jsEt/cSBGSkF3+JhEwBQC3qkDbfECXmna
         7MsgapSPs1UCGNvmpy02V9ywdoOeyvcewZIgcX+APTxfK3tm4QsJtPyJbZg9QHc6yg
         aCFPpGs68heyar/+h5RHUXUY90cSAeB+Ydyho7y3+HzFr8dNP4Iz4p6xmexbDjjqfz
         iPc5C80PvC0Xfq19zOIq+j34Z5/Wcu5BOcdq3swcGdigp24SxWoJHEMlXKlSmnBtTJ
         MmsVExv1CWOIg==
Date:   Wed, 4 Oct 2023 09:21:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, ira.weiny@intel.com
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <z43unomoc6f542g5qxgc3zzjtrjdfnqckywd32jzavyzcouana@buy5wxxsnuty>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
 <zs7jliubdhd6e7eabzukvale7bfoltk7ja5lwvvue2df2n2vol@4nhsl2gzdcfw>
 <651cbb54d1ebd_ae7e7294f1@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <651cbb54d1ebd_ae7e7294f1@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 03 Oct 2023, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> On Fri, 29 Sep 2023, Dan Williams wrote:
>>
>> >+static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
>> >+{
>> >+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> >+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> >+	struct device *dev = cxlds->dev;
>>
>> This wants to be dev = &cxlmd->dev;
>
>No, the notifier needs to be torn down in the cxl_pci teardown path. If
>cxlmd->dev was the devm operations host then this notifier would need to
>be setup from the cxl_mem driver, not cxl_pci. The teardown order of
>cxl_pci ends with @cxlds->dev as the devm host ends up as:
>
>cxl_sanitize_teardown_notifier()
>cxl_memdev_unregister()
>
>...otherwise if the @cxlmd->dev is used then the devm callback may not
>fire until device_release() time since it is possible that the cxl_mem
>driver never attaches to trigger the typical devm action around
>->remove() time.

As is, the first sysfs_get_dirent() fails, fyi.

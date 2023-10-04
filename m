Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4931EE7C4EE
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjJDTXV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 15:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjJDTXS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 15:23:18 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF1AB
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 12:23:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3DB195018FC;
        Wed,  4 Oct 2023 19:23:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 995A4501264;
        Wed,  4 Oct 2023 19:23:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696447391; a=rsa-sha256;
        cv=none;
        b=dHWBnk4kythYS5zfxG+uefzao5py/duTmiy4pS7OrPkP/1QVd/j3PCcXiMp9WsJsTrGDVt
        LWbGictdqA0oHb152Yxkc5XwwuT7484HW1WrFoFKIu7jZgitCHdlTNGJpFm26WbUONZn7b
        9nIvJPTSd4PcgDeag/wSyK2fb9T/20lBoaUTu/r6Z/+m4sJE6skHtMkR65DtMufOjPzif9
        HHZ5AsaMVBK7Im3DUGSBo6fVq4K8Naok91GQEJCXWYVHBCTDhaR4OE5XNykNQqWC3UdtIZ
        XAMW6fd0vRddkbqwXSrrONt9Kxly94i4aCkgbYryzofZX/BD3q/ztVN9r5c2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696447391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=nbMyiT126YMbEoLLBhhY2iNi/jPLKFhAvGC+BZ0wIts=;
        b=w3Md8/5dD6wB5tJ+8tacopBLP8GK2tmz4n9GYO8jG51qf7CbvJhaYMzwcavSAZY3Hgw9Zn
        HZnlzB5hY2vH94ec8DSQM1sNl6mVIIEdzSeO1veUSQwl9O+PCH/9+irPACSITIAio1LrCd
        mZoee5IueQBQNvrRdkn4//6wpWWAZ0sHDb0jgmwI4WXvks9JzDPs2EhUbfjPZcknCClmBX
        ho1Bs9ort7P4AnaJYM4wmpehSCKMnoNZwoSA/ssAIXwQrEWc6Q+txJtSzC2xKvUT/hMmJ8
        JiL8QYvie1qEl7RuBEd+ndwe+MGSOL5UiOSpdzRQJ7x15XSVnxKuKaxb/3tgnw==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-sr8f5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Cure: 724d028943e7d121_1696447391889_2007305297
X-MC-Loop-Signature: 1696447391889:690480050
X-MC-Ingress-Time: 1696447391889
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.41.146 (trex/6.9.1);
        Wed, 04 Oct 2023 19:23:11 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4S14NH0r8tz62;
        Wed,  4 Oct 2023 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1696447391;
        bh=nbMyiT126YMbEoLLBhhY2iNi/jPLKFhAvGC+BZ0wIts=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Kdp7fC3YBJWz2yHoaglnjpNYxqIChobq6jPwi9VYTAmqMeLqvsava1ahVoCb6Ck0m
         VQ7nNr+/q0y3Cxdx2E6qYVSToXGSpe5jArV9G5SbX2yIbWnCXK9jHlzREjobf6EDKi
         q3k/L1zrm/SbVAJyBPF4y2rFh5tnaflI7ERmmQCiwx7tDG7sOpg67W7+qvCaZhMuDD
         7ef8VhTXZT4v3T+tD3Yy+t11/w8kaAL7BXfRPVk+aEB97dSZtROs7JCdjmp44Yv6MA
         5vh9ldjcBdG6K4yS2IHJH8CAkWsPWhXI1snjMEYrUERTCWtTpIOVR/w4acO7rGV90l
         6qvi/Oyi888lQ==
Date:   Wed, 4 Oct 2023 12:23:08 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, ira.weiny@intel.com
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <yiozqcgkjlulkdfzgcpgz3opgbrgop3bx64zecebf4ltf6xuwx@3nnopswwyqqx>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
 <zs7jliubdhd6e7eabzukvale7bfoltk7ja5lwvvue2df2n2vol@4nhsl2gzdcfw>
 <651cbb54d1ebd_ae7e7294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <z43unomoc6f542g5qxgc3zzjtrjdfnqckywd32jzavyzcouana@buy5wxxsnuty>
 <651db4ef262ed_ae7e72947a@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <651db4ef262ed_ae7e72947a@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 04 Oct 2023, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> On Tue, 03 Oct 2023, Dan Williams wrote:
>>
>> >Davidlohr Bueso wrote:
>> >> On Fri, 29 Sep 2023, Dan Williams wrote:
>> >>
>> >> >+static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
>> >> >+{
>> >> >+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> >> >+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> >> >+	struct device *dev = cxlds->dev;
>> >>
>> >> This wants to be dev = &cxlmd->dev;
>> >
>> >No, the notifier needs to be torn down in the cxl_pci teardown path. If
>> >cxlmd->dev was the devm operations host then this notifier would need to
>> >be setup from the cxl_mem driver, not cxl_pci. The teardown order of
>> >cxl_pci ends with @cxlds->dev as the devm host ends up as:
>> >
>> >cxl_sanitize_teardown_notifier()
>> >cxl_memdev_unregister()
>> >
>> >...otherwise if the @cxlmd->dev is used then the devm callback may not
>> >fire until device_release() time since it is possible that the cxl_mem
>> >driver never attaches to trigger the typical devm action around
>> >->remove() time.
>>
>> As is, the first sysfs_get_dirent() fails, fyi.
>
>Here is the full fix, apologies for misreading your fix earlier:

Yep, looks good (and tested).

>
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>index f69f6195c465..a84932ad9392 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -187,25 +187,25 @@ static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
> {
>        struct cxl_dev_state *cxlds = cxlmd->cxlds;
>        struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>-       struct device *dev = cxlds->dev;
>+       struct device *host = cxlds->dev;
>        struct kernfs_node *sec;
>
>        if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
>                return 0;
>
>-       sec = sysfs_get_dirent(dev->kobj.sd, "security");
>+       sec = sysfs_get_dirent(cxlmd->dev.kobj.sd, "security");
>        if (!sec) {
>-               dev_err(dev, "sanitize notification setup failure\n");
>+               dev_err(host, "sanitize notification setup failure\n");
>                return -ENOENT;
>        }
>        mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
>        sysfs_put(sec);
>        if (!mds->security.sanitize_node) {
>-               dev_err(dev, "sanitize notification setup failure\n");
>+               dev_err(host, "sanitize notification setup failure\n");
>                return -ENOENT;
>        }
>
>-       return devm_add_action_or_reset(dev, cxl_sanitize_teardown_notifier, mds);
>+       return devm_add_action_or_reset(host, cxl_sanitize_teardown_notifier, mds);
> }
>
> /**
>

Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6A0CD37B1
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Sep 2023 00:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbjIPAMM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbjIPALk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Sep 2023 20:11:40 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF11FB
        for <linux-cxl@vger.kernel.org>; Fri, 15 Sep 2023 17:11:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 42F5D84114F;
        Sat, 16 Sep 2023 00:11:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C5618841BED;
        Sat, 16 Sep 2023 00:11:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694823092; a=rsa-sha256;
        cv=none;
        b=jSCryIOAhTEgyeLMy6Lt4jq+T4jvvVvEuFdRU5oBmB6X5Yg5Mf+V/HBKUf+n+y4p/EVd9G
        ewBC6V7HaltWKCjuaV7SGeACinAoWjngCs84eskx5Axf8/nqQwsK6GYM7j5lLpEtEOz7HV
        b3B3rifGOTarWcrJnSEYvEOgP+mDaE3s8Md9dQSPZOAwDGn9zzRagwtZtMcAaAGQMCCv7w
        LruCjbdXrBiDPXePp94IrxGdZ8mTjXHkuS4l2IhotSIBZSyK1MA0tkRwZNyW9l7CKO8bi+
        gtZPxJ0igv+R+Y3atASQRPhbIspCWO5Aw0rMw54KPyalx3ifqz1/7sZfMGwCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694823092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=CiIEgm6m0suODKUPRaeAIJ589b4/+6KueaWIIjl+Wsg=;
        b=mf7QH2CjpoauqKzOnLa/iRYPCespuFrgPAM9Ap2zeVPlcP1ZF8AOMRCNcAYst91pMa8Oid
        6Xm6usWa9+QBht/Nht/ChHucnwzpjAPbHpKBSIRtXxf404UdyZEDWcbj5KtURSK8L01c02
        bbZb6OqQcdBRuT+aNMcq1eEXuk7P0zZWjSPFdEGDkxqYDBacYor08EvtrPcta72v5tPiuG
        O6nhI/P0wmxX3y3ncxvqhqiLh1y/A5v8+4IdiI0P5BrUOQNNHAMCrwENQxo825RF8XgQju
        ToN2VDdLEWbZaIatpB1ukBylUMtc5Ir+d7QjQ17GaPUXBJHBhhtL4Ip/1FlxNg==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-fwf8h;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Share: 24970ca97ac06894_1694823093072_1323013605
X-MC-Loop-Signature: 1694823093072:1772689953
X-MC-Ingress-Time: 1694823093072
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.244.76 (trex/6.9.1);
        Sat, 16 Sep 2023 00:11:33 +0000
Received: from offworld (unknown [172.56.176.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4RnWgm0kwfzGS;
        Fri, 15 Sep 2023 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694823092;
        bh=CiIEgm6m0suODKUPRaeAIJ589b4/+6KueaWIIjl+Wsg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HAmyZfMN9DnJV945rYM/i23fkvHgURVe0qtvMwwmI83eRmCJcGnTwgz3y6x8LTlqO
         jWeM3FAhmEEjo+grxNHLt8Z4LEgsAnTaAsdD83hetX7CiBtEQeo1EavlSrWXWEB7rL
         cAHtOQMFxsUU5qhCnI+zQ8UcT6kFlvIKAv/QGVEZQKzH9M6lqcSC2gCWBnHmFEyB0c
         bgEX+duI18SQpZuc3v0+IfCMClcMpnDZ8ivWIn0v460wRhRlbyuDO7NdT2rjGW/P+1
         70RPE/Ip0HyIbn0nFT3LVTugc3Jy2j1/L3S/G31oM4sswe01MGaDPjgrW8DNijfkGZ
         OxYhHBpTMXWuA==
Date:   Fri, 15 Sep 2023 17:11:27 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     fan.ni@samsung.com, dan.j.williams@intel.com,
        alison.schofield@intel.com, ayush.m55@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/4] hw/cxl: Add get scan media results cmd support
Message-ID: <fdylnvbildmd5oxl5datqz63awg2nqacwavif5yhlvbq7qnnoi@bdikubr3uky3>
References: <20230908073152.4386-1-dave@stgolabs.net>
 <20230908073152.4386-5-dave@stgolabs.net>
 <20230912130425.0000569b@Huawei.com>
 <kbznhylcg6qqltagnwrsidsvyetsdvmg4dftbsm2btjlwhqx2c@yy245lt2z6zd>
 <20230913143028.00003fec@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230913143028.00003fec@Huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 13 Sep 2023, Jonathan Cameron wrote:

>https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13
>
>Fresh and tasty.  Includes 3 series that I've posted with the hope
>of them merging soon and another one I'll post in a few mins to
>deal with over long lines...

fyi I'm getting the below:

/usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_reset':
/home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:477: undefined reference to `ct3d_reset'
/usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_exit':
/home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:466: undefined reference to `ct3_exit'
/usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_realize':
/home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:428: undefined reference to `ct3_realize'
/usr/lib64/gcc/x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: libcommon.fa.p/hw_cxl_vendor_skhynix_skhynix_niagara.c.o: in function `cxl_niagara_reset':
/home/dave/git/qemu-jic/build/../hw/cxl/vendor/skhynix/skhynix_niagara.c:478: undefined reference to `cxl_add_cci_commands'

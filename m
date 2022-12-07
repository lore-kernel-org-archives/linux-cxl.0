Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B3C352A1
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 03:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLGD1T (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 22:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGD1S (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 22:27:18 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC62155A85
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 19:27:17 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D0F0C101C00;
        Wed,  7 Dec 2022 03:27:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 492A5101B70;
        Wed,  7 Dec 2022 03:27:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670383636; a=rsa-sha256;
        cv=none;
        b=s81mvW0ruFn7NFftrhtZyKbLIDWaJKxj6JsYHzSvlA9+NOm74Anftj9Q+AZth7sQ1B/FL3
        /bNlKBm+y+CReLBBc9ZLcSw3cshdr/qDNkPHi/h/CZgnv3vlDht/7MLBPkgTysf7SMnuIh
        YkuwvebBe7YtqE5Y6XtcnTvklKE7zkKBujegILl2omPYz+hp3Dlcvgn6+oS27oB7ejAYxQ
        di2VqwvmB7VFXxmMYOyXJzmBRPOxE4ZyxxaTmTUekrBAv6ercFvrLVSuNokKAsv2RzTDn/
        h/GdAG6VGYqBsVfBpKsSygEv4dkbcKbkX/w2dcqnajJN8/ghZT8s44EGsvqRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670383636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=XmDcGXJV/F2TdyzO8O5yD2PoftYMUlYQT+ZGjomJE3Y=;
        b=Q8jGA+hgXSjZ7QQAehVftkHjFqpahSQVYYWdcaWx9ijN8x91QyNu0WYsSDBZL51302WYgu
        TSCNgWboetRz4dfhVK8Iu+OKWANVi9gRi4LOdB6xZDT1lSDhROiYK9WItpOf1kq1eNhdyQ
        A+GcwWmD9wgQ+QB0B/1LV2faXNAl6FZU3JHu/ymkzNyjzmKbiWilrt+uUVMSQFRhRMUM3C
        kPE2VhINuRxyvczpYmfSCwGzO4ymJt6D76+HhKqkOMYnu2wvC/QOwO5oMnRNZqDYEyiUaV
        j4+GOLoX0RLYNEVqt7ChKCcR7wFzc4XVxYzmVTpXv2yUetLEtlyt9vBsnocyvQ==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-rjvf7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Society: 5479de8d424f8411_1670383636567_3753961411
X-MC-Loop-Signature: 1670383636567:382833182
X-MC-Ingress-Time: 1670383636566
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.30 (trex/6.7.1);
        Wed, 07 Dec 2022 03:27:16 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4NRjQC4hP6z1H;
        Tue,  6 Dec 2022 19:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670383636;
        bh=XmDcGXJV/F2TdyzO8O5yD2PoftYMUlYQT+ZGjomJE3Y=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=VHA7fQh8b5rxsCLETsduQYf6mAwthoeGOtvP639nUf+pdaZgJesOg+2dLsYZn30un
         9XtbMoTBtxTsZgG3nBTMiKhjLF8Okiaca/AwUA46OWAU72037rNSm+Z8CcP4JxdCdx
         y0ceSSXxcRuS2j7TD1j8KnDweW5+Q10d4d6RN9VWqf0lI8MgTVrELa8HcO9eQpoKZA
         nOLcm2l84Q4TJjrfzAR0VkxnllnoqUjQkY6YG2YwSllqg1XHVvF+FW0fdih176IvTu
         dtGvOHSDYoyogaa7+vgd/N5s/vfbipa0OW96sHiVUp2wv8rMC9FmLAr09xxGh6vjrO
         s3dBiYkLvW+pA==
Date:   Tue, 6 Dec 2022 19:03:14 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/3] cxl: BG operations and device sanitation
Message-ID: <20221207030314.4xzlqhe3kgl5r3pp@offworld>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <638fd9c2d11b3_3cbe029448@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <638fd9c2d11b3_3cbe029448@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 06 Dec 2022, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> Hi,
>>
>> This series adds support for the rest of the security related cxl operation
>> which are not strictly dependent on PMEM.
>>
>> Patch 1 adds the required background cmd handling bits. While this is currently
>> only polling support, the idea is to follow up with an irq support once the
>> bits land in Ira's event work. All polling-specific code has been marked
>> as __maybe_unused.
>
>I will take a look, but this tends to put me in the mindset of this is
>v6.3 material that should wait for its user. Was that your intent?

Thanks for having a look. My intent was for 6.3, yes.

>
>> Patch 2 implements the sanitation commands (overwrite and secure erase).
>
>My concern with landing non-PMEM secure erase is that it is not scoped
>by partition type, and there is no existing appartus like there is on
>the nvdimm side to make sure an erase event does not collide with a
>device in active use.

I can drop the secure erase part of patch 2 and just leave overwrite.

Thanks,
Davidlohr

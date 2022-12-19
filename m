Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD0DC001B2
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 21:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiLSVMe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 16:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiLSVMd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 16:12:33 -0500
Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEA5EE16
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 13:12:31 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 909C841446;
        Mon, 19 Dec 2022 21:12:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 000A1413AD;
        Mon, 19 Dec 2022 21:12:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1671484350; a=rsa-sha256;
        cv=none;
        b=B/MFQZxC2gUXqySaFsnJGVjjGdXNcz5aJv6GsspLABddF1C/q34NYQcDCYqxfc+lU5sHEz
        g1M6Jxqagy4KiB6I1JcUVV2CFqpiuj9I59n2FAeb7fJUOuABIG+1GzoSD2wn03GHTftDmg
        xmX2oqjzkFRa7kPP1R0JEdg6oI3IFP1agSPiA6NYNXuc+CD4v+JHMsy//6lz2BqHug36VR
        K8HPx59cT+cO6csUk3gM6K8cyAMqbsZ3SMicJcMEcKoT/ywvOiMKi0E9diXWJOaQxKu4iQ
        +x3gqgideF83NruC/9wGnEdAiDG/XtwZ4eqF6NWSRkniNfoc7q7XhIZNSSaQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1671484350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=twaUYurFKPDkZpNU2fCTR/GrB7eDAue/bZi8A5G/Msg=;
        b=2fHH+FBMIDQ3ZruDQZjoZJeKYpCj9p2U2Z+SBckD4HW0dzigM8hsuFY5hHh1qIRP6a9/zD
        QlGMv74Z21nTSEeMy0LyZLwBiZhIFY65hzf92M8OQbhsoT4+XyxmEajHhgRslDYDPwtB89
        AwFped1cGDdHMJS7jFP+dbHx96Df1ECVB2wwMqDHWWP2zo3t3LSBcK40tiQlk6yAvDcrTy
        viGLki8XcdUekhki6DG/PL2T6+fjk7CRV3mfbbDdkxlaSjWlybKd1LKr2xlpF0l8/Tk2EW
        SH/y83k5xXBc//1e4Y2+KFF+0rwiAF02N44Cl9Qrajcvisf3YUKYTsdauRq8Mw==
ARC-Authentication-Results: i=1;
        rspamd-6f8d97c84c-8zjcj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Celery-Inform: 4058625049885765_1671484350314_1764458435
X-MC-Loop-Signature: 1671484350313:2935410038
X-MC-Ingress-Time: 1671484350313
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.82 (trex/6.7.1);
        Mon, 19 Dec 2022 21:12:30 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4NbXTn2ln9z2T;
        Mon, 19 Dec 2022 13:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1671484349;
        bh=twaUYurFKPDkZpNU2fCTR/GrB7eDAue/bZi8A5G/Msg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=jlRzFdgNEceyFyHAPDyMA/QBWTxG9VVKGMxpco48CX4Qux+Jcb6/k1rSqenviii6w
         vwk1PCqOG9kDgAW+qBZr+yVNs/VJ5pHStPPTZjLrsG5qM7y/NFNMif7sEOLK+F4YWC
         F9MyGhLTj5CH7hK5eaXlAV13UJZmS8hZrNm91258PBQ2C0ycrT4daZyEgtaj0jMkQv
         Yj0kaBOr5ON7Yu3zt4O5S9ifh2TK2zJdKJYo9+e+5QPb201EOLd+YITekaUOR6M9h+
         iG+tPQlW4RmWOCPjPcfjUN5Wr5MAN+d42GzgyvGYA3UTDurRnmfLX7DOnTyc3o5lje
         U0wadYgenX3aQ==
Date:   Mon, 19 Dec 2022 12:47:44 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/mem: Support sanitation commands
Message-ID: <20221219204744.rna4khfjdyt4dugx@offworld>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-3-dave@stgolabs.net>
 <20221219174329.000073c3@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221219174329.000073c3@Huawei.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 19 Dec 2022, Jonathan Cameron wrote:

>On Mon,  5 Dec 2022 17:15:00 -0800
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Implement support for the non-pmem exclusive sanitize (aka overwrite)
>> and secure erase commands, per CXL specs.
>>
>> To properly support this feature, create a 'security' sysfs file that
>> when read will list the current pmem security state or overwrite, and
>> when written to, perform the requested operation.
>>
>> As with ndctl-speak, the use cases here would be:
>>
>> $> cxl sanitize --erase memX
>> $> cxl sanitize --overwrite memX
>> $> cxl sanitize --wait-overwrite memX
>>
>> Where userspace can implement entirely the wait/query mechanism for
>> waiting for the sanitize to complete (albeit no poll support for
>> the security sysfs file).
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>Hi Davidlohr,
>
>Given I'm late to the game and there has been lots of discussion I'll
>focus on just the ABI.
>
>> +What:		/sys/bus/cxl/devices/memX/security
>> +Date:		December, 2022
>> +KernelVersion:	v6.2
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		Reading this file will display the security state for that
>> +		device. The following states are available: disabled, frozen,
>> +		locked, unlocked and overwrite. When writing to the file, the
>> +		following commands are supported:
>> +		* overwrite - Sanitize the device to securely re-purpose or
>> +		  decommission it. This is done by ensuring that all user data
>> +		  and meta-data, whether it resides in persistent capacity,
>> +		  volatile capacity, or the label storage area, is made
>> +		  permanently unavailable by whatever means is appropriate for
>> +		  the media type. This causes all CPU caches to be flushed.
>> +		* erase - Secure Erase user data by changing the media encryption
>> +		  keys for all user data areas of the device. This causes all
>> +		  CPU caches to be flushed.
>
>General rule of sysfs is one file, one thing.  I think this interface needs splitting.
>RO attribute security_state
>WO attribute security_overwrite (or maybe security_sanitize as overwriting is an
>  implementation choice?)
>WO attribute security_erase

Fine by me. How about instead: security/{state, sanitize, erase}?

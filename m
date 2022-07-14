Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5A2C43334
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 19:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiGNTbR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiGNTbQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 15:31:16 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC92850062
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 12:31:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BD7BB6C2800;
        Thu, 14 Jul 2022 19:31:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a243.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4ACEE6C2837;
        Thu, 14 Jul 2022 19:31:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1657827070; a=rsa-sha256;
        cv=none;
        b=bLqwwofH4UiqUqOLJZroVkcXdSu1Ry/h3IVekkoWBcnAE9VHuhsTUgkr0BJYnMFSx47ULT
        EUtlIl7CopmsM+Nqu9Rno0Mrxd4fuu1WwY57EFvk1q3ZkDSmf73Hcz+YAwcrlXpvDPagwJ
        5Y8qqPu4jiGa5cw8tPpvhFG5DVP4WnvsZ6dsv55iilyi9rrbrADq7blWVbzSwKCx/elnHO
        NfgYtXIy9uiWfscZLU4B1/99lfOI6uoDfzGMGE2NKFxWOgYeQnavHKZmEJaO1Z98e9OKqp
        gU2DODb9e9sGZ+y/VaEngw1r51mPd73EK/dQN/E927ryUZrrmZICsJ+OpWqk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1657827070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=yWKK3bEV46rE4r0Tj8RjOVeXPsiolDVez52sLvjeGgk=;
        b=mQDWmJR8mC/P7OqBIGaRueXayjXK9X18nUTITmM5WR2uhGPq5hFXdM4/VW+2GOASTCzDmr
        2xpZxYtmkSOyx6eycjMospVk0PpFr7j5JDVOfrjILv1RaikJkxU3OF/8arBmgO5bdkQf2n
        MhSEO5D09Cd0D2b0JMYK9Wgy/Okps7ML2BT0bJMgWZz66PxRwszrZENklhriL+p5bdkFYL
        pgf6TlacKAPAyTlVfKt8qAzgZqbA6z/d/WSf5viM5Jpfj8W+5yC8Rg8fTETTlak5BexvKv
        PQVJF7urVBlqOQWF7S20tleVTnVwTMSmUKAw6VWvHDmqO6ztlSKYhD1nGVgnDA==
ARC-Authentication-Results: i=1;
        rspamd-674ffb986c-2djfm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Average: 398c09655aea1293_1657827070624_1677813914
X-MC-Loop-Signature: 1657827070624:1643253323
X-MC-Ingress-Time: 1657827070624
Received: from pdx1-sub0-mail-a243.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.242 (trex/6.7.1);
        Thu, 14 Jul 2022 19:31:10 +0000
Received: from offworld (unknown [104.36.25.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a243.dreamhost.com (Postfix) with ESMTPSA id 4LkPjn5SjjzZT;
        Thu, 14 Jul 2022 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1657827070;
        bh=yWKK3bEV46rE4r0Tj8RjOVeXPsiolDVez52sLvjeGgk=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=BLtKSa9Um0xkLgc4I2ag4urqMYyygHO2yvbMzVEf0rdscaZdrq9SaoOT2YItV+Ssy
         rl056L070ulhnM1+SbBnk/68eqNv6AAte8ZE331GnQbG5IbbnPPpWopY4pFlFdb4ak
         Tk13BVVopcxdty9tRcjP3WgCkGsxXvQC/RJQYjFQ0HgzONrTsmQsgzUnR2hiSZgVSi
         Z6ViMy2Uds20tq/B8iQrSKj1HZ/IsCgE4OHNwSxVQR28Vna576fGjvO/2yK78aV7KT
         PBL2dDcLkP9Uui/jQ1IW8RMPYr/uLCJLTgRgpPOgZfG9wt23c3pPQUCdMF/eBNn2L7
         sfiBnn4Lc2iew==
Date:   Thu, 14 Jul 2022 12:15:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH ndctl] cxl: Add list all option to the cxl command
Message-ID: <20220714191521.sy45sjpkpxijdefr@offworld>
References: <20220714182737.60714-1-sunfishho12@gmail.com>
 <8546b123eb6303db6b863a2670d64aa87434f196.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8546b123eb6303db6b863a2670d64aa87434f196.camel@intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 14 Jul 2022, Verma, Vishal L wrote:

>On Thu, 2022-07-14 at 11:27 -0700, sunfishho12@gmail.com wrote:
>> From: Matthew Ho <sunfishho12@gmail.com>
>>
>> This adds a new subcommand cxl list --all, which is equivalent to cxl
>> list -MBPEDTHIiu. This addition makes it easier to list all the CXL
>> devices at once, as one does not need to append a subcommand for each
>> device. --all is also easier to remember than -MBPEDTHIiu. When
>> region support is added, this will be updated to include it.
>>
>> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
>> Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
>> ---
>> =A0cxl/filter.h |=A0 1 +
>> =A0cxl/list.c=A0=A0 | 15 +++++++++++++++
>> =A02 files changed, 16 insertions(+)

You also need to the manpage (which I also missed) via:

      Documentation/cxl/cxl-list.txt

and of course, same for Vishal's suggestions below.

>
>Hi Matthew, thanks for sending this - I agree it gets tedious trying to
>list multiple things.
>
>However, I think we should do this similar to ndctl-list's --verbose
>options, where adding the number of 'v's adds in more and more detail.

Yeah I agree, and was not aware that ndctl has this. Furthermore perf
tooling also uses this.

>
>For example:
>
>cxl list (default) : Regions and memdevs (this isn't there today, but
>in a pending series I'm about to send out).
>
>cxl list -v: -RMBDPT
>
>cxl list -vv: -RMBDPTi
>
>cxl list -vvv: -RMBDPTiHI

Makes sense to me.

>
>-u/--human can be excluded from the verbosity levels as that can be
>passed in if needed, and there may be use cases where it isn't desired
>(in scripts).
>
>Thoughts on this - do you want to take a shot at implementing it this
>way?

Sounds good to me.

Thanks,
Davidlohr

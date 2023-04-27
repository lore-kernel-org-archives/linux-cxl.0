Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ECBC77B61
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 16:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjD0QSe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjD0QSd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 12:18:33 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B93ABC
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 09:18:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7C7DB3E1F4E;
        Thu, 27 Apr 2023 16:11:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4BBE83E183C;
        Thu, 27 Apr 2023 16:11:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682611862; a=rsa-sha256;
        cv=none;
        b=iga0dwRK5eBbNDcK/UnKz2rxr6UbyxVlmZu34AgtGBamqdWi7l0KA/3bBWFpTGci5rm9lG
        yQN/V7xv9rRRSEzXo66ra28AHf3c2Kss/Sd6L24O6+0+PPLu1aoCi83WyjUrVU7Mag48C2
        sIA0hshgg5DfXk24NWqZYmsfvEGQeqNc6IOrOiC9SUy2bRt2iZz6a4rQFL10dTWH3I1R7H
        Z9K/RnHpj4cx+h5IRfcpzNmW39hvuTzjtROnQ8XrjV1ltgi9EeuHlmu5PjwZ73LQ6hPx0S
        ZhKP6ObEdCHlN4lrzSnghmuYN9a+rKb1tCe0CHoFkfNQqext1cC1JvScIi7X/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682611862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=gSdmaJWUUBewH0XJ41Q0GjNIILGRWyi8f6/q5Xn+ZxA=;
        b=ED64X7Mur+ZYH74/RIEwiO886RhDBI6qWcei0JXBYXBh2ViC1jyIiJnmkDnIm7vrAMTSM6
        kyaujmyMPsGUsRCfahkOP4pUZ4+f3rBZ5wo4fb1FihF21ElJleKCxOuP6Sp4qt+xalP5EM
        U5Fn44KR5RZgTJ/A4y2a4gGfyjUG3U2x4qb/cLyGBL7MZ9lIBU8vZ22E+mgK+Ggsw2Z9fs
        qtn19V2Ajk4sgY6samkYs1xhl47ArMoQAXLfyyLc/76TmsYE6TXIX05eSBPUs9aBts9FVr
        3oDTFR5Sy18hkt75nE1bgA57DF7TbkaL+efgVLb83qKbfLdfWKB2GM9I9MCNRA==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-4qj5j;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Obese: 04764cc667117151_1682611862235_1515290143
X-MC-Loop-Signature: 1682611862235:1809103070
X-MC-Ingress-Time: 1682611862234
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.244 (trex/6.7.2);
        Thu, 27 Apr 2023 16:11:02 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4Q6ghM6rtkz3Z;
        Thu, 27 Apr 2023 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682611860;
        bh=gSdmaJWUUBewH0XJ41Q0GjNIILGRWyi8f6/q5Xn+ZxA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=BV+bzxtsKtoEshJKvHcuUD5RQ0cAhhfrZdS1NSwWRSXwLxhsULGd++Lwo78oCXINy
         NKseyF3Kinou2J8vb18vxWUUv+DjMgkQgNS9ZKm8lBsOObomnEic/rYRSyvaBeZGuw
         8LkxlEicng2ZrxNs+1HUS6jDYycDCamcJaj8BPsEiiM11TfZnk5pzrdY16IceBehwC
         oRF0CfyXDwrA7/EMnObEe8ngHK0YWw7//hhBMKTyJHxA7Rn+ecizrxGq4ou8kBQPe2
         M/s06u+ZFsKdu1f8Z53o+wWlg03EwtcNQcghAcdcGMXzMrHECkWGvaHbJJeUnddgKb
         rEMTH64pjBrTw==
Date:   Thu, 27 Apr 2023 08:39:10 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v13 6/9] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <iurygq7c3gg6gskfzgnl3mkr7trbpnp3bo6nzqiwyonzw2kscy@w5s3xh6fkell>
References: <cover.1681838291.git.alison.schofield@intel.com>
 <1081cfdc8a349dc754779642d584707e56db26ba.1681838291.git.alison.schofield@intel.com>
 <rjgz474mou55qufxwwmy3vpxftagdys6ge3iqs3guqukkw3jlv@ho7vuf7bmjsp>
 <ZEn19R/iusbbkPau@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZEn19R/iusbbkPau@aschofie-mobl2>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 26 Apr 2023, Alison Schofield wrote:

>At the moment, I have 'trigger_scan_media' that results in a spew of
>scan media results to a trace file. I guess we'll chat more about
>presenting a _nocache, when I post for review.

I'm not crazy about calling the interface scan media straight how just
because it's very unintuitive - albeit users that care will probably
don't care.

>
>I'm concerned that a  _nocache_ will lead user to believe they are
>getting 'fresher' results, and to over-use it with that mindset.

Agreed.

>Get Poison List gives accurate results and Scan Media is only necessary
>when the poison list has overflowed. OK...here I go opening the can of
>worms myself ;)

trigger_poison_list_overflow?

If triggered and the list hasn't overflowed yet, just be a nop?

Thanks,
Davidlohr

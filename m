Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF897EB64D7
	for <linux-cxl@archiver.kernel.org>; Mon, 26 Jun 2023 22:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjFZWL2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 26 Jun 2023 18:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjFZWLQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 26 Jun 2023 18:11:16 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7838E3A97
        for <linux-cxl@vger.kernel.org>; Mon, 26 Jun 2023 15:08:06 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9945C641BEF;
        Mon, 26 Jun 2023 22:08:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4D9566417CA;
        Mon, 26 Jun 2023 22:08:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687817281; a=rsa-sha256;
        cv=none;
        b=3Yl1mbwtseQzSYK8nEa59Bl5XUaFOOZH4JgK3Ct9SUGp2y+WdC8+zuqbJ3Im4Qeznp+YoI
        4OwIcFaZl/gt08zG881Wfh9GNkTFa5zc0HRyoAxR/BCdc7DUkdtYOI3WEzogl3PdKpPdHH
        GqVO84gLQDfg5uhS38XPP7a09A34MYqABGA5uzOxttYPnwNmf77kOFgs4BOSu8x8pKqAoS
        seD7CrcPkVgvMEmkX4F80cyy8gDOb31MWruP9Hq/3AajrPNN/dTcCsNv2l0m8bkJoXkcYH
        7l1GB6Ae8+3WC/NRreV8jCzGMMW4+Qdg8+I9iY3dUp2YHDj1wEPjOgwoDKDuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687817281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=OOPnw0Xtk1GuUQHoF4meQ2eV2F9wx3waLvV64d4tLN4=;
        b=N2xfoiNZ2cLFiD77areQuZgvzdXua80fVSlVub99XBhQhzANVAFtEs4GV0oscYCXHsn32N
        +4NWHM8GwkM5a25TSkhzLOmOfP/5Yqof+G8qRI4n3hX3PVhEIWWwl2T02gODp8CFm6fShi
        hJvg6iTCV+GZCvOyTnhkzuCvhzyGhxwgNdpd6igYcl8hk9bzcB8K2gwVBwlL6DkoCBnHvy
        fyFqF20TIH7bcqHk27qWGm3TAk8rrzqMjsb9XozCIRpQBXYWskkN92Odc+X2VyJqa+AWIX
        Ub14ZdjP7bHNXavDhNTIeRW3eWTUyKs3AnTWR2rgE9VNSjOlOSUOxdC+3uTccQ==
ARC-Authentication-Results: i=1;
        rspamd-9fcc56855-gcssm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Cellar: 3f310a13451fb7cc_1687817282403_3261843728
X-MC-Loop-Signature: 1687817282403:1665034919
X-MC-Ingress-Time: 1687817282403
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.91 (trex/6.9.1);
        Mon, 26 Jun 2023 22:08:02 +0000
Received: from offworld (host86-183-53-156.range86-183.btcentralplus.com [86.183.53.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4QqhmX1MCQz46;
        Mon, 26 Jun 2023 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1687817281;
        bh=OOPnw0Xtk1GuUQHoF4meQ2eV2F9wx3waLvV64d4tLN4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HOyjKxo0xRZWlISxv83Cks1FA11BKN4YXGjoR/ojI+r+PH1Z3ahd6bu/cmtQJYZYB
         7DBOL3unZMQMwWTgui/6eOHWQuq6tJMHraYgWrGy7CFco1/j0SNgUA5C7Z0ad3rViS
         COCpY8R0uatL70up0wFyXkKQ2LFJEfQSK9a/nng4k9shdIcFfVNfkiBadqd5nvqSPS
         dxBSdBene7VIui98st8zooxLxhgZXVJl9SkKPJPB8bRSMu1Cln4JMbHdMQveG6CcMa
         JpMUCUxtEsdJo+Kz5RJYTTMTmzJYulNle9+Q12duo7x54dZOVrbmwQ59zB9o82FEBv
         vYX7DdS2H0hpg==
Date:   Mon, 26 Jun 2023 14:32:18 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 0/7] cxl: Support device sanitation
Message-ID: <ll3imaqzzqkhmsa2r4rxxzhmgnpoayuasb3ay5dfx47f7avco2@j6bmlcelamco>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <6498c35a934ab_8e178294b9@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6498c35a934ab_8e178294b9@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 25 Jun 2023, Dan Williams wrote:

>This looks good to me after s/([sS])anitation/\1anitization/ throughout
>and some othe minor fixups that I mentioned.
>
>Merged for v6.5.

fyi per https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=pending&id=0c36b6ad436a38b167af16e6c690c890b8b2df62
this seems to be missing this fix:

https://lore.kernel.org/linux-cxl/ispowzuk5fg2u7zbpenocvyihh4t3kywtszcbg245unypzduex@jenknfy62rjl/

Thanks,
Davidlohr

Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E95DEB64D9
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Jul 2023 16:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGJQNG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjGJQNB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Jul 2023 12:13:01 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C41A11F
        for <linux-cxl@vger.kernel.org>; Mon, 10 Jul 2023 09:12:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EE4B76C1C59;
        Mon, 10 Jul 2023 16:12:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 158926C2039;
        Mon, 10 Jul 2023 16:12:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689005577; a=rsa-sha256;
        cv=none;
        b=AOWsXpZc3S/zEprDk3x6q8ABL+oJTydWC0GnlXKUmriZx+f/ItzfriItzSZMH+JLNwKRzw
        oqKbKlxfu6ziLQBPk/ABEZZil+VrjMuDtyoH7sE0bHXT74uQI+96X3thWgZyH2c/TB8OXm
        f5ryzKin88PQpIvotegnCXTCi8HutgTF/Cx0BQz6lnvBq+Iy6mbtfuyWVJWZVIoCHJ93BF
        1ryLJZD4rBCawKgDvju9sHCeisxCMM403XSexdzU67MERvUXDNZJMh95BdvNRH2eyyrjTm
        TKJRZYOs1WE88X5nu5X5xqAGNV3jApKEDDiQkAYX6dStm3XP7JFuyMScnvmdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689005577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=8L32kq3qzWCO6ysyOFQIZqQGPy5sVzk6EvCBa/ThBAI=;
        b=MffjqDC+hnY7FiiLiGeqnr6Vm6diexrBwrVBTmtTZIKaUTJ/hLSa9CV7LhZJfR2t5SE8R3
        lMxapGnSFfWKOUJNM9DwZUqOgWVqHd0GLC1x7l44fMo2ksSVST9tOUI14SeElUdmJnhZIw
        SEwJxPOvWXouNoFRYnteMVeFUtwVcT5jAqkwXzCnqqUsipzVTg9hyoZeCjMJYqQFJo2cBT
        tMhMTuSGU50kRpsoY5hf3uczNIBX7HJuwSUS3U86y31+95sK4tEch8B69v2z3dlaExqXqf
        yRiijbEJ/Mff74ci0y43ERpopzcynIkncno9lcxhRem0fjZc4T+lRcgJP2G3kQ==
ARC-Authentication-Results: i=1;
        rspamd-7d9c4d5c9b-rvf7c;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Broad-Abortive: 0bfa44600ac13a95_1689005577397_1069515946
X-MC-Loop-Signature: 1689005577396:1513233869
X-MC-Ingress-Time: 1689005577396
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.120 (trex/6.9.1);
        Mon, 10 Jul 2023 16:12:57 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4R08DR73qGzLt;
        Mon, 10 Jul 2023 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1689005576;
        bh=8L32kq3qzWCO6ysyOFQIZqQGPy5sVzk6EvCBa/ThBAI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=nSuQzrFDMAMd06a/hOzuYKvj+Hc8s2JZBhbPb2JABKKrz8Ed/ZGpep8f65M4xG/EH
         9KFKTzGovEG5FzEgYEZh2DZ2RvWEkU8lg77RQu9mhFswCZYmqZpu5XYBf426GggtMz
         Qkm0bWvmzkvmPXo18P1X37yjKtspxnu+38/XjaXCAPUzL9KvUiMAIJEjKZlDGaX7DL
         OQ3R5gahnqzAYxGl58doXZExG3qTUWIgF/YwtFLJ+tL3cY/ortLvVcbKNN7PxiNGJL
         Uw4cEEVumzomtRsC4AcBlEglnRSF3Jpc4+5DJcoBxD1zSB7HBxrQuUCkIeYrcb+1m3
         IH06PklInF/CA==
Date:   Mon, 10 Jul 2023 08:36:39 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Fan Ni <nifan@outlook.com>, linux-cxl@vger.kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, nmtadam.samsung@gmail.com,
        fan.ni@samsung.com
Subject: Re: [Question] How to set up DVSEC CXL Range Registers for DCD
 devices
Message-ID: <qvclgbexammsjxgnoqc7oeeisofl62escgjnzhqdgnapfj4pqi@zcl2jh2slajy>
References: <SG2PR06MB339718DD083E76EEA06008F2B225A@SG2PR06MB3397.apcprd06.prod.outlook.com>
 <20230706094620.000035d2@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230706094620.000035d2@Huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 06 Jul 2023, Jonathan Cameron wrote:

>On Thu, 29 Jun 2023 10:10:48 -0700
>Fan Ni <nifan@outlook.com> wrote:
>
>> Hi,
>>
>> When preparing the DCD patches for QEMU emulation and testing, I hit an issue
>> when trying to load the cxl modules. The issue happens when the kernel tries
>> to do cxl pci probe where it checks whether the media is ready
>> through cxl_await_media_ready. The function will check dvsec mem range.
>>
>> In current QEMU code, the dvsec range registers for type3 memdev is set
>> only for static ram and pmem in function build_dvsecs, which will cause
>> the kernel fails the check of media ready of DCD devices without static
>> capacity.
>>
>> About the issue, I have following questions that want to ask and
>> clarify,
>>
>> 1. do we allow DCD device have no static (RAM/PMEM) capacity at all and
>> only dynamic capacity?
>
>Yes.  That will probably be a reasonably common configuration so definitely
>want that to work.
>
>>
>> 2. Do we need to set dvsec range registers for dynamic capacity? And how
>> if needed?
>
>hmm.  I think we should.  Given a DCD device is not an eRCD (though it may
>be operating in RCD mode) the memory types are all from CDAT - so I think
>we 'could' use either one or two ranges to cover the DCD range.
>
>Desired interleave is messy but it's only a hint anyway so meh.
>Memory active timeout might potentially be different for say a PMEM region
>between a volatile range and DCD range but I guess it just needs to be
>the biggest of anything covered.

Btw, we probably want to robustify cxl_await_media_ready() to 1) check for
Mem_HwInit_Mode=1 and 2) rely more on Memory_Active_Timeout to set the module
parameter.

Also, I was under the impression we wouldn't want to set the dvsec for dynamic
capacity exactly because of the active memory timeout, which makes no sense
for dcd.

Thanks,
Davidlohr

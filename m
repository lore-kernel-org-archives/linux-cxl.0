Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DA8C54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 22:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjA3WW0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 17:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjA3WWZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 17:22:25 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCB039B86
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 14:22:22 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1DBE4821A20;
        Mon, 30 Jan 2023 22:22:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a221.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8D65E821E2A;
        Mon, 30 Jan 2023 22:22:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675117338; a=rsa-sha256;
        cv=none;
        b=Ji8ea/VhO/gyBIH6lsTpKMUKnl0oZqBCKzQ6CTjwtswC1EuBGPUy/ItoXpRTdseBxf7yM9
        UuGUEkfqSQlJkqNMwi1R8P0S64Rz7o08r7zHRIaRwkDpjLDZyfhwkbQJxHgtJZ2dhHigzg
        BlfNjKzfHgZ12CpD6DH1BYnKP7nMij8gqw2mW/H7QdhL3HDslw56/zpFQ+tg1200IeN/CP
        /GtnAIrHee1BqDyutgsRq6v2VRW1CKKI5YKHIxVF4Cam2lwWiQEdzHtlHPmxi6+eq03tX0
        1Ff+mMpi2jjqCj2zNL5E4E+YVIAa5nXCJEGL2rPD6oxiOMLY9sKVeO3AYrzcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675117338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=3wSCLvnvykBahLskQERa3cHLXICwFksGbKpLcEhDQdg=;
        b=5IiJgr8b20jHsuKDpOx0Z5Q99A3pwiQrApsRK1CgmeYH49avWAU7juSNH9lC0S1azE1kzV
        xYCdyD/WwmKx5t0eToE3QUQSLyo7PYsHlacD6WiMLfJdCldRcouRc0n1T3dp4pvh+5xGhH
        1Oi+p1LMTpAGqFOeYfTiCeiDoy1GqwMQT2dLYXDhdPEMDEuv+GFwg1cmNyjlkRcqxAxbzV
        Ges1cZxuJVPHGCcwXCh4pSkCCy20QDG54XdatTKD59DFlLBDKToxIUa4qHZk7zwMTngjPw
        Ff3xSMevWLVWDMBQ91Ocy9OeyUdGBBQjG7ipRDqxU51y5uMJd2Oy/PiPRo/IfQ==
ARC-Authentication-Results: i=1;
        rspamd-5fb8f68d88-mcdm2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Cellar: 74025b3342eeb0b9_1675117338911_3914163511
X-MC-Loop-Signature: 1675117338911:4027687716
X-MC-Ingress-Time: 1675117338911
Received: from pdx1-sub0-mail-a221.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.237 (trex/6.7.1);
        Mon, 30 Jan 2023 22:22:18 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a221.dreamhost.com (Postfix) with ESMTPSA id 4P5N2x453Zz22;
        Mon, 30 Jan 2023 14:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675117338;
        bh=3wSCLvnvykBahLskQERa3cHLXICwFksGbKpLcEhDQdg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TFsri0I35sj/kVoUMOF03wT3U1iynj6Hdi9iFM0p8MdTWOiGBBUqMIgRY/ZaMfx7l
         iws++OS+z5DkPePY+KKqgXQCB+69HqwP8EoX7bqU97eB1QXfcQ7lqSwcMhFuxWASfD
         kxRYIPAHO97SgGC6bmUh/NImE+gC9/8PrrrSucOmezcc/jk9wVCA2wGvvHxvXPsdsC
         2yk3NJBi/kmJ7r3bBiXIt0q9BHscbXbSs2uwLeTTlb0WUlEFX5tfUdwNucqQBO4ySo
         O0SpNJoycpw70efzSCd8mSJ30slbpf1E8I+2hM3d5PUb7rP8zbJZbI4uCQHZSfbwWg
         nXytA/B42WNIA==
Date:   Mon, 30 Jan 2023 13:55:14 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     kernel test robot <lkp@intel.com>, ira.weiny@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org
Cc:     oe-kbuild@lists.linux.dev, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [cxl:pending 13/21] drivers/cxl/pci.c:511:8-33: WARNING:
 Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless
 it is nested IRQ)
Message-ID: <20230130215514.6cviyuwhxgjlzj27@offworld>
References: <202301291620.DxnDWLoW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202301291620.DxnDWLoW-lkp@intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 29 Jan 2023, kernel test robot wrote:

>BCC: lkp@intel.com
>CC: oe-kbuild-all@lists.linux.dev
>CC: Alison Schofield <alison.schofield@intel.com>
>CC: Vishal Verma <vishal.l.verma@intel.com>
>CC: Ira Weiny <ira.weiny@intel.com>
>CC: Ben Widawsky <ben.widawsky@intel.com>
>CC: Dan Williams <dan.j.williams@intel.com>
>CC: linux-cxl@vger.kernel.org
>TO: Davidlohr Bueso <dave@stgolabs.net>
>CC: Dan Williams <dan.j.williams@intel.com>
>CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>CC: Ira Weiny <ira.weiny@intel.com>
>
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
>head:   ace4b76d4ab70335cffb5a1c8450d3b34c16771a
>commit: a49aa8141b657a7fd33d86f7bed3ca07567ab37a [13/21] cxl/mem: Wire up event interrupts
>:::::: branch date: 4 hours ago
>:::::: commit date: 2 days ago
>config: microblaze-randconfig-c043-20230129 (https://download.01.org/0day-ci/archive/20230129/202301291620.DxnDWLoW-lkp@intel.com/config)
>compiler: microblaze-linux-gcc (GCC) 12.1.0
>
>If you fix the issue, kindly add following tag where applicable
>| Reported-by: kernel test robot <lkp@intel.com>
>| Reported-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks for reporting, and I'm adding more folks explicitly to the Cc.

>
>cocci warnings: (new ones prefixed by >>)
>>> drivers/cxl/pci.c:511:8-33: WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)

Considering MSIs are edge triggered interrupts, this should be benign.

Thanks,
Davidlohr

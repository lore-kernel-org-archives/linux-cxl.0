Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9EFEB64DA
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jul 2023 15:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjGEPZv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Jul 2023 11:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEPZv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 5 Jul 2023 11:25:51 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3F8F7
        for <linux-cxl@vger.kernel.org>; Wed,  5 Jul 2023 08:25:49 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CB854140CCA;
        Wed,  5 Jul 2023 15:25:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 307D414122C;
        Wed,  5 Jul 2023 15:25:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1688570748; a=rsa-sha256;
        cv=none;
        b=J7WJnYRX6pM1/OUbifoTvAljNo/lWo6ohIFnBNgbgrF0/MO0ikj3gg5I5GtduZdbHT4Pz9
        Tcjc/h9Yach+tRbPKbOkyHKrBA67jXi+gTub95OR/ZeqVxHBz2pjpOn4TIS7uzn1xmCy7W
        Mz+5ifHUx0p/DvOJF7u2BMY7011FHwuLZhVzcHEtLAGmYSNYNyAYiDmQ99pFcRmH2ZUYqx
        xwFxTQ8nyid1bzrHUpumKPru/LtkJTB8APl6GOmBYOMYoTPvmVxA7c5e98x5j68abOve8p
        8a+TQzK/T+Ea05NjIfzyiLJyYk4I3iwuBTE4umCwCypCMEWEROtIjASoXvJRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1688570748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=GYKUvwL3MfU+YCMLm3BJExzI+1oyu739JjjoqEfmW20=;
        b=wnAb4EqQ/5gHNrzUb8idSaN3lnUSiKBuWvZIPl/SPio1Qocchuyy6+3b0Ty9YrhpQv01wf
        2MbJnLG45gy8NvbrXaIWF/Cvuxy6XA4pWzT+p9qEoLlSrXsZkG+gms88HvztYZu2MoOht1
        8udT9KPmmei8zCBEEBSzLy2i+wgeri0383ZFQoMqe4FwuDSsQlFMjwuziYoWtTQ7uE/glK
        Qa+lSkHNyjaFjvlKOErLkJCH0+BEn0Dt7syvLUEUDuRn1/RCsKcL+9lQPapNkQdl2SE/6D
        wjXxy0u5uVAf6uCI98fWQUqJN9RG1aWAsCc1f/KPlSo7FyqDLwO4f8tuUhxEnA==
ARC-Authentication-Results: i=1;
        rspamd-9fcc56855-twxqs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Industry: 2be2260d5380b1b5_1688570748563_992489489
X-MC-Loop-Signature: 1688570748563:438952908
X-MC-Ingress-Time: 1688570748563
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.48 (trex/6.9.1);
        Wed, 05 Jul 2023 15:25:48 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4Qx3QM3xTWz6n;
        Wed,  5 Jul 2023 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1688570748;
        bh=GYKUvwL3MfU+YCMLm3BJExzI+1oyu739JjjoqEfmW20=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=M79PYyKq/qnupRyJ3sfLnBHDU8qiH+DDLp5nYv3fGlajc9kE4GdgUK6VWYRdPh2kM
         cBVwK0JVbRcAtqKERko217rxCXckGjcIsKWQAmmoEkLYyXqAicTRmokN2VYehBY0Jz
         VERjk5b4C2jJzGNjyvxRwrLln1hD3wHBbY7sJY5XlQeqz1NYQAVvqsLPhurWt9G2kc
         RUjFnw18eI9hHOW2L10sjs1mTqXBsxSx63KIfU+9k3ra4+40+5HlW/bK5YQuEk5PAZ
         uqejwNEU+JLikcgVFfK0CPX+KQs5EOuds05R8DYXVJAKY20G6Puac89MmtvaUKoQ2H
         6oE1hT+Prtvhg==
Date:   Wed, 5 Jul 2023 07:49:47 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     ira.weiny@intel.com
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <fmbpzsfvap2msiussk6p4772ddinsfnhfh2aqixzdtewmjbj3f@cp7qpgzcqf6e>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 14 Jun 2023, ira.weiny@intel.com wrote:

>+config CXL_DCD
>+	bool "CXL: DCD Support"
>+	default CXL_BUS
>+	depends on CXL_REGION
>+	help
>+	  Enable the CXL core to provision CXL DCD regions.
>+	  CXL devices optionally support dynamic capacity and DCD region
>+	  maps the dynamic capacity regions DPA's into Host HPA ranges.
>+
>+	  If unsure say 'y'

Does this really merit another Kconfig option? What are the usecases for
this ever to be shipped as disabled?

Thanks,
Davidlohr

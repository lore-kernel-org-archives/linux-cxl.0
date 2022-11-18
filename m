Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A45C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Nov 2022 13:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiKRNxT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRNxS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Nov 2022 08:53:18 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F62B1BE96
        for <linux-cxl@vger.kernel.org>; Fri, 18 Nov 2022 05:53:17 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h12so6825979ljg.9
        for <linux-cxl@vger.kernel.org>; Fri, 18 Nov 2022 05:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTmy7DaNbgodXmvBotH5A/SkGmzj0zKuVyDL5rf5T2o=;
        b=dETl6XOrA6dvb1LJ8+bZ6h7Dq4ixXZPwQbxQzYx/1qskJGVmlwrzqbA8SGsLXMl0Y6
         RebwJ79Tv/CeZyuL2LKaevKIRrGcPW5HTgSSMM24YVgpQkBOwhWs1rGSQ97XGFDr5f4E
         aBCzqJlY6s2A5TGTPU+ujQUf5PRbN4c0QYp2ewTByZ3swyrFjS022tvs6MQCmZc0EsqU
         MBP1BHMAlwekJTsus/s8177du1JCiSUroJfeVLrKhQHI1HnR1zZIx6h9sZ0k7Og7YBJA
         pQbXFC9+sX9isCTqfI3oO2B4E84q0ecaUCK/LYde/V310zPcU9if76E7N9GrF6UYE1w4
         RotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTmy7DaNbgodXmvBotH5A/SkGmzj0zKuVyDL5rf5T2o=;
        b=Ay/P0ThVLTbI9SeL7E69kzJ054yoJZqJH6ehNaLBE/e4aFHEo/tZW16iuGJnpl2C/k
         qIvLmSUAQk0/6vPuowyOmeEDK3YYo7l001zA0YxuDWYgJAU7+SLXuzGOEUP/MgIg1TnS
         L6k/sFDtV2fCeIFZXFN6qjcbuupZftel0E+FDgP9G1I1V9dVFY8Dnj4KEBXNGePjrak2
         LUq8FiCuIyyNA1zJtAKXD1u9FRGQOcKD5VNHgQuPVfaFI6xjgIQTd8bvz7ouUh83c3Vf
         dxu5mj2UqNbOhAJ4CE0qLgzXARegyjqwznv4p9yTFHHu1F5vM9heF7xoAqmz8tmWuLRD
         ZTjw==
X-Gm-Message-State: ANoB5pmOVBIWKsZ6e3WYZyUrmb69P2fdq5I5vEQoG3d9JfBi5DZobTjS
        J51ait6hayf1tbdvC/edRJ4IK0M9U+7G1A==
X-Google-Smtp-Source: AA0mqf52yRbi0gkSWxThqqzFIq6OrBBt87Z5pAMl6Tk1KPjCGeaEyRVnIWi4JKQxfPJzfpQ2Xc8FgA==
X-Received: by 2002:a2e:9807:0:b0:26e:58d:e94a with SMTP id a7-20020a2e9807000000b0026e058de94amr2493854ljj.252.1668779595521;
        Fri, 18 Nov 2022 05:53:15 -0800 (PST)
Received: from ubuntu.armcompdev.pub.tds.tieto.com ([89.46.86.70])
        by smtp.gmail.com with ESMTPSA id d5-20020a056512368500b004a65780e4cfsm667772lfs.106.2022.11.18.05.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 05:53:15 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:53:11 +0000
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: trace events
Message-ID: <20221118135311.12cb241d@ubuntu.armcompdev.pub.tds.tieto.com>
In-Reply-To: <Y3bW8CLw8xcbrfav@aschofie-mobl2>
References: <20221114202242.5f9023d3@ubuntu.armcompdev.pub.tds.tieto.com>
        <Y3bW8CLw8xcbrfav@aschofie-mobl2>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Nov 2022 16:50:56 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> There are a few patchsets under review that are using trace events
> in CXL. I'm working on one for CXL Poison Retrieval.
> 
> There is also tool support, the monitor patchset, making its way
> upstream for ndctl that uses the trace events.
> 
> I haven't looked at lttng.
> 
> Can you share more about your project?

Hi Alison,

There should be already plenty of tools using the trace events,
libtraceevent, libtrracefs and trace-cmd, lttng, but I guess
another one may be of use too. When do you think it should be out
for testing?

For the project, it is strictly secret, and I shouldn't reveal too
much publicly, as I was told at least, but what we do we basically
test a CXL root complex in RTL/verilog that instead of being synthesized,
gets compiled to a VCS sim (a simulator) that in turn gets
connected through the BFM (bus-function-model) to another simulator,
simics or qemu. The connection to another simulator is for having
the root complex to test it against something.

So to serve the purpose I need a good grip at what is happening at
a very low level, ideally with the CXL operation taken down to the
register access/mnemonics, especially throughout the enumeration
phase, which we think will the primary source of all the defects to be
caught up and fixed in RTL.

I hope our paths would cross at some point in which the HW will be
finding its way to Linux with all the support it requires.

Any tips/suggestions how I can use Linux for now effectively to
achieve my goals is highly appreciated.

Thanks,
Marek

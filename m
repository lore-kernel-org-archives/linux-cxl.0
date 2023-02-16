Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9539C61DA4
	for <linux-cxl@archiver.kernel.org>; Thu, 16 Feb 2023 18:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBPSac (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjBPSab (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 16 Feb 2023 13:30:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7CA7EC3
        for <linux-cxl@vger.kernel.org>; Thu, 16 Feb 2023 10:30:28 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PHk3W6LF3z682sD;
        Fri, 17 Feb 2023 02:28:39 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 16 Feb
 2023 18:30:26 +0000
Date:   Thu, 16 Feb 2023 18:30:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Not enough CXL HDM decoders in pass through host bridges (sort of)
Message-ID: <20230216183025.00000e39@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Dan,

I've finally been adding support for multiple HDM decoders in QEMU
(need to implement the address decode at EPs, but have it working at
HB and switch USP)

Whilst testing ran into a corner case on the kernel side of things.

           Host Bridge
                |
            Root Port
                |
           Switch USP
                |   
        ________|_________       
       |                  |
     DSP0               DSP1
       |                  |
     Type3              Type3


Previously I'd been testing this with either an interleave across the two
Type3 devices or with just one in use (as I only had one HDM decoder in the SW USP
so couldn't handle anything else)

Now I have lots of decoders, I added a simple test with two regions. One on each of
the type 3 devices.

It fails on the second region (with a "no decoder available error") because...

It's trying to find an HDM decoder in the host bridge and the fake one used
for a pass through decoder is 'already in use' by the first region.

I'm not sure we can simply skip the check in this case because cxld->region
can only point at one region at a time and I haven't though through
the impacts of that for a pass through decoder.  The cynic in me says
that if this HB had more RPs, we'd have a maximum of 32 decoders, so
just fake 32 of them instead of 1 and not worry about it any more but
that feels like a hack and probably has side effects.

I thought I'd raise the issue first and think about a solution afterwards
(and secretly hope it is fixed before I get to it ;)).

Obviously I can avoid the whole thing by adding an RP and hence have
actually decoders to use up on the host bridge which does fine for
testing my QEMU work, but we still need to fix this up - unless I'm missing
some subtlety.

There is another question of whether we should make some effort to conserve
decoders - so if we can just expand an existing one to cover a wider range?
We can't do that after commit, but maybe there is a dance we could do to
soft commit a bunch of regions, then hard commit them as a set.
HDM decoders may be a precious resource on some systems even though CXL 3.0
let's host bridges have 32 of them.  One to tackle only when it's a real problem
though.

Jonathan

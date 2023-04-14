Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D837DC77B6E
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 13:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDNNwH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 09:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDNNwG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 09:52:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B5B745
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 06:51:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pyd5n2218z6DF3r;
        Fri, 14 Apr 2023 21:46:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Apr
 2023 14:51:04 +0100
Date:   Fri, 14 Apr 2023 14:51:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mbox: Add support for background operations
Message-ID: <20230414145103.00000eb5@Huawei.com>
In-Reply-To: <6s2gtg7imyiyrkiq54rcxmidzkyfy4bvybfpjm5jikblnvluei@6trlbojork66>
References: <20230224194443.1990440-1-dave@stgolabs.net>
        <20230224194443.1990440-2-dave@stgolabs.net>
        <20230403174730.00003920@Huawei.com>
        <6s2gtg7imyiyrkiq54rcxmidzkyfy4bvybfpjm5jikblnvluei@6trlbojork66>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 11 Apr 2023 12:06:07 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 03 Apr 2023, Jonathan Cameron wrote:
> 
> >On Fri, 24 Feb 2023 11:44:41 -0800
> >Davidlohr Bueso <dave@stgolabs.net> wrote:  
> >> +    } else {
> >> +        /* estimate only */
> >> +        cxl_dstate->bg.complete_pct = 100 * now / total_time;
> >> +        timer_mod(cxl_dstate->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
> >> +    }
> >> +
> >> +    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP,
> >> +                               cxl_dstate->bg.complete_pct);
> >> +    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
> >> +
> >> +    if (cxl_dstate->bg.complete_pct == 100) {
> >> +        cxl_dstate->bg.starttime = 0;
> >> +        /* registers are updated, allow new bg-capable cmds */
> >> +        cxl_dstate->bg.runtime = 0;  
> >
> >Looks like this could all move into the if (now >=..
> >block above as I'm not seeing either of these fields being used after that.  
> 
> I'd rather keep this branch. For one, the next patch will also add the msi
> notifications here; and secondly, we don't want another incoming cmd to see
> no bg command running (runtime is used to check CXL_MBOX_BUSY) and status
> pct complete not at 100.
> 
Fair enough. I still haven't read patch 3 :)

Might make it today!  Only a few weeks after reading patch 2.

> Thanks,
> Davidlohr


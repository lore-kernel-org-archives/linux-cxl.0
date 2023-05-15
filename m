Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5761DC77B7D
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 16:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbjEOQTq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242655AbjEOQTn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 12:19:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4DC359E
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 09:19:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKl0q5tZQz67n3K;
        Tue, 16 May 2023 00:18:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 17:19:32 +0100
Date:   Mon, 15 May 2023 17:19:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <20230515171931.000054a5@Huawei.com>
In-Reply-To: <lhpw35lii4cfrmvebphvhaivjgp2l3ajhnelmtilj5vbvqaxmn@o2ajzugaxbcc>
References: <20230502171841.21317-1-dave@stgolabs.net>
        <20230502171841.21317-4-dave@stgolabs.net>
        <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
        <20230515113027.00001825@Huawei.com>
        <lhpw35lii4cfrmvebphvhaivjgp2l3ajhnelmtilj5vbvqaxmn@o2ajzugaxbcc>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 15 May 2023 08:40:30 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 15 May 2023, Jonathan Cameron wrote:
> 
> >On Wed, 3 May 2023 07:57:56 -0700
> >Davidlohr Bueso <dave@stgolabs.net> wrote:
> >  
> >> This adds support for handling background operations, as defined in
> >> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
> >> can run in the background asynchronously (to the hardware).
> >>
> >> The driver will deal with such commands synchronously, blocking all
> >> other incoming commands for a specified period of time, allowing
> >> time-slicing the command such that the caller can send incremental
> >> requests to avoid monopolizing the driver/device. This approach
> >> makes the code simpler, where any out of sync (timeout) between the
> >> driver and hardware is just disregarded as an invalid state until
> >> the next successful submission.
> >>
> >> On devices where mbox interrupts are supported, this will still use
> >> a poller that will wakeup in the specified wait intervals. The irq
> >> handler will simply awake the blocked cmd, which is also safe vs a
> >> task that is either waking (timing out) or already awoken. Similarly
> >> any irq setup error during the probing falls back to polling, thus
> >> avoids unnecessarily erroring out.  
> >
> >This raises the question of why we don't support Doorbell Interrupts.
> >2 seconds is rather a long time to poll for.  I can't really remember the
> >reasoning but maybe it's that we don't expect anyone to every produce
> >hardware that takes that long.
> >
> >Ah well, job for another day perhaps.
> >
> >I'm not following why the rcuwait is needed versus other options.
> >Perhaps some minimal text here for those of us not familiar with that
> >particular mechanism vs a completion of similar.  
> 
> As mentioned before, rcuwait gives us the single wait/wake semantics we
> need (we are serialized by the mbox_mutex) - completions use queued wait,
> which is an overkill for this case.
Fair enough I guess. New toy that I'd not come across before.

Jonathan

> 
> >> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> >Otherwise just a comment inline on dev_warn for unexpected interrupt
> >on an interrupt that you've marked as IRQF_SHARED which pretty much
> >guarantees you need to handle unexpected interrupts as 'normal'.  
> 
> Per your feedback in the the previous series, I will remove this dev_warn
> altogether.
> 
> Thanks,
> Davidlohr


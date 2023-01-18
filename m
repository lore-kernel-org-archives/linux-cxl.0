Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C568C004D4
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 10:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjARKza (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 05:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjARKxH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 05:53:07 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8369588752
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 02:02:20 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nxgh30KRdz6J6K5;
        Wed, 18 Jan 2023 17:39:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 09:43:10 +0000
Date:   Wed, 18 Jan 2023 09:43:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [RFC PATCH 2/2] cxl: Add tprintk support for header log hex
 dump
Message-ID: <20230118094309.0000008c@Huawei.com>
In-Reply-To: <0907017b-a620-0089-8d10-b3dc92e145ed@intel.com>
References: <20230113154058.16227-1-Jonathan.Cameron@huawei.com>
        <20230113154058.16227-3-Jonathan.Cameron@huawei.com>
        <0907017b-a620-0089-8d10-b3dc92e145ed@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 17 Jan 2023 11:08:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/13/23 8:40 AM, Jonathan Cameron wrote:
> > May not make sense in general, but very helpful when writing multiple
> > header logging support.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> The user logging software would be retrieving from the log data directly 
> instead of parsing the trace output right? Will people visually inspect 
> the formatted trace output? Useful for debugging?

Rather depends on the use case and rate of expected errors + if you are
trying to debug errors before your logging infrastructure is up.

Sure in production, likely these tracepoints would just get stored to a DB for later
querying.  But in debug, I often just use the kernel parameter
to directly dump them in the main kernel log, or perf's own decoding of a trace.

The nearest equivalent to this is AER which does print the log.
https://elixir.bootlin.com/linux/v6.2-rc4/source/include/ras/ras_event.h#L337

though that uses __print_array so maybe that's a better choice.
Don't get the nice offsets though if we do that though...

I'm not fussed about this patch going upstream or not, it just makes testing
patch 1 a lot easier :)

Jonathan


> 
> > ---
> >   drivers/cxl/core/trace.h | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 20ca2fe2ca8e..64f6ad13529d 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -62,10 +62,13 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
> >   		 */
> >   		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> >   	),
> > -	TP_printk("%s: status: '%s' first_error: '%s'",
> > +	TP_printk("%s: status: '%s' first_error: '%s' header_log: %s",
> >   		  __get_str(dev_name),
> >   		  show_uc_errs(__entry->status),
> > -		  show_uc_errs(__entry->first_error)
> > +		  show_uc_errs(__entry->first_error),
> > +		__print_hex_dump("", DUMP_PREFIX_OFFSET, 32, 4,
> > +				(char *)__entry->header_log,
> > +				CXL_HEADERLOG_SIZE_U32, false)
> >   	)
> >   );
> >     


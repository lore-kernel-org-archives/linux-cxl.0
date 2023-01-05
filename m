Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B55EC3DA7D
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Jan 2023 17:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjAERgz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Jan 2023 12:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjAERgp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Jan 2023 12:36:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C2E3DBC2
        for <linux-cxl@vger.kernel.org>; Thu,  5 Jan 2023 09:36:30 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nntn96g50z6HJXV;
        Fri,  6 Jan 2023 01:31:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 17:36:27 +0000
Date:   Thu, 5 Jan 2023 17:36:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mem: Fix command comment
Message-ID: <20230105173626.00005460@Huawei.com>
In-Reply-To: <63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
        <20221222-cxl-misc-v1-1-9343bab16e72@intel.com>
        <63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 3 Jan 2023 19:02:38 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Ira Weiny wrote:
> > The command comment had some minor grammatical errors.
> > 
> > Fix them.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  include/uapi/linux/cxl_mem.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index c71021a2a9ed..555f9140e2bc 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -11,9 +11,9 @@
> >  /**
> >   * DOC: UAPI
> >   *
> > - * Not all of all commands that the driver supports are always available for use
> > - * by userspace. Userspace must check the results from the QUERY command in
> > - * order to determine the live set of commands.
> > + * Not all of the commands that the driver supports are available for use by
> > + * userspace at all times.  Userspace must check the results from the QUERY
> > + * command in order to determine the live set of commands.
> >   */  
> 
> It's interesting that these grammatical fixups further highlight that
> the existing description was a lie. This new wording makes it seem like
> QUERY informs about temporarily disabled commands (like those in the
> cxlds->exclusive_cmds set), in addition to the device enabled commands
> (those in the cxlds->enabled_cmds set).
> 
> It turns out this has always been a lie and the cxl tool checks if a
> command is supported and enabled by trying to execute it if it exists in
> the cxl_query_cmd() payload.
> 
> Now we could either go fix that, or change this comment to reflect the
> current reality that cxl_command_info.flags is always zero and the
> command info array is just telling you if the driver knows how to
> attempt the given command.

I'd really like to see a query mechanism that reflects whether the hardware
supports the command (plus all the other reasons why we might not be able to use
it - ultimately the question is 'can I issue this'). Some commands may
'take a while' so it's not nice to have to issue them to find out if they
exist given the discoverable nature hardware side.

Possible that mechanism is different from this one though...

Jonathan

> 
> >  
> >  #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
> > 
> > -- 
> > 2.38.1  
> 
> 


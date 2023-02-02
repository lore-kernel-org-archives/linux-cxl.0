Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C34EC05027
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 10:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBBKBb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 05:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBBKBa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 05:01:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587908759A
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 02:01:29 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P6vNR4Hp5z67DxW;
        Thu,  2 Feb 2023 17:57:43 +0800 (CST)
Received: from localhost (10.81.211.68) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 10:01:26 +0000
Date:   Thu, 2 Feb 2023 10:01:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] cxl/uapi: Tag commands from cxl_query_cmd()
Message-ID: <20230202100125.0000590a@Huawei.com>
In-Reply-To: <20230202095821.00001a98@Huawei.com>
References: <20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com>
        <20221222-cxl-misc-v3-3-60d4f35e4b39@intel.com>
        <20230202095821.00001a98@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.211.68]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 2 Feb 2023 09:58:21 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 01 Feb 2023 17:23:12 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > It was pointed out that commands not supported by the device or excluded
> > by the kernel were being returned in cxl_query_cmd().[1]
> > 
> > While libcxl correctly handles failing commands, it is more efficient to
> > not issue an invalid command in the first place.  This can't be done
> > without additional information being returned from cxl_query_cmd().  In
> > addition, information about the availability of commands can be useful
> > for debugging.
> > 
> > Add flags to struct cxl_command_info which reflect if a command is
> > enabled and/or exclusive to the kernel.
> > 
> > [1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> 
> No mention of why we can use space in the existing defined flag mask?
> 
> I couldn't find a reason why we couldn't previously but Dan's proposal
> was to reserve that first bit so I'm wondering on the reasoning one
> way or the other!
> 
> Other than that detail, this looks like a good solution to me.

On second thoughts. Some docs for the two flags explaining what they
mean would be good to have (as there isn't a reference to how to use
them in the Docs patch that follows this).

> 
> Jonathan
> 
> 
> > 
> > ---
> > Changes for v3:
> > 	Dan
> > 		Pass enabled/exclusive flags to user space rather than
> > 		masking those commands.
> > ---
> >  drivers/cxl/core/mbox.c      | 9 +++++++--
> >  include/uapi/linux/cxl_mem.h | 4 +++-
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index b03fba212799..6ab4613f3cf9 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -445,9 +445,14 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
> >  	 * structures.
> >  	 */
> >  	cxl_for_each_cmd(cmd) {
> > -		const struct cxl_command_info *info = &cmd->info;
> > +		struct cxl_command_info info = cmd->info;
> >  
> > -		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > +		if (test_bit(info.id, cxlmd->cxlds->enabled_cmds))
> > +			info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
> > +		if (test_bit(info.id, cxlmd->cxlds->exclusive_cmds))
> > +			info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
> > +
> > +		if (copy_to_user(&q->commands[j++], &info, sizeof(info)))
> >  			return -EFAULT;
> >  
> >  		if (j == n_commands)
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index 459a3f7f764b..4aee64b7cc1a 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -91,7 +91,9 @@ struct cxl_command_info {
> >  	__u32 id;
> >  
> >  	__u32 flags;
> > -#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(0, 0)
> > +#define CXL_MEM_COMMAND_FLAG_MASK		GENMASK(1, 0)
> > +#define CXL_MEM_COMMAND_FLAG_ENABLED		BIT(0)
> > +#define CXL_MEM_COMMAND_FLAG_EXCLUSIVE		BIT(1)
> >  
> >  	__u32 size_in;
> >  	__u32 size_out;
> >   
> 


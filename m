Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0252C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 14:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjAaO6A (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjAaO5l (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 09:57:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD38F521C0
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 06:57:33 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5p2P35bDz6J6Pj;
        Tue, 31 Jan 2023 22:53:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 14:57:31 +0000
Date:   Tue, 31 Jan 2023 14:57:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Robert Richter" <rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] cxl/uapi: Only return valid commands from
 cxl_query_cmd()
Message-ID: <20230131145730.00000c23@Huawei.com>
In-Reply-To: <63d81dc17dcd0_3a36e5294db@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
        <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
        <63d483332ff46_3a36e52942c@dwillia2-xfh.jf.intel.com.notmuch>
        <20230130150633.00005cd2@huawei.com>
        <63d81dc17dcd0_3a36e5294db@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 30 Jan 2023 11:42:57 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 27 Jan 2023 18:06:43 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Ira Weiny wrote:  
> > > > It was pointed out that commands not supported by the device or excluded
> > > > by the kernel were being returned in cxl_query_cmd().[1]
> > > > 
> > > > While libcxl correctly handles failing commands, it is more efficient to
> > > > not issue an invalid command in the first place.
> > > > 
> > > > Exclude both kernel exclusive and disabled commands from the list of
> > > > commands returned by cxl_query_cmd().
> > > > 
> > > > [1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/
> > > > 
> > > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > ---
> > > > Changes for v2:
> > > > 	New patch
> > > > ---
> > > >  drivers/cxl/core/mbox.c | 35 ++++++++++++++++++++++++++---------
> > > >  1 file changed, 26 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > > index b03fba212799..a1618b7f01e5 100644
> > > > --- a/drivers/cxl/core/mbox.c
> > > > +++ b/drivers/cxl/core/mbox.c
> > > > @@ -326,12 +326,27 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +/* Return 0 if the cmd id is available for userspace */
> > > > +static int cxl_cmd_id_user(__u32 id, struct cxl_dev_state *cxlds)
> > > > +{
> > > > +	/* Check that the command is enabled for hardware */
> > > > +	if (!test_bit(id, cxlds->enabled_cmds))
> > > > +		return -ENOTTY;
> > > > +
> > > > +	/* Check that the command is not claimed for exclusive kernel use */
> > > > +	if (test_bit(id, cxlds->exclusive_cmds))
> > > > +		return -EBUSY;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
> > > >  			  const struct cxl_send_command *send_cmd,
> > > >  			  struct cxl_dev_state *cxlds)
> > > >  {
> > > >  	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
> > > >  	const struct cxl_command_info *info = &c->info;
> > > > +	int rc;
> > > >  
> > > >  	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> > > >  		return -EINVAL;
> > > > @@ -342,13 +357,9 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
> > > >  	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
> > > >  		return -EINVAL;
> > > >  
> > > > -	/* Check that the command is enabled for hardware */
> > > > -	if (!test_bit(info->id, cxlds->enabled_cmds))
> > > > -		return -ENOTTY;
> > > > -
> > > > -	/* Check that the command is not claimed for exclusive kernel use */
> > > > -	if (test_bit(info->id, cxlds->exclusive_cmds))
> > > > -		return -EBUSY;
> > > > +	rc = cxl_cmd_id_user(info->id, cxlds);
> > > > +	if (rc)
> > > > +		return rc;
> > > >  
> > > >  	/* Check the input buffer is the expected size */
> > > >  	if ((info->size_in != CXL_VARIABLE_PAYLOAD) &&
> > > > @@ -446,9 +457,15 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
> > > >  	 */
> > > >  	cxl_for_each_cmd(cmd) {
> > > >  		const struct cxl_command_info *info = &cmd->info;
> > > > +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > > +		int rc;
> > > >  
> > > > -		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > > > -			return -EFAULT;
> > > > +		rc = cxl_cmd_id_user(info->id, cxlds);
> > > > +		if (!rc) {
> > > > +			if (copy_to_user(&q->commands[j++], info,
> > > > +					 sizeof(*info)))
> > > > +				return -EFAULT;
> > > > +		}    
> > > 
> > > I like where this is going, but I think it is still useful to return all
> > > the commands even if they are not enabled or currently exclusive,
> > > especially since that expectation has already shipped.
> > > 
> > > I also think it is a bug that this command passes kernel internal flags
> > > like CXL_CMD_FLAG_FORCE_ENABLE. So let's declare new flags in
> > > include/uapi/linux/cxl_mem.h starting at BIT(1) and do something like:
> > >   
> > 
> > So this is OK in that we are just adding more info in the flags
> > field so backwards compatibility is better maintained than simply hiding
> > commands.
> >   
> > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > > index c71021a2a9ed..1ba0e12fd410 100644
> > > --- a/include/uapi/linux/cxl_mem.h
> > > +++ b/include/uapi/linux/cxl_mem.h
> > > @@ -87,8 +87,10 @@ struct cxl_command_info {
> > >         __u32 id;
> > >  
> > >         __u32 flags;
> > > -#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(0, 0)
> > > -
> > > +#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(2, 1)
> > > +#define CXL_MEM_COMMAND_FLAG_RESERVED BIT(0)  
> > 
> > Good to add a comment on this flag.  I've been staring at it an can't
> > figure out what it was ever for...  
> 
> Oh, I just noticed that the kernel internal CXL_CMD_FLAG_FORCE_ENABLE
> was being blindly copied out to userspace where it has no meaning. So
> any new flags need to come after that one that is already burned.
> 
> > > +#define CXL_MEM_COMMAND_FLAG_ENABLED BIT(1)  
> > 
> > ENABLED isn't the clearest naming... Perhaps _AVAILABLE_TO_USER
> > or something like that would be easier?  
> 
> Yes... but it is unavailable to the user when it is temporarily reserved
> by the kernel in the next flag indication.
> >   
> > > +#define CXL_MEM_COMMAND_FLAG_EXCLUSIVE BIT(2)  
> > What does EXCLUSIVE mean to a userspace caller?  EXCLUSIVE to whom?
> > 
> > Other than bikeshedding this looks good to me.  
> 
> How about USER_ENABLED and KERNEL_RESERVED? With some docs:
> 
> /*
>  * Older kernels leaked an internal flag at this bit position, that flag
>  * is not relevant to userspace. Newer kernels set it to zero.
>  */
> #define CXL_MEM_COMMAND_FLAG_RESERVED BIT(0)
> 
> /*
>  * The given command id is supported by the driver and is supported by a
>  * related opcode on the device.
>  */
> #define CXL_MEM_COMMAND_FLAG_USER_ENABLED BIT(1)
> 
> /*
>  * Requests with the given command id will terminate with EBUSY as the
>  * kernel actively owns management of the given resource. For example,
>  * the label-storage-area can not be written while the kernel is
>  * actively managing that space.
>  */
> #define CXL_MEM_COMMAND_FLAG_KERNEL_RESERVED BIT(2)

LGTM



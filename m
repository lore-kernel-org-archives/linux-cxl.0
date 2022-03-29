Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C95EC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Mar 2022 10:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiC2Kwr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 06:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiC2Kwp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 06:52:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE4113CDD
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 03:51:02 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KSRCN0PlVz67kSQ;
        Tue, 29 Mar 2022 18:49:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 29 Mar 2022 12:50:59 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 11:50:59 +0100
Date:   Tue, 29 Mar 2022 11:50:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] cxl/mbox: Make handle_mailbox_cmd_from_user()
 use a mbox param
Message-ID: <20220329115057.00004569@Huawei.com>
In-Reply-To: <20220326002535.GA1153598@alison-desk>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
        <20220324011126.1144504-7-alison.schofield@intel.com>
        <20220325110443.0000139f@huawei.com>
        <20220326002535.GA1153598@alison-desk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 25 Mar 2022 17:25:35 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Fri, Mar 25, 2022 at 11:04:43AM +0000, Jonathan Cameron wrote:
> > On Wed, 23 Mar 2022 18:11:23 -0700
> > alison.schofield@intel.com wrote:
> >   
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > Previously, handle_mailbox_cmd_from_user(), constructed the mailbox
> > > command and dispatched it to the hardware. The construction work
> > > has moved to the validation path.
> > > 
> > > handle_mailbox_cmd_from_user() now expects a fully validated
> > > mbox param. Make it's caller, cxl_send_cmd(), deliver it. Update
> > > the comments and dereferencing of the new mbox parameter.
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>  
> > 
> > One suggestion below.
> >  
> snip
> 
> > > @@ -474,22 +466,22 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
> > >  	 * to userspace. While the payload may have written more output than
> > >  	 * this it will have to be ignored.
> > >  	 */
> > > -	if (mbox_cmd.size_out) {
> > > -		dev_WARN_ONCE(dev, mbox_cmd.size_out > *size_out,
> > > +	if (mbox_cmd->size_out) {
> > > +		dev_WARN_ONCE(dev, mbox_cmd->size_out > *size_out,
> > >  			      "Invalid return size\n");
> > >  		if (copy_to_user(u64_to_user_ptr(out_payload),
> > > -				 mbox_cmd.payload_out, mbox_cmd.size_out)) {
> > > +				 mbox_cmd->payload_out, mbox_cmd->size_out)) {
> > >  			rc = -EFAULT;
> > >  			goto out;
> > >  		}
> > >  	}
> > >  
> > > -	*size_out = mbox_cmd.size_out;
> > > -	*retval = mbox_cmd.return_code;
> > > +	*size_out = mbox_cmd->size_out;
> > > +	*retval = mbox_cmd->return_code;
> > >  
> > >  out:
> > > -	kvfree(mbox_cmd.payload_in);
> > > -	kvfree(mbox_cmd.payload_out);
> > > +	kvfree(mbox_cmd->payload_in);
> > > +	kvfree(mbox_cmd->payload_out);  
> > 
> > As this function is no longer responsible for allocating these, I'd be inclined
> > to pull the frees out to the caller.
> > 
> > That will make things less fragile to any additional code that might in future
> > occur between
> > 
> > cxl_validate_cmd_from_user() and handle_mailbox_cmd_from_user()
> >   
> > >  	return rc;
> > >  }  
> 
> Yeah, not so graceful there. I'll pull them out to the caller, but the
> caller isn't the place were they were alloc'd. It goes like this:
> 
> cxl_send_cmd() {
> 	copy_from_user()
> 	cxl_validate_cmd_from_user() - does the allocs now
> 	handle_mailbox_from_user() - does the frees now
> 	? Move the frees here ?	

Could wrap them in a function to balance with the
validate, though that would need renaming to make the connection obvious.



> 	copy_to_user()
> }
> 
> I'll move. See what you think in next version.
> 
> > >  
> > > @@ -511,9 +503,8 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > -	rc = handle_mailbox_cmd_from_user(cxlds, &c, send.in.payload,
> > > -					  send.out.payload, &send.out.size,
> > > -					  &send.retval);
> > > +	rc = handle_mailbox_cmd_from_user(cxlds, &mbox_cmd, send.out.payload,
> > > +					  &send.out.size, &send.retval);
> > >  	if (rc)
> > >  		return rc;
> > >    
> >   


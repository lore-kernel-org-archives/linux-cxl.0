Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E968C43217
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Dec 2022 20:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLAUOk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Dec 2022 15:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLAUOj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Dec 2022 15:14:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B0BEE05
        for <linux-cxl@vger.kernel.org>; Thu,  1 Dec 2022 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669925679; x=1701461679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LyVYWQ2afrYOXoPuOEaoKtwUOfxyh/tUIQBnz/uxyuo=;
  b=mSE4D+b6tpp8cMHwwcfLhBDLeZCS542TCznmRVq7DPicly/02XrgUOLd
   fZP/Q/bNIhzmWBiwKt9ERU9ImY1jxPVa3gOg6mYhbSGmiBsLNj7Wd0Eaa
   FxEq5PqjgQx8+nFWwiS5siVwBWAPhmrts6YNsaQvv8kbgRTU1WjOhceaI
   Pm//alcmZnLBe4/xbhWUw4jMjYUXvxZbzJfEz1HM8Tld4K2mrCcVjbVMl
   p5NXQ8WUXFv98Zrr1CFi5U4iabqDcA+MbnPWFIJkQFFCEGY72oCKdB6Sc
   hjpCzZl1Ob5zVV+XFOjGFXLcU91oXWu8P/VqX0SOIewNY2ITpnufZwE6F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342722117"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="342722117"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:14:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="622437608"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="622437608"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.213.80])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:14:37 -0800
Date:   Thu, 1 Dec 2022 12:14:36 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/memdev: Add support for the Clear Poison mailbox
 command
Message-ID: <Y4kLLOb+cESnaH+s@aschofie-mobl2>
References: <cover.1669781852.git.alison.schofield@intel.com>
 <091f50b2644f220f0607633a4a953184e9c88b53.1669781852.git.alison.schofield@intel.com>
 <20221130144330.00002709@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130144330.00002709@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 30, 2022 at 02:43:30PM +0000, Jonathan Cameron wrote:
> On Tue, 29 Nov 2022 20:34:34 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices optionally support the CLEAR POISON mailbox command. Add
> > a sysfs attribute and memdev driver support for clearing poison.
> > 
> > When a Device Physical Address (DPA) is written to the clear_poison
> > sysfs attribute send a clear poison command to the device for the
> > specified address.
> > 
> > Per the CXL Specification (8.2.9.8.4.3), after receiving a valid clear
> > poison request, the device removes the address from the device's Poison
> > List and writes 0 (zero) for 64 bytes starting at address. If the device
> > cannot clear poison from the address, it returns a permanent media error
> > and ENXIO is returned to the user.
> 
> -ENXIO
> 
> > 
> > Additionally, and per the spec also, it is not an error to clear poison
> > of an address that is not poisoned. No error is returned and the address
> > is not overwritten. The memdev driver performs basic sanity checking on
> > the address, however, it does not go as far as reading the poison list to
> > see if the address is poisoned before clearing. That discovery is left to
> > the device. The device safely handles that case.
> > 
> > Implementation note: Although the CXL specification defines the clear
> > command to accept 64 bytes of 'write-data' to be used when clearing
> > the poisoned address, this implementation always uses 0 (zeros) for
> > the write-data.
> 
> Maybe put a * above to refer to this note given the spec is referenced
> for stuff different from what you are doing with it.  Nice to flag
> up to anyone reading this that they shouldn't write a 'no that's not
> what it says' comment before reading on. (who would do something
> silly like that? :)
> 

Rereading the 2 paragraphs above, it's not flowing for me now either.
I hop between 'spec says' and 'driver does'. Let me give that another
pass.

> > 
> > The clear_poison attribute is only visible for devices supporting the
> > capability.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Otherwise, a few really trivial things inline + it made me notice I'd missread
> the code for patch 1, hence the reply to my reply.
> 
> With this stuff tweaked.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'll pick up the stuff below too.
Thanks!

> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 17 +++++++++
> >  drivers/cxl/core/memdev.c               | 47 +++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h                    |  6 ++++
> >  3 files changed, 70 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 20db97f7a1aa..9d2b0fa07e17 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -435,3 +435,20 @@ Description:
> >  		poison into an address that already has poison present and no
> >  		error is returned. The inject_poison attribute is only visible
> >                  for devices supporting the capability.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/memX/clear_poison
> > +Date:		December, 2022
> > +KernelVersion:	v6.2
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(WO) When a Device Physical Address (DPA) is written to this
> > +		attribute the memdev driver sends a clear poison command to the
> > +		device for the specified address. Clearing poison removes the
> > +		address from the device's Poison List and writes 0 (zero)
> > +		for 64 bytes starting at address. It is not an error to clear
> > +		poison from an address that does not have poison set, and if
> > +		poison was not set, the address is not overwritten. If the
> > +		device cannot clear poison from the address, ENXIO is returned.
> 
> -ENXIO ?
> 
> > +		The clear_poison attribute is only visible for devices
> > +		supporting the capability.
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 71130813030f..85caffd5a85c 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -187,6 +187,44 @@ static ssize_t inject_poison_store(struct device *dev,
> >  }
> >  static DEVICE_ATTR_WO(inject_poison);
> >  
> > +static ssize_t clear_poison_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf, size_t len)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct cxl_mbox_clear_poison *pi;
> > +	u64 dpa;
> > +	int rc;
> > +
> > +	rc = kstrtou64(buf, 0, &dpa);
> > +	if (rc)
> > +		return rc;
> > +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> > +	if (rc)
> > +		return rc;
> Trivial:
> blank line here.  Kind of make sense to keep the string parser and validation in
> one block, but good to then separate that from the next bit of code.
> 
> > +	pi = kzalloc(sizeof(*pi), GFP_KERNEL);
> > +	if (!pi)
> > +		return -ENOMEM;
> > +	/*
> > +	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
> > +	 * is defined to accept 64 bytes of 'write-data', along with the
> > +	 * address to clear. The device writes 'write-data' into the DPA,
> > +	 * atomically, while clearing poison if the location is marked as
> > +	 * being poisoned.
> > +	 *
> > +	 * Always use '0' for the write-data.
> > +	 */
> > +	pi->address = cpu_to_le64(dpa);
> > +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_POISON, pi,
> > +			       sizeof(*pi), NULL, cxlds->payload_size);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return len;
> > +}
> > +static DEVICE_ATTR_WO(clear_poison);
> ...
> 
> 
> 

Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFC5C3A5A7
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 04:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLHERH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 23:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLHERD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 23:17:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA36229814
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 20:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670473022; x=1702009022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u3D1XV0JmSkI+pbiQ2w8tJC6f9bRPg7N5ySNc8Uhu40=;
  b=Xa6lOTobQSxC8lCmq8LmPFbtX0FmorJ+BCdWqhbABuACk9cz2itJLo4i
   ZchboBXX8qwpfMzzDFAPZ/Lp89GcXETXyDz8thGRPmE/ZTCmHrdjIbzVE
   WdowKAzYBP6NzWqN2YN5cz3HrYnvs31omNEuhTrkkHUzcDs6o3GtvnqgX
   BCLJyA+z+sJAIV9ROyNFvHFtsH/YxBnXDw1e08OzPovqRHUJk/J8/+qH4
   4gFM1+/qxBRip0qQ2DqiINVPzrcsDeRlG5xhYOYU+ckSe3QwIw+NAFkLp
   9I3IvSj1Vacy4z3fjqamR47BGn0gQR08BX9PJ9kP06osOHhu+xq+sCe3w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="296762510"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="296762510"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 20:17:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="892064071"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="892064071"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.198.95])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 20:17:00 -0800
Date:   Wed, 7 Dec 2022 20:16:56 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/5] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <Y5FlOBiVWW4yTe+0@aschofie-mobl2>
References: <cover.1669781852.git.alison.schofield@intel.com>
 <3c260749c833f51d5cad9ae3912debcdf8b82753.1669781852.git.alison.schofield@intel.com>
 <638d197d5393d_c957294ee@dwillia2-mobl3.amr.corp.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <638d197d5393d_c957294ee@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Dec 04, 2022 at 02:04:45PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices optionally support the INJECT POISON mailbox command. Add
> > a sysfs attribute and memdev driver support for injecting poison.
> > 
> > When a Device Physical Address (DPA) is written to the inject_poison
> > sysfs attribute send an inject poison command to the device for the
> > specified address.
> > 
> > Per the CXL Specification (8.2.9.8.4.2), after receiving a valid
> > inject poison request, the device will return poison when the address
> > is accessed through the CXL.mem bus. Injecting poison adds the address
> > to the device's Poison List and the error source is set to injected
> > error. In addition, the device adds a poison creation event to its
> > internal Informational Event log, updates the Event Status register,
> > and if configured, interrupts the host.
> > 
> > Also, per the CXL Specification, it is not an error to inject poison
> > into an address that already has poison present and no error is returned
> > from the device. The memdev driver performs basic sanity checking on the
> > address, however, it does not go as far as reading the poison list to see
> > if the address is on the list. That discovery is left to the device.
> > 
> > The inject_poison attribute is only visible for devices supporting
> > the capability.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 19 +++++++++
> >  drivers/cxl/core/memdev.c               | 53 +++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h                    |  3 ++
> >  3 files changed, 75 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index b715a4609718..20db97f7a1aa 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -416,3 +416,22 @@ Description:
> >  		if accessed, and the source of the poison. The retrieved
> >  		errors are logged as kernel trace events with the label
> >  		'cxl_poison'.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/memX/inject_poison
> > +Date:		December, 2022
> > +KernelVersion:	v6.2
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(WO) When a Device Physical Address (DPA) is written to this
> > +		attribute the memdev driver sends an inject poison command to
> > +		the device for the specified address. If successful, the device
> > +		returns poison when the address is accessed through the CXL.mem
> > +		bus. Injecting poison adds the address to the device's Poison
> > +		List and the error source is set to injected error. In addition,
> > +		the device adds a poison creation event to its internal
> > +		Informational Event log, updates the Event Status register, and
> > +		if configured, interrupts the host. It is not an error to inject
> > +		poison into an address that already has poison present and no
> > +		error is returned. The inject_poison attribute is only visible
> 
> This description needs to clarify how much poison is injected and that
> the address needs to be 64-byte aligned, or what happens if the address
> is not aligned.

Will clarify!
Is 64 bytes and if it's not aligned, fail -EINVAL.

> 
> I also think this whole facility needs to have its own Kconfig symbol so
> that it can be disabled at build time, and it likely needs to disable
> itself at run time if Linux fails obtain CXL error reporting control
> from the BIOS.

wrt Kconfig and 'whole facility' I'm thinking the Kconfig control
is for Inject&Clear, and that you are not thinking Get Poison List and
Scan Media are part of the group that needs a Kconfig control.

I'm seeking clarification on the error reporting control - as in,
confirmation that the Poison commands need to acquire that control.

> 
> > +                for devices supporting the capability.
> 
> Stray indenting...
> 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index d08b7295a01c..71130813030f 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -142,6 +142,51 @@ static ssize_t trigger_poison_list_store(struct device *dev,
> >  }
> >  static DEVICE_ATTR_WO(trigger_poison_list);
> >  
> > +static int cxl_validate_poison_dpa(struct cxl_dev_state *cxlds, u64 dpa)
> > +{
> > +	if (!resource_size(&cxlds->dpa_res)) {
> > +		dev_dbg(cxlds->dev, "device has no dpa resource\n");
> > +		return -EINVAL;
> > +	}
> > +	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
> > +		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
> > +			dpa, &cxlds->dpa_res);
> > +		return -EINVAL;
> > +	}
> > +	if ((dpa & CXL_POISON_INJECT_RESERVED) != 0) {
> > +		dev_dbg(cxlds->dev, "dpa reserve bit(s) [5:0] set 0x%llx\n",
> > +			dpa);
> 
> I think it's less that those bits are reserved and more that poison is
> tracked in terms of 64-byte aligned cache lines. So I would do:
> 
>     if (!IS_ALIGNED(dpa, 64))
> 

:) thanks!


> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static ssize_t inject_poison_store(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *buf, size_t len)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	u64 dpa;
> > +	int rc;
> > +
> > +	rc = kstrtou64(buf, 0, &dpa);
> > +	if (rc)
> > +		return rc;
> > +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> > +	if (rc)
> > +		return rc;
> > +
> > +	dpa = cpu_to_le64(dpa);
> > +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_INJECT_POISON, &dpa,
> > +			       sizeof(dpa), NULL, cxlds->payload_size);
> 
> I would make it clear that the input payload is a single little endian
> 64-bit address with something like this:
> 
> struct cxl_mbox_poison_inject cmd;
> 
> cmd = (struct cxl_mbox_poison_inject) {
> 	.dpa = __le64_to_cpu(dpa),
> };
> 
> ...where cxl_mbox_poison_inject is:
> 
> struct cxl_mbox_poison_inject {
>         __le64 dpa;
> };
> 
> ...otherwise its strange to assign the result of cpu_to_le64() to a u64,
> I expect sparse would complain about that.

I did fix up the sparse warning but not w a struct like you suggest.
I was treating this input payload unfairly and unclearly by not giving
it it's own struct definition. I will give it a struct!

> 
> > +	if (rc)
> > +		return rc;
> > +
> > +	return len;
> > +}
> > +static DEVICE_ATTR_WO(inject_poison);
> > +
> >  static struct attribute *cxl_memdev_attributes[] = {
> >  	&dev_attr_serial.attr,
> >  	&dev_attr_firmware_version.attr,
> > @@ -149,6 +194,7 @@ static struct attribute *cxl_memdev_attributes[] = {
> >  	&dev_attr_label_storage_size.attr,
> >  	&dev_attr_numa_node.attr,
> >  	&dev_attr_trigger_poison_list.attr,
> > +	&dev_attr_inject_poison.attr,
> >  	NULL,
> >  };
> >  
> > @@ -175,6 +221,13 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> >  			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> >  			return 0;
> >  	}
> > +	if (a == &dev_attr_inject_poison.attr) {
> > +		struct device *dev = kobj_to_dev(kobj);
> > +
> > +		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
> > +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> > +			return 0;
> > +	}
> >  	return a->mode;
> >  }
> >  
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 19a9e545ac19..0d4c34be7335 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -396,6 +396,9 @@ struct cxl_mbox_poison_payload_out {
> >  #define CXL_POISON_SOURCE_INJECTED	3
> >  #define CXL_POISON_SOURCE_VENDOR	7
> >  
> > +/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
> > +#define CXL_POISON_INJECT_RESERVED	GENMASK_ULL(5, 0)
> > +
> >  /**
> >   * struct cxl_mem_command - Driver representation of a memory device command
> >   * @info: Command information as it exists for the UAPI
> > -- 
> > 2.37.3
> > 
> 
> 

Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B68C54EAA
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 01:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjA1BRt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 20:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjA1BRs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 20:17:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544EDF765
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 17:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674868666; x=1706404666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hfghNAh5aPPDwihVghmpInm0PEiPuc1zJfsbxDQFogk=;
  b=Yo7owyY/JGlwR1hSxE5dTTL/j/AZ3Oe5MSvMnv/9bdEVHA3DwCkFyYuz
   M1l5BW5CQborS63q0p/+J++pvkbMm6JLeJVtGdV9tMVvEmv7m1t9qwm4L
   hR8yP4fkNZkLnhZhS1Gn+gdJ7LlMSyy/5TM3/cA5rfAe1fn8yGQvGIuGq
   0XnIY5jt8f5wN7rrhf7hpcFcEK6zMKwhUOfgnlSwFxSHCJKcShTQl6C/N
   7B5Wvd2P2BdPMZr9AJ6ERo26dw6TSd1An50eZyPGG9lsV/QWeMmuvpYJc
   7wTVzNyNtO6EdA24dkxUmqWq4otHlwCztlzoE7i8emoo7HIuv8PTmNppE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="315198051"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="315198051"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 17:17:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="837330423"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="837330423"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.161.50])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 17:17:45 -0800
Date:   Fri, 27 Jan 2023 17:17:44 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/6] cxl/memdev: Add support for the Clear Poison
 mailbox command
Message-ID: <Y9R3uP/EBBt86ow/@aschofie-mobl2>
References: <cover.1674101475.git.alison.schofield@intel.com>
 <3ae253f32602a62fa7521d5787b1b26b1c808275.1674101475.git.alison.schofield@intel.com>
 <63d464b7cb7ff_ea222294ef@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d464b7cb7ff_ea222294ef@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 27, 2023 at 03:56:39PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices optionally support the CLEAR POISON mailbox command. Add
> > a sysfs attribute and memdev driver support for clearing poison.
> > 
> > When a Device Physical Address (DPA) is written to the clear_poison
> > sysfs attribute, send a clear poison command to the device for the
> > specified address.
> > 
> > Per the CXL Specification (3.0 8.2.9.8.4.3), after receiving a valid clear
> > poison request, the device removes the address from the device's Poison
> > List and writes 0 (zero) for 64 bytes starting at address. If the device
> > cannot clear poison from the address, it returns a permanent media error
> > and -ENXIO is returned to the user.
> > 
> > Additionally, and per the spec also, it is not an error to clear poison
> > of an address that is not poisoned. No error is returned from the device
> > and the address is not overwritten.
> > 
> > *Implementation note: Although the CXL specification defines the clear
> > command to accept 64 bytes of 'write-data' to be used when clearing
> > the poisoned address, this implementation always uses 0 (zeros) for
> > the write-data.
> > 
> > The clear_poison attribute is only visible for devices supporting the
> > capability when the kernel is built with CONFIG_CXL_POISON_INJECT.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++
> >  drivers/cxl/core/memdev.c               | 57 ++++++++++++++++++++++++-
> >  drivers/cxl/cxlmem.h                    |  6 +++
> >  3 files changed, 80 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index e9c6dd02bd09..7e4897e7bc05 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -438,3 +438,21 @@ Description:
> >  		inject_poison attribute is only visible for devices supporting
> >  		the capability. Kconfig option CXL_POISON_INJECT must be on
> >  		to enable this option. The default is off.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/memX/clear_poison
> > +Date:		January, 2023
> > +KernelVersion:	v6.3
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(WO) When a Device Physical Address (DPA) is written to this
> > +		attribute, the memdev driver sends a clear poison command to
> > +		the device for the specified address. Clearing poison removes
> > +		the address from the device's Poison List and writes 0 (zero)
> > +		for 64 bytes starting at address. It is not an error to clear
> > +		poison from an address that does not have poison set, and if
> > +		poison was not set, the address is not overwritten. If the
> > +		device cannot clear poison from the address, -ENXIO is returned.
> > +		The clear_poison attribute is only visible for devices
> > +		supporting the capability. Kconfig option CXL_POISON_INJECT
> > +		must be on to enable this option. The default is off.
> 
> So unlike error inject, this interface leaves me cold because it is
> changing the state of data without coordination.
> 
> You might say, "inject poison also changes the state of data without
> coordination", while that is true it is expected that media can go bad
> without warning. What software does not expect is that memory could be
> put back into service without coordination. A memory error wants to be
> cleared by the agent that currently owns the memory, like the page
> allocator clearing PageHWPoison and putting the page back into service,
> or a filesystem restoring a file that was previously quarantined.
> 
> The only way this interface can proceed is if it can assert that the
> poison to be cleared is not mapped by any decoder which makes the owner
> of the memory the administrator using the sysfs interface. That limits
> its utility.

It is a debug interface. 'Changing the state of data without the
coordination' yes, but isn't that coordination up to the user.
I get putting more protection in place, as in not allowing
inject or clear of a DPA that is mapped. 

Do you expect, or fear, that users will 'trigger poison list', and
then issue 'clears' of poisoned DPA's directly, instead of letting
core-mm and filesystems to handle poison?

> 
> Inside the kernel the expectation is that the core-mm or filesystems are
> using facilities like movdir64b to atomically clear poison without
> needing to hassle with a CXL mailbox.
> 
> This sysfs interface can move forward but it needs the idle checks and
> locking before it can issue the command. I would also have an eye
> towards skipping the mailbox call on architectures that have poison
> clearing instruction like x86's movdir64b, because as the spec says:
> "This provides the same functionality as the host directly writing new
> data to the device", so just try to do that by default. However that can
> be a follow-on optimization.

This (have an eye towards skipping ...) sounds like you do want
users to be able to clear real poison using the sysfs interface,
and for the the driver to be able to coordinate it upwards.

I'll go off and learn more about the upwards coordination, and
more thoughts here are welcome!

Thanks,
Alison

> 
> 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 226662cf3331..4d86a4565c9e 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -197,6 +197,51 @@ static ssize_t inject_poison_store(struct device *dev,
> >  }
> >  static DEVICE_ATTR_WO(inject_poison);
> >  
> > +static ssize_t clear_poison_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf, size_t len)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct cxl_mbox_clear_poison clear;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	u64 dpa;
> > +	int rc;
> > +
> > +	rc = kstrtou64(buf, 0, &dpa);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> > +	if (rc)
> > +		return rc;
> > +	/*
> > +	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
> > +	 * is defined to accept 64 bytes of 'write-data', along with the
> > +	 * address to clear. The device writes the data into the address
> > +	 * atomically, while clearing poison if the location is marked as
> > +	 * being poisoned.
> > +	 *
> > +	 * Always use '0' for the write-data.
> > +	 */
> > +	clear = (struct cxl_mbox_clear_poison) {
> > +		.address = cpu_to_le64(dpa)
> > +	};
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_CLEAR_POISON,
> > +		.size_in = sizeof(clear),
> > +		.payload_in = &clear,
> > +	};
> > +
> > +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return len;
> > +}
> > +static DEVICE_ATTR_WO(clear_poison);
> > +
> >  static struct attribute *cxl_memdev_attributes[] = {
> >  	&dev_attr_serial.attr,
> >  	&dev_attr_firmware_version.attr,
> > @@ -205,6 +250,7 @@ static struct attribute *cxl_memdev_attributes[] = {
> >  	&dev_attr_numa_node.attr,
> >  	&dev_attr_trigger_poison_list.attr,
> >  	&dev_attr_inject_poison.attr,
> > +	&dev_attr_clear_poison.attr,
> >  	NULL,
> >  };
> >  
> > @@ -225,7 +271,8 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> >  		return 0;
> >  
> >  	if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT) &&
> > -	    a == &dev_attr_inject_poison.attr)
> > +	    (a == &dev_attr_inject_poison.attr ||
> > +	     a == &dev_attr_clear_poison.attr))
> >  		return 0;
> >  
> >  	if (a == &dev_attr_trigger_poison_list.attr) {
> > @@ -242,6 +289,14 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> >  			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> >  			return 0;
> >  	}
> > +	if (a == &dev_attr_clear_poison.attr) {
> > +		struct device *dev = kobj_to_dev(kobj);
> > +
> > +		if (!test_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON,
> > +			      to_cxl_memdev(dev)->cxlds->enabled_cmds)) {
> > +			return 0;
> 
> Similar comment as the last patch with respect to the command enabling.
> 
> > +		}
> > +	}
> >  	return a->mode;
> >  }
> >  
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 862ca4f4cc06..adcbd4a98819 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -441,6 +441,12 @@ struct cxl_mbox_inject_poison {
> >  	__le64 address;
> >  };
> >  
> > +/* Clear Poison  CXL 3.0 Spec 8.2.9.8.4.3 */
> > +struct cxl_mbox_clear_poison {
> > +	__le64 address;
> > +	u8 write_data[CXL_POISON_LEN_MULT];
> > +} __packed;
> > +
> >  /**
> >   * struct cxl_mem_command - Driver representation of a memory device command
> >   * @info: Command information as it exists for the UAPI
> > -- 
> > 2.37.3
> > 
> 
> 

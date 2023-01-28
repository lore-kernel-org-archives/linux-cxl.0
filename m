Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E34C54EAA
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 02:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjA1CrV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 21:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA1CrV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 21:47:21 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F0A8B066
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 18:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674874039; x=1706410039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=niUW6mTX/NBf0qDsvorbOe6MGXWd6tlWzMHEsRsWqlQ=;
  b=H5C73WfN2pmb2Wt74d+77hJ8cEsmGzfJM2jyNIOkqI4La19wcjtZpbMJ
   rwBYSMsPyLOQ9nwpGJauYX+/MdsOyoaxDsxmZOMtp5enq+2dknEqxYums
   7yZkLN6ritJLHFIX3EvVLCFFI1rUY1SNgC2I1pYRlUYrjTmOYMrCCVlMs
   h/Ipru3PWFZ7wzdtZ1xG+Odfy3h/1jXuW8XFP40oOAzMN+zf7v8mvl8de
   4zwMu0bzMdCGzFnQ+pvzAniIhTZs9GIIX5ugVgDwMMcyxDaGjrZPAOd7T
   47wJC9KSpndV3h7iK03bZ/I7IhVFjp0HaKj3znyQkILPiSopVgo+eN5xJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="327271054"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="327271054"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 18:47:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="837351165"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="837351165"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.161.50])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 18:47:18 -0800
Date:   Fri, 27 Jan 2023 18:47:17 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/6] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <Y9SMtfBK6FRrgW6f@aschofie-mobl2>
References: <cover.1674101475.git.alison.schofield@intel.com>
 <97a0b128d0d0df56cea1a1a4ead65a40b9cf008e.1674101475.git.alison.schofield@intel.com>
 <63d458e7eed85_ea222294af@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d458e7eed85_ea222294af@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 27, 2023 at 03:06:16PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices optionally support the INJECT POISON mailbox command. Add
> > a sysfs attribute and memdev driver support for injecting poison.
> > 
> > When a Device Physical Address (DPA) is written to the inject_poison
> > sysfs attribute, send an inject poison command to the device for the
> > specified address.
> > 
> > Per the CXL Specification (3.0 8.2.9.8.4.2), after receiving a valid
> > inject poison request, the device will return poison when the address
> > is accessed through the CXL.mem bus. Injecting poison adds the address
> > to the device's Poison List and the error source is set to Injected.
> > In addition, the device adds a poison creation event to its internal
> > Informational Event log, updates the Event Status register, and if
> > configured, interrupts the host.
> > 
> > Also, per the CXL Specification, it is not an error to inject poison
> > into an address that already has poison present and no error is
> > returned from the device.
> > 
> > The inject_poison attribute is only visible for devices supporting
> > the capability when the kernel is built with CONFIG_CXL_POISON_INJECT.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++++
> >  drivers/cxl/Kconfig                     | 10 ++++
> >  drivers/cxl/core/memdev.c               | 67 +++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h                    |  5 ++
> >  4 files changed, 104 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index b715a4609718..e9c6dd02bd09 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -416,3 +416,25 @@ Description:
> >  		if accessed, and the source of the poison. The retrieved
> >  		errors are logged as kernel trace events with the label
> >  		'cxl_poison'.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/memX/inject_poison
> > +Date:		January, 2023
> > +KernelVersion:	v6.3
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(WO) When a Device Physical Address (DPA) is written to this
> > +		attribute, the memdev driver sends an inject poison command to
> > +		the device for the specified address. The DPA must be 64-byte
> > +		aligned and the length of the injected poison is 64-bytes. If
> > +		successful, the device returns poison when the address is
> > +		accessed through the CXL.mem bus. Injecting poison adds the
> > +		address to the device's Poison List and the error source is set
> > +		to Injected. In addition, the device adds a poison creation
> > +		event to its internal Informational Event log, updates the
> > +		Event Status register, and if configured, interrupts the host.
> > +		It is not an error to inject poison into an address that
> > +		already has poison present and no error is returned. The
> > +		inject_poison attribute is only visible for devices supporting
> > +		the capability. Kconfig option CXL_POISON_INJECT must be on
> > +		to enable this option. The default is off.
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 0ac53c422c31..6541f54725cd 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -129,4 +129,14 @@ config CXL_REGION_INVALIDATION_TEST
> >  	  If unsure, or if this kernel is meant for production environments,
> >  	  say N.
> >  
> > +config CXL_POISON_INJECT
> > +	bool "CXL: Support CXL Memory Device Poison Inject"
> > +	depends on CXL_MEM
> > +	help
> > +	  Selecting this option creates the sysfs attributes inject_poison
> > +	  and clear_poison for CXL memory devices supporting the capability.
> > +	  See Documentation/ABI/testing/sysfs-bus-cxl.
> 
> Could maybe clarify that this is meant for hardware debug scenarios so
> that is the reason it is disabled by default.
>
Got it. Thanks!

> > +
> > +	  If unsure, say N.
> > +
> >  endif
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index e0af7e9c9989..226662cf3331 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -142,6 +142,61 @@ static ssize_t trigger_poison_list_store(struct device *dev,
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
> > +	if (!IS_ALIGNED(dpa, 64)) {
> > +		dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n",
> > +			dpa);
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
> > +	struct cxl_mbox_inject_poison inject;
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
> > +
> > +	inject = (struct cxl_mbox_inject_poison) {
> > +		.address = cpu_to_le64(dpa)
> > +	};
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_INJECT_POISON,
> > +		.size_in = sizeof(inject),
> > +		.payload_in = &inject,
> > +	};
> > +
> > +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
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
> > @@ -149,6 +204,7 @@ static struct attribute *cxl_memdev_attributes[] = {
> >  	&dev_attr_label_storage_size.attr,
> >  	&dev_attr_numa_node.attr,
> >  	&dev_attr_trigger_poison_list.attr,
> > +	&dev_attr_inject_poison.attr,
> >  	NULL,
> >  };
> >  
> > @@ -168,6 +224,10 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> >  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> >  		return 0;
> >  
> > +	if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT) &&
> > +	    a == &dev_attr_inject_poison.attr)
> > +		return 0;
> > +
> >  	if (a == &dev_attr_trigger_poison_list.attr) {
> >  		struct device *dev = kobj_to_dev(kobj);
> >  
> > @@ -175,6 +235,13 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> >  			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> >  			return 0;
> >  	}
> > +	if (a == &dev_attr_inject_poison.attr) {
> > +		struct device *dev = kobj_to_dev(kobj);
> 
> I'd move the IS_ENABLED(CONFIG_CXL_POISON_INJECT) inside here so just
> one spot in this function handles the poison attribute.

OK

> 
> > +
> > +		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
> > +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> > +			return 0;
> 
> Ugh, this is a problem. So "inject poison" never should have been
> enabled for the ioctl path way back in:
> 
> 87815ee9d006 cxl/pci: Add media provisioning required commands
> 
> All the nice sysfs interface and compile option to turn it off in this
> patch is moot since userspace can just send the ioctl if the sysfs
> attribute is missing.
> 
> On the one hand this is already shipping ABI, but given cxl-cli has not
> been enabled it chances are high that it can be deleted without anyone
> caring (i.e. breaking deployed configurations). That would need to be a
> lead in patch.

I'm confused on how to kill it.

I see it in the enum here: include/uapi/linux/cxl_mem.h, and I also
see Ira's patch reminding us not to break backward compatibility on
that enum. Do I replace with dummy entries?

I'll block in raw mode too.

> As for how to detect that the inject poison opcode is
> supported, that needs something like a custom "cxlds->has_poison_inject"
> flag into cxl_walk_cel(). I.e.  cxlds->enabled_cmds is only about the
> enabled ioctl wrapper commands for CXL opcodes not the availability of
> opcodes for cxl_internal_send_cmd().
Sounds like fun ;)

Thanks Dan,
Alison

> 
> 
> > +	}
> >  	return a->mode;
> >  }
> >  
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 28ba0cd8f2d3..862ca4f4cc06 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -436,6 +436,11 @@ struct cxl_mbox_poison_payload_out {
> >  #define CXL_POISON_SOURCE_INJECTED	3
> >  #define CXL_POISON_SOURCE_VENDOR	7
> >  
> > +/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
> > +struct cxl_mbox_inject_poison {
> > +	__le64 address;
> > +};
> > +
> >  /**
> >   * struct cxl_mem_command - Driver representation of a memory device command
> >   * @info: Command information as it exists for the UAPI
> > -- 
> > 2.37.3
> > 
> 
> 

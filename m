Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AEDC3A5A7
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 04:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLHEYf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 23:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLHEYe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 23:24:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888494905
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 20:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670473473; x=1702009473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=970kxod42O6p6KXBfm07goEWk70J06DMqDqxMpyMmco=;
  b=cS23uGYF9/4idutn1XoanXGWPV2X/VcJsF41LrtjgVikA52K9IGRfva0
   nIu5vddqd3YHqvxYhWJkCWwJmnTkThDj5K3UEjwsKrqaylzB08wdgZpGz
   DUE+hRRPWX0BN07R/K7LEYtavsXpgAaJJ5CMRzDHT+nadNf4sKEiJM9yE
   VzVGMZYUm6Hvxs4jgfd/YXawYbVDLjdVvuRc0OzvtNKg7savfoXyc7AEH
   B/NMDK7Jf5/MAerb2tG1NHnuf/e/pZLUp51kz2nJq/7H8mHSTCZy9H3pS
   U2itBUy5dzfU1NFdc8WDny5MG/At68X1Zye32Fs0ZgnJ5KVKoQSIsi4Xs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="314714438"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="314714438"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 20:20:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="975708398"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="975708398"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.198.95])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 20:20:25 -0800
Date:   Wed, 7 Dec 2022 20:20:21 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/5] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <Y5FmBYBYGhaCMJAN@aschofie-mobl2>
References: <cover.1669781852.git.alison.schofield@intel.com>
 <3c260749c833f51d5cad9ae3912debcdf8b82753.1669781852.git.alison.schofield@intel.com>
 <20221130143136.00003808@Huawei.com>
 <20221130144057.000024de@Huawei.com>
 <a595f3dd-3655-eda8-34ed-b11445068e62@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a595f3dd-3655-eda8-34ed-b11445068e62@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Dec 01, 2022 at 09:42:01AM -0700, Dave Jiang wrote:
> 
> 
> On 11/30/2022 7:40 AM, Jonathan Cameron wrote:
> > On Wed, 30 Nov 2022 14:31:36 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > > On Tue, 29 Nov 2022 20:34:33 -0800
> > > alison.schofield@intel.com wrote:
> > > 
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > > 
> > > > CXL devices optionally support the INJECT POISON mailbox command. Add
> > > > a sysfs attribute and memdev driver support for injecting poison.
> > > > 
> > > > When a Device Physical Address (DPA) is written to the inject_poison
> > > > sysfs attribute send an inject poison command to the device for the
> > > > specified address.
> > > > 
> > > > Per the CXL Specification (8.2.9.8.4.2), after receiving a valid
> > > > inject poison request, the device will return poison when the address
> > > > is accessed through the CXL.mem bus. Injecting poison adds the address
> > > > to the device's Poison List and the error source is set to injected
> > > > error. In addition, the device adds a poison creation event to its
> > > > internal Informational Event log, updates the Event Status register,
> > > > and if configured, interrupts the host.
> > > > 
> > > > Also, per the CXL Specification, it is not an error to inject poison
> > > > into an address that already has poison present and no error is returned
> > > > from the device. The memdev driver performs basic sanity checking on the
> > > > address, however, it does not go as far as reading the poison list to see
> > > > if the address is on the list. That discovery is left to the device.
> > > > 
> > > > The inject_poison attribute is only visible for devices supporting
> > > > the capability.
> > > > 
> > > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > A few trivial things inline.  With those fixes LGTM
> > > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > > ---
> > > >   Documentation/ABI/testing/sysfs-bus-cxl | 19 +++++++++
> > > >   drivers/cxl/core/memdev.c               | 53 +++++++++++++++++++++++++
> > > >   drivers/cxl/cxlmem.h                    |  3 ++
> > > >   3 files changed, 75 insertions(+)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > > index b715a4609718..20db97f7a1aa 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > > @@ -416,3 +416,22 @@ Description:
> > > >   		if accessed, and the source of the poison. The retrieved
> > > >   		errors are logged as kernel trace events with the label
> > > >   		'cxl_poison'.
> > > > +
> > > > +
> > > > +What:		/sys/bus/cxl/devices/memX/inject_poison
> > > > +Date:		December, 2022
> > > > +KernelVersion:	v6.2
> > > > +Contact:	linux-cxl@vger.kernel.org
> > > > +Description:
> > > > +		(WO) When a Device Physical Address (DPA) is written to this
> > > > +		attribute the memdev driver sends an inject poison command to
> > > > +		the device for the specified address. If successful, the device
> > > > +		returns poison when the address is accessed through the CXL.mem
> > > > +		bus. Injecting poison adds the address to the device's Poison
> > > > +		List and the error source is set to injected error. In addition,
> > > "set to Injected."
> > > 
> > > perhaps to match spec naming in Media Error Record.
> > > 
> > > > +		the device adds a poison creation event to its internal
> > > > +		Informational Event log, updates the Event Status register, and
> > > > +		if configured, interrupts the host. It is not an error to inject
> > > > +		poison into an address that already has poison present and no
> > > > +		error is returned. The inject_poison attribute is only visible
> > > > +                for devices supporting the capability.
> > > 
> > > White space issues (spaces instead of tabs?)
> > > 
> > > Add something about the masked bits / granularity of addresses that are accepted.
> > > 
> > > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > > index d08b7295a01c..71130813030f 100644
> > > > --- a/drivers/cxl/core/memdev.c
> > > > +++ b/drivers/cxl/core/memdev.c
> > > > @@ -142,6 +142,51 @@ static ssize_t trigger_poison_list_store(struct device *dev,
> > > >   }
> > > >   static DEVICE_ATTR_WO(trigger_poison_list);
> > > > +static int cxl_validate_poison_dpa(struct cxl_dev_state *cxlds, u64 dpa)
> > > > +{
> > > > +	if (!resource_size(&cxlds->dpa_res)) {
> > > > +		dev_dbg(cxlds->dev, "device has no dpa resource\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
> > > > +		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
> > > > +			dpa, &cxlds->dpa_res);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +	if ((dpa & CXL_POISON_INJECT_RESERVED) != 0) {
> > > > +		dev_dbg(cxlds->dev, "dpa reserve bit(s) [5:0] set 0x%llx\n",
> > > > +			dpa);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static ssize_t inject_poison_store(struct device *dev,
> > > > +				   struct device_attribute *attr,
> > > > +				   const char *buf, size_t len)
> > > > +{
> > > > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > > > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > > +	u64 dpa;
> > > > +	int rc;
> > > > +
> > > > +	rc = kstrtou64(buf, 0, &dpa);
> > > > +	if (rc)
> > > > +		return rc;
> > > > +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> > > > +	if (rc)
> > > > +		return rc;
> > > > +
> > > > +	dpa = cpu_to_le64(dpa);
> > > > +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_INJECT_POISON, &dpa,
> > > 
> > > Endianness?
> > 
> > Got thrown by the type and missed the cpu_to_le64().  Use a local __le64 so it's all explicit.
> > One of the static analysis tools will correctly moan about storing it to a u64
> > (can't remember which).
> 
> Sparse. I just got yelled at by 0-day for something similar. :)
> 

Thanks for all your endian-ness eyes.

> > 
> > > 
> > > > +			       sizeof(dpa), NULL, cxlds->payload_size);
> > > > +	if (rc)
> > > > +		return rc;
> > > > +
> > > > +	return len;
> > > > +}
> > > > +static DEVICE_ATTR_WO(inject_poison);
> > > > +
> > > >   static struct attribute *cxl_memdev_attributes[] = {
> > > >   	&dev_attr_serial.attr,
> > > >   	&dev_attr_firmware_version.attr,
> > > > @@ -149,6 +194,7 @@ static struct attribute *cxl_memdev_attributes[] = {
> > > >   	&dev_attr_label_storage_size.attr,
> > > >   	&dev_attr_numa_node.attr,
> > > >   	&dev_attr_trigger_poison_list.attr,
> > > > +	&dev_attr_inject_poison.attr,
> > > >   	NULL,
> > > >   };
> > > > @@ -175,6 +221,13 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> > > >   			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> > > >   			return 0;
> > > >   	}
> > > > +	if (a == &dev_attr_inject_poison.attr) {
> > > > +		struct device *dev = kobj_to_dev(kobj);
> > > > +
> > > > +		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
> > > > +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> > > > +			return 0;
> > > > +	}
> > > >   	return a->mode;
> > > >   }
> > > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > > index 19a9e545ac19..0d4c34be7335 100644
> > > > --- a/drivers/cxl/cxlmem.h
> > > > +++ b/drivers/cxl/cxlmem.h
> > > > @@ -396,6 +396,9 @@ struct cxl_mbox_poison_payload_out {
> > > >   #define CXL_POISON_SOURCE_INJECTED	3
> > > >   #define CXL_POISON_SOURCE_VENDOR	7
> > > > +/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
> > > > +#define CXL_POISON_INJECT_RESERVED	GENMASK_ULL(5, 0)
> > > > +
> > > >   /**
> > > >    * struct cxl_mem_command - Driver representation of a memory device command
> > > >    * @info: Command information as it exists for the UAPI
> > > 
> > > 
> > 

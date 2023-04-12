Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD98C77B6E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 18:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDLScv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 14:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLScu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 14:32:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E87A8D
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681324355; x=1712860355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GIvvldpn1084VWG3Aut1aGnDup0/FGq7QdC/FVziLnA=;
  b=aFFv+DsS/cHFF4weZ7YITvsmZL31Y26W5PoH32PvgUz+Jb17G8PYNqol
   VJVmMw7gBdsZrJxNiw+cq1VOwH8xQbxfnlc7+gHKoooK5nv7N3sFAnXvM
   F/rJKQyKa4OOCt4L0i6wUrRsp1z/e6le4EGuYyrfF60npUoQ8YvYJ3Dss
   3sehyTpPqP8T36GRgTXFhkvZfz5h4vNpzvQuB5ypWB8FJY0Vnqu1C9B9C
   JTmCEZQrvYYke92MiwFFZTR8MaT4lXEtdVDH9it3Uc96QjodAMdCg64st
   CnxCmZsplpGnxHuLTr23xUbBlyN2Whxl3K4F0BNR5G7GDRfuk0OIGwDjq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="342739538"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="342739538"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="778403968"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="778403968"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.150.154])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:32:16 -0700
Date:   Wed, 12 Apr 2023 11:32:14 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <ZDb5LptUNNnej/cc@aschofie-mobl2>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <31ecc71e43fa584aa0c4b1cb1e9aa7b124461037.1681159309.git.alison.schofield@intel.com>
 <643643ada955_417e294b1@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643643ada955_417e294b1@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 11, 2023 at 10:37:49PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a boolean 'true' is written to this attribute the memdev driver
> > retrieves the poison list from the device. The list consists of
> > addresses that are poisoned, or would result in poison if accessed,
> > and the source of the poison. This attribute is only visible for
> > devices supporting the capability. The retrieved errors are logged
> > as kernel events when cxl_poison event tracing is enabled.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++
> >  drivers/cxl/core/memdev.c               | 48 +++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h                    |  5 ++-
> >  drivers/cxl/mem.c                       | 36 +++++++++++++++++++
> >  4 files changed, 102 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 3acf2f17a73f..48ac0d911801 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -415,3 +415,17 @@ Description:
> >  		1), and checks that the hardware accepts the commit request.
> >  		Reading this value indicates whether the region is committed or
> >  		not.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/memX/trigger_poison_list
> > +Date:		April, 2023
> > +KernelVersion:	v6.4
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(WO) When a boolean 'true' is written to this attribute the
> > +		memdev driver retrieves the poison list from the device. The
> > +		list consists of addresses that are poisoned, or would result
> > +		in poison if accessed, and the source of the poison. This
> > +		attribute is only visible for devices supporting the
> > +		capability. The retrieved errors are logged as kernel
> > +		events when cxl_poison event tracing is enabled.
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 0af8856936dc..297d87ebaca6 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -106,6 +106,53 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(numa_node);
> >  
> > +static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
> > +{
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	u64 offset, length;
> > +	int rc = 0;
> > +
> > +	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> > +	if (resource_size(&cxlds->pmem_res)) {
> > +		offset = cxlds->pmem_res.start;
> > +		length = resource_size(&cxlds->pmem_res);
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +	if (resource_size(&cxlds->ram_res)) {
> > +		offset = cxlds->ram_res.start;
> > +		length = resource_size(&cxlds->ram_res);
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +		/*
> > +		 * Invalid Physical Address is not an error for
> > +		 * volatile addresses. Device support is optional.
> > +		 */
> > +		if (rc == -EFAULT)
> > +			rc = 0;
> > +	}
> > +	return rc;
> > +}
> > +
> > +ssize_t cxl_trigger_poison_list(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t len)
> 
> The @attr argument is unused, it can be dropped.

Agree, will do.

> 
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> 
> The caller can do this conversion.
> 
> > +	bool trigger;
> > +	ssize_t rc;
> > +
> > +	if (kstrtobool(buf, &trigger) || !trigger)
> > +		return -EINVAL;
> 
> Hmm, the caller could to this too...

Why split the work?

It seems having the caller do a little bit of work, and then pass it on,
hurts readability. ATM, the caller does nothing, and here we do all
the usual sysfs handling. The division of power is crisp. If it's not
an efficiency concern, why make it less readable?

Alison

> 
> ...the below seems to be the bit that the cxl_core cares about handling.
> 
> > +
> > +	down_read(&cxl_dpa_rwsem);
> 
> down_read_interruptible() since this is coming from userspace.

Thanks, got it!

> 
> > +	rc = cxl_get_poison_by_memdev(cxlmd);
> > +	up_read(&cxl_dpa_rwsem);
> > +
> > +	return rc ? rc : len;
> 
> The caller can do this conversion.
> 
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
> > +
> >  static struct attribute *cxl_memdev_attributes[] = {
> >  	&dev_attr_serial.attr,
> >  	&dev_attr_firmware_version.attr,
> > @@ -130,6 +177,7 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> >  {
> >  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> >  		return 0;
> > +
> 
> I am surprised that Jonathan let this slide :).

He caught it, so did DaveJ. It just won't go away.

> 
> >  	return a->mode;
> >  }
> >  

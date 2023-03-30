Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BFCC761A6
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjC3So4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjC3Soz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:44:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B55119
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:44:53 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnXNs5g7vz6J7DC;
        Fri, 31 Mar 2023 02:43:09 +0800 (CST)
Received: from localhost (10.195.247.161) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 19:44:51 +0100
Date:   Thu, 30 Mar 2023 19:44:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <20230330194450.00002f30@Huawei.com>
In-Reply-To: <20230330191335.00006e07@Huawei.com>
References: <cover.1677704994.git.alison.schofield@intel.com>
        <84ac69fdfd9faa8ccb7f751358e75b0b7fd4f0d0.1677704994.git.alison.schofield@intel.com>
        <20230330191335.00006e07@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.247.161]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 30 Mar 2023 19:13:35 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed,  1 Mar 2023 13:36:26 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices optionally support the INJECT POISON mailbox command. Add
> > a sysfs attribute and memdev driver support for injecting poison. The
> > attribute is only visible for devices supporting the capability when
> > the kernel is built with CONFIG_CXL_POISON_INJECT.
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
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> One query inline about the protection against DPAs that are mapped.
> I'm not sure the checks won't rule out injection on a DPA that is
> a configured but not yet committed HDM decoder range.
> I think we should allow injection into such a memory address as it's
> not in use.

Oops. I've managed to find an old version.  Ignore these comments, I'll
take a look at v5. 

Jonathan

> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++
> >  drivers/cxl/Kconfig                     | 11 +++
> >  drivers/cxl/core/memdev.c               | 97 +++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h                    |  5 ++
> >  4 files changed, 135 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index d9421c965a3b..e19d1020f30a 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -429,3 +429,25 @@ Description:
> >  		attribute is only visible for devices supporting the
> >  		capability. The retrieved errors are logged as kernel
> >  		trace events with the label 'cxl_poison'.
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
> > index ff4e78117b31..a7ca0bbb8475 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -139,4 +139,15 @@ config CXL_REGION_INVALIDATION_TEST
> >  	  If unsure, or if this kernel is meant for production environments,
> >  	  say N.
> >  
> > +config CXL_POISON_INJECT
> > +	bool "CXL: Support CXL Memory Device Poison Inject"
> > +	depends on CXL_MEM
> > +	help
> > +	  Selecting this option creates the sysfs attributes inject_poison
> > +	  and clear_poison for CXL memory devices supporting the capability.
> > +	  This option is intended for debug scenarios only and is disabled
> > +	  by default. See Documentation/ABI/testing/sysfs-bus-cxl.  
> 
> Default for almost everything in Kconfig is off.  Is it useful to call that out
> for this one?  The unsure bit below is enough for me.
> 
> > +
> > +	  If unsure, say N.
> > +
> >  endif
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index c11b7bc253b4..82e09b81e9c6 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -165,6 +165,92 @@ static ssize_t trigger_poison_list_store(struct device *dev,
> >  }
> >  static DEVICE_ATTR_WO(trigger_poison_list);
> >  
> > +static int cxl_dpa_mapped(struct device *dev, void *data)
> > +{
> > +	struct cxl_endpoint_decoder *cxled;
> > +	u64 *dpa = data;
> > +
> > +	if (!is_endpoint_decoder(dev))
> > +		return 0;
> > +
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> > +		return 0;
> > +
> > +	if (*dpa <= cxled->dpa_res->end && *dpa >= cxled->dpa_res->start) {  
> 
> I haven't chased it all the way through, but are we guaranteed that this
> particular decoder is committed if we reach here? 
> I think the resource is setup when we set size not at point of committing
> so checking that may not be sufficient.
> 
> > +		dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n",
> > +			*dpa, dev_name(&cxled->cxld.region->dev));
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
> > +{
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct cxl_port *port;
> > +	int rc;
> > +
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
> > +		dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n", dpa);
> > +		return -EINVAL;
> > +	}
> > +	port = dev_get_drvdata(&cxlmd->dev);
> > +	if (port && is_cxl_endpoint(port) && port->commit_end != -1) {
> > +		rc = device_for_each_child(&port->dev, &dpa, cxl_dpa_mapped);
> > +		if (rc)
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t inject_poison_store(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *buf, size_t len)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_mbox_inject_poison inject;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	u64 dpa;
> > +	int rc;
> > +
> > +	rc = kstrtou64(buf, 0, &dpa);
> > +	if (rc)
> > +		return rc;
> > +
> > +	down_read(&cxl_dpa_rwsem);
> > +	rc = cxl_validate_poison_dpa(cxlmd, dpa);
> > +	if (rc) {
> > +		up_read(&cxl_dpa_rwsem);
> > +		return rc;
> > +	}
> > +
> > +	inject = (struct cxl_mbox_inject_poison) {
> > +		.address = cpu_to_le64(dpa)
> > +	};
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_INJECT_POISON,
> > +		.size_in = sizeof(inject),
> > +		.payload_in = &inject,
> > +	};
> > +	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
> > +
> > +	up_read(&cxl_dpa_rwsem);
> > +	return rc ? rc : len;
> > +}
> > +static DEVICE_ATTR_WO(inject_poison);
> > +
> >  static struct attribute *cxl_memdev_attributes[] = {
> >  	&dev_attr_serial.attr,
> >  	&dev_attr_firmware_version.attr,
> > @@ -172,6 +258,7 @@ static struct attribute *cxl_memdev_attributes[] = {
> >  	&dev_attr_label_storage_size.attr,
> >  	&dev_attr_numa_node.attr,
> >  	&dev_attr_trigger_poison_list.attr,
> > +	&dev_attr_inject_poison.attr,
> >  	NULL,
> >  };
> >  
> > @@ -198,6 +285,16 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> >  			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> >  			return 0;
> >  	}
> > +	if (a == &dev_attr_inject_poison.attr) {
> > +		struct device *dev = kobj_to_dev(kobj);
> > +
> > +		if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT))
> > +			return 0;
> > +
> > +		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
> > +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> > +			return 0;
> > +	}
> >  	return a->mode;
> >  }
> >  
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index a6eb1b42eb88..01d27f362cd6 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -602,6 +602,11 @@ struct cxl_mbox_poison_payload_out {
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
> 


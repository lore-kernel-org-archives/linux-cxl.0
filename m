Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E98C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 14:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiK3OlE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 09:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiK3OlD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 09:41:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56B2FC3B
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 06:41:00 -0800 (PST)
Received: from frapeml100008.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMhhL3DTVz67PcT;
        Wed, 30 Nov 2022 22:40:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 15:40:58 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 14:40:58 +0000
Date:   Wed, 30 Nov 2022 14:40:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/5] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <20221130144057.000024de@Huawei.com>
In-Reply-To: <20221130143136.00003808@Huawei.com>
References: <cover.1669781852.git.alison.schofield@intel.com>
        <3c260749c833f51d5cad9ae3912debcdf8b82753.1669781852.git.alison.schofield@intel.com>
        <20221130143136.00003808@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 30 Nov 2022 14:31:36 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 29 Nov 2022 20:34:33 -0800
> alison.schofield@intel.com wrote:
> 
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
> A few trivial things inline.  With those fixes LGTM
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
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
> "set to Injected."
> 
> perhaps to match spec naming in Media Error Record.
> 
> > +		the device adds a poison creation event to its internal
> > +		Informational Event log, updates the Event Status register, and
> > +		if configured, interrupts the host. It is not an error to inject
> > +		poison into an address that already has poison present and no
> > +		error is returned. The inject_poison attribute is only visible
> > +                for devices supporting the capability.  
> 
> White space issues (spaces instead of tabs?)
> 
> Add something about the masked bits / granularity of addresses that are accepted.
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
> 
> Endianness?

Got thrown by the type and missed the cpu_to_le64().  Use a local __le64 so it's all explicit.
One of the static analysis tools will correctly moan about storing it to a u64
(can't remember which).

> 
> > +			       sizeof(dpa), NULL, cxlds->payload_size);
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
> 
> 


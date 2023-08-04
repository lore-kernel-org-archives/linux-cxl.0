Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C404C00528
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 11:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjHDLGA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHDLF5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 07:05:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F119B
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 04:05:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHMhV52vdz6HJbZ;
        Fri,  4 Aug 2023 18:41:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 11:46:17 +0100
Date:   Fri, 4 Aug 2023 11:46:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: Re: [RFC PATCH v2 4/4] cxl/pci: Add support for stand alone CXL
 Switch mailbox CCI
Message-ID: <20230804114616.000032d7@Huawei.com>
In-Reply-To: <6397d1d288fed_b05d1294b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221025104243.20836-1-Jonathan.Cameron@huawei.com>
        <20221025104243.20836-5-Jonathan.Cameron@huawei.com>
        <6397d1d288fed_b05d1294b4@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 12 Dec 2022 17:13:54 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > CXL 3.0 defines a mailbox PCI function independent of any other CXL
> > components. The intent is that instances of this mailbox will be found
> > as additional PCI functions of upstream CXL switch ports.
> > 
> > RFC: Including this directly in cxl/pci.c as a second pci_driver, is a
> > bit hacky.  The alternative is to factor out all the common
> > infrastructure to a library module shared by the Type 3 PCI driver
> > and the Switch CCI driver.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > V2: Thanks to Viacheslav Dubeyko for review.
> >  - Drop double free of IDA in error path.
> >  - Switch to cxl_send_cmd()
> >  - Hex constant for size.
> >  - Shuffle code to put the release down near alloc.
> >  - Correctly handle shutdown in unregister path by setting the
> >    cxlswd->cxlds = NULL.
> >  - Use new define in pci_ids.h instead of opencoding the class code.
> > 
> > Options to consider:
> > 1 - Factor out all the shared code and have a separate module for
> >     switch CCI driver. Messy!
> > 2 - Is sharing the allow lists between type 3 devices and switch CCI
> >     an issue? Not a whole lot of overlap...
> > ---
> >  drivers/cxl/core/Makefile     |   1 +
> >  drivers/cxl/core/core.h       |   1 +
> >  drivers/cxl/core/mbox.c       |   5 ++
> >  drivers/cxl/core/port.c       |   4 +
> >  drivers/cxl/core/switch-cci.c | 149 ++++++++++++++++++++++++++++++++++  
> 
> Warning, incoming bikeshed comment: How about dropping the CCI term?
> It is really only used in the specification to indicate the class of
> transports that can convey CXL commands, but as far as Linux terminology
> it's just a mailbox. As for the filename, perhaps switchdev.c?
> 
I'd forgotten to actually incorporate this in previous versions.

There are far too many mailboxes kicking around, but sure switchdev.c sounds
safe enough and we are distant enough from other uses of that term in the
kernel that it shouldn't be a problem.

I have kept one CCI reference in the module description mostly so there
is something for grep to hit if anyone is searching for the spec term.

> 
> >  drivers/cxl/cxlmem.h          |   3 +
> >  drivers/cxl/cxlpci.h          |   3 +
> >  drivers/cxl/cxlswitch.h       |  18 ++++  
> 
> The only reason the "cxl" prefix is there for cxlmem.h and cxlpci.h is
> to not collide with "mem.h" and "pci.h" for usermode-linux builds and
> the like that confuse the core that includes those headers by include
> search path. So this one can just be switch.h unless and until a build
> robot says otherwise.
Done.

> 
> >  drivers/cxl/pci.c             |  95 +++++++++++++++++++++-
> >  include/uapi/linux/cxl_mem.h  |   3 +
> >  10 files changed, 281 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index 79c7257f4107..18275e153437 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -10,4 +10,5 @@ cxl_core-y += memdev.o
> >  cxl_core-y += mbox.o
> >  cxl_core-y += pci.o
> >  cxl_core-y += hdm.o
> > +cxl_core-y += switch-cci.o
> >  cxl_core-$(CONFIG_CXL_REGION) += region.o
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 0835942bcea6..f6a35e7f980c 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -73,5 +73,6 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> >  int cxl_memdev_init(void);
> >  void cxl_memdev_exit(void);
> >  void cxl_mbox_init(void);
> > +int cxl_switch_cci_init(void);
> >  
> >  #endif /* __CXL_CORE_H__ */
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 3823d450fdd2..76987f2e30e2 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/debugfs.h>
> >  #include <linux/mutex.h>
> >  #include <cxlmem.h>
> > +#include <cxlpci.h>
> >  #include <cxl.h>
> >  
> >  #include "core.h"
> > @@ -43,6 +44,8 @@ static bool cxl_raw_allow_all;
> >   * 0, and the user passed in 1, it is an error.
> >   */
> >  static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> > +	CXL_CMD(INFO_STAT_IDENTIFY, 0, 0x12, 0),  
> 
> Ah, guess this answers the earlier question about raw only or not.
> However if there is a non-zero possibility of this being used in
> production then it likely does want to be formalized.
> 
> > +	CXL_CMD(GET_BG_CMD_STATUS, 0, 8, 0),  
> 
> This is only for "Bind vPPB", right? In that case the result of the Bind
> comes via an event, correct? Perhaps this command does not need to be
> exposed. At least there is no use case to expose it even for endpoint
> background commands since userspace has no mechanism to reliably
> associate to which command that status refers.
Ok. Dropped.

> 
> >  	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
> >  #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
> >  	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
> > @@ -65,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> >  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> >  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> >  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> > +	CXL_CMD(IDENTIFY_SWITCH_DEVICE, 0, 0x49, 0),  
> 
> >  };
> >  
> >  /*
> > @@ -552,6 +556,7 @@ int cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
> >  
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(cxl_send_cmd);  
> 
> Why?
No idea - probably cruft from the way this code evolved. Gone.

> 
> >  
> >  static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8 *out)
> >  {
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index bffde862de0b..3b2e93bc4684 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1859,6 +1859,10 @@ static __init int cxl_core_init(void)
> >  	if (rc)
> >  		return rc;
> >  
> > +	rc = cxl_switch_cci_init();
> > +	if (rc)
> > +		return rc;
> > +
> >  	cxl_bus_wq = alloc_ordered_workqueue("cxl_port", 0);
> >  	if (!cxl_bus_wq) {
> >  		rc = -ENOMEM;
> > diff --git a/drivers/cxl/core/switch-cci.c b/drivers/cxl/core/switch-cci.c
> > new file mode 100644
> > index 000000000000..8c3f2b8a3b53
> > --- /dev/null
> > +++ b/drivers/cxl/core/switch-cci.c


> > +static int cxl_swdev_open(struct inode *inode, struct file *file)
> > +{
> > +	struct cxl_memdev *cxlswd =  
> 
> I do think a common cxl_dev is warranted, but this looks like
> s/cxl_memdev/cxl_swdev/ typo.

Indeed a typo. I'm not convinced a common cxl_dev makes sense. Not much to
it and adds another layer + I think adds unneeded complexity.

> 
> > +		container_of(inode->i_cdev, typeof(*cxlswd), cdev);
> > +
> > +	get_device(&cxlswd->dev);
> > +	file->private_data = cxlswd;
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_swdev_release_file(struct inode *inode, struct file *file)
> > +{
> > +	struct cxl_swdev *cxlswd =
> > +		container_of(inode->i_cdev, typeof(*cxlswd), cdev);
> > +
> > +	put_device(&cxlswd->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct file_operations cxl_swdev_fops = {
> > +	.owner = THIS_MODULE,
> > +	.unlocked_ioctl = cxl_swdev_ioctl,
> > +	.open = cxl_swdev_open,
> > +	.release = cxl_swdev_release_file,
> > +	.compat_ioctl = compat_ptr_ioctl,
> > +	.llseek = noop_llseek,
> > +};
> > +
> > +void cxl_swdev_shutdown(struct cxl_swdev *cxlswd)
> > +{
> > +	down_write(&cxl_swdev_rwsem);
> > +	cxlswd->cxlds = NULL;
> > +	up_write(&cxl_swdev_rwsem);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_swdev_shutdown, CXL);
> > +
> > +static void cxl_swdev_release(struct device *dev)
> > +{
> > +	struct cxl_swdev *cxlswd = to_cxl_swdev(dev);
> > +
> > +	ida_free(&cxl_swdev_ida, cxlswd->id);
> > +	kfree(cxlswd);
> > +}
> > +
> > +static const struct device_type cxl_swdev_type = {
> > +	.name = "cxl_swdev",
> > +	.release = cxl_swdev_release,
> > +	.devnode = cxl_swdev_devnode,
> > +};
> > +
> > +struct cxl_swdev *cxl_swdev_alloc(struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_swdev *cxlswd;
> > +	struct device *dev;
> > +	struct cdev *cdev;
> > +	int rc;
> > +
> > +	cxlswd = kzalloc(sizeof(*cxlswd), GFP_KERNEL);
> > +	if (!cxlswd)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rc = ida_alloc_range(&cxl_swdev_ida, 0, 10, GFP_KERNEL);
> > +	if (rc < 0) {
> > +		kfree(cxlswd);
> > +		return ERR_PTR(rc);
> > +	}
> > +
> > +	cxlswd->id = rc;
> > +	cxlswd->cxlds = cxlds;
> > +	dev = &cxlswd->dev;
> > +	device_initialize(dev);
> > +	dev->parent = cxlds->dev;
> > +	dev->bus = &cxl_bus_type;
> > +	dev->devt = MKDEV(cxl_sw_major, cxlswd->id);
> > +	dev->type = &cxl_swdev_type;
> > +	device_set_pm_not_required(dev);
> > +	cdev = &cxlswd->cdev;
> > +	cdev_init(cdev, &cxl_swdev_fops);
> > +	rc = dev_set_name(dev, "swcci%d", cxlswd->id);  
> 
> How about just "switch%d"? Likely this will also want some late binding
> linkage to the eventual cxl_port that gets registered for this switch.

So far I'm not seeing much point in that linkage. This functionality may
well be exposed on a USP with no CXL capabilities at all. 

> 
> > +	if (rc) {
> > +		put_device(dev);
> > +		return ERR_PTR(rc);
> > +	}
> > +
> > +	return cxlswd;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_swdev_alloc, CXL);  
> 
> I think a few exports can be saved if this is changed to alloc+add like
> other cxl core apis.

Sorry, I don't follow. 

> 
> > +
> > +__init int cxl_switch_cci_init(void)
> > +{
> > +	dev_t devt;
> > +	int rc;
> > +
> > +	rc = alloc_chrdev_region(&devt, 0, 10, "cxlsw");
> > +	if (rc)
> > +		return rc;
> > +	cxl_sw_major = MAJOR(devt);
> > +
> > +	return 0;
> > +}

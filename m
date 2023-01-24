Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDBFC61D97
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 16:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjAXQpK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 11:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjAXQpF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 11:45:05 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69619002
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 08:44:56 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1Xqd1Sr7z6J9hC;
        Wed, 25 Jan 2023 00:44:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 16:44:54 +0000
Date:   Tue, 24 Jan 2023 16:44:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH] cxl/pmem: Fix nvdimm unregistration when cxl_pmem
 driver is absent
Message-ID: <20230124164453.000029c6@Huawei.com>
In-Reply-To: <26633055-4e38-01c3-19a5-ef83fd57b533@intel.com>
References: <167426077263.3955046.9695309346988027311.stgit@dwillia2-xfh.jf.intel.com>
        <26633055-4e38-01c3-19a5-ef83fd57b533@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 24 Jan 2023 08:46:58 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/20/23 5:26 PM, Dan Williams wrote:
> > The cxl_pmem.ko module houses the driver for both cxl_nvdimm_bridge
> > objects and cxl_nvdimm objects. When the core creates a cxl_nvdimm it
> > arranges for it to be autoremoved when the bridge goes down. However, if
> > the bridge never initialized because the cxl_pmem.ko module never
> > loaded, it sets up a the following crash scenario:
> > 
> >      BUG: kernel NULL pointer dereference, address: 0000000000000478
> >      [..]
> >      RIP: 0010:cxl_nvdimm_probe+0x99/0x140 [cxl_pmem]
> >      [..]
> >      Call Trace:
> >       <TASK>
> >       cxl_bus_probe+0x17/0x50 [cxl_core]
> >       really_probe+0xde/0x380
> >       __driver_probe_device+0x78/0x170
> >       driver_probe_device+0x1f/0x90
> >       __driver_attach+0xd2/0x1c0
> >       bus_for_each_dev+0x79/0xc0
> >       bus_add_driver+0x1b1/0x200
> >       driver_register+0x89/0xe0
> >       cxl_pmem_init+0x50/0xff0 [cxl_pmem]
> > 
> > It turns out the recent rework to simplify nvdimm probing obviated the
> > need to unregister cxl_nvdimm objects at cxl_nvdimm_bridge ->remove()
> > time. Leave the cxl_nvdimm device registered until the hosting
> > cxl_memdev departs. The alternative is that the cxl_memdev needs to be
> > reattached whenever the cxl_nvdimm_bridge attach state cycles, which is
> > awkward and unnecessary.
> > 
> > The only requirement is to make sure that when the cxl_nvdimm_bridge
> > goes away any dependent cxl_nvdimm objects are shutdown. Handle that in
> > unregister_nvdimm_bus().
> > 
> > With these registration entanglements removed there is no longer a need
> > to pre-load the cxl_pmem module in cxl_acpi.
> > 
> > Fixes: cb9cfff82f6a ("cxl/acpi: Simplify cxl_nvdimm_bridge probing")
> > Reported-by: Gregory Price <gregory.price@memverge.com>
> > Debugged-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Took a bit of poking around to figure out how to get the device_release_driver
to happen (rmmod cxl_acpi worked) but I've poked it in a bunch of simple ways
and can't get anything to break any more :) So with that in mind

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> A side note, the naming of cxlmd->cxl_nvd and cxlmd->cxl_nvb makes it 
> really difficult to read. I wonder if cxl_nv_bridge and cxl_nv_device 
> would lead to clearer code.
Absolutely agree!

> 
> > ---
> >   drivers/cxl/acpi.c      |    1 -
> >   drivers/cxl/core/pmem.c |   42 ++++--------------------------------------
> >   drivers/cxl/pmem.c      |   24 ++++++++++++++++++++++++
> >   3 files changed, 28 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index ad0849af42d7..13cde44c6086 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -736,4 +736,3 @@ module_exit(cxl_acpi_exit);
> >   MODULE_LICENSE("GPL v2");
> >   MODULE_IMPORT_NS(CXL);
> >   MODULE_IMPORT_NS(ACPI);
> > -MODULE_SOFTDEP("pre: cxl_pmem");
> > diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> > index f3d2169b6731..c2e4b1093788 100644
> > --- a/drivers/cxl/core/pmem.c
> > +++ b/drivers/cxl/core/pmem.c
> > @@ -227,34 +227,16 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
> >   	return cxl_nvd;
> >   }
> >   
> > -static void cxl_nvd_unregister(void *_cxl_nvd)
> > +static void cxlmd_release_nvdimm(void *_cxlmd)
> >   {
> > -	struct cxl_nvdimm *cxl_nvd = _cxl_nvd;
> > -	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> > +	struct cxl_memdev *cxlmd = _cxlmd;
> > +	struct cxl_nvdimm *cxl_nvd = cxlmd->cxl_nvd;
> >   	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
> >   
> > -	/*
> > -	 * Either the bridge is in ->remove() context under the device_lock(),
> > -	 * or cxlmd_release_nvdimm() is cancelling the bridge's release action
> > -	 * for @cxl_nvd and doing it itself (while manually holding the bridge
> > -	 * lock).
> > -	 */
> > -	device_lock_assert(&cxl_nvb->dev);
> >   	cxl_nvd->cxlmd = NULL;
> >   	cxlmd->cxl_nvd = NULL;
> > +	cxlmd->cxl_nvb = NULL;
> >   	device_unregister(&cxl_nvd->dev);
> > -}
> > -
> > -static void cxlmd_release_nvdimm(void *_cxlmd)
> > -{
> > -	struct cxl_memdev *cxlmd = _cxlmd;
> > -	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
> > -
> > -	device_lock(&cxl_nvb->dev);
> > -	if (cxlmd->cxl_nvd)
> > -		devm_release_action(&cxl_nvb->dev, cxl_nvd_unregister,
> > -				    cxlmd->cxl_nvd);
> > -	device_unlock(&cxl_nvb->dev);
> >   	put_device(&cxl_nvb->dev);
> >   }
> >   
> > @@ -293,22 +275,6 @@ int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
> >   
> >   	dev_dbg(&cxlmd->dev, "register %s\n", dev_name(dev));
> >   
> > -	/*
> > -	 * The two actions below arrange for @cxl_nvd to be deleted when either
> > -	 * the top-level PMEM bridge goes down, or the endpoint device goes
> > -	 * through ->remove().
> > -	 */
> > -	device_lock(&cxl_nvb->dev);
> > -	if (cxl_nvb->dev.driver)
> > -		rc = devm_add_action_or_reset(&cxl_nvb->dev, cxl_nvd_unregister,
> > -					      cxl_nvd);
> > -	else
> > -		rc = -ENXIO;
> > -	device_unlock(&cxl_nvb->dev);
> > -
> > -	if (rc)
> > -		goto err_alloc;
> > -
> >   	/* @cxlmd carries a reference on @cxl_nvb until cxlmd_release_nvdimm */
> >   	return devm_add_action_or_reset(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);
> >   
> > diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> > index eedefebc4283..08bbbac9a6d0 100644
> > --- a/drivers/cxl/pmem.c
> > +++ b/drivers/cxl/pmem.c
> > @@ -225,11 +225,35 @@ static int cxl_pmem_ctl(struct nvdimm_bus_descriptor *nd_desc,
> >   	return cxl_pmem_nvdimm_ctl(nvdimm, cmd, buf, buf_len);
> >   }
> >   
> > +static int detach_nvdimm(struct device *dev, void *data)
> > +{
> > +	struct cxl_nvdimm *cxl_nvd;
> > +	bool release = false;
> > +
> > +	if (!is_cxl_nvdimm(dev))
> > +		return 0;
> > +
> > +	device_lock(dev);
> > +	if (!dev->driver)
> > +		goto out;
> > +
> > +	cxl_nvd = to_cxl_nvdimm(dev);
> > +	if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
> > +		release = true;
> > +out:
> > +	device_unlock(dev);
> > +	if (release)
> > +		device_release_driver(dev);
> > +	return 0;
> > +}
> > +
> >   static void unregister_nvdimm_bus(void *_cxl_nvb)
> >   {
> >   	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
> >   	struct nvdimm_bus *nvdimm_bus = cxl_nvb->nvdimm_bus;
> >   
> > +	bus_for_each_dev(&cxl_bus_type, NULL, cxl_nvb, detach_nvdimm);
> > +
> >   	cxl_nvb->nvdimm_bus = NULL;
> >   	nvdimm_bus_unregister(nvdimm_bus);
> >   }
> >   


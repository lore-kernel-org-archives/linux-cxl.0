Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875FCC7EE29
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjFHKr0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjFHKrZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 06:47:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A329E6C
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 03:47:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QcLW535Cjz6J7sY;
        Thu,  8 Jun 2023 18:46:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 11:47:11 +0100
Date:   Thu, 8 Jun 2023 11:47:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vikram Sethi <vsethi@nvidia.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "navneet.singh@intel.com" <navneet.singh@intel.com>
Subject: Re: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator with
 local memory
Message-ID: <20230608114710.000058e8@Huawei.com>
In-Reply-To: <BYAPR12MB333690E529D339194795EF50BD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com>
        <BYAPR12MB333690E529D339194795EF50BD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
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

On Wed, 7 Jun 2023 21:09:21 +0000
Vikram Sethi <vsethi@nvidia.com> wrote:

> Thanks for posting this Dan. 
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Sunday, June 4, 2023 6:33 PM
> > To: linux-cxl@vger.kernel.org
> > Cc: ira.weiny@intel.com; navneet.singh@intel.com
> > Subject: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator with local
> > memory 
> > 
> > Mock-up a device that does not have a standard mailbox, i.e. a device that
> > does not implement the CXL memory-device class code, but wants to map
> > "device" memory (aka Type-2, aka HDM-D[B], aka accelerator memory).
> > 
> > For extra code coverage make this device an RCD to test region creation
> > flows in the presence of an RCH topology (memory device modeled as a
> > root-complex-integrated-endpoint RCIEP).
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/memdev.c    |   15 +++++++
> >  drivers/cxl/cxlmem.h         |    1
> >  tools/testing/cxl/test/cxl.c |   16 +++++++-
> >  tools/testing/cxl/test/mem.c |   85
> > +++++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 112 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c index
> > 859c43c340bb..5d1ba7a72567 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -467,6 +467,21 @@ static void detach_memdev(struct work_struct
> > *work)
> >         put_device(&cxlmd->dev);
> >  }
> > 
> > +struct cxl_dev_state *cxl_accel_state_create(struct device *dev) {
> > +       struct cxl_dev_state *cxlds;
> > +
> > +       cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> > +       if (!cxlds)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       cxlds->dev = dev;
> > +       cxlds->type = CXL_DEVTYPE_DEVMEM;
> > +
> > +       return cxlds;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
> > +
> >  static struct lock_class_key cxl_memdev_key;
> > 
> >  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
> > ad7f806549d3..89e560ea14c0 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -746,6 +746,7 @@ int cxl_await_media_ready(struct cxl_dev_state
> > *cxlds);  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);  int
> > cxl_mem_create_range_info(struct cxl_memdev_state *mds);  struct
> > cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
> > +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> >  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> >                                 unsigned long *cmds);  void
> > clear_exclusive_cxl_commands(struct cxl_memdev_state *mds, diff --git
> > a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c index
> > e3f1b2e88e3e..385cdeeab22c 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -278,7 +278,7 @@ static struct {
> >                         },
> >                         .interleave_ways = 0,
> >                         .granularity = 4,
> > -                       .restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> > +                       .restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE2 |
> >                                         ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
> >                         .qtg_id = 5,
> >                         .window_size = SZ_256M, @@ -713,7 +713,19 @@ static void
> > default_mock_decoder(struct cxl_decoder *cxld)
> > 
> >         cxld->interleave_ways = 1;
> >         cxld->interleave_granularity = 256;
> > -       cxld->target_type = CXL_DECODER_HOSTMEM;
> > +       if (is_endpoint_decoder(&cxld->dev)) {
> > +               struct cxl_endpoint_decoder *cxled;
> > +               struct cxl_dev_state *cxlds;
> > +               struct cxl_memdev *cxlmd;
> > +
> > +               cxled = to_cxl_endpoint_decoder(&cxld->dev);
> > +               cxlmd = cxled_to_memdev(cxled);
> > +               cxlds = cxlmd->cxlds;
> > +               if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> > +                       cxld->target_type = CXL_DECODER_HOSTMEM;
> > +               else
> > +                       cxld->target_type = CXL_DECODER_DEVMEM;
> > +       }
> >         cxld->commit = mock_decoder_commit;
> >         cxld->reset = mock_decoder_reset;  } diff --git
> > a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c index
> > 6fb5718588f3..620bfcf5e5a5 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -1189,11 +1189,21 @@ static void label_area_release(void *lsa)
> >         vfree(lsa);
> >  }
> > 
> > +#define CXL_MOCKMEM_RCD BIT(0)
> > +#define CXL_MOCKMEM_TYPE2 BIT(1)
> > +
> >  static bool is_rcd(struct platform_device *pdev)  {
> >         const struct platform_device_id *id = platform_get_device_id(pdev);
> > 
> > -       return !!id->driver_data;
> > +       return !!(id->driver_data & CXL_MOCKMEM_RCD); }
> > +
> > +static bool is_type2(struct platform_device *pdev) {
> > +       const struct platform_device_id *id =
> > +platform_get_device_id(pdev);
> > +
> > +       return !!(id->driver_data & CXL_MOCKMEM_TYPE2);
> >  }
> > 
> >  static ssize_t event_trigger_store(struct device *dev, @@ -1205,7 +1215,7
> > @@ static ssize_t event_trigger_store(struct device *dev,  }  static
> > DEVICE_ATTR_WO(event_trigger);
> > 
> > -static int cxl_mock_mem_probe(struct platform_device *pdev)
> > +static int __cxl_mock_mem_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> >         struct cxl_memdev *cxlmd;
> > @@ -1274,6 +1284,75 @@ static int cxl_mock_mem_probe(struct
> > platform_device *pdev)
> >         return 0;
> >  }
> > 
> > +static int cxl_mock_type2_probe(struct platform_device *pdev) {
> > +       struct cxl_endpoint_decoder *cxled;
> > +       struct device *dev = &pdev->dev;
> > +       struct cxl_root_decoder *cxlrd;
> > +       struct cxl_dev_state *cxlds;
> > +       struct cxl_port *endpoint;
> > +       struct cxl_memdev *cxlmd;
> > +       resource_size_t max = 0;
> > +       int rc;
> > +
> > +       cxlds = cxl_accel_state_create(dev);
> > +       if (IS_ERR(cxlds))
> > +               return PTR_ERR(cxlds);
> > +
> > +       cxlds->serial = pdev->id;
> > +       cxlds->component_reg_phys = CXL_RESOURCE_NONE;
> > +       cxlds->dpa_res = DEFINE_RES_MEM(0, DEV_SIZE);
> > +       cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, DEV_SIZE, "ram");
> > +       cxlds->pmem_res = DEFINE_RES_MEM_NAMED(DEV_SIZE, 0, "pmem");
> > +       if (is_rcd(pdev))
> > +               cxlds->rcd = true;
> > +
> > +       rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
> > +       if (rc)
> > +               return rc;
> > +
> > +       cxlmd = devm_cxl_add_memdev(cxlds);
> > +       if (IS_ERR(cxlmd))
> > +               return PTR_ERR(cxlmd);
> > +
> > +       endpoint = cxl_acquire_endpoint(cxlmd);
> > +       if (IS_ERR(endpoint))
> > +               return PTR_ERR(endpoint);
> > +
> > +       cxlrd = cxl_hpa_freespace(endpoint, &endpoint->host_bridge, 1,
> > +                                 CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> > +                                 &max);
> > +  
> 

> IIUC, finding free HPA space is for the case where the platform FW
> has not already allocated it and initialized the HDM ranges in the
> device decoders, correct? If the accelerator driver recognized that
> FW had initialized its HPA ranges in the device decoders (without
> committing/locking the decoders), could it skip the cxl_hpa_freespace
> call? It would seem reasonable for FW to init the decoder but not
> commit/lock it. 

I'd find it a bit odd if firmware did a partial job...
Why do you think it might?  To pass a hint to the kernel?


> 
> > +       if (IS_ERR(cxlrd)) {
> > +               rc = PTR_ERR(cxlrd);
> > +               goto out;
> > +       }
> > +
> > +       cxled = cxl_request_dpa(endpoint, CXL_DECODER_RAM, 0, max);
> > +       if (IS_ERR(cxled)) {
> > +               rc = PTR_ERR(cxled);
> > +               goto out_cxlrd;
> > +       }
> > +
> > +       /* A real driver would do something with the returned region */
> > +       rc = PTR_ERR_OR_ZERO(cxl_create_region(cxlrd, &cxled, 1));  
> 

> Assuming the accelerator driver wanted to add some, or all of its
> coherent memory to the kernel MM via add_memory_driver_managed, I
> think it would get the HPA ranges from the decoder's hpa_range field.
> But that API also needs a node ID. If the FW ACPI tables had shown
> the accelerator Generic Initiator Affinity structure, then I believe
> the accelerator's device struct should already have its numa node,
> and the same could be passed to add_memory_driver_managed. Does that
> sound right, or is there a better way to ensure the accelerator
> memory gets a distinct NUMA node?

If it has a GI node assigned I agree that probably makes sense.
There might be some fiddly corners where it doesn't but they are probably
the exception (multiple memory types, or different access characteristics,
need to represent some other topology complexities)


> If the ACPI tables had not shown
> the device as a generic initiator, is there any notion of the cxl
> memory device structs having a new/distinct NUMA node for the memory
> device, or would it just be pointing to the NUMA node of the
> associated CPU socket which has the host bridge or a default 0 NUMA
> node?

I'll leave this one for others (mostly :). I personally think current model is too
simplistic and we need to bite the bullet and work out how to do full
dynamic numa node creation rather that using some preallocated ones.

> 
> > +
> > +       put_device(cxled_dev(cxled));
> > +out_cxlrd:
> > +       put_device(cxlrd_dev(cxlrd));
> > +out:
> > +       cxl_release_endpoint(cxlmd, endpoint);
> > +
> > +       return rc;
> > +}
> > +
> > +static int cxl_mock_mem_probe(struct platform_device *pdev) {
> > +       if (is_type2(pdev))
> > +               return cxl_mock_type2_probe(pdev);
> > +       return __cxl_mock_mem_probe(pdev); }
> > +
> >  static ssize_t security_lock_show(struct device *dev,
> >                                   struct device_attribute *attr, char *buf)  { @@ -1316,7
> > +1395,7 @@ ATTRIBUTE_GROUPS(cxl_mock_mem);
> > 
> >  static const struct platform_device_id cxl_mock_mem_ids[] = {
> >         { .name = "cxl_mem", 0 },
> > -       { .name = "cxl_rcd", 1 },
> > +       { .name = "cxl_rcd", CXL_MOCKMEM_RCD | CXL_MOCKMEM_TYPE2 },
> >         { },
> >  };
> >  MODULE_DEVICE_TABLE(platform, cxl_mock_mem_ids);  
> 


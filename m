Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F86C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 15:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjAXPrG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjAXPrC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 10:47:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59721268E
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674575220; x=1706111220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=upY9s2oQSYyNHTBBWCgQjWzUFkeNku0F2ozNZsMoNh4=;
  b=JxX4Mzc0XyJCAFaO03QpKi5ajj4ngTA7aFNQ+mO2qvHyF0Pw5YB8F5Ch
   DDTViXY3amMX2lP+M8WdGvJkd8fdyooymqWDHpoDbyl6DZ4oIYw4blv/j
   u5ilur0ueRsqpvuDIXfNcEWyDw7tmZ4uSWUts43T4ShlI5tjUNg0r9LDI
   pZdC8DvvVHiXwkS+hAZl/O7aeBDi55PoVzAKPCzFdTL0Zhqe/B+jDD8xw
   9z+yO2dNVq7go7W0NTwLlmbnzvmYWQlHvAIhejzjUgdgtjAgb/jEkl45L
   7/5V+3sBI6h+/8A4+SwFVff1AfhYsjMc42FROdIjhW1juJevuVnjZjxFv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="327580507"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="327580507"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:46:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="770360993"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="770360993"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.182.87]) ([10.213.182.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:46:58 -0800
Message-ID: <26633055-4e38-01c3-19a5-ef83fd57b533@intel.com>
Date:   Tue, 24 Jan 2023 08:46:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl/pmem: Fix nvdimm unregistration when cxl_pmem driver
 is absent
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Jonathan.Cameron@huawei.com
References: <167426077263.3955046.9695309346988027311.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167426077263.3955046.9695309346988027311.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/20/23 5:26 PM, Dan Williams wrote:
> The cxl_pmem.ko module houses the driver for both cxl_nvdimm_bridge
> objects and cxl_nvdimm objects. When the core creates a cxl_nvdimm it
> arranges for it to be autoremoved when the bridge goes down. However, if
> the bridge never initialized because the cxl_pmem.ko module never
> loaded, it sets up a the following crash scenario:
> 
>      BUG: kernel NULL pointer dereference, address: 0000000000000478
>      [..]
>      RIP: 0010:cxl_nvdimm_probe+0x99/0x140 [cxl_pmem]
>      [..]
>      Call Trace:
>       <TASK>
>       cxl_bus_probe+0x17/0x50 [cxl_core]
>       really_probe+0xde/0x380
>       __driver_probe_device+0x78/0x170
>       driver_probe_device+0x1f/0x90
>       __driver_attach+0xd2/0x1c0
>       bus_for_each_dev+0x79/0xc0
>       bus_add_driver+0x1b1/0x200
>       driver_register+0x89/0xe0
>       cxl_pmem_init+0x50/0xff0 [cxl_pmem]
> 
> It turns out the recent rework to simplify nvdimm probing obviated the
> need to unregister cxl_nvdimm objects at cxl_nvdimm_bridge ->remove()
> time. Leave the cxl_nvdimm device registered until the hosting
> cxl_memdev departs. The alternative is that the cxl_memdev needs to be
> reattached whenever the cxl_nvdimm_bridge attach state cycles, which is
> awkward and unnecessary.
> 
> The only requirement is to make sure that when the cxl_nvdimm_bridge
> goes away any dependent cxl_nvdimm objects are shutdown. Handle that in
> unregister_nvdimm_bus().
> 
> With these registration entanglements removed there is no longer a need
> to pre-load the cxl_pmem module in cxl_acpi.
> 
> Fixes: cb9cfff82f6a ("cxl/acpi: Simplify cxl_nvdimm_bridge probing")
> Reported-by: Gregory Price <gregory.price@memverge.com>
> Debugged-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

A side note, the naming of cxlmd->cxl_nvd and cxlmd->cxl_nvb makes it 
really difficult to read. I wonder if cxl_nv_bridge and cxl_nv_device 
would lead to clearer code.

> ---
>   drivers/cxl/acpi.c      |    1 -
>   drivers/cxl/core/pmem.c |   42 ++++--------------------------------------
>   drivers/cxl/pmem.c      |   24 ++++++++++++++++++++++++
>   3 files changed, 28 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index ad0849af42d7..13cde44c6086 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -736,4 +736,3 @@ module_exit(cxl_acpi_exit);
>   MODULE_LICENSE("GPL v2");
>   MODULE_IMPORT_NS(CXL);
>   MODULE_IMPORT_NS(ACPI);
> -MODULE_SOFTDEP("pre: cxl_pmem");
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index f3d2169b6731..c2e4b1093788 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -227,34 +227,16 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
>   	return cxl_nvd;
>   }
>   
> -static void cxl_nvd_unregister(void *_cxl_nvd)
> +static void cxlmd_release_nvdimm(void *_cxlmd)
>   {
> -	struct cxl_nvdimm *cxl_nvd = _cxl_nvd;
> -	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> +	struct cxl_memdev *cxlmd = _cxlmd;
> +	struct cxl_nvdimm *cxl_nvd = cxlmd->cxl_nvd;
>   	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
>   
> -	/*
> -	 * Either the bridge is in ->remove() context under the device_lock(),
> -	 * or cxlmd_release_nvdimm() is cancelling the bridge's release action
> -	 * for @cxl_nvd and doing it itself (while manually holding the bridge
> -	 * lock).
> -	 */
> -	device_lock_assert(&cxl_nvb->dev);
>   	cxl_nvd->cxlmd = NULL;
>   	cxlmd->cxl_nvd = NULL;
> +	cxlmd->cxl_nvb = NULL;
>   	device_unregister(&cxl_nvd->dev);
> -}
> -
> -static void cxlmd_release_nvdimm(void *_cxlmd)
> -{
> -	struct cxl_memdev *cxlmd = _cxlmd;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
> -
> -	device_lock(&cxl_nvb->dev);
> -	if (cxlmd->cxl_nvd)
> -		devm_release_action(&cxl_nvb->dev, cxl_nvd_unregister,
> -				    cxlmd->cxl_nvd);
> -	device_unlock(&cxl_nvb->dev);
>   	put_device(&cxl_nvb->dev);
>   }
>   
> @@ -293,22 +275,6 @@ int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
>   
>   	dev_dbg(&cxlmd->dev, "register %s\n", dev_name(dev));
>   
> -	/*
> -	 * The two actions below arrange for @cxl_nvd to be deleted when either
> -	 * the top-level PMEM bridge goes down, or the endpoint device goes
> -	 * through ->remove().
> -	 */
> -	device_lock(&cxl_nvb->dev);
> -	if (cxl_nvb->dev.driver)
> -		rc = devm_add_action_or_reset(&cxl_nvb->dev, cxl_nvd_unregister,
> -					      cxl_nvd);
> -	else
> -		rc = -ENXIO;
> -	device_unlock(&cxl_nvb->dev);
> -
> -	if (rc)
> -		goto err_alloc;
> -
>   	/* @cxlmd carries a reference on @cxl_nvb until cxlmd_release_nvdimm */
>   	return devm_add_action_or_reset(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);
>   
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index eedefebc4283..08bbbac9a6d0 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -225,11 +225,35 @@ static int cxl_pmem_ctl(struct nvdimm_bus_descriptor *nd_desc,
>   	return cxl_pmem_nvdimm_ctl(nvdimm, cmd, buf, buf_len);
>   }
>   
> +static int detach_nvdimm(struct device *dev, void *data)
> +{
> +	struct cxl_nvdimm *cxl_nvd;
> +	bool release = false;
> +
> +	if (!is_cxl_nvdimm(dev))
> +		return 0;
> +
> +	device_lock(dev);
> +	if (!dev->driver)
> +		goto out;
> +
> +	cxl_nvd = to_cxl_nvdimm(dev);
> +	if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
> +		release = true;
> +out:
> +	device_unlock(dev);
> +	if (release)
> +		device_release_driver(dev);
> +	return 0;
> +}
> +
>   static void unregister_nvdimm_bus(void *_cxl_nvb)
>   {
>   	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
>   	struct nvdimm_bus *nvdimm_bus = cxl_nvb->nvdimm_bus;
>   
> +	bus_for_each_dev(&cxl_bus_type, NULL, cxl_nvb, detach_nvdimm);
> +
>   	cxl_nvb->nvdimm_bus = NULL;
>   	nvdimm_bus_unregister(nvdimm_bus);
>   }
> 

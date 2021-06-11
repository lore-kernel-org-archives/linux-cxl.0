Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299FEC48BD1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036B261404
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 13:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhFKNjd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 09:39:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3223 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhFKNjd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 09:39:33 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G1hVd01vqz6L7GC;
        Fri, 11 Jun 2021 21:28:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 15:37:34 +0200
Received: from localhost (10.52.120.251) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 14:37:33 +0100
Date:   Fri, 11 Jun 2021 14:37:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 2/4] cxl/region: Create attribute structure / verify
Message-ID: <20210611143729.00004dbc@Huawei.com>
In-Reply-To: <20210610185725.897541-3-ben.widawsky@intel.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
        <20210610185725.897541-3-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.251]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 10 Jun 2021 11:57:23 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Introduce a verification mechanism for a region. Regions have complex
> configuration requirements and it is beneficial to provide a way to
> verify the constraints are met before trying to bind. Primarily it adds
> ABI to inform userspace of more detailed information about what failed
> rather than the limited choices of errno at bind time.
> 
> It's important to point out that a verified region can still fail to
> bind, but the first step in binding will be to run the same verification
> algorithm.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> --
> 
> Functionally it might make sense to squash this patch in with other
> patches adding attributes. From a discussion standpoint however, it's
> nice to have this broken out as I suspect there might be some debate
> about it.

Hmm. Definitely squash it in later, as this is downright odd at the moment!

Is there precedence elsewhere for this interface approach?
I can see the advantage of it as it lets us pass through invalid states
whilst configuring but it is somewhat unusual.

Probably one for linux-api@vger.kernel.org to get more exposure to people
who care about this stuff.  I suspect there aren't that many people
on linux-cxl yet ;)

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++++++++++
>  drivers/cxl/region.c                    | 22 +++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 5bcbefd4ea38..699c8514fd7b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -146,3 +146,16 @@ Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		Deletes the named region. A region must be unbound from the
>  		region driver before being deleted.
> +
> +What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/verify
> +Date:		June, 2021
> +KernelVersion:	v5.14
> +Contact:	linux-cxl@vger.kernel.org
> +Description:

Doing 'what' to this file causes to this to happen?
You want to state that "Reading this file instructs..."

> +		Instructs the kernel to verify that the regionX.Y:Z is properly
> +		configured and provide more detailed information about
> +		configuration errors. A value of 0 indicates the region is
> +		properly configured and ready to bind, otherwise a negative
> +		integer is returned describing the first error found in the
> +		configuration. A verified region can still fail binding due to
> +		lack of resources.
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index 1f47bc17bd50..ea1ac848c713 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -20,11 +20,31 @@
>   * relationship between decoder and region when the region is interleaved.
>   */
>  
> -static void cxl_region_release(struct device *dev);
> +static ssize_t verify_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "0");
> +}
> +
> +static DEVICE_ATTR_RO(verify);
> +
> +static struct attribute *region_attrs[] = {
> +	&dev_attr_verify.attr,
> +	NULL,
> +};
>  
> +static const struct attribute_group region_group = {
> +	.attrs = region_attrs,
> +};
> +
> +static const struct attribute_group *region_groups[] = {
> +	&region_group,
> +};
> +
> +static void cxl_region_release(struct device *dev);
>  static const struct device_type cxl_region_type = {
>  	.name = "cxl_region",
>  	.release = cxl_region_release,
> +	.groups = region_groups,
>  };
>  
>  static struct cxl_region *to_cxl_region(struct device *dev)


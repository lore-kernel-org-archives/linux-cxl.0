Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF9BC54EBE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 11:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjAMLti (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241163AbjAMLtO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 06:49:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7FB8CBE3
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 03:39:15 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtfWg4MN8z6J67T;
        Fri, 13 Jan 2023 19:36:31 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 11:39:12 +0000
Date:   Fri, 13 Jan 2023 11:39:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/port: Link the 'parent_dport' in portX/ and
 endpointX/ sysfs
Message-ID: <20230113113911.00007348@Huawei.com>
In-Reply-To: <167124082375.1626103.6047000000121298560.stgit@dwillia2-xfh.jf.intel.com>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
        <167124082375.1626103.6047000000121298560.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 16 Dec 2022 17:33:43 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Similar to the justification in:
> 
> 1b58b4cac6fc ("cxl/port: Record parent dport when adding ports")
> 
> ...userspace wants to know the routing information for ports for
> calculating the memdev order for region creation among other things.
> Cache the information the kernel discovers at enumeration time in a
> 'parent_dport' attribute to save userspace the time of trawling sysfs
> to recover the same information.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm not totally sold on this being worth while as opposed to building reverse
look up in userspace, but meh - seems harmless and is consistent and tiny
amount of code so

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   15 +++++++++++++++
>  drivers/cxl/core/port.c                 |   27 +++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 8494ef27e8d2..1b17c8cb48b5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -90,6 +90,21 @@ Description:
>  		capability.
>  
>  
> +What:		/sys/bus/cxl/devices/{port,endpoint}X/parent_dport
> +Date:		October, 2022
> +KernelVersion:	v6.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) CXL port objects are instantiated for each upstream port in
> +		a CXL/PCIe switch, and for each endpoint to map the
> +		corresponding memory device into the CXL port hierarchy. When a
> +		descendant CXL port (switch or endpoint) is enumerated it is
> +		useful to know which 'dport' object in the parent CXL port
> +		routes to this descendant. The 'parent_dport' symlink points to
> +		the device representing the downstream port of a CXL switch that
> +		routes to {port,endpoint}X.
> +
> +
>  What:		/sys/bus/cxl/devices/portX/dportY
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6296d2bc909a..729e4aab5308 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -586,6 +586,29 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
>  	return devm_add_action_or_reset(host, cxl_unlink_uport, port);
>  }
>  
> +static void cxl_unlink_parent_dport(void *_port)
> +{
> +	struct cxl_port *port = _port;
> +
> +	sysfs_remove_link(&port->dev.kobj, "parent_dport");
> +}
> +
> +static int devm_cxl_link_parent_dport(struct device *host,
> +				      struct cxl_port *port,
> +				      struct cxl_dport *parent_dport)
> +{
> +	int rc;
> +
> +	if (!parent_dport)
> +		return 0;
> +
> +	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dport->kobj,
> +			       "parent_dport");
> +	if (rc)
> +		return rc;
> +	return devm_add_action_or_reset(host, cxl_unlink_parent_dport, port);
> +}
> +
>  static struct lock_class_key cxl_port_key;
>  
>  static struct cxl_port *cxl_port_alloc(struct device *uport,
> @@ -695,6 +718,10 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	rc = devm_cxl_link_parent_dport(host, port, parent_dport);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
>  	return port;
>  
>  err:
> 


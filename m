Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD46C7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 14:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjFAOU7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjFAOUx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 10:20:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C729C186
        for <linux-cxl@vger.kernel.org>; Thu,  1 Jun 2023 07:20:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX7Xz36Gxz6D8W5;
        Thu,  1 Jun 2023 22:18:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 15:20:43 +0100
Date:   Thu, 1 Jun 2023 15:20:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v6 06/11] cxl: Store the access coordinates for the
 generic ports
Message-ID: <20230601152042.0000575b@Huawei.com>
In-Reply-To: <168451603029.3470703.13447576080193633262.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
        <168451603029.3470703.13447576080193633262.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023 10:07:10 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Each CXL host bridge is represented by an ACPI0016 device. A generic port
> device handle that is an ACPI device is represented by a string of
> ACPI0016 device HID and UID. Create a device handle from the ACPI device
> and retrieve the access coordinates from the stored memory targets. The
> access coordinates are stored under the cxl_dport that is associated with
> the CXL host bridge.
> 
> The access coordinates struct is dynamically allocated under cxl_dport in
> order for code later on to detect whether the data exists or not.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
Trivial suggestion inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I guess I got distracted a while back and only half reviewed this version.
Sorry about the delay!

> ---
> v6:
> - Change memcpy to strncpy. ACPI HID and UID are strings.
> ---
>  drivers/cxl/acpi.c |   22 ++++++++++++++++++++++
>  drivers/cxl/cxl.h  |    2 ++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 8247df06d683..0c22cc9dbcba 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -557,8 +557,26 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>  	return 0;
>  }
>  
> +static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
> +{
> +	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
> +	u8 handle[ACPI_SRAT_DEVICE_HANDLE_SIZE] = { 0 };
> +	int rc;
> +
> +	/* ACPI spec 6.5 table 5.65 */
> +	strncpy(handle, acpi_device_hid(hb), 8);
> +	strncpy(&handle[8], acpi_device_uid(hb), 4);
> +
> +	rc = acpi_get_genport_coordinates(handle, &dport->hb_access);
> +	if (rc)
> +		return rc;


	return acpi_get_genport....

and get rid of local variable rc as no longer used.

> +
> +	return 0;
> +}
> +
>  static int add_host_bridge_dport(struct device *match, void *arg)
>  {
> +	int ret;
>  	acpi_status rc;
>  	struct device *bridge;
>  	unsigned long long uid;
> @@ -614,6 +632,10 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	if (IS_ERR(dport))
>  		return PTR_ERR(dport);
>  
> +	ret = get_genport_coordinates(match, dport);
> +	if (ret)
> +		dev_dbg(match, "Failed to get generic port perf coordinates.\n");
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3d0c8c63f6d6..2369e91add63 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -636,6 +636,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>   * @rcrb: base address for the Root Complex Register Block
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @port: reference to cxl_port that contains this downstream port
> + * @genport_coord: access coordinates (performance) from ACPI generic port
>   * @coord: access coordinates (performance) for switch from CDAT
>   * @link_latency: calculated PCIe downstream latency
>   */
> @@ -646,6 +647,7 @@ struct cxl_dport {
>  	resource_size_t rcrb;
>  	bool rch;
>  	struct cxl_port *port;
> +	struct access_coordinate hb_access;
>  	struct access_coordinate coord;
>  	long link_latency;
>  };
> 
> 


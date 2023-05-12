Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D527C77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 15:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbjELPRM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbjELPRK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 11:17:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C89D87F
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 08:16:57 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHsNZ2F1Vz67dbJ;
        Fri, 12 May 2023 22:59:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 15:59:58 +0100
Date:   Fri, 12 May 2023 15:59:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 06/14] cxl: Store the access coordinates for the
 generic ports
Message-ID: <20230512155957.00000c2f@Huawei.com>
In-Reply-To: <168357884996.2756219.11067819935569345137.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357884996.2756219.11067819935569345137.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 08 May 2023 13:47:29 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Each CXL host bridge is represented by an ACPI0016 device. A generic port
> device handle that is an ACPI device is represented by a string of
> ACPI0016 device HID and UID. Create a device handle from the ACPI device
> and retrieve the access coordinates from the stored memory targets. The
> access coordinates are stored under the cxl_dport that is associated with
> the CXL host bridge.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/acpi.c |   28 ++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h  |    2 ++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index f9b35e8fe810..675a4f423f4b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -537,8 +537,26 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>  	return 0;
>  }
>  
> +static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
> +{
> +	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
> +	u8 handle[ACPI_SRAT_DEVICE_HANDLE_SIZE] = { 0 };
> +	int rc;
> +
> +	/* ACPI spec 6.5 tABLE 5.65 */

tABLE?

> +	memcpy(handle, acpi_device_hid(hb), 8);
> +	memcpy(&handle[8], acpi_device_uid(hb), 4);
> +
> +	rc = acpi_get_genport_coordinates(handle, dport->genport_coord);
> +	if (rc)
> +		return rc;
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
> @@ -594,6 +612,16 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	if (IS_ERR(dport))
>  		return PTR_ERR(dport);
>  
> +	dport->genport_coord = devm_kzalloc(dport->dport,
> +					    sizeof(*dport->genport_coord),
> +					    GFP_KERNEL);

It's pretty small - worth allocating separately?

Maybe add something on why to the patch description if there is another reason
for this dance.

> +	if (!dport->genport_coord)
> +		return -ENOMEM;
> +
> +	ret = get_genport_coordinates(match, dport);
> +	if (ret)
> +		dev_dbg(match, "Failed to get generic port perf coordinates.\n");
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c1e2c3703a63..033b822a20f2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -626,6 +626,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>   * @rcrb: base address for the Root Complex Register Block
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @port: reference to cxl_port that contains this downstream port
> + * @genport_coord: access coordinates (performance) from ACPI generic port
>   * @coord: access coordinates (performance) for switch from CDAT
>   * @link_latency: calculated PCIe downstream latency
>   */
> @@ -636,6 +637,7 @@ struct cxl_dport {
>  	resource_size_t rcrb;
>  	bool rch;
>  	struct cxl_port *port;
> +	struct access_coordinate *genport_coord;
>  	struct access_coordinate coord;
>  	long link_latency;
>  };
> 
> 


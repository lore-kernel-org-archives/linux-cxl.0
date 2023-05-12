Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677D6C77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 15:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjELPJG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbjELPJG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 11:09:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921B05B83
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 08:09:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHsWM6j6yz6J7CK;
        Fri, 12 May 2023 23:05:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 16:09:02 +0100
Date:   Fri, 12 May 2023 16:09:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 08/14] cxl: Compute the entire CXL path latency and
 bandwidth data
Message-ID: <20230512160901.00001384@Huawei.com>
In-Reply-To: <168357886214.2756219.978696616095404572.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357886214.2756219.978696616095404572.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 08 May 2023 13:47:42 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL Memory Device SW Guide rev1.0 2.11.2 provides instruction on how to
> caluclate latency and bandwidth for CXL memory device. Calculate minimum
Spell check.

Also, a link for SW guide probably good to add.

> bandwidth and total latency for the path from the CXL device to the root
> port. The QTG id is retrieved by providing the performance data as input
> and calling the root port callback ->get_qos_class(). The retrieved id is
> stored with the cxl_port of the CXL device.
> 
> For example for a device that is directly attached to a host bus:
> Total Latency = Device Latency (from CDAT) + Dev to Host Bus (HB) Link
> 		Latency + Generic Port Latency
> Min Bandwidth = Min bandwidth for link bandwidth between HB
> 		and CXL device, device CDAT bandwidth, and Generic Port
> 		Bandwidth
> 
> For a device that has a switch in between host bus and CXL device:
> Total Latency = Device (CDAT) Latency + Dev to Switch Link Latency +
> 		Switch (CDAT) Latency + Switch to HB Link Latency +
> 		Generic Port Latency
> Min Bandwidth = Min bandwidth for link bandwidth between CXL device
> 		to CXL switch, CXL device CDAT bandwidth, CXL switch CDAT
> 		bandwidth, CXL switch to HB bandwidth, and Generic Port
> 		Bandwidth.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> v5:
> - Use new API call cxl_endpoint_get_perf_coordinates().
> - Use root_port->get_qos_class() (Dan)
> - Add endieness handling to DSM input.
> ---
>  drivers/cxl/cxl.h  |    1 +
>  drivers/cxl/port.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0c8952e568cc..7c94f07771c1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -833,6 +833,7 @@ struct dsmas_entry {
>  	struct range dpa_range;
>  	u8 handle;
>  	struct access_coordinate coord;
> +	int qos_class;
>  };
>  
>  #ifdef CONFIG_ACPI
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index c5a24b75bf03..b474997cc7ee 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -67,6 +67,52 @@ static void dsmas_list_destroy(struct list_head *dsmas_list)
>  	}
>  }
>  
> +static int cxl_port_perf_data_calculate(struct cxl_port *port,
> +					struct list_head *dsmas_list)
> +{
> +	struct access_coordinate c;
> +	struct qtg_dsm_input input;
> +	struct cxl_port *root_port;
> +	struct cxl_root *cxl_root;
> +	struct dsmas_entry *dent;
> +	int rc, qos_class;
> +
> +	rc = cxl_endpoint_get_perf_coordinates(port, &c);
> +	if (rc) {
> +		dev_dbg(&port->dev, "Failed to retrieve perf coordinates.\n");
> +		return rc;
> +	}
> +
> +	root_port = find_cxl_root(port);
> +	cxl_root = to_cxl_root(root_port);
> +	if (!cxl_root->ops && !cxl_root->ops->get_qos_class)
> +		return -EOPNOTSUPP;
> +
> +	list_for_each_entry(dent, dsmas_list, list) {
> +		dent->coord.read_latency = dent->coord.read_latency +
> +					   c.read_latency;
> +		dent->coord.write_latency = dent->coord.write_latency +
> +					    c.write_latency;
> +		dent->coord.read_bandwidth = min_t(int, c.read_bandwidth,
> +						   dent->coord.read_bandwidth);
> +		dent->coord.write_bandwidth = min_t(int, c.write_bandwidth,
> +						    dent->coord.write_bandwidth);
> +
> +		input.rd_lat = cpu_to_le32(dent->coord.read_latency);
> +		input.wr_lat = cpu_to_le32(dent->coord.write_latency);
> +		input.rd_bw = cpu_to_le32(dent->coord.read_bandwidth);
> +		input.wr_bw = cpu_to_le32(dent->coord.write_bandwidth);
> +
> +		qos_class = cxl_root->ops->get_qos_class(root_port, &input);
> +		if (qos_class < 0)
> +			continue;
> +
> +		dent->qos_class = qos_class;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -155,10 +201,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  		LIST_HEAD(dsmas_list);
>  
>  		rc = cxl_cdat_endpoint_process(port, &dsmas_list);
> -		if (rc < 0)
> +		if (rc < 0) {
>  			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
> -
> -		/* Performance data processing */
> +		} else {
> +			rc = cxl_port_perf_data_calculate(port, &dsmas_list);
> +			if (rc)
> +				dev_dbg(&port->dev,
> +					"Failed to do perf coord calculations.\n");
> +		}
>  
>  		dsmas_list_destroy(&dsmas_list);
>  	}
> 
> 


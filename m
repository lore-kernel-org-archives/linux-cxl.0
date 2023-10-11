Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02661F182
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0533290
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 06:19:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5Cx95fCNz6K6HR;
	Wed, 11 Oct 2023 21:17:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 14:19:34 +0100
Date: Wed, 11 Oct 2023 14:19:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v10 20/22] cxl: Store QTG IDs and related info to the
 CXL memory device context
Message-ID: <20231011141933.000028fb@Huawei.com>
In-Reply-To: <169698641993.1991735.8821776839011657844.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
	<169698641993.1991735.8821776839011657844.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 10 Oct 2023 18:06:59 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
> the return package. Create a list of entries in the cxl_memdev context and
> store the QTG ID as qos_class token and the associated DPA range. This
> information can be exposed to user space via sysfs in order to help region
> setup for hot-plugged CXL memory devices.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v10:
> - Store single qos_class value. (Dan)

I'm fine with doing this, but I'd like a print if more than one is
provided by the DSMAS (e.g. multiple DSMAS entries for a given region)
Mostly so we have something to let us know if anyone is shipping such a
device.

Otherwise a couple of minor comments inline.

Jonathan


> - Rename cxl_memdev_set_qtg() to cxl_memdev_set_qos_class()
> - Removed Jonathan's review tag due to code changes.

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 99a619360bc5..049a16b7eb1f 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -105,6 +105,40 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  	return 0;
>  }
>  
> +static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> +				     struct list_head *dsmas_list)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct range pmem_range = {
> +		.start = cxlds->pmem_res.start,
> +		.end = cxlds->pmem_res.end,
> +	};
> +	struct range ram_range = {
> +		.start = cxlds->ram_res.start,
> +		.end = cxlds->ram_res.end,
> +	};
> +	struct perf_prop_entry *perf;
> +	struct dsmas_entry *dent;
> +
> +	list_for_each_entry(dent, dsmas_list, list) {
> +		perf = devm_kzalloc(cxlds->dev, sizeof(*perf), GFP_KERNEL);
> +		if (!perf)
> +			return;
> +
> +		perf->dpa_range = dent->dpa_range;
> +		perf->coord = dent->coord;
> +		perf->qos_class = dent->qos_class;
> +		list_add_tail(&perf->list, &mds->perf_list);
> +
> +		if (resource_size(&cxlds->ram_res) &&
> +		    range_contains(&ram_range, &dent->dpa_range))
> +			mds->ram_qos_class = perf->qos_class;

So this assumes one DSMAS per memory type.
Not an unreasonable starting place, but I think this should 
print something to the log if it does see more that one.

> +		else if (resource_size(&cxlds->pmem_res) &&
> +			 range_contains(&pmem_range, &dent->dpa_range))
> +			mds->pmem_qos_class = perf->qos_class;
> +	}
> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -201,6 +235,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  			if (rc)
>  				dev_dbg(&port->dev,
>  					"Failed to do perf coord calculations.\n");
> +			else
> +				cxl_memdev_set_qos_class(cxlds, &dsmas_list);

This is getting a bit deeply nested.  Perhaps a follow up patch to factor
it out makes sense so we can use a goto to cleanup the dmsmas_list without
that label being nested as well.

>  		}
>  
>  		cxl_cdat_dsmas_list_destroy(&dsmas_list);
> 
> 


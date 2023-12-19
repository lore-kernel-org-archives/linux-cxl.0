Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24D1C68A
	for <linux-cxl@vger.kernel.org>; Tue, 19 Dec 2023 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Svflb5kNKz6K6Wl;
	Tue, 19 Dec 2023 22:51:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 896D7140F76;
	Tue, 19 Dec 2023 22:51:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 14:51:36 +0000
Date: Tue, 19 Dec 2023 14:51:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <brice.goglin@gmail.com>,
	<nifan.cxl@gmail.com>
Subject: Re: [PATCH v2 1/3] cxl/region: Calculate performance data for a
 region
Message-ID: <20231219145135.000021f6@Huawei.com>
In-Reply-To: <170268215975.1381493.16321994239389305102.stgit@djiang5-mobl3>
References: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
	<170268215975.1381493.16321994239389305102.stgit@djiang5-mobl3>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 15 Dec 2023 16:15:59 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Calculate and store the performance data for a CXL region. Find the worst
> read and write latency for all the included ranges from each of the devices
> that attributes to the region and designate that as the latency data. Sum
> all the read and write bandwidth data for each of the device region and
> that is the total bandwidth for the region.
> 
> The perf list is expected to be constructed before the endpoint decoders
> are registered and thus there should be no early reading of the entries
> from the region assemble action. The calling of the region qos calculate
> function is under the protection of cxl_dpa_rwsem and will ensure that
> all DPA associated work has completed.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Trivial comments inline.  With the HMAT reference tweaked,
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
> - Move cxled declaration (Fan)
> - Move calculate function to core/cdat.c
> - Make cxlr->coord a struct instead of allocated (Dan)
> - Remove list_empty() check (Dan)
> - Move calculation to cxl_region_attach() under cxl_dpa_rwsem (Dan)
> - Normalize perf numbers to HMAT coords (Brice, Dan)
> ---
>  drivers/cxl/core/cdat.c   |   53 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c |    2 ++
>  drivers/cxl/cxl.h         |    5 ++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5fe57fe5e2ee..29bba04306e9 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -547,3 +547,56 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
>  EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
>  
>  MODULE_IMPORT_NS(CXL);
> +
> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> +				    struct cxl_endpoint_decoder *cxled)
> +{
> +	struct list_head *perf_list;
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct range dpa = {
> +			.start = cxled->dpa_res->start,
> +			.end = cxled->dpa_res->end,
> +	};
> +	struct cxl_dpa_perf *perf;
> +	bool found = false;
> +
> +	switch (cxlr->mode) {
> +	case CXL_DECODER_RAM:
> +		perf_list = &mds->ram_perf_list;
> +		break;
> +	case CXL_DECODER_PMEM:
> +		perf_list = &mds->pmem_perf_list;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	list_for_each_entry(perf, perf_list, list) {
> +		if (range_contains(&perf->dpa_range, &dpa)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return;

Could use
	if (list_entry_is_head())
		return;
and drop the found variable. Though that is a little bit specific to the
internals of the list infrastructure so maybe adding a variable is better..
There is precedence for both approaches in tree.

> +
> +	/* Get total bandwidth and the worst latency for the cxl region */
> +	cxlr->coord.read_latency = max_t(unsigned int,
> +					 cxlr->coord.read_latency,
> +					 perf->coord.read_latency);
> +	cxlr->coord.write_latency = max_t(unsigned int,
> +					  cxlr->coord.write_latency,
> +					  perf->coord.write_latency);
> +	cxlr->coord.read_bandwidth += perf->coord.read_bandwidth;
> +	cxlr->coord.write_bandwidth += perf->coord.write_bandwidth;
> +
> +	/*
> +	 * Convert latency to nanosec from picosec to be consistent with HMAT

HMAT version what?  You may ask why is there a breaking change in the HMAT definition
between 6.2 and 6.3 but I'd rather you didn't :(


> +	 * attributes.
> +	 */
> +	cxlr->coord.read_latency = DIV_ROUND_UP(cxlr->coord.read_latency, 1000);
> +	cxlr->coord.write_latency = DIV_ROUND_UP(cxlr->coord.write_latency, 1000);
> +}


Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJDEXWKF"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D64C9B
	for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 09:44:43 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d053c45897so41628245ad.2
        for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 09:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702316682; x=1702921482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBHV5MPd1HV5/Jh+yFKFz4zXnjSY7uhQ7N9VQXbfgX8=;
        b=jJDEXWKFiJg1rIkY+gemSQVm1BsHMlSX81Ul3u0TC44JXIxYzGovRTZammLb3ZHehw
         5IDHirWqFHE9tCg8p+9W8Lj5bjRUXFaFRX4QvMKyNwWp+A1CwVrXt54EvVxG1Ii6Od57
         uw2gNf94xi4tfAPYpQpLt/CxCtkEB7o1MSl8RUW/EAzizL6QSFfuMu7xlvtGP/pv9x0Y
         gG9c1A4H3ur7dI4XEZrMT5i/bz077+kmT6c86iIIjulPdmKtXWVHK/F3iHnfYvgPQUmq
         r36e1tahK5aLX8aqeAjpAwxeLJbAlLa4Ny0PO7SifdMAwk9Un6OFEJHeEOARFYkp8j3U
         JFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316682; x=1702921482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBHV5MPd1HV5/Jh+yFKFz4zXnjSY7uhQ7N9VQXbfgX8=;
        b=WJO+dOr74e5wzMIwSGDDxVBqOVfMg9zldbIc1HmRCwKWnLVq3FipW0N5kzLH8409Jx
         wkgeAb/ehVw4k1Mr/tbdGFLbWYADMplI7aA1wwEzx3weE11jmd8VdxxLfckVmwE1kHfS
         dneLykS5IkAdSA3vlmqHAQN12dNqdTJqBGVLNGVtSal7yhv1+JLsr0KfMBtwowv3so2I
         Vl3pA3kSLh/g4B0XhyJBytNRfryn/MUI6L+obvSgRMOLagJUAkbWG0pQNAmFgKyrO+nO
         yH7UC/lUscxbSlZCSVFRPRuDFztVWay0Tz/ad7KLfGMHzPE3ZPv7h5t2P9C2CrZcWBp7
         8Jmg==
X-Gm-Message-State: AOJu0YzGWlw1SL4J6W2KdeBCydY0B4rtxAc/68awmZqCbErPOnpf7p4f
	ALoKf3tgTlAgcA+UoaqGn4MQ0P4/ZaI=
X-Google-Smtp-Source: AGHT+IFOkZay4YNYzzbba/3jEyfBKSwc4lCxs6kpewx+LrGYbi/gUCx6Cpi6K67Bbpu2pccB8sHi3Q==
X-Received: by 2002:a17:903:187:b0:1d2:fa04:7cb7 with SMTP id z7-20020a170903018700b001d2fa047cb7mr5977447plg.5.1702316682388;
        Mon, 11 Dec 2023 09:44:42 -0800 (PST)
Received: from debian (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id a22-20020a170902b59600b001d0cd351baesm6743722pls.13.2023.12.11.09.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:44:41 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 11 Dec 2023 09:44:24 -0800
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, jonathan.cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH 1/3] cxl/region: Calculate performance data for a region
Message-ID: <ZXdKeOLQ8s0B08Eq@debian>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199190986.3543815.7111880145751330916.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170199190986.3543815.7111880145751330916.stgit@djiang5-mobl3>

On Thu, Dec 07, 2023 at 04:31:49PM -0700, Dave Jiang wrote:
> Calculate and store the performance data for a CXL region. Find the worst
> read and write latency for all the included ranges from each of the devices
> that attributes to the region and designate that as the latency data. Sum
> all the read and write bandwidth data for each of the device region and
> that is the total bandwidth for the region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c |   94 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |    1 
>  2 files changed, 95 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 56e575c79bb4..d879f5702cf2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2934,6 +2934,98 @@ static int is_system_ram(struct resource *res, void *arg)
>  	return 1;
>  }
>  
> +static int cxl_region_perf_data_calculate(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled;
> +	unsigned int rd_bw = 0, rd_lat = 0;
> +	unsigned int wr_bw = 0, wr_lat = 0;
> +	struct access_coordinate *coord;
> +	struct list_head *perf_list;
> +	int rc = 0, i;
> +
> +	lockdep_assert_held(&cxl_region_rwsem);
> +
> +	/* No need to proceed if hmem attributes are already present */
> +	if (cxlr->coord)
> +		return 0;
> +
> +	coord = devm_kzalloc(&cxlr->dev, sizeof(*coord), GFP_KERNEL);
> +	if (!coord)
> +		return -ENOMEM;
> +
> +	cxled = p->targets[0];

cxled is only used in the for loop below, maybe we can move it into the loop.

Fan

> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct range dpa = {
> +			.start = cxled->dpa_res->start,
> +			.end = cxled->dpa_res->end,
> +		};
> +		struct cxl_memdev_state *mds;
> +		struct perf_prop_entry *perf;
> +		struct cxl_dev_state *cxlds;
> +		struct cxl_memdev *cxlmd;
> +		bool found = false;
> +
> +		cxled = p->targets[i];
> +		cxlmd = cxled_to_memdev(cxled);
> +		cxlds = cxlmd->cxlds;
> +		mds = to_cxl_memdev_state(cxlds);
> +
> +		switch (cxlr->mode) {
> +		case CXL_DECODER_RAM:
> +			perf_list = &mds->ram_perf_list;
> +			break;
> +		case CXL_DECODER_PMEM:
> +			perf_list = &mds->pmem_perf_list;
> +			break;
> +		default:
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +
> +		if (list_empty(perf_list)) {
> +			rc = -ENOENT;
> +			goto err;
> +		}
> +
> +		list_for_each_entry(perf, perf_list, list) {
> +			if (range_contains(&perf->dpa_range, &dpa)) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
> +			rc = -ENOENT;
> +			goto err;
> +		}
> +
> +		/* Get total bandwidth and the worst latency for the cxl region */
> +		rd_lat = max_t(unsigned int, rd_lat,
> +			       perf->coord.read_latency);
> +		rd_bw += perf->coord.read_bandwidth;
> +		wr_lat = max_t(unsigned int, wr_lat,
> +			       perf->coord.write_latency);
> +		wr_bw += perf->coord.write_bandwidth;
> +	}
> +
> +	*coord = (struct access_coordinate) {
> +		.read_latency = rd_lat,
> +		.read_bandwidth = rd_bw,
> +		.write_latency = wr_lat,
> +		.write_bandwidth = wr_bw,
> +	};
> +
> +	cxlr->coord = coord;
> +
> +	return 0;
> +
> +err:
> +	devm_kfree(&cxlr->dev, coord);
> +	return rc;
> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -2959,6 +3051,8 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> +	cxl_region_perf_data_calculate(cxlr);
> +
>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 004534cf0361..265da412c5bd 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -529,6 +529,7 @@ struct cxl_region {
>  	struct cxl_pmem_region *cxlr_pmem;
>  	unsigned long flags;
>  	struct cxl_region_params params;
> +	struct access_coordinate *coord;
>  };
>  
>  struct cxl_nvdimm_bridge {
> 
> 

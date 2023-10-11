Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2381F920
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A990293
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 06:29:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5D8Y0G9lz6K5hF;
	Wed, 11 Oct 2023 21:27:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 14:29:25 +0100
Date: Wed, 11 Oct 2023 14:29:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v10 22/22] cxl: Check qos_class validity on memdev probe
Message-ID: <20231011142924.00006060@Huawei.com>
In-Reply-To: <169698643180.1991735.11469426905286068135.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
	<169698643180.1991735.11469426905286068135.stgit@djiang5-mobl3>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 10 Oct 2023 18:07:11 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a check to make sure the qos_class for the device will match one of
> the root decoders qos_class. If no match is found, then the qos_class for
> the device is set to invalid.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/mem.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 317c7548e4e9..3495119d2edf 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -104,6 +104,70 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_debugfs_poison_clear, "%llx\n");
>  
> +struct qos_class_ctx {
> +	bool matched;
> +	int dev_qos_class;
> +};
> +
> +static int match_cxlrd_qos_class(struct device *dev, void *data)
> +{
> +	struct qos_class_ctx *ctx = data;
> +	struct cxl_root_decoder *cxlrd;
> +
> +	if (ctx->matched)
> +		return 0;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	if (cxlrd->qos_class == CXL_QOS_CLASS_INVALID ||
> +	    ctx->dev_qos_class == CXL_QOS_CLASS_INVALID)
> +		return 0;
> +
> +	if (cxlrd->qos_class == ctx->dev_qos_class)
> +		ctx->matched = 1;
If matched, why not terminate the bus_for_each_dev()
That is return 1 and amend check to be if (rc < 0)
Not that this ever returns < 0 anyway.  It might in
future though so that test makes sense as defensive measure.


> +
> +	return 0;
> +}
> +
> +static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct qos_class_ctx ctx;
> +	int rc;
> +
> +	if (mds->ram_qos_class != CXL_QOS_CLASS_INVALID) {
> +		ctx.matched = false;
> +		ctx.dev_qos_class =  mds->ram_qos_class;
> +		rc = bus_for_each_dev(dev->bus, NULL, &ctx, match_cxlrd_qos_class);
> +		if (rc)
> +			return rc;
> +
> +		if (ctx.matched)
> +			return 0;
Early return doesn't make sense to me given not checked the pmem one yet.
> +
> +		mds->ram_qos_class = CXL_QOS_CLASS_INVALID;
> +	}
> +
> +	if (mds->pmem_qos_class != CXL_QOS_CLASS_INVALID) {
> +		ctx.matched = false;
> +		ctx.dev_qos_class = mds->pmem_qos_class;
> +		rc = bus_for_each_dev(dev->bus, NULL, &ctx, match_cxlrd_qos_class);
> +		if (rc)
> +			return rc;
> +
> +		if (ctx.matched)
> +			return 0;
> +
> +		mds->ram_qos_class = CXL_QOS_CLASS_INVALID;

pmem_qos_class?

> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -181,6 +245,10 @@ static int cxl_mem_probe(struct device *dev)
>  			return rc;
>  	}
>  
> +	rc = cxl_qos_class_verify(cxlmd);
> +	if (rc)
> +		return rc;
> +
>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
>  	 * there is no spec defined way to determine whether this device
> 
> 


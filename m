Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31FEF4E5
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09424E3
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 04:04:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8Dhd0y9vz6K6F0;
	Mon, 16 Oct 2023 19:02:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 16 Oct
 2023 12:04:25 +0100
Date: Mon, 16 Oct 2023 12:04:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v11 22/22] cxl: Check qos_class validity on memdev probe
Message-ID: <20231016120425.0000542a@Huawei.com>
In-Reply-To: <169713694184.2205276.9863653630713216825.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
	<169713694184.2205276.9863653630713216825.stgit@djiang5-mobl3>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 12 Oct 2023 11:55:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a check to make sure the qos_class for the device will match one of
> the root decoders qos_class. If no match is found, then the qos_class for
> the device is set to invalid. Also add a check to ensure that the device's
> host bridge matches to one of the root decoder's downstream targets.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

So, if I read this right, QTG is required for probe to succeed.
Perhaps that's a little too heavy handed on something we haven't supported at
all until now?

Otherwise LGTM

> 
> ---
> v11:
> - Return when matched in match function (Jonathan)
> - Don't return after matched in caller function, still need to check pmem. (Jonathan)
> - Fix copy/paste error for pmem_qos_class. (Jonathan)
> - Use device_for_each_child() instead of bus_for_each_dev(). (Dan)
> - Add match of host_bridge to a root decoder target. (Dan)
> ---
>  drivers/cxl/mem.c |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 317c7548e4e9..74f72e37ccfc 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -104,6 +104,123 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
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
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	if (cxlrd->qos_class == CXL_QOS_CLASS_INVALID ||
> +	    ctx->dev_qos_class == CXL_QOS_CLASS_INVALID)
> +		return 0;
> +
> +	if (cxlrd->qos_class == ctx->dev_qos_class) {
> +		ctx->matched = 1;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +struct qos_hb_ctx {
> +	bool matched;
> +	struct device *host_bridge;
> +};
> +
> +static int match_cxlrd_hb(struct device *dev, void *data)
> +{
> +	struct cxl_switch_decoder *cxlsd;
> +	struct qos_hb_ctx *ctx = data;
> +	struct cxl_root_decoder *cxlrd;
> +	unsigned int seq;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +
> +	do {
> +		seq = read_seqbegin(&cxlsd->target_lock);
> +		for (int i = 0; i < cxlsd->nr_targets; i++) {
> +			if (ctx->host_bridge ==
> +			    cxlsd->target[i]->dport_dev) {
> +				ctx->matched = true;
> +				return 1;
> +			}
> +		}
> +	} while (read_seqretry(&cxlsd->target_lock, seq));
> +
> +	return 0;
> +}
> +
> +static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct qos_class_ctx ctx;
> +	struct qos_hb_ctx hbctx;
> +	struct cxl_port *root_port;
> +	int rc;
> +
> +	root_port = find_cxl_root(cxlmd->endpoint);
> +	if (!root_port)
> +		return -ENODEV;
> +
> +	/* Check that the QTG IDs are all sane between end device and root decoders */
> +	if (mds->ram_qos_class != CXL_QOS_CLASS_INVALID) {
> +		ctx = (struct qos_class_ctx) {
> +			.matched = false,
> +			.dev_qos_class =  mds->ram_qos_class,
> +		};
> +		rc = device_for_each_child(&root_port->dev, &ctx, match_cxlrd_qos_class);
> +		if (rc < 0)
> +			goto out;
> +
> +		if (!ctx.matched)
> +			mds->ram_qos_class = CXL_QOS_CLASS_INVALID;
> +	}
> +
> +	if (mds->pmem_qos_class != CXL_QOS_CLASS_INVALID) {
> +		ctx = (struct qos_class_ctx) {
> +			.matched = false,
> +			.dev_qos_class =  mds->pmem_qos_class,
> +		};
> +		rc = device_for_each_child(&root_port->dev, &ctx, match_cxlrd_qos_class);
> +		if (rc < 0)
> +			goto out;
> +
> +		if (!ctx.matched)
> +			mds->pmem_qos_class = CXL_QOS_CLASS_INVALID;
> +	}
> +
> +	/* Check to make sure that the device's host bridge is under a root decoder */
> +	hbctx = (struct qos_hb_ctx) {
> +		.matched = false,
> +		.host_bridge = cxlmd->endpoint->host_bridge,
> +	};
> +	rc = device_for_each_child(&root_port->dev, &hbctx, match_cxlrd_hb);
> +	if (rc < 0)
> +		goto out;
> +
> +	if (!hbctx.matched) {
> +		mds->ram_qos_class = CXL_QOS_CLASS_INVALID;
> +		mds->pmem_qos_class = CXL_QOS_CLASS_INVALID;
> +	}
> +
> +out:
> +	put_device(&root_port->dev);
> +	return rc;
> +}
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -173,6 +290,10 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_qos_class_verify(cxlmd);
> +	if (rc < 0)
> +		return rc;
> +
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>  		rc = devm_cxl_add_nvdimm(cxlmd);
>  		if (rc == -ENODEV)
> 
> 
> 


Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F023D0CE
	for <linux-cxl@vger.kernel.org>; Tue, 19 Dec 2023 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SvjBj4Dfmz6JBFC;
	Wed, 20 Dec 2023 00:41:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 860851402C7;
	Wed, 20 Dec 2023 00:42:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 16:42:22 +0000
Date: Tue, 19 Dec 2023 16:42:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v14 19/19] cxl: Check qos_class validity on memdev probe
Message-ID: <20231219164221.000011c8@Huawei.com>
In-Reply-To: <170248579618.801570.17463788516390290503.stgit@djiang5-mobl3>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
	<170248579618.801570.17463788516390290503.stgit@djiang5-mobl3>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 13 Dec 2023 09:43:16 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a check to make sure the qos_class for the device will match one of
> the root decoders qos_class. If no match is found, then the qos_class for
> the device is set to invalid. Also add a check to ensure that the device's
> host bridge matches to one of the root decoder's downstream targets.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few comments on places I think this can be simplified.

Jonathan

> ---
> v14:
> - Move unmatched entries to discard list (Dan)
> - Update perf_prop_entry to cxl_dpa_perf (Dan)
> - Use DEFINE_FREE() in cxl_qos_class_verify to clean up code (Dan)
> - Move qos verify to core/cdat.c in order to be called before region setup
>   (Dan)
> ---
>  drivers/cxl/core/cdat.c |  137 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8c561f1deec6..5fe57fe5e2ee 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -270,6 +270,142 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  	devm_add_action_or_reset(&cxlds->cxlmd->dev, free_perf_ents, mds);
>  }
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
Why check this one in here?  Caller should take that out first.

> +		return 0;
> +
> +	if (cxlrd->qos_class == ctx->dev_qos_class) {
> +		ctx->matched = 1;
> +		return 1;

As noted below, this is the return value for the device_for_each_child()
so can use that instead of needing ctx->matched.

> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_qos_match(struct cxl_port *root_port,
> +			 struct list_head *work_list,
> +			 struct list_head *discard_list)
> +{
> +	struct cxl_dpa_perf *dpa_perf, *n;
> +	struct qos_class_ctx ctx;
> +	int rc;
> +
> +	if (list_empty(work_list))
> +		return 0;
> +
> +	list_for_each_entry_safe(dpa_perf, n, work_list, list) {
> +		ctx = (struct qos_class_ctx) {
> +			.matched = false,
> +			.dev_qos_class = dpa_perf->qos_class,
> +		};

		as above the dev_qos_class doesn't change so can we not
		reject it early here? 
		if (!dpa_perf->qos_class)
			continue; /* I think? */

> +		rc = device_for_each_child(&root_port->dev, &ctx, match_cxlrd_qos_class);
> +		if (rc < 0)
> +			return -ENOENT;

Can only return 0 or 1  and 1 is returned only on a match, so can use that
in place of ctx.matched if you like.

> +
> +		if (!ctx.matched)
> +			list_move_tail(&dpa_perf->list, discard_list);
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
> +static void discard_dpa_perf(struct list_head *list)
> +{
> +	struct cxl_dpa_perf *dpa_perf, *n;
> +
> +	list_for_each_entry_safe(dpa_perf, n, list, list) {
> +		list_del(&dpa_perf->list);
> +		kfree(dpa_perf);
> +	}
> +}
> +DEFINE_FREE(dpa_perf, struct list_head *, if (_T) discard_dpa_perf(_T))

Can if (_T) ever fail?
The list can be empty but I think the pointer is always valid.

> +
> +static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_port *root_port __free(put_device) = NULL;
> +	LIST_HEAD(__discard);
> +	struct list_head *discard __free(dpa_perf) = &__discard;
> +	struct qos_hb_ctx hbctx;
> +	int rc;
> +
> +	root_port = find_cxl_root(cxlmd->endpoint);
> +	if (!root_port)
> +		return -ENODEV;
> +
> +	/* Check that the QTG IDs are all sane between end device and root decoders */
> +	rc = cxl_qos_match(root_port, &mds->ram_perf_list, discard);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Check to make sure that the device's host bridge is under a root decoder */
> +	hbctx = (struct qos_hb_ctx) {
> +		.matched = false,
> +		.host_bridge = cxlmd->endpoint->host_bridge,
> +	};
> +	rc = device_for_each_child(&root_port->dev, &hbctx, match_cxlrd_hb);
> +	if (rc < 0)
> +		return rc;
As above failre sure this can't return an error, and I think you can use the return
value == 1 in place of the matched variable allowing simpler context.
> +
> +	if (!hbctx.matched) {
> +		list_splice_tail_init(&mds->ram_perf_list, discard);
> +		list_splice_tail_init(&mds->pmem_perf_list, discard);
> +	}
> +
> +	return rc;
> +}
> +



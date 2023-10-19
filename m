Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110642FE1B
	for <linux-cxl@vger.kernel.org>; Thu, 19 Oct 2023 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68536B0
	for <linux-cxl@vger.kernel.org>; Thu, 19 Oct 2023 07:34:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB9Bj15xkz687Wk;
	Thu, 19 Oct 2023 22:31:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 19 Oct
 2023 15:34:49 +0100
Date: Thu, 19 Oct 2023 15:34:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH v3 1/2] cxl: Add cxl_decoders_committed() helper
Message-ID: <20231019153449.0000290d@Huawei.com>
In-Reply-To: <169747906849.272156.1729290904857372335.stgit@djiang5-mobl3>
References: <169747906849.272156.1729290904857372335.stgit@djiang5-mobl3>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Mon, 16 Oct 2023 10:57:48 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a helper to retrieve the number of decoders committed for the port.
> Replace all the open coding of the calculation with the helper.
> 
> Link: https://lore.kernel.org/linux-cxl/651c98472dfed_ae7e729495@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> v3:
> - Rename cxl_decoders_committed() to cxl_num_decoders_comitted() (Jim)
> - Compare cxl_num_decoders_committed() to 0 to improve readability (Jim)
> v2:
> - Remove EXPORT_SYMBOL() (Dan)
> - Rebase on top of Dan's Fix shutdown order series, to pick up
>   cxl_region_rwsem export.
> ---
>  drivers/cxl/core/hdm.c    |    7 ++++---
>  drivers/cxl/core/mbox.c   |    2 +-
>  drivers/cxl/core/memdev.c |    4 ++--
>  drivers/cxl/core/port.c   |    7 +++++++
>  drivers/cxl/cxl.h         |    1 +
>  5 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 506c9e14cdf9..7d112557c939 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -643,10 +643,11 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		return 0;
>  
> -	if (port->commit_end + 1 != id) {
> +	if (cxl_num_decoders_committed(port) != id) {
>  		dev_dbg(&port->dev,
>  			"%s: out of order commit, expected decoder%d.%d\n",
> -			dev_name(&cxld->dev), port->id, port->commit_end + 1);
> +			dev_name(&cxld->dev), port->id,
> +			cxl_num_decoders_committed(port));
>  		return -EBUSY;
>  	}
>  
> @@ -863,7 +864,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		else
>  			cxld->target_type = CXL_DECODER_DEVMEM;
> -		if (cxld->id != port->commit_end + 1) {
> +		if (cxld->id != cxl_num_decoders_committed(port)) {
>  			dev_warn(&port->dev,
>  				 "decoder%d.%d: Committed out of order\n",
>  				 port->id, cxld->id);
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 67aec57cc12f..04033b06f75f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1200,7 +1200,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	 * Require an endpoint to be safe otherwise the driver can not
>  	 * be sure that the device is unmapped.
>  	 */
> -	if (endpoint && endpoint->commit_end == -1)
> +	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
>  		rc = __cxl_mem_sanitize(mds, cmd);
>  	else
>  		rc = -EBUSY;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index fed9573cf355..fc5c2b414793 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -231,7 +231,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  	if (rc)
>  		return rc;
>  
> -	if (port->commit_end == -1) {
> +	if (cxl_num_decoders_committed(port) == 0) {
>  		/* No regions mapped to this memdev */
>  		rc = cxl_get_poison_by_memdev(cxlmd);
>  	} else {
> @@ -282,7 +282,7 @@ static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
>  		.dpa = dpa,
>  	};
>  	port = cxlmd->endpoint;
> -	if (port && is_cxl_endpoint(port) && port->commit_end != -1)
> +	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
>  		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
>  
>  	return ctx.cxlr;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 5ba606c6e03f..d0ed98a6bade 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -37,6 +37,13 @@ DECLARE_RWSEM(cxl_region_rwsem);
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +int cxl_num_decoders_committed(struct cxl_port *port)
> +{
> +	lockdep_assert_held(&cxl_region_rwsem);
> +
> +	return port->commit_end + 1;
> +}
> +
>  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 76d92561af29..36bd3f06dd90 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -679,6 +679,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  	return port->uport_dev == port->dev.parent;
>  }
>  
> +int cxl_num_decoders_committed(struct cxl_port *port);
>  bool is_cxl_port(const struct device *dev);
>  struct cxl_port *to_cxl_port(const struct device *dev);
>  struct pci_bus;
> 
> 
> 


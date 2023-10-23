Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3622110D
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCOAZSxh"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5017E94
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698083367; x=1729619367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xav6qcS4ougcoVjHe9d4XNr/uMwsK8OyhoY+dkoPPCU=;
  b=jCOAZSxhWLk1e6uzM2whTzPdObfRMUUk73f5eb53MMy4JyJGlKg9M0b/
   vApkgaqjXbn0IuHhE2aZkFSfABI4MRzr9nmFU6N9kjUy5ZtVPRe5SpYKC
   2MbSznkJzMjPJfRAGiJ9g5qLSz+bwn2O6OXK60r3dDrSMSF8RcXAe/RKX
   KTdgLNXeYfxK5XslrYV/IpaPLNSa0lBtaw3TQci8vLeEkl+sjfK8gckha
   oKKLZ4zd+UYelFxYy79ADgJi0cMH/WQbs8lp25M7p9/nlOWj459oKSBP5
   63ieK/aesXTwLsd7sZ/c/Iqx1v/TsrPDJw6Abjo6LR9bCneJ+2vhzfLxd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="390778525"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="390778525"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 10:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="734746835"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="734746835"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.152.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 10:49:24 -0700
Date: Mon, 23 Oct 2023 10:49:17 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net,
	vishal.l.verma@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH v3 1/2] cxl: Add cxl_decoders_committed() helper
Message-ID: <ZTayHZgMI3nIOgcC@aschofie-mobl2>
References: <169747906849.272156.1729290904857372335.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169747906849.272156.1729290904857372335.stgit@djiang5-mobl3>

On Mon, Oct 16, 2023 at 10:57:48AM -0700, Dave Jiang wrote:
> Add a helper to retrieve the number of decoders committed for the port.
> Replace all the open coding of the calculation with the helper.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Link: https://lore.kernel.org/linux-cxl/651c98472dfed_ae7e729495@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
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

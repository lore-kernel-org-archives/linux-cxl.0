Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C32555E
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlaPlvQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704387940; x=1735923940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+l6Xz+ZO/N8DezYI2h1Pjl9yO6QASksvs9MSO+hJD1Y=;
  b=PlaPlvQ088PH/kI6T+WGHi+pG0Asusvas9hZV1C0gauBRXM4Xkww5yo6
   Lh1S1TCLxyEYrfwbjgCSO8ES6l9K7ZiVhRWU4MrMcKko2vAPCVK/xChIQ
   dU96XyaPlfj4GY2yP/rj+UP8X+MnCfDGMRSA7c/POBljIOhTceQnyIXrQ
   KYf1Qd8bGRzJMqCfiObCuoeiEGcAH/n48kCys8eOPngUJKE3qsfQcUBHu
   cOvHXOL7zIqspfM4nfgNg8IrcHMrLmSC5+UTDHeBCcqBgNpMaKr+WtTj2
   S3wLMf7ztL5Z07fkwsnSqq8lAwQ97233WiVWGd0pxVEis4hODxZ4BSB/j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="397025030"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="397025030"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:05:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1111821949"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="1111821949"
Received: from pnle-mobl1.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.206.13])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:05:38 -0800
Date: Thu, 4 Jan 2024 09:05:37 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Robert Richter <rrichter@amd.com>,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH] cxl: Clarify root_port cleanup routine for
 cxl_qos_class_verify()
Message-ID: <ZZblYSTDfT25N4Ma@aschofie-mobl2>
References: <170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3>

On Thu, Jan 04, 2024 at 09:08:05AM -0700, Dave Jiang wrote:
> The current __free() call for root_port in cxl_qos_class_verify() depends
> on 'struct device' to be the first member of 'struct cxl_port' and calls
> put_device() directly with the root_port pointer passed in. Add a helper
> function put_cxl_port() to handle the put_device() properly and avoid
> future issues if the 'struct device' member moves.
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
>  drivers/cxl/core/cdat.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index cd84d87f597a..d6e64570032f 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -345,11 +345,21 @@ static void discard_dpa_perf(struct list_head *list)
>  }
>  DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
>  
> +static void put_cxl_port(struct cxl_port *port)
> +{
> +	if (!port)
> +		return;
> +
> +	put_device(&port->dev);
> +}
> +
> +DEFINE_FREE(cxl_port, struct cxl_port *, put_cxl_port(_T))
> +
>  static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct cxl_port *root_port __free(put_device) = NULL;
> +	struct cxl_port *root_port __free(cxl_port) = NULL;
>  	LIST_HEAD(__discard);
>  	struct list_head *discard __free(dpa_perf) = &__discard;
>  	int rc;
> 
> 

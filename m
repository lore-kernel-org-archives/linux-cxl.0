Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9E21A0B
	for <linux-cxl@vger.kernel.org>; Thu,  2 Nov 2023 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQvTWAjb"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4C71A3
	for <linux-cxl@vger.kernel.org>; Thu,  2 Nov 2023 15:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698964963; x=1730500963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mH9UoLpd/YQT0aBuzvdMvE2IeduQBeIo7LgDSAtkEyQ=;
  b=fQvTWAjb4snjkQ+39xJpg9oYQ1zvSJ7d8aPu3l1lrshwSZrNYbwJxrMh
   sWbDxmJuNa+tyvwOKInM03RggvAXeXowN62I1WzPw5m//eETFdDOkf9VH
   tRcpaP5V8bfLmSMQHcoHHl2fGyxfMSZTA0QGXlzuI71BWZOxXQHxuadQA
   akbsStB+uIAOeHMERHRa6qk8PpLeKs7Rr6ZVM0RXQ6Xn5lvl/M6U46Ia+
   Wv9o9bAWJrEzD7dKGcfBrMEKk99Kk4j/iDIwiqzmgTo/7cviUhTuB1M4s
   DpsoII5xKFTTF7lZD7NpXnKRNVplYBGYsZGO0eVDf9UKmUo6cYfyhCz2p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="387724386"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="387724386"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:42:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878417793"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="878417793"
Received: from sanchitj-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.94.246])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:42:42 -0700
Date: Thu, 2 Nov 2023 15:42:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jim Harris <jim.harris@samsung.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Refactor logic around check_last_peer()
Message-ID: <ZUQl4Bd1a36SR48/@aschofie-mobl2>
References: <169696721124.1190606.18028412676865061799.stgit@bgt-140510-bm03.eng.stellus.in>
 <CGME20231101050219uscas1p25227a9255ab06201798ca35cae137194@uscas1p2.samsung.com>
 <169881493839.1770063.6493881963554580869.stgit@bgt-140510-bm03.eng.stellus.in>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169881493839.1770063.6493881963554580869.stgit@bgt-140510-bm03.eng.stellus.in>

On Wed, Nov 01, 2023 at 05:02:18AM +0000, Jim Harris wrote:
> 'distance' is equivalent to the product of the interleave_ways of the
> "ancestor" decoders of the port's decoder we are setting up in
> cxl_port_setup_targets().
> 
> So use the term "ancestral_ways" instead of "distance" to better
> clarify the meaning of this value. Also move all logic around this
> value directly into check_last_peer() so that all necessary calculations
> are in one place. It also allows eliminating a parameter to that
> function.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

A couple of housekeeping notes:
- Use get_maintainers script to find the To: List
- It's customary to send revised patches as a new thread, not as a
  reply to previous version.

Thanks,
Alison


> 
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---
>  drivers/cxl/core/region.c |   33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a1eac592c66a..2edfc02bb766 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1037,8 +1037,7 @@ static void cxl_port_detach_region(struct cxl_port *port,
>  }
>  
>  static int check_last_peer(struct cxl_endpoint_decoder *cxled,
> -			   struct cxl_ep *ep, struct cxl_region_ref *cxl_rr,
> -			   int distance)
> +			   struct cxl_ep *ep, struct cxl_region_ref *cxl_rr)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_region *cxlr = cxl_rr->region;
> @@ -1048,19 +1047,30 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_memdev *cxlmd_peer;
>  	struct cxl_ep *ep_peer;
>  	int pos = cxled->pos;
> +	int ancestral_ways;
> +
> +	if (cxl_rr->nr_targets == 1) {
> +		/*
> +		 * Passthrough decoders impose no positioning requirements
> +		 * between peers.
> +		 */
> +		return 0;
> +	}
> +
> +	ancestral_ways = p->nr_targets / cxl_rr->nr_targets;
>  
>  	/*
>  	 * If this position wants to share a dport with the last endpoint mapped
> -	 * then that endpoint, at index 'position - distance', must also be
> +	 * then that endpoint, at index 'position - ancestral_ways', must also be
>  	 * mapped by this dport.
>  	 */
> -	if (pos < distance) {
> +	if (pos < ancestral_ways) {
>  		dev_dbg(&cxlr->dev, "%s:%s: cannot host %s:%s at %d\n",
>  			dev_name(port->uport_dev), dev_name(&port->dev),
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
>  		return -ENXIO;
>  	}
> -	cxled_peer = p->targets[pos - distance];
> +	cxled_peer = p->targets[pos - ancestral_ways];
>  	cxlmd_peer = cxled_to_memdev(cxled_peer);
>  	ep_peer = cxl_ep_load(port, cxlmd_peer);
>  	if (ep->dport != ep_peer->dport) {
> @@ -1105,20 +1115,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
>  	if (cxl_rr->nr_targets_set) {
> -		int i, distance;
> +		int i;
>  
>  		/*
> -		 * Passthrough decoders impose no distance requirements between
> -		 * peers
> +		 * Check if this ep is already in the switch target list and
> +		 * if so ensure it meets relative positioning requirements.
>  		 */
> -		if (cxl_rr->nr_targets == 1)
> -			distance = 0;
> -		else
> -			distance = p->nr_targets / cxl_rr->nr_targets;
>  		for (i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
> -				rc = check_last_peer(cxled, ep, cxl_rr,
> -						     distance);
> +				rc = check_last_peer(cxled, ep, cxl_rr);
>  				if (rc)
>  					return rc;
>  				goto out_target_set;
> 

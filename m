Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9904C10E7
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909963; cv=none; b=pZjqv+CR6wbjJevtTZurtJF5FG52/rmiL17BNC6glPDMHHZCovb2O4shpHntniRmXC9lQXjNSULOLMQWhWUEw6XQIG7rdTWFMhWCtwEI2xzZK27N2KZ+SG3XLbwp2Wf/h0eh/4SdVDT8NDKEKqKw0kxG7FZ5fKlLAQgnudkGfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909963; c=relaxed/simple;
	bh=8ghLxZPhgwN4UssevPjS0lLbNr+qhzfFDDaTjQMXJlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlzENErqiJdi9mHXFmbTGpzLbTNIreYiyu8plYuAlWRP5J3Wanyl8k1uZGK4qHqN6m0GqY/cwQAD9fiOEBaTBZMOp8+pQj0J1FprWbNcfgtWMGUeY8wqSBXUDULHkZMUjWjWHoTcdJU2PQx0kMh7qqVVp5mSxtZjyfoJEwnbPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/8VItSZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/8VItSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791909961; x=1823445961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ghLxZPhgwN4UssevPjS0lLbNr+qhzfFDDaTjQMXJlY=;
  b=N/8VItSZvUuvX2xuzYMzSHbDOcX+T2pjkcesr3bgDewWel/f4u4j867P
   uE9jz8eMaIWJnB9mqWlV9OHk5dOq//hGV42w6yEEZrv/WI/K84I0sXtqI
   0f4wjBeaIZBU0af9M6xjgRcV4XR5o8DzSPDLsw+3XZa4AK1nThrAVwGxN
   n7oMYMGvTQkxvvnjcIUNEB+4cIjgOY15vcAF3PfZhdVdavSoLtWRYUNmC
   FxS7SqFe51PUqPSE0jIGwxVbZTQFT7wT5Hb3bX3jizoTAGRaVz2MytGaX
   /KfAak3ZpzMv06luuGJFSm3A7RU9yIA21rDtovxma+N6Pub3JZVgSsecr
   A==;
X-CSE-ConnectionGUID: Mz8aEFyCQbmr573wIAWyUQ==
X-CSE-MsgGUID: 7Aj/YHefRo6W5ZFeoQAdwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="543618"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="543618"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:46:01 -0700
X-CSE-ConnectionGUID: nyLHVwn4Q56/5VdSym3mmg==
X-CSE-MsgGUID: vEw1jBRnRAWJ7H3fVzRddw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1279065"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.235]) ([10.125.109.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:45:59 -0700
Message-ID: <9a583963-6274-4539-a546-e05e3965d3cf@intel.com>
Date: Tue, 13 Oct 2026 09:45:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] cxl/region: Rename cxl_port_setup_targets() to
 cxl_switch_port_setup_targets()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791676454.git.alison.schofield@intel.com>
 <6bef106f136e813b760fa7ab65d419fa4a1b6922.1791676454.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <6bef106f136e813b760fa7ab65d419fa4a1b6922.1791676454.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/26 5:20 PM, Alison Schofield wrote:
> cxl_port_setup_targets() configures the switch decoder targets for a
> region. It runs for each switch port, including host bridges, between the
> root and an endpoint.
> 
> Rename the function to cxl_switch_port_setup_targets() to make its scope
> explicit.
> 
> No functional change.
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1a42753fda48..d564443a1d39 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1432,9 +1432,9 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> -static int cxl_port_setup_targets(struct cxl_port *port,
> -				  struct cxl_region *cxlr,
> -				  struct cxl_endpoint_decoder *cxled)
> +static int cxl_switch_port_setup_targets(struct cxl_port *port,

Pass in cxlsd since it's a switch port function? That would enforce the type.

DJ

> +					 struct cxl_region *cxlr,
> +					 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
> @@ -1716,7 +1716,7 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
>  		 */
>  		for (ep = cxl_ep_load(iter, cxlmd); iter;
>  		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
> -			rc = cxl_port_setup_targets(iter, cxlr, cxled);
> +			rc = cxl_switch_port_setup_targets(iter, cxlr, cxled);
>  			if (rc) {
>  				cxl_region_teardown_targets(cxlr);
>  				return rc;


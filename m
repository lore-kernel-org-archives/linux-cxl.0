Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32848A8C6;
	Thu,  1 Oct 2026 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890701; cv=none; b=LgrDPIc+zRDuDsXo3YHIWdl6z5UkWORABWK3Ni63W3qhsjn5QGvwy4fGyfgLpX/tLrB2MxWrGGWLUBAOaeRBOFSqSECYbTLbCm/Vhay7rbGIEBK/ogZtmgq5cFHTN+0W/uJOCsZnaHJaAuVP0lBGlDpeREGRW9GczjhwA/Mkv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890701; c=relaxed/simple;
	bh=IxzlKcoKGQ4Xb2LDKANBq4GEy1hhinMRNIOBfmJSr1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwrSg4dRoBz8/hdr3pI08RrzUjMgNDylEylu+JLxBtTUXklrP0joRUca7n4ERkja97OSDpIYFrxBgTV0HwJbsFVknMUdGUHOY0QE9pgMcplS4Phdv8Jj1SfIVUBz+No+mr3vfL1DZ7xvlV0+PpOtwXsjAzLqvuNYk/xhYxZ79/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ftf0DABQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ftf0DABQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790890699; x=1822426699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IxzlKcoKGQ4Xb2LDKANBq4GEy1hhinMRNIOBfmJSr1k=;
  b=Ftf0DABQf2+k8qLa2rrIsX/e3Vf1hZ3M+ggzkR/yr2Z+T00TB2avUhdQ
   j/Ry+ygEQfXvjhMe9qO+ldlwKzyksbXd3Z4gMyQ9B6xAzrOrNyhbWd8Tf
   FJtkr2if8PpOxupoeieGVrWCYjrZnnnartT2ymJDdtDxjD6g6Ovmg5bWg
   2uHVKmzbk+LYWt7yGeW5KXC+Ep3Al3QHG2H+62Hr6bK2ulgWfpwZPYjE6
   CTSL2JAOmTU8Nseo2yBLMQl/uo3MlO47J/6ijRXTlNBV/Oyghvvd/j3r5
   ETTlZKBxkv28lHxTAab6GuPP6QSCUSzbC8L6qun9ZvdicCmiqDqfbdfqd
   g==;
X-CSE-ConnectionGUID: 1VMXLGcxQl6qyJGu06HUgg==
X-CSE-MsgGUID: u3MDnS4MTaeUDojWX/xxiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="101825227"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="101825227"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 14:38:18 -0700
X-CSE-ConnectionGUID: b2PT1CwEQWWIQnI5tKt5QQ==
X-CSE-MsgGUID: s/vFgvorQIi+tMJXn9iv3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275648264"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.241]) ([10.125.111.241])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 14:38:17 -0700
Message-ID: <6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com>
Date: Thu, 1 Oct 2026 14:38:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/region: Add region reference in memdev attach
To: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-3-alucerop@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001132023.17032-3-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 6:20 AM, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use a new field in cxl_attach_region struct for easily link it with the
> region the memdev is attached to.
> 
> This facilitates device links creation where such a region is the supplier
> with non-PF0 physical functions wanting to use the CXL region being the
> consumers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 1 +
>  drivers/cxl/cxlmem.h      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..78ca7ebc3e55 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4132,6 +4132,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>  	if (rc)
>  		return rc;
>  
> +	attach->cxlr = cxlr;
>  	attach->hpa_range = (struct range) {
>  		.start = cxlr->params.res->start,
>  		.end = cxlr->params.res->end,
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..c598561b8e5f 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -104,6 +104,7 @@ struct cxl_memdev_attach {
>  /**
>   * struct cxl_attach_region - coordinate mapping a region at memdev registration
>   * @attach: common core attachment descriptor
> + * @cxlr: cxl region the memdev is attached to.
>   * @hpa_range: physical address range of the region
>   *
>   * For the common simple case of a CXL device with private (non-general purpose
> @@ -112,6 +113,7 @@ struct cxl_memdev_attach {
>   */
>  struct cxl_attach_region {
>  	struct cxl_memdev_attach attach;
> +	struct cxl_region *cxlr;
>  	struct range hpa_range;
>  };
>  

attach->cxlr is never cleared when the region goes away. Unbinding the endpoint port runs endpoint_unregister_region(), which unregisters the region and drops its reference. PF0 stays bound until the detach work runs.

A non-PF0 probe in that window still finds the memdev and calls device_link_add() on the freed region.

How about something like this?

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..38ca73f12b84 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4076,6 +4076,23 @@ static int first_mapped_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
+/*
+ * Invalidate @attach before the region goes away so that
+ * cxl_get_range_and_link() can not pick up a stale region.
+ */
+static void endpoint_detach_attach_region(void *_attach)
+{
+	struct cxl_attach_region *attach = _attach;
+	struct cxl_region *cxlr;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.region) {
+		cxlr = attach->cxlr;
+		WRITE_ONCE(attach->cxlr, NULL);
+		attach->hpa_range = DEFINE_RANGE(0, -1);
+	}
+	endpoint_unregister_region(cxlr);
+}
+
 /*
  * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
  * simple case of single mapped decoder per memdev.
@@ -4127,15 +4144,23 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 
 	/* Only teardown regions that pass validation, ignore the rest */
 	get_device(&cxlr->dev);
-	rc = devm_add_action_or_reset(&endpoint->dev,
-				      endpoint_unregister_region, cxlr);
-	if (rc)
+	/*
+	 * Not devm_add_action_or_reset(): the reset path would take
+	 * cxl_rwsem.region for write while it is held for read here. The
+	 * endpoint lock keeps the action from running before @attach is set.
+	 */
+	rc = devm_add_action(&endpoint->dev, endpoint_detach_attach_region,
+			     attach);
+	if (rc) {
+		put_device(&cxlr->dev);
 		return rc;
+	}
 
 	attach->hpa_range = (struct range) {
 		.start = cxlr->params.res->start,
 		.end = cxlr->params.res->end,
 	};
+	WRITE_ONCE(attach->cxlr, cxlr);
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..7cd3a69cd5f5 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -104,6 +104,8 @@ struct cxl_memdev_attach {
 /**
  * struct cxl_attach_region - coordinate mapping a region at memdev registration
  * @attach: common core attachment descriptor
+ * @cxlr: cxl region the memdev is attached to, cleared under cxl_rwsem.region
+ *	before the region is unregistered
  * @hpa_range: physical address range of the region
  *
  * For the common simple case of a CXL device with private (non-general purpose
@@ -112,6 +114,7 @@ struct cxl_memdev_attach {
  */
 struct cxl_attach_region {
 	struct cxl_memdev_attach attach;
+	struct cxl_region *cxlr;
 	struct range hpa_range;
 };
 

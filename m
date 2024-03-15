Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76483E474
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517500; cv=none; b=fp5QS2gpJW9fe0nTMHhdLqBclxJah4rTJGS0htY+/iVVq0LKJDE6og5h1YJcsmgqG3kWZQsparCzLrG2H/2080jbBmshmruDznwPcPAhxRK9efsaRgP2TgtCbUB2T4jLwqqGjTWFmLOx9DbFzVGhJxwNE4rRFB0CT6yeCOyCsig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517500; c=relaxed/simple;
	bh=MJYL9oB34Zh/c8XhctDIX74QBfR/PepMrQuE9K1DaXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtQnOha6UhWEUXjGTNyXY5u7HW3rtHJYFzIPbligBZIsEkixhg/65UkJ2oF6JKPmIADaYhbklC4kKz9IqOROYxEJsw9Mr1NzyHvaeUvBUSM8U93ua85nlHmwBxUstBB/NJn09ue8Yg/Yamd8Q7+kf3EI2jhWh4D7Tx7QhFhiofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQvl33T0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQvl33T0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710517498; x=1742053498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MJYL9oB34Zh/c8XhctDIX74QBfR/PepMrQuE9K1DaXc=;
  b=HQvl33T0zATxVXGOtqgGukB+PPkIZWHff6x3VpT/eRAOnEgmS5Hl1rBL
   zftm/OdDmNhNSl9Wg82MlgeMCQfJqdPOFAFjI+JiR5avzm6qpUfzIELat
   UJ+kOQc33tmZEoRwKB1VEDYwfyVRVtBWX+llV6lpXovk3HK2GhrHbnH68
   G0t9NC5pn2Miym109xSEc6AEH+VadK8Vjs+dG/85tY/R5+N5bnxXI4AzN
   raWsaycdl2U9mfIz0wwhBQJxCCU3JIFySUrtYU+2EMonEHtrJs5Bm5l7M
   hLzbYX3cKBvhNRfBWQ8nGnXteWBZjJtUHkpw+TSI/Ip3urAwPMk0tMyFm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5525521"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5525521"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 08:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="13339077"
Received: from daericks-mobl2.amr.corp.intel.com (HELO [10.213.163.132]) ([10.213.163.132])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 08:44:57 -0700
Message-ID: <2dd47fb5-8537-42b5-bdc5-c2d96ec7dad3@intel.com>
Date: Fri, 15 Mar 2024 08:44:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ndctl PATCH v11 4/7] cxl/event_trace: add helpers to retrieve
 tep fields by type
Content-Language: en-US
To: alison.schofield@intel.com, Vishal Verma <vishal.l.verma@intel.com>
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
References: <cover.1710386468.git.alison.schofield@intel.com>
 <0dbf9557aaf5e8047440cb74f7df84ae404c11ba.1710386468.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0dbf9557aaf5e8047440cb74f7df84ae404c11ba.1710386468.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/13/24 9:05 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add helpers to extract the value of an event record field given the
> field name. This is useful when the user knows the name and format
> of the field and simply needs to get it. The helpers also return
> the 'type'_MAX of the type when the field is
> 
> Since this is in preparation for adding a cxl_poison private parser
> for 'cxl list --media-errors' support those specific required
> types: u8, u32, u64.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/event_trace.c | 37 +++++++++++++++++++++++++++++++++++++
>  cxl/event_trace.h |  8 +++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> index 640abdab67bf..324edb982888 100644
> --- a/cxl/event_trace.c
> +++ b/cxl/event_trace.c
> @@ -15,6 +15,43 @@
>  #define _GNU_SOURCE
>  #include <string.h>
>  
> +u64 cxl_get_field_u64(struct tep_event *event, struct tep_record *record,
> +		      const char *name)
> +{
> +	unsigned long long val;
> +
> +	if (tep_get_field_val(NULL, event, name, record, &val, 0))
> +		return ULLONG_MAX;
> +
> +	return val;
> +}
> +
> +u32 cxl_get_field_u32(struct tep_event *event, struct tep_record *record,
> +		      const char *name)
> +{
> +	char *val;
> +	int len;
> +
> +	val = tep_get_field_raw(NULL, event, name, record, &len, 0);
> +	if (!val)
> +		return UINT_MAX;
> +
> +	return *(u32 *)val;
> +}
> +
> +u8 cxl_get_field_u8(struct tep_event *event, struct tep_record *record,
> +		    const char *name)
> +{
> +	char *val;
> +	int len;
> +
> +	val = tep_get_field_raw(NULL, event, name, record, &len, 0);
> +	if (!val)
> +		return UCHAR_MAX;
> +
> +	return *(u8 *)val;
> +}
> +
>  static struct json_object *num_to_json(void *num, int elem_size, unsigned long flags)
>  {
>  	bool sign = flags & TEP_FIELD_IS_SIGNED;
> diff --git a/cxl/event_trace.h b/cxl/event_trace.h
> index b77cafb410c4..7b30c3922aef 100644
> --- a/cxl/event_trace.h
> +++ b/cxl/event_trace.h
> @@ -5,6 +5,7 @@
>  
>  #include <json-c/json.h>
>  #include <ccan/list/list.h>
> +#include <ccan/short_types/short_types.h>
>  
>  struct jlist_node {
>  	struct json_object *jobj;
> @@ -32,5 +33,10 @@ int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
>  int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system,
>  		const char *event);
>  int cxl_event_tracing_disable(struct tracefs_instance *inst);
> -
> +u8 cxl_get_field_u8(struct tep_event *event, struct tep_record *record,
> +		    const char *name);
> +u32 cxl_get_field_u32(struct tep_event *event, struct tep_record *record,
> +		      const char *name);
> +u64 cxl_get_field_u64(struct tep_event *event, struct tep_record *record,
> +		      const char *name);
>  #endif

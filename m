Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE81D357B;
	Thu, 17 Oct 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169066; cv=none; b=f/NRORCcuwLt4HmFzHckuND4rmh9FhM9L/dND+xmbMFhLHcqookYPX90hGCjNew/8ZDzbleQWTHVCq15opOWZSGOP4iBd5AI63A34POlmrrvyxPqJKmMlM65Qk+4VBGsTE6nsGPWqlpP3Vc/JsHWD2XZX/Ra5/EWSV2u+H+J7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169066; c=relaxed/simple;
	bh=7iUccDjyB3lkNOhVwRrikKnAz/dNha05D/XKS62LNTM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7gWmlxzoPu+H9seH9MZWJFtV0b5jp4KaUU6trrdILBGIrrGsYGHcOs1pAFmaEGt0DgjmoEf3RcbokGZiVab2NuI7U0Nau9ve7LkWbn6wSicEoIFT2W1RLAdXuzMPIFtRhjAETzI+Gycg36aI25ECYj9R1cjko5FytgVA3sesb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTnZN2WtVz6J9yF;
	Thu, 17 Oct 2024 20:43:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 974591400F4;
	Thu, 17 Oct 2024 20:44:20 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 14:44:19 +0200
Date: Thu, 17 Oct 2024 13:44:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [RFC PATCH 4/4] cxl/events: Updates for CXL Memory Module Event
 Record
Message-ID: <20241017134417.00005c6b@Huawei.com>
In-Reply-To: <20241016163349.1210-5-shiju.jose@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
	<20241016163349.1210-5-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Oct 2024 17:33:49 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.2.1.3 Table 8-47, Memory Module Event Record
> has updated with following new fields and new info for Device Event Type
> and Device Health Information fields.
> 1. Validity Flags
> 2. Component Identifier
> 3. Device Event Sub-Type
> 
> Add updates for the above spec changes in the CXL events record and CXL
> Memory Module trace event implementations.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

A few minor things inline, but with the event_sub_type naming feel
free to add
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  
>  	CXL_EVT_TP_printk("event_type='%s' health_status='%s' media_status='%s' " \
>  		"as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
>  		"as_cor_per_err_cnt=%s life_used=%u device_temp=%d " \
> -		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u",
> +		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u " \
> +		"validity_flags='%s' comp_id=%s sub_type='%s'",
>  		show_dev_evt_type(__entry->event_type),
>  		show_health_status_flags(__entry->health_status),
>  		show_media_status(__entry->media_status),
> @@ -750,7 +782,11 @@ TRACE_EVENT(cxl_memory_module,
>  		show_one_bit_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
>  		__entry->life_used, __entry->device_temp,
>  		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
> -		__entry->cor_per_err_cnt
> +		__entry->cor_per_err_cnt,
> +		show_mem_module_valid_flags(__entry->validity_flags),
> +		cxl_print_component_id(__entry->validity_flags, CXL_MMER_VALID_COMPONENT,
> +				       CXL_MMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
> +		show_dev_event_sub_type(__entry->sub_type)
If we are going to reorganize for the other patches, why not move this next to the event type
field?  There isn't a validity flag for this (0 means not specified)
so fine to move it earlier I think.
>  	)
>  );
>  
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 7e98492c85df..18b7f96dea77 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -102,7 +102,10 @@ struct cxl_event_mem_module {
>  	struct cxl_event_record_hdr hdr;
>  	u8 event_type;
>  	struct cxl_get_health_info info;
> -	u8 reserved[0x3d];
> +	u8 validity_flags[2];
> +	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +	u8 sub_type;
maybe event_sub_type to match spec naming?

> +	u8 reserved[0x2a];
>  } __packed;
>  
>  union cxl_event {


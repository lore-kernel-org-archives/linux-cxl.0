Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E237A256D;
	Tue, 22 Oct 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616316; cv=none; b=BWsgyHFiv26Pn8NaiuIsCZJ2J3zihjCo9hX4GScIL4fEIjix6SQefYOxD08vX3P0mP7HVI2OQSqn4YQVYnUfX4Jhcv1/mCQpaYcBmuSvmWk0YHgeq2qqQNDBVIMtnasQFslQsP9WPddX0VpmipzCJwjePw+tdgtJwt6kldyWeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616316; c=relaxed/simple;
	bh=mv3DKaNIW8cfxeolYjwKDutSrgWG+3comP9lZi4DtYE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLTK4GP9JD9ilx+psBQs3hOCTMb/vD2ofVHeKdOwOXHa45xllmEl57gtKdA7TnaRnrGBRXVNEGAB2nnK0on+2FAt0rLqgPQJrRgVgl3501i3CasMy55Vj+PddUwv1pvFpJtKuzRUO4LdxdKXIY1GozTebcYl69XzwbV8Zj9f05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXyz257SRz6K5x8;
	Wed, 23 Oct 2024 00:57:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 614411404F9;
	Wed, 23 Oct 2024 00:58:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Oct
 2024 18:58:29 +0200
Date: Tue, 22 Oct 2024 17:58:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v2 2/6] cxl/events: Add Component Identifier formatting
 for CXL spec rev 3.1
Message-ID: <20241022175827.000033ef@Huawei.com>
In-Reply-To: <20241022105849.1272-3-shiju.jose@huawei.com>
References: <20241022105849.1272-1-shiju.jose@huawei.com>
	<20241022105849.1272-3-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Oct 2024 11:58:45 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add Component Identifier formatting for CXL spec rev 3.1, Section
> 8.2.9.2.1, Table 8-44.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/trace.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 7305974e2301..81908072c6f3 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -268,6 +268,26 @@ TRACE_EVENT(cxl_generic_event,
>  	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
>  )
>  
> +/*
> + * Component ID Format
> + * CXL 3.1 section 8.2.9.2.1; Table 8-44
> + */
> +#define CXL_PLDM_COMPONENT_ID_ENTITY_VALID	BIT(0)
> +#define CXL_PLDM_COMPONENT_ID_RES_VALID		BIT(1)
> +
> +#define comp_id_pldm_flags(flags)  __print_flags(flags, " | ",			\
> +	{ CXL_PLDM_COMPONENT_ID_ENTITY_VALID,   "PLDM_Entity_ID[5:0] " },	\
> +	{ CXL_PLDM_COMPONENT_ID_RES_VALID,      "Resource_ID[9:6] " }		\
> +)
> +
> +#define cxl_print_component_id(flags, valid_comp_id, valid_id_format, comp_id)			\
> +	(flags & valid_comp_id && flags & valid_id_format) ?					\
> +	(comp_id[0] & (CXL_PLDM_COMPONENT_ID_ENTITY_VALID | CXL_PLDM_COMPONENT_ID_RES_VALID)) ?	\
> +	__print_hex(&comp_id[1], 10) : (comp_id[0] & CXL_PLDM_COMPONENT_ID_ENTITY_VALID) ?	\
> +	__print_hex(&comp_id[1], 6) : (comp_id[0] & CXL_PLDM_COMPONENT_ID_RES_VALID) ?		\
> +	__print_hex(&comp_id[7], 4) : __print_hex(comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE) :	\

> +	__print_hex(comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> +
Hi Shiju,

This is hard to read and I've lost track of what the aim is.
Side note that it is probably good to state that in the patch description
+ give some examples of what this print looks like in the various cases.
If we are going to print the whole thing in the case where we
have no valid bits set in byte[1], maybe we just print the whole thing
in all cases and just add the info on whether it is formatted and what
those valid bits are in byte[1]?

I was never keen on printing the invalid fields in the first place
but this code adopted the convention of validity bits and print what
is there where valid or not. So maybe the things we should print are:
Taking GMER as an example.

Add the component id valid format to show_valid_flags() 
Then always print the flags for comp_id_pldm_flags() above whether
or not they are valid. Finally print the two broken out fields
Enity ID and Resource ID.

Whether we also just print the raw versions is another question we
need to figure out - in the formatted case it is duplication, but
if not it includes more bytes.

Jonathan



>  /*
>   * General Media Event Record - GMER
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43


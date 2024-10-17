Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292051DDC0E;
	Thu, 17 Oct 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168727; cv=none; b=uddaySqTx6Px1KcMsAqETjyIAnEm4rmLfvf9Itj+clyqvGZchRJVZBzjCflmzSAXPwmnAMPxYsiQyocCrZOVclWTctGwsou39UkTps7QniXo1AuOu7FFAJurUAANi4jp5jCs/QRU7hY590CTJzTcGRvViQ+WufBxiNAKqWd76Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168727; c=relaxed/simple;
	bh=gJowPuj2eGVIHd+l3ktq8ceYKlOGYjghKnJE8W+rq8s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTIBBnNAZeUlGarLzafe718h1LBTxtrhsKjw4APy+6Bl7LHlOjzv9j9bL3DGf1d0hPfMNbBV9GG/Fas7sJRzzLJsl1l25NOLsnjYyNb0SlsJLt9bhuMG5trcJgvkSjgDKEQ0jnAVZO1z4wYNqzZUTb1WQi5OOoaAlWfdTINl4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTnMQ06xCz6LDF7;
	Thu, 17 Oct 2024 20:34:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D9DC140B33;
	Thu, 17 Oct 2024 20:38:41 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 14:38:40 +0200
Date: Thu, 17 Oct 2024 13:38:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [RFC PATCH 3/4] cxl/events: Updates for CXL DRAM Event Record
Message-ID: <20241017133839.000035dd@Huawei.com>
In-Reply-To: <20241016163349.1210-4-shiju.jose@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
	<20241016163349.1210-4-shiju.jose@huawei.com>
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

On Wed, 16 Oct 2024 17:33:48 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.2.1.2 Table 8-46, DRAM Event Record has updated
> with following new fields and new types for Memory Event Type, Transaction
> Type and Validity Flags fields.
> 1. Component Identifier
> 2. Sub-channel
> 3. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 4. Corrected Memory Error Count at Event
> 5. Memory Event Sub-Type
> 
> Add updates for the above spec changes in the CXL events record and CXL
> DRAM trace event implementations.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Passing comments on two things inline.
1) There are a couple of whitespace consistency changes in here.
   Spaces to tabs for alignment.  That's fine but maybe needs a brief
   mention in the patch description.
2) Really odd that the spec didn't have a component ID field for DRAM
   errors.  They weren't all that useful before the PLDM format was added
   but still a curiosity that made me open up the 3.0 spec.  Indeed, no
   such field.

With that one line added to the patch description this looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/trace.h | 44 ++++++++++++++++++++++++++++++++--------
>  include/cxl/event.h      |  7 ++++++-
>  2 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index e638e82429bc..20790dffa2b4 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -468,7 +468,7 @@ TRACE_EVENT(cxl_general_media,
>  /*
>   * DRAM Event Record - DER
>   *
> - * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + * CXL rev 3.1 section 8.2.9.2.1.2; Table 8-46
>   */
>  /*
>   * DRAM Event Record defines many fields the same as the General Media Event
> @@ -478,11 +478,17 @@ TRACE_EVENT(cxl_general_media,
>  #define CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x01
>  #define CXL_DER_MEM_EVT_TYPE_INV_ADDR			0x02
>  #define CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x03
> -#define show_dram_mem_event_type(type)  __print_symbolic(type,				\
> +#define CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION	0x04
> +#define CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE	0x05
> +#define CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION		0x06
> +#define show_dram_mem_event_type(type)	__print_symbolic(type,				\

This change looks odd here but does print the line above into the
same formatting style as the other similar cases in the file.
Maybe worth a line in the patch description to say "Includes trivial consistency of white
space improvements" just to flag up that it was intentional.

>  	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },			\
>  	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },	\
>  	{ CXL_DER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },		\
> -	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" }		\
> +	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" },		\
> +	{ CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION,	"TE State Violation" },		\
> +	{ CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE,	"Adv Prog CME Counter Expiration" },	\
> +	{ CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" }		\
>  )
>  
>  #define CXL_DER_VALID_CHANNEL				BIT(0)
> @@ -493,7 +499,10 @@ TRACE_EVENT(cxl_general_media,
>  #define CXL_DER_VALID_ROW				BIT(5)
>  #define CXL_DER_VALID_COLUMN				BIT(6)
>  #define CXL_DER_VALID_CORRECTION_MASK			BIT(7)
> -#define show_dram_valid_flags(flags)	__print_flags(flags, "|",			   \
> +#define CXL_DER_VALID_COMPONENT				BIT(8)
> +#define CXL_DER_VALID_COMPONENT_ID_FORMAT		BIT(9)
> +#define CXL_DER_VALID_SUB_CHANNEL			BIT(10)
> +#define show_dram_valid_flags(flags)	__print_flags(flags, "|",		   \

As above this is a minor white space consistency change.

>  	{ CXL_DER_VALID_CHANNEL,			"CHANNEL"		}, \
>  	{ CXL_DER_VALID_RANK,				"RANK"			}, \
>  	{ CXL_DER_VALID_NIBBLE,				"NIBBLE"		}, \
> @@ -501,7 +510,9 @@ TRACE_EVENT(cxl_general_media,
>  	{ CXL_DER_VALID_BANK,				"BANK"			}, \
>  	{ CXL_DER_VALID_ROW,				"ROW"			}, \
>  	{ CXL_DER_VALID_COLUMN,				"COLUMN"		}, \
> -	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}  \
> +	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}, \
> +	{ CXL_DER_VALID_COMPONENT,			"COMPONENT"		}, \
> +	{ CXL_DER_VALID_SUB_CHANNEL,			"SUB CHANNEL"		}  \
>  )

> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index ea8cd44a52e9..7e98492c85df 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -71,7 +71,12 @@ struct cxl_event_dram {
>  	u8 row[3];
>  	u8 column[2];
>  	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> -	u8 reserved[0x17];
> +	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
Odd that the general media had this field in 3.0 but DRAM didn't.
I checked though and indeed the case!

> +	u8 sub_channel;
> +	u8 cme_threshold_ev_flags;
> +	u8 cvme_count[3];
> +	u8 sub_type;
> +	u8 reserved;
>  } __packed;
>  
>  /*


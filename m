Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B6E54673
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671812; cv=none; b=oZm+b+xw9F3CeWNXKFjtx2v72/C69Re15wYcLQ203oWfj4mS5VqYTqqLxe+JZXpsXOWF9JsETjgJb1HfrinnocSmzsaUzGaUFuEOGrguRe3wD4FLzqE/lU/KuTcL3Jm5jse+xazt+7rgj6fsWeQt4BgoQb4Gtb8Pfjc5ujnMKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671812; c=relaxed/simple;
	bh=q7FGpS4gUkP7HnhZgYiwzPfJy1Ofx3QCIeO358REUD8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmjKmc+naQmgiUSnLrdK6ph9P2v4fs1MHlLHh7M5DatiYJvJke6rsgWNz1HeeCsG6B/SUd1SYBuggnKo2E2/5iSln2oo+jp+yHVdJSy4+i6/e+WqhrItie1s3dQIFn07efDRxlqqEYn4x/eckNlzjqcxLnC7xbmkFMaUo3F60WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhxLx1yvZz6L5BM;
	Wed, 16 Jul 2025 21:13:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F0FA814033C;
	Wed, 16 Jul 2025 21:16:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 15:16:45 +0200
Date: Wed, 16 Jul 2025 14:16:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 4/4] cxl/events: Trace Memory Sparing Event Record
Message-ID: <20250716141644.00000347@huawei.com>
In-Reply-To: <20250716104945.2002-5-shiju.jose@huawei.com>
References: <20250716104945.2002-1-shiju.jose@huawei.com>
	<20250716104945.2002-5-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Jul 2025 11:49:45 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL rev 3.2 section 8.2.10.2.1.4 Table 8-60 defines the Memory Sparing
> Event Record.
> 
> Determine if the event read is memory sparing record and if so trace the
> record.
> 
> Memory device shall produce a memory sparing event record
> 1. After completion of a PPR maintenance operation if the memory sparing
> event record enable bit is set (Field: sPPR/hPPR Operation Mode in
> Table 8-128/Table 8-131).
> 2. In response to a query request by the host (see section 8.2.10.7.1.4)
> to determine the availability of sparing resources.
> The device shall report the resource availability by producing the Memory
> Sparing Event Record (see Table 8-60) in which the channel, rank, nibble
> mask, bank group, bank, row, column, sub-channel fields are a copy of the
> values specified in the request. If the controller does not support
> reporting whether a resource is available, and a perform maintenance
> operation for memory sparing is issued with query resources set to 1, the
> controller shall return invalid input.
> 
> Example trace log for produce memory sparing event record on completion
> of a soft PPR operation,
> cxl_memory_sparing: memdev=mem1 host=0000:0f:00.0 serial=3
> log=Informational : time=55045163029
> uuid=e71f3a40-2d29-4092-8a39-4d1c966c7c65 len=128 flags='0x1' handle=1
> related_handle=0 maint_op_class=2 maint_op_sub_class=1
> ld_id=0 head_id=0 : flags='' result=0
> validity_flags='CHANNEL|RANK|NIBBLE|BANK GROUP|BANK|ROW|COLUMN'
> spare resource avail=1 channel=2 rank=5 nibble_mask=a59c bank_group=2
> bank=4 row=13 column=23 sub_channel=0
> comp_id=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> comp_id_pldm_valid_flags='' pldm_entity_id=0x00 pldm_resource_id=0x00
> 
> Note: For memory sparing event record, fields 'maintenance operation
> class' and 'maintenance operation subclass' are defined twice, first
> in the common event record (Table 8-55) and second in the memory
> sparing event record (Table 8-60). Thus those in the sparing event
> record coded as reserved, to be removed when the spec is updated.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Only comment formatting related.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c  |   6 +++
>  drivers/cxl/core/trace.h | 100 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h     |   8 ++++
>  include/cxl/event.h      |  33 +++++++++++++
>  4 files changed, 147 insertions(+)
> 

> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index c3cd871942c5..2c291fb1857c 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -888,6 +888,106 @@ TRACE_EVENT(cxl_memory_module,
>  	)
>  );
>  
> +#define CXL_MSER_QUERY_RESOURCE_FLAG			BIT(0)
> +#define CXL_MSER_HARD_SPARING_FLAG			BIT(1)
> +#define CXL_MSER_DEV_INITED_FLAG			BIT(2)
> +#define show_mem_sparing_flags(flags)	__print_flags(flags, "|",		\
> +	{ CXL_MSER_QUERY_RESOURCE_FLAG,		"Query Resources" },		\
> +	{ CXL_MSER_HARD_SPARING_FLAG,		"Hard Sparing" },		\
> +	{ CXL_MSER_DEV_INITED_FLAG,	"Device Initiated Sparing"	}	\

Spacing before the } is inconsistent for this last line.  Copy whatever we have
in the file already and if it is inconsistent (which it is) pick most common option.

> +)
> +
> +#define CXL_MSER_VALID_CHANNEL				BIT(0)
> +#define CXL_MSER_VALID_RANK				BIT(1)
> +#define CXL_MSER_VALID_NIBBLE				BIT(2)
> +#define CXL_MSER_VALID_BANK_GROUP			BIT(3)
> +#define CXL_MSER_VALID_BANK				BIT(4)
> +#define CXL_MSER_VALID_ROW				BIT(5)
> +#define CXL_MSER_VALID_COLUMN				BIT(6)
> +#define CXL_MSER_VALID_COMPONENT_ID			BIT(7)
> +#define CXL_MSER_VALID_COMPONENT_ID_FORMAT		BIT(8)
> +#define CXL_MSER_VALID_SUB_CHANNEL			BIT(9)
> +#define show_mem_sparing_valid_flags(flags)	__print_flags(flags, "|",		\
> +	{ CXL_MSER_VALID_CHANNEL,			"CHANNEL"		},	\
> +	{ CXL_MSER_VALID_RANK,				"RANK"			},	\
> +	{ CXL_MSER_VALID_NIBBLE,			"NIBBLE"		},	\
> +	{ CXL_MSER_VALID_BANK_GROUP,			"BANK GROUP"		},	\
> +	{ CXL_MSER_VALID_BANK,				"BANK"			},	\
> +	{ CXL_MSER_VALID_ROW,				"ROW"			},	\
> +	{ CXL_MSER_VALID_COLUMN,			"COLUMN"		},	\
> +	{ CXL_MSER_VALID_COMPONENT_ID,			"COMPONENT ID"		},	\
> +	{ CXL_MSER_VALID_COMPONENT_ID_FORMAT,		"COMPONENT ID PLDM FORMAT" },	\
> +	{ CXL_MSER_VALID_SUB_CHANNEL,			"SUB CHANNEL"		}	\
> +)
> +
> +TRACE_EVENT(cxl_memory_sparing,
> +
> +	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> +		 struct cxl_event_mem_sparing *rec),
> +
> +	TP_ARGS(cxlmd, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +
> +		/* Memory Sparing Event */
> +		__field(u8, flags)
> +		__field(u8, result)
> +		__field(u16, validity_flags)
> +		__field(u16, res_avail)
> +		__field(u8, channel)
> +		__field(u8, rank)
> +		__field(u32, nibble_mask)
> +		__field(u8, bank_group)
> +		__field(u8, bank)
> +		__field(u32, row)
> +		__field(u16, column)
> +		__field(u8, sub_channel)
> +		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> +		__entry->hdr_uuid = CXL_EVENT_MEM_SPARING_UUID;
> +
> +		/* Memory Sparing Event */
> +		__entry->flags = rec->flags;
> +		__entry->result = rec->result;
> +		__entry->validity_flags = le16_to_cpu(rec->validity_flags);
> +		__entry->res_avail = le16_to_cpu(rec->res_avail);
> +		__entry->channel = rec->channel;
> +		__entry->rank = rec->rank;
> +		__entry->nibble_mask = get_unaligned_le24(rec->nibble_mask);
> +		__entry->bank_group = rec->bank_group;
> +		__entry->bank = rec->bank;
> +		__entry->row = get_unaligned_le24(rec->row);
> +		__entry->column = le16_to_cpu(rec->column);
> +		__entry->sub_channel = rec->sub_channel;
> +		memcpy(__entry->comp_id, &rec->component_id,
> +		       CXL_EVENT_GEN_MED_COMP_ID_SIZE);
> +	),
> +
> +	CXL_EVT_TP_printk("flags='%s' result=%u validity_flags='%s' " \
> +		"spare resource avail=%u channel=%u rank=%u " \
> +		"nibble_mask=%x bank_group=%u bank=%u " \
> +		"row=%u column=%u sub_channel=%u " \
> +		"comp_id=%s comp_id_pldm_valid_flags='%s' " \
> +		"pldm_entity_id=%s pldm_resource_id=%s",
> +		show_mem_sparing_flags(__entry->flags),
> +		__entry->result,
> +		show_mem_sparing_valid_flags(__entry->validity_flags),
> +		__entry->res_avail, __entry->channel, __entry->rank,
> +		__entry->nibble_mask, __entry->bank_group, __entry->bank,
> +		__entry->row, __entry->column, __entry->sub_channel,
> +		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
> +		show_comp_id_pldm_flags(__entry->comp_id[0]),
> +		show_pldm_entity_id(__entry->validity_flags, CXL_MSER_VALID_COMPONENT_ID,
> +				    CXL_MSER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
> +		show_pldm_resource_id(__entry->validity_flags, CXL_MSER_VALID_COMPONENT_ID,
> +				      CXL_MSER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id)
> +	)
> +);
> +
>  #define show_poison_trace_type(type)			\
>  	__print_symbolic(type,				\
>  	{ CXL_POISON_TRACE_LIST,	"List"   },	\



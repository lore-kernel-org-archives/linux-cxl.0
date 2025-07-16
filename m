Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D42B660
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704609; cv=none; b=dVf+MqwAWrMbKOFVcv6TDjeEoPlFN5wyswDde4HSK2+aFIG3DIl1abT9NFM09AE5VYvAmtqThRiHVZEvKhzimATWyRiFRdwGLr3LjP28d/QV2MbMTniLOhp6WfVKrd20T5jo+LL5IJoMsW9jIt8hsx3jXjhRFuufLaBKxltBn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704609; c=relaxed/simple;
	bh=xY+HMLNZa+NbAl02CuBGBNM6bIQ6xejdVHxQCCVJ+n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDCNZTUCvOeI9pAq9ythJRQM54PTpluxPMPx3cK6kzmvJoVERhhQpK5FKsoqN4fDKWA6ChehYsNm+SAtiUcksEqd+eia3BdjD7KZ/sorNoL6pH/Qk8tpln3x668lFC11LeZOT0W+q/bj5W6ErKpjcR+wPorAMApR0xGqRZWslQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSuUzKgp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSuUzKgp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752704608; x=1784240608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xY+HMLNZa+NbAl02CuBGBNM6bIQ6xejdVHxQCCVJ+n8=;
  b=TSuUzKgpdEcCGgaozSk3ZQf124ic8bnSlUyKayotI2sGXTpgXaIMzQad
   1f73sdpYWZ3fIhOtSbbb4pa8putJ6A0IETtqvRzNlkGI4gcmiE1x7C148
   lhz1+a4lXYYVqsR61Z8eRxfC5mWxU3X+sZb1t1VRUZKRQAiLYzCd+SLxj
   W1AckkAGNov0U7irqcC/8p+/en4/vMBu/KDbU1rQbfE2EPUQZBUyk9Ieb
   w/Mx4cijNRrnCjio2CtTP2cxyEXt7KGUK9Qluz8qjkmyq69J9zNfuZUJW
   fDUqtMEH6V4kjfdC8+oVJXBFq6uWgex+Nh+KvhTn3ZGvtMIA6zzOndmh3
   g==;
X-CSE-ConnectionGUID: jRBiomIXSrys39NrLH6LqA==
X-CSE-MsgGUID: x2GrojfGTnqTpuiuYG4D1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54685666"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54685666"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 15:23:27 -0700
X-CSE-ConnectionGUID: /8iwGsj2RfCRJ686PRfFEw==
X-CSE-MsgGUID: 8Zb2z3KIR3GPaMQIil7FrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="181315499"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.193]) ([10.125.111.193])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 15:23:26 -0700
Message-ID: <1f240e13-8b2f-470f-9bed-6c2a1363469f@intel.com>
Date: Wed, 16 Jul 2025 15:23:25 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cxl/events: Trace Memory Sparing Event Record
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, dave@stgolabs.net, vishal.l.verma@intel.com,
 ira.weiny@intel.com
Cc: tanxiaofei@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com
References: <20250716104945.2002-1-shiju.jose@huawei.com>
 <20250716104945.2002-5-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250716104945.2002-5-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/25 3:49 AM, shiju.jose@huawei.com wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c  |   6 +++
>  drivers/cxl/core/trace.h | 100 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h     |   8 ++++
>  include/cxl/event.h      |  33 +++++++++++++
>  4 files changed, 147 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e8c49ae28828..682993ace4ae 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -899,6 +899,10 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
>  		return;
>  	}
> +	if (event_type == CXL_CPER_EVENT_MEM_SPARING) {
> +		trace_cxl_memory_sparing(cxlmd, type, &evt->mem_sparing);
> +		return;
> +	}
>  
>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
>  		u64 dpa, hpa = ULLONG_MAX, hpa_alias = ULLONG_MAX;
> @@ -970,6 +974,8 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		ev_type = CXL_CPER_EVENT_DRAM;
>  	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
>  		ev_type = CXL_CPER_EVENT_MEM_MODULE;
> +	else if (uuid_equal(uuid, &CXL_EVENT_MEM_SPARING_UUID))
> +		ev_type = CXL_CPER_EVENT_MEM_SPARING;
>  
>  	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
>  }
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
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 551b0ba2caa1..f98311f357b7 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -633,6 +633,14 @@ struct cxl_mbox_identify {
>  	UUID_INIT(0xfe927475, 0xdd59, 0x4339, 0xa5, 0x86, 0x79, 0xba, 0xb1, \
>  		  0x13, 0xb7, 0x74)
>  
> +/*
> + * Memory Sparing Event Record UUID
> + * CXL rev 3.2 section 8.2.10.2.1.4: Table 8-60
> + */
> +#define CXL_EVENT_MEM_SPARING_UUID                                          \
> +	UUID_INIT(0xe71f3a40, 0x2d29, 0x4092, 0x8a, 0x39, 0x4d, 0x1c, 0x96, \
> +		  0x6c, 0x7c, 0x65)
> +
>  /*
>   * Get Event Records output payload
>   * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index f4cb8568566b..6fd90f9cc203 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -110,11 +110,43 @@ struct cxl_event_mem_module {
>  	u8 reserved[0x2a];
>  } __packed;
>  
> +/*
> + * Memory Sparing Event Record - MSER
> + * CXL rev 3.2 section 8.2.10.2.1.4; Table 8-60
> + */
> +struct cxl_event_mem_sparing {
> +	struct cxl_event_record_hdr hdr;
> +	/*
> +	 * The fields maintenance operation class and maintenance operation
> +	 * subclass defined in the Memory Sparing Event Record are the
> +	 * duplication of the same in the common event record. Thus defined
> +	 * as reserved and to be removed after the spec correction.
> +	 */
> +	u8 rsv1;
> +	u8 rsv2;
> +	u8 flags;
> +	u8 result;
> +	__le16 validity_flags;
> +	u8 reserved1[6];
> +	__le16 res_avail;
> +	u8 channel;
> +	u8 rank;
> +	u8 nibble_mask[3];
> +	u8 bank_group;
> +	u8 bank;
> +	u8 row[3];
> +	__le16 column;
> +	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +	u8 sub_channel;
> +	u8 reserved2[0x25];
> +} __packed;
> +
>  union cxl_event {
>  	struct cxl_event_generic generic;
>  	struct cxl_event_gen_media gen_media;
>  	struct cxl_event_dram dram;
>  	struct cxl_event_mem_module mem_module;
> +	struct cxl_event_mem_sparing mem_sparing;
>  	/* dram & gen_media event header */
>  	struct cxl_event_media_hdr media_hdr;
>  } __packed;
> @@ -133,6 +165,7 @@ enum cxl_event_type {
>  	CXL_CPER_EVENT_GEN_MEDIA,
>  	CXL_CPER_EVENT_DRAM,
>  	CXL_CPER_EVENT_MEM_MODULE,
> +	CXL_CPER_EVENT_MEM_SPARING,
>  };
>  
>  #define CPER_CXL_DEVICE_ID_VALID		BIT(0)


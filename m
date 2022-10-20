Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43062C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 17:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJTRHg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJTRHf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 13:07:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4A1A5B0B
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666285654; x=1697821654;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z53kMzdTiHhYe1tf3HmHNEM3O8NKOQyeC+5GGVVDJMg=;
  b=a1qcq7GPL1+tvPjLQLEbNo+fq125FSHV74uPUzNOno8NaALYEqJQHqLe
   9Nb8JYKb7zmQ/13wGGk059KzTO2nSrHxi6tjk4ZSGJG6lxyQ1R3U9AJIA
   Q+XNAdk9PzIEqe2qgvCRMVKPWBQsksTKE2ndJxaJSG+e+sJWK4kMtINpw
   AGI5ys0Dmufzh/PkungXGJXZDgV6P2cdvODfG/7sriuxUdmI1dW5kQtUH
   IneSyj3FeFjXy03pxq4pjQPEzPqqZKQCGO7mETFBBsDWuN+QMp3dL6XWR
   8fUqJtJbPt9KqtZub1To/gz7NWoMdaq5OrYG3+/l9zp1STA6sLhV+lNAU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286495028"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="286495028"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 10:07:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="607798577"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="607798577"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.65.105]) ([10.212.65.105])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 10:07:31 -0700
Message-ID: <d70a5bc5-2d1d-c038-fb78-b7f36a31677c@intel.com>
Date:   Thu, 20 Oct 2022 10:07:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [PATCH RFC v2 8/9] cxl/pci: add tracepoint events for CXL RAS
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, shiju.jose@huawei.com, rrichter@amd.com,
        Steven Rostedt <rostedt@goodmis.org>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
 <166336989980.3803215.5292431481210955312.stgit@djiang5-desk3.ch.intel.com>
 <20221020180235.00007320@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221020180235.00007320@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/20/2022 10:02 AM, Jonathan Cameron wrote:
> On Fri, 16 Sep 2022 16:11:39 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> Add tracepoint events for recording the CXL uncorrectable and correctable
>> errors. For uncorrectable errors, there is additional data up to 512B from
>> the header log register (CXL spec rev3 8.2.4.16.7). The content of the
>> register depends on the Uncorrectable Errors (UC) register status (CXL spec
>> rev3 8.2.4.16.1).  This implementation supports the Receiver_Overflow error
>> where the definition is defined as first 3 bits of the Header Log data. The
>> trace event will intake a dynamic array that will dump the Header Log data
>> based on error. If multiple errors are set in the status register, then the
>> 'first error' field (CXL spec rev3 v8.2.4.16.6) is read from the Error
>> Capabilities and Control Register in order to determine the error.
>>
>> This implementation does not include CXL IDE Error details.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Given the useful review we've gotten on other race points seems wise to
> Cc Stephen.
Yes I will next rev.
>
> The overflow flags seems to be inconsistent wrt to spec.  They aren't flags
> as such in the spec.  However I note that isn't used anyway so maybe drop
> it for now?

Will do.


>
> Jonathan
>
>> ---
>>   drivers/cxl/pci.c              |    2 +
>>   include/trace/events/cxl_ras.h |  117 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 119 insertions(+)
>>   create mode 100644 include/trace/events/cxl_ras.h
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 610b3a77f205..357de704e42c 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -13,6 +13,8 @@
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>>   #include "cxl.h"
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/cxl_ras.h>
>>   
>>   /**
>>    * DOC: cxl pci
>> diff --git a/include/trace/events/cxl_ras.h b/include/trace/events/cxl_ras.h
>> new file mode 100644
>> index 000000000000..6bb41c3b87c8
>> --- /dev/null
>> +++ b/include/trace/events/cxl_ras.h
>> @@ -0,0 +1,117 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM cxl_ras
>> +
>> +#if !defined(_CXL_RAS_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _CXL_RAS_EVENTS_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +#define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
>> +#define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
>> +#define CXL_RAS_UC_CACHE_BE_PARITY	BIT(2)
>> +#define CXL_RAS_UC_CACHE_DATA_ECC	BIT(3)
>> +#define CXL_RAS_UC_MEM_DATA_PARITY	BIT(4)
>> +#define CXL_RAS_UC_MEM_ADDR_PARITY	BIT(5)
>> +#define CXL_RAS_UC_MEM_BE_PARITY	BIT(6)
>> +#define CXL_RAS_UC_MEM_DATA_ECC		BIT(7)
>> +#define CXL_RAS_UC_REINIT_THRESH	BIT(8)
>> +#define CXL_RAS_UC_RSVD_ENCODE		BIT(9)
>> +#define CXL_RAS_UC_POISON		BIT(10)
>> +#define CXL_RAS_UC_RECV_OVERFLOW	BIT(11)
>> +#define CXL_RAS_UC_INTERNAL_ERR		BIT(14)
>> +#define CXL_RAS_UC_IDE_TX_ERR		BIT(15)
>> +#define CXL_RAS_UC_IDE_RX_ERR		BIT(16)
>> +
>> +#define show_uc_errs(status)	__print_flags(status, " | ",		  \
>> +	{ CXL_RAS_UC_CACHE_DATA_PARITY, "Cache Data Parity Error" },	  \
>> +	{ CXL_RAS_UC_CACHE_ADDR_PARITY, "Cache Address Parity Error" },	  \
>> +	{ CXL_RAS_UC_CACHE_BE_PARITY, "Cache Byte Enable Parity Error" }, \
>> +	{ CXL_RAS_UC_CACHE_DATA_ECC, "Cache Data ECC Error" },		  \
>> +	{ CXL_RAS_UC_MEM_DATA_PARITY, "Memory Data Parity Error" },	  \
>> +	{ CXL_RAS_UC_MEM_ADDR_PARITY, "Memory Address Parity Error" },	  \
>> +	{ CXL_RAS_UC_MEM_BE_PARITY, "Memory Byte Enable Parity Error" },  \
>> +	{ CXL_RAS_UC_MEM_DATA_ECC, "Memory Data ECC Error" },		  \
>> +	{ CXL_RAS_UC_REINIT_THRESH, "REINIT Threshold Hit" },		  \
>> +	{ CXL_RAS_UC_RSVD_ENCODE, "Received Unrecognized Encoding" },	  \
>> +	{ CXL_RAS_UC_POISON, "Received Poison From Peer" },		  \
>> +	{ CXL_RAS_UC_RECV_OVERFLOW, "Receiver Overflow" },		  \
>> +	{ CXL_RAS_UC_INTERNAL_ERR, "Component Specific Error" },	  \
>> +	{ CXL_RAS_UC_IDE_TX_ERR, "IDE Tx Error" },			  \
>> +	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>> +)
>> +
>> +#define CXL_RAS_UC_OVFL_D2H_REQ		BIT(0)
>> +#define CXL_RAS_UC_OVFL_D2H_RSP		BIT(1)
>> +#define CXL_RAS_UC_OVFL_D2H_DATA	BIT(2)
>> +#define CXL_RAS_UC_OVFL_S2M_NDR		BIT(3)
>> +#define CXL_RAS_UC_OVFL_S2M_DRS		BIT(4)
> Why not align these with the values in the spec?
> They aren't flags as such...  Mind you not used anyway so probably just
> drop it for now?
>
>> +
>> +#define show_uc_ovfl(hl)	__print_flags(hl, " | ",		\
>> +	{ CXL_RAS_UC_OVFL_D2H_REQ, "Receiver Overflow D2H Req" },	\
>> +	{ CXL_RAS_UC_OVFL_D2H_RSP, "Receiver Overflow D2H Rsp" },	\
>> +	{ CXL_RAS_UC_OVFL_D2H_DATA, "Receiver Overflow D2H Data" },	\
>> +	{ CXL_RAS_UC_OVFL_S2M_NDR, "Receiver Overflow S2M NDR" },	\
>> +	{ CXL_RAS_UC_OVFL_S2M_DRS, "Receiver Overflow S2M DRS" }	\
>> +)
>> +
>> +TRACE_EVENT(cxl_ras_uc,
>> +	TP_PROTO(const char *dev_name, u32 status, u32 fe, u8 *hl, int hl_len),
>> +	TP_ARGS(dev_name, status, fe, hl, hl_len),
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name)
>> +		__field(u32, status)
>> +		__field(u32, first_error)
>> +		__dynamic_array(u8, header_log, hl_len)
>> +		__field(int, header_log_len)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name);
>> +		__entry->status = status;
>> +		__entry->first_error = fe;
>> +		memcpy(__get_dynamic_array(header_log), hl, hl_len);
>> +		__entry->header_log_len = hl_len;
>> +	),
>> +	TP_printk("%s: status: '%s' first_error: '%s' header log: %s",
>> +		  __get_str(dev_name), show_uc_errs(__entry->status),
>> +		  show_uc_errs(__entry->first_error),
>> +		  __print_array(__get_dynamic_array(header_log), __entry->header_log_len, 1)
>> +	)
>> +);
>> +
>> +#define CXL_RAS_CE_CACHE_DATA_ECC	BIT(0)
>> +#define CXL_RAS_CE_MEM_DATA_ECC		BIT(1)
>> +#define CXL_RAS_CE_CRC_THRESH		BIT(2)
>> +#define CXL_RAS_CE_CACHE_POISON		BIT(3)
>> +#define CXL_RAS_CE_MEM_POISON		BIT(4)
>> +#define CXL_RAS_CE_PHYS_LAYER_ERR	BIT(5)
>> +
>> +#define show_ce_errs(status)	__print_flags(status, " | ",			\
>> +	{ CXL_RAS_CE_CACHE_DATA_ECC, "Cache Data ECC Error" },			\
>> +	{ CXL_RAS_CE_MEM_DATA_ECC, "Memory Data Ecc Error" },			\
>> +	{ CXL_RAS_CE_CRC_THRESH, "CRC Threshold Hit" },				\
>> +	{ CXL_RAS_CE_CACHE_POISON, "Received Cache Poison From Peer" },		\
>> +	{ CXL_RAS_CE_MEM_POISON, "Received Memory Poison From Peer" },		\
>> +	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>> +)
>> +
>> +TRACE_EVENT(cxl_ras_ce,
>> +	TP_PROTO(const char *dev_name, u32 status),
>> +	TP_ARGS(dev_name, status),
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name)
>> +		__field(u32, status)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name);
>> +		__entry->status = status;
>> +	),
>> +	TP_printk("%s: status: '%s'",
>> +		  __get_str(dev_name), show_ce_errs(__entry->status)
>> +	)
>> +);
>> +
>> +#endif /* _CXL_RAS_EVENTS_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>>
>>

Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93C28C5BA
	for <linux-cxl@vger.kernel.org>; Fri, 20 Jun 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750428802; cv=none; b=Ya18lgFbhlBmP6AEMcvZEVyoAPx9dCtfs6bbYjdzEZER7ClfaLGAcw1Ck29BSaxBCWylxiru32qqqen8aThsmnGy7mhcLJ5b3lJagqsEKU9YnS/BZ3hAcj8iWNDOpPby97RDhMAKpShATkXim2hU36zPsO4Oka6ui7YZbX49V3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750428802; c=relaxed/simple;
	bh=2muKcuXuA5AmXSpGrK15U/dKsZbqqqab09jXCx49cHc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcT0T4+s1sS2ir2wsYGG+n+8PecQ3BXiAlKlRgFV2gXSiL9L5gROCuMOMxvtne9GGN9XifnJ5mNUd/yRB8AOiuIMS3eUZUIaR/uHVOnvqzesahDdvaAmL3aEJM4ZcwgOQS0Ci3iA9EqyP1iCJMzAfE2oyoQsOTNGKxSvYg0WCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNzvV6rfYz6M4y6;
	Fri, 20 Jun 2025 22:12:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E246140446;
	Fri, 20 Jun 2025 22:13:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 16:13:16 +0200
Date: Fri, 20 Jun 2025 15:13:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/7] hw/cxl/events: Updates for rev3.2 general media
 event record
Message-ID: <20250620151314.0000535c@huawei.com>
In-Reply-To: <20250619151619.1695-3-shiju.jose@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
	<20250619151619.1695-3-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Jun 2025 16:16:14 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
> table has updated with following new fields.
> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 2. Corrected Memory Error Count at Event
> 3. Memory Event Sub-Type
> 
> Add updates for the above spec changes in the CXL general media event
> reporting and QMP command to inject general media event.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
This has the same constraints on not changing the qemu api stuff
in a non backwards compatible way.

So make them optional parameters and fill them in with what
we'd get if the device didn't support cme. These only really
make sense if we have memory event type 5 anyway:
Advanced Programmable Corrected Memory Counter Expiration

We don't need to enforce that in the interface though.

I don't mind if we do the incompatible 'counter expiry'
and a count of 0 for a type 5 event.  We could check for that
specific condition given the spec calls it out and reject the
injection but perhaps we are better leaving it fully flexible
so we can poke the OS with that invalid state.  Any real
test paths will set it appropriately so the counter is non 0
when we signal the event.

> ---
>  hw/mem/cxl_type3.c          |  9 +++++++++
>  hw/mem/cxl_type3_stubs.c    |  3 +++
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  qapi/cxl.json               | 14 +++++++++++++-
>  4 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 0787a9bfca..410ff445d0 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1813,6 +1813,7 @@ static const QemuUUID memory_module_uuid = {
>  #define CXL_GMER_VALID_RANK                             BIT(1)
>  #define CXL_GMER_VALID_DEVICE                           BIT(2)
>  #define CXL_GMER_VALID_COMPONENT                        BIT(3)
> +#define CXL_GMER_VALID_COMPONENT_ID_FORMAT              BIT(4)
>  
>  static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
>  {
> @@ -1840,6 +1841,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>                                          bool has_rank, uint8_t rank,
>                                          bool has_device, uint32_t device,
>                                          const char *component_id,
> +                                        uint8_t cme_ev_flags,
> +                                        uint32_t cme_count,
> +                                        uint8_t sub_type,
>                                          Error **errp)
>  {
>      Object *obj = object_resolve_path(path, NULL);
> @@ -1898,10 +1902,15 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>          strncpy((char *)gem.component_id, component_id,
>                  sizeof(gem.component_id) - 1);
>          valid_flags |= CXL_GMER_VALID_COMPONENT;
> +        valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
>      }
>  
>      stw_le_p(&gem.validity_flags, valid_flags);
>  
> +    gem.cme_ev_flags = cme_ev_flags;
> +    st24_le_p(gem.cme_count, cme_count);
> +    gem.sub_type = sub_type;
> +
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
>          cxl_event_irq_assert(ct3d);
>      }
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 263d8b4609..b2a11bded8 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -23,6 +23,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>                                          bool has_rank, uint8_t rank,
>                                          bool has_device, uint32_t device,
>                                          const char *component_id,
> +                                        uint8_t cme_ev_flags,
> +                                        uint32_t cme_count,
> +                                        uint8_t sub_type,
>                                          Error **errp) {}
>  
>  void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags,
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 4d9cfdb621..352f9891bd 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -115,10 +115,10 @@ typedef struct CXLEventInterruptPolicy {
>  
>  /*
>   * General Media Event Record
> - * CXL r3.1 Section 8.2.9.2.1.1; Table 8-45
> + * CXL r3.2 Section 8.2.10.2.1.1; Table 8-57
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
> -#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
> +#define CXL_EVENT_GEN_MED_RES_SIZE      0x29
>  typedef struct CXLEventGenMedia {
>      CXLEventRecordHdr hdr;
>      uint64_t phys_addr;
> @@ -130,6 +130,9 @@ typedef struct CXLEventGenMedia {
>      uint8_t rank;
>      uint8_t device[3];
>      uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t cme_ev_flags;
> +    uint8_t cme_count[3];
> +    uint8_t sub_type;
>      uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
>  } QEMU_PACKED CXLEventGenMedia;
>  
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index c38585d3c8..dd01d50c25 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -82,6 +82,16 @@
>  # @component-id: Device specific component identifier for the event.
>  #     May describe a field replaceable sub-component of the device.
>  #
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.
> +#
> +# @cme-count: Corrected memory error count at event.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.
> +#
> +# @sub-type: Memory event sub-type.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.
> +#
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-general-media-event',
> @@ -91,7 +101,9 @@
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> -            '*device': 'uint32', '*component-id': 'str' } }
> +            '*device': 'uint32', '*component-id': 'str',
> +            'cme-ev-flags':'uint8', 'cme-count':'uint32',
> +            'sub-type':'uint8' } }
>  
>  ##
>  # @cxl-inject-dram-event:


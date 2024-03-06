Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7E1361C6
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737582; cv=none; b=iJhejhsBuQgnW1vxsLtHgtt09KrOy9dEjy8n9uYgs0QBlYsTt+1dBQXPBhav7Af5i2vlZQZyY0U+j5twRLG+tiMuQm2crCblOvMipRS7s+z6crvcX2kXvB7zLJ5UnVcKCHJTkoIoTKsia5HGQqD1lMJOHt8Yre42EvnrwpLAxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737582; c=relaxed/simple;
	bh=QmDeWLQmFHasL7HmbVlhNSr0E/x5NJzKk0k9RCYR7vU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnaUFzS3AdPLbyP4kr6a1vcoPCxnAB1c0qROURpaFufBhXuQ6wciNGjh2kVZQsTgxya8CjYI4HDhHiQRPi2xuCrDIVNXukRW5Q15MTYXW15tbXYbCpG6FlChT0l8nyYD5UlX0Q48G0glx6hnkrO2S841rcb/pmWjIw+Q2ia/0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqbHF3SMqz6K64d;
	Wed,  6 Mar 2024 23:01:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 59B4B14206D;
	Wed,  6 Mar 2024 23:06:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 15:06:04 +0000
Date: Wed, 6 Mar 2024 15:06:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH v2] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox
 output payload space zeroing
Message-ID: <20240306150603.0000207e@Huawei.com>
In-Reply-To: <20240221221824.1092966-1-nifan.cxl@gmail.com>
References: <20240221221824.1092966-1-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Feb 2024 14:18:11 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> The whole mailbox output payload space is already zeroed after copying
> out the input payload, which happens before processing the specific mailbox
> command:
> https://elixir.bootlin.com/qemu/v8.2.1/source/hw/cxl/cxl-device-utils.c#L204
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Good point.

I've applied this to my local tree - not rushing on this one.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index e5eb97cb91..fda88470a3 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -226,7 +226,6 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
>      log_type = payload_in[0];
>  
>      pl = (CXLGetEventPayload *)payload_out;
> -    memset(pl, 0, sizeof(*pl));
>  
>      max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
>                  CXL_EVENT_RECORD_SIZE;
> @@ -264,7 +263,6 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
>      CXLEventLog *log;
>  
>      policy = (CXLEventInterruptPolicy *)payload_out;
> -    memset(policy, 0, sizeof(*policy));
>  
>      log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
>      if (log->irq_enabled) {
> @@ -363,7 +361,6 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
>      QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
>  
>      is_identify = (void *)payload_out;
> -    memset(is_identify, 0, sizeof(*is_identify));
>      is_identify->pcie_vid = class->vendor_id;
>      is_identify->pcie_did = class->device_id;
>      if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
> @@ -597,7 +594,6 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
>      QEMU_BUILD_BUG_ON(sizeof(*bg_op_status) != 8);
>  
>      bg_op_status = (void *)payload_out;
> -    memset(bg_op_status, 0, sizeof(*bg_op_status));
>      bg_op_status->status = cci->bg.complete_pct << 1;
>      if (cci->bg.runtime > 0) {
>          bg_op_status->status |= 1U << 0;
> @@ -636,7 +632,6 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>      }
>  
>      fw_info = (void *)payload_out;
> -    memset(fw_info, 0, sizeof(*fw_info));
>  
>      fw_info->slots_supported = 2;
>      fw_info->slot_info = BIT(0) | BIT(3);
> @@ -792,7 +787,6 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>      }
>  
>      id = (void *)payload_out;
> -    memset(id, 0, sizeof(*id));
>  
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
>  
> @@ -1079,7 +1073,6 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
>      out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
>      assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
>  
> -    memset(out, 0, out_pl_len);
>      QLIST_FOREACH(ent, poison_list, node) {
>          uint64_t start, stop;
>  


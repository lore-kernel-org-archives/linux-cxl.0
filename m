Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB425A646
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jan 2025 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977218; cv=none; b=iY+CNkvZU4bdCTQsj8+CFlcAErP6VtCCHoecKK4iv4NIz1II1fKCcc+7OoGFBS+vwjHCwTMHzmBTPFnjPjIwo7bPQ4gMD6GwK4v48ZScQLy8mIdn4SoA/nTJdpAMr5RrxE8+lcuKLGTTyi9KGUhuzEvkHYQXSS4COh8RnDgXR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977218; c=relaxed/simple;
	bh=2LXzBcD3lP1Z45W52QsCqvgm7530RMSofuk22LtNzDk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1fx2IKo/tjOJnvppDMCJJOs+t4epHbwXRCAxkLFVgicsS+ErF88mp0kpLxTHsqKCbOSPwhd8HInTc4AJoS9l0pPlEKMOSEqzZ3yTs3vGqyrggOy1ZOIHBVPvgcHNsxGHCyhr70nv+UQYchlmighTTJXVFU1gNOwPuVtoIx/sNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YhR0C101Rz67FBw;
	Mon, 27 Jan 2025 19:24:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 38C1F1400D9;
	Mon, 27 Jan 2025 19:26:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 27 Jan
 2025 12:26:51 +0100
Date: Mon, 27 Jan 2025 11:26:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <hch@infradead.org>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <20250127112650.00004dd8@huawei.com>
In-Reply-To: <20250124233533.910535-1-dave@stgolabs.net>
References: <20250124233533.910535-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 24 Jan 2025 15:35:33 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add support for GPF flows. It is found that the CXL specification
> around this to be a bit too involved from the driver side. And while
> this should really all handled by the hardware, this patch takes
> things with a grain of salt.
> 
> Upon respective port enumeration, both phase timeouts are set to
> a max of 20 seconds, which is the NMI watchdog default for lockup
> detection. The premise is that the kernel does not have enough
> information to set anything better than a max across the board
> and hope devices finish their GPF flows within the platform energy
> budget.
> 
> Timeout detection is based on dirty Shutdown semantics. The driver
> will mark it as dirty, expecting that the device clear it upon a
> successful GPF event. The admin may consult the device Health and
> check the dirty shutdown counter to see if there was a problem
> with data integrity.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

A few minor things inline.

Only return 0 definitely wants changing, the others are just comments
that you can act on if you want.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b3aac9964e0d..b0a85f411e7d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1054,3 +1054,89 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  
>  	return 0;
>  }
> +
> +/*
> + * Set max timeout such that platforms will optimize GPF flow to avoid
> + * the implied worst-case scenario delays. On a sane platform, all
> + * devices should always complete GPF within the energy budget of
> + * the GPF flow. The kernel does not have enough information to pick
> + * anything better than "maximize timeouts and hope it works".
> + *
> + * A misbehaving device could block forward progress of GPF for all
> + * the other devices, exhausting the energy budget of the platform.
> + * However, the spec seems to assume that moving on from slow to respond
> + * devices is a virtue. It is not possible to know that, in actuality,
> + * the slow to respond device is *the* most critical device in the
> + * system to wait.
> + */
> +#define GPF_TIMEOUT_BASE_MAX 2
> +#define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
> +
> +static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
> +{
> +	u16 ctrl;
> +	int rc, offset, base, scale;
> +
> +	switch (phase) {
> +	case 1:
> +		offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
> +		base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
> +		scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
> +		break;
> +	case 2:
> +		offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
> +		base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
> +		scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rc = pci_read_config_word(pdev, dvsec + offset, &ctrl);
> +	if (rc)
> +		return rc;
> +
> +	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
> +	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
> +		return rc;

return 0; // it is zero anyway, so be explicit that this
          // is a good path.

> +
> +	ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);
> +	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
> +
> +	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
> +	if (!rc)
> +		pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",

It's a bit nasty to assume for this print that the scale is 10 seconds
but allow the base to vary.

> +			phase, GPF_TIMEOUT_BASE_MAX);
> +
> +	return rc;
> +}

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..17baced54b3b 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -693,6 +693,10 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +struct cxl_mbox_set_shutdown_state_in {
Spec reference maybe to keep inline with other similar structures?

> +	u8 state;
> +} __packed;
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -829,6 +833,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
> +int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,


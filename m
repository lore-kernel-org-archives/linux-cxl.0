Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86691518125
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028007; cv=none; b=LereGHDaAEPnFZesH0Wn4YKxFk+c1q/xPcR3KajH6bQ2HvC/jPP1saBgOiUSC5BLb2QdW7CO2VqeTj4vFgdbiXjEmabrriWULQFF6ZE7UrFZyFL5HaDsL4n958aklfPexERIV8WRLfPBYAsiZklRQiBpDiNgPvvjeMWjeMQVBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028007; c=relaxed/simple;
	bh=vasWoqqcBUlw0u6i34av8d3MrdwtjMYbfhLeYGjnDGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHq0L99R/haDaAA6ycfJuYj1MmV9xtUNTCgGHRIceCG6CLsWZbzHnwpULhqnaUcxeyKwXCbCvlb61xIgTXMb/LCvXvqpBRcOYuqMqgq3fsrAH2QGgKe9ANc1OkJBJPtYe20Yx9+QHF7w3puVpSkB2g1Mf+DLEoMmGoD7j0Bd/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcIHVafD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcIHVafD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790028006; x=1821564006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vasWoqqcBUlw0u6i34av8d3MrdwtjMYbfhLeYGjnDGU=;
  b=kcIHVafDSw/GxhYG6VLEnybp9HZ8HsfcVAQP81e0qyXJP44LyGBa2EqE
   GI7qpbF4YrTqSufEDky7N1uhb5R9a+Gw/E3Yr6s9XZWBOO5YEbf/gAbY8
   tf25QeoNRswHhOoy6YKzAXL/1+3cj/u9xfCuIQbpUkK3J9KywiFj59b28
   gZ+PtNkrVRoZ9izXOvaZmYmPf+4TUqHlGdbuNNDf6KLfGi0FMyoTj9rMR
   7EV7Li9FVwecjJzneO9wpHJT9ghCQwCFHgGhURN6s1Ym9fHBG/wvRm/m2
   VCQCafA1uY7/FLTItVJBgi0z4gSZQqngjwqiP2z1OfPQfzw+xpUvntEhH
   A==;
X-CSE-ConnectionGUID: bP3HSu1JQYKKpG27sJfZRw==
X-CSE-MsgGUID: we5YKR+gTVOC0sE4UkBCew==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116106846"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="116106846"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 15:00:05 -0700
X-CSE-ConnectionGUID: GY2aQrBvTAW0LJwFr6HU3Q==
X-CSE-MsgGUID: BhrkFVJZRjyJXc/UaM4kVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="299087693"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.234]) ([10.125.109.234])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 15:00:02 -0700
Message-ID: <da6deab0-de16-43ea-bd13-5861f84a587b@intel.com>
Date: Mon, 21 Sep 2026 15:00:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 6/8] cxl/mem: Configure dynamic capacity interrupts
To: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
 Gregory Price <gourry@gourry.net>, Richard Cheng <icheng@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>, Ira Weiny <iweiny@kernel.org>,
 Anisa Su <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>,
 Junhee Park <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-7-anisa.su@samsung.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260918203049.7273-7-anisa.su@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/26 1:30 PM, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism. The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications. Firmware can't
> configure DCD events to be FW controlled but can retain control of
> memory events.
> 
> Configure DCD event log interrupts on devices supporting dynamic
> capacity. Disable DCD if interrupts are not supported.
> 
> The DCD event log is not drained here. cxl_event_drain_mask() reports
> only the logs the driver can service, and the DCD bit is added by
> the patch introducing DCD event handling. Until then a DCD interrupt
> wakes the event thread, which finds no log it owns and returns.
> 
> Care is taken to preserve the interrupt policy set by the FW if FW first
> has been selected by the BIOS.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Co-developed-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> ---
> Changes:
> 
> 1. [jonathan]: get rid of CXL_EVENT_STATUS_ALL and instead opt into
>    event logs we want to read individually in cxl_event_drain_mask. This
>    makes which logs the driver drains explicit if new logs are added in
>    the future. The cxl_test mock names the same four logs for its
>    probe-time drain.
> 2. pci.c: when BIOS owns the memory event logs and a short interrupt
>    policy has just disabled DCD, return before Set Event Interrupt
>    Policy and the event buffer allocation. Nothing is left to configure,
>    and the Set would only have echoed firmware's own settings back.
> ---
>  drivers/cxl/cxl.h            |   6 +-
>  drivers/cxl/cxlmem.h         |   2 +
>  drivers/cxl/pci.c            | 127 +++++++++++++++++++++++++++++------
>  tools/testing/cxl/test/mem.c |   5 +-
>  4 files changed, 114 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cab8ce39f465..1add114bc178 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -192,11 +192,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
>  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
>  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> -
> -#define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
> -				 CXLDEV_EVENT_STATUS_WARN |	\
> -				 CXLDEV_EVENT_STATUS_FAIL |	\
> -				 CXLDEV_EVENT_STATUS_FATAL)
> +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
>  
>  /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
>  #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9fd5af2e41d4..9106affd7c81 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -240,7 +240,9 @@ struct cxl_event_interrupt_policy {
>  	u8 warn_settings;
>  	u8 failure_settings;
>  	u8 fatal_settings;
> +	u8 dcd_settings;
>  } __packed;
> +#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
>  
>  /**
>   * struct cxl_event_state - Event log driver state
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7b754af2168d..fee3a704b73b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -510,11 +510,23 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  	return true;
>  }
>  
> +/* Event logs the driver drains: standard logs when native_cxl */
> +static u32 cxl_event_drain_mask(struct pci_host_bridge *host_bridge)
> +{
> +	if (host_bridge->native_cxl_error)
> +		return CXLDEV_EVENT_STATUS_INFO | CXLDEV_EVENT_STATUS_WARN |
> +		       CXLDEV_EVENT_STATUS_FAIL | CXLDEV_EVENT_STATUS_FATAL;
> +	return 0;
> +}
> +
>  static irqreturn_t cxl_event_thread(int irq, void *id)
>  {
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct pci_host_bridge *host_bridge =
> +		pci_find_host_bridge(to_pci_dev(cxlds->dev)->bus);
> +	u32 mask = cxl_event_drain_mask(host_bridge);
>  	u32 status;
>  
>  	do {
> @@ -523,8 +535,8 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  		 * ignore the reserved upper 32 bits
>  		 */
>  		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> -		/* Ignore logs unknown to the driver */
> -		status &= CXLDEV_EVENT_STATUS_ALL;
> +		/* Ignore logs unknown to the driver or owned by BIOS */
> +		status &= mask;
>  		if (!status)
>  			break;
>  		cxl_mem_get_event_records(mds, status);
> @@ -551,42 +563,62 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>  }
>  
>  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> -				    struct cxl_event_interrupt_policy *policy)
> +				    struct cxl_event_interrupt_policy *policy,
> +				    size_t *policy_size)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd = {
>  		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
>  		.payload_out = policy,
>  		.size_out = sizeof(*policy),
> +		/* CXL 2.0 firmware omits dcd_settings; accept the shorter reply */
> +		.min_out = CXL_EVENT_INT_POLICY_BASE_SIZE,
>  	};
>  	int rc;
>  
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> -	if (rc < 0)
> +	if (rc < 0) {
>  		dev_err(mds->cxlds.dev,
>  			"Failed to get event interrupt policy : %d", rc);
> +		return rc;
> +	}
>  
> +	if (policy_size)
> +		*policy_size = mbox_cmd.size_out;
>  	return rc;
>  }
>  
>  static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> -				    struct cxl_event_interrupt_policy *policy)
> +				    struct cxl_event_interrupt_policy *policy,
> +				    bool native_cxl, size_t policy_size)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> -	*policy = (struct cxl_event_interrupt_policy) {
> -		.info_settings = CXL_INT_MSI_MSIX,
> -		.warn_settings = CXL_INT_MSI_MSIX,
> -		.failure_settings = CXL_INT_MSI_MSIX,
> -		.fatal_settings = CXL_INT_MSI_MSIX,
> -	};
> +	/* memory event policy is left if FW has control */
> +	if (native_cxl) {
> +		*policy = (struct cxl_event_interrupt_policy) {
> +			.info_settings = CXL_INT_MSI_MSIX,
> +			.warn_settings = CXL_INT_MSI_MSIX,
> +			.failure_settings = CXL_INT_MSI_MSIX,
> +			.fatal_settings = CXL_INT_MSI_MSIX,
> +			.dcd_settings = 0,
> +		};
> +	}
> +
> +	/*
> +	 * A CXL 3.0+ device can carry dcd_settings field without DCD command
> +	 * support, so size the request by the device's policy_size and only
> +	 * enable the DCD interrupt when DCD commands are supported.
> +	 */
> +	if (cxl_dcd_supported(mds))
> +		policy->dcd_settings = CXL_INT_MSI_MSIX;
>  
>  	mbox_cmd = (struct cxl_mbox_cmd) {
>  		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
>  		.payload_in = policy,
> -		.size_in = sizeof(*policy),
> +		.size_in = policy_size,
>  	};
>  
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> @@ -597,7 +629,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  	}
>  
>  	/* Retrieve final interrupt settings */
> -	return cxl_event_get_int_policy(mds, policy);
> +	return cxl_event_get_int_policy(mds, policy, NULL);
>  }
>  
>  static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
> @@ -633,6 +665,30 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
>  	return 0;
>  }
>  
> +static int cxl_irqsetup(struct cxl_memdev_state *mds,
> +			struct cxl_event_interrupt_policy *policy,
> +			bool native_cxl)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	int rc;
> +
> +	if (native_cxl) {
> +		rc = cxl_event_irqsetup(mds, policy);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (cxl_dcd_supported(mds)) {
> +		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
> +		if (rc) {
> +			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
> +			cxl_disable_dcd(mds);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static bool cxl_event_int_is_fw(u8 setting)
>  {
>  	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
> @@ -651,32 +707,57 @@ static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> -	struct cxl_event_interrupt_policy policy;
> +	struct cxl_event_interrupt_policy policy = { 0 };
> +	bool native_cxl = host_bridge->native_cxl_error;
> +	size_t policy_size;
> +	u32 mask;
>  	int rc;
>  
>  	/*
>  	 * When BIOS maintains CXL error reporting control, it will process
>  	 * event records.  Only one agent can do so.
> +	 *
> +	 * If BIOS has control of events and DCD is not supported skip event
> +	 * configuration.
>  	 */
> -	if (!host_bridge->native_cxl_error)
> +	if (!native_cxl && !cxl_dcd_supported(mds))
>  		return 0;
>  
>  	if (!irq_avail) {
>  		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
> +		if (cxl_dcd_supported(mds)) {
> +			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
> +			cxl_disable_dcd(mds);
> +		}
>  		return 0;
>  	}
>  
> -	rc = cxl_event_get_int_policy(mds, &policy);
> +	rc = cxl_event_get_int_policy(mds, &policy, &policy_size);
>  	if (rc)
>  		return rc;
>  
> -	if (cxl_event_fw_owns_mem_logs(&policy)) {
> +	/*
> +	 * dcd_settings cannot be sent to a device whose policy is too short
> +	 * to hold it, so the device would never accept the setting
> +	 * cxl_irqsetup() arms the DCD interrupt with.
> +	 */
> +	if (cxl_dcd_supported(mds) && policy_size < sizeof(policy)) {
> +		dev_warn(mds->cxlds.dev,
> +			 "DCD supported but interrupt policy is only %zu bytes\n",
> +			 policy_size);
> +		cxl_disable_dcd(mds);
> +		/* DCD was the only reason to be here */
> +		if (!native_cxl)
> +			return 0;
> +	}
> +
> +	if (native_cxl && cxl_event_fw_owns_mem_logs(&policy)) {
>  		dev_err(mds->cxlds.dev,
>  			"FW still in control of Event Logs despite _OSC settings\n");
>  		return -EBUSY;
>  	}
>  
> -	rc = cxl_event_config_msgnums(mds, &policy);
> +	rc = cxl_event_config_msgnums(mds, &policy, native_cxl, policy_size);
>  	if (rc)
>  		return rc;
>  
> @@ -684,11 +765,17 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_event_irqsetup(mds, &policy);
> +	rc = cxl_irqsetup(mds, &policy, native_cxl);
>  	if (rc)
>  		return rc;
>  
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	mask = cxl_event_drain_mask(host_bridge);
> +	if (mask)
> +		cxl_mem_get_event_records(mds, mask);
> +
> +	dev_dbg(mds->cxlds.dev, "Event config : %s DCD %s\n",
> +		native_cxl ? "OS" : "BIOS",
> +		cxl_dcd_supported(mds) ? "supported" : "not supported");
>  
>  	return 0;
>  }
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 7b756000a1a6..6ef47265da10 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1818,7 +1818,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		dev_dbg(dev, "No CXL FWCTL setup\n");
>  
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_INFO |
> +				       CXLDEV_EVENT_STATUS_WARN |
> +				       CXLDEV_EVENT_STATUS_FAIL |
> +				       CXLDEV_EVENT_STATUS_FATAL);

Second time I'm seeing this constructed mask being used in this commit. Maybe create a define for it?

s/CXLDEV_EVENT_STATUS_ALL/CXLDEV_EVENT_STATUS_BASE/ perhaps?

>  	cxl_mock_test_feat_init(mdata);
>  
>  	return 0;


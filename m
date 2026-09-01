Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18ED4A0EEF
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290271; cv=fail; b=IJ3HtTDErFJmX3FQYiUnNuV302A+p3uOpmzp6iWXoy7tBr4MH2lr7bRdukdDeTTAqprzOixZ9K6IaPwVN6O6MscrwRFYHX6zATgrCHKnW4bC8IMZfrzsyPh9g3iw+QGo2/ualLYNTi8bZL4ANb/turpgrwGXGXujWLgDSvn1qWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290271; c=relaxed/simple;
	bh=aaMKOKPmdjGxD24JseccBR/uCOoR37+FgrQSbaD3iYM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=HREospJKOvRWMTCIDQH7OjmNQiF3TYEusbT3Hk2yJYYltnsjglXnf5JY9XDo/uP9AmOiiI73qbm1GxWt3hNSfDEKjfpju8rk2t0woX90HASegnYSTpE0QUDgyf6wx1kB/Oznlq7O+KdqRp8DaMoSLKNw1ASyqynBeTS7Bu6PxuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mF68Hk5C; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mF68Hk5C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN9Fi41kCdGuZOxg0jIMZhr033WX8JFHBgbgcxSQJmGn0XBUoRp+wJmG1GfyYy8vaAW09IYdox1w7meid8aYyLR1IyKbie5IO+qA/tkT9q0nv44eDymGoVg3kkTPt0ajyfUindWpRJseRpQBBFPzzKjFP2LZI6PjIfICp9OEmWnDu6utvIejDE+A3b8IOSc2qOWHZD0T07/Znz9vNLagv79dH7Z6VZ+ANRPLg2NCjMzWzHQztVL52xlzFxlMP2K+xd1h6aoeJjua++ZvcFeRnrZg2XBVYK9EBg3qZPL+Ac+p0Uv/5OEv6/zrbHK6pGM294RZkt7+2laVJftTv0hlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aev6bLQ9ho+BXZYfptGjoxfddDd3tpamxOEUgeOzJH8=;
 b=O4UsGrU/zpplzweUrBJNAvKdAxiA0nL3WhNq/Zi3o5U62GBfvAD6bgl45ytUHK15VweD5jNZIybSRWnEusyTPTilTrAJ31AQ6L5A8jhnUu6U4/cWtNkOonijh4YyoWPCAW5pk9Cre2NN2IGeAoXhlPVzi/xhPkfl73qdCcuFdEjc0dGK14Syr2ocrHFM2BPbutCApRtxv6zfgTtQAtZYaDLMzITrtk3pr02XjO4qzzR96myIk96jDHduI2aWke8JsyYLw5kqdGh2s0b/ex3lbnFDhqlhARIgdqrpXWeLff38dd4F0TiHsxYPPBb7iMql93dua208/nOxaLVE/xnzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aev6bLQ9ho+BXZYfptGjoxfddDd3tpamxOEUgeOzJH8=;
 b=mF68Hk5CnUqebb4nfamrSLOZx2CLgk2zgtuGSXq5+0NIkU36xf3EEkxF334+vRIhw/S0T6bwKEhWBoerQhyyICrSDVknYAFM2WFQPB5HyI3klGpUEvjBepbNH6qmN6i4nahz+uCxyaDmDr27nm9+kzpCV7pv1ej59sJpqOzGkVw=
Received: from SJ0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:33b::26)
 by CY1PR12MB9581.namprd12.prod.outlook.com (2603:10b6:930:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:17:43 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::73) by SJ0PR05CA0021.outlook.office365.com
 (2603:10b6:a03:33b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:17:42 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 14:17:41 -0500
Message-ID: <ca465e01-4081-48a8-b83d-21a1bc52e6ee@amd.com>
Date: Tue, 1 Sep 2026 14:17:41 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v2 1/4] cxl/events: Bound get records loop in
 cxl_event_thread()
To: Anisa Su <anisa.su887@gmail.com>, <linux-cxl@vger.kernel.org>
References: <20260901002912.958-1-anisa.su@samsung.com>
 <20260901002912.958-2-anisa.su@samsung.com>
Content-Language: en-US
In-Reply-To: <20260901002912.958-2-anisa.su@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CY1PR12MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 96dff1f1-9552-4b78-de62-08df085db253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|6133799003|3023799007|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	W6ZQ2NvjYm6D91OEHLMwM/b1sEJV7hkcNvhhRlvaAbE4waX/r9DlVk3V/2EhLLTaYUnKHwquktwzoP8gHOm4W/ugEcnTTxzw1FWNmvWQ6dvvDWv0TkmaW0jqj2IqC9VGw04GE2PA7SmqGfOGQtw2VWL4L77XEkNNh4ma4uabdsn7cTqVZBDY3gDF7t4n3Cfj72WYIsQIFdvuIWa2w3A7K0d1hzrKireQXMCHAkXaSj97BTm4aVwf6EI4GRpbsNiwFlKA0ma91eKWgM1tyIYmpFVavnP8XSo1WHy9dKP/41UJwT/rB8bl4krskACwA5U+zlPJVX2cUG1HAwFklURetB84jzOaY1brlIE4HTRFkTRw45JUpEz8IPmjUnhY3NpN8goMcDksbvZJy4K12+0001z2J/zfjvT56870bX1+Kn7Ochhdxib/Xu8esrJQi0+7jKbH15YRjP7cRpwjO7CaR1fV/5tVsassy07OZaIvn/mGbYzbfzvh/2guSDiq5g8JsNPzNBpxOanboQp39O6Jq4y7z0yusQgglQSbpJt7gD9tnuhN/2bB2SG0/mNnRIGjkqpF4vsgf6pjEHx4jCY20BaZ2NDGi+kuXRQLO/6icb/Q3OZ+Mv812M/VUuJ48oFi87awEZX3TpRfpv1Rvv6DyvhoH5vDpCQ0rJsOS7Bgc0aSIVfZNCPVLhWA2iObEQxBZuM+m3rJ2rEGpPjp+ZcybA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AEcr945GZuuLiyQ/4nqmCwcSQ5/C5Y0y0lousf8zrVZ2HJCEv7Lm1Mepr2gj+3PU8OR3lzEB5iSc2Zk/1bUMTiLj3fpB++m9La8ONUBU35fSqMnufKXcHFsoui39T0qmaP0Nw0eEo1hDtUaGKeOtHslyWp1eIxzfvZuH4RaDf2YJRZefKY2A3/CUNa8g/R0MYZrofmt+OG5jaTkCFhz9EleioU1ql0dxgzM7xYBxQxrez0eGmiTJYnqu7jabZJTAx8Xo6sRC0wV0oGwWBZTO05IZmg2rc7uKJSfYAwrVzVzfMoMZkY2kSNZhyqWJskt2RdMphB/GoCkkY+ambLXHLkrqFyW2LdRbaKSSkjFqAZ6SgTjZzd7euPxPQXpELxfJqs1kRF5PK2mz2YCIJ3ybvW8hXaSgWsD9zRAzIhH3/siIoVmo3AZRUwNJhoQXAwuI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:17:42.5436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dff1f1-9552-4b78-de62-08df085db253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9581

On 8/31/2026 7:26 PM, Anisa Su wrote:
> cxl_event_thread() drains all logs named in the Event Status register and
> repeats until the register reads zero. CXL r4.0 Section 8.2.9.3.1 Table 8-203
> marks the register RO and leaves clearing it to the device, so a misbehaving
> device that leaves a status bit set spins the thread forever, resending
> Get Event Records as fast as the mailbox completes.
> 
> Bound the loop on work completed instead. cxl_mem_get_records_log() and
> cxl_mem_get_event_records() report failures and which logs returned
> records; the thread drops any log whose status bit was set while it
> returned nothing, and caps consecutive errors at CXL_EVENT_DRAIN_ATTEMPTS.
> Every pass either drains a record, clears a bit from the mask or spends an
> attempt, so the loop eventually terminates, even if the device misbehaves.
> The first error is returned and an error from one log does not prevent
> getting logs from the rest.
> 
> Retrying is limited to the failures that can plausibly be cleared:
> -EBUSY and -ETIMEDOUT from the mailbox, and Retry Required from the
> device. Anything else gives up on the first error, so cycles are not wasted
> retrying on a non-retryable error.
> 
> Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> 
> ---
> Changes:
> [Richard Cheng]: retry on transient failures
> ---
>  drivers/cxl/core/mbox.c      | 74 +++++++++++++++++++++++++++++-------
>  drivers/cxl/cxlmem.h         |  3 +-
>  drivers/cxl/pci.c            | 63 ++++++++++++++++++++++++++----
>  tools/testing/cxl/test/mem.c |  4 +-
>  4 files changed, 120 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..2b71a8e1f35f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -988,6 +988,18 @@ static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
>  }
>  
> +/*
> + * cxl_mbox_cmd_rc2errno() collapses every device return code onto -ENXIO;
> + * pick out the one the spec asks the caller to retry.
> + */
> +static int cxl_event_retry_rc(struct cxl_mbox_cmd *mbox_cmd, int rc)
> +{
> +	if (rc == -ENXIO && mbox_cmd->return_code == CXL_MBOX_CMD_RC_RETRY)
> +		return -EAGAIN;
> +
> +	return rc;
> +}

I think it's more valuable to update cxl_mbox_cmd_rc2errno() to return -EAGAIN for that
mailbox code. It's a smaller change and is more reusable.

> +
>  static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  				  enum cxl_event_log_type log,
>  				  struct cxl_get_event_payload *get_pl)
> @@ -1056,11 +1068,11 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  
>  free_pl:
>  	kvfree(payload);
> -	return rc;
> +	return cxl_event_retry_rc(&mbox_cmd, rc);
>  }
>  
> -static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> -				    enum cxl_event_log_type type)
> +static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> +				   enum cxl_event_log_type type, bool *got_records)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> @@ -1068,12 +1080,15 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  	struct cxl_get_event_payload *payload;
>  	u8 log_type = type;
>  	u16 nr_rec;
> +	int rc = 0;
> +
> +	*got_records = false;
>  
>  	mutex_lock(&mds->event.log_lock);

I was looking at patch 3/4 when I realized you can convert this to a guard() and then
return instead of using break statements below. Would be nice as a clean up, but not necessary.

>  	payload = mds->event.buf;
>  
>  	do {
> -		int rc, i;
> +		int i;
>  		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
>  			.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
>  			.payload_in = &log_type,
> @@ -1085,6 +1100,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  
>  		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  		if (rc) {
> +			rc = cxl_event_retry_rc(&mbox_cmd, rc);
>  			dev_err_ratelimited(dev,
>  				"Event log '%d': Failed to query event records : %d",
>  				type, rc);
> @@ -1094,6 +1110,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		nr_rec = le16_to_cpu(payload->record_count);
>  		if (!nr_rec)
>  			break;
> +		*got_records = true;
>  
>  		for (i = 0; i < nr_rec; i++)
>  			__cxl_event_trace_record(cxlmd, type,
> @@ -1112,31 +1129,60 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  	} while (nr_rec);
>  
>  	mutex_unlock(&mds->event.log_lock);
> +
> +	return rc;
>  }
>  
>  /**
>   * cxl_mem_get_event_records - Get Event Records from the device
>   * @mds: The driver data for the operation
>   * @status: Event Status register value identifying which events are available.
> + * @drained: Optional mask of the logs in @status that returned records.
>   *
>   * Retrieve all event records available on the device, report them as trace
> - * events, and clear them.
> + * events, and clear them.  Every log named in @status is drained even if
> + * another one fails, so that a broken log does not suppress reporting from
> + * the rest.
> + *
> + * Return: 0, or the first error encountered.  -EAGAIN if the device asked for
> + * a command to be retried.
>   *
>   * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
>   * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
>   */
> -void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
> +int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
> +			      u32 *drained)
>  {
> +	static const struct {
> +		u32 status;
> +		enum cxl_event_log_type type;
> +	} logs[] = {
> +		{ CXLDEV_EVENT_STATUS_FATAL, CXL_EVENT_TYPE_FATAL },
> +		{ CXLDEV_EVENT_STATUS_FAIL, CXL_EVENT_TYPE_FAIL },
> +		{ CXLDEV_EVENT_STATUS_WARN, CXL_EVENT_TYPE_WARN },
> +		{ CXLDEV_EVENT_STATUS_INFO, CXL_EVENT_TYPE_INFO },
> +	};
> +	int ret = 0;
> +
>  	dev_dbg(mds->cxlds.dev, "Reading event logs: %x\n", status);
>  
> -	if (status & CXLDEV_EVENT_STATUS_FATAL)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FATAL);
> -	if (status & CXLDEV_EVENT_STATUS_FAIL)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FAIL);
> -	if (status & CXLDEV_EVENT_STATUS_WARN)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
> -	if (status & CXLDEV_EVENT_STATUS_INFO)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
> +	if (drained)
> +		*drained = 0;
> +
> +	for (int i = 0; i < ARRAY_SIZE(logs); i++) {
> +		bool got_records;
> +		int rc;
> +
> +		if (!(status & logs[i].status))
> +			continue;
> +
> +		rc = cxl_mem_get_records_log(mds, logs[i].type, &got_records);
> +		if (got_records && drained)
> +			*drained |= logs[i].status;
> +		ret = ret ?: rc;
> +	}
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ed419d0c59f2..cb5372eb2d85 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -803,7 +803,8 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
> -void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> +int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
> +			      u32 *drained);
>  void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 267c679b0b3c..239df18c9c87 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -509,26 +509,75 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  	return true;
>  }
>  
> +#define CXL_EVENT_DRAIN_ATTEMPTS 3
> +
> +/*
> + * -EAGAIN is the device asking for a retry, the rest are the mailbox being
> + * momentarily unavailable.  Everything else is permanent as far as this can
> + * tell.
> + */
> +static bool cxl_event_drain_retryable(int rc)
> +{
> +	return rc == -EAGAIN || rc == -EBUSY || rc == -ETIMEDOUT;
> +}
> +
>  static irqreturn_t cxl_event_thread(int irq, void *id)
>  {
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	u32 status;
> +	u32 mask = CXLDEV_EVENT_STATUS_ALL;
> +	int attempts = CXL_EVENT_DRAIN_ATTEMPTS;
> +
> +	while (mask) {
> +		u32 status, drained, stuck;
> +		int rc;

I'd put these declarations at the top of the function, there's not a reason to put them
here AFAICT.

>  
> -	do {
>  		/*
>  		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
>  		 * ignore the reserved upper 32 bits
>  		 */
>  		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> -		/* Ignore logs unknown to the driver */
> -		status &= CXLDEV_EVENT_STATUS_ALL;
> +		/* Ignore logs unknown to the driver, and logs given up on */
> +		status &= mask;
>  		if (!status)
>  			break;
> -		cxl_mem_get_event_records(mds, status);
> +
> +		rc = cxl_mem_get_event_records(mds, status, &drained);
> +		if (rc) {
> +			if (!cxl_event_drain_retryable(rc)) {
> +				dev_warn(cxlds->dev,
> +					 "Event log drain failed: %d\n", rc);
> +				break;
> +			}
> +			if (--attempts) {
> +				fsleep(1000);
> +				continue;
> +			}
> +			dev_warn(cxlds->dev,
> +				 "Event log drain gave up after %d attempts: %d\n",
> +				 CXL_EVENT_DRAIN_ATTEMPTS, rc);
> +			break;
> +		}
> +		/* Progress was made, so reset number of attempts */
> +		attempts = CXL_EVENT_DRAIN_ATTEMPTS;
> +
> +		/*
> +		 * The Event Status register is device owned and read only, so
> +		 * it cannot bound this loop; records read can.  A device that
> +		 * leaves a bit set with an empty log makes no progress, and
> +		 * only the device can clear that state, so stop polling that
> +		 * log rather than spin on it.
> +		 */
> +		stuck = status & ~drained;
> +		if (stuck) {
> +			dev_warn_once(cxlds->dev,
> +				      "Event status %#x set with no records to read\n",
> +				      stuck);

It may be good to make this an error print instead of warn. This only happens if something on the
device is broken and needs to be fixed, so it may be good to make it hard to miss.

After thinking about what Li said in the other thread, would it be appropriate to just error out here
instead of skipping the record type? My thinking here is it would increase the pressure on the device
vendor to fix their device/firmware instead of the kernel allowing a broken device. Of course that
comes with the downside of the remaining records not being read, but they aren't read anyway at the
moment.

> +			mask &= ~stuck;
> +		}
>  		cond_resched();
> -	} while (status);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -682,7 +731,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
>  
>  	return 0;
>  }
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index a7da279aa3ef..87e01612cea9 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -372,7 +372,7 @@ static void cxl_mock_event_trigger(struct device *dev)
>  			event_reset_log(log);
>  	}
>  
> -	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
> +	cxl_mem_get_event_records(mdata->mds, mes->ev_status, NULL);
>  }
>  
>  struct cxl_event_record_raw maint_needed = {
> @@ -1805,7 +1805,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		dev_dbg(dev, "No CXL FWCTL setup\n");
>  
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
>  	cxl_mock_test_feat_init(mdata);
>  
>  	return 0;


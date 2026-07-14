Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B304DA551
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047944; cv=none; b=NMmDywAJSidhTGFxwQOCcCM3d0Xzp8Hy55wTjV0/VwerK3WQKhIo0nRVC6Ylclll4b/IVXm8LhcZipl8u1ab1H0woVL7DhTrSH/4/rKhbKSNN6USbeOUnJzCtIRkXl+JE4C040NE958QlVyUa61HMQmcWhuyHi6O+N8f63drtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047944; c=relaxed/simple;
	bh=OLH9+tXGBV8HboO7VvrLAxUaYuRyFxvgeguIaHfnNGE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lOGMRznnge8zS9so8D1Tvi2TQTeakBk1xDEVRO/S22H3KmKjkjfTA0W8oyVcbpY/JHCXheVK6Ru3Swr0JIlCXiVyy8z+M4f6GxbDJcOXrbIx5QJq/obJDv351zASy2aDMPbvbMEugakV2f4Lw/cqPLII3UeAe9ey4mcM59gda+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2uDtnzP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2uDtnzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784047943; x=1815583943;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=OLH9+tXGBV8HboO7VvrLAxUaYuRyFxvgeguIaHfnNGE=;
  b=I2uDtnzPHaaOYvHQ+9Fmli9MXhj9n5mj3CtnlYMFQNGeOfpPrn/tr9nQ
   tDsJsQ/TVmsozCwc7+kEcLkhAzyr54/u+6DeWJDycLM5N5WfN4qlPi+54
   CiVPnjZ7uzS1RYOiy7RiFzyJExh513g67YXytCEZHuXOHZ0sdFQsph1Ll
   jBk62XRl6uMSMp03LapQ/UDPRlsngBPGpxLnZsbkvk5U0XYnFuh1S2pl1
   zdmiFVQ1lmn+n8nnnwOTW5jJ/tGhoMyaqhZ4WXF7kBOBzNcWDhr0x/93F
   3XrNUoXa+zia3Xv3Rsz448ZcysKjwdOhY3w+Z+46gb8jIvvLoSMnmG1Ul
   A==;
X-CSE-ConnectionGUID: RZKxzM73RlGzjmYvE8dUuQ==
X-CSE-MsgGUID: Qj9lLqYQT8edNmzB/SRxsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95822134"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95822134"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:52:22 -0700
X-CSE-ConnectionGUID: LplNOaN/TKyB8lk5OafNwQ==
X-CSE-MsgGUID: dmblQdpHRRim16/eXnA8pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="255412625"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:52:22 -0700
Message-ID: <463f5e4a-1631-4382-9aca-b57d7e0999b2@intel.com>
Date: Tue, 14 Jul 2026 09:52:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/features: Serialize multi-part Get/Set Feature
 transfers
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20260709155841.1895915-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260709155841.1895915-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 8:58 AM, Dave Jiang wrote:
> A Get or Set Feature payload larger than the mailbox payload size is
> split into several mailbox commands. mbox_mutex only serializes
> individual mailbox commands and is dropped between iterations of these
> loops. Nothing serializes the multi-part transfer as a whole.
> cxl_get_feature() and cxl_set_feature() are reachable concurrently
> from fwctl (per-fd RPCs run under a read-held registration lock) and
> from the EDAC scrub/ECS/repair paths, so two transfers to the same
> mailbox can interleave their parts and corrupt the device's transfer
> context.
> 
> Add a per-mailbox feat_mutex and hold it across the whole transfer in
> both functions. It nests outside mbox_mutex (which is taken inside
> cxl_internal_send_cmd()), and is taken nowhere else, so no lock-ordering
> inversion is introduced.
> 
> Link: https://sashiko.dev/#/patchset/20260702090849.47501-1-icheng@nvidia.com?part=1
> Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
> Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
77b814c1832f

> ---
>  drivers/cxl/core/features.c | 3 +++
>  drivers/cxl/core/mbox.c     | 1 +
>  include/cxl/mailbox.h       | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 85185af46b72..85d6bcdc360e 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -240,6 +240,8 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  	size_out = min(feat_out_size, cxl_mbox->payload_size);
>  	uuid_copy(&pi.uuid, feat_uuid);
>  	pi.selection = selection;
> +
> +	guard(mutex)(&cxl_mbox->feat_mutex);
>  	do {
>  		data_to_rd_size = min(feat_out_size - data_rcvd_size,
>  				      cxl_mbox->payload_size);
> @@ -314,6 +316,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  		data_in_size = cxl_mbox->payload_size - hdr_size;
>  	}
>  
> +	guard(mutex)(&cxl_mbox->feat_mutex);
>  	do {
>  		int rc;
>  
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..0370ac39ec4a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1516,6 +1516,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  
>  	cxl_mbox->host = host;
>  	mutex_init(&cxl_mbox->mbox_mutex);
> +	mutex_init(&cxl_mbox->feat_mutex);
>  	rcuwait_init(&cxl_mbox->mbox_wait);
>  
>  	return 0;
> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> index c4e99e2e3a9d..d008b9db07aa 100644
> --- a/include/cxl/mailbox.h
> +++ b/include/cxl/mailbox.h
> @@ -50,6 +50,7 @@ struct cxl_mbox_cmd {
>   * @payload_size: Size of space for payload
>   *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
>   * @mbox_mutex: mutex protects device mailbox and firmware
> + * @feat_mutex: serializes multi-part Get/Set Feature transfers
>   * @mbox_wait: rcuwait for mailbox
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   * @feat_cap: Features capability
> @@ -60,6 +61,7 @@ struct cxl_mailbox {
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	size_t payload_size;
>  	struct mutex mbox_mutex; /* lock to protect mailbox context */
> +	struct mutex feat_mutex;
>  	struct rcuwait mbox_wait;
>  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
>  	enum cxl_features_capability feat_cap;
> 
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3A40855
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962913; cv=none; b=LeG6rZYZAQA5q4F45dsG2RtIUvp/ZrcWyBmtSJr218uXdUxHwlMyAmIn1CtPLBN3zYkFx/VF6qm+EvExnA94UbceOQ8Ki+e9GMYHb6axb2Fs3kMcSgnqt3mjAJvH7BdjVahxLyGpnUGtTOpjU3OszQEtiOjyoXm0iKJY4554ncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962913; c=relaxed/simple;
	bh=Rz2xWiwYqNaTvy1ZwUwdxx7/JD02Xd1BckGLDyvc9GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJl6N1y0svVDap25uZv0UJvg3WZ+mlpQaiitUHuhg1RN+YPNEmhIznFl9UQSNXFaD7BhQLOtHx7ugoRXp2JAf0HUuv/rlnUkwQDtY1zSuZHoCZI5JieWCUutKXqU98Xna6+AkhHs4ecKLMMprLktz6MSluBNCmXMYG0FWFH50Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnkzkJW0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnkzkJW0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783962910; x=1815498910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rz2xWiwYqNaTvy1ZwUwdxx7/JD02Xd1BckGLDyvc9GU=;
  b=lnkzkJW0Oo9q2Tvc4nyJbZ8noHITedNz+R62X0ttHyXH3FM8bBjVNgv1
   9dmXxJHGak1QlrO5R0+ITtCQbS+AmWk0c28H93K8edJ2YZjxs7oVpa8o8
   hNnWb3vqhS6IGgbu5iX94jgpkkDdbOF7iPe95Hyhkef4My9DQP3skd1fk
   DwvE6kP6PIULgrLEP50pV2Gpkt0GYNF/Qt3N0Pko9eU9Y+grdi3eOTE9+
   +OgEUtK3fhGnelQnaxjEqbUOfMfHLtCwgXwvfhuL/KqFxhEsMnFPjE5os
   w3xEw4ESnUf4+l8VDVXA+0BPrmN+fyk3Lb+Fwg+a1cOMcAeKxX10Kl9qF
   A==;
X-CSE-ConnectionGUID: mp6VEP+GSQGZyV0DgZWphg==
X-CSE-MsgGUID: bIKCdXpvQtO70kbCua1noQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88401797"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88401797"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:15:09 -0700
X-CSE-ConnectionGUID: BPm59eodT5aWwyWUVG0Xmg==
X-CSE-MsgGUID: VmkcAHdwQuinCdCYOkUpzA==
X-ExtLoop1: 1
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.69]) ([10.125.108.69])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:15:08 -0700
Message-ID: <ee673c37-e6bd-4321-8b76-a26a89e0df08@intel.com>
Date: Mon, 13 Jul 2026 10:15:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/features: Serialize multi-part Get/Set Feature
 transfers
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, djbw@kernel.org, dave@stgolabs.net,
 jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20260709155841.1895915-1-dave.jiang@intel.com>
 <alS0YGIqRfGBVCWl@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <alS0YGIqRfGBVCWl@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/13/26 2:52 AM, Richard Cheng wrote:
> On Thu, Jul 09, 2026 at 08:58:41AM +0800, Dave Jiang wrote:
>> A Get or Set Feature payload larger than the mailbox payload size is
>> split into several mailbox commands. mbox_mutex only serializes
>> individual mailbox commands and is dropped between iterations of these
>> loops. Nothing serializes the multi-part transfer as a whole.
>> cxl_get_feature() and cxl_set_feature() are reachable concurrently
>> from fwctl (per-fd RPCs run under a read-held registration lock) and
>> from the EDAC scrub/ECS/repair paths, so two transfers to the same
>> mailbox can interleave their parts and corrupt the device's transfer
>> context.
>>
> 
> Hi Dave,
> 
> I have some opinion maybe worth discussing.
> 
> Get Feature does not have transfer state, it uses an offset and count.
> For Set Feature, the device must reject a second transfer with Feature
> Transfer in progress.
> 
> Maybe we should reword this as preventing concurrent Set failures and
> preventing a multi-part Get from spanning a Set update? I don't think
> "currupt the device's transfer context" is accutate.

I'll update that.

> 
>> Add a per-mailbox feat_mutex and hold it across the whole transfer in
>> both functions. It nests outside mbox_mutex (which is taken inside
>> cxl_internal_send_cmd()), and is taken nowhere else, so no lock-ordering
>> inversion is introduced.
>>
>> Link: https://sashiko.dev/#/patchset/20260702090849.47501-1-icheng@nvidia.com?part=1
>> Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
>> Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/features.c | 3 +++
>>  drivers/cxl/core/mbox.c     | 1 +
>>  include/cxl/mailbox.h       | 2 ++
>>  3 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>> index 85185af46b72..85d6bcdc360e 100644
>> --- a/drivers/cxl/core/features.c
>> +++ b/drivers/cxl/core/features.c
>> @@ -240,6 +240,8 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>>  	size_out = min(feat_out_size, cxl_mbox->payload_size);
>>  	uuid_copy(&pi.uuid, feat_uuid);
>>  	pi.selection = selection;
>> +
>> +	guard(mutex)(&cxl_mbox->feat_mutex);
>>  	do {
>>  		data_to_rd_size = min(feat_out_size - data_rcvd_size,
>>  				      cxl_mbox->payload_size);
>> @@ -314,6 +316,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>>  		data_in_size = cxl_mbox->payload_size - hdr_size;
>>  	}
>>  
>> +	guard(mutex)(&cxl_mbox->feat_mutex);
> 
> What about RAW command path ?
> With CONFIG_CXL_MEM_RAW_COMMANDS=y, GET_FEATURE and SET_FEATURE can be
> sent directly through mbox_send() without taking feat_mutex.
> 
> Or you want to keep the scope minimum so RAW path is out of scope ?

Yeah I was only trying to fix fwctl side with this patch.

DJ
> 
> Otherwise the locking and ordering looks correct to me.
> 
> Best regards,
> Richard Cheng.
> 
>>  	do {
>>  		int rc;
>>  
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 7c6c5b7450a5..0370ac39ec4a 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1516,6 +1516,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>  
>>  	cxl_mbox->host = host;
>>  	mutex_init(&cxl_mbox->mbox_mutex);
>> +	mutex_init(&cxl_mbox->feat_mutex);
>>  	rcuwait_init(&cxl_mbox->mbox_wait);
>>  
>>  	return 0;
>> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
>> index c4e99e2e3a9d..d008b9db07aa 100644
>> --- a/include/cxl/mailbox.h
>> +++ b/include/cxl/mailbox.h
>> @@ -50,6 +50,7 @@ struct cxl_mbox_cmd {
>>   * @payload_size: Size of space for payload
>>   *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
>>   * @mbox_mutex: mutex protects device mailbox and firmware
>> + * @feat_mutex: serializes multi-part Get/Set Feature transfers
>>   * @mbox_wait: rcuwait for mailbox
>>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>>   * @feat_cap: Features capability
>> @@ -60,6 +61,7 @@ struct cxl_mailbox {
>>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>>  	size_t payload_size;
>>  	struct mutex mbox_mutex; /* lock to protect mailbox context */
>> +	struct mutex feat_mutex;
>>  	struct rcuwait mbox_wait;
>>  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
>>  	enum cxl_features_capability feat_cap;
>>
>> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
>> -- 
>> 2.54.0
>>
>>


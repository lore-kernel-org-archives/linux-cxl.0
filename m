Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC32205E16;
	Tue, 14 Jan 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886327; cv=none; b=s1KUZQdcm3undRTqJO6cwLyV2VrHAx0X8CvLVWmAhUnEWW1uUNm93fz/EXgFFlXU45VyGPUVX4vtXn0TSnH3fY49rtE8ZHMRpcjGjFEnQ8PXH1ssIVGuBp0m3oi1mgTS0qp3o3lBFpWUUrSIG+IQN+2oLvmlOFmMi6myP2/nJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886327; c=relaxed/simple;
	bh=0fBpa/WjFC7doM9PzG8ulFy10TKn2w5qgD8q5B5bE5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvhavbZ/ApFKBh2xdaNhfrog1Qq+04+k9jQNyK4wD3flvdeqNpnAORdGPkJ/oIYhWHrBX32YYrnj7gvc83GEX8oDiUORr0cZauFEwk0RYrHcbBXBAI8Sd8QAlD2+vuSV7mly94OqDwz23d76Ah0wTgHNf2jIkuJiszznSkrryMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBOVoWBM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBOVoWBM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736886326; x=1768422326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0fBpa/WjFC7doM9PzG8ulFy10TKn2w5qgD8q5B5bE5o=;
  b=PBOVoWBM/oP1vNb5nyCXhYakboY9eJTic/KT6idiHxj0HU+d4wpQbQHw
   WUkg5M7Lgv80mg4p6OC7RS8rqof3C8PqyPvotCi3s1by3B6W97LvucIT0
   D9nwQDIkzqCt2G06Cqyix2wT7qnUbrGDRWLIaAYW3RQiZjabThyna7pqZ
   bTtVpsaDuo5svYt2joUht71nQiG2JH62RUAGXRfxPyFBt6c8jfuHn+uuh
   3iPL4caLtzz6Qk9Ci4/NgleH+gy4VrCJveSZuzJfnqj5ZIE3+HDAFz/Ms
   cgOpLSn+ii2r7VwKaByB82MGrHOEMRK6lTi7wuccf12dl6j4K4h7b86QY
   A==;
X-CSE-ConnectionGUID: kNUcIb02QfCUv5H368q9oQ==
X-CSE-MsgGUID: rflo9mA0RFuimLDyxVZUcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54620935"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="54620935"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:25:13 -0800
X-CSE-ConnectionGUID: zm0Jw3IjSLOgDrmKmXWuyA==
X-CSE-MsgGUID: CqHSs7jvQAyCbSkYmdL4Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142182973"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.148]) ([10.125.108.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:25:11 -0800
Message-ID: <1673676a-9d86-4188-933f-27a84586fb0b@intel.com>
Date: Tue, 14 Jan 2025 13:25:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cxl/mbox: support aborting the current background
 operation
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 fan.ni@samsung.com, a.manzanares@samsung.com, sthanneeru.opensrc@micron.com,
 emirakhur@micron.com, ajayjoshi@micron.com, Ravis.OpenSrc@micron.com,
 sthanneeru@micron.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241022031809.242591-1-dave@stgolabs.net>
 <20241022031809.242591-3-dave@stgolabs.net>
 <7e390255-7e55-4b59-9a7d-6aa3857c8a42@intel.com>
 <20250114193344.jswodb44wupxx4a3@offworld>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250114193344.jswodb44wupxx4a3@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/14/25 12:33 PM, Davidlohr Bueso wrote:
> On Tue, 14 Jan 2025, Dave Jiang wrote:
> 
>> On 10/21/24 8:18 PM, Davidlohr Bueso wrote:
>>> CXL 3.1 introduced the ability to request that the current on-going
>>> background command be aborted. Add support for this, where the current
>>> policy is for the request to occur whenever a new incoming bg command
>>> wants to run. As such everything is left to user discretion and it
>>> becomes impossible to hog the device/mailbox.
>>
>> Are you trying to say that the patch is changing the current behavior to where every time a new bg command comes in, it will abort the previous one?
> 
> Yes.
Perhaps consider:
Add support for the policy where a new command request will supersede and abort the current running background command. With this new behavior, everything is left to the user's discretion. It will no longer be possible to hog the device/mailbox.

DJ

> 
>>
>>>
>>> The context of doing the cancellation request is the same as the new
>>> incoming command, and will always hold the mbox_mutex, guaranteeing
>>> that any successful cancel does not race with a third thread coming
>>> in and stealing the effort.
>>>
>>> - For Sanitize, the thread doing the will cancel the work, and clean
>>
>> doing the? seems to be missing a word here.
> 
> 'doing the request', will update.
> 
> ...
> 
>>> +/*
>>> + * Return true implies that the request was successful and the on-going
>>> + * background operation was in fact aborted. This also guarantees that
>>> + * the respective thread is done.
>>> + */
>>> +static bool cxl_try_to_cancel_background(struct cxl_mailbox *cxl_mbox)
>>> +{
>>> +    int rc;
>>> +    struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
>>> +    struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>>> +    struct device *dev = cxlds->dev;
>>> +    struct cxl_mbox_cmd cmd = {
>>> +        .opcode = CXL_MBOX_OP_REQUEST_ABORT_BG_OP
>>> +    };
>>> +
>>> +    lockdep_assert_held(&cxl_mbox->mbox_mutex);
>>> +
>>> +    rc = __cxl_pci_mbox_send_cmd(cxl_mbox, &cmd);
>>> +    if (rc) {
>>> +        dev_dbg(dev, "Failed to send abort request : %d\n", rc);
>>> +        return false;
>>> +    }
>>> +
>>> +    if (!cxl_mbox_background_complete(cxlds))
>>> +        return false;
>>> +
>>> +    if (mds->security.sanitize_active) {
>>> +        /*
>>> +         * Cancel the work and cleanup on its behalf - we hold
>>> +         * the mbox_mutex, cannot race with cxl_mbox_sanitize_work().
>>> +         */
>>> +        cancel_delayed_work_sync(&mds->security.poll_dwork);
>>> +        mds->security.poll_tmo_secs = 0;
>>> +        if (mds->security.sanitize_node)
>>> +            sysfs_notify_dirent(mds->security.sanitize_node);
>>> +        mds->security.sanitize_active = false;
>>
>> Should this line happen before the sysfs notification?
> 
> It is benign as we hold the lock, but yes. I will also abstract this in a helper,
> such that both cxl_mbox_sanitize_work() and cxl_try_to_cancel_background() can
> use it.
> 
> Thanks,
> Davidlohr
> 


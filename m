Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154E1DCB26
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468571; cv=none; b=uFhvrYaZ6Nbbxt7xJsE/JrymrdkMAPRRS0TwS1CFevROxAIWI7PPqGvG+44nGP+WqhVyVUjQ19zUp6H/GEggo/VblW/jMNkqfjpbghNF6SYA5eY+6dTROIcLo4FPoaJEK/YiiN6UTg6Yj9q7h7AI4didBVzNzUToKaId3EWnjTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468571; c=relaxed/simple;
	bh=rRMvonLgztdJQQQYsRebtlmixJhsUVoM9bd0HmKcwCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI6ae0TsUvXTxtQPwmboBndTJxEoi+78IxZ7275rL+md0+tOEee0XX9fhsAoM8AfBh3wfmOTdav2S0Tvfaow6n/ybEgfnavyTzm/Aowm8O/i5S+vfJjD+SnwpMMJY6lHclVqYaMLNI4YEAuQHbfkRolRlyiDmXUIAAefm8gFvmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8cK2fsn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8cK2fsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725468570; x=1757004570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rRMvonLgztdJQQQYsRebtlmixJhsUVoM9bd0HmKcwCM=;
  b=e8cK2fsnidKUhdQO2Qcuau0zZrEXEGoagrVUQbnpokco66e0s/S6zAUm
   Sg0Q7E6WAAgND/e7+4JsO3xTjSoJKhJI+sbH1225zaPlcxmCsH941c0yj
   hl4Go/HUb6WHmUZSo2A0Zs7qjnAEzfhUze470zL9x7z0xaE7+PHW1K5Y/
   ulywk4os7QBt7kDZXPHZ4no5ik56MKGiG0H+v4B3AVsTJIlVD5/R8cOro
   iuQExWlWVD3QRoZG3BOTuC8wk9eN+mFq5j4HSFnhTEv8BTYgK9aXkzF/K
   DA+TPaOVDUPI6OtCEXElr0PVvYitUUhPHhTo1heifB1F5Jg3mlJVDHgw6
   A==;
X-CSE-ConnectionGUID: 8OVjJTdJSlmFY/9mbFIDlw==
X-CSE-MsgGUID: zMzXMqJFQBWOtwQ9R87vVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27901881"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="27901881"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 09:49:30 -0700
X-CSE-ConnectionGUID: 5sbK5BitTK6Hc6dY/q/YnA==
X-CSE-MsgGUID: VrfrtQeeT9KmaGAJQaC9+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="66056604"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.157]) ([10.125.109.157])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 09:49:29 -0700
Message-ID: <b7d13c8d-dc80-4a1c-baac-d27db35c8a16@intel.com>
Date: Wed, 4 Sep 2024 09:49:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] cxl: Move mailbox related bits to the same context
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, alejandro.lucero-palau@amd.com,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, fan.ni@samsung.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20240904000020.1686611-1-dave.jiang@intel.com>
 <20240904000020.1686611-2-dave.jiang@intel.com>
 <ZtiLQblMnSAoHfu3@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZtiLQblMnSAoHfu3@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/24 9:30 AM, Alison Schofield wrote:
> On Tue, Sep 03, 2024 at 04:59:08PM -0700, Dave Jiang wrote:
>> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
>> it. This allows isolation of all CXL mailbox data in order to export
>> some of the calls to external kernel callers and avoid exporting of CXL
>> driver specific bits such has device states. The allocation of
>> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
>> mailbox can be created independently.
>>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Link: https://patch.msgid.link/20240724185649.2574627-2-dave.jiang@intel.com
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
> 
> snip
> 
> 
>> @@ -1408,6 +1421,19 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>>  
>> +int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>> +{
>> +	if (!cxl_mbox && !host)

Oh yeah this needs to be || for it to make sense

>> +		return -EINVAL;
>> +
>> +	cxl_mbox->host = host;
> 
> drivers/cxl/core/mbox.c:1431 cxl_mailbox_init() error: we previously assumed 'cxl_mbox' could be null (see line 1428)
> 
> caught by smatch_scripts/kchecker
> 
> 
> 
>> +	mutex_init(&cxl_mbox->mbox_mutex);
>> +	rcuwait_init(&cxl_mbox->mbox_wait);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, CXL);
>> +
>>
>>

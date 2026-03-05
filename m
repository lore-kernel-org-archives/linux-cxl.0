Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D731F9A6
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696642; cv=none; b=RugYZlyRdLlOZb8AGCqICkp0QgABu282gmRsxk9G4fWO/MIfYpX7zC3354NAAS7+7QVL1lD9mQkUmVltwoF+W8SubHqw+KV9xuVhGY2MvfWdNtvsYspPucGmfwbhFt9Wig+42avyBRnnLkkvs+gKqEVKw5GLpvFtCX855smjpyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696642; c=relaxed/simple;
	bh=HFhQGScd5orZZTQDNzxl2IwQKAoGG4UpAXqgoxIXrwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYI4OlTzfuBHmcSSU/vmOA8n0DgjxLE3zglnIVhcVNKM7+fK4I13FfuMp8mBcS5h7QRgMBA90SI197OSP/K2vSpC5EDt20RVoC1Nxa83YoD1u+okKQL3WW3/7lJqnZbr+9G95GiXJeng2A5v5S1BTQGw87vRP+GPywcF7/5VSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=AWFB08gI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="AWFB08gI"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8296dabef74so1735806b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 04 Mar 2026 23:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772696641; x=1773301441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGV5tSt+Pn/qUjEUL1W1gWV5V7UmQEiKPJnjCM1uOgk=;
        b=AWFB08gIfQHFD01398SGmCH3CzEFasxne52A1do5Pdw7CGgVTPfRl3YFfvsC1sHMkr
         RoJl1th+KvOMt4wzT00KIR956nm5m5izbt/yySY035pxRUpaWvwZr4WAO8kT7fZgR4E3
         CpyJ7kGjPbA0xq+DF0bPltOLbArHZ7aNqMqRSCC+ua2mRr9NPrRrAB4ju7YD65h5xEuv
         YLsqSH5b6Gh0LYGyq8kpPczuZKMFDyMTYkAxf7xqys9/Z9QAzh8L3b8aaQWeUTDWF5zv
         +MSPAYZmfbElVnZlb0DbZ7MoorU5iiKhZUlEdZ8BhsUoiYvbylsXWX4WZZgNt0i0MZ7k
         s8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696641; x=1773301441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGV5tSt+Pn/qUjEUL1W1gWV5V7UmQEiKPJnjCM1uOgk=;
        b=U4FtVJItjRLaDW83mTlOrFzj6yDlbqEeGj83C3LAo4yhIg1e+ffzSPaYSqNky2iSHS
         4xZhoGGlj9VpPMaQ906zFN0tKIosj1cWx2nZu61vegTkoOJtmyA+gyFE4PPwzusDv9hE
         10V+oK71jgnyAZwWEIs0WwdvKrLtfLtGDn9h9FnQb/4uEhea7KsUgxe9rLoleI6UG22l
         RV4TFbQ0mgStO0C5YMIr8nn3BYtgFS3fXTTV9CjAk4aT3jLdIxNBw1MwnL+tG2XeYAuL
         ZCc+qbFrBWEkZxjC+nhgjg2Oo8ATJTHl3irH+csnWXVJxjFJPV6lAXpEWcRRojfCvtHU
         9L5w==
X-Forwarded-Encrypted: i=1; AJvYcCXvkUF1oH+z1qg8JUK9H5/IhMShE99az2FZEOxhz47JVGNa8bmfpKWwN5Gdua8AN2yT84mAbFQ+Rts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsR8KqE91uN33q3Kw1wedmXvuUAOC2qV8D8bQ3YDBnD4Rg46s
	o0aOXoXfaY19ZUg5pGcnSDFXM3pymxe6JYNv/XTlJZrUjz56zvMkOJOiwPDtaZ9FVvQ=
X-Gm-Gg: ATEYQzyRcDOp2KAoEGecLm4MglhD2tjX7D+O1Kin0+AlN13pi346pb1Kognlg3XWhTL
	xb3MQMYbIZEtcjifs9I5cNsDad9m5gPEbUVltA6l9SCkflvOso4XTHoXcIyY+UqK71TfIrNQHSe
	20kiTMOpprR8V5GPrwur6/I4QZfB7cib/Z3Jx4cG5MgSKJb9cM6l7heoD5Ng9oE0/WwU0h5GvVl
	d3bFCVj7Voqjh4kgmdqILjWcMecVK0ZylyHppm40w+XY+Oov3SEfPD7RrUayAJ437eono7LU8xK
	KuHxEpNVlWqQz2e6IF1JHKRsHG+Ib9tq4lR+9nzyJeWnG+8IuD3L25UT2TizH1Y/AEvnhcIbnEX
	20oyWzx9EMOVyCAB3hGYC0mlxbjw5FBjfPpI30tjS/xLl0feKSndpG/tiePr/YH47/gll+LUZt2
	LHjfuixziuSRoxKTN268ik/qHZSHfEmToglX6s
X-Received: by 2002:a05:6a00:cca:b0:827:46b2:50f6 with SMTP id d2e1a72fcca58-82972cd401cmr4596619b3a.49.1772696640701;
        Wed, 04 Mar 2026 23:44:00 -0800 (PST)
Received: from [10.54.26.107] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8297a05d155sm2593862b3a.25.2026.03.04.23.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:44:00 -0800 (PST)
Message-ID: <a549b1d3-547b-49a5-b92d-864bb825945c@shopee.com>
Date: Thu, 5 Mar 2026 15:43:54 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
To: Gregory Price <gourry@gourry.net>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260304080647.169434-1-haifeng.xu@shopee.com>
 <aaho0IyQ0WAjcRMM@gourry-fedora-PF4VCD3F>
 <8ad398f6-995a-489b-8ca2-f21afdce47e4@shopee.com>
 <aaki7DZ78o_vr0kb@gourry-fedora-PF4VCD3F>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <aaki7DZ78o_vr0kb@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2026/3/5 14:30, Gregory Price wrote:
> On Thu, Mar 05, 2026 at 12:18:05PM +0800, Haifeng Xu wrote:
>> On 2026/3/5 01:16, Gregory Price wrote:
>>> On Wed, Mar 04, 2026 at 04:06:47PM +0800, Haifeng Xu wrote:
>>
>> Every memcg records shrinker info for each possible node. If we use online node
>> instead of possible node，then during memory hotplug, we must tarverse all memcgs
>> and shrinkers to check whether corresponding node has allocated the shrinker_info.
>> This way introduces more complexity.
>>
> 
> Right, but some systems might actually WANT this many nodes, and this
> does not scale well at all as-is.  I also don't think it's as complex as
> you think, most of the infrastructure is already there.
> 
>>> If you're not actually using CXL, can't you just disable CXL in the
>>> BIOS?  Then you shouldn't even emit CFMWS at all.
>>
>> I have asked our Intel Support Engineer, he saied that cxl can't be disabled
>> in BIOS.
>>
> 
> Huh, this is surprising.
> 
> If this is the case then see Dan's patch here:
> https://lore.kernel.org/linux-cxl/1f5074979a58803ec875dd10c9234c7b1a17192d.camel@intel.com/T/#m0d64b723a63ca7faf44311c52c1ebd5f280ae626
> 
> That should deal with your issue more cleanly.
> 
> Otherwise, the problem you're describing here really should really be
> fixed with either better lock scoping or lazy-allocation.
> 
> (Already poking at the issue a bit)

Yes，the patch you paste above worke well for us.

Thanks！

> 
> ~Gregory


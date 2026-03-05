Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA1188735
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772684294; cv=none; b=MRgL5b9JmEdizirDsUCRjZffdG7y4kBmb7Ge7z7I3HFGZZE9ogPQXQ5kjSJGU2aNTGAmWKI8rJa6i6mNdoDHEZ4zjKR1hmCYRQ4kuIUG5fa03b7kiKAcEYY2tdnXcF1j1j8YEzL31E7nlNXWL/kB6VBlpP8r0OPD/E2Y1ZRleT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772684294; c=relaxed/simple;
	bh=xqEUrDrHuTsX7BOEBaGNgotXQMrlUkf2uviuVaMzWjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2b/TkY/r35/0VEOcKT+vCj/jlP1/W7G7oHXvpXM63ncb0OCj4Qsw8xTrMxlzmViUcUwLDF5nFQt1EgCZvsk7Cw5wy4irV95sJYZ/XSNsUymClEJLTCMaYmwTNHa4SvR26G7E9YQHyOTvxwPtGG2Navcpf2f5fnqDXDnIzhnI5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=I499EJBH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="I499EJBH"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso4564145a91.1
        for <linux-cxl@vger.kernel.org>; Wed, 04 Mar 2026 20:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772684293; x=1773289093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ex5BiGy9sdTtbNN9/uQGHuy877qSLSxuqy2llH/Sfzc=;
        b=I499EJBHfCx3nVfNnlm5d9YSZNmpWFq0BUAKsuLimXNimWNAl+aWEylCQ3JyfqTmgt
         Eyxty/pkibTJaFwNY14PQ9mBwETzUktxo706Yo175idZimSveH19O5+s8opC1hCQOp4p
         0L2SOaGy8Gd9/7hM8beXdtyr1b7wM/I5jfolBXFqV3xYv1SHR0bakJYtqF1PQKeW8V+A
         yxLTxL4LEyI/hVLATEjlKfRxzWbWoBLHwAtNxJMqDZmg3uMwrvVI0n5TYjyNZuDPEhIq
         0Jdbi+w4+3dsoU5/i+aJuPJ8++g+RT2FYyodcdxyOOma24xpbETcbQGo2SJAg4rzoucM
         1sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772684293; x=1773289093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ex5BiGy9sdTtbNN9/uQGHuy877qSLSxuqy2llH/Sfzc=;
        b=vJdQvfxKTIaCAAyInLbGbnkPA6OszpVat56Z3xKOLQb01nDHsUiT+6Y0vj+pLlWt1u
         4EBrKjin3lm5VXsTOV3hqG2inFQWoOzH31nFSIml1BRHpNhjHwW2+4VldOh6/V7aMXRv
         HwxeBHVjCz84YVml25mWio5xBx2VLdTRE1qgE/DK6PKSaoXt1LG3kdsmLMrd+cahc9xd
         O87up+IFmfSG831PokJ5lJYHCyMr0GSok+yc8CTpUR/+4x5KqtPNXanb50+jVJskgKy2
         Sfif45lkXwAm6r15ZD2WNmIdw/2jYmC2Poxz1O5/KGHctDEAkG6nHL84lZYApLelWezY
         0Q8A==
X-Forwarded-Encrypted: i=1; AJvYcCXN6GI43coVui6g7dWZt6I175V7vREVOUBOX2lh6t3D3ajPjxSGd0AgX0YrL+bubXw4pBsn1EGCp9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDvZNaKwCMICPCn1NsWMoI9HtAIo38UQHg/qXrzhMkhkNELcKB
	M4+GzD/RQp7pD6lo4m9/Cx3i9zXJHbFbPtNZCTmU+Myp0AIkPJvy2VM7yF6GQCLl7PSLBrOa83F
	hcCimZeUi8g==
X-Gm-Gg: ATEYQzwogfOAFn6NDXV/vhsBC2d6nznhI+c52RuT4pEGBbC0dHagFfO653H7AGCDKPq
	j8gjhT5K9BKrmdtt9KhJWn0ZUvtztrJA8VPEp15+iNN8F5CJ2JPs1E3Ji7yJbxeJRMjZTY83bfD
	aNRFaM4zflaWQ0z59deyyrZoyzIPCobp7Txil+cfcoevuHuOn4xRvO+7Dib86w96kTShxu3DEay
	vKfLLgfPNWaWHhFAfux2ykspQvJUvQz+Qs+QCgVv0dKjarT4VSQzTeJrKZL3M+6If9Y3pv5Holt
	63hVvGM2HQ30dSi0uNp3I7ZvhJqGvE8+tLOPAm9VryMxLSxi2BH4SjMcHYwEsqE3mBkadWs5yBy
	2594DEeMp88tIzY1V4CcdET24x7QZ9u4sMkMFun0arUdkJQDBhlf1N1/8cJa12U8UUMdCR46e7X
	HzXxJ9SUYtRATSdgLItNNmd4fiUWN67RT9q0WNiyGvDxXN28P8pVV7AHtOh5uBQOL+vo6mwNlBI
	ozXGIRzN1W0+Ru7oiSJ+g==
X-Received: by 2002:a17:90b:1c10:b0:352:d59a:b28 with SMTP id 98e67ed59e1d1-359a6a4f86amr4022402a91.19.1772684292685;
        Wed, 04 Mar 2026 20:18:12 -0800 (PST)
Received: from [10.54.26.107] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2dffbf2sm459828a91.13.2026.03.04.20.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 20:18:12 -0800 (PST)
Message-ID: <8ad398f6-995a-489b-8ca2-f21afdce47e4@shopee.com>
Date: Thu, 5 Mar 2026 12:18:05 +0800
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
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <aaho0IyQ0WAjcRMM@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2026/3/5 01:16, Gregory Price wrote:
> On Wed, Mar 04, 2026 at 04:06:47PM +0800, Haifeng Xu wrote:
>> For the machine Intel(R) Xeon(R) 6746E that supports CXL memory,
>> the possible nodes are 20 (0-19). However, only two numa nodes (0-1)
>> have memory and the rest nodes (2-19) detected by CEDT are memoryless.
>>
>> The problems is that when creating many pods, the shrinker map size
>> needs to be expanded for all memory cgroups in expand_shrinker_info().
>> If the number of possible nodes is too large, the holding time of
>> shrinker lock grows significantly.
>>
>> In this case, there is no CXL memory inserted in the machine, those
>> memoryless nodes are useless for us, so there is no need to set them
>> in 'numa_nodes_parsed'. After disabling parsing CFMWS, the pod creation
>> time is reduced from over 10 minutes to approximately 150 seconds in
>> our internal test.
>>
> 
> This seems like the wrong scope to fix the underlying problem - which is
> the shrinker lock holding scope.

Hi Gregory，
	
Thanks for your comments. 

Every memcg records shrinker info for each possible node. If we use online node
instead of possible node，then during memory hotplug, we must tarverse all memcgs
and shrinkers to check whether corresponding node has allocated the shrinker_info.
This way introduces more complexity.


> 
> If you're not actually using CXL, can't you just disable CXL in the
> BIOS?  Then you shouldn't even emit CFMWS at all.

I have asked our Intel Support Engineer, he saied that cxl can't be disabled
in BIOS.

If know how much nodes we actually use, can we specify the max number of pxm?

Now the pxm can't exceed MAX_PXM_DOMAINS which is equal to MAX_NUMNODES.

Thanks!

> 
> ~Gregory


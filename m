Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD330F932
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698287; cv=none; b=N5NN7yxPcJuKjmUBNf0P/sd/2KYGb8nEyzDiUiiYX0QYJ0X84of9wQLU2ktHAFEyH2gBiYG4PrgeY3SZm1gRmwqHl+uyg2JzSND+ZBvP13PyKajfpr1ExTfEi5cKVoV8B8pjj8GFwlpwFOma60C+CnuJRp1w2MoFBtu0KZ+jCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698287; c=relaxed/simple;
	bh=7lNeI4Q9Uja+/KQLyBu/MSPEZ+msyNAKfW3xJ2P/m4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubh2c69SyANwjj8l5nxh8bWhusBK54X4u2i6HynwTLMPKJOwtoLwknWo9Jnuwqp+6HzRSV/BDxXj4/U4Absr7K25L3Lak8M1YLNh0U4qa9KdEskgTapGr3PrIrjzavTjkkI7qCivM/MiCR9kIZD5ZrSeT0rHx4NQEcKeUX0qhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=edi1eKcp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="edi1eKcp"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae43042ea7so51116925ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 05 Mar 2026 00:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772698285; x=1773303085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBOWB+m079XaZQjYmCEPY71XRCZ9lZ345P6YQe50dwY=;
        b=edi1eKcpJNR7cnVSD/0cZ4K7bJDzXYCaU5Jjkux+fDXU2OgFN4EdmN+JTaCdhN7KMX
         pF5tsxm313RFrmihUXtK3yDIaRJ/5UfFcVqpatqPyLXf7VN3sU8MKXBsDO1U/kc0egM3
         65NagpOq3yyicf+MGcq6ZFMHPzaADn+v0eLzZ83LUlx9d5pehriTmq95TBXk3GmUislG
         mzpkMVKhx+eh+QlIww/bLFklRjprlbrEqAfW40ODl/7cESonAowbx0KEWSFz9MuMyYX7
         XF9TBCa3JAkhWLetWL1Fz/v0mQVFHu3zKKXOCZ9a4H+6Wko8mthkUiwfeVc4zKSJUSbT
         6XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772698285; x=1773303085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBOWB+m079XaZQjYmCEPY71XRCZ9lZ345P6YQe50dwY=;
        b=Oy6W3y8ZBy0Fk+GUW3X0PN7FxiueLECbfz14ezxHENEOoVRZMJ+74/HXmNrkgcymXg
         GyTlWzcJOggwIyk1egBE02G+EGUK9JNCqP67DSzmKZfE4xOoqczY79o6pS/5SBef3yM/
         eiIQuM7wqg6wSBDhB4nJ+H+WLVCkPatQjtXU56B7ctPoP0kafKntORkrAyoWv1VpIDvN
         qku8SeAISNffRUjB0RCGY+dzGQhMj4TPoi4hbjyg5b6VQQbpc3FwVFzcgPH/ZvR0QXOr
         hrgGe48kkOim/F2rGlFO4QhWPNMWrGr/W7izKJNXUcLagf/dvpdb8qJeizbcfcwjTnTv
         C3NA==
X-Forwarded-Encrypted: i=1; AJvYcCUnyK2cQKSPdosDT8r5Wx+2Z4eeD3lAnW8arEvu0uyB7N8bCrFoOp1CQ+fJEUl6kry35Vi5+J2Qda0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1JWFPhR/LGIWg8U4AZgWMCEmyFtcg2Rp/IMFmqHILTeyUmLH9
	wvdHx5lLik4eThRZ3w5FXKtgcu8PuRUACOCA3nZMiWl1jnsy59o+nOBLEB+qJ26a0tk=
X-Gm-Gg: ATEYQzy6//X+RkgnAd9N7kpDOjPj6HCl74DHF1VPUm9wVEpGdB3eZlpLC+fMr/YYy3Y
	H//1266LSwiZDNzttB45f4i+++25aCWIjCjTYZen1cpIc5zKJKJRVEkD9KX5eRxXYzggE2iG6MI
	Ct9srLryB7QZlSlefb36qJDLJaNTvoyZrqqZ+i3VBccld+VDZB6wRNA9rWL3XUiB4FAz+ijKM4X
	riiQE66aU01WoyM70qIMO7PatWUQv/rBgxj0EhI8quWlEJLs2bcMZl3oDitugTDc2dj5BEm9SaX
	nw6oDfT5BTMI7nm0zMnFerX7N73iX8rcLHd0Nd8BTIRuzxzkvHbzZpPcMe7KpjD14DKToamhDsH
	WiFFEyUWpYr1ETZQn1jKw3L5/X1RraS3bkBa+qxQpygbROD4eBM0flkcwRNZDkV0fy1U0GTh0J5
	h1m/i9g1kQa7ozlMunyTwnsbl5m4BivQrTA6thhNXLSKLtLcI=
X-Received: by 2002:a17:902:d4cc:b0:2ae:4ad5:b76a with SMTP id d9443c01a7336-2ae6aa157c6mr46505265ad.21.1772698285431;
        Thu, 05 Mar 2026 00:11:25 -0800 (PST)
Received: from [10.54.26.107] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae492e6901sm121199785ad.65.2026.03.05.00.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:11:25 -0800 (PST)
Message-ID: <8355402a-e4f0-42b5-854a-ee42f9505612@shopee.com>
Date: Thu, 5 Mar 2026 16:11:19 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
To: "Huang, Kai" <kai.huang@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "gourry@gourry.net" <gourry@gourry.net>
Cc: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
 "wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2026/3/5 08:14, Huang, Kai wrote:
> On Wed, 2026-03-04 at 18:56 -0500, Gregory Price wrote:
>> On Wed, Mar 04, 2026 at 03:20:11PM -0800, Alison Schofield wrote:
>>> On Wed, Mar 04, 2026 at 05:33:26PM -0500, Gregory Price wrote:
>>>> On Thu, Mar 05, 2026 at 10:33:42AM +1300, Kai Huang wrote:
>>>>> Increasing the 'nr_node_ids' has side effects.  For instance, it is
>>>>> widely used by the kernel for "highest possible NUMA node" based memory
>>>>> allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
>>>>> related system calls such as 'get_mempolicy' which requires 'maxnode'
>>>>> not being smaller than the 'nr_node_ids'.
>>>>>
>>>
>>>>
>>>> Is this a Linux issue or a Firmware issue?
>>>
>>> IIUC BIOS creates the CEDT based on the hardware it 'sees' as present.
>>>
>>> This patch is describing the case (weird as it seems to me) where we
>>> then boot a system with ACPI and NUMA enabled but CXL_ACPI disabled.
>>>
>>> So, I don't think we can blame BIOS.
>>>
>>>>
>>>> Is GNR exporting more CFMWS than it should?
>>> Not sure of any limits on flavors of CFMWS's a BIOS can offer.
>>> If BIOS can carve out a window, it can create a CFMWS.
>>> Not clear how that matters to the issue.
>>>
>>>>
>>>> Is your SRAT missing entries for CFMWS that are otherwise present?
>>>>
>>>> Are the CFMWS empty? (is that even valid)
>>>
>>> Why this line of questioning ;)  I see the problem as a bit simpler.
>>> We have other code that tells us if the CFMWS's are valid, etc, but
>>> the point here is, we are not going to use these CFMWS's so stop
>>> the parse as early as possible, like right here as Kai has done.
>>>
>>
>> Mostly i'm wondering if this issue should be dealt with in the acpi code
>> or if the issue is that we just don't want to figure out how to
>> lazy-create these things instead of always creating them at __init.
>>
>> it does seem rational to build out support for CEDT entries if CXL_ACPI
>> is built out, but this also means you can't otherwise load modules that
>> would have made use of this information.
> 
> Besides CXL_ACPI, is there any other module(s) that uses this information
> for these CXL memory regions?
> 
>>
>> This basically says if specifically CXL_ACPI is built out, the NUMA
>> structure is forever lost - even though it's accurately described by
>> BIOS.  
>>
> 
> The normal NUMA info described in SRAT is still there.  It only avoids
> detecting CFMWS, which doesn't provide any NUMA info actually -- that's why
> kernel assigns a 'faked' NUMA node for each of them.

Hi Kai, we met some performance issues when creating pods because of too much
possible node without cxl memory inserted in our machine (machine Intel(R) Xeon(R) 6746E).
This patch can workaround our issue.

By the way, If insert real cxl memory but disable CXL_ACPI, how the kernel
initilaizes the cxl memory and assigns the numa node? can you provide the
related kernel souce code?

Thanks!


> 
> So we are not losing anything AFAICT.


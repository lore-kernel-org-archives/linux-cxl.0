Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CA13B7A7
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032830; cv=none; b=pF97r945TWmU1fVaoZj4eFnTlp73KbLFHJMfIw9gaN+BIUqUHYI/2lBnf5sFp6sTNydtlnKTqZcO43r9pMc02YqgesRfn/LW/lA88gWTY92gNxs4kWAD/IrfrIiY7NvgbVyKxBz5QGhCVv7p94GMuWkZA5+9NJ9QPu1bKzbNEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032830; c=relaxed/simple;
	bh=4yEvNJ7C1AftfR2EL7QYv5ogVUJ+uvFZlOwu1eCT1DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkkxHyYZmdKa8rT04IyCxmM/xRCNEuwW2DZg4T19lIbCsiEPdAAJU80OmFod235cK7eCrI18T0yWEh7UGRnxit6ZJfu4tBGw6C57b7SXOo9yq8GOO85Ds12M5MtongjpRDOwmVtBwY00Eh4PCtOs/+YGIXWZZJKtgeG7VF0crD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQNflBYc; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQNflBYc"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6818f3cf006so7482616d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 13:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708032827; x=1708637627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0KxUQjikN9qJwUUfXca+Q3jrms+wai3/UguMFU4Ync=;
        b=lQNflBYcFghANNjmIeFfC3HIpT88DRdAPj2fJX0VXMpWYEDy4/Qu3dwNg183Fepitx
         fbH4ds0gv8Pd0pDnEW1UQcpG1k7SY83dINLrvig4iZ7wt6/P1HE/YHzhO0ubNuW7qWc+
         H0IQrjD061nOoXzQKGe+b5zAui6l4PTspV5YBcJzuZYLck82vbfMBtRLd4u6twi7j/mX
         7xOxKwCncEYwPkZPGnq2DeD2YGC5s4MaTY4idefID086+JmX0aiKbloYGGDlUQZwTLhj
         yPX3iNHHV0/Nf5jqwVFtUVIwzvnhqx5DxuuGh7JZvhw5HA0KqC8LTmEq514pZQkFt3+r
         wKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708032827; x=1708637627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0KxUQjikN9qJwUUfXca+Q3jrms+wai3/UguMFU4Ync=;
        b=jM5SnrsdiBXgX7W8RqAkX5HyE0/c5o2dTknsz8Wl7h7zkXX6o72E+N1Ku7Z+1CeAW3
         5UgzthcmwHivS4GEmLu/c8GhOR20dgOKg0eAGrUCylHvEFdewfE3qCd2iMUXVTSAEQCE
         StdpFgz7jP5sLb0Hpp4zlejeE+9hCjuH9MrXv3wq9GAl2VaOlQ5LWLXk7k7cQGk7Q+JZ
         DlkzvhlyarPUUdgSjFFI3VpL/gM/5sF86Egcz1loqvkq5ai59nD4ycsmPzpQ55ki71H1
         6MXqCVAePlWDU1BZBJtmKRlPZI6axc1l1m/LdtQJOXqGPm/npUBDl8PbzGoWANxtuqkg
         9Vjw==
X-Gm-Message-State: AOJu0YzL/u2VF24htkTgC4BFaE4w7AZtDHNBYGcXK7I2PvHdAmVRB1A5
	KeOmEcELnzMB1eDGfOgPl/zkL0CNcJkKvrU7ypjoakRAW8/Wolg=
X-Google-Smtp-Source: AGHT+IGrDgFoaFAdEbK+jmPd0VtrOjYDKqIRotHp2cRjtYsDRVzqAH0uY6caYbOindUjJ7MvZJhCcw==
X-Received: by 2002:a0c:e302:0:b0:68c:cb57:72ba with SMTP id s2-20020a0ce302000000b0068ccb5772bamr2907113qvl.29.1708032827241;
        Thu, 15 Feb 2024 13:33:47 -0800 (PST)
Received: from [10.236.30.149] ([165.204.77.1])
        by smtp.gmail.com with ESMTPSA id mu16-20020a056214329000b0068f11bec5desm1052260qvb.78.2024.02.15.13.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 13:33:46 -0800 (PST)
Message-ID: <c3aadcee-818c-4346-9935-b72df9e4b443@gmail.com>
Date: Thu, 15 Feb 2024 15:33:45 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question on deferring dax registration to cxl module for
 CXL_REGION
To: Alison Schofield <alison.schofield@intel.com>,
 Hongjian Fan <hongjian.fan@seagate.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <CH0PR20MB4250F264AA40C6E9CF1F599C90682@CH0PR20MB4250.namprd20.prod.outlook.com>
 <ZaCHSE13Q/KJAZQU@aschofie-mobl2>
Content-Language: en-US
From: Nathan Fontenot <ndfont@gmail.com>
In-Reply-To: <ZaCHSE13Q/KJAZQU@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 18:26, Alison Schofield wrote:
> On Thu, Jan 11, 2024 at 09:03:48PM +0000, Hongjian Fan wrote:
>> Hi CXL experts,
>>
>>
>> I have observed the following behavior on iomem_resourece when CONFIG_CXL_REGION is enabled in the kernel.
>>
>> CXL windows are inserted into iomem_resourece based on CEDT CFMWS. If there is only one CXL device attached to the host, the CXL window matches the soft reserved memory range, and the CXL window is inserted as the child of the PCI mem and the parent of the soft reserve. But if there are multiple CXL windows, each of the CXL window is part of the soft reserved memory range, the CXL window is inserted as the child of the soft reserved memory.
>>
>> Function dax_hmem_platform_probe defers the dax region registration for the CXL window to cxl module.
>> However, two issues seem to occur:
>>         1) If the CXL window is not the direct child of the iomem_resourece, dax_hmem_platform_probe will not be able to detect and defer it. This means that if CFMWS contains multiple CXL windows, no deferral would happen.
>>         2) If a CXL1.1 device is behind the CXL window, and the dax region registration is deferred. The dax region will not be created because CXL1.1 device doesn't have the HDM decoder and other features needed by the CXL module to create the dax region.
>>
>> DAX ( and hmem ) module is not visible to the CXL device's features behind a CXL window, so it is impossible to defer only the CXL window for CXL2.0 devices.
>>
>> If I want to make dax region show up when a single CXL1.1 device is attached, I can see two potential approaches:
>>         1) Do not defer the CXL window in dax_hmem_platform_probe.
>>                 Can we simply not defer? Current code will not defer if multiple CXL windows presents. Is any issue observed when multiple CXL devices are attached?
>>         2) Defer all CXL windows, and let cxl module create the dax region for CXL1.1 device.
>>                 But where should this creation be? It would be a long path to handle all the unvailable features from function cxl_pci_probe to reach function devm_cxl_add_dax_region.
>>
>> Please provide your comments.
>>
>>
> 
> Hi Hondjian Fan,
> 
> This is familiar. In Aug '23 I stopped work on a patchset [1] aimed at
> improving the soft reserved resource handling. From that cover letter:
> 
> 1) Soft reserved resources were observed as sometimes being the parent
> and sometimes being the child of a region resource. Patch 1 clears up
> that inconsistency.
> 
> 2) Soft reserved resources were also observed as stranded after region 
> teardown, making the address space the region released unavailable for
> reallocation. Patch 2 implements soft reserved resource removal.
> 
> By v3 of the set, we were rethinking the approach as Patch 2's juggling
> of soft reserved spaces seemed silly and error prone. Also, the folks who
> were hitting the soft reserved issue during hotplug were able to use CFMWS
> address space not in the Soft Reserved range as a work-around.
> 
> Dan offered a couple of new approaches since then:
> (I hope I'm not misquoting)
> 
> 1) Insert cxl intersecting soft reserved resources into a separate
> (non iomem_resource) resource tree, when / if any CXL region assembly
> fails walk that side tree and move them all over to iomem_resource.
> 
> 2) Given that it is already the case that the device-dax core waits for
> cxl_acpi to mark ranges as IORES_DESC_CXL, and that we do not expect that
> to fail. It means that cxl_acpi can then turn around and ask the device-dax
> core to cache and delete the soft reserve address ranges. Then if CXL notices
> a region assembly failure it can signal device-dax to release that cached
> range as a new CXL disconnected DAX region.
> 
> 3) CXL acpi walks the resource range knowing that at the beginning of time
> Soft Reserved ranges are unparented making them easier to delete and
> register them as "just in case" recovery ranges to device-dax.
> 
> Can you comment on whether any/all of these suggestions seems to address
> what you are seeing?
> 
> Others thoughts on the approach this might take next.

Alison, and others,

Can you provide some additional details on this new approach. I'm trying to wrap
my head around management of the the separate cxl resource tree and what resources
would be put in it.

I've also wondered if you were looking to use this to manage cxl resources outside
of the iomem resource tree or is it just for management of 'soft reserve' resources
under the CFMWS.

thanks,
-Nathan


> 
> Thanks,
> Alison
> 
> 
> [1] https://lore.kernel.org/linux-cxl/cover.1692638817.git.alison.schofield@intel.com/
> 
> 
> 
> 
> 
> 
>>
>> Below is the /proc/iomem output from my hardware:
>>
>> 1) When there is a single CXL2.0 device on the host, the CXL window is inserted in PCI mem and the soft reserved region is a child of the CXL window:
>>
>>         6080000000-707fffffff : CXL Window 0
>>           6080000000-707fffffff : region0
>>                 6080000000-707fffffff : Soft Reserved
>>                   6080000000-707fffffff : dax0.0
>>                         6080000000-707fffffff : System RAM (kmem)
>>
>>         A cxl region is inserted under the CXL window by function discover_region and the dax region is registered by cxl_dax_region_probe
>>
>> 2) When there is a single CXL1.1 device on the host, it is similar but neither cxl region nor dax is created:
>>
>>         6080000000-707fffffff : CXL Window 0
>>           6080000000-707fffffff : Soft Reserved
>>
>>         HDM decoder and other CXL2.0 features are missing from the CXL1.1 device so the CXL driver will not create related CXL structures. Because of the absence of the dax region, there is no numa node created for the cxl memory and the cxl memory is not usable in user space.
>>
>> 3) When there are multiple CXL devices, regardless CXL1.1 or 2.0, the CXL window is created under the soft reserved region:
>>
>>         6080000000-807fffffff : Soft Reserved
>>           6080000000-707fffffff : CXL Window 0
>>                 6080000000-707fffffff : region0
>>                   6080000000-707fffffff : dax2.0
>>                         6080000000-707fffffff : System RAM (kmem)
>>           7080000000-807fffffff : CXL Window 1
>>                 7080000000-807fffffff : dax3.0
>>                   7080000000-807fffffff : System RAM (kmem)
>>
>>         Both dax regions are registered by dax_hmem_platform_probe. The cxl region is created under CXL Window for the CXL2.0 devices.
>>
>>
>>
>> Thanks,
>> Hongjian Fan
>>
>> Seagate Internal
>>

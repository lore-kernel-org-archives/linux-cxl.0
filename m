Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B04496D46
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154135; cv=none; b=uuGtZMAKPzPaWxu8Y77QT0HmsS1Vv9fhoVcUlv9TXcx1dSVApoIdd6KTHZ/Y0hIhx20fAqrVIaRTPivDsMlXGk4uKAeboM65QUlshvAEZhIZOrrxsC7sYrcsqgi9Xc0c6Ztosf32qoqwa+vLPnhyZl02jI/y8N+X0C6p/VJ4nj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154135; c=relaxed/simple;
	bh=aSu4fPkvdgD69XVSSJdgQhQsUOzXL9ufWnahhnOOFfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxLWftemhb7mcrdR7ockzE204yUG0Fv4jFDkMVHJ0QfMPLnFijqNqtdxxnZe6Asy9iQoFu/bKbyomed1p466PjPi+m+s3hAwkecBeBlxy1fgpROQlna+9Qy7BnCcthzC8rnGiuxHRroXV2iR7q4sOp1dhMAIpZ2ScJvocz5ItgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LS7uMZsC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LS7uMZsC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so49805485e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792154131; x=1792758931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Oaxw1ojTm33dUVZ3YmdLAwJF+qVMH14EEkliPunBjow=;
        b=LS7uMZsCWzoGBSjI/KzRbrH7GOvwnvOdl0Mx4RNXWVsISnfctBZMR2CHsdWMH/Hf5i
         iqVwIMuGmTSQOF97TxKX2cgEL+BTAsqsCINnUbnoDx8K2JvkfsHJPfSgUgfoBe9DAqTq
         Nh8r6Xf8LUaROaPAps78xk95B8rGRxRw91b1DBhxleIx51rufx+aopXgazMbXMll61La
         SMVXpXoNzcSd9vTARbEygIVFUHGIzjMlYqZDMSQUaqu5aTF9aYSLUN1Ah/g99Jqe1L6e
         v4O26TqeUeUwtSjwC/vAD/NFg6smWAMMson008OxFPFT7XYRCIFGEsHkjZV0nAbi1GhB
         BkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154131; x=1792758931;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Oaxw1ojTm33dUVZ3YmdLAwJF+qVMH14EEkliPunBjow=;
        b=MFK6CyhP4utIqFQDB47EcB/VQ/m2oHbtuMyCMyZfCHbfDWLnRQB48nSi1hPq4aUdeM
         4gHcjRy/WZXoCvkbf633HEPN1Y6Lg0sAyEOroGER5xQDRtKKgP91Q8RqHK0a0FqAIDEK
         CO4UMSKavV0TN8SDDI7c2Ngim9j67jwhqyOlfcNBwem8AyBIUzIU9yzhEqGpnJsoLKVy
         GBjHN9liZiVFqW9qg4mE3RSiYcY+XNhK1s4Gav53tXi0aypM8m9TiL9DTX2HbIUnboTc
         1mvrXTaTxo/LSyPUNKFy3nzOD6HOeRJPP+INRJjgSIoHs5C/NzLWVw/eRQwys0oADjOM
         ZAdQ==
X-Forwarded-Encrypted: i=1; AKwUvBw06t9LtCeg7foAcEvcQ6xaPRkk+hZ6vH+57wpWvTzhuC8tKgG6lZ9SZFlgurGNnauH7Ivsj1aYbIs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJa0l/pj3hnVEx/FAly8p8Cq1mFG8BQvkSL+0i9/t8yaxxmOcmh
	capcfJBTjCRNShWYboVWdidikJp9D60g6cs/uxZh4IkvrbdSrhUta8bA4qua9zC6+gE=
X-Gm-Gg: AYBFou0/kzOp6/QhmB+yKkYGB9G10UnroAy3Rja7pnKCOvXCQcV6e18LDgGhPxRpH3O
	2Yq5SQofsY65rmd7pcWc4PkZSBJ1JpaFHll4YoVu/xcrE2iM15b4Ioq4J5cus0tpckmW7SdFV/h
	x84A6ECnNjpSifuZVVz8+MePVSRD8NHeGqcDkUe6uZ1izUJxBrZzq6lCE5WBliDQyQFz/9NpD73
	8DPHXTWtsi6qfFcO4QebQfHRV0oFB66RpW9D21Y+FQmpLbppuacodBYbpRt9NXGfPvYsTSo7Nnp
	C8nmuV78URfGEHCch/rZ+UrafhKyZ7FvH7UKt/pBR5j8a0DRixQFW6phnmSK5q7fgu7BdK6dBHd
	bA40tKy+m8tfK/FWTjqQ4KLVP3mAEEP7CPOJKysCzmnp2s/3rQcci/a6NvQ+cU9f/4IGwYsuPPU
	wISTxVM7WPjQxulFsWO5U/fhPhRtZv//JGEvoTKxsDy1hRQkHY5/jYEiDCTiCPNsKK6/m2mWqbG
	EDz/KCR/CxzrZBpYUNIA5hH
X-Received: by 2002:a05:600c:3f18:b0:49f:fbad:29c1 with SMTP id 5b1f17b1804b1-4a18e4cedfcmr420105305e9.33.1792154130780;
        Fri, 16 Oct 2026 05:35:30 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b35a6sm140099685e9.6.2026.10.16.05.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 05:35:30 -0700 (PDT)
Message-ID: <230ba855-0a7a-4187-aee4-ac551c1cac76@suse.com>
Date: Fri, 16 Oct 2026 15:35:28 +0300
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] PCI/TSM: Create MMIO descriptors via TDISP Report
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
 jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, jgg@nvidia.com, aneesh.kumar@kernel.org,
 aik@amd.com, iweiny@kernel.org, ming.li@zohomail.com, icheng@nvidia.com,
 bhelgaas@google.com, smadhavan@nvidia.com, ilpo.jarvinen@linux.intel.com,
 Smita.KoralahalliChannabasappa@amd.com, andriy.shevchenko@linux.intel.com,
 linux-coco@lists.linux.dev
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-2-ankita@nvidia.com>
 <7605d698-b08c-4fcb-b86b-3f79927fb0d5@suse.com>
 <atIRRUO/t/Fj4VX6@yilunxu-OptiPlex-7050>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <atIRRUO/t/Fj4VX6@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.10.26 г. 14:57 ч., Xu Yilun wrote:
>>> +int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
>>> +{
>>> +	int i;
>>> +
>>> +	device_lock_assert(&pdev->dev);
>>> +	if (pdev->dev.driver)
>>> +		return -EBUSY;
>>> +
>>> +	for (i = 0; i < mmio->nr; i++) {
>>> +		struct resource *res = pci_tsm_mmio_resource(mmio, i);
>>> +		int j;
>>> +
>>> +		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
>>> +			break;
>>> +
>>> +		/* Only require the caller to set the range, init remainder */
>>> +		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
>>> +					     pci_name(pdev), IORESOURCE_MEM,
>>> +					     IORES_DESC_ENCRYPTED);
>>> +
>>> +		for (j = 0; j < PCI_NUM_RESOURCES; j++)
>>> +			if (resource_contains(pci_resource_n(pdev, j), res))
>>> +				break;
>>> +
>>> +		/* Request is outside of device MMIO */
>>> +		if (j >= PCI_NUM_RESOURCES)
>>> +			break;
>>> +
>>> +		if (insert_resource(&encrypted_iomem_resource, res) != 0)
>>> +			break;
>>> +	}
>>> +
>>> +	if (i >= mmio->nr)
>>> +		return 0;
>>
>> Shouldn't this check be if (i == mmio->nr -1 ) i.e all descriptors have been
>> initialized, given the for loop condition i can ever be at most mmio->nr - 1
>> i.e the actual index of a descriptor?
> 
> The original if (i >= mmio->nr) check is correct. Valid i is at most mmio->nr -1,
> but you need an invalid i to finish the loop.


Shouldn't the check strictly check for i  == mmio->nr the loop 
terminating condition, which means "we've initialized ALL mmio 
resources" otherwise perform the cleanup, that '>' can never be true.

  While not wrong per-se having a strict check would be far clearer, no?

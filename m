Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F036AB53
	for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304290; cv=none; b=QBZi7nAQSTnkzPgX/fw4swURRGigmWDh11b5K/aemQpTyZj9cmCEzVZNJnMT85FFXNYFbOwhMlDqtL9MmfpiCjqU49UsPMAlAGw1RxJeaxVKhliPw7cUgP6P898G/ken1lg9q0YhIuHhfS020XVPtSeU+BYOBdVNX77ALOkK6zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304290; c=relaxed/simple;
	bh=tfe0Vxv2opm5hw+ZzXeTgUj1EFeDY5O/sNZWlSnCo1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDkEVkcXQeoU77aDN/vdUNLtpB4CIvACJ0bjrtgn0mpB3EovMOIzmrjBJZeKP3X40njS2PHtD/NBKxfZag4rwDKmh0ylbqqeKER7Cud/zU9m/et9f3+dffgBGiMzi4srayx0iQdL4ohsuQ22/qqRNvQyHljx3zQDwd+tHVWmjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqrgnEMX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqrgnEMX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486b9675d36so38361245e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774304287; x=1774909087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvgmpqqiB57K4H68q5ZefoGrbBATbCDpybAH6NvYNSk=;
        b=LqrgnEMXUjOmOStWs86xwtpXktyEOyBoheTuLPP5Ne34EZBP7hPoGIGtNjUju8MExd
         YRbNS6Ld81kk/zLfTRWp5sLkA399W/Zh/L26rzcpjIP3HEHDUijeu/0SbO8RhxwSwRud
         2N7x1t4EqAQxIkXJLjLwfE84dK/cMjLaSXrj/0Ygid0a4sALjLhUZ0ADYDTNUQFLD8uW
         0EEBYS8DJN7RXCLWkLcuEUEIp4R87h8QcFoYzjZERMtFDEL3n9/TYFYCPRRu09Kmrx/K
         Qk0jE7HqcxAEC+RCLe/inmtp40GMSqHzENQSJXFr2Nd76VRYr+xARs53z2V3yPwjw6YX
         T7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304287; x=1774909087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvgmpqqiB57K4H68q5ZefoGrbBATbCDpybAH6NvYNSk=;
        b=RP2cE7869qTMNOnqmR872IU3JkankGpx1FRYXOCZVIeIyfHQNTpxkDZePdHNyoCew6
         Vqd74sN60HNweyWV07GQ+5KODqkxhgXRc7TI9+tItsj9MuiYuC/ELyt92SrOfEgqAMMc
         hO+xaQGTgDStQcmaYYYDyPDZ3Ngn/+6ctaRIHCbj9whiwLnfUjk1TGp4cxBeYOjTQbBY
         ulE7VmJ/1tgYlMrqOxBpr/caZ+LHUcsucXkyU0Nxxwacu4xowUv3wg7edtyQmVWk0VOz
         /9SbNRKRfG5IXFHTo2Q88fMftq551XCPYHQ2ftp3Tt2+olhApZaIp7sK62V1UhRxKQDh
         Ij0w==
X-Forwarded-Encrypted: i=1; AJvYcCX5IzbMMPzHv0xBVofV61mPkwcyru4a5hNJQOqDbUiklow8KKOxGPpa53i83LHan7aZ4aQ/apbI938=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLF2QcdmEa9AEG8iI3IOu4r1hEHJPpJn9z2+fDY0lzTbOXNdHE
	nskKQbj7AvGs4mLFyD7S08jO+JKmg9ZeNXZkvy9Re6o/7kgr7AV2/m3I
X-Gm-Gg: ATEYQzwAUmoATDL+cMddGI20ssDjDUaP/D84Dp4Wa3/1g7auVHfVYillZGy03M7M2xc
	9U5s3F9aomrcdir9rf9py87Le/MJzvu9p6E7aAnSLTrdNV+4/3pcLtR4tRSe1YBG5c8mYPnNG3e
	YOGW3Grbo3Ej0ccheiPoeQuleenYiuo8RDKdR8Rb13aoopr8iSFAbYOwm5KIGZ8M1VQzOGu7TAA
	6dV8Xn+wxLPzdBMDlCgE0YoyzKFuC6VBB0Eu23yZHA23f8r9sXs8muNF3oF9HHV0e87IQXCTa2S
	Q//SK1hTEIggp0EyrQreQwir7qMTSnJlCw0QrlnA7VPCDLgy6sY//Vq7w5N2pzS1suMePl8h7M5
	NLcm9zfXt019W3QQ0vYirKSaS/Z3KZZmbgbahNVAmKv2aFw9c6x3FO1XPdJW7MKxo+JTePq98vX
	GFz9f7xCFK3H8dD/eJh8YptbWH1BFMgj8Ch4KmIUhiUcrIss5JF3sWRlghmwnP033ubPfTLmL7m
	AJDY5byuqE5FlH1+Rg7Y6LV
X-Received: by 2002:a05:600c:c167:b0:486:fc5f:1ab9 with SMTP id 5b1f17b1804b1-486fedcbeb7mr182654785e9.14.1774304286668;
        Mon, 23 Mar 2026 15:18:06 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711693a08sm3571665e9.2.2026.03.23.15.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 15:18:06 -0700 (PDT)
Message-ID: <4d8eae17-3b95-4fba-82e3-1da6b53c0a1d@gmail.com>
Date: Mon, 23 Mar 2026 22:18:05 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 11/11] sfc: support pio mapping based on cxl
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dave.jiang@intel.com, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-12-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260323113117.2352709-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/03/2026 11:31, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A PIO buffer is a region of device memory to which the driver can write a
> packet for TX, with the device handling the transmit doorbell without
> requiring a DMA for getting the packet data, which helps reducing latency
> in certain exchanges. With CXL mem protocol this latency can be lowered
> further.
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Add the disabling of those CXL-based PIO buffers if the callback for
> potential cxl endpoint removal by the CXL code happens.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

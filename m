Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6897AE7C
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690574; cv=none; b=oiNa+DEz5perEFNBFs7icsqNyn2kuo4n6/lvhIjvCjALsFdatOQO7fqYiOVwRIsKqDtU/eL6w9NHUR+KAtXGlXgTmwhE6kzsaHDShxpoXw63X+g5+qiy0CrJz6sNsnAIKfXlfRfMEZyavUBMM9pRjp6P03m/dTVofVR5nyG3lQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690574; c=relaxed/simple;
	bh=XXfjYSKyK7PSGERT9cR7X9BLftE8LaP1K1MWP4ezhWg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pOHZVvcBqfT08xPTiivlxCcrPMn/lxRxnlm0jOtPLop1w8S1PebHTdOhQikANTux212b4f01lHlhl97WW9GCOnurx6UZb0zFAMXQaowgeEIMjcFLCqhOIlL2frVsMfZiTFrKh/9rv4dmkJn1d3zT7gxPFnqv7Tw8xEyM/JPq5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtwQt6mP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtwQt6mP"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d731314e67so4749245ad.1
        for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 04:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708690572; x=1709295372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=liGPk6TzyipF2EkGC5C5VT5uk5qnMjBqkU56Aj0oaVE=;
        b=FtwQt6mPZ12uAJCYDYqfDnh5cTu0zTq1karVcT0BMSDP1HLAhcLybx3GGFmlHeJmhW
         mDukRRigX3yk6nWLI4G+QhkWOvVhQffiF8fPIjBhr8eCGImZChyyaZV+eieFWL5dgwm7
         O4z2bpAkAH5Tm6mOxrMR0U32PUu2WyTt1hYqx1Eu1Zc8j1kzOxyLDnLN3wQxmbFJ69JP
         yEDhpIDym3W5TF/MrOJj4cds6lkefByFNoCjUTztLJoFattdKx7b8SMzKmr8lLxO2c/r
         BqzuvvpCZ9IRWdZNPc9oN9akuVTqh0ypgPrR2uxXiQjtPCT9NcIlBTgdM4g9rUS47zMv
         0iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690572; x=1709295372;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liGPk6TzyipF2EkGC5C5VT5uk5qnMjBqkU56Aj0oaVE=;
        b=vyyl/gxpQAyzyJq1ASeMRHipp+mTJRVh3IBj0uTjcAVtHVxsCkt96MB2rUQSY+Bdl9
         aFlbI3bNAS261+RFmP71WnHm+oMjts2h4lQaHsM+5dWdtqYIBBpjhDchg99BicfoOAaU
         7TL0s2wnXIXjcMknY+IPSamcIOvprXcNTAAfKncILvJZhMXse1pmSxQHQGjmOGxdPJ+U
         IwsJNMukAsqsw4zmK0Z1zwjVebU9oOA6CxulTpQDBG5yszW9KN+7aOHOnnONPLVbwhMB
         bAnPecHEF/Sc2i8jsneOqr14ha5Zbjl+kBzNwqs/R3UTQuzzQKmla/YUnuun/hWTsZbC
         JJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+iTA/A3RBJyDVUJmqK9qmTPyYEtDEth0F6hFoeHpBvs+vpVLbHoBUW7caX7OsTeFuSlbVyJtOZlKgHiUfdeWi2fmwPnXWtDnI
X-Gm-Message-State: AOJu0Yy9Y1Cxiy2i40dsvA/r0YIXOIKT79vBy6Lfi1J2P5IuQziLLi6Q
	uuvFS6nPRT+cQav+yWo6nBripmURSSo1B+ukGPsTWMyjR1wNCskb
X-Google-Smtp-Source: AGHT+IFU8YdKN/dHPvCC6fzGrj67uMLL5vUeoVjuOlk3cvj+Az3TprmEw2T/vXWIrEQQFf48CHLlgw==
X-Received: by 2002:a17:903:2307:b0:1db:f1e2:84f4 with SMTP id d7-20020a170903230700b001dbf1e284f4mr2041534plh.38.1708690571879;
        Fri, 23 Feb 2024 04:16:11 -0800 (PST)
Received: from [192.168.0.9] ([121.137.152.114])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902c99200b001db6a228c3esm11432557plc.307.2024.02.23.04.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 04:16:11 -0800 (PST)
Message-ID: <4da6524a-8a30-4872-8168-441105e8f7b5@gmail.com>
Date: Fri, 23 Feb 2024 21:16:06 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wonjae Lee <wj28.lee@gmail.com>
Subject: Re: [PATCH v4 09/10] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
To: nifan.cxl@gmail.com, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-10-nifan.cxl@gmail.com>
Content-Language: en-US
In-Reply-To: <20240221182020.1086096-10-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-22 오전 3:16, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Since fabric manager emulation is not supported yet, the change implements
> the functions to add/release dynamic capacity extents as QMP interfaces.
> 
> Note: we skips any FM issued extent release request if the exact extent
> does not exist in the extent list of the device. We will loose the
> restriction later once we have partial release support in the kernel.
> 

[snip]

> +/* CXL r3.1 Table 8-50: Dynanic Capacity Event Record */

It needs a spell check. Dynamic.

...

> +    switch (type) {
> +    case DC_EVENT_ADD_CAPACITY:
> +        break;
> +    default:
> +        break;
> +    }

Perhaps this switch statement has become unnecessary in the revision to 
patch v4?

...

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 8cc4c72fa9..19927629c7 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json

[snip]

> +##
> +# @cxl-add-dynamic-capacity:
> +#
> +# Command to start add dynamic capacity extents flow. The device will
> +# have to ackowledged the acceptance of the extents before they are usable.
> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: id of the region where the extent to add/release

How about just using "add" instead of "add/release"?

...

> +##
> +# @cxl-release-dynamic-capacity:
> +#
> +# Command to start release dynamic capacity extents flow. The host will
> +# need to respond to indicate that it has released the capacity before it
> +# is made unavailable for read and write and can be re-added.
> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: id of the region where the extent to add/release

And here. Only "release"?


Thanks,
Wonjae

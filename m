Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9E14B814
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628831; cv=none; b=rkr/3Yv37VsZrwQ0Y008bkxCGr5Q24Rs353fQOJjiaclCEkI9S/UM/EKK3Xq7Qhwj3iJx/+lN9qNvUBaA9w77iZ0pmv5zEet7UtF1IpPoj/Ey+9mMQ/R6cQowVRljaP2eJnCBX4mOTWthgYe5XMgi3UhrL7yYOxlI//PmNhcUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628831; c=relaxed/simple;
	bh=2V7KZ5kBP4xq46kmE1QebmenXznwKEZwKf6OdNGzdD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4FzKQIZRBABStqueIbcESohyig3A/E68LKEpl6ckOn0KgPC9Pgsg+9amRlwvEqYVtoF6R3n9SW/oBtUUmWXPZid/e+OBEKnk04KRRZFIBl+kP/8wddco5Lcum9PiLmPL0tdR7lVYqDUk81O3f6bSXk6hZuCnFXsDllx8eHaSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EefCq0aG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EefCq0aG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d746ce7d13so58430985ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 11:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708628828; x=1709233628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xpp4DmdZelqa3/qJH9FOo7tBbfaeZKlhtvUdGDFXTJU=;
        b=EefCq0aGz5Lg/8Ri2DD4MoOFm8xpsW7q1pwv/K0fsk+M9DXEQDlkfbPseZvIjNg+Xr
         vGCi0Amv2ZKIYy1pM0IhBf/P0+8arO5xqKOffhRXUgJZM8k8nasYKXvzthfF9DA80m7e
         JantbWx4e/QmCD9BJHjJxuHTOLT9F7nUA3MLQg7eQkjjyDpgfijOVZGQJUDuIwIiM+1N
         ifOb9bwdFRy9CZgA8LSkMZtsovCkDNxl7hvJCSzK4tTT/l06O5b6DG4rNPci8nRc9y5G
         tbMuuCzXYLirwfuQ/64k1g9fLdKKUcbRkQDGhOQy+77gC3IxrMAxvhM0vFY6GbwAg20K
         t8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628828; x=1709233628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpp4DmdZelqa3/qJH9FOo7tBbfaeZKlhtvUdGDFXTJU=;
        b=nbNBXR96ji9kre7ePdcsmdKGCWNKkPz+mGXBpyhgB6UogyEh2ND4FLhnF9FbYrzcl1
         FvJ7IGEChwojwaPyh4cwE4g3NGfbgoUSe7NdswP7Ym+SrjVmMjVvjL43LA9KW0Yua1ZI
         j1+T/WFoCS0du/bnm28jnxZBGsf8VjAjT4CDqAiUUbxaXqBwOJU3DWvXQmZKqCohlvnm
         20Kcz/jH7PVfD0hZ1IeKcR0eYLTHrzH96PCcsRcoiyaEzMe8TEn7mNLGPdc2wXaQf2PS
         ohBKUN+5QH8jIbztmG8CuWdUiHP0MyMEFXnoOqyVsqJokXZDlI6HjYpJbz1gs4saHvab
         LRJA==
X-Forwarded-Encrypted: i=1; AJvYcCWRej9bxpu0YEH4rTjuUDCuGpwHIDWUEJwVQ0HSV3A+mvi2THyk8UT+osyLUMsvFr1Vqv6TyyLNSmK8lpVSXr8Y/9+3iFvsbD8M
X-Gm-Message-State: AOJu0YzsC4dTvdOe4tXlu8nquSjwBIhTLin5CFU5sZFoWO63YKsitdGb
	DebVEw7dX58n31X3QIbJL5QRVIcsg+trkzq9LWNihvW8ZyXOUXgjej94uOEK6AChMQptEeMeSYx
	X
X-Google-Smtp-Source: AGHT+IHYPc+1zNyyTsVAXwA+p/shYQGyroZNvCYgD8exWDzjPlr9OZ+6sz29FkFBS4Cg7TRMOFO+ng==
X-Received: by 2002:a17:902:ea0e:b0:1db:eec6:5b9e with SMTP id s14-20020a170902ea0e00b001dbeec65b9emr15783481plg.65.1708628827907;
        Thu, 22 Feb 2024 11:07:07 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com. [173.197.98.125])
        by smtp.gmail.com with ESMTPSA id h22-20020a170902ac9600b001db5eb52911sm10315032plr.89.2024.02.22.11.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 11:07:07 -0800 (PST)
Message-ID: <1cf87044-8830-49da-92c8-406316260e51@linaro.org>
Date: Thu, 22 Feb 2024 09:07:03 -1000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3 qemu] tcg/i386: Page tables in MMIO memory fixes
 (CXL)
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: linuxarm@huawei.com, linux-cxl@vger.kernel.org
References: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 07:31, Jonathan Cameron wrote:
> v2: Changes documented in patch 3.
>     - I have not addressed Richard's comment on recursive locks as that
>       seems to be a more general issue not specific to this patch set.
> 
> CXL memory is interleaved at granularities as fine as 64 bytes.
> To emulate this each read and write access undergoes address translation
> similar to that used in physical hardware. This is done using
> cfmws_ops for a memory region per CXL Fixed Memory Window (the PA address
> range in the host that is interleaved across host bridges and beyond.
> The OS programs interleaved decoders in the CXL Root Bridges, switch
> upstream ports and the corresponding decoders CXL type 3 devices who
> have to know the Host PA to Device PA mappings).
> 
> Unfortunately this CXL memory may be used as normal memory and anything
> that can end up in RAM can be placed within it. As Linux has become
> more capable of handling this memory we've started to get quite a few
> bug reports for the QEMU support. However terrible the performance is
> people seem to like running actual software stacks on it :(
> 
> This doesn't work for KVM - so for now CXL emulation remains TCG only.
> (unless you are very careful on how it is used!)  I plan to add some
> safety guards at a later date to make it slightly harder for people
> to shoot themselves in the foot + a more limited set of CXL functionality
> that is safe (no interleaving!)
> 
> Previously we had some issues with TCG reading instructions from CXL
> memory but that is now all working. This time the issues are around
> the Page Tables being in the CXL memory + DMA buffers being placed in it.
> 
> The test setup I've been using is simple 2 way interleave via 2 root
> ports below a single CXL root complex.  After configuration in Linux
> these are mapped to their own Numa Node and
> numactl --membind=1 ls
> followed by powering down the machine is sufficient to hit all the bugs
> addressed in this series.
> 
> Thanks to Gregory, Peter and Alex for their help figuring this lot
> out. Note that I've included one patch from Peter without a SoB
> because so far it has only be posted in the discussion thread.
> 
> Whilst thread started back at:
> https://lore.kernel.org/all/CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com/
> The QEMU part is from.
> https://lore.kernel.org/all/20240201130438.00001384@Huawei.com/
> 
> 
> Gregory Price (1):
>    target/i386: Enable page walking from MMIO memory
> 
> Jonathan Cameron (1):
>    tcg: Avoid double lock if page tables happen to be in mmio memory.
> 
> Peter Maydell (1):
>    accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper

Thanks.  Queued patches 1 and 3 to tcg-next, and adjusted patch 3 to use BQL_LOCK_GUARD as 
suggested by Alex.


r~


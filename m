Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A55C368294
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874871; cv=none; b=rhp0uN0HwQbxsLKVeAfp1vtLfDQTc+BegIHWiCjXCP9WO2jqa2Du63fJVDn20CsfbdKgD4LTjB4UTi8b+agBojrYe8djCg5ZLrzCLEdV/Vhl2uRMekDPh7noLjcBu9rBhr7mDxgCx/1ev85i0uxk0DaRHLZO81wvwNxiHmS53Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874871; c=relaxed/simple;
	bh=RrYFsFP0tXNmnqEzs6qL22aT4go6mN+DaVONZ5T1/v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2njVdLl+oZ3p/vGq3jKMQcw4xpgCmHvT2KFy9FHZKvpqrEywAEdpcQoLwt1QV+G4zcwX4CyQKhJBVpS6CxB7PrUTEria70pEu+KBdrNyMTJsgOuKNzH+F1ekfKOiQNGyX31JQXj9Y1lOUl8DHxwelfJKpKehUP3nvE31wYf7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU0hfpQ2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU0hfpQ2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b7866869so20059425e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781874869; x=1782479669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Itjwnzaz3yMi0+4/X+y09zh3lVlh9HqeVBzmh26n8mg=;
        b=MU0hfpQ2zeVuVWnYSdTQJ9j18P74CjrrOYZ7+MTvfRNIZrjcBolEzdcJG6A5bTMuID
         Hna2ZoyuDPGFjco6OYCns6UfzlHA7B0nTK4tt92Np4jAFtC5FNUjyNgm8IxGcmFfgsaH
         6M4NDmGns0y2HTjMYEg6eMtYmxM9B7xYnOzWjG8kYP5MtmK1Oq4n6Db6vFSQrDCkK3nv
         WqPV2lqWJ+F/XN1W9nEQ6M2B+kEthLUGjOnejaRP3lxbO8bacelwWTPZrCDw35FvuLLW
         d9Es1Is543ZYKAI9sMguGT+mJhvPJcnS2qfhJ15TaRWZqJKcIkdfkA6pcewJjrJAWDnk
         6/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874869; x=1782479669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Itjwnzaz3yMi0+4/X+y09zh3lVlh9HqeVBzmh26n8mg=;
        b=KLIu6G4l/LslmrlCnPzESbRecxz6GBXyVWkFm7PmDQHfi4/UhTJw+7O0HUc/F4gZoJ
         NceDGuELKdp3S5/iP8TD9tPyIkytZiV65L1xNoNQwVPMF3ExLqGfuIQbBBpb7mVhrRTs
         pXQqX/3/po4/8AQ1plDhkTirL+/jmhcNpWT2hXrwfKSMCX1UGTlu2d/RQUfwhluI/y5K
         wDpDAkfzmWmLAoM0Aby0DVJxYtVD2xMyFs5k4vSFQZF7KjYb6WnMrZ5uycuXvdCWbZS8
         pg3BYSQFYEOLNUBJBIz6yAdMb/qJLUxRnkNhpSD0gVWJR0ZmqT6by8bjWCdsozecfz88
         iJdg==
X-Forwarded-Encrypted: i=1; AFNElJ/J+Y6cbT+4dz46u1Jbtoz8iXpCSmShqkK2GLoGimbtE9Dub28DpAhQC/zl5Asy8RtEKCqc2ATgR78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAaeLpmyBP2xAl3Q/BrT1B62X39a70/5k+JA0hPal0ip7LHgnP
	6qt5iy5iB90ydXpwBS+/LInpn7T1q490cFltaAH7uU8A3Kx9sWyryhwA
X-Gm-Gg: AfdE7cnH4feKj6yvXP6oWcxb2EPTZdkBfDxZpU4K8AHkr76DHjXwB51tLVdeB6Rn5At
	rYe0v7XQBJD4dPbvWPpGFusRXBe9tA/23bTJLWkOXtuuudMom4enk8LjcMZmhhdQa9Ft4PaGkMx
	xQvt/hgus8w2vMUvmwXqLUCfTSsWo9kephnLr/UR+3AjDw8PA8h/1m53WeIh1AJQBg0SQusZr1V
	T95vqDXzLRRmtjkG/iQkLEjin8REQA+QjQUCHUYe2tTsUQ5WbjZoS0rnRHCMdzc2IP7zw4S3lfd
	KojbQJGktwov25hb04tBvedEVuuApbrQqoZgKGhzP2GcgJcVJD+bNBHIDNtPPW6cvXDwVKpW14S
	d0YXpGLtTjyewQ4xh9Q/1Yp8B5OShlC+V22ZWHpsGgTxss34UOKz6PnH73dyzlHdTM2JK+tvT+m
	7Ytaj/4zHX/p9QOUjNi/27R6Ty29PoVjanOtKWPZqLSw1gKr/XIjTAHZFEaggbQ5sjOPyPxub1h
	Oo=
X-Received: by 2002:a05:600c:4ec6:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-492425706acmr41616015e9.19.1781874868944;
        Fri, 19 Jun 2026 06:14:28 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650c114a50sm8990375f8f.33.2026.06.19.06.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:14:28 -0700 (PDT)
Message-ID: <46d1effe-4a8b-4043-85f7-5ddf8803ca16@gmail.com>
Date: Fri, 19 Jun 2026 14:14:27 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 2/5] cxl/sfc: Map cxl regs
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-3-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260618181806.118745-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2026 19:18, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Export cxl core functions for a Type2 driver being able to discover and
> map the device registers.
> 
> Use it in sfc driver cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc

Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7852191F91
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027333; cv=none; b=S36/XcYgDEaAgsuzZqvX+R8LgzrQ7D4ymz+IeRXdtdxbvaAIFIPH56L1hcBqxZ2NGF10JcwMh2UfsNI4SeHNcutDWdu2I/xZrZta+aVU6+i0Vb6z9visvMKHTTCLc5NERBZEEW8y0xfdrrNzTBC//OxXb6I8unYAJKeBtap1Gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027333; c=relaxed/simple;
	bh=Mg3INqOpqyAJhgaigqIT74zNX+BsxY72Qaa/OghquoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5DX+TgkT52rr5yIHyVy3EOVtZsGo6tT24fLUpoxXpot2IaOj/loHtjTa1EfQPnHsW8jUtjiu5Wz4PSJOel9Ak2a2cdzIalCHallB75IQAkqfDEJ41XAxk7Zl+TP9RMQjgg5pcdhqDLbT2kPH1gbaDkxAHtVDY2UQthU1cRGyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Alwmjv+M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alwmjv+M"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so16344415e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027330; x=1774632130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7i5Ias5YzraA/kA03DLV1PJU1eKcypCkeyngdorE2no=;
        b=Alwmjv+M5k0y9R/2GA6Nc37Yw6ot80F50v8jYhjw7BP7ImyVR28Q1P4bUBfb+QQBlI
         7og0UJI2XH0WzPOWdythlQWxh3dpIuXF+4Du8D9EFxwWQIo4hYnhLBbZSCyntozLnL0V
         HWuPyV0rEsZgrNQRwPNkVIhIBMy5E9xN8MBTe9P16yoM+sEaT36Gfx3E5Z7/6B+m816Y
         E2zHhvb/oBIu+55GhIkCSS1KyOCiIvPoYQh8CWrscTQJutc4UoyJEQeIxdkLu/gNVoyt
         862PEayJgUyGjwFPeCCpvhVgP3kyFgcMMRRywCIK9OJLU3l4/hDU41MA0ttMSu6DGheL
         Xyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027330; x=1774632130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7i5Ias5YzraA/kA03DLV1PJU1eKcypCkeyngdorE2no=;
        b=MMLpoXrjwT4Oq1HLbYTG/DrYsyzMduYbT6FjeYsfh69+rUET6ubbn0uOf4doswss4+
         VPz3MEslHHNADyjnmq1kZg9+jE4ouLxQ3QjVMhtJ6z9ukYScfFMFPUZKk9Fxkt4NO6qJ
         DoSVmWa/cCj75Bii1AqaF3+MygDCaMJo/tqaOORpzhtJYm/9+909fHybH6rNTV6PflHU
         9t3BX+0ooPcsCzWv3i88qUkE6hybFQ8tr4g10Hf6LUk5Oo/hgQkkD6bKU0ckfW6yGdjV
         eOSEexNp1EPuVKT/9wZIVavVkDAxaytDwyb1k9kgkn0kKHn/hPfX9o9tvqr8g/d2LAOp
         Yj9A==
X-Forwarded-Encrypted: i=1; AJvYcCWczfqgosCil0J86ndbqGIgiZwuHBw5oylsb6nzZ1aVMU01S0etMn2ij7HYoDNzHOuCoYj/ajHkBMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9kD0nCpAd3zQTePvIXYL2Mjq/EqbSolspZD+hMIMJ5BwqVfQ
	ekr78UL7pCpq+UhNZVJLrLyypOF5pcP0GRJvge2fiVFeSI6Y0fJKUNyF
X-Gm-Gg: ATEYQzyAOTB58DX/q2cajZmffoTjZvdnwGAOK5XlzSjxcNnbF2eLGAZejO2Z47QhLEK
	mVyCTW5ht2OzYZcikIjqlryJNjNenpB1elCJS8EOW/VjHvSsJZ9URWTIgSxfaZ24/d2veH2JR+d
	wehdNz8HZKz0NggBoIPDyAsGf7a58ZSEdSq8pft09sBB3SUH7G9Nd3t63x6HjurUSk5qEQElQtt
	MVt2WAucVC1qPfq5ZE1kgL7Wot58yLwVzTDaQ2Ah4/2QbBWYXu3nh2sKOdiej8G4i7WzpQjWhiw
	ljKv1GI0vKovwhkoNQGRdRUptHqWsTX8I1baXuda+hJVGrgOHKdiEfe2gfsAB3YzVi+7o3u8kLH
	I5qXzCGWUJCYjzGdXq34GCCwHYJS8c+H9X5SbcgGw2ePShvnS1BDzkSruztHSX7806NbmWWexI+
	FFgkM9C2EYhdJMh9LCqTzTGQ5zGG9uQw74cGZNzYdTBbsqAwjbfcrDBHWguLHuyGMpYbUMrnDN3
	RyP2xW6Q1OnzwdszusAEgyc
X-Received: by 2002:a05:600c:a312:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-486fe8b7afdmr54233265e9.6.1774027329805;
        Fri, 20 Mar 2026 10:22:09 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe87c815sm22104765e9.7.2026.03.20.10.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:22:09 -0700 (PDT)
Message-ID: <a22be11f-00b0-4351-9fe2-1f354ebe451f@gmail.com>
Date: Fri, 20 Mar 2026 17:22:08 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 04/22] cxl/sfc: Map cxl component regs
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-5-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260201155438.2664640-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2026 15:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Export cxl core functions for a Type2 driver being able to discover and
> map the device component registers.
> 
> Use it in sfc driver cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

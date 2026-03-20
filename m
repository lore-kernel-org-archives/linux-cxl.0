Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9D3D34B3
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027460; cv=none; b=o/PZCgviWGHkyd5wzm2CXH3mbGEsG1XvUhq25erJ+yj+Mpbgf2tn1N2btXZvAkrrC+RihNk18z2aVJBgSfHdHb1mqw/3JMI0iHNanLOApj9PBflFMUzTto/5tZSH07G1ylSLzheBSK0Z8g35yr50kbjlFZtAlvU83Q8yJSeLHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027460; c=relaxed/simple;
	bh=wsmTnk81qY4dZoUf8M2YmiGOl4GG74Pq87bDkle1jHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqgHN6vKyAaYTD6l0u4eVKPr8tFS5H5fIR2hG6hoqLP1fRrAIKf1n6/o10zfMDKVSzcW6pAD8SOkyxrxG6Xd61gqRRC9kxKf5k2LGwhO6Ig+hPNTFGN34SRHM26Yf/uLVRymTuOw69LlcIdarmJNwTOFhOwIQu4jcfx8DxYBaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgM8RBFS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgM8RBFS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-487012ce896so4159125e9.0
        for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027457; x=1774632257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yw+YBmUR+wFyaejpDUu1Z5+Dr5WPXPB//Fj4vKcC1uk=;
        b=hgM8RBFS9qX6qCsJWHlkQP3vp0lo6uBY6wtLy8deXU2qAoA2xPxWDTctBamYWaghNA
         Ezx0IiyJJFEmxNze3JpoY2/IYFzlCh5YEKBBCGihMyEADtQA8doJYiVM8mmxd7wvVQob
         UYEs6KTfHV6Y7hq6LqNWr9Yc8c0uzRr8/6Mtq2H25OARNxPoMBev2Zh4dPJnCMAjMqLy
         bR+e6tt5nnd9Sr7FUFRzN2BzRQkx8ihoH+WDG/b9cfpKmJz0KWiQAWig7/j6K3qJeoLG
         IZrs2vQL5MS7CgAqStfBKHuOWVtLmz9NDcWxNBgUDbT5kNwHde3zmx7eQA/+zA1LUXxT
         C4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027457; x=1774632257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw+YBmUR+wFyaejpDUu1Z5+Dr5WPXPB//Fj4vKcC1uk=;
        b=DgRgAMZxhiapMyccySZpEVNmzyFdwIe5COX7V/2B3DzR2g/gf8moFg5Mx//61IeQq5
         C9gGZuQJkSWVJgzaFvY8EyXWx3oipFoohipRnIodyChFYGc9tweFZhR1KMks/G2R8kO0
         ADCqeGVt8VlQ0SfgtCHasb2LPCXNFWF8HyEkemaXD4SwWO3zyR1vc80UsMw33jmAgaKa
         ZD0Hfi9BIHk/1l0wp4Y6U0m0xRWdrazVykW4TdTCZaRO//TRgSNNDh0WHmhvb+L3XrRJ
         3Mpqa5tGKItKxPKIvZaiUHH/mNj4A5cfkiO0+KSBqQcW2YT/qL+OEywpep7F+q142IhO
         hqzA==
X-Forwarded-Encrypted: i=1; AJvYcCWX4HWdoB/8U3y8eoHdVAIklnldibYDadrtSG8eyVvBTBzrO1552nuTMg+mQa0RGu1XVLd+f9WQmsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrGQYMFnomsInw/ZPfuK1ejFg3wvROXoTpbht0mTew6gaIY/Aw
	j/IfB8T88aAjNpwiaMHZ55bbaVWb+P277SeJgsNou5LOvJxcxTQIlyD+ydXIDw==
X-Gm-Gg: ATEYQzz5Mh1j9c7KTlexP+8tpKWZVeJWJQCm2bhghD2Md8UW2EhxC9WFPHpqSzq1U4/
	IK0syTH9ZCXka7ZMd+uYVE5DMjRrq52W35efbt6e7bh+9C1J62Y9vE8l/OcIPFq1yk7fccTq5bI
	jYROmnfT4FaVIOuaQEIEDGEXThjE59ynHT3uvvadVajc3kGFKHF/xKbKt24tK90pcLX8ixbcLFl
	yH2P5Az+PcxxUthtmASbtW2B+0IgJbhQ7lFZ0tOiGtewaDWQtt6Fmf4DOqm5ciILkKJNYbcVLb8
	HiMY4Z2jLntpy9Hsq368scOZes6pfuo1nz7Krpz7rTPSg4X1AAifjticIDbgxQXTl7jRD7Yd3Z3
	IlJvufe34ZuluP2KRzyNxrZsbxqAI+saoEfi7DQbSZApl/7s2+xhIX9s2s3wQPhWsHqnNPTfq1P
	b//UpUftEEA6CzkG7K2I11h37GWRqPEu6SDskYbCksCQ8WBWWLcmhb//j7AVlngrDU+K5uC23f+
	w0mMai9uBRDTA==
X-Received: by 2002:a05:600c:8215:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-486ff030a77mr54538195e9.26.1774027456678;
        Fri, 20 Mar 2026 10:24:16 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8ba4a74sm148279435e9.12.2026.03.20.10.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:24:16 -0700 (PDT)
Message-ID: <59fe77d2-71e6-4b36-b8d7-0e465c7f5ab4@gmail.com>
Date: Fri, 20 Mar 2026 17:24:15 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 05/22] cxl/sfc: Initialize dpa without a mailbox
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-6-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260201155438.2664640-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2026 15:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
> 
> Move related functions to memdev.
> 
> Add sfc driver as the client.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

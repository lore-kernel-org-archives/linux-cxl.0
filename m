Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D637475C
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709987; cv=none; b=nJKBhiEf+GjOR/FGJSqvMC2AvIBsBpl3jUztX5Yg7XiqCRxVvIuKXYNs+7cizrngyhwRwL9AS19voIDrnCYSvYzQymILgC6YDP7jYA+bishMEhpLx7fDig6jVe8oN8zdmRPG8o1I6IbQgFw2CAX9qN6e4WrP82J/d06wvqmt3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709987; c=relaxed/simple;
	bh=1e5FmJqr0d5Nr1ikMsAxK6bIvG+kQKpIeszylR7qdmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfdUxL1jRH5kT0RSHBci9KV/b4njeUzAWcF6lenXI76HSlnGyVADLXg8sO5Y58taV9yo5ot4X9NYcHvYJIz+UMg7/REBSKzE3qZWf5jzzlP5HeGXFLELWdjuRp6uSdy4J9qmRikKzv+kYkKbLLtaZHZyo8j2s8NiICy4M6xChYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=N3zqnHq7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="N3zqnHq7"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82984c077b2so346311b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 05 Mar 2026 03:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772709985; x=1773314785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysqjtnihLzlMKmZvTnyQ/HF3OaRcuwAeEcdn2G2RcKg=;
        b=N3zqnHq7jAgUcauG/TKePtAtMHzaV2BTqTTPlVORTHCRmY9tP9kpc6bxuU1X5mXF69
         9UWFtTD2t1Ekaa0O0Qp2JCAw4hZbjjClKwR2T0harDLeOAz3VDPhnh+AzlGBbm+zqW/q
         cux0lPNYLLKTbtCJu9hiMzvNrQHlWXpwEugITs38h57ykdKkqeR5HnUuxKAAn05CoI+N
         MH12kP+oDlGiIUH7kYLFelTqfILyltVcZQRJHFpK7eY1Q1mNht3uU6kU6kEmwaKVpljC
         ulDa/dwV0A81v8bsZfk99RBss8Y6UbUoU3jLHTay0+ZCdaAuJW1o/qVFbpcvzZmu9CdE
         zE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772709985; x=1773314785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysqjtnihLzlMKmZvTnyQ/HF3OaRcuwAeEcdn2G2RcKg=;
        b=c3I45O4r7nCr7CEhC4GuHEidz88GbFhInBbiy4sKVlYRvxbkdjOqL5Ik2RmikvR+Ig
         RV6twG+xF5g4R9+YCN9MAwEJGlQkHuoZeBP0Qs00l0K1zlnDSZtXwvOufo50Fijecl2K
         CZAC6fyBKDhgGAVGAR8zaNsdVZsHigDQM4fv5Nih1kofm7Qd94meVVwvb9RoOVPgs2er
         5cohec+pSRgyLXHt8xIU9lzZHI/+xPjPOXhb9dKkpgkuONezMsx7W2i36EVnEmApebb6
         5HWvUC73bw1ibJeTZFT2DWPMAn/3nbDtGhp9wbANjTGalApbU1e7fBDbZscUku9UxzCH
         gWQg==
X-Forwarded-Encrypted: i=1; AJvYcCWlLpcukm9Z0KL8WfaXuV37BKeYZ6b6q4tGVD/+qHgNmjPcOv7RHR6SnR0JSCwySE87+BnmPHUSUcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvfzM8mgHnbFefnBzW8MbgR8hWZcjPb1qSyBeFWTDRleBPZjc
	E+CXkP5R0TfDvGHVw8Y0xkAjt+l6hJEFtQ/3TgnzHxPF9KA65bXLbF3KZj4Xucof+cw=
X-Gm-Gg: ATEYQzzLvWyHAfafOFTWXJmwDHlDYvguixnzKfcXETDIkOx8LDsdDxAab8DUToXn74M
	cvW+HbTLdYUds75pqMUnpfdc37wIDi1uAuyqQzmS/M6sgcT+uzPCcyMfNvqOjFamI0Q7TFxmbSp
	WrBbzL+AbJQgCxTXj5SRX1ozqfRIF9bNJz0LMEs3i9SgEn+93dFmt6Rms0OhjJiF4yKfBS2rgZF
	Ja19p0YYI6+0qflqZDo+3mCLD2cbW+K56zjEe4lQcfmUJGo49vLkCkKBxtmOlhUX6SKiFcKZYE9
	ELIJPU3q1h7rUvXC7rKECFxsZcJkSQxH3f1b+0BZjIBM5d1G6+3Le0PbvTFzKMCb+EkSt9C2WGh
	iPFvhYgmey5IQ+Ia+J8VsB0fGuY8rAQu2ldCJ2zEGtED++b4D1QNiV/4YQvdEIlg6l0yKYnWGA/
	tZUJ9f3sR3XIc/All45nO4SZpYVWhGPvOmjDVYZoajimU7oeGvLNQZorDqyeY3b+008ehopqpsn
	9ha3ivDER4=
X-Received: by 2002:a05:6a00:1488:b0:81f:23b5:dc33 with SMTP id d2e1a72fcca58-82972c9eeccmr5183569b3a.30.1772709985579;
        Thu, 05 Mar 2026 03:26:25 -0800 (PST)
Received: from [10.54.26.107] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4e10csm21738076b3a.1.2026.03.05.03.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 03:26:25 -0800 (PST)
Message-ID: <e705cd6f-5946-4a8b-8870-0c49f8239d4f@shopee.com>
Date: Thu, 5 Mar 2026 19:26:18 +0800
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
 "lenb@kernel.org" <lenb@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
 "wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
 <8355402a-e4f0-42b5-854a-ee42f9505612@shopee.com>
 <aee45ef3bc5e62814b09db5f605270b3b376fc64.camel@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <aee45ef3bc5e62814b09db5f605270b3b376fc64.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2026/3/5 18:25, Huang, Kai wrote:
> 
>>
>> By the way, If insert real cxl memory but disable CXL_ACPI, how the kernel
>> initilaizes the cxl memory and assigns the numa node? can you provide the
>> related kernel souce code?
> 
> Sorry I am a bit confused what you want to do.
> 

" It only avoids detecting CFMWS, which doesn't provide any NUMA info actually -- that's why
kernel assigns a 'faked' NUMA node for each of them."

Sorry I misunderstand what you said above. I originally thought that the inserted cxl memory
was assigned to a 'faked' NUMA node if disable CXL_ACPI. 


> If you have actual CXL memory installed, that means you want to use that?
> 
> But if you want to use CXL memory, you cannot disable CXL_ACPI IIUC.
> 
> If you don't want to use CXL memory in your deployment then you can either
> disable CXL memory in your BIOS or, with this patch, disable CXL_ACPI in
> your kernel.
> 

I see.

Thanks!

Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209020AF94
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601107; cv=none; b=hGQjIIRdvYxWMR0QC+1VdlT6fOklqi4sWOUbk8IBkJdKnQu8wbR3fZTcMjRIaWb64fFrzWlzF+SHQEdk+WyZKtvlM5jN4yUY0Hq1ohVAPKVyy/Wgt5NcBEslfR9ZydlQsD1EA8lKaB83Z1Yn91DNcEHBO3nVXmG1kZmORH/ujCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601107; c=relaxed/simple;
	bh=2F0k44TwZ0iSKQB4qKPryoTAKgzt4z8FBTDJKafNbT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6dI7hoF5uCJ6kfIF30/mMg+0kuvcvWfs4lqNy8VAZ1WSc+DE1dFnifioIpjT/umdVYsB5QTkJow5zlYGZ29l6K87qWEU5CSgwjM6/MjttSN8OkK1xjK3/1VnHxdTfmvMoEQyX26SNLHKJQ0+tYLCa2wN3S7gviQ6jPN+k7DhJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LXHyg3NL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXHyg3NL"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso31938245e9.3
        for <linux-cxl@vger.kernel.org>; Mon, 03 Feb 2025 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738601104; x=1739205904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HwTx55omfIwn9vmPW4Ylr0tYSCsYYdwY9ilDwZcljFc=;
        b=LXHyg3NLAH/ceZ+E/xxrS92HkIWgMm0IKXsI4VBDt+3c0wuwPrAejJJEm4/vewlFmJ
         GjeHRWeRI69d9nWD38qAimyiKDncfnuXH6oM9dCDagIFTDbJjUpXEBWIWskWGPQRKW77
         MQovKgG9xxNAVyPw/R8fZOEGCNOqHNhudiAXyO7ZlIoLaKwzKXBU2EjK+CTdhqlm+/CD
         7djFLuEnOUA2mhmC8yJAX7SKuoidHthMUT7PS4SucADTEONp9vpVvQQZsJvDEvGhj8UI
         OSh1NW1i+c+n+QjhnpEjmXpnRkJlLw9X+tAVE7MKsObDRs3kQ2inOo8NH8gbZ0TDRg4o
         5YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738601104; x=1739205904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwTx55omfIwn9vmPW4Ylr0tYSCsYYdwY9ilDwZcljFc=;
        b=xUV5zJPljIeabktN/C5an13s74YoJuPkwLKdqeMatYmHIO3bRI3qp0tnC+ylx3GPay
         wa96hLIwaNWyGLf9Fs280OTxmIwbCNc/WXVrsZS6saJnIS7ga722oNDBgPnErvgpcWpC
         ozQWrEHqSEBVJiz8ER+oUSwCalC1qbcv49Xkr2yl4pXgxMgkoFw4PTdeUb+yOrpiktyM
         ij7QX9OCqkSuEd1lIzjeWY5Mof9lekUAuRaZhG91NjRMu+xXSGHUK0dRWOA+YPG1VXO5
         UZCF3mNhNE2cU30DleDz7sfv92U1glVmS//kci7SxyQSKTJdjwYAwcKO8HRAVmP/SgAR
         oJyg==
X-Gm-Message-State: AOJu0YwFXkwQ1V7sBGfNRkDAzZ1MxN4R1+ju08RvkOzMbwNUgEA54/K+
	vaIZtuAe4VUqacg7Du1Ene7KfndHbcYBjRkUlwM4R1RDfnX87g7UO1qOQliYLQw=
X-Gm-Gg: ASbGnctcXEbD8Wb/9Qu5a0TF2h+p7FlJ6W5Lre1QNJDCKqJglw4Ci3EzEw8s0jbkMDM
	XHlF0ulr9pCUBAa+N1VnnyByUVpqkcBEedXDVqoqZmOl7QVi8RgGFY0BabcaHx7OW48X0kCgNFe
	2DwvmYbgyYN5WSrUP5fMmhULKl9e43J4xa1oEvTOx3Sr/uwM8RHaC3oxCZRregWyt+2sdiCHQsF
	GYBaD9KjS53EDfUznYfYmaIBvs87S6JNsv7HHCiMUK7zOThTKKS/WulSJ3JDG6xJEY7/VJ2rnmI
	BTo1SxHxljRAXkYBD3zASdKoCn/B3e0CSf/xpuPtylgkYaVCqdG3QjDU8TU=
X-Google-Smtp-Source: AGHT+IH/O0uQRyvhpGuXfc9gJ4kXTe69ZsOfNxUpWc+ECBDc2zpsjT0tmJh4NG8D4a9J6c7DcPOmlQ==
X-Received: by 2002:a05:600c:1f15:b0:434:f335:83b with SMTP id 5b1f17b1804b1-438dc3a84aamr225539795e9.5.1738601104140;
        Mon, 03 Feb 2025 08:45:04 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ec7f1sm13038493f8f.9.2025.02.03.08.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 08:45:03 -0800 (PST)
Message-ID: <119405b1-d7ba-4d61-bf7a-e2b0bce32d6e@linaro.org>
Date: Mon, 3 Feb 2025 17:45:02 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu 4/5] hw/mem/cxl_type3: Ensure errp is set on
 realization failure
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, mst@redhat.com
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com
References: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
 <20250203161908.145406-5-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250203161908.145406-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/2/25 17:19, Jonathan Cameron via wrote:
> From: Li Zhijian <lizhijian@fujitsu.com>
> 
> Simply pass the errp to its callee which will set errp if needed, to
> enhance error reporting for CXL Type 3 device initialization by setting
> the errp when realization functions fail.
> 
> Previously, failing to set `errp` could result in errors being overlooked,
> causing the system to mistakenly treat failure scenarios as successful and
> potentially leading to redundant cleanup operations in ct3_exit().
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/mem/cxl_type3.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


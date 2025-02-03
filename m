Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129181D5159
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601116; cv=none; b=LShw5al/MkoYxCd9L1AjvKjYf16m6HEP740ilbmtQliG8HezGMdBySDp8ElAMP0fgFlLWlzlICAPW0eJ8bY9SPdpvhCEytaNYqt6nTX+v0/DVYI0Mry+lp+BbkKHQtFFYGkQG9CjWxTHdeH7yAWoA3bAHAyDDDGzSZqtvsygnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601116; c=relaxed/simple;
	bh=Ro1o3bnksOsqqvLrd836Vj6SvW2gsUvQLHxDFnqkIWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlIi5JAWTPi1xxrh4o+3g3v+Yhe4ZDnyX3BJT7eFEnxQjbVLQyX+Msfon6K4CCdbWIfc5H3r/oeU3fV4LrIZs/enpt/4pE3+QVW84+cqr2J07dr4UDjNzw/jt+gUwC+W7QEWjzMl/faNjoB1DW6Jg0PQMjkGaytnEX1KhCnzSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/eNV1Z5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/eNV1Z5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e3621518so2227477f8f.1
        for <linux-cxl@vger.kernel.org>; Mon, 03 Feb 2025 08:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738601112; x=1739205912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2huIyCIvHwLAJXOtgyL0NwBZmXW7RVzQ/ZAmobOuZg=;
        b=S/eNV1Z58Ion/7tbFkT4b2LnQ8MJ6cvJbfMpCzcEqmgk+72nqWClesmPG0uISjmgsu
         sYZBWvQ790G/1K5w0dXu8iXu0LkS5m+vaps1Sj4nlxtmUoxgmO6/P+AJ+USrwBXWkSUY
         Ar4JVrzudaRPNnhPQVEUaFPL/k58VDO1qI3MoEV9lXWExHul8bEdxZnxwtj/o76hQ46A
         6AitLxKRqebF8RhP5gPc39zuWJ1PNYc6viRYloa6z5n130sOByQ+NMBsaLg56SGLrLiK
         DlnqAoXWFTeSzG+FLfN8CNknZZ290+2nzk7SEmvA1NJlLGGfFWDO7chjFW18aEmlCOaF
         oYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738601112; x=1739205912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2huIyCIvHwLAJXOtgyL0NwBZmXW7RVzQ/ZAmobOuZg=;
        b=QZl9SYYlJvxRHGdMPmYeoqXsf/Nn+cEN6U4wEWQ0Cp1XTnTcBKZEQeOl8ywGjLTGHX
         HQcOXFlaI43BnVZbVGVIj94y0bj/lJ65aVAG0FRsk3yLJ0l4XoF44cbkrGw+glOJ+l+u
         gFytblieQc1gFdo6pn5Q1xlvpE6k7rK7r0whjCohr7ZVS/tmhTUNw1NK7oX8CT9KTJJO
         6pV3N8ZTDrM/kg5spuXBLroXpbHv0DZS8Rl6EsKdopgov/U1JPLDP4X9wkDwSPBSgg81
         kMAzIeLAPYVCKtnrIC+4yUdZeZp8c7QWd+eE6HE6C3dEIak+GpmRYm6ls5Mmf1KXuiYS
         NhZw==
X-Gm-Message-State: AOJu0YzpiDnVci3r9HthY3AKInEtmY4zH7KRR7HqPDjboNORcbrSjQIq
	er3I9g11+hHY3ZPWYeas2hccgbo1LcIqJDvOpIjzANnZvzK5Bj9V5NekhslzKRNjpiYCVsaf6jK
	ZuRk=
X-Gm-Gg: ASbGnct979096N83JvHH89EBcpx4vnywf/ru5zZhrr5zKDzDIHGMkxDxg5UmcaGs7dJ
	FyegfE6SoVM9rjbJKAW/AeVCZXhEu+H/jMlJunnADPtFkqkFRQJxS4AzKxiiZ9BZ/1+3HlOtXaf
	XzrYundswssnWxx1c3OdI3i31wsDiwY2UIKX5k6JeBTX6WF7SZMIKLfCinsIE1Ds8wSTX0zXIPn
	OqZPPAW+cQ11Vx6rvzYkYFnalA9HeISr0gtI2wTTpI8LA4+X/uG8q+f+Nyb27xEEnHGMjs8vVVH
	/8eEGTtXfkL8Y8NKXl9U5wo1chpMx8HAXITXJ9qOHNmPVz9sPI/MGse9kP0=
X-Google-Smtp-Source: AGHT+IHK1tjrD8UJaJcWAs+nVbyzYO1l9aFefUUfWN9/49zzSDe1r/xOrvICyBFIyqjgGsjysBg5yw==
X-Received: by 2002:a05:6000:4013:b0:385:f631:612 with SMTP id ffacd0b85a97d-38c5195f2e5mr17217671f8f.17.1738601112142;
        Mon, 03 Feb 2025 08:45:12 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c102d2esm13489851f8f.33.2025.02.03.08.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 08:45:11 -0800 (PST)
Message-ID: <75647ca0-164b-42ff-9d5f-368e1b838a62@linaro.org>
Date: Mon, 3 Feb 2025 17:45:10 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu 3/5] hw/mem/cxl_type3: Fix special_ops memory leak on
 msix_init_exclusive_bar() failure
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, mst@redhat.com
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com
References: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
 <20250203161908.145406-4-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250203161908.145406-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/2/25 17:19, Jonathan Cameron via wrote:
> From: Li Zhijian <lizhijian@fujitsu.com>
> 
> Address a memory leak issue by ensuring `regs->special_ops` is freed when
> `msix_init_exclusive_bar()` encounters an error during CXL Type3 device
> initialization.
> 
> Additionally, this patch renames err_address_space_free to err_msix_uninit
> for better clarity and logical flow
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/mem/cxl_type3.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


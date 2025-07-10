Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC669DDC1
	for <linux-cxl@vger.kernel.org>; Thu, 10 Jul 2025 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135119; cv=none; b=Bz4QYQH2SVQB/B1kHb6DVqKsmV/JWl5MXHfSFpafWGft/PzvMkHk9Iyvf0mrEruB3zkt4/SBzvYC5ywJHOITv5fMiEtsVHk7oYjQ5mje2PyQOS5I7WeU1fyFm3ciHqd4Ob7p3dGsZoXBeNHBtLhHfB3k7MgJIea2qQRM4LQeNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135119; c=relaxed/simple;
	bh=QmLo2OQyC2h2k/HDRYdEtNo08TGkMqGM8PpUJla2t+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BO8Z4XeSX/csVVZJSEcOXvkB7S7gJsCRvy7xisj7Vw0ivrl8mx0Gnm+5FEkv0bMEsR7cj/5q029XyVaugreuKCvZw6xX066xp/0rNmJbrwvWQBsWj6fYXmEsYjAwbuLt8k0fyDXnDgRcIOxyJMQQ5T2EYVIuTuGr0ZL9fgV6zYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MeRluxmH; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeRluxmH"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8187601f85so591722276.2
        for <linux-cxl@vger.kernel.org>; Thu, 10 Jul 2025 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752135116; x=1752739916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2s/Zqafw8AcoBzgRuZ54ScgDx0pAEPd4KULnehzKxBg=;
        b=MeRluxmHqTBDfjAA1xxxY6mdhUcStnoyIs0HktrYf1NjxXQdz6UIyJAM4yw2pwQN/q
         PNnRZ30ZpQMZRp42IhCRgVjQcfEVzN/7iKI1IQGpTZPHNrIhDFMnPy84duDc88uVYaOP
         JEnas+61GAzvfo1ZUlv32rp1oh9WvjZiTEMKVVmh6F2IGNyh7Z5nR9x5pbN+b2/hxTaV
         sHJD/Z2u37SttGKJ4Xh6iwx4eQSp+hr1xItFHkXTJMfq6DHdbTmCyjHS7Z5yjIY6P/Y5
         109Xnpy/W70e2v1fC9jEoeOAdlbF4MFZtzf2Q5GkWrwzIvN0dIjpRx4yRi86MLjXf6Fs
         o7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752135116; x=1752739916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2s/Zqafw8AcoBzgRuZ54ScgDx0pAEPd4KULnehzKxBg=;
        b=Yj9GRTsNZxrGEPGB7YPIfJCUsriuacNwRIvjidmjGnxlN6NJKAXiE4JAIK2moMX586
         NcZpyOXD92jcmrCifIJjk0sP5hAM8RgnHPoQRuGVPZ8UwRkpR8B2QhmuqzXbsXQjPja1
         O88YFv8V18vHsGdjlw+5Yha/qSLmmFv4W9EXYK54SayNcs2Um4jebBv82h8duijWLw+b
         bf07bz5j73KYu5ARCnCCA8A45e/tC6SUeFUznvG1T8s4skyYneZu7q29TPa1wtVZdfEY
         89hDrkn8AKhCsT1PrqNiTwfWeZhlN65A2QwTD9F44OKg76l++G0GFUQmlegO0tWqc2gK
         JNxw==
X-Forwarded-Encrypted: i=1; AJvYcCXe9L8N2t/DuIbId2BOLfkzGVmuaT3ziXuXZJeJjY+R/2BWpOB0hDRDN+7m7gC83Xkb09YWgFIytGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqitw6lAyN+YncGSu74n7Ko5iUY6+KdauNAXonA6jMTVhaXXPr
	OkbbtaiSHDK560valNs8IUZoOTzEORaDzPSEaK/cHDVo9Fb7o+bZeAhx9wmDMervo6q1oRU1G6+
	6dfcuqSlopNBwS85detnAxoL0FwRXOUqPa2Zm/EdWHQ==
X-Gm-Gg: ASbGncvEHNlEe6aZ7NhUGmfaI2XwdFddenVjtnOowB/uyLamjRqcLctie6vkAGNmt2I
	qpGU8gOVHjXDlNGwBVtTb0CSi3mwWSp2H3s2luwnXAIGDqZcCRR6lP5C7T46f9m7IJlXmSvtFz9
	WOXfkWleG0UVZkbO2hj4g2Gwaxe5zG7H25XriLiQqp0TK7
X-Google-Smtp-Source: AGHT+IFP+d3kfFlfXU34Hul8KsHFBVCuvpuCpVKWMgez/2tubk87UqxG1pqPRadEPQ4pauRTaUj/kTpukXVQAtDyNlU=
X-Received: by 2002:a05:690c:87:b0:70d:ecdd:9bd1 with SMTP id
 00721157ae682-717b198ef8emr84285357b3.24.1752135116592; Thu, 10 Jul 2025
 01:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703104110.992379-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250703104110.992379-1-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 09:11:44 +0100
X-Gm-Features: Ac12FXwPnQQnWUTVs71FmnCoarOVLcrYujDLpcY0gASudkRZRuyeu7_DF9hc4Qg
Message-ID: <CAFEAcA9gDM87t0RXWPdu5bi1WxcMcpRiYEcnqjzhdUiys=E0gA@mail.gmail.com>
Subject: Re: [PATCH qemu v17 0/5] arm/virt: CXL support via pxb_cxl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, 
	Eric Auger <eric.auger@redhat.com>, mst@redhat.com, Zhijian Li <lizhijian@fujitsu.com>, 
	Itaru Kitayama <itaru.kitayama@linux.dev>, linuxarm@huawei.com, linux-cxl@vger.kernel.org, 
	qemu-arm@nongnu.org, Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 11:41, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> v17: Thanks to Eric for review
> - Add a comment to the high memory map to reduce the chance of nasty
>   surprises in the future as similar to device_memory, the CXL
>   Fixed Memory Windows are of variable size as so can't be represented
>   by explicit entries in the map.
> - Updated a couple of patch descriptions to provide answers to questions
>   Eric raised.
>



Applied to target-arm.next, thanks.

-- PMM

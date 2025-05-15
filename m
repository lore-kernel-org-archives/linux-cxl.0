Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EDA1F153C
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747349474; cv=none; b=ktVM9qGjRT9jBhAJxXc4si+edmKlFHAJfs9OyWk8IJDyw5wuTd+3ymxQ3qQg9eJBFmYUoqeh5NRynKuqw1PMF/OcwA87S34/Xh0K/dJ+ogJe3+atRuMl+I73TyLg6eoGXaXXRmBkMGaCM+RiXrOfg9Xspj21vzSqcOat9ptwVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747349474; c=relaxed/simple;
	bh=TLb9YQW9UaLJ5jucRwK32fQ6KItneOhjha16N4sLHXQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R0lODcuX32AD/9neLj61Vus3vWqQgNt6OKMSCyekhLdjvZQPTiFaFD136HnQpmJPlnW3BR/IIKEOwQMXFugPk9cQ5KIhSkDhFSYsRpFpE291+HfGFYwZG9YwRo9JsZfLY+aH0tkkl83BevFl7lTVV976JeQb24Ysd01qwAEwlHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbbAbnvj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbbAbnvj"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad51ef2424bso184763066b.0
        for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747349470; x=1747954270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JjLveP7wVYZoQzaIplndUNDRdBpqGka4IvUAobKyPQg=;
        b=kbbAbnvjnVJVbvE8zJ/aIYl8hFAScHwDUGtbR6zt1QAQBiF4ehYzOYC7iQZ/7zVQs7
         8BhSqmG5dux3FTy4vdX6gr2mxf9pn24hiRKxJrKwJotewZbBmuiPj13+Uq8Fup5rX8BP
         oSXTv1HmFDNn5rhaS4kt340Js/KNgHVlUBVFww28UpCdVrr107dcom9sGQSzJnL0qO68
         0RZWVfAyRj36O7MrfHc77eDq6HifjTlpBFsgwSa/HzL2VnihGf3+cr06MDb8Lq7yPh4O
         9TAqYSJSwMh5zSTT2BJ600FF3hudda06ncxkU9kb8UbdMKjabHedRbe7YaIORs223+N6
         Po5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747349470; x=1747954270;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JjLveP7wVYZoQzaIplndUNDRdBpqGka4IvUAobKyPQg=;
        b=CblcuzTRK7HR2dOxiFAdNbQWaCVFv9kkH9YZL6MdzqOTtl+p+d+51Gp4aduVspZULc
         wp0FaoHGjGGQP3Kc3H/coP3UTuL2GmMlnOf5QC1ThNNlAm5D/y9+KAGpuE/B//4qkEFi
         NeJPwcm8KMIIomUItsdE88HuwKM+e4I1ge8+yAr/F9Oli0n5QM/tMnP84v4WdHgxMjcL
         Trt5nRjAGzgrmf5LRBpPOGa5y62B2xEjoFxkA7ntnzozuoy3oQCFdFyt0Vz4IeWqcO8L
         tsCk71CL+nOmG9SeVoeRW/JbvP11eC7z6NYaEYrwbHLl6qlMK4K0Sdokxx8h3yazf/z8
         7IGw==
X-Gm-Message-State: AOJu0Yybh5kwW7qPDqmaO7uAgC28n4XPcfxZgYJ6Xu548dr5626yVTvY
	P24MC6kMyEl9a5QoAiCDGa5chklzf9SDxxbE2HddQ/k0Kbj7+Afk1gDhp9gNF/NAopfscAAUjXc
	SrIDYi0DmsrXDF8fycRjnFsHEiMSKpHEReA==
X-Gm-Gg: ASbGncuHh7XTXAViccbWt8segJFBNjLInGaXJb5TyUq1tBh/y75GG4hd78POk7C2Kqs
	f6Eaqmt0VaBTf8lkFBkUFPm59rrjbAeLDFyXSlCT0Cy948P4CFsJlAe9nQMr7B7cd+pQBkJ7utg
	kAsRlxZ0NYNmm8+ZogzH5SisMDCYMPR5pfwd0=
X-Google-Smtp-Source: AGHT+IF4pBTNGOUGrYpH1roTxc0fY0pe00NkicWum0jTV9Nv7KjVxX5batLfFteZvVNUqicGBQXNSj2OTTjoUP3BZks=
X-Received: by 2002:a17:907:11c8:b0:ad5:3746:5906 with SMTP id
 a640c23a62f3a-ad537465b9amr12666466b.49.1747349470005; Thu, 15 May 2025
 15:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yiannis Nikolakopoulos <yi.nikolakop@gmail.com>
Date: Fri, 16 May 2025 00:50:44 +0200
X-Gm-Features: AX0GCFsOaWot0hJfOPZmytNYR6EmtULQoZmkOQduQS4gv3_TQbh4WAEIVhQhRT0
Message-ID: <CA+CExOgLYnVYdhHADBp4EEmDgfvhv81R1RW1iHGJZxd+V_1wSw@mail.gmail.com>
Subject: dax behavior on CXL 1.1 hosts
To: linux-cxl@vger.kernel.org
Cc: yiannis@zptcorp.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying to understand the dax behavior on CXL 1.1 hosts running
recent kernels and what is that I have probably misconfigured.
To my understanding this series [1] introduced some different
behavior, and I am trying to figure out what I am getting wrong here
(but of course I might as well be looking in a completely wrong
place).

System:
CXL 1.1 Host (x86) + CXL 2.0 Type 3 memory expander (FPGA).
CONFIG_EFI_SOFT_RESERVE is enabled.
The memory region appears correctly as soft reserved in the e820 tables.

When running with Kernel 6.2.16 (or older) the dax device appears as
expected, and I can either map it or configure it as system ram. No
issues there.

When running with 6.14.5 (and others e.g. 6.12-lts, 6.3), while the
soft reserved region is still there, neither the memory is brought
online, nor the dax device appears at all. I have tried what the
patchset suggested, `memhp_default_state=offline`, but there is no dax
device to reconfigure afterwards. Neither could I manually create
anything with daxctl as no dax regions are found. With online as
default, still nothing happens -- memory is not used and no dax device
appears.

I have dyndbg enabled for dax and hmem and the only entry I see is:
[   12.714566] dax_hmem:hmem_register_device:73: hmem_platform
hmem_platform.0: deferring range to CXL: [mem
0x2050000000-0x240fffffff flags 0x80000200]

What is it that I am missing here?

Thanks in advance.

Best regards,
Yiannis

[1] https://lore.kernel.org/linux-cxl/167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com/

Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5710E9
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817937; cv=none; b=NBPARBKk0C1SXlez9ubYn2pawnTizsTnnRmM/4Su4CVSaZi2N7iip4eqWsFR3YTVb7UR81A93r+pBxaMARwlzfAn4HNXDJu9/8k1sCIDWAPfjARsQTY2NJvbCVnscJo7mt/m6LaFKmx8CX0BBptZlwx0A+4Z1+qoILlb49lM3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817937; c=relaxed/simple;
	bh=HZ6ApUm8L4DPNb5S+/MYzxzlcFJypwwuCpGVY03xJuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4mrVh6o4lUXEvmfSOmtvc3u+AEr2AxZ20x98/WUqnL5Ms/k3Jj0B0isaExTnu223SYpF6+5dL1SVq44W+OLM2qRYZiMvbq9byGgw4Pl46S4Plf33xhOKmZh1rmjV4QDuQzTJzCauHzmml3pF6nD3kfILGcY9fB/X/K0l8tfvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gHV2MryE; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHV2MryE"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ff4faf858cso14022377b3.2
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749817934; x=1750422734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=07JVhg802iRo9r8/K0Jmv569qCvievwFPfErLy0AXps=;
        b=gHV2MryEhLs62Szd/ptOZvI3d/apee4gDuZ/W3bCZQqC/cIjLSznVcrFPwRZJmXnpg
         wi5R0utUAWrc8SITKBtQ5rVSsLAfiyV/7mMKxpRGNBU7YccEKHchh29D27oJxWYsKgpY
         FS6tVu89UOYk6wkAh6iqPo/7VWyrB2h8Z19R7PL1VeBDId7lWB8kLHj5bBA3U2J+z6iV
         Mfsrx70ISATLD0CLwfTBB6FEhpCe7BqvpOnPCzL0zA4QQCn8WkMVAX05JBEkPsA4UQeJ
         YHZZjAYwvyaag9535jN4O59h8CQBkK4aKLOwTMVoPRKHEX14NOVwE7OWY2o6ldTY3CsY
         fWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749817934; x=1750422734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07JVhg802iRo9r8/K0Jmv569qCvievwFPfErLy0AXps=;
        b=IXCtGPXO5QK3QeK8/jG/rwgS7iVwTufHPy0qudO0S2M6XtArKnEKV5ykZD4XIPUKTr
         iV1ARNYw7UPsByvobIwxU1r/eDDbd+zIHzUVBhbE8/raQOeFNe/zSBTxz3iQ6t32fka9
         FPFBbwgcqDhtMw7bRdjAFxQ6v/9tK+zZgslHbYkmG+mZUiDRiGFjPHsoadnrJzqiKo3F
         z17iz12oKolZWlAOZIl0tAkKUDxVoK857XK2GoMwJtFhH2pVo93tFeAjTfJbeWZdO8SH
         SKRzixkzF1mbk1+ouLvs/+hF6hQCbJueQyHRyRGLMIGAU0zSoxTr6bz7YrFJlaTxXsYu
         Mvhw==
X-Forwarded-Encrypted: i=1; AJvYcCWfmnsQFIEKjnzDPWziYbGTSP5T8n8rGBXn6jK8jnx5393zPzIVkTF2azKp1lfYZcU8iwMWzpDnyqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKLNevdnX3t6zqRhiKmyYTwDVcl4UOMLa95tAh0b8jOS3Q1IUG
	HWvFV8K/8arESXvNdX9CSx9tvXbhxzuQcGitvldHA+xbsrBFKOx9nCDTnGBvINY58BcUQyDy4I0
	Rdsj/fNUHlLxBSATZEdUxH0AVsuGmyIRvUIHvUNZdEA==
X-Gm-Gg: ASbGncvtGyMF+HzBL1R+Nnjk/jp2w4Avuqae4gMQDndzVEktkFU5b9qqYK2a6DofRff
	YYuZmHztFjh221NdkW23vLy9DcrUhnuVkguz7tUSOShRqz8OQWlfbvKNOFDN3Ial30qIUR0fGnb
	bEFmILX9Ey3HO1u33NozxqPQHziZDH16xXxvb5ewYH1R1g
X-Google-Smtp-Source: AGHT+IFAh/pRObNEqsEHzHc9PX7qF1sWhz9Pj9Np6nag1q6YhuyL+Lq3qJpFmsYoU3w5VHRtSeualJtj+JZoQa8/Ww8=
X-Received: by 2002:a05:690c:f96:b0:70e:142d:9c52 with SMTP id
 00721157ae682-7116372329emr42840937b3.22.1749817934334; Fri, 13 Jun 2025
 05:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com> <20250612134338.1871023-5-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250612134338.1871023-5-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 13:32:03 +0100
X-Gm-Features: AX0GCFtY0-n-3gf_nsaxJ4DbwNp3JIuQBsYWobX7KaEQ6RzpFw0oR2DA4cIwVXQ
Message-ID: <CAFEAcA8xVQUnReg-3jYENLmOMG_PeJ-ACLQa0dRoLBzxQ+9Svg@mail.gmail.com>
Subject: Re: [PATCH v15 4/4] qtest/cxl: Add aarch64 virt test for CXL
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>, linuxarm@huawei.com, 
	linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Alireza Sanaee <alireza.sanaee@huawei.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Add a single complex case for aarch64 virt machine.
> Given existing much more comprehensive tests for x86 cover the
> common functionality, a single test should be enough to verify
> that the aarch64 part continue to work.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v15: Dropped tags due to changes in patches 2 and 3.
> ---
>  tests/qtest/cxl-test.c  | 59 ++++++++++++++++++++++++++++++++---------
>  tests/qtest/meson.build |  1 +
>  2 files changed, 47 insertions(+), 13 deletions(-)
>
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index a600331843..c7189d6222 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -19,6 +19,12 @@
>      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
>      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
>
> +#define QEMU_VIRT_2PXB_CMD \
> +    "-machine virt,cxl=on -cpu max " \
> +    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> +    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> +    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> +
>  #define QEMU_RP \
>      "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
>
> @@ -197,25 +203,52 @@ static void cxl_2pxb_4rp_4t3d(void)
>      qtest_end();
>      rmdir(tmpfs);
>  }
> +
> +static void cxl_virt_2pxb_4rp_4t3d(void)
> +{
> +    g_autoptr(GString) cmdline = g_string_new(NULL);
> +    char template[] = "/tmp/cxl-test-XXXXXX";
> +    const char *tmpfs;
> +
> +    tmpfs = mkdtemp(template);

We prefer g_mkdtemp() or g_dir_make_temp() over raw mkdtemp(),
I think. Other tests in this file use g_dir_make_tmp().

Also you aren't checking whether it failed.

> +
> +    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
> +                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
> +                    tmpfs, tmpfs);
> +
> +    qtest_start(cmdline->str);

We never change the GString and only use its C representation,
so I think it's simpler to use
  g_autofree char *cmdline = NULL;
  ...
  cmdline = g_strdup_printf(...);

But I see all the other tests in this file are written this
way, so I'm ok with staying consistent to that here.

-- PMM

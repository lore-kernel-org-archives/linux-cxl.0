Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686C155A55
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623334; cv=none; b=L2X/Wxlkl9wfm+QQICxo2xyfk733FKge2gcz0e2SRh47TfAcpt2qweE7K9hEUzjJ4+FFHMDSAUrlkjF8zp/vo4hHBzb8MK3JZ9UDdMGeEbR1iA0MGU2bow9LMmQoodfvL5ukL6uj6CfbwjW2MhgkDsJyT9AIOrQhbuZnFU8OO0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623334; c=relaxed/simple;
	bh=Mxxx8zDL0M3ohmn9Aox4c3HM2spSYVWqoIJfbMbG2rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6cxJ6IQ/Clz+RVqY3bgQgOzjXxjflHRNApmEjXsjlb+AabfIh/WtHC131AswBjYvBADSqd+4lcORelSC/a5aMQ4H8onZt8o/ZNTiCflp+AKMxK8hpDuKyD1+mfrIPCIJLlhQ+Q0vqcFzLfmF/rdeovlWJJyRGeAh0BNy7rRp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfuChaMX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfuChaMX"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5654621d62dso996510a12.3
        for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708623318; x=1709228118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mxxx8zDL0M3ohmn9Aox4c3HM2spSYVWqoIJfbMbG2rY=;
        b=TfuChaMXUAoGIpZtkkIDsyFFP6a0Wy6hWngBnrwF1OHxqIiWgiWhhWU9QAnBHKG6oM
         Ql0WAPVsnD4pa7tzmEqXTTNQc+yxF+LCCIW/YPCA+5vOsT1gVkGu+T0OoIaodCjmNjJW
         Tx8iQGipL232vrMx5A+kJpr53qcmf0+QrZfJxfoob5vJpwJJPsknQIcewo4y1FwoTBWB
         gPcZlchSHYb9ImqzRPIZi4ylPtxuAXL6CuRaC0as5c+/R/pgiQo6ukHEO8g9dKJvkOc4
         bPSieBHCWD30xFFZNE7+Hm9uaL4keVFq75cWUYlD00M2ku2WE+HPwH0tsgxBbfOi7hiE
         YHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623318; x=1709228118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mxxx8zDL0M3ohmn9Aox4c3HM2spSYVWqoIJfbMbG2rY=;
        b=ChMrLvLQO/UVKdoH9lMep+WolhTRHlOsnXDIuIhr/8Rv2s1U1EuAUlHfhmWVuK7K4w
         DyNht6yR2HDuzrrjA6dmrPQa0pE3BRmHIMZ5tTPEpgdiIUdMHJjqSfi7SvptQUbJywaR
         PrXvW5TRE4fr7BoUyPw++Dn/gvpv8JkU9+Bwo1UB+WIbC+ucJS0xDdp4FokDh8ZFrqLx
         yIPSyTensjF+OojIV/ALEZ33a9Po2m9Jy0hQL7lZsl7Ra2TxViWd78hGR300ichLW/vk
         p4SPJs2/XMi3xJZZrNpjV6Q8H2x6uaI5R6L1wOhDZvnn4mP4dqTvcXYsf5odhJJwchG3
         a31w==
X-Forwarded-Encrypted: i=1; AJvYcCUr37ql/5aETRpNzZfvwgysxuhLSr64rVoCopWXK6Eq19xuP8tqVEUVEGkDGQHjbwrwMZZxICDsX9mjDab574To53pyu6QMmZ/2
X-Gm-Message-State: AOJu0YxSTt03PqXDuGO5geMO7KcC3/j27xNxHfweB22eJkE58032ug0C
	t9ZMdQ+H5YEIm7g+BKDnTUMEGzWEG031hRrqIGuTB2zwleDlX6RsW/aMzIMJssou+ghPCjK+CMO
	aI4LfPGDbaCESZwGPwjwwdAKb/cyCsGpmJ3FYpA==
X-Google-Smtp-Source: AGHT+IHGc7xzpKMoxOTR/sBFz/bV0sXQFDE8Qb5kuOiSCgx+NvFOofgn4l4IYFpGN/YKzdSyoXV5HvJG/b1jXLKwDZA=
X-Received: by 2002:aa7:dd02:0:b0:565:43e7:7b5f with SMTP id
 i2-20020aa7dd02000000b0056543e77b5fmr1585759edv.5.1708623318524; Thu, 22 Feb
 2024 09:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219173153.12114-1-Jonathan.Cameron@huawei.com> <20240219173153.12114-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240219173153.12114-4-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 17:35:07 +0000
Message-ID: <CAFEAcA_F_tRJb-SWJCmmZXAJgvXm_Gs0mNKUwiumwQWhQY3PVg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tcg: Avoid double lock if page tables happen to be
 in mmio memory.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, 
	richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Eduardo Habkost <eduardo@habkost.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	linuxarm@huawei.com, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 17:33, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On i386, after fixing the page walking code to work with pages in
> MMIO memory (specifically CXL emulated interleaved memory),
> a crash was seen in an interrupt handling path.
>


> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

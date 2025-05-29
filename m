Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FB1632C8
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748539448; cv=none; b=goIeXb/le8KDOenNMefIOyN/1fnkDbj8nwr7RcHnDYOY4P8Zwpxe9Ykph2MjHlqNrVfAZb12mKygKq/4mvpw5Rb1tW+hY31J2961tAaJ74h/MNL/TF1Y1AejWLwYm7XCaEMe5tq2uyvaGPw0eyhpFNme3kja5JQ5isZ1itwj9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748539448; c=relaxed/simple;
	bh=82xFsc6Sni33qIILIGq8Dc+nmMfXkZDD0WLeJR3Yeho=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8Czahh0d00cAMAUt6DJf6eNYWU3N8TFsD4c8cGJJhxF9w5h9qCE02l/rxO3UFs8rnw4Mx+9lX2MWrbQyn7alXTVXVxPnTaVH1s7ny0Q2AOd3+9tCJ7Z3MTbbnELPwXemLptHHW4qim3lZSFHsoMaHBtFfcv/vREHzn7JJVDivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEz5RTIf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEz5RTIf"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22d95f0dda4so14786895ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748539447; x=1749144247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kEyH62zNAebqEqtp3fTh4mOcudMflb/GkOdJm5SLEDk=;
        b=TEz5RTIf5LUjZclHcn+0DA+nBnHLcLn82NLUYtb19ja+YHqF38wU6TSdMjiLH0sIyB
         OVQeF07htZOGcQC2pdLWlr8VlHu/iiHltgUIm9yVxvCJkCa5T3IUr26KZ03wsUcy9o0S
         TUzuCCPH92cZJgumIO/HFvIhhShbOi3e/mXP8dPwmhLa/RCYtWFNz2RCeCgUy7iv6ptp
         K24noerYNo7SqqWP3b4Oqk8mgDZQVO6SrWPd1hp7fj6Iks3BBQ7UfIqDiHJCin7OPA0I
         v1Dw75GJcIp6rjJsXm9wwx3WwS1rgsM/qq4HoSy8/7yZ7oB/UozPp0Fvxnd3gbd4auTZ
         pnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748539447; x=1749144247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEyH62zNAebqEqtp3fTh4mOcudMflb/GkOdJm5SLEDk=;
        b=rHZ2U1r83cu6PXiMelr+Xipvyaig0smeAU+tKoAb/dhfif9+tGdB10nmAz2pM6EADM
         7RumiHMa6lH41CUAPXmsFdSB1zx5VYAIFw7cJ5ZshKF5TvVs7XNEzBEYnCRum+HfG/Gm
         HKH9hb6lluyhCHdokV0cW063O3ACDUyZZ67HIorzxsRLrHk8qtEzfADwDydJ2QJwfHTp
         RRrUsbXVtXi3m8RHWNMfpbEP/Zt95fis7ue9S94uBuC+5cYZV5MYP1P8kSihsuGh31ni
         31V92abSPF9zObGlnerSiJs/uXMuoyC5JHF18aZkloCajr/OTfhXGIcOtYPPXKFUiIez
         cq4A==
X-Forwarded-Encrypted: i=1; AJvYcCUU2IVfGNPiw4KQWxQaRMZEc6Wa5jZQkTmNutsTm0uCqDbW7iuPOGsRNeiFaxWs+86lJ0cW8LYBdx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXaa1tunoO8CTUK+MNKDtm/tz/bV6BUAn2EvqB8goaDqKQQvZE
	RI+0Rvh8xYIFZf0ohpRvLtQj+/btU1rSMQsZqfHvCRdsr4+vUuQgSyBW
X-Gm-Gg: ASbGncssc+8BWxN7mAQ6wxEX5yKTDfiGA7uKNAI/aqKHDGuBNmPFF0TR44lFkiUEZt+
	O/pLAZrf3rvSCLhlNuUDzeXxJx5qhrzu4FCwiLs5fEmF1va+Ilpyl9rNga0FJY54VdVD/tcomAU
	VZdcyiRczeosX2aphgv7bFZwK2IxATJhckidsf1nxVEEmlS48I+S1H+/h8wa2LkjfcHwRo6slyQ
	n6F/HwSPZ5HfJlcVYb4t608vgv/FyeyKK9FpgWYIVsWdj052q90563oT1YiIQ5/w2NAeXaDxUwd
	jBhF5I5eq8HmaygwoFLezkUfeT4nGg+nb8NLcnG78sXuuzkCgqsbAXc=
X-Google-Smtp-Source: AGHT+IGi5cGGCBmBiq+PkmtAJs3wjt1VsFTAILjcCXfRmlpkbOd8nC8FKlVdDZKj1HMFeYrFw5JuzQ==
X-Received: by 2002:a17:902:c952:b0:235:779:edfe with SMTP id d9443c01a7336-23529a11512mr5031775ad.43.1748539446636;
        Thu, 29 May 2025 10:24:06 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8863sm14826385ad.19.2025.05.29.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 10:24:06 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 29 May 2025 17:24:04 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, linux-cxl@vger.kernel.org,
	linuxarm@huawei.com
Subject: Re: [PATCH qemu] hw/cxl: Fix register block locator size
Message-ID: <aDiYNDGscGVVz6BB@smc-140338-bm01>
References: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>

On Thu, May 29, 2025 at 02:48:28PM +0100, Jonathan Cameron wrote:
> This has been wrong from day 1.  For now we only have
> two entries (component and device registers).
> 
> The wrong size could lead to arbitrary data off the stack being presented
> in PCIe config space.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> index d0855ed78b..3bb882ce89 100644
> --- a/include/hw/cxl/cxl_pci.h
> +++ b/include/hw/cxl/cxl_pci.h
> @@ -31,7 +31,7 @@
>  #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH 0x20
>  #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID  2
>  
> -#define REG_LOC_DVSEC_LENGTH 0x24
> +#define REG_LOC_DVSEC_LENGTH 0x1C
>  #define REG_LOC_DVSEC_REVID  0
>  
>  enum {
> -- 
> 2.48.1
> 

-- 
Fan Ni (From gmail)

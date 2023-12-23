Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6D14F62
	for <linux-cxl@vger.kernel.org>; Sat, 23 Dec 2023 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDHk3AoO"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7ba9f24acf8so71716139f.2
        for <linux-cxl@vger.kernel.org>; Sat, 23 Dec 2023 11:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703359660; x=1703964460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LWJUJumj+chjdb+mpbxLFz3PFkxATdghWRd6VcipqG0=;
        b=SDHk3AoOKMTHCjlApjROzRi7TVMEReOXWBxnbU4VHmMkrCMw9IOyYt5iLTiMb2sSxX
         ovKe/U83154vKsXg+iJh9Rog9j4atwHhammPg62gLyO2oVg+yNvMR0m4Iot895YBaTiv
         GiQQDJCICSTiF27MxlXVu0jizMYxBjTgK086vMJnSyywdhilbjrLtlRCVaKF2MBhLxHq
         ME+qaALJSS1Z0h+6xgWNKqfOxXgzK6ruWMUZf6O37baKPLk74hjL8QhrYFW57aPev7Mu
         gIMM0GVKO7Vtei00bBoK19JZqvLAH5yc1iaqnAtzVnBRa5CRBAT1ddGVu4thKQTMfmGk
         j3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703359660; x=1703964460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWJUJumj+chjdb+mpbxLFz3PFkxATdghWRd6VcipqG0=;
        b=kHh8W2TUtHBq+3yb3rUenTZJ8K72eEmNzaIUMswiKRUpMbIfHlQ5lj4m1rxYjUaKk7
         F3Yy59IRAsEF+8CmPo0n+FdTvJTvBzNX+TQ56Rc9jxK+N1Gxr+2xjIO9gFDXDcpNYNAY
         iufUgHuuv23mIahXan4m8IJ+hv3y0a6ubSI2Q7e2h6M3B2BOyDBGli6U27b6A+V9hfxk
         fueRJ2j7srmZIO5QW3v4ZmTiCKP6t6hAkElARatBsLvwDwDKCM7gnSACmI4mXMgK81X4
         9rXk2+qiACq5Zs4g5uSHJawZ9zognezPG0LmZ5LedcFufwq8k+po+aogvi+8zAzRh3vr
         kdoA==
X-Gm-Message-State: AOJu0YzhthWRSMQHEeHwSBTBEwRhExu+hT+nZddbATeipVlMA8FDLJjg
	oMxOsS3NmiztuAP7//8eMBI=
X-Google-Smtp-Source: AGHT+IEOkEBSdkZ5Wbq1c4+gEUKJhLvN5eByQle6t+fvokwJ3tQi61ctdJX+RtpkWJp7+w4aKqoWQw==
X-Received: by 2002:a5d:9c4b:0:b0:7b7:fac7:fda8 with SMTP id 11-20020a5d9c4b000000b007b7fac7fda8mr4566959iof.39.1703359660135;
        Sat, 23 Dec 2023 11:27:40 -0800 (PST)
Received: from debian ([2601:642:4c01:bbb:d356:cf92:29ae:5af2])
        by smtp.gmail.com with ESMTPSA id jb2-20020a170903258200b001cf6783fd41sm5492341plb.17.2023.12.23.11.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 11:27:39 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Sat, 23 Dec 2023 11:27:33 -0800
To: alison.schofield@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	"Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI: NUMA: Fix overlap when extending memblks to fill
 CFMWS
Message-ID: <ZYc0pU4mD29XiX8H@debian>
References: <20231223000025.1401076-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223000025.1401076-1-alison.schofield@intel.com>

On Fri, Dec 22, 2023 at 04:00:25PM -0800, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> When the BIOS only partially describes a CFMWS Window in the SRAT
> the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
> to fill the entire CFMWS Window, thereby applying the proximity domain
> to the entire CFMWS.
> 
> The calculation of the memblks to fill has an off-by-one error, that
> causes numa_init to fail when it sees the overlap:
> 
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
> [] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
> [] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]
> 
> Fix by making the 'end' parameter to numa_fill_memblks() exclusive.
> 
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 12f330b0eac0..b99062f7c412 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  
>  	cfmws = (struct acpi_cedt_cfmws *)header;
>  	start = cfmws->base_hpa;
> -	end = cfmws->base_hpa + cfmws->window_size;
> +	end = cfmws->base_hpa + cfmws->window_size - 1;
>  
>  	/*
>  	 * The SRAT may have already described NUMA details for all,
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> -- 
> 2.37.3
> 

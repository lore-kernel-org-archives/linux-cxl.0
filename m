Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3057526E6FA
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033725; cv=none; b=iKodfGDoBFSJ9oRVU5CqEJnT/2Sq636ls6EmTeh7Ae2Z9bEzb1iDKwWhUZXExPZ9zBc0G3/dmRzV52M0I2MvRc3y9Yh8qTOHHqs3OQNbrBwZ+LxINDCBlSDd8VBu99zYCzLq7SW4wfKHHyn77VQ5J/Gok4C8OY6j62I58jVwYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033725; c=relaxed/simple;
	bh=pVruJEWVFpGrONjAfSumiqSrsJYS5ATEjsbsH4xlv5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okQjC3aJTsF377HIvaesQ/Y3rslHJXa7+oEGUItEGwrj55pWOPJEIOTSMLKjphLP8AdXD7a0hqymp/uNthSSuqtLZhJFyZUWJ+yThJQ+y0a3mJr+HFdWZC3MEh/Vj66zOnRwxdyIZ0VEqxn028W6DVAvRiqf5bjK4VoHUaStUgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=An/ZP09t; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="An/ZP09t"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ca01dc7d40so670090685a.1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772033723; x=1772638523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5bIJ2sRvx2PTU2VEZWqTckWnSCyuKXhLaTB7EtedyE=;
        b=An/ZP09tnm3JwbcceiFiWS1pKcmZzBVTxeuy/obhdvgu2UsNUCF8MsBNwjS5BMSkbi
         E7iqEJP1N5Mpu1SbfBNO2MrmmvEY8PNcdyhnD/BPqoXIkieDt75dO1ToMIrLo3Hlmh5S
         HQkRaxZomTH/s1HBiv2rSW6JPEp5izvPXG4I7IUwkHhCLFBRALv7PMydhWFc4GxWcOMo
         ZapPhko6MaOzAxK8jCouwm2BDgKWvwSKnZWjqiNw8LZvqu6o+NiovMiD3/ul3dGa95Ai
         Vh7adtYLSTo9ePuXOPEkr8g4tJZT9en4gaFDxKrIr20GXAWlTJUaUbQOPjNT7KT2NWer
         n7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033723; x=1772638523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5bIJ2sRvx2PTU2VEZWqTckWnSCyuKXhLaTB7EtedyE=;
        b=QcPfflgG8EpLlKai09ooIUhLzqgk6YGf6/FkAc+qgXvArdd1igFFolOthJXJEF3uoV
         WembU+UUvK72+MXqn8tnLKo0fGK/z1HwK3jmujwRxUfjkvRFXk+EhNHRjaV5WGGeIVu2
         3dI0SJZUXbHxPtkgqHOPQyr/SIWNXSbj9SqkNrYTFg1V1M79mB7Vpq/w35fjEF4WAZxk
         PQJlS/Q+OZveXnTqgf/dRLRYgUFfx7fcoaBZhNOv8Mg1/xJCS7AX4bxycNu4enDxQNHp
         MNrpQMqJXZya0XrfkCrmr4AjDlfZhska7V3zr5KIpMXCWkblYg4HdkT6Qd+vZ/TUXltg
         TYRg==
X-Gm-Message-State: AOJu0YxgTG9XFh0oNPEZzujzwTXpaeLCOl0QyJeOZiSv5gMlg5QxKoGe
	JjO1juC+dDPaieXoaZBmAHa9hJWC/jtDmvLqGsWZYRRG8LNIdROH5r+buSgxW/gTkNI=
X-Gm-Gg: ATEYQzwfzI9v44Cw6J9GlNUgB8bexiibHxSmVF98nWDAaTbSrmcop6c+eooohyGaSRk
	7p+m0Dh9aoes/Yx3D2ek0wymFR33RH7OL4kWzjlN1xds3WnNTUjNftNexiUqLwWeyewu5FqgdQG
	7zupJPB1KOCbaKP1yrMo+XFSqWTzjxzCXxyNRIJnGfe0eNV/ZqXYwWL1ucexxHPrX4w6q8AnHBP
	iA68xgrpllpH9IsZb4tDeDOn8fsrkj3CU3HnErbCA/+CCdQOtU5NfGO4v2DBUYDy8lK1TChskF1
	t3QN0I2W0XxDqU67eUdak9Q8mfjJnVRazm31LlAK0QoMDXB81gET6JKjtIujsvbS4Y/E04SvISp
	SHOvMHgTUBq5T8YvjgLGQzgX0ga22AYvC9EMXLXOxDlVsetjR4k/mbq61bZTiBWAfcEgJg8Z+bI
	R/traHc4WzUIcCACCPckS10egRqDZ1A+gukkinirKFj5s8SZ9+4BeaLyBpAgUPSePKb0j83zcj2
	34V/ApbIA==
X-Received: by 2002:a05:620a:3197:b0:8ca:3175:cc72 with SMTP id af79cd13be357-8cb8c9d2ba0mr1844677985a.15.1772033722964;
        Wed, 25 Feb 2026 07:35:22 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899b58705bbsm24198296d6.23.2026.02.25.07.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 07:35:22 -0800 (PST)
Date: Wed, 25 Feb 2026 10:35:20 -0500
From: Gregory Price <gourry@gourry.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/3] cxl: export internal structs for external Type2
 drivers
Message-ID: <aZ8WuBEAYBNIpSDY@gourry-fedora-PF4VCD3F>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
 <20260225121430.3839189-3-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225121430.3839189-3-alejandro.lucero-palau@amd.com>

On Wed, Feb 25, 2026 at 12:14:29PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 

Mostly two nits

Reviewed-by: Gregory Price <gourry@gourry.net>

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 04c673e7cdb0..0d350b69f1c8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -12,6 +12,7 @@
>  #include <linux/node.h>
>  #include <linux/io.h>
>  #include <linux/range.h>
> +#include <cxl/cxl.h>
> 

... snip ...

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> --- /dev/null
> +++ b/include/cxl/cxl.h

... snip ...

> +#include <linux/node.h>
> +#include <linux/ioport.h>
> +#include <cxl/mailbox.h>

... snip ...

> +struct cxl_dpa_perf {
> +	struct range dpa_range;

You dropped linux/range.h from the move.

Probably still builds in most cases since range is likely included
somewhere else deep in the stack, but correctness etc etc.

One other nit, you mention Type2 drivers a lot in comments:

+struct cxl_dev_state {
+       /* public for Type2 drivers */
+       struct device *dev;
+       struct cxl_memdev *cxlmd;
+
+       /* private for Type2 drivers */
+       struct cxl_register_map reg_map;
+       struct cxl_device_regs regs;

Is it reasonable to think that these would be public/private for *any*
*any* driver building from the public headers?



Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3C514A4DF
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747280517; cv=none; b=PQKOTRDBWDFocfP7jLYfd6wAAINonf/frrhJiZi9FmU/TP5YhTrUFXnSZrdV3qdfMMLjvXkfRTywUttVcBVoY/b5U7TxAl/s6NmxQsAyPKUoMda0cbEiVid8PdxROrCoRH4TI7afdZwd3pXQCKKUBGFTSHfkAgrkSOWM8YmBX1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747280517; c=relaxed/simple;
	bh=xMMskxrVMpq24hBPN7oQhjCkaUbu0tdWf6JzXATBmtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIE2ZrZjw2KtLWyu7xQlpIYUL74ZRtfOkW4uaKAip0ibU3r9pkJxTblfYoBmaf+kmFTFqzfn2dMD6euEi+Z+9GyeYpopP5K6vB3YwZV+QsD7dL5AVpQlEnVyw4ENf8roYa3NwfQgSBObedKixe2N9ZFq53Ge9d1aGZJXuqBccfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jf3cXSnM; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jf3cXSnM"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7cadd46ea9aso70589785a.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 20:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747280513; x=1747885313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8sUwwawumtr+nRSApvKIolrhRUfjcNfHvqlKiL0pBGs=;
        b=jf3cXSnMBaUQhtr9c+ukyHwUl+OUBlHcgXslHZbrFLG3fHGEms4QC6psUoURcd1nul
         HjIItM8ZTyxrIHv9tgUY7e+0x0cjtSp51CfBsChj6LqNx4VsWAfDMTkEtQvnc+P7L/2O
         xd1MIu5yOQk5JLz8nsylzc8S3eI9oVBqvyc56cp/YqE1rfyCk/wA39ZSQle3BAmjRbM0
         Xgocw9jIG74h8X3eexs9ONADfODpnaFt54sdvA/5vm5GxoqZ0qXphYuRWlA6/Ap1BNOa
         Rh6dEwftl0jwVsTGqV1sSBsGgMAdyZMkG2c2/JmLk59nVEP608I/akfk+/VSvyX1RNmm
         g3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747280513; x=1747885313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sUwwawumtr+nRSApvKIolrhRUfjcNfHvqlKiL0pBGs=;
        b=AOiGgp7n/I2eLKPdOVIMfpCBZHWtKXv/mEP1SaR+8VSqQENMtyVTzgEtjWLZHmWihu
         ZyTpfQwUw9yYljay02HJXQbq5kC8AY2G4PW4k605Phg4BZTfEWG0CPIOwapYbbIEBdsa
         bPg2xOuinuJOgiUKF5jxsyUWnRTDiw433E3JWzjoAjBERql/Md42VjcVfuUb4jQclcCX
         5XdQjcUZwQe+vaocUZz6QXsB8jcytLbqP6/7FsmObAd/UK1IC7WtdfSwgYoC6fZtUOWR
         5CXOLntgjMmJ5ZZNkby6PSXQZSygN0/bwRu+c5KWmyozml9mgQ9XI0ccAMygj3RBK5aB
         9CUQ==
X-Gm-Message-State: AOJu0Yw1jTCOvxYu8aMG0wwgg2y6gTc4FaXV1PF6GUi8QHC5+t4M2GpH
	zQLGgtHB3xzbcyuDX3WorszYm/ghGJ4tovjbR/S+Z6V23HuGL9szKyFUuj2uZrI=
X-Gm-Gg: ASbGncuuKpOEe6YHknaCuT487P6FVBOsJpKJStApXKXRG3HwChOAS48dtTF+edd5W92
	r/lBeS6wHCb5uvSIz2guiGSa6TmKiZACTdy5T3iH5amJm2WpiU6ZMQHlBjbtB9rV4llwXJJ61hr
	z7eie+QDBgi822jihX2EQGDet/H2+1cRx3uwjOymx9Hh2HDrfECbNOdTs1S0PHWWo+akydVDgnp
	jV3/cHP2XIc1jkKrHL9TcoCvbZg/Xt9OxzPRwCpgSP/LDNmfLyTFUuXMPX9zkrCl51qeJmLMNaF
	aI/W/QVNUgvj2lN4XjpbSCx6ana8uC6/ISjaWurhknnR8PS51Ek9qN+TdW6zN1TcR+Qhh72Wbdc
	lxLVMfjDoIM9fxym8zlN4OMonpnHrzwY=
X-Google-Smtp-Source: AGHT+IE7ytAus0tpaGpDRpkqtOxJiJQ2Z5PZxmZT/wxt4btbH6n1O7R8/dBrSabJpnZsugDwlPhBaw==
X-Received: by 2002:a05:620a:25c9:b0:7c5:3c0a:ab77 with SMTP id af79cd13be357-7cd3c64354fmr110939985a.4.1747280513244;
        Wed, 14 May 2025 20:41:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a472b3sm89422486d6.77.2025.05.14.20.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 20:41:52 -0700 (PDT)
Date: Wed, 14 May 2025 23:41:51 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v2 1/3] cxl: docs/platform/cdat reference documentation
Message-ID: <aCVifxz7t62uOfmn@gourry-fedora-PF4VCD3F>
References: <20250515000923.2590820-1-dave.jiang@intel.com>
 <20250515000923.2590820-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515000923.2590820-2-dave.jiang@intel.com>

On Wed, May 14, 2025 at 05:09:21PM -0700, Dave Jiang wrote:
> Add documentation for CDAT structures for CXL usages.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
> v2:
> - Move everything into cdat.rst (Gregory)
> - Update various languages in the doc for clarification (Gregory)
> - Add a term definition section (Gregory)
> ---
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../driver-api/cxl/platform/cdat.rst          | 118 ++++++++++++++++++
>  2 files changed, 119 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 366faf851fc7..9e1414ad3357 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -27,6 +27,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>  
>     platform/bios-and-efi
>     platform/acpi
> +   platform/cdat
>     platform/example-configs
>  
>  .. toctree::
> diff --git a/Documentation/driver-api/cxl/platform/cdat.rst b/Documentation/driver-api/cxl/platform/cdat.rst
> new file mode 100644
> index 000000000000..34bbe7264d71
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/cdat.rst
> @@ -0,0 +1,118 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +Coherent Device Attribute Table (CDAT)
> +======================================
> +
> +The CDAT provides functional and performance attributes of devices such
> +as CXL accelerators, switches, or endpoints.  The table formatting is
> +similar to ACPI tables. CDAT data may be parsed by BIOS at boot or may
> +be enumerated at runtime (after device hotplug, for example).
> +
> +Terminology:
> +DPA - Device Physical Address, used by the CXL device to denote the address
> +it supports for that device.
> +
> +DSMADHandle - A device unique handle that is associated with a DPA range
> +defined by the DSMAS table.
> +
> +
> +===============================================
> +Device Scoped Memory Affinity Structure (DSMAS)
> +===============================================
> +
> +The DSMAS contains information such as DSMADHandle, the DPA Base, and DPA
> +Length.
> +
> +This table is used by Linux in conjunction with the Device Scoped Latency and
> +Bandwidth Information Structure (DSLBIS) to determine the performance
> +attributes of the CXL device itself.
> +
> +Example ::
> +
> + Structure Type : 00 [DSMAS]
> +       Reserved : 00
> +         Length : 0018              <- 24d, size of structure
> +    DSMADHandle : 01
> +          Flags : 00
> +       Reserved : 0000
> +       DPA Base : 0000000040000000  <- 1GiB base
> +     DPA Length : 0000000080000000  <- 2GiB size
> +
> +
> +==================================================================
> +Device Scoped Latency and Bandwidth Information Structure (DSLBIS)
> +==================================================================
> +
> +This table is used by Linux in conjunction with DSMAS to determine the
> +performance attributes of a CXL device.  The DSLBIS contains latency
> +and bandwidth information based on DSMADHandle matching.
> +
> +Example ::
> +
> +   Structure Type : 01 [DSLBIS]
> +         Reserved : 00
> +           Length : 18                     <- 24d, size of structure
> +           Handle : 0001                   <- DSMAS handle
> +            Flags : 00                     <- Matches flag field for HMAT SLLBIS
> +        Data Type : 00                     <- Latency
> + Entry Basee Unit : 0000000000001000       <- Entry Base Unit field in HMAT SSLBIS
> +            Entry : 010000000000           <- First byte used here, CXL LTC
> +         Reserved : 0000
> +
> +   Structure Type : 01 [DSLBIS]
> +         Reserved : 00
> +           Length : 18                     <- 24d, size of structure
> +           Handle : 0001                   <- DSMAS handle
> +            Flags : 00                     <- Matches flag field for HMAT SLLBIS
> +        Data Type : 03                     <- Bandwidth
> + Entry Basee Unit : 0000000000001000       <- Entry Base Unit field in HMAT SSLBIS
> +            Entry : 020000000000           <- First byte used here, CXL BW
> +         Reserved : 0000
> +
> +
> +==================================================================
> +Switch Scoped Latency and Bandwidth Information Structure (SSLBIS)
> +==================================================================
> +
> +The SSLBIS contains information about the latency and bandwidth of a switch.
> +
> +The table is used by Linux to compute the performance coordinates of a CXL path
> +from the device to the root port where a switch is part of the path.
> +
> +Example ::
> +
> +  Structure Type : 05 [SSLBIS]
> +        Reserved : 00
> +          Length : 20                           <- 32d, length of record, including SSLB entries
> +       Data Type : 00                           <- Latency
> +        Reserved : 000000
> + Entry Base Unit : 00000000000000001000         <- Matches Entry Base Unit in HMAT SSLBIS
> +
> +                                                <- SSLB Entry 0
> +       Port X ID : 0100                         <- First port, 0100h represents an upstream port
> +       Port Y ID : 0000                         <- Second port, downstream port 0
> +         Latency : 0100                         <- Port latency
> +        Reserved : 0000
> +                                                <- SSLB Entry 1
> +       Port X ID : 0100
> +       Port Y ID : 0001
> +         Latency : 0100
> +        Reserved : 0000
> +
> +
> +  Structure Type : 05 [SSLBIS]
> +        Reserved : 00
> +          Length : 18                           <- 24d, length of record, including SSLB entry
> +       Data Type : 03                           <- Bandwidth
> +        Reserved : 000000
> + Entry Base Unit : 00000000000000001000         <- Matches Entry Base Unit in HMAT SSLBIS
> +
> +                                                <- SSLB Entry 0
> +       Port X ID : 0100                         <- First port, 0100h represents an upstream port
> +       Port Y ID : FFFF                         <- Second port, FFFFh indicates any port
> +       Bandwidth : 1200                         <- Port bandwidth
> +        Reserved : 0000
> +
> +The CXL driver uses a combination of CDAT, HMAT, SRAT, and other data to
> +generate "whole path performance" data for a CXL device.
> -- 
> 2.49.0
> 

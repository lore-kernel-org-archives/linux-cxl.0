Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2755C16
	for <linux-cxl@vger.kernel.org>; Mon, 18 Mar 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784298; cv=none; b=CaGrnAc8jUxnLT/C9Ebvhxa2HKCLx6SAs7pWBTCaXO5r3D+HwP+w2luvEPsVZhHq2lvHGAp1ftJSxyN7pBQRLXU6SIR0Y/i5W697tvTmr0jzNanxB4/34lptRY/k6+UaYdTUCiftcOooT9FzAlgFlqUCYcSHyLGIGALwRGebbTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784298; c=relaxed/simple;
	bh=mz6Hep8+8raXo4mTDv6pPAlc+LtNuOP76p+skgh853M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOOg7ONac0qLUe1HMfPDTMEqQ196RXAPsgWjYkjZyytHb5rl1NpIpkMvqGViIkw7yc/5kBH3/fUAmTqFhgRKcM1MXzQFr7zD1MZ2BosChf1eQgzs6d3+uI5uqBbpLsqwBRnr0SIr7xhW11/ch3/7rIzHRfzQIzqkIAU6MDwhMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfiWH0KU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfiWH0KU"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-609fc742044so50508627b3.1
        for <linux-cxl@vger.kernel.org>; Mon, 18 Mar 2024 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710784296; x=1711389096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBHswQV9G02gO2bZl0sGiztK295Y2llrkadXRSbyhFM=;
        b=AfiWH0KUkW+bZr6K/2cIQA+X3UdvuTJIMBh5r7UwmcLyQVOH1PKMANmFQpBM56eNgC
         Y3JC2e9IxpS3zgyTiF2pY71pXDqb3tQir9CRWU+mRtfcw/XXQboQrz46tAg5CQy2T7Rv
         +Zu4IkmNHSBUVGF7CfEvmN/7ISwlWYQ/rFrH8uHIWOdhMMv9GmSR03mn/faKe8gjTzqg
         ql8odUtF43ViAv13DWg4yzmI1huOXbhgWVdaU6MNu/xHMeACmZECt0w/dBnuqz98raf5
         2pf2LxSxoNBXJiNd+xUEElkK4i9m1R8qBkeG99UE65EoiMOndsOmN/4yLK9KIkahunLa
         v+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710784296; x=1711389096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBHswQV9G02gO2bZl0sGiztK295Y2llrkadXRSbyhFM=;
        b=ogbfgARbEcN8tRz8EW6n/DyZVWeMqkF/tIvdrb1FswawUbvLuoWTZF6FNMblYx8DVO
         iY+4ja4vOF1V/qrz5WjvAU46tMynAVhOPmoD/OsFTPaGlYwfym7EXtVKSCM/BV2uCFIr
         vQeFmfKFy8GFRN59SVbA/GKkk5RDWXR7UnacnIK6gwOD/gVMToq5hR1CI0iqi0Xp6uFF
         MFwb6E+8BE3Fhc0s8K4vSFx8E/oohjBN0CkpD8BWyvR60wUGBKKoM+SezmhnNvQSaXin
         lZcWy4ey0e98h/SGcV8xcfWRkdihXZfHxARlsbCkZGIZ6CPbHJSduqRwPG5JQOtBSK9o
         1N6g==
X-Forwarded-Encrypted: i=1; AJvYcCVHHZFxx0ulriFyM3kQFno7ISkrmg9GXBIGst6rsy1GSOwZ037EUnjQzuJh3NRbz5Exm5dIpRfXrouNzRs8gN+xOgbRlCAcs6US
X-Gm-Message-State: AOJu0YzDEYH9/4GuVcXTmp9nxPFM6GTUfADHAeH3WC0x2GOcLN7hhJoc
	fRkL8zyTAYGZi+BO9vBuNKurDHzIL4To/aZXGq6uM+9ACjMz6Vl+
X-Google-Smtp-Source: AGHT+IGJ+fobtYj0WeLFsICVrm3rv2z20m+ymf6xdVCwH4W2k/7DL4Kfgk7zEHf7N/4bnBOy6+eShg==
X-Received: by 2002:a81:9210:0:b0:609:87d8:4869 with SMTP id j16-20020a819210000000b0060987d84869mr10778350ywg.52.1710784296141;
        Mon, 18 Mar 2024 10:51:36 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id k7-20020a81ac07000000b0060a2afc37bdsm2031311ywh.16.2024.03.18.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:51:35 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 18 Mar 2024 10:51:13 -0700
To: alison.schofield@intel.com
Cc: Vishal Verma <vishal.l.verma@intel.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [ndctl PATCH v11 1/7] libcxl: add interfaces for GET_POISON_LIST
 mailbox commands
Message-ID: <Zfh_EYPNeRJl8Qio@debian>
References: <cover.1710386468.git.alison.schofield@intel.com>
 <c43e12c5bafca30d3194ebb11d9817b9a05eaad0.1710386468.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43e12c5bafca30d3194ebb11d9817b9a05eaad0.1710386468.git.alison.schofield@intel.com>

On Wed, Mar 13, 2024 at 09:05:17PM -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices maintain a list of locations that are poisoned or result
> in poison if the addresses are accessed by the host.
> 
> Per the spec (CXL 3.1 8.2.9.9.4.1), the device returns the Poison
> List as a set of  Media Error Records that include the source of the
> error, the starting device physical address and length.
> 
> Trigger the retrieval of the poison list by writing to the memory
> device sysfs attribute: trigger_poison_list. The CXL driver only
> offers triggering per memdev, so the trigger by region interface
> offered here is a convenience API that triggers a poison list
> retrieval for each memdev contributing to a region.
> 
> int cxl_memdev_trigger_poison_list(struct cxl_memdev *memdev);
> int cxl_region_trigger_poison_list(struct cxl_region *region);
> 
> The resulting poison records are logged as kernel trace events
> named 'cxl_poison'.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/lib/libcxl.c   | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  cxl/lib/libcxl.sym |  2 ++
>  cxl/libcxl.h       |  2 ++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index ff27cdf7c44a..73db8f15c704 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1761,6 +1761,53 @@ CXL_EXPORT int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev)
>  	return 0;
>  }
>  
> +CXL_EXPORT int cxl_memdev_trigger_poison_list(struct cxl_memdev *memdev)
> +{
> +	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +	char *path = memdev->dev_buf;
> +	int len = memdev->buf_len, rc;
> +
> +	if (snprintf(path, len, "%s/trigger_poison_list",
> +		     memdev->dev_path) >= len) {
> +		err(ctx, "%s: buffer too small\n",
> +		    cxl_memdev_get_devname(memdev));
> +		return -ENXIO;
> +	}
> +	rc = sysfs_write_attr(ctx, path, "1\n");
> +	if (rc < 0) {
> +		fprintf(stderr,
> +			"%s: Failed write sysfs attr trigger_poison_list\n",
> +			cxl_memdev_get_devname(memdev));

Should we use err() instead of fprintf here? 

Fan

> +		return rc;
> +	}
> +	return 0;
> +}
> +
> +CXL_EXPORT int cxl_region_trigger_poison_list(struct cxl_region *region)
> +{
> +	struct cxl_memdev_mapping *mapping;
> +	int rc;
> +
> +	cxl_mapping_foreach(region, mapping) {
> +		struct cxl_decoder *decoder;
> +		struct cxl_memdev *memdev;
> +
> +		decoder = cxl_mapping_get_decoder(mapping);
> +		if (!decoder)
> +			continue;
> +
> +		memdev = cxl_decoder_get_memdev(decoder);
> +		if (!memdev)
> +			continue;
> +
> +		rc = cxl_memdev_trigger_poison_list(memdev);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  CXL_EXPORT int cxl_memdev_enable(struct cxl_memdev *memdev)
>  {
>  	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index de2cd84b2960..3f709c60db3d 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -280,4 +280,6 @@ global:
>  	cxl_memdev_get_pmem_qos_class;
>  	cxl_memdev_get_ram_qos_class;
>  	cxl_region_qos_class_mismatch;
> +	cxl_memdev_trigger_poison_list;
> +	cxl_region_trigger_poison_list;
>  } LIBCXL_6;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index a6af3fb04693..29165043ca3f 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -467,6 +467,8 @@ enum cxl_setpartition_mode {
>  
>  int cxl_cmd_partition_set_mode(struct cxl_cmd *cmd,
>  		enum cxl_setpartition_mode mode);
> +int cxl_memdev_trigger_poison_list(struct cxl_memdev *memdev);
> +int cxl_region_trigger_poison_list(struct cxl_region *region);
>  
>  int cxl_cmd_alert_config_set_life_used_prog_warn_threshold(struct cxl_cmd *cmd,
>  							   int threshold);
> -- 
> 2.37.3
> 

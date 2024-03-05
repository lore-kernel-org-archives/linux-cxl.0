Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0751C01
	for <linux-cxl@vger.kernel.org>; Tue,  5 Mar 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664181; cv=none; b=t6am9iDmtmcIocAXRIis0Tt/MeUhp/9EwkCwDg60i1ieXrj01eCQZ5FZGDCrWnwdxOZAKa8L58ly3nYbgMSNbXhhE1uhcfTnAaObSgVLRXL1Q07YXEEoaz7eVw+AEnyfjoshQjmKp9c2wB0imfj/VN798krlWsSuYlsCKU/mKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664181; c=relaxed/simple;
	bh=FxCjnyJzhyxRIJLthPFGKfJraOHx3GVEnOf+pk5zx7w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzpEf/csaHXdWvP9CONJdld46O9ZBtvQJYEABTAtwo7WYbBoB9qIOFvQraZY+zPaMJl5xMQytvHWiRyyH5VU6UKZnOQnIdHU1r5c+kGWN0/NDf5hT8vLVvP9QnfDcQkZm0btqYZblolqPYVXLUVHrrGvVnvy2dIEt4GNr0JzneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4NNme4O; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4NNme4O"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e649a2548cso66885b3a.3
        for <linux-cxl@vger.kernel.org>; Tue, 05 Mar 2024 10:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709664177; x=1710268977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyTFrjsijyp6jaVvcYoxPbeGVi7UycI3dnKIovRi5qs=;
        b=e4NNme4Oub9G6ZHmqKevhzpaJOPJsha43cTL8ejrcCtQ51Cdvfzugb/od7P7nYlnox
         MB/v0kAeyNEhD53yF3ZzrZHYPv9xg5ObxJjRBEtFNh7MxAd7d/mYsVSEx7r0EOctcXbI
         emEk2K4s1CqNWuLqJiDwfifbAngpvfiIOwtc0h39c+PH89fsaLlpOJ6Y0dWVdVfkmlkn
         hZ30ctY2792EDT6nb3EMmQYdVIEXON43QgT/lRiLJMnHRdKPy/U3FkRVs3Q8o/Q7tXah
         jIyd332+qDdS5HCqjyvwXXGALcZrzZNTUwYh7eorV6NvOWCYtSVcDlLlVzG+Flj3jeLr
         o4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664177; x=1710268977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyTFrjsijyp6jaVvcYoxPbeGVi7UycI3dnKIovRi5qs=;
        b=m+gx6NKOlsyjgL/d8Prf23+yc6DPPAjEn2sJPlRlCr6wsp/eZjtXsl5EUOdRtcBCTy
         hv6xklFYkeahZ7ScdOZtdunP/TDmID/po+uZT82mQ5itbrfC8h/joFn55dq5weXKuCq/
         JKcaT2Oqxjum+bG16MPf7Uv3fi6+mlNn7R2me9ffmztNhwmI6kHCU/bWYh6SaE72jJhX
         hQEhJQUP3871zyHBf4+xlJlaSwKVmaLbGrfO0w6/Q6vXKS0kY7SIcHhbVVj1fdWeZIAm
         HABQf/Qwx6R7JeUydZicdRUiiNxaeVWDjVwmfkSIpgHG1O5nqTovIV2C4/nYzjjh5uoR
         Jg9w==
X-Gm-Message-State: AOJu0YzCiJkGugSWy8QAkumwD9hzKTv2GyH/sQ4Annp3yObp3+lhKHd4
	FwSpwDkQUhW0vsyhaLkf2JhsIM1YywZQg/PKkZt3qgJfJIvZwolL
X-Google-Smtp-Source: AGHT+IHYUcjimwln/fAMwG3E1r6lAxP7gHil2Grzm1xrr1ILR3nZ2HOb0+WF75lyz3+sV0Pu4hORjQ==
X-Received: by 2002:a05:6a00:10c9:b0:6e6:49df:4dcb with SMTP id d9-20020a056a0010c900b006e649df4dcbmr84622pfu.22.1709664176596;
        Tue, 05 Mar 2024 10:42:56 -0800 (PST)
Received: from debian ([2601:641:300:14de:7784:c9b:83e4:f2c8])
        by smtp.gmail.com with ESMTPSA id lm22-20020a056a003c9600b006e5afb1bb37sm7918588pfb.192.2024.03.05.10.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:42:56 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 5 Mar 2024 10:42:39 -0800
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v3] cxl: Fix the incorrect assignment of SSLBIS entry
 pointer initial location
Message-ID: <Zednn4G1Zog5bTiY@debian>
References: <20240301210948.1298075-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301210948.1298075-1-dave.jiang@intel.com>

On Fri, Mar 01, 2024 at 02:09:48PM -0700, Dave Jiang wrote:
> The 'entry' pointer in cdat_sslbis_handler() is set to header +
> sizeof(common header). However, the math missed the addition of the SSLBIS
> main header. It should be header + sizeof(common header) + sizeof(*sslbis).
> Use a defined struct for all the SSLBIS parts in order to avoid pointer
> math errors.
> 
> The bug causes incorrect parsing of the SSLBIS table and introduces incorrect
> performance values to the access_coordinates during the CXL access_coordinate
> calculation path if there are CXL switches present in the topology.
> 
> The issue was found during testing of new code being added to add additional
> checks for invalid CDAT values during CXL access_coordinate calculation. The
> testing was done on qemu with a CXL topology including a CXL switch.
> 
> Fixes: 80aa780dda20 ("cxl: Add callback to parse the SSLBIS subtable from CDAT")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> v3:
> - use var for sizeof() instead of struct (Alison)
> ---
>  drivers/cxl/core/cdat.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 08fd0baea7a0..0363ca434ef4 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -389,36 +389,38 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
>  static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  			       const unsigned long end)
>  {
> +	struct acpi_cdat_sslbis_table {
> +		struct acpi_cdat_header header;
> +		struct acpi_cdat_sslbis sslbis_header;
> +		struct acpi_cdat_sslbe entries[];
> +	} *tbl = (struct acpi_cdat_sslbis_table *)header;
> +	int size = sizeof(header->cdat) + sizeof(tbl->sslbis_header);
>  	struct acpi_cdat_sslbis *sslbis;
> -	int size = sizeof(header->cdat) + sizeof(*sslbis);
>  	struct cxl_port *port = arg;
>  	struct device *dev = &port->dev;
> -	struct acpi_cdat_sslbe *entry;
>  	int remain, entries, i;
>  	u16 len;
>  
>  	len = le16_to_cpu((__force __le16)header->cdat.length);
>  	remain = len - size;
> -	if (!remain || remain % sizeof(*entry) ||
> +	if (!remain || remain % sizeof(tbl->entries[0]) ||
>  	    (unsigned long)header + len > end) {
>  		dev_warn(dev, "Malformed SSLBIS table length: (%u)\n", len);
>  		return -EINVAL;
>  	}
>  
> -	/* Skip common header */
> -	sslbis = (struct acpi_cdat_sslbis *)((unsigned long)header +
> -					     sizeof(header->cdat));
> -
> +	sslbis = &tbl->sslbis_header;
>  	/* Unrecognized data type, we can skip */
>  	if (sslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
>  		return 0;
>  
> -	entries = remain / sizeof(*entry);
> -	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));
> +	entries = remain / sizeof(tbl->entries[0]);
> +	if (struct_size(tbl, entries, entries) != len)
> +		return -EINVAL;
>  
>  	for (i = 0; i < entries; i++) {
> -		u16 x = le16_to_cpu((__force __le16)entry->portx_id);
> -		u16 y = le16_to_cpu((__force __le16)entry->porty_id);
> +		u16 x = le16_to_cpu((__force __le16)tbl->entries[i].portx_id);
> +		u16 y = le16_to_cpu((__force __le16)tbl->entries[i].porty_id);
>  		__le64 le_base;
>  		__le16 le_val;
>  		struct cxl_dport *dport;
> @@ -448,8 +450,8 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  			break;
>  		}
>  
> -		le_base = (__force __le64)sslbis->entry_base_unit;
> -		le_val = (__force __le16)entry->latency_or_bandwidth;
> +		le_base = (__force __le64)tbl->sslbis_header.entry_base_unit;
> +		le_val = (__force __le16)tbl->entries[i].latency_or_bandwidth;
>  
>  		if (check_mul_overflow(le64_to_cpu(le_base),
>  				       le16_to_cpu(le_val), &val))
> @@ -462,8 +464,6 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  							  sslbis->data_type,
>  							  val);
>  		}
> -
> -		entry++;
>  	}
>  
>  	return 0;
> -- 
> 2.43.0
> 

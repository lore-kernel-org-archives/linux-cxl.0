Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA21350DC
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130657; cv=none; b=FY8ifabxw3uMX7EkDFT/Djdr1nzqjzxt/DGROQFaAT4WStoTUh9rcI6Mq5YkfbRtSy5RjQanYe/6pxlkJUfCRMAiY9IyM4G3Drz7oPxtSUFf1mHgsD1L+pdaXV5z8IiW/6nf9h3Gq6QkxDiEsvdzFhRNARsrqSRyaZkAECrj7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130657; c=relaxed/simple;
	bh=0a6vue7FMaWu12amXKL+5fACnuFlAnkpsJ3HLDbNsdI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8h9GpkfjSz+zXqReLGUEzaapFHijGxf20lMRY7ReKiudsp3sOpfSB86iSGfrtuW3fkyYFmQNvIdWi+GfCrDTkiooCF8E/FDev8BFlfQNRznHZ2iuMe7wRrziEXPfCqFwLpGlnEauw1Ch6AI/+MHtBgvEj9MWrNJS99xjbgsL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5h7yNVD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5h7yNVD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d70a986c4aso28226205ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 13:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706130655; x=1706735455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4xU1xPzLV1x6z8Ss6xDVzDXbbEyrm2kDKmsKKYD7Y8=;
        b=X5h7yNVD/4g/lhu8UDhrdTAHuqC6Gh0pOWnm0CjaqdnlaM5SsKRRN8BjBQ/9J5zRZd
         Y6QWcg8/ZguOWEr30Omcc9+3B5U+18mCXdXzoAysJ4TYY16nEmTQ1+x5j+hQDSzIUzSq
         8Eda5mpT0Cs4e5I6kSH0KqBLiHt281s+Qy8SVlKtJflwjsq3CpZG+sU4bTPtwSzgndPD
         DC9MpODyjGk1pQuV9mTtB+MsJw+fi7kAPlXlKnBmmhNnZ3kWa57X/4zGH8vdUZnTWltS
         HzDO/U8e/sA+pn8i1r1+VvCIjtzqOfI6Rs9SovOuWBDbq9TRAzwgGOVLKpZg22CwQoEg
         Lh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706130655; x=1706735455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4xU1xPzLV1x6z8Ss6xDVzDXbbEyrm2kDKmsKKYD7Y8=;
        b=fRMysUcUzJ0T+E4pPj7FUP6EfC2fe0ZCAV1NqS46eGgbdS6NGWE5x5vMgI9I1x6umo
         zfJKlGqF2BExQ8yQEom8atPDwXGToEBGrmJVaaDYR87fCvKcDb+8STPxaWnHcUDG4R3V
         vOQO9ELdMdJwmV0ReRuWTKMoOe4Pbv+a2nyeQNJUSaUDkHesxS7i9uaOtqLQnVyXl/wk
         lW267+803wpn1ZGXLd9DxOIXVRzgDLK030DV/rQwBYMJzzzxan4NbRGb5rYGaF/YzpRf
         UiYDMeMwm89utne645q1bRorxihFRjzQS67e0G96HLDLb91fe7w6XRcA6Zq+uXRhZzKE
         4fYg==
X-Gm-Message-State: AOJu0Yxmce6hXX31W8+bwA4Bpg2evAl8soZQwiiT5Wj1BLKnEbBpmFte
	bRzw8d+sE47uoEEsvD1c5iY64EPyfLK8PIu4JgHdKR4mC0RVJDTI
X-Google-Smtp-Source: AGHT+IE4ZyUlrAQohEqAYTUCLHIZt6cHjZeVzqNz/BBqMndcA2TgxNfldeyeXFy9woRKTkRRL7ewDg==
X-Received: by 2002:a17:902:a50e:b0:1d7:852b:7020 with SMTP id s14-20020a170902a50e00b001d7852b7020mr1074273plq.85.1706130654808;
        Wed, 24 Jan 2024 13:10:54 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id mq14-20020a170902fd4e00b001d74dd065e5sm5700690plb.136.2024.01.24.13.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:10:54 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 13:10:51 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
	Dave Jiang <dave.jiang@intel.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Stefan Hajnoczi <stefanha@gmail.com>, linuxarm@huawei.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 02/12] hw/mem/cxl_type3: Drop handling of failure of
 g_malloc0()
Message-ID: <ZbF82w3iCa0t1awW@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-3-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 12:40:50PM +0000, Jonathan Cameron wrote:
> As g_malloc0 will just exit QEMU on failure there is no point
> in checking for it failing.

The change is also related to g_malloc. So we may want to also mention it in
the comments like " As g_malloc and g_malloc0 will just ....  ". Other
than that, LGTM.

Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fan

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/mem/cxl_type3.c | 52 +++++++---------------------------------------
>  1 file changed, 7 insertions(+), 45 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 52647b4ac7..1b92a065a3 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -42,9 +42,9 @@ enum {
>      CT3_CDAT_NUM_ENTRIES
>  };
>  
> -static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> -                                         int dsmad_handle, MemoryRegion *mr,
> -                                         bool is_pmem, uint64_t dpa_base)
> +static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> +                                          int dsmad_handle, MemoryRegion *mr,
> +                                          bool is_pmem, uint64_t dpa_base)
>  {
>      g_autofree CDATDsmas *dsmas = NULL;
>      g_autofree CDATDslbis *dslbis0 = NULL;
> @@ -54,9 +54,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      g_autofree CDATDsemts *dsemts = NULL;
>  
>      dsmas = g_malloc(sizeof(*dsmas));
> -    if (!dsmas) {
> -        return -ENOMEM;
> -    }
>      *dsmas = (CDATDsmas) {
>          .header = {
>              .type = CDAT_TYPE_DSMAS,
> @@ -70,9 +67,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>  
>      /* For now, no memory side cache, plausiblish numbers */
>      dslbis0 = g_malloc(sizeof(*dslbis0));
> -    if (!dslbis0) {
> -        return -ENOMEM;
> -    }
>      *dslbis0 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> @@ -86,9 +80,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      };
>  
>      dslbis1 = g_malloc(sizeof(*dslbis1));
> -    if (!dslbis1) {
> -        return -ENOMEM;
> -    }
>      *dslbis1 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> @@ -102,9 +93,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      };
>  
>      dslbis2 = g_malloc(sizeof(*dslbis2));
> -    if (!dslbis2) {
> -        return -ENOMEM;
> -    }
>      *dslbis2 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> @@ -118,9 +106,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      };
>  
>      dslbis3 = g_malloc(sizeof(*dslbis3));
> -    if (!dslbis3) {
> -        return -ENOMEM;
> -    }
>      *dslbis3 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> @@ -134,9 +119,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      };
>  
>      dsemts = g_malloc(sizeof(*dsemts));
> -    if (!dsemts) {
> -        return -ENOMEM;
> -    }
>      *dsemts = (CDATDsemts) {
>          .header = {
>              .type = CDAT_TYPE_DSEMTS,
> @@ -159,8 +141,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      cdat_table[CT3_CDAT_DSLBIS2] = g_steal_pointer(&dslbis2);
>      cdat_table[CT3_CDAT_DSLBIS3] = g_steal_pointer(&dslbis3);
>      cdat_table[CT3_CDAT_DSEMTS] = g_steal_pointer(&dsemts);
> -
> -    return 0;
>  }
>  
>  static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> @@ -171,7 +151,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      int dsmad_handle = 0;
>      int cur_ent = 0;
>      int len = 0;
> -    int rc, i;
>  
>      if (!ct3d->hostpmem && !ct3d->hostvmem) {
>          return 0;
> @@ -194,27 +173,18 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      }
>  
>      table = g_malloc0(len * sizeof(*table));
> -    if (!table) {
> -        return -ENOMEM;
> -    }
>  
>      /* Now fill them in */
>      if (volatile_mr) {
> -        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
> -                                           false, 0);
> -        if (rc < 0) {
> -            return rc;
> -        }
> +        ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
> +                                      false, 0);
>          cur_ent = CT3_CDAT_NUM_ENTRIES;
>      }
>  
>      if (nonvolatile_mr) {
>          uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
> -        rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> -                                           nonvolatile_mr, true, base);
> -        if (rc < 0) {
> -            goto error_cleanup;
> -        }
> +        ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> +                                      nonvolatile_mr, true, base);
>          cur_ent += CT3_CDAT_NUM_ENTRIES;
>      }
>      assert(len == cur_ent);
> @@ -222,11 +192,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      *cdat_table = g_steal_pointer(&table);
>  
>      return len;
> -error_cleanup:
> -    for (i = 0; i < cur_ent; i++) {
> -        g_free(table[i]);
> -    }
> -    return rc;
>  }
>  
>  static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
> @@ -1168,9 +1133,6 @@ void qmp_cxl_inject_uncorrectable_errors(const char *path,
>          }
>  
>          cxl_err = g_malloc0(sizeof(*cxl_err));
> -        if (!cxl_err) {
> -            return;
> -        }
>  
>          cxl_err->type = cxl_err_code;
>          while (header && header_count < 32) {
> -- 
> 2.39.2
> 

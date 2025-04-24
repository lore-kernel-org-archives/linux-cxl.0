Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A897DA6D
	for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491387; cv=none; b=HVMO6ubEbHEn/2rokOwFXyuptbCqn9cxGFecBGLq2heXdb/IHSPgEPad3dpAQcXtFeSGkUP5LmUjW3VOxbN7jghdY1C0zRJRc2uz2AMVaDsatDQ9hgJnTktmg1otxWspJmHNPTP+WdB0bWU8ewbXV8TBhovTQMa6s/zGL5ozVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491387; c=relaxed/simple;
	bh=oFZSQzkCeP9jY5ZuQAlAlwZNQ3RVfHNGSYM9ra17Ssg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dn27Er93OgZrp7/t2TKOGXE8+MAublzWMYxZnC6tjyUx/pRFbJsYW+AKXH502FG5HI9tWxenh4WW87Gw/fKvFAPUA/qRYFHBP4X0c7laAiNNeoadISZ5C9+K1bNkG9DbfmQ8QU21MckUBdpEVpUn0CaEEjUzA+pdVY6St7L0QVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjsvt6jVNz6L56y;
	Thu, 24 Apr 2025 18:41:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A42B1402EF;
	Thu, 24 Apr 2025 18:43:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:43:00 +0200
Date: Thu, 24 Apr 2025 11:42:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 3/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <20250424114259.000000a0@huawei.com>
In-Reply-To: <20250317164204.2299371-4-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
	<20250317164204.2299371-4-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 17 Mar 2025 16:31:30 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> Add dsmas_flags field to DC Region struct in preparation for next
> command, which returns the dsmas flags in the response.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 2 ++
>  include/hw/cxl/cxl_device.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 731497ebda..452a0c101a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -237,6 +237,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>                                            ct3d->dc.regions[i].len,
>                                            false, true, region_base);
>              ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> +            CDATDsmas *dsmas = (CDATDsmas *) table[cur_ent + CT3_CDAT_DSMAS];
> +            ct3d->dc.regions[i].dsmas_flags = dsmas->flags;

This is relying to much on the ordering of creating fields in
ct3_build_cdat_entries_for_mr().

I'd rather you just stored the information flags is built from in CXLDCRegion
and then built the field that is wonderfully called 'Note' in the DC region
configuration in 6.2 spec.   I've sent a mail to see if we can clean that
'what is the field called' question for future spec releases.

Whilst the flag definitions cross refer the CDAT spec, the actual locations
of those flags matches, but doesn't cross refer so maybe in the future
we will have other flags in here and locations might not match.

>  
>              cur_ent += CT3_CDAT_NUM_ENTRIES;
>              region_base += ct3d->dc.regions[i].len;
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index bebed04085..81b826f570 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -609,6 +609,7 @@ typedef struct CXLDCRegion {
>      uint8_t flags;
>      unsigned long *blk_bitmap;
>      uint64_t supported_blk_size_bitmask;
> +    uint8_t dsmas_flags;
>  } CXLDCRegion;
>  
>  typedef struct CXLSetFeatureInfo {


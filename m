Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07671381B1;
	Tue, 23 Jul 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756976; cv=none; b=USnFbIF0aBZWHR5BA+fL6LykPxLo45j7MlEQbh1z3QigHaytZRC9o5fHQSo2MLWKQ+kdV2bk2Gfuo8TLMGKsQ63/2YX0oS55rUPc0AnlKhpsh9E9wL74XW5jedAl6Z8y1nAnPmgGmHx7UyvG5NmNiiveysGItZ2E4wcxIcJ2HWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756976; c=relaxed/simple;
	bh=ukXSgZlZzqNl2Shk56zE2uJF2BQgmxvy6tlluHspA78=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alDeyAn4eTNLCcMwiX99F30DozoLb7oCl9vFqmuk90JEGJwtOVDvYfgws8E1b5WvHFmOkBYGZbNbM0BO7MJ+nbI4ulfmvdMMP4Dq6Me0xl1mzSggatW2dn1qXZqZyWpyrUQE+y23Qzvuv62bZ0J75ecCsboo7mfB2xt+wcV9S0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDWF8sbx; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDWF8sbx"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0875778facso3333997276.3;
        Tue, 23 Jul 2024 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721756973; x=1722361773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANWw5uNeyRqUnyFj0bwffCAjqYWhMwE6a/JHlQCsG5w=;
        b=lDWF8sbxytXW/YPADHKs53GeLU7iSGBri3UT01ek+7qhsPyel4/7j5FV5o4B40JMTt
         xPqPH2gz2Kv6f59ILc88NPDkOmomo6tEW7PIGRSIknWZTYWTYmuuBx6WPSP303t/cUCI
         WnbyUn4QKK4w7sFDU+S3amp0U83I2RhUw1sSaknO8cSrcq9lzoUszeu76BE97eZ3HjRp
         Sz6EtCZZ7qodADYaLge2/xpl2Hts0Ol8ZSWK+aTtADRmv8K3sBKqiqDgyayvd9bNFY9j
         wKALL/j+yNIydBJ+LK+q3016CHg4qGruLFA0cfMS78/EiOIoCLrAiDJQzZdc3qXhh4A1
         ciwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721756973; x=1722361773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANWw5uNeyRqUnyFj0bwffCAjqYWhMwE6a/JHlQCsG5w=;
        b=KXJjWreRKcHtAgcIuFQqeLaxsS+G59NyMJ5U/AJiWg4UfPb9hHSxJRpFDZqhnCTk8O
         YMJCG1tvDFjalyVXsMlHM+FH7JVaKfQxN4101V/1m/cxDyxoeZkavWx0hRBNOyTYlctf
         iXm54ZCULKbmz/EXjzhNIxVYZ2eECFGJrTddatsKjBHk88FnHpOD6FFBqk+HfWgd3WvW
         vlRlxmzO+j6lucBXs537R6llCJiCXDTH5vyVSxGpboT6KCMyp2dUva/Yv2mQ/lP604en
         V4hqWT3fiCLuax60DZkX/anEygX2M0tgSIE31zi0LmjwzOzeZzVumQC/4xQD56nmEeH0
         EOew==
X-Forwarded-Encrypted: i=1; AJvYcCVSOrZcSs79w3GyDLUg6TSLOq58aGO3erZCk1kHRTBrW1TxYBbI+dICfP8C3v5NAoeuD2cOWtC8zkZVpciSfvASAc4qvMbfsyRtPbrweCPYVNvcbBGn4sY2hrOW7GotgFToRE/MmwJ2
X-Gm-Message-State: AOJu0Yz+ydFWit8H90wDlkd/RIc+EgjYBN3YiWQKczuH7Ec7d6B96G/U
	r8/gyGtUI7nP/1jLE+6wZK9xFF5MfaE0gd1BbQOBJOdJwuMKccUWaGrY1w==
X-Google-Smtp-Source: AGHT+IEETxrwz681WygXsuHTtpOPDiZXhAZdhe6NRhewySnnyu3I/1tQHPi9s6okYskK/Sx0bVbP5w==
X-Received: by 2002:a05:6902:2b87:b0:e05:fc94:4e30 with SMTP id 3f1490d57ef6-e0b098c31d6mr617290276.47.1721756972950;
        Tue, 23 Jul 2024 10:49:32 -0700 (PDT)
Received: from gpd ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0860ae9c1asm1942108276.50.2024.07.23.10.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 10:49:32 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@gpd>
Date: Tue, 23 Jul 2024 10:49:30 -0700
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] cxl/region: Simplify cxl_region_nid()
Message-ID: <Zp_tKpLvjvSBgIB6@gpd>
References: <20240618084639.1419629-1-ying.huang@intel.com>
 <20240618084639.1419629-4-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618084639.1419629-4-ying.huang@intel.com>

On Tue, Jun 18, 2024 at 04:46:39PM +0800, Huang Ying wrote:
> The node ID of the region can be gotten via resource start address
> directly.  This simplifies the implementation of cxl_region_nid().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/region.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index dc15ceba7ab7..605efe3562c6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2309,15 +2309,13 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  static int cxl_region_nid(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_endpoint_decoder *cxled;
> -	struct cxl_decoder *cxld;
> +	struct resource *res;
>  
>  	guard(rwsem_read)(&cxl_region_rwsem);
> -	cxled = p->targets[0];
> -	if (!cxled)
> +        res = p->res;
> +	if (!res)
>  		return NUMA_NO_NODE;
> -	cxld = &cxled->cxld;
> -	return phys_to_target_node(cxld->hpa_range.start);
> +	return phys_to_target_node(res->start);
>  }
>  
>  static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
> -- 
> 2.39.2
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>


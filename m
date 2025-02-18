Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306B749C;
	Tue, 18 Feb 2025 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739845226; cv=none; b=pKHSLme9n2mH6LTAHtYhgXNcRuAAG1RtLrTKDVqzU5cVcMwKZscfJucqi1lXYO8URJlMQUflDitjwwaWgGvViCg9CgGEoxpE3x94BEZFPqvs/DMHdjpixfs+r8EbCoet6SlkczA4nGQFG/DQISUQECM13wbXWVNRiH+qDX4A8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739845226; c=relaxed/simple;
	bh=mQT153XU+LUXIdmyQcBJ+jLOKSDewI1RyRsKB+T2nEI=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIxaFKlWjP/LE6y9dcPoYi863yEEGYijHYSXBXZebgZO1/Kbh1hKLpAG6BzEVr5qMl5V/+D6jFVGPC4qRSbLmOj15rd4YXW/DtU/NmkY/7F2/DyE1wWXyCh/k2qoBBTm1tlXcqccZks15unpifw5UWwZWes3uDdOZ4L5z7ozl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E68sDGIN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E68sDGIN"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f42992f608so7499727a91.0;
        Mon, 17 Feb 2025 18:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739845224; x=1740450024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=csJP8p+MIKfp9UXiIAtHs4GYIWnmVtAB4XRG7isriQg=;
        b=E68sDGIN77AG/Wsd3eNL1Pq7eybAzKin1Zs3PiTAiu4ANGW9jOWNsbmoCVgSmjzLNB
         B3miwy3Pbb0MJQ2b/mIKLlW5Ed6aFtxQvlK6VAu9NvbdLyKUnbyccEDck3Vaj5RvnAHt
         U5B+ycUHKchh9OETunm9+oVDYbnkX6xrnOPZgRsF7wPHBHu36CWWFicrMDD5mTfkTd/l
         bBis8AvxOmhFlYn3BfoC+jook5eC1QSQMOEt9817YlL5S05STyHFncD8/dgJG8TmMoYb
         5yxJZBaYcBse2rC+18/2bCnyIAt9i/ViJGBXM0I3mSgs36f6bPcwBLY5t+rW968d9zr7
         fVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739845224; x=1740450024;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csJP8p+MIKfp9UXiIAtHs4GYIWnmVtAB4XRG7isriQg=;
        b=rw2yg1KnndJF5T0/ifRz+IwCkEM0AHYDpmfDBmTl5s226YBjfCeZGacpupvN5+8P61
         C7YUaea+iREPyR3EWYd+tdjsFJEuJbiOqOprRVBdUj9wCtCUC7o0pO8bjTeCtpOzlGNv
         47eMJ5s5gNCf2ab/FEQZGwgH668P5Zob82jA1k3ymqtKlDPYrUvjSczUZ7JCUPrYdgjt
         92KGqlAXT9G3+TuyzE7P6UPXlclF3PjW1K2+tT3WaSeka7Zzr/pAuQ/t48/kZu7/kivS
         dwe0E7VfvJNG2GVr82LzVXEw75hwSOB9zTrLfel71WkvWiG7ZF9bKa0oqPEgwl7csnh8
         3hiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZFpseLp6u4AYFkLgqEpfDATrRtusVhEX48UcndJQFCaIBxTzjRMGHVsuJraAuVKVvgitQVAE0YC0=@vger.kernel.org, AJvYcCWgelOwDnhfUS0LI7VgEF7XxWkYvoc5/ztIoDQvocd+PN2Cg16pkKMnajLxtSwlBPTzGHtKqemQJZy+CPta@vger.kernel.org
X-Gm-Message-State: AOJu0YyImZdzO2q4pQ7wQYZtflHSHjGl2hWP+OUg2B8aykZgONQeh/il
	XtgPgmUuxHMEzuAPb1mtJFU7tpZCWUXwWLjNlGjQOOBbNRdcvvPo
X-Gm-Gg: ASbGncu2GD5WK3woPPjDh3j2b1JdhxeJnC8ZpuPdv3/mSMu66uIuzzLr193+mvS1YYE
	Mh5T412qQJghIdIOaleYdBslkaqxxmLctxoisj93wT//697rWFMcf6hhbablo48VHrPAKvDm5Fx
	mquRGMh5cyCPjISXQ2yfe2W7ed8sjAX91kYELtxoyjpUssSOdR/wvo24AGyMJzzYfdDQy/Jb33B
	AkoWHSHUTT7Or5z8YxzKm3B250JJjS4mGRbSjvviMFkyiNBlAd97EW0KxlLk2tigjYau/uhLxPc
	7ZhPE0a9ehfqKzKPihuoclprY1p9orYuqKSiDUl+Yp4=
X-Google-Smtp-Source: AGHT+IFLqdZnR7NiVCaqT8hxtiSvjaYCcg/X+0mPqtZbu9qHISmkC4IRZQ5MEJmd0IiGvgBKk29XTw==
X-Received: by 2002:aa7:888e:0:b0:730:8d25:4c24 with SMTP id d2e1a72fcca58-7326179e908mr18092511b3a.10.1739845224145;
        Mon, 17 Feb 2025 18:20:24 -0800 (PST)
Received: from asus. (c-73-189-148-61.hsd1.ca.comcast.net. [73.189.148.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326c87a86esm4501133b3a.132.2025.02.17.18.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 18:20:23 -0800 (PST)
Message-ID: <67b3ee67.a70a0220.21e7fd.0285@mx.google.com>
X-Google-Original-Message-ID: <Z7PuYr5k6gwlo6cs@asus.>
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 17 Feb 2025 18:20:18 -0800
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn
Subject: Re: [PATCH v3 1/1] cxl/pmem: debug invalid serial number data
References: <20250218014746.166565-1-wangyuquan1236@phytium.com.cn>
 <20250218014746.166565-2-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218014746.166565-2-wangyuquan1236@phytium.com.cn>

On Tue, Feb 18, 2025 at 09:47:46AM +0800, Yuquan Wang wrote:
> In a nvdimm interleave-set each device with an invalid or zero
> serial number may cause pmem region initialization to fail, but in
> cxl case such device could still set cookies of nd_interleave_set
> and create a nvdimm pmem region.
> 
> This adds the validation of serial number in cxl pmem region creation.
> The event of no serial number would cause to fail to set the cookie
> and pmem region.
> 
> For cxl-test to work properly, always +1 on mock device's serial
> number.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  drivers/cxl/pmem.c           | 8 ++++++++
>  tools/testing/cxl/test/mem.c | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index f9c95996e937..73787afe1b9d 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -383,6 +383,14 @@ static int cxl_pmem_region_probe(struct device *dev)
>  			.position = i,
>  		};
>  		info[i].offset = m->start;
> +
> +		if (cxlds->serial == 0) {
> +			/* include missing alongside invalid in this error message. */
> +			dev_err(dev, "%s: invalid or missing serial number\n",
> +				dev_name(&cxlmd->dev));
> +			rc = -ENXIO;
> +			goto out_nvd;
> +		}

Should we do the check earlier in the code? 
For example, right below if (!nvdimm) {}

Fan

>  		info[i].serial = cxlds->serial;
>  	}
>  	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 8d731bd63988..9e098cf06603 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1533,7 +1533,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>  	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>  
> -	cxlds->serial = pdev->id;
> +	cxlds->serial = pdev->id + 1;
>  	if (is_rcd(pdev))
>  		cxlds->rcd = true;
>  
> -- 
> 2.34.1
> 

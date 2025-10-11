Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81C23C51C
	for <linux-cxl@vger.kernel.org>; Sat, 11 Oct 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760192916; cv=none; b=ThoUejL9UgXkZMztaWIgBWTU3iH7O/fGJJfAMlQGQLfU+Ol/J0gcDuV0yMkOtRXXpcZDZj/+ClB7B4erTmhO5u6/UH+xFsFfj4S9VZr2O7LlnCRLzSuT+RVXkAAWzyo0IbZqRYg0ebK0YmHEjfKdt1BRrSPTBhZifrpKoG4k8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760192916; c=relaxed/simple;
	bh=wg3CCArs5ScqiKJG1dxjbKCVfL9xs8sBpMfSZHOdxRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGIHdazpq2cNiDMWSU2qCtPEFjh6y1THNp08Pq/sWf5ccX2D2tX3O5mRPSR9VTvg3mIkdkDlb/HOkabWQO6dzr/1S96XCkg8JToZNsKTTGass7xTmIMtvioOimL4ASePXhlI+5PahDoEMhDKKmlKsF9DxHpTzQCAQxpe1pOxMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q1GggkaN; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q1GggkaN"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-796d68804a0so41913016d6.3
        for <linux-cxl@vger.kernel.org>; Sat, 11 Oct 2025 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760192913; x=1760797713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHTY9nKWDZPU06aV4UcjEkkECR+RF2ZeZw1d9XhO2aQ=;
        b=q1GggkaNhZPCiyxKU46WflD9FkLqjPkEv/mSr/9egUAgok0FUOINdR+6xwFmpcgUIa
         k3QVZECsH0RicIJsGGyxxXJSjZUXrCNE2noEPXdPjU6FJZ7bdVdt8I1kLHguILuSlQM9
         Qtzv9LXCpx9jQ5Qpm3nflgHq6EQxOCSUDvqZQSbCFskvqoDq6nY0zsqcv2B/8jguHNv4
         hrwsHBYdcyz7XWuLOhiu/tcJ1qaMdAegMfr54MHijCIAqbS9jajFXqK8O6glGgP0d1M/
         ogG2ynpHoSX+f4imRkRmG9JLgsvJkhoSKRnfRuxwj3N+hZ2uWMWeRxMrKJ3yRgEiHQ54
         9Etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760192913; x=1760797713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHTY9nKWDZPU06aV4UcjEkkECR+RF2ZeZw1d9XhO2aQ=;
        b=Y84l2hjcJq3MYpW/ASgTmpTtQdUfDMl6jJs3QHH+nAFWjVpgqAJH9ffkPQZYqvXe2W
         JX7XoKluLo6xxCmUOGWWrIY5wyC148R9rtnPd0ZmcxjPUkIbV26Ih5zFiQgEBWTJrapI
         G55HnLrDBo28AuJG9hUKvVFcFM0mECkFJk8gjThHM32zkkmuJFcQs5W2YsFzMJNR3YGV
         opScLx2o8PY38QJebnwxRQ+t0dzPefEXub95AO57AdGOuWxwC5zePzkoEA0FD0FnUHmf
         xz7+GpFhoFxmwHtrZ59l+jGFqxRJnU/bsaGkLGlsiefZzZ4MzUM5YLLOy5DLlwoJB/hO
         mT2g==
X-Gm-Message-State: AOJu0YyN1+r0XtZuZhehS7om7lHDzOmiR6yaDzKiDN0nF4ubJ6iatRLS
	IsP1vcOvQZmAQK3RNfpaDe+ZooPs+14kGCq7qg2QLSP1jCNOwFjxAOHbwYxN7ZzAPGs=
X-Gm-Gg: ASbGncsh/5xZp4r8YutfhhkoBF7mBePuYtaik0sM93tO6lwnbpLgqZxEgQVmGCJTzwq
	0Ea2ZP/MNaHNwDtykanc6+sTVCYdm34EQPLay1csuvFD1nk7aE9jBuSuZczquYCICnvQi94g4Fy
	sjZDhPuCa8PZ6TY7gYTfSBm59+MC89Q/QIzqdQ9QqitPKm1ydSGgDvnhk87zUD9wFp56QBCRmjH
	1IArB0kyCFLDObmM+m3ogchZaRRzG0sDxsMpdhmY0GTSvFy7qS+4D4fsMQqCqnIndCZ+Wr9G1YW
	TvNyL0hQokYGLhfI42fg8MVFIdgjKB/9NqMdY5vkqNrWMCfvLFM91VvB9a/ajikhPRg66Li5S20
	15omRxNB25Kq0RJbmF+qdXd5F8EjVA/NcAhRFvwNNhbXATQUvxyVtRU/70SIcXS9IR9A9HSwQVt
	HdcymjeYb1YHjB+8eG81Hv9u9f
X-Google-Smtp-Source: AGHT+IGkDhcEriUlY3tMsJn1ZFmne8ZzSflH5WSsCJI5ZXywsrD4MNkQlLocJlLOU2Dj0A4elAUTXw==
X-Received: by 2002:a05:622a:3c7:b0:4e5:1bb7:df3e with SMTP id d75a77b69052e-4e6ead77042mr214377981cf.51.1760192913561;
        Sat, 11 Oct 2025 07:28:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706ba8136sm37931471cf.7.2025.10.11.07.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 07:28:32 -0700 (PDT)
Date: Sat, 11 Oct 2025 10:28:30 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, stable@kernel.org
Subject: Re: [PATCH 3/3] cxl: Fix match_region_by_range() to use
 region_res_match_cxl_range()
Message-ID: <aOppju57z8w8tfoU@gourry-fedora-PF4VCD3F>
References: <20251010205755.205280-1-dave.jiang@intel.com>
 <20251010205755.205280-4-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010205755.205280-4-dave.jiang@intel.com>

On Fri, Oct 10, 2025 at 01:57:55PM -0700, Dave Jiang wrote:
> match_region_by_range() is not using the helper function that also takes
> extended linear cache size into account when comparing regions. This
> causes a x2 region to show up as 2 partial incomplete regions rather
> than a single CXL region with extended linear cache support. Replace
> the open coded compare logic with the proper helper function for
> comparison. User visible impact is that when 'cxl list' is issued,
> no activa CXL region(s) are shown. There may be multiple idle regions
> present. No actual active CXL region is present in the kernel.
> 
> Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
> Cc: stable@kernel.org
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

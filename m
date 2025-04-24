Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662741A5BB2
	for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531381; cv=none; b=Yet2o6WLgNC5fCcOdmiJhXs0+AfPUkoHlDiOGGyvy995PpuYBud+pIvFKge5G7nB3/OaDhdDV0lY05+LKsKeIrZ1vbJv9RTHrewb43kyl/bd73PNoHLYljr377qJre3uKp2kdPWpfSfSZBdewT1JG1JxeGcCXQJ3du2rFvIOtb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531381; c=relaxed/simple;
	bh=1aRfcngz3t0Reu+ykpikN3FVUubI/Am/J/BJGdZpneE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw2B0Y4S5A7Q9PNwwPvMwVtUsZZpaDrjVpj/gUdZx1d3mrQeGySKIsjst1ldVhGQzVkPwd14dfUfzcWGbMn7XvrTIlXxUdXROCScUDlLi3b+v+ggKfLO9zU0I8D7ouGiCkR/UlozmNjXFtXXrLBuSlFKEcoips0jgkJhmHS0TfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=A3aWgwSi; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="A3aWgwSi"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f0ad74483fso17667926d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745531378; x=1746136178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNwByNKdG9uz9NysHExE1f7B9TlMZjPyDOEKCrzNzw8=;
        b=A3aWgwSiN/4tjw6+g1w/Fc/ZI9FhbkTa3D7UMEDyaRe6m4OWK12QeSBgvSbgFNuhhu
         /FILCH9AhMnAifzS8znARge8aL54g11FmkBitrByTq/BksdUB1Od8tfG4HzLrc0DeKTo
         24qc72Mw1QOLvmfh5vQkgqB3EkL+RfProy01waRnK3n6RM75VJFLRRTRJsanEAvbnP9d
         zonHss+4parq3ahd88Ac2wFKT3e54rCN28LwLL160F0nFY800G6I57grc4Zz8dZDrxXU
         NVnsgUUZzYRm2m8YckqtD2xGljB1Mxe12g2OlnErY50uTgNDtKOr0pLr3Eby/yNn0HOw
         dzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745531378; x=1746136178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNwByNKdG9uz9NysHExE1f7B9TlMZjPyDOEKCrzNzw8=;
        b=Sept8r2d9blxxkjVB48Q0KgT32kfpiuYElBnOeaeyzN/J/zm44WbIKaXlElBvMUgkK
         mH1gLjycKV/44CO6aiT6C0r7fFBdHM88VyxpgFfBOP+l4h53A+KWjap9tUQ4EyKEPO5j
         dKS3BM6XYz2kTHcuJn5A5Phfl8cxokDNhP2wxw6JwWjx9cfStpjJ6dxMsCC+Qvpe7NJf
         HM5jWD/xoSCua1NHpGc6wuGNW9G1/N5y8PoxCFIzzUa62Bg8EfDKuz32xRJrqmVoJGe5
         C4SJiyPZYp2pYtsVshcLgA7LhLg0zQ2UXa8tAPPk9Hc3mbKk21HBLutRlp3OoKgu/Yaw
         xp/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmxxrHLajHrzsMiZEm3793baTKA1clQw/H5IQ4YCRYdV2gyPx9h2D14x7EUUdzQZGLi8zgKTaBbPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJloAlXoV+fMNSY5+Ma8Ke5LCg1QdNs7bOqEMP2ImMNYsJpk43
	ymhr2Sy+46EDUPPP+UczKH03+wcUwlGJUqjx9/B+4BFEczPvb7a5UBFWdo0/ONA=
X-Gm-Gg: ASbGnctsFTSDVmEgYUkllFctgeCoIkDpLhlBsOez6m/zbnIVun4XhKhfYEqqd+ZVx7z
	7QwaUToXF497Gq7toklJJSfp9o3u8w2JcUNMxps2STKKuwYp1FLe0dAsJs/LjMswKORtTvJ8Tks
	ujf2bD93tVbYAu+H5/VZ/QyScdvsU6I93BqM9OrFxJtwT0U9vqSgGPvuH/A9v93koOwg/rQmlS2
	EbRnhs1KkjW+Mq1QXmOEpU/TDc2RJYmLiGHJfoV3AsF7qXjNXXKvpsAdTrsKz91u8a74bX3z2jc
	LYktYF/jCCeeLA7NOWlJMdoV27Duq0zSunP7OxJyvAIEgxUgJEoFVteK+JzI7NxhFnM0eArnaGc
	/pGk1o5uY1sJo0rRV58bnrTRhIjTN/P8Kog==
X-Google-Smtp-Source: AGHT+IFHelggdM4itqUdnMB3pkEhQKzQFiEwTaYzYTxWngWCOBuYKgq96+vIbqTUY+rUr/Si6bJYaA==
X-Received: by 2002:ad4:5aec:0:b0:6f4:c2e5:9dc5 with SMTP id 6a1803df08f44-6f4cbb5b66bmr765446d6.44.1745531378141;
        Thu, 24 Apr 2025 14:49:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958e9fbcasm137957585a.99.2025.04.24.14.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 14:49:37 -0700 (PDT)
Date: Thu, 24 Apr 2025 17:49:35 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 06/15] cxl/region: Use endpoint's HPA range to find
 the port's decoder
Message-ID: <aAqx74FWd--8aVw1@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-7-rrichter@amd.com>
 <aAmFk1iQcS7UpslQ@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAmFk1iQcS7UpslQ@gourry-fedora-PF4VCD3F>

On Wed, Apr 23, 2025 at 08:28:03PM -0400, Gregory Price wrote:
> @@ -916,13 +921,14 @@ cxl_find_decoder_early(struct cxl_port *port,
>  		       struct cxl_region *cxlr)
>  {
>  	struct device *dev;
> +	struct mad_context mad = { .p = &cxlr->params,
> +				   .r =&cxled->cxld.hpa_range };
                                               ^^^^^^^^^^^^^^
					       spa_range

Woops, missed this.  Not sure if it goes here or a later patch, but
that's needed to make this work.

~Gregory

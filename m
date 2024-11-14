Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90F193408
	for <linux-cxl@vger.kernel.org>; Thu, 14 Nov 2024 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617746; cv=none; b=VaVllUeVB6HTMD67KjZGMc9J2hNv+JjmfqkpxYTo5UdAVXMe1pHItZUh7jXvw52cwzUsuWsPvf/r1giTFX9QAom47IILhWfF8lyPiEnKRqQi+7jsK1qw68q2bUeiq+D2fZh96bJk3gJoyrwV4YNi0CX76A/j896j9ZxjBYK8DHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617746; c=relaxed/simple;
	bh=r3dYo8E0jcfa+old5XKwH/CU4OAgW5HEiIzPWAaIjWY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSCFL2s2Gv2O9kBVhKpSjhUHuZ7qnkwTxSqKfulrKvDRA7ooU/q1BAjJD8GBt23u4Y/7pyD7ka01a+tSuvH8IfALP5CIryRDqgTnhTDU4kB9E8OrczixOBZdcmwQtFviHwKOhkjnvbZe7SjKMXk8dDrh2u4Sd2e5u4VHBqwNO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvyP9h3a; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvyP9h3a"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f12ba78072so882241a12.2
        for <linux-cxl@vger.kernel.org>; Thu, 14 Nov 2024 12:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731617744; x=1732222544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UyUMx9yDjp0kvSQBuU8zPZut31WXGDJ1+Et1NFiIc1w=;
        b=hvyP9h3aTIxKVTMbXzpq2scXF81jd4OcVEgahzeHg7rYyYiZk1KzH7ye1sQi5taZtq
         fO//+m1YEvacee8Irmok2DxQrZUh/3QitSFxjvyUHv91zcMv2BSFK/aiJKKplIkjHFO8
         5sSqSe6AMtR6pqDDsWCSbgXZufrxjQAjNLPMihveXZxgEhCA5P913DbJY4wnagOT76B/
         Uo/isl/0O3LcU1MXI3/KGlXD3LguGMyg934LfVbN8JebHPbAvxMRX6gFGLfjLXS3Vc0y
         nHoZhDroT2bjsLNafiB5dP0TlX4fg3xaPoC32UYkDxej09DvjkXZhkqBFvOD0bNFGkav
         v8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731617744; x=1732222544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyUMx9yDjp0kvSQBuU8zPZut31WXGDJ1+Et1NFiIc1w=;
        b=tz5+VQX9y50++z6/cUXQv1sCNlnHIGKGUbaaVrUdExqf8KowOYoPnU+HvnKMvOSFfE
         MDyGv56JMN+sJZB718t0P0zpy+yFoaBAjIExZp2rVGcgYPBSELpX/VZmNYZc9G89NrK6
         unWpAUgARCIWdFgzj9TxlfOHtX11/tc92U4zf4eJ7G+hsJw233Ebg/lbJ/Fl6fYGXavG
         D+3dp1UNi7Xdr2vbQMEhxEqrrcHa8kaza5a7f5D2dDNPcAU1B6RsgdnLdxjmkU5E7Zy/
         IxSp1BbE++6MLZA690Xjkzt/A7Kbh6zxo6TQDu1KeEJXs6hnCnfzXna3rC1BVI//p1GJ
         XJ9A==
X-Gm-Message-State: AOJu0YwCfPIKXWTAGy3LjM9pqZ6G6adqt8/9OxKkA8p6ARoFzuJcfWcu
	MucwqyuBbT1pkJ5Mabx8fz/K8I8yvmM2N3Gv1aAdjNbRTlA3nWlB7oEskmCO
X-Google-Smtp-Source: AGHT+IEzRliJ+4QG+0vxHF7SkpKSNLGLKnkdZxU6ghtxdiyQ+aEzXPY9iWkzr2tSq3zsYiLgaS9JZQ==
X-Received: by 2002:a05:6a21:339e:b0:1db:c20f:2bfc with SMTP id adf61e73a8af0-1dc90bd5025mr166294637.37.1731617743895;
        Thu, 14 Nov 2024 12:55:43 -0800 (PST)
Received: from fan ([2601:646:8f03:9fee:c740:506e:c3bb:ebba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f1b1aasm1593231a91.17.2024.11.14.12.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:55:43 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 14 Nov 2024 12:55:40 -0800
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Message-ID: <ZzZjzDCiOKbemv8R@fan>
References: <20241114112435.45593-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114112435.45593-1-alejandro.lucero-palau@amd.com>

On Thu, Nov 14, 2024 at 11:24:35AM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alejandro.lucero-palau@amd.com>
> 
> CXL Type3 pci driver uses struct device driver_data for keeping
> cxl_dev_state reference. Type1/2 drivers are not only about CXL so
> this field so not be used when code requires cxl_dev_state to work with
> and such a code used for Type2 support.

This sentence is broken to me. Do you mean something like "Type1/2
drivers are not only about CXL and for type1/2 drivers this field
is not always available for cxl_dev_state." ?

Fan

> 
> Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c        | 6 +++---
>  drivers/cxl/cxl.h             | 2 +-
>  drivers/cxl/port.c            | 2 +-
>  tools/testing/cxl/test/mock.c | 6 +++---
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5b46bc46aaa9..420e4be85a1f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -291,11 +291,11 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
>  	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
>  }
>  
> -int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> +int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct device *dev = cxlds->dev;
>  	int hdm_count, rc, i, ranges = 0;
>  	int d = cxlds->cxl_dvsec;
>  	u16 cap, ctrl;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5406e3ab3d4a..42a46e78d786 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -812,7 +812,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  				struct cxl_endpoint_dvsec_info *info);
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> -int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> +int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info);
>  
>  bool is_cxl_region(struct device *dev);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 9dc394295e1f..acf2ac70f343 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	struct cxl_port *root;
>  	int rc;
>  
> -	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
> +	rc = cxl_dvsec_rr_decode(cxlds, &info);
>  	if (rc < 0)
>  		return rc;
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index f4ce96cc11d4..4f82716cfc16 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -228,16 +228,16 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
>  
> -int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> +int __wrap_cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			       struct cxl_endpoint_dvsec_info *info)
>  {
>  	int rc = 0, index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>  
> -	if (ops && ops->is_mock_dev(dev))
> +	if (ops && ops->is_mock_dev(cxlds->dev))
>  		rc = 0;
>  	else
> -		rc = cxl_dvsec_rr_decode(dev, port, info);
> +		rc = cxl_dvsec_rr_decode(cxlds, info);
>  	put_cxl_mock_ops(index);
>  
>  	return rc;

-- 
Fan Ni

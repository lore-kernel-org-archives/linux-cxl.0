Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D74C9D
	for <linux-cxl@vger.kernel.org>; Fri, 21 Feb 2025 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096927; cv=none; b=Mu4w1b8ehqqNh/RCCSXdrG6yZQi+DlU0LlhoxrWQY7LtCsdXRJndBL/Dt64AGrNqWxuz6wPJVUuwHoVz36FHdWygIs6J1Sqdv2u6XPFwDuLH1bs/fKVXpMmzME1otvDDuPWc0MJ5jr2k+ExZOhdZIH8G3X6C7rS5OJp4kUcmet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096927; c=relaxed/simple;
	bh=uDjxJIghAu7LjWv9r7HK75xv6XOfvs0c5uF2l7ZuzCQ=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAQLEd8Q8QuHSnWTP3GlBvrBjovgX31VWTQWOXVGWW/mEABmTwOxr+C76zkYeubfF+EsCDSHaNZbs8tDJ1Qi1lcmSGmKDeCjmw+G77asbxOJC1n7yy+FvF7741/t1jrNlhHQi+SxrHOWYo0nnggyJMKFJGEubnoI/imrqoZmKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnnFJAhI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnnFJAhI"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220f048c038so28149475ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 16:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740096925; x=1740701725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q96il5xcAGYfJkp2EFS1vV5QGqZQZt3aGAlqNin990w=;
        b=lnnFJAhIQa/uL1M/URxmg3DXlAqIP6bkxJKwcBCUcyISsJQR390FDcJ9UjejpZ0p6o
         ah9vTmzCiLjWjTzIZdvre458m621w+K8IcW6vXLNWjJyEE9sq8bwNfsD93ThwsIstSBf
         ieSZoWmWdNES3DJqDhrcXwHvTjEwN+/cB1SHdm5pptx46lpRJZhHQtNVvEBzEVqc7NFW
         gN8Pa/C4KDc4iK3c2Tzz67eQ10Vib0HxRnLQvVnNdnUcfmw1GhoVOAotWkMSTsUPIIAE
         5c8JO70Ku360V/oS9FprJoLvv/RFTtogOt1EZxsmp0quI4I1H1/LvPO4GxsB+Gf4TBDz
         8KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096925; x=1740701725;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q96il5xcAGYfJkp2EFS1vV5QGqZQZt3aGAlqNin990w=;
        b=bJEs59iiiNCr4lS0aRbyjLilzI3wPWaIh3RTxzFkyKTMw36PzbmA3FEMA7qdH7FYjv
         BPA1Gu/yhzgBm8UlJUnu25NcPLI3cK36Dh1u8pf/ieZsUY3biKhrUNveZ9x3kJhZA3uq
         22zt3uMjfECV84oDaihHTps89CKlhql22dN11sCNubLNu5YtM4tngCtvYdZArYIpfQZ1
         r10Heef6Tm7Bv8B5hj6+KcyFjH89L8vUwLaeusQjd66G3t78mDH7EHW4kEQVBRYC5bOl
         Xf35HALQ0whIsmtwbl61Qdha94Iw30mGm7diSyF/CvQLO4rwJrt15A1ilOcX+2uU7jha
         nKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7ws4BtpkGnUGj9lIwcJ9H9ieshgyJ7XDQKM8P91RlyPckecQw0/IG3nm7a60jL/o4vrLJ/tnp2xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrax7L+W6j9N36KMr6sVbIHpGCL3cWZNVaXPZ5ecYU0J0hOzh
	YAoLqS61SF0O7+aPeADQrecBclXkrQkyTyf1AlIketqyz6d43UnC
X-Gm-Gg: ASbGnctl4E89DMQ5GePPWvYnqPniEhhcAmAPAY5sU2Wn6bP947jjFI4fAXbFk/oxyAO
	Wied1XktI4Q8vTW595pXbQUamjAroXn8P8JUyugGQ8wdV/wnXhlTDJZKIpFdU/ZR79by/jDMaRQ
	kWeVri3Uo8EC7rpRI7amMvmtvfsgRELRyoQDCQDnnSRYGs1kppOM5ZyWjm0MiBXzOkPblgk6wz9
	imRdpYXhmua/7OLRQd0KhOh03ROejPV9PdVJSW4Rw1cSB3rngUQSjGO8eHz7hjov7C/oa5B+fnW
	8mzsiLiA5uGuN1a9bo3ovDp14D/zpmzmtfY8fGGPJak=
X-Google-Smtp-Source: AGHT+IGH/q430HsI8FQMAt5VhEZxFYvU7P9EEHpeSjw1r6uMTX/xkQFU6lXt0j3rlp0Y8oyaYhZdvw==
X-Received: by 2002:a05:6a00:2ea9:b0:731:771:38f2 with SMTP id d2e1a72fcca58-73426cab14fmr1945512b3a.8.1740096924791;
        Thu, 20 Feb 2025 16:15:24 -0800 (PST)
Received: from asus. (c-73-189-148-61.hsd1.ca.comcast.net. [73.189.148.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326bcd94fdsm10393677b3a.53.2025.02.20.16.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:15:24 -0800 (PST)
Message-ID: <67b7c59c.050a0220.6348c.723b@mx.google.com>
X-Google-Original-Message-ID: <Z7fFmZn_GwFVnHny@asus.>
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 20 Feb 2025 16:15:21 -0800
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com, ming.li@zohomail.com,
	a.manzanares@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/4] cxl/pci: Introduce cxl_gpf_get_dvsec()
References: <20250220013604.263489-1-dave@stgolabs.net>
 <20250220013604.263489-2-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220013604.263489-2-dave@stgolabs.net>

On Wed, Feb 19, 2025 at 05:36:01PM -0800, Davidlohr Bueso wrote:
> Add a helper to fetch the port/device GPF dvsecs. This is
> currently only used for ports, but a later patch to export
> dirty count to users will make use of the device one.
> 
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/pci.c | 30 ++++++++++++++++++++----------
>  drivers/cxl/cxl.h      |  2 ++
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..96fecb799cbc 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1072,6 +1072,22 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  #define GPF_TIMEOUT_BASE_MAX 2
>  #define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
>  
> +u16 cxl_gpf_get_dvsec(struct device *dev, bool is_port)
> +{
> +	u16 dvsec;
> +
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
> +	dvsec = pci_find_dvsec_capability(to_pci_dev(dev), PCI_VENDOR_ID_CXL,
> +			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
> +	if (!dvsec)
> +		dev_warn(dev, "%s GPF DVSEC not present\n",
> +			 is_port ? "Port" : "Device");
> +	return dvsec;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_gpf_get_dvsec, "CXL");
> +
>  static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  {
>  	u64 base, scale;
> @@ -1116,26 +1132,20 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
>  {
>  	struct pci_dev *pdev;
>  
> -	if (!dev_is_pci(dport_dev))
> -		return 0;
> -
> -	pdev = to_pci_dev(dport_dev);
> -	if (!pdev || !port)
> +	if (!port)
>  		return -EINVAL;
>  
>  	if (!port->gpf_dvsec) {
>  		int dvsec;
>  
> -		dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> -						  CXL_DVSEC_PORT_GPF);
> -		if (!dvsec) {
> -			pci_warn(pdev, "Port GPF DVSEC not present\n");
> +		dvsec = cxl_gpf_get_dvsec(dport_dev, true);
> +		if (!dvsec)
>  			return -EINVAL;
> -		}
>  
>  		port->gpf_dvsec = dvsec;
>  	}
>  
> +	pdev = to_pci_dev(dport_dev);
>  	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 1);
>  	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 2);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6baec4ba9141..29f2ab0d5bf6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -901,4 +901,6 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  #define __mock static
>  #endif
>  
> +u16 cxl_gpf_get_dvsec(struct device *dev, bool is_port);
> +
>  #endif /* __CXL_H__ */
> -- 
> 2.39.5
> 

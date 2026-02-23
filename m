Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139E3EBF1F
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885112; cv=none; b=G8VqlFGuGFnDh8J0zZll4IO7TGXioVt+91SO/ItRIlCk77VhWPU0OW/WrDyntTZSCyMWAR8ru4Kq93Xy4kCM7kCwm3VJ4b7rFR+Hg5Pi7K+Xuk48w0fvY9DRZvwGVaurlq73FBInc6z8IWd1Zio2F8JTcdKJJ68DoiNChmX8vLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885112; c=relaxed/simple;
	bh=UTCY7pP8jwtjeVQIQNsWFzUyXQW83DeCNIfvTuL4g10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyuUf2YVO1T6qY/BiGzzq6byJ8JW6sGeElSzcC+MQmPvjRrYYLQNo/rDQEc3i+lkkpZy6RdfypLNY5BoN8TQwZKJQ2tb0pa1iv5Q5l/htnOrZMRJr1z204GxpttdXxIDGZjRxljW2630XwGmHRks7rdYkls6CyK0hJSanKz3OeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eKRVtrHR; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eKRVtrHR"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb3a8494c5so453792085a.2
        for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 14:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771885110; x=1772489910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oPmSnk8zjBxqZQmaokMv5bObs6EJjURDlenAKCTaM0=;
        b=eKRVtrHRjO8Cy0QfMykAVZt5GthG2xCpK8O/4QNz5LgVFiq6VkBjF+xwqanMmngsEi
         wbTp00kEbIt5b3GumbHYb2K0cHaHllFpYGdbQFr449XPk4SkS3Tyn965FBuOvB1r8ifP
         HiGdxedeiF9JrkPFddq8eMWGMjucFBkbEosN5zq9Rum0LW21TbA69EPX6jt1WNgLuaJL
         /kb1g6EAg4xeOIoa/stDBJEYVCbbpP8ot1dvsUczoML/jCUJ3niAMzk4T7sfuGdc7p6D
         GK+ouPc4DqaIYIVfa0tc1xr5T3o/5MuwKtE0/j7KpDdYB887wANPOyCsulaKsPs82ZiC
         aWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885110; x=1772489910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oPmSnk8zjBxqZQmaokMv5bObs6EJjURDlenAKCTaM0=;
        b=BD2G4LbnQdYtqzaGOgixmxEggo493S9O5XENTF8wEgITlRLar2eF/s2VHvXIeRc4AV
         5KLHCHCD8oJkkqaUf5bFtbeLmliZYAAj0veeDjAbp1VxFvsiT0b95NRW7x5WThe7YgB0
         cqZA6t6RvKgEyhSCBLfN9Kvd7KXVTzxGlUbyIEijR/hGO8Ud10Xzc2c+bn1KNKBI26Pc
         nu+kGoH1SSEAJqZK1m9Wd6RAchHvMqOHuO7SdS5vOzNOC/f6cQXbzEgRjsXJuPPT3UsY
         3aBshUHs8Mojzrk/2hgyVY8s/GlCMFsy48ETLUcjKCB+56i3stKBZsgOR5LS9agNZ70g
         yBqw==
X-Gm-Message-State: AOJu0YyG4zYrm2fBztK12GvdEDFQoa2riwZ2G2GEww8Pw8f7FRk/8bHC
	Hes9PMpE1AXrATsCFgF2lk/rJ+GQL09X4Ppo1yGOZJKz/V7b3+PytXviHAvdtrVTsu0=
X-Gm-Gg: AZuq6aIAqDoGGBkNHDitaWdiIPmOp74/1fdjlJAtQb5TfDYhYArySu6wlA91Lo47KAX
	nAXB++V9BX+D4G2LwugF6wb5M2W8K5MelrUj+2mzOuHUfZwo7Q6K/gSMzomFYLisWO8GWcGvilb
	lY///+ZIrDRsvRw+wdmN+W3AT7qo4ujYbn9yE0TCB4Ieh+0WcCtfk1p13ghGETmWF/2K4zr1KaG
	MooDAHKFTmuINEkm4zbSsLWeRlM1I5Y44MhziZJmjkOK9jahhxl2Ek09RgyELxwytEb0UirYMuL
	XleonKJ8VWV6UXoPTBNjlTrexroW7zSZ7IMrwVDyayqfUppdsdlSPVCEfF4YsKzKoKIWlut67ZK
	hnGLOhJkSA617tPyFPS+K9p7Ko1VjDsmM5N8+hjdo4NkOl0qJn02yXytSTQ8k0ORST+s/7y2jdc
	EuUAQHJci61oq7qLWL5k3dDrOo4hxTaZUIbpIfEZ+Q4TE4a070f2lW9UrNZVvLLXI0rRMsT7gLH
	CNtKW9cXA==
X-Received: by 2002:a05:620a:1aa9:b0:8c7:14d8:36f5 with SMTP id af79cd13be357-8cb8c9e653fmr1172358385a.15.1771885110096;
        Mon, 23 Feb 2026 14:18:30 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0461a5sm847491685a.1.2026.02.23.14.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:18:29 -0800 (PST)
Date: Mon, 23 Feb 2026 17:18:27 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v3 2/2] cxl: Fix race of nvdimm_bus object when creating
 nvdimm objects
Message-ID: <aZzSMwc2evqS8uBc@gourry-fedora-PF4VCD3F>
References: <20260213224038.549798-1-dave.jiang@intel.com>
 <20260213224038.549798-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213224038.549798-3-dave.jiang@intel.com>

On Fri, Feb 13, 2026 at 03:40:38PM -0700, Dave Jiang wrote:
> @@ -248,6 +262,19 @@ int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
>  	if (!cxl_nvb)
>  		return -ENODEV;
>  
> +	/*
> +	 * Take the uport_dev lock to guard against race of nvdimm_bus object.
> +	 * cxl_acpi_probe() registers the nvdimm_bus and is done under the
> +	 * root port uport_dev lock.
> +	 *
> +	 * Take the cxl_nvb device lock to ensure that cxl_nvb driver is in a
> +	 * consistent state. And the driver registers nvdimm_bus.
> +	 */
> +	guard(device)(cxl_nvb->port->uport_dev);
> +	guard(device)(&cxl_nvb->dev);
> +	if (!cxl_nvb->nvdimm_bus)
> +		return -ENODEV;
> +

I think this leaks the reference on cxl_nvb taken by 

	devm_cxl_add_nvdimm()
		device_find_child()

Maybe:
     if (!cxl_nvb->nvdimm_bus) {
             rc = -ENODEV;
             goto err_alloc;
     }


Reported-by: kreview-0811365

~Gregory

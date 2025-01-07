Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F81F4720
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736277261; cv=none; b=LpUR/ES2L603z/lXrLvazibfpyBQPQN8IfhN19ERioKMOm7DiRoMdu8Dk1inag43WZdczzwkyQTzCgS3qCuOpQmev2762aIzu9oOXFNToHsVmc8chgoxwIsZZmgEvLHwtsM12HgJ6mAaRQldouUF8Y9NUGJodT1D+EIJ22UfoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736277261; c=relaxed/simple;
	bh=JWWSlr546QF/Ojod4A+nTboyQKMLYGiAA95RDQAX/To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnaN4MrRGC45taVXd5tPEEWv1Al6IYkwQWnQMN4XAzCQj0BVoL5cgs+OmVJxs/ZdLa60Lsmdu2awTDyBIGmRn6xO6y8jYiN9nGlsT2VEPjtAWXPYpKM+4A2RNlRQy32b1dUBWMUaI+Oc7xC4m8ID2a3J2N7VDRWmbndM1OWeDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NTHxSahl; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NTHxSahl"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d91653e9d7so139230466d6.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 11:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736277257; x=1736882057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEN5Mj96bM8YcY4Gv0++Fg9PbmwUSh4czT7h1uET0WU=;
        b=NTHxSahlhCRGLJN5O9pfWL24JdDa8/wvjAabMi1aPb74A56vneX6u7dGqp239xbJCZ
         i6GM7+NTJO69kW233jD9vM3I9RBQbITD7E/omrFXrjlte0BV2s6TIm1GvCQMBgmEfnZf
         CBNkDMgwSdDrgqFslu45+TxlYUZi2vVNYmw9g7H2RPF9Bq+A7A/JiAnv2UZNDQ9gJ5MX
         9kCPBst8MCywOK+817W8X3OxBflMLnUwsUjoz8zlrmN0zfJ8a43Rz54iUB0vA3wwfBDo
         MBarSv+yY6Pz1ruCzITVuPKJCaRAsuqWtc+/C09n33UmVKj3S4UX8bV4MqPlAT6D+EHT
         bOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736277257; x=1736882057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEN5Mj96bM8YcY4Gv0++Fg9PbmwUSh4czT7h1uET0WU=;
        b=TpVjWF2ZmBH9lfKLSOurh5rmHC8FVDSkzBe0+kEjEhJkWCp0PMNyJmm7FAKzZt8/hg
         IqwDfLY0zoQgPEg5h6pcAr8N6mfM3KcGEipryPh9S50rkRTuuyIcHFbJfxDyQtl97dzJ
         LiGtHcICpHPb0+/psCu6HikbC9vN83hbEAL1KzywoR1kgoO310pwwgyPPvcCLSSdFcn0
         u+J1qUxIRV26J+FgirANqv5kEUOcyXGxb1Zf3DX4SEsdavbiEVyFnTxNVHk2x/AOL7z6
         MlSHrnSPCZSnxlBtpKIHdx1trR03YTrklsuQHylvdk0t8M0nFwv2ACYdPZ9WvJJWe/QO
         csUg==
X-Forwarded-Encrypted: i=1; AJvYcCUaEQdXXeQ0d4VeXwpUUMa8DBlCp+zDYIG5fcLno0TV6AOt4snvInKYX5lKBnc9oH2DYREW6J45uWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylPpTjCmBa9ZrssFiV+9PsQRVVeITzgZBXw+sE5GP6wL/uvfEk
	3G3OvUpjY6xDQVJqT3uy0UHZs2kY0VrFcw+YDNhlvwa29+4+of00TiUDC7Ensi8=
X-Gm-Gg: ASbGnct/br7RNFNwiBjh8Yg2cF3cl8MT5Tkv8OxYAkD/zKWG465Za8u/pIC6LN1TOg1
	rGjopMSPPAQpFys37bXt2b8MIXtKf4sx6u0z5mmxPIjfa2eVyy8HRj8JyUJG7pLK9ilGravSmfU
	CyAEvWkl/H57TdCJOE/MH8j4MapbeV2DjUt7BvSinb+3nElqLzbaxQCPrsUvN81ukGomvPoGvNx
	AuiUtVw3BmZX3JiK5VaJv7FEch4ub+RYHn5SqJH7GB33vRP8kEErbB+W/gNjiG5f4CUtjzRsoOZ
	0G6Km42mgmlT9WswWGCVqkhAbiBWGqbWuHNzhvE=
X-Google-Smtp-Source: AGHT+IE+UWZ8eXb4MJFaAPhyQHqwNX/ssf57HkKvpRv61oVHdww4YvDlPRDvhWCtSKcT+itrEjTygw==
X-Received: by 2002:a05:6214:1316:b0:6d8:e634:204d with SMTP id 6a1803df08f44-6df9b2b29d3mr2968686d6.38.1736277256823;
        Tue, 07 Jan 2025 11:14:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181372easm184473886d6.63.2025.01.07.11.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 11:14:16 -0800 (PST)
Date: Tue, 7 Jan 2025 14:14:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 15/29] cxl/region: Use an endpoint's SPA range to find
 a region
Message-ID: <Z319Bj1Nk5LAZoL0@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-16-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-16-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:01PM +0100, Robert Richter wrote:
> To find the correct region and root port of an endpoint of a system
> needing address translation, the endpoint's HPA range must be
> translated to each of the parent port address ranges up to the root
> decoder.
> 
> Calculate the SPA range using the newly introduced callback function
> port->to_hpa() that translates the decoder's HPA range to its parent
> port's HPA range of the next outer memory domain. Introduce the helper
> function cxl_port_calc_hpa() for this to calculate address ranges
> using the low-level port->to_hpa() callbacks. Determine the root port
> SPA range by iterating all the ports up to the root. Store the
> endpoint's SPA range and use it to find the endpoint's region.
>

Some comments/questions inline.

> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 85 ++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxl.h         |  1 +
>  2 files changed, 71 insertions(+), 15 deletions(-)
... snip ...
> +	while (1) {
> +		parent = parent_port_of(iter);
> +

I'm always suspicious of unbounded while loops.  Should this simply be

	while(iter) {
		...
	}

Instead?  Given the rest of the function, I don't think this matters,
but it's at least a bit clearer.

> +		if (is_cxl_endpoint(iter))
> +			cxld = &cxled->cxld;
> +		else if (!parent || parent->to_hpa)
> +			cxld = cxl_port_find_switch_decoder(iter, &hpa);
> +
> +		if (!cxld) {
> +			dev_err(cxlmd->dev.parent,
> +				"%s:%s no CXL window for range %#llx:%#llx\n",
> +				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +				hpa.start, hpa.end);
> +			return -ENXIO;
> +		}

I also think we should be able to move this check out of the loop on
various break conditions (iter==NULL, cxld not found, etc).

> +
> +		/* No parent means the root port was found. */
> +		if (!parent)
> +			break;
> +
> +		/* Translate HPA to the next upper memory domain. */
> +		if (cxl_port_calc_hpa(parent, cxld, &hpa))
> +			return -ENXIO;
> +
> +		iter = parent;
>  	}
>
> +	dev_dbg(cxld->dev.parent,
> +		"%s:%s: range:%#llx-%#llx\n",
> +		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
> +		hpa.start, hpa.end);
> +
>  	cxled->cxlrd = to_cxl_root_decoder(&cxld->dev);
> +	cxled->spa_range = hpa;
>  
>  	return 0;
>  }

Overall good, just think we might be able to improve the readability /
safety of this loop a bit.

Stupid question: I presume a look in this iteration is not (generally?)
possible, but if it were to happen this while loop as-is would go infinite.
Is that something we should worry about it?

~Gregory

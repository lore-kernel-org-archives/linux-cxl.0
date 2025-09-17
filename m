Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEF2C11D1
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139746; cv=none; b=KXMDL+t5quWABD5t8alNrm42UaTvv8VTESbIvxYxspliBK6ITgRqUtxFls5XGOdVoXuJhBT2l/6pQSSAUmVnKUE+Lptxg/WvAN/ONbw0qi0O+WAruw32t+v3yTkwU7ioQP8q9eixjRb/FDSvDvi9Lbln1dThEQfyVh0gsfIR7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139746; c=relaxed/simple;
	bh=QegIn/xIpMqvZ7j5QOaGIvD2uUiHbfcl1Y7O1OQ6RY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxc5SXnahOtrw+zCPgklMR+4rKa3gu3Y8zRmZbRnsEdNXtyXd+5Nzrnx8INQLDwj5hSpdCamxImM/BEalbk6ISxwztFPpb8wY2CrKAAvIa81joSlMIAGmNOgGIaLAjkmoidHUm9HIuK2AjMU18rBuVML/aiCFEjHv3D4VsVAh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rx1zIIDP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rx1zIIDP"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-81076e81aabso22189285a.3
        for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 13:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758139743; x=1758744543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VprrwUyM52fjIWKNQUnRndbubnPQYNADGPvk3/EtEEE=;
        b=rx1zIIDPxYg7g1OXRSY3cuY9Ll1Jf/YnmMU5pXw17s2jrh1GfGd4GUFC6P2T7UEIlZ
         2u29l6ftIU5vWth+0o6bpzq7LsVNtJXDU911KMbZRN1bDbEy8twih7SnW9qbgUCEKHbZ
         1y9rtZ9uqsTbwWUt5ECtoIjrlZ13937frLa2Ne/DcpKzMVwfa8pmPCoAGkNwKhM8BXRj
         XZTjqU3yv1p/Xg18cnfJTD49p0HFplRyG/CSUwHNqVQR5+cc1doQFLXjzp5mmtpxmmd8
         B6vMKuefr4XDQz3UYaPBnhQ9ZtFo9wqUyrVcrZ7HguWFtI0rFU1QeEiHXvjwBrd/BEwy
         firQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139743; x=1758744543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VprrwUyM52fjIWKNQUnRndbubnPQYNADGPvk3/EtEEE=;
        b=G3gQvMijV6oAJdxCZytP0FC2REyyJ02DTGqjqGS5dewHohGngXJDAzccSncIi6EsqL
         c32eEwQmY6u3xUuhyP0a2tcFCwjTW7jLbKjSs3Umd3cgKdfQLHTM1uavXULTdZNqF2Iq
         /3A4UVcgHdMM3wBGUhqYJO/qiGR9Y+kRPA+448osCt6aAYgqfjmStfmwvZ1KClWOtI0D
         UhCjsyb1V8+EsgMv9T81lO6YcaNSVDpLgViuzAU8Sl1xwSNZfRAhSmc2YjoqkkYMszFw
         3KcXvhAmw57avrDuKHjK5fGfY4IJwCuZSASATS/wRvpoTktDdLILmQbMcYbbqN0lfmA4
         nT6A==
X-Forwarded-Encrypted: i=1; AJvYcCUHkxSjgFQNfcFVV0S/StNVsh7X52sSR0buTQNf37SQe4RhWf3EL2qu5PSSLGpjpcp5wDkzlwjLeI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweFB+u2lVAwHgLaFc1qvtoeckiO8vWV/A8UZtU3l2ybCAkHdsQ
	XmBm19ueikZixQ8QzYuNsgl3GIk++R4CMdDesuUOF0M0KrpH1T3DicpiaS/UO6CywyI=
X-Gm-Gg: ASbGncujCWuX82H3GMrqMek07Cowa2je2WRIYxyMCPcK/3a7tvPnMX4A21BeSmsJVO7
	ZtLkvdf2AQiDbUKIGa0v29ui+KlXx+N7F3t/AQCEYZxzkGRvX0CG0e+ITG5pIqD/6bFhSQw9GFv
	LBzmIu/gnOFsS2WvakpMNqqB2RBf1DnGJU/Nb6oCzExPxUFS7MbwD1Kvz3Aj1V7ZCcIRx7VeAc8
	MKnsPpnDQ5WkV9up9HseXk5AzMEOTzVGTAVedZWTS1TtTvIWZ4vlZzz+wD+EJqJxEfzzlNjQHkE
	cp6iNjNqVUQb0ANsZy2yLXv30BlXXSo6rK/XE0LEuuvEqnLRKnjMvMzV0qfzSql/cBV4Bg+7Cq3
	Y/ogG/3GtWNjZ+FeLSzR5AHWyyCJHf+e6M8+q2c60R1o/YtN7XEPwgphKNaynCnO3tQ+9a9LIDt
	IEifQ=
X-Google-Smtp-Source: AGHT+IGUMr1Nkfy8mnqMrHeB30gSgrKq7LYSjOJLs2P4VZWfTc9K5c9FC/qhH4RsE7Urb/tyHmNviA==
X-Received: by 2002:a05:620a:46a3:b0:7e9:f120:de9e with SMTP id af79cd13be357-8310c4f09aamr351094785a.26.1758139743299;
        Wed, 17 Sep 2025 13:09:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83634a4f3e0sm35600785a.70.2025.09.17.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:09:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:09:01 -0400
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
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 05/11] cxl/region: Add @range argument to function
 cxl_calc_interleave_pos()
Message-ID: <aMsVXS5z89HCFpb-@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-6-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-6-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:07PM +0200, Robert Richter wrote:
> cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
> determine its interleaving position. This requires the endpoint
> decoders to be an SPA, which is not the case for systems that need
> address translation.
> 
> Add a separate @range argument to function cxl_calc_interleave_pos()
> to specify the address range. Now it is possible to pass the SPA
> translated address range of an endpoint decoder to function
> cxl_calc_interleave_pos().
> 
> Patch is a prerequisite to implement address translation.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

As with patch 4, maybe worth noting that this is simply a refactor, but
otherwise

Reviewed-by: Gregory Price <gourry@gourry.net>

Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47769378823
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882069; cv=none; b=FKjYxpUYHYy0O8Y4up+ZCWdcZ/G1izN2QhdFZ7Icyj8kI3qQ4tOdsPMQbWYOkoisI4hf5tPDP/kt1pUOlgBjluCfMScBgbkFyVyUntD9AvxHD2O5+ys4hQHBmM7biz5BipQKDexF8iBiN9Vja9wY9LGU75/6I3dh2vSLdTJpQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882069; c=relaxed/simple;
	bh=b7rZ2k5ruNRowVsEoYb7YMGeUPStO/wIvKYuR1pTBdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmTCESYoIX9y7fS+u+csfOJTgmQ8AUEKF/mhqid0Dskr9Guqz7pscZCldzwImBEOlieSaUP2I/TXWDHZEPVyRPk6KTmTTpJntrjIKnWFbJ7yq2aRjeGyFX5CjPURTwATRuWh0p21UafEXEKHj3tT5icHtZhWQjUcH434GglBii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GZR5I1zS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GZR5I1zS"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c9f6b78ca4so596449485a.0
        for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 13:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771882067; x=1772486867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpJAnvM0piRUL15vMGoZ0LhD4PtuYLEHcEXlgFSKHAU=;
        b=GZR5I1zSxKPlv6GRvwlSdP8XczLM3Po3X1VQrB1FHwTTPaciA1ZJ29E/pRbLQXEdyF
         TW2JeaZMAoFtDwDiwVMJDCbn+Db2rCmpG67oYrUb+jNDKONtXltPTwU0QLe4nI3qNRWg
         WwsUmIRl4xCldM268AaxFVaBzPla3T4+C5dza4W97Zh1iTwtHjXFdGds2hZ/nrOtlw83
         MN3MJdMXXwjRy8cP4SoV77DAPb39JzKBnYYOb5RIBDdiqtfjzlJV83QuDreRdPNqllZc
         EMliL8Nf4V1Yy6cce1hu/vxiUUXvEGzHI37tZvb6edM1fSDFs6NB/3/6MG4e59vB8nbL
         L8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771882067; x=1772486867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpJAnvM0piRUL15vMGoZ0LhD4PtuYLEHcEXlgFSKHAU=;
        b=AQ3dIbaKwm+WoGfakgXVS626liOWn6+CItn87idE14YhkOKY/GfJ69Y1PfyohnJooK
         gaCNntx077aghvugIR7ImsAsrqoOMYWCMNz53W9VjyZM9SEXkf9hhqV9D69f2B7ZKbd1
         EYVjGuox3fsbEb1WRn2dFfSRoW3D5dRp4MMzpdYjUBxuQ00/2rsw5ppE7EGvfljHGd2V
         +55JBSInNqYvFz10gINSI7eL21+znEGidDcGwYZkk+JoWLukPIAKRmrXU3e1odOgadFD
         g31rQg9fa0SioMOHITPrqW0dZ7UhDnUflY/NB5vU7vuTCQ3FCSNj7NDpzfM7frwZ6D69
         scpw==
X-Forwarded-Encrypted: i=1; AJvYcCXYrzZPV/dKiNdobtKt3HqeaGcw9OvmdIYiqxwg6LL7HdxJN9wrVv419fpt+fO1tHfjW5Y0Pmj2+/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjEXZeuIVhm9aMkmM8J8kDhTiofO4g5jo5Jjd5lOHrwgaDXUt
	w8LEpn+AxMAb/H6M3vEyPO3+hMEw8QseEX2ZLuxyBGS2I8Sj8W7nXjR8WT5HAtH4cU0=
X-Gm-Gg: AZuq6aL2hvHIMy74plnYrp2sM5CjZ+sROu4+94fkBy6EqiaQnHPMpYS0VxVSCXXgJu8
	f650n1uMChyzAcusUwUStYJtZPD9NDTVCXOso0fQ2VInFnnQUt2Igv9lNNaoUGYlYEy2a2CpOzu
	+PIyEMLupjLl+palSbRGtGXrXJG+pbRYnPVfczmrWObJvJZvaBdqfGlyW2lszg4ixDSrheiWh2Y
	AvxWob98oSvWksI7gvT/+r4SLWgCotXu5ktJFgD4r80iVBXmvBxhvRoVmbcRBo3N+SYhT4eTIcm
	hURLoPFoCXqxU0cVmj/ApmLHgoO2rj+rimjoM2mUUg2sAQRaNs/zC/UrAWB5RRHZPrzy7rfpGYB
	Ze1PJViLtQup2MYq6Z5VkR9lAVMC/XF8jGk+0mlMpOYL0AIPcvYzriei8P8VrUA0Oto0wSDrLMd
	ZTWxla9CbfORCK4f34obw8pCQQRThvb6FeCBSJeUDi4iGAP3toMC/NEqDc6wi99SP0bpfrW0jw8
	Y3nXHxQXQ==
X-Received: by 2002:a05:620a:1a23:b0:8c9:fb69:e708 with SMTP id af79cd13be357-8cb8ca09ff1mr1268843985a.25.1771882067220;
        Mon, 23 Feb 2026 13:27:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0461a5sm836357085a.1.2026.02.23.13.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:27:46 -0800 (PST)
Date: Mon, 23 Feb 2026 16:27:45 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxl/region: Test
 CXL_DECODER_F_NORMALIZED_ADDRESSING as a bitmask
Message-ID: <aZzGURaa8aHKqreA@gourry-fedora-PF4VCD3F>
References: <98851c4770e4631753cf9f75b58a3a6daeca2ea2.1771873256.git.alison.schofield@intel.com>
 <63fe4a6203e40e404347f1cdc7a1c55cb4959b86.1771873256.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fe4a6203e40e404347f1cdc7a1c55cb4959b86.1771873256.git.alison.schofield@intel.com>

On Mon, Feb 23, 2026 at 11:13:40AM -0800, Alison Schofield wrote:
> The CXL decoder flags are defined as bitmasks, not bit indices.
> Using test_bit() to check them interprets the mask value as a bit
> index, which is the wrong test.
> 
> For CXL_DECODER_F_NORMALIZED_ADDRESSING the test reads beyond the
> flags word, making the flag sometimes appear set and blocking creation
> of CXL region debugfs attributes that support poison operations.
> 
> Replace test_bit() with a bitmask check.
> 
> Found with cxl-test.
> 
> Fixes: 208f432406b7 ("cxl: Disable HPA/SPA translation handlers for Normalized Addressing")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>


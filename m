Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1002F8EAF
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378525; cv=none; b=kB8bSqzL7E+ynWx5xt++vLoFIAxGXWMaC1h4vmhjGmj8QMN8HVYqA2ZVf4ax0FOgTvan1SravwibPSqi+j0okE5uWrSKldK42DtUrgC6ra8JjuyQ5o16quOouAVdujKvj9MQOC4KaTEKwRRtGohxmBWJkKWwE3+jxSELzs5aMOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378525; c=relaxed/simple;
	bh=YGWfzGQORLJkRM4iXt4veDpJWzcxQCLpMbCh3q7RdrA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrUXrTfSo4LEnTOz94K9H/2BOWnTBJx8JiEiEpanXVJjwylxYYe+fcZ+UjJNkiqoGadkgZ4SULT73jPqgOmCqak/RlghL6RIIE8k+wR8b3k5gf9Ah60QQUIDCJCWHueDBI5DYMUZr8cmBo7XJ2dgUBZnVHJlAuQf9h0bWfu3vTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaeCSMQt; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaeCSMQt"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30c591fb1cbso2967140eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 02:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378523; x=1782983323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh+XojUQaqMIviFBsHEt7W4dW/CY/ggastnUo3Mk/nU=;
        b=JaeCSMQtqtW5O2qbDMMb2iTtC3Ui7XC2CE/lJdiUJG4a2FNOjXP37uDMnNGJiA4oxx
         iCDBHC1l43lXJd2IdV13FIddl+DKLwEMFJk/nEG1MWTEddhzufVSLbA7JrHkfKF2Eefn
         5YE5ClvVf4grXVi4yEbDMV71JFYhEKqeSrmFnIQ9IJLv2KqCXyrxVsTLeDJjCi0IJ4IN
         gEWfbdn7hXEkj54OBFG1CTofZ4yFj5XnVeHfFditaWA5ZKo9CsJq6MXX6Qtku2Jglawo
         8Bi5gzLxJBpsbZdq6bN5jDpm+dlVBlDskEWWgzhhzks8Th+JCP7dMAjwT/ikPqnH6N88
         fuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378523; x=1782983323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh+XojUQaqMIviFBsHEt7W4dW/CY/ggastnUo3Mk/nU=;
        b=rjiAAzZMpBM4pDxmtcfp1PjLUoCYXY+bGM1VsWLAahZVi2Gb+6AipP5U/ZM8aH5V19
         zNKtRre6s18hxIz2zCLNGaeLSCTOLUIPypeznW7LRglrV8s6pwrrbgShV2QAqC4BX/vr
         csZ+1pdr0QGqDjOq8SlUeRezDwL95AdLPzPnA5Wr3lBGJIQKofczPDDvpuHJouN94Kbs
         6whyy36EulaOvdKHkDUzJHuOb9SM3PZUkLfxiOz10iHIGFWcr/tqPbT/3HuvwCnotg50
         xqreEAUdsPgpT3fsJQLdcTaGN+WaL6WRPf8iZy0oCA+IOEh4peqsmPO6PrbcM6EddeQT
         +uIA==
X-Forwarded-Encrypted: i=1; AHgh+RqjtO9Z34LNWevSWHIJ4NCfRy1zKyU2G8/0DnUei4AbT24MVrmKZ6fw4xBzfx+8TEIXZZkJ2DI9hc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRUG7tOz/sWsX7G/gRD2oLqVq9s34BUIMY8HxBz7dtHcA0Muo
	L2RRYjhYCLKPPDgRATQvEVTo+RivcQ8mhS+/0+d/O0oHV6F9RUqkypbN
X-Gm-Gg: AfdE7cnlUQGXBw5wpQihrxtBnbhCUvCTvE6pjXAxq4aWknMSIvMQMQrfQ0jvUEFOC19
	/B+vQ+ooZ0pNni0vwp4pQRpQ1Seaveg6DK+fqd/6vQ2cPR9KtrjUxVZPKbfx3qUQnQgFrEjnkUc
	Kx6p8YntYR+6uYnaakqlJgGjKqzh44DFUMU2ykuzwwjUuB576iw+gyG+zLvitzpCeBIsDlzoWns
	btiVSJY/HuB+RTrfG8Ol/bfOV7OIgUEXAuOTIdsRtkB6Rm+KnKznZ4qrHdNR2mTV3yAa9HZLFRc
	cuOGOhKXUHQ6NZJmqRtQeY1ronNilVUjSFqv3f5+hcH78rKZEgZ0vSVmxeG/xXw5YvE+jbOS/zA
	yza44zJ/MDHM/JqKA/7LbX0KI/lNu2yyWDjE7Sh+MnIqP3SxkQeeyZmracs5TP2nK012ZtQod/s
	KPWEUj7j3+Z20n1PviebCF0DMY/2rNEcsvC714+0f6U99c6ve0eMzuPhzAFd2H6k3G+p7X
X-Received: by 2002:a05:7300:e8a4:b0:2ed:935:aa33 with SMTP id 5a478bee46e88-30c84b1e852mr1902737eec.5.1782378523429;
        Thu, 25 Jun 2026 02:08:43 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8afca8sm6375872eec.17.2026.06.25.02.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:08:43 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 25 Jun 2026 02:08:42 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Richard Cheng <icheng@nvidia.com>, Anisa Su <anisa.su887@gmail.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v6 2/7] libcxl: Add Dynamic RAM A partition mode support
Message-ID: <ajzwGj0wjaqMTLPE@AnisaLaptop.localdomain>
References: <20260523095043.471098-1-anisa.su@samsung.com>
 <20260523095043.471098-3-anisa.su@samsung.com>
 <06747633-ed22-48a2-b8d0-c9b544a682f8@intel.com>
 <aijefVjI2x6hgxH8@MWDK4CY14F>
 <8656e29c-79ff-4b96-87ba-7919ad32a6a2@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8656e29c-79ff-4b96-87ba-7919ad32a6a2@intel.com>

On Wed, Jun 10, 2026 at 09:55:49AM -0700, Dave Jiang wrote:
> 
> 
> On 6/9/26 8:51 PM, Richard Cheng wrote:
> > On Mon, Jun 08, 2026 at 04:19:47PM +0800, Dave Jiang wrote:
> >>
> >>
> >> On 5/23/26 2:50 AM, Anisa Su wrote:
> >>> From: Ira Weiny <ira.weiny@intel.com>
> 
> <-- snip -->
> 
> >>> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> >>> index ed4429f..258bdd3 100644
> >>> --- a/cxl/lib/libcxl.sym
> >>> +++ b/cxl/lib/libcxl.sym
> >>> @@ -294,6 +294,10 @@ global:
> >>>  	cxl_memdev_get_fwctl;
> >>>  	cxl_fwctl_get_major;
> >>>  	cxl_fwctl_get_minor;
> >>> +	cxl_memdev_get_dynamic_ram_a_size;
> >>> +	cxl_memdev_get_dynamic_ram_a_qos_class;
> >>> +	cxl_decoder_is_dynamic_ram_a_capable;
> >>> +	cxl_decoder_create_dynamic_ram_a_region;
> >>>  } LIBECXL_8;
> >>>  
> >>>  LIBCXL_10 {
> > 
> > Shouldn't new exported symbols go in a fresh top-level node ?
> > Something like LIBCXL_12 ? please note that Patch 4 has the same
> > issue.
> > 
> > Please let me know if I'm wrong or misunderstand anything.
> You are correct. These need to be moved to a new block for a new release. 

Thank you for finding this! It's gone into LIBCXL_13 after rebasing on
the latest pending branch.

Thanks,
Anisa

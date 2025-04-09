Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925725F972
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207312; cv=none; b=fgUo+G2ESucgdTTN+bOdYQ2fUlk72UKfTpdmXRbkldZTHRJDz26fwImLcDbtvWzD2+cHDHnML8FqHElj0r+ZcRv+rW3MVUf88rrUQbJfCSlCXOgg0oDkWRufJUY8g5m6F+uVlMWY0pPy2Kg7BGDoYzRH8fJvDzeTrhAje/4ESDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207312; c=relaxed/simple;
	bh=MaeGFp7H9tj5T2RhN3Q273B63saJKdfiYy4ifuiHBHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRSD89MR8K4apQI6Asj0FvWoNVHRQW6RcoCNKkizLFiBFuWy7cQXmIjlfV+Oecv2kvqlYzzAlQ47ZOB92zJUqqe8aNBcPCRMoYIG0Jtf8MO5rOKh04DfMW47XoJGuuMIZJLwdjEFl67Y+7mpsDY0sA3vwTRecCiUlOpof1Dy7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hm1ez5Bs; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hm1ez5Bs"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476ac73c76fso67293481cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 09 Apr 2025 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744207309; x=1744812109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJDUmNjWpshUz30BgfOpBzQfxZmZX858AGbk0Bs67XA=;
        b=hm1ez5BsDZ+V9rHTRsbAMk0z4HtH/gUaZfFfYqANa0XC7YZXv0GqcSMlYkA7kDUA2T
         Yft/W3abxe1LF2C/PwjZw2/VD+bu7/nR1dG6K+A4ZlsX8Qyo3vuKp7+bPyMJsyD+mc+g
         bz40YipsgTIwyaZEov4uPLfG1MG6ph9MSlE8SC9RdEzFSXxSsV23pqfQANOWYnBP5LUp
         U5XfpmS4oEm2YzR4PW/93CZbZoXeDDd7k3uLZ0/d7aV9DH5l1lZmOeWnfvOyCxrkHemA
         DffTWtyAcbjhptKDmrxGbZTu4vciRO1iSQUwSF49c8Oxq7gxtjxxGaCHnZ/SmBTgdjzG
         vFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207309; x=1744812109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJDUmNjWpshUz30BgfOpBzQfxZmZX858AGbk0Bs67XA=;
        b=A+37R1fiTH2zTVfd3HVQs6w54cEUhL3nJE5C3Cs5U3044+9zcho9qZqCFGIfG2JH6p
         PsUe5jNHSa+IfYBEu7W9jMYsj2kRKC1//mLwS8i7uuV54PuH20S29foD7XdpAh3TVpfo
         53WmX8ZntW551DzJI/T2fuJL37JNhZul+H9UksXoPCyFQgVceCZDtUuA5a10+/s6CusD
         YncWAU3MmWR2kh9ZSRPjFyqfHrWgVkNh9GGtKr6AI5BvWtXRoSBGjuOUL4TwncCfUnAM
         et8yIMHd4MoMI2SSictouArOOe6IxvmsA646axFK+n/4Gcr4P8TWjCmUfaBjtHH9Ia/z
         KjXg==
X-Forwarded-Encrypted: i=1; AJvYcCUUxhqNkgBuj4J5YRWFoqWs2giHADan6KPvTln+D+Mj8ahpTkGQ4/7l7uZSe+FMhcOX1247H6h6v00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJVQyDD39hheVXKKvgw6ryhPuAxVZZq6+N5IgNMN2bA9bSY57
	9dcyZLggLLJdvK72/tDqmm0uCfZ7qgFC710Gj50Casjd4lF7cSG4DJ5mBHE0Bmg=
X-Gm-Gg: ASbGncuRF4r0WjJzDU4l9c9KdqYoez5MOv4iX/4raLyGyof3hXl8pez51s94pTNPLUQ
	UiJCfhE0ic8iPuIXbtSRpN9RHy/H/uK4NDAEUkUruACIbct9g0epZNos2Kao5uqqi7ErjYMeiPC
	JMkVLytWBrI6+5YvxMYkchxri4yy37tZweWABpKc+/VqhGg5iSeDlhxwoYGOuWcc8jcic+yIhVY
	mO8ZNn3TKXRUuJ9CNAF8xosX+uBuRInrnXf1s4oyWOQ7+Bo8ebZo4IU5yOZ2zwa6YWQSXD2cn/J
	a1JNja3kkUoF2GJURn+cJbbldKw2gaWVwKurbQ==
X-Google-Smtp-Source: AGHT+IEZxUidqMUFZz2Y0Xa8WQayz98qmQnLCKs0R6C3yLugqEVh1PlESfx6aP2uM7ORMKJ5Ot7meg==
X-Received: by 2002:a05:622a:28f:b0:476:add4:d2c9 with SMTP id d75a77b69052e-4795f2a9aafmr42115661cf.8.1744207307751;
        Wed, 09 Apr 2025 07:01:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::4:3298])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964efbf30sm7353521cf.79.2025.04.09.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:01:47 -0700 (PDT)
Date: Wed, 9 Apr 2025 09:01:45 -0500
From: Gregory Price <gourry@gourry.net>
To: "Ye, Huaisheng" <huaisheng.ye@intel.com>
Cc: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Jia, Pei P" <pei.p.jia@intel.com>, "Du, Fan" <fan.du@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Message-ID: <Z_Z9yU_kWkWRp8YJ@gourry-fedora-PF4VCD3F>
References: <20250406112752.1261855-1-huaisheng.ye@intel.com>
 <Z_SWjQA4qb3OE6Dk@gourry-fedora-PF4VCD3F>
 <DS0PR11MB7458325CE975067CBD63ED3E9FB42@DS0PR11MB7458.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7458325CE975067CBD63ED3E9FB42@DS0PR11MB7458.namprd11.prod.outlook.com>

On Wed, Apr 09, 2025 at 03:48:42AM +0000, Ye, Huaisheng wrote:
> From: Gregory Price <gourry@gourry.net>
> The phenomenon I observed here is that the content of RR is incorrect, as it is not within the hpa_range of the root decoder.
> Here are the debug messages of dmesg from site scene. FYI.
> 
>  [    7.683508] cxl_dvsec_rr_decode: cap = 0x1e
>  [    7.683535] cxl_dvsec_rr_decode: ctrl = 0x6		<-- which means CXL_DVSEC_MEM_ENABLE has been set by firmware (Qemu)
>  [    7.683557] cxl_dvsec_rr_decode: range0 base = 0, size = 2147483648   <- endpoint's dvsec_range
> 
>  [    7.761781] dvsec_range_allowed: cxld->hpa_range.start = 11005853696  <- root decoder
>  [    7.761782] dvsec_range_allowed: cxld->hpa_range.end   = 45365592063

Are you interleaving like 16 2GB devices?  Because the RR here has 2GB
of capacity, while the root describes 32GB of capacity.  Just trying to
make sense of the configuration here.  If you can share your qemu
config, tha would be helpful.

> I agree Qemu should fix this issue, it occurs probabilistically.

Hm, Jonathan is it unreasonable to go off an clear the ctrl bits in
ct3_reset?  I'm not sure what the warm-reset procedure is, but it does
seem like we shouldn't cache decoder / ctrl bit programmings across
reset.  Not sure if just re-calling build_dvsecs is sufficient.

> And I think this patch would help CXL driver to dealing with various firmware situations.

The question is whether this behavior is even feasible on real hardware.
The issue seems to basically be that QEMU doesn't implement the right
reset mechanism, because other

~Gregory

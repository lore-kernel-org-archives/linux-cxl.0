Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926233C1FF2
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503397; cv=none; b=g6aITI5hxCUdHbth0aGZgRpslJEod0AS3Uw0u4U4wG/CDTjjH8c8Su7HDFUjALVxK7OqWdslXAHorFCb7MAEhFHeZDT2bJ+ScjvJRVmBQgWZevTWbkcmE/EbQIMQ59ReUkAdV+xGxXMS/vwq5wUtXQURfkvls64XpZBMS/6Fakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503397; c=relaxed/simple;
	bh=+NPKlxMJIya2krzxpEptQT3uJRO1ho8dMMOvzVkGWMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYpRuR1ZLx7FH3r0DDdfRqvwxhAvITpuBnIUTwWYyfHfvHSSqnbdQyn+COp6ERIY5JS4gH1V2L2jLn0zcNaGBiYmkL0WfK7MKEpbgNjwsvV2woZPsJSysdrJbMdqkJHntUezMr32SGCP/MTxizBFIC3wrpnF1GfgidBa5ErMS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GZNhqcXJ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GZNhqcXJ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c6a5c57e01so30340085a.2
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 10:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768503394; x=1769108194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kafO8fZz22tbfudoIkF3k7wfdMDjRkFUpXNKTf1nNus=;
        b=GZNhqcXJPXWjd53OX7Hi22JH//WqMrfzd5LUzj3Rxfm0aXVQhcF2YO1eAgHVpADpO1
         KWWVdsjst/t6uWolV/I5yDbX2eq81SycA8WyyCeH58m5LYcXxXiAS8qkjoh8BkA37A6M
         UNsnwSGtbyOgCGPJhitpUUGe/sMCBd3Y1OLdofMVH63cGhxGgV9JGsOCEHZ24C25nf17
         NT++sHoWLQzhv07NgwXo1xCjrmJtRIr8auX6ZwwodAet1DScKb6vJE1iLd4RkoTwvAlK
         ngd9Ot9hAiELlGF/XAS/xhz1sGAlsj5vFY3YqdbrZwS+J40mylqUpO4rGmliDQa+MP+6
         DrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503394; x=1769108194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kafO8fZz22tbfudoIkF3k7wfdMDjRkFUpXNKTf1nNus=;
        b=dzZ31K+dJYl28SWCY8ibia3G/2AgSqb9ZjZj9YIeYGXA9So6pJrvOpRUsjy8R/Sczg
         xRfd3QwZMiMU0Yt4Yfp0GFvao6ngcHR81O5a+OWWavhsDoLNp0avQ38KkceranYuYEz/
         SKl2ehPyqvcST6wNR7rfZvUH7ARtXMxR3ven76C4mdN9cB1AUIcqq3kob25Croc2qoeL
         XwM0JzhmWOXrm5wWZrlQBg1YHty6kmyvE1QMvMipnkGq9vU1//mFsy9jiHGvJ/MU0xtb
         naa4mool1zjA7guhrI+lB9el3KBZeBNE3z9kMI5dMqB3SAuV2smTVCcIp+WhBApw+jkx
         kChA==
X-Gm-Message-State: AOJu0YxofT3Y5p+JPHdn4WuO/axS987lbRLLWUeOPrUnnbGewCOG4qzS
	MfhKq0fRBudWE/5FjQjls+7K8BdF3oBdaB2aZNZxzgEt4V+fsHOz2X6iollxHkshsxI=
X-Gm-Gg: AY/fxX6BTrrJ2QkrDty5o2mTh1bZEdHgfmzyCreknZzI2b/tX9Bs6trM43YG5lS73h8
	DCkdwGEq/6FsOgZGpui7FL57kETo4O//4nFYb0sL6ktHOjgjtVLVR49VH2l/CwHkG0yj1rRjhVB
	ISpHMgZUUw8Fys+q7dRTdc7E7fu8VE24WGX7W9iJ/QL8uol/Og1PVLztFEuADpLCCNJt+W+RZqZ
	wzg75kSxTOKb6hxKu03itkvEHVFNwUWiTZ19qbNtW9NRQg2lJzQdUbSHSh9vilsy1uzXiRgfG3t
	j1cvS4foKLohvlg1W8yChBPqZffscIcG1NIV2BR6pdzQGJMHRhEpD5bR0hC6ChSJDCeK8Ii1+fk
	b1PWX+LjQ950lu5Rv1qcjUZC+5E6WMLgjgNmyzp+xfUAeLp5I5Bv7MO+9g5rz1mL1rbMtyrd4Xc
	+AeiYatUGZc98fPfRy/in0SDarzknter+883BPIdP5CVCMITzPqUQx9ut++pjhXvYBbVkVng==
X-Received: by 2002:a05:620a:1a1c:b0:8b2:dbc0:a1e3 with SMTP id af79cd13be357-8c6a66c8505mr70108885a.15.1768503394383;
        Thu, 15 Jan 2026 10:56:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a724eadcsm12628385a.29.2026.01.15.10.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:56:33 -0800 (PST)
Date: Thu, 15 Jan 2026 13:56:01 -0500
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 0/6] CXL: Introduce memory controller abstraction and
 sysram controller
Message-ID: <aWk4QX_zbyA3sDMT@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <edb6cd44-76df-4d68-8df8-2e7f3a7db73b@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb6cd44-76df-4d68-8df8-2e7f3a7db73b@amd.com>

On Thu, Jan 15, 2026 at 06:43:08PM +0000, Alejandro Lucero Palau wrote:
> Hi Gregory,
> 
> 
> I was concerned with how this could affect Type2 but I think there is no
> issue at all, but I prefer to ask specifically about it.
> 
> 
> Type2 can obtain an auto region if BIOS enabled/configured the HDMs, or it
> can create one on purpose if not. Type2 patchset does not allow to create a
> dax region when region probing and it will be the same type2 check
> precluding call to enabling the sysram controller.
> 
> 
> However, I can see the region will have default sysfs files for setting the
> controller. I think even with such a change there is no way for enabling the
> controller from the type2 region probing, so I guess it is safe, but I would
> prefer to not allow a Type2 region setting a controller at all.
> 
> 
> I like the approach for solving the problem pointed out, and I think
> something similar or a controller extension for type2 could be needed in the
> future, but maybe adding more flexibility for theoretical per type2 driver
> memory-handling uniqueness.
> 
> 

(pre-note: we changed the verbiage from controller to driver)

I think Type2 devices (and some special memory devices) are exactly
the use case that drives formalizing region-drivers.

Some Type2 devices might just register a normal memory region.

Some Type2 devices might want a dax device.

Some Type2 devices might want a "private memory" region (private node).

Some Type2 devices might have a completely different usage pattern.

Maybe we might want a control that limits which drivers a given device
can use (limiting switch-ability), and let devices inform the core
region driver of that in some way.

The sysfs toggle is a pressure-valve for devices that might be configurable
in multiple ways.  Maybe it won't actually be needed, but at least for
"Regular Memory" devices i can see us having dax and sysram drivers at a
minimum.

The base sysram driver may even be the basis for a dcd_sysram driver.
After all it's just a sysram driver w/ add/remove extent functions :]

~Gregory

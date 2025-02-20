Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FCF213E72
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081485; cv=none; b=CGaZz8P6sKGNY+LfolG7RFPDzZo6Z1qMLDdwhqPExGFXBUmd5hgx2aOGxpdGM9itAJHYTOY3O6VjDjyduHPtU6U4ez+IsUplMR1sxaYlw9IaLZ15Pg3JWX6qrU69LCG1C1oAZdC1bLbmikt8pFf99SdBiMjVN8SfHFDsQcK7ZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081485; c=relaxed/simple;
	bh=jrlGTmgmhbT1peUN46Fe2MxKkTTrc+D4XgqIColiGGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH3GSqENWHT4iXqRv1sB4shAWvrY0oGh+LlXYEbm1/qgMeB1Cg5BalNzVV7sUhfxKWQYXHW6eqzWqtmjFvIZu9fOrjYpRAqq/yu4SCIUmzc6ysNE18bISZT55Lr6OB6crPcpeqj7DnCyfD34Z7TYVcLJaP9W30Y0EmMVfWGW1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lC2NhlaR; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lC2NhlaR"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e69db792daso11619846d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740081481; x=1740686281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kr1joMIDiETyhMXa3u3wcO1t9R4bjZJsjINmgsHmqAs=;
        b=lC2NhlaRmmo3P6GtYE0Y5L7gyeW00f1JV1B0MsYm9EBhQRGFxVvIaxMUo5yPBZL4vW
         cTHKgRkwlFj8J6eMCCfgC1qUjLMaYT9YryefKL/ezr9wEy+uxVb5gPnvO5X/EgWlmqFB
         XAO7iWDv/ECqx+4hPvvrpqSbHMlrFXncR73jIfYhhWDkbJ0RT/voxgrcAHsut72y82wF
         D5rT0P5MpWywJ8ANXVQK5UcmlIFZ8M68A/pD9a7E3+dUgGPBwyvM1ETFv0eMpN48u5qd
         TotGafwXuEG/UEe5yUjx5dR5IyQyjt+lsGgz+uIHHHoKsg5WdZLQizwEpPaUxXowMmx2
         HLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081481; x=1740686281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr1joMIDiETyhMXa3u3wcO1t9R4bjZJsjINmgsHmqAs=;
        b=FXtgTnwRP3XuyjWne2dfGyzLWHnthrMmE1UWULZEM+u08ZgrcIdOvdi5jWw3pS/w6g
         AFfTPVBk26ndt0p48K1hLNTFryqb8m7Ctb1SICH6Ggc8/WZjpzG9AwNbbjlTrg4eBi2t
         8k4CN9BZDw207+F+ldEPiUxEY3506UwXVqHkPYT9q1RTOQYtzqq1qNf8o2OU9jhivMh4
         NkLXnLRx3HMdWt3my331vV78K98fXKiGnxDEvBLYlx7dMPFRBbRpP6qf6F32VX8fSnVV
         tZXf1KNdbv1YIQiFTK2haW0XRJy0+W5hPuxtqfpAh8Od2gkXCC9xf6Bz8WauIvmWyKHx
         EKzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTG1Qhm9gEUz/gn+H/s/jkj0ybG/YsygnbstaXGrsTLXhhyisE8NsVzUxESLPNzJAoUwEBzX1bnlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxEBY7lHEDzTqgomLjrpusPkJF33n60d0jigM5MBJ1+JAFJu7f
	iFJOEnEpBhYnJJ2uOdPhiInrhJZ8tyMdYm6xtzJaen4ciF6fXQ1SbpEqZIl7zN7Ozx648i/2Bxe
	u
X-Gm-Gg: ASbGnctEpvHTQWnZ+yxOhXDa2Iz3wI2gnC8FmrE30cbWv9ZxW70Emjl94UxrrwDiwFy
	CCrQd+htBnwWrpedSLJFMXU8gDMwZQs6X1Cj4Vfma8mUV6U7hdfuJqkzwJ+gvnesSMolt3s6h7U
	yekZIqzdEKZ0dS1os6pPnmZuwJNg41SwadC8IN2XZ0XvogPF1UI/WH4zJMogPq/FQaT+i8X5PpV
	mSzxNje/bsnA4DkpU7Nh/Sg03p51LyH5vdxGLM4shLBgcEJn7ZALS34ia5J0GeIzZCMS0Te9p5w
	3Dxmev2qYfC0GeC7sZRR0VEfwqWX/5BgLY20HvainV9l5zw5xLVHVoCihufPk8Wem5jj5Zt41Q=
	=
X-Google-Smtp-Source: AGHT+IHZS+OAndXZ63oF13Bq+bLF0/Yd5FRQs22lEGLPEgYn8FK+myJuX9Qfgt1NDL+/ZMzp5hGhxg==
X-Received: by 2002:a05:6214:4109:b0:6e4:2c6e:7cdc with SMTP id 6a1803df08f44-6e6ae84f6dfmr5284346d6.25.1740081481372;
        Thu, 20 Feb 2025 11:58:01 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65daff4fdsm88988706d6.96.2025.02.20.11.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:58:01 -0800 (PST)
Date: Thu, 20 Feb 2025 14:57:59 -0500
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
Subject: Re: [PATCH v2 13/15] cxl/x86: Prepare for architectural platform
 setup
Message-ID: <Z7eJR6U878BIwk1X@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-14-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-14-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:54PM +0100, Robert Richter wrote:
> In preparation of an architectural, vendor and platform specific port
> setup, add a function arch_cxl_port_platform_setup() that can be used
> to handle and implement architecture and platform specific code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


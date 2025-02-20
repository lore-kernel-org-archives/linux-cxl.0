Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301920487F
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069674; cv=none; b=rV32V9sXylBeEoosS6ZmA0mrA+hEvgSh3WTh9UE5ZJbaTTAqI64wjcVhSoZDW77hbdumhK0VTr/sZ+JOGmN/7duSlsNFg9xiZoZ8+mqMZ34yExnBYrSWA9zJkAn4oxOLBf8GHKRGGCIpBNYHSSuD+pGrImHqx4lVlch3VenDc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069674; c=relaxed/simple;
	bh=wtVm1OReLkO+WQiX2RY76tqiMRy5uIw9+ikeo3KDP0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaBppbepg945o5YQ7wdl9J50pupmYBn7gY9DA6u998FvY+GUpEjvJnI0czxluynCDdcasNuKCNdoiAVAsyyN6SJDxxTtlW6Scrrb6D2kYUBzNBAxC3fLQ1Jo8a1gIknPuvti0n2PfCxV+rHX7msCPkvIwHdrNjpuLX5P0kKKKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Y2tqgT8P; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Y2tqgT8P"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0ba89dda9so124075985a.0
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 08:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740069672; x=1740674472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvT9hr4wyRdgqH4GD8vWiYOLKGLcsbZRX76Llb1LL6s=;
        b=Y2tqgT8Pjo3g7ZZPfYB6vqKamFXy9a/mwd/St0nRqbx85XVIRfZYl5bcdr90Fyqo/E
         jtX1mKjR4wsR+ZL0J7yvyvdHGjwAfaTknUc98dedqPDCynkrMMgNjj9M4n4kGbNmoKhw
         yd0h8fHXDV4Hd1NxvXVhsN8fRUroy2ya9Qm5KbMgm1Hyh6mkhBhOMVxtSOOjcyWcucqi
         AH5+o/8Tq4MICedCyzIXoA1JU6XLJTha/cawWTxeCVap4SniIR9rghA8JGy09To/LpQy
         sg9n6E7gtlB1hA7El7K4u3o9ekh2L5YqSJlI49XPQKjdkB3isCMTzGERFyhgsfCSSTup
         lENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069672; x=1740674472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvT9hr4wyRdgqH4GD8vWiYOLKGLcsbZRX76Llb1LL6s=;
        b=V4m/v9qlkLuro1Ebcsj7UbiOAdszbavN5KETksoyisCW5/5nMLHLAPRHh3+foBl0hF
         PAhhM8sfQKgX4GLLeVzTUBV/gUJdGtJBn9e2cxf4RwF4XkrXcn8vayTdndkKpLQuvYhV
         Jg89WGRqBzz4dJBvhy6+h2MKSd/zze7qWhlKtbjJ49WjAN0MEeYR5LZ6EnbcBRe4b2S/
         hiBJfyX2qtWw6s9kPiVuvNYGwyG63WAnunKKYHtdk/eXuPwXCPHQso7KkOlPY9J+D5uh
         67jW+cRAjeqwWMe/qG00DrS6+B3gsikbZNcqsTxkZTM47txdvfdSCsv+SYkKTKovJJpk
         E58Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBPgSSchDwapl2kk7Peq3qaGvPzwFMuIy0gSsRr1VcAOOBxJW44BAynpy2xesiiAHat9RR1Lu7zKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRElEkNBWFyHIqzyz6QYNtee4CR8U+EuYuu2eP623AjJFDeof4
	LieGQv4e/SlBMA3BAUw69xx/vpZ0j9P028FBg/RHkUTWz37P+czylECcXPPa8zo=
X-Gm-Gg: ASbGncuOibS/FNRMYsKUpcYRfSQOCfy/IPWomLaIi+pNPmMFXfoZqg2mXGdKMKh3f3F
	+pkvCTcJ05d7OwRcVtk4A6kLF9HQZ4SmvKDWLwarp21U+JSl2QdqMyPbcbsDP/1RXy3tjyTuDre
	f10hH6PruBtL742yCGMaFMnJcugyYBaPxrs9J9YprxYuXcMb8fTp3w7hScNbHUbEUUbv8Z+cKXk
	APxR2i0ZJ5UEPnY4iHDJrUX5dkWcwvSHvmDQ+aFsP64T5npJj59nZ65ik8eSEal1yMpOgXagIxN
	HajlDUBy0NLz8nQ3Hto/roIRn4SuCuEmE65L8itlqBkDshBN3Kwrv63e5bEwwq3T5YbHpcNsfA=
	=
X-Google-Smtp-Source: AGHT+IGlH80zk+2PBNQ/ZB5qRD43YHH9jlASFS3zwf6R7lUXwObcQaUrgnHIjK3rfriVXd+k7XVBog==
X-Received: by 2002:a05:620a:1927:b0:7c0:9df3:a0d7 with SMTP id af79cd13be357-7c09df3aa60mr2071684885a.41.1740069671990;
        Thu, 20 Feb 2025 08:41:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0c6d41b5asm70688485a.73.2025.02.20.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:41:11 -0800 (PST)
Date: Thu, 20 Feb 2025 11:41:09 -0500
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
Subject: Re: [PATCH v2 03/15] cxl/region: Factor out code for interleaving
 calculations
Message-ID: <Z7dbJfr-qVrXj6ek@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-4-rrichter@amd.com>
 <Z7dYODuRrRv1bXpV@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dYODuRrRv1bXpV@gourry-fedora-PF4VCD3F>

On Thu, Feb 20, 2025 at 11:28:40AM -0500, Gregory Price wrote:
> On Tue, Feb 18, 2025 at 02:23:44PM +0100, Robert Richter wrote:
> I get that this will be used later to pass information back, but this
> patch by itself is a little confusing because ctx seems pointless since
> the function still returns the position and accesses the hpa_range directly
> 
> Looked at in isolation, having the context structure change in this
> patch than just adding the hpa_range as an argument and adding the
> context later when it's actually relevant.
> 
> static int cxl_port_calc_interleave(struct cxl_port *port,
> 				    struct range *hpa_range);
>

Disregard my note here, I missed that pos has to be carried through.

Didn't notice until I looked at patch 3 and 4 together.

> +	ctx->pos = ctx->pos * parent_ways + parent_pos;
> +
> +	return ctx->pos;

This looks fine

Reviewed-by: Gregory Price <gourry@gourry.net>

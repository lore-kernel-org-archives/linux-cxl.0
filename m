Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7F4499AB
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783634286; cv=none; b=DdGEgrx1N4tY81VbpyDOVdLIDkKfkAkQE795stJbF9C8emVzJhZ2H6oGy2obe9Nbbq0Eqveq2vjmAqFwHUsvuhN5hkGcVXRw61ZwWX+DYQjJ5GCB6gjl371r5nGvYM5PVzoX2NUMuKI0cftvIgqTwL9hP7PB6N24qPJtAzNEXf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783634286; c=relaxed/simple;
	bh=C6+QVbKbywsT2lvtAVnXRM7Y/Q3xo1OzIYQ065Ab/+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fstm18OvvMxBWtS3/GhQr4mA14DivCwUJarH2S7WNcs0d4AQ6MLnG7PKhcQ9nEda1NSeiHIWGjdvkRUGEGsq77Hk3OKq4IA+B1eUkQYI4njHwYJK65MZsqvi60wuf0QHdi3IpXWUgFsds3sSsXGHxrtw33towXfU0i1SH3PhCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m3QKUTQ1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m3QKUTQ1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfad59921so1777711cf.0
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783634284; x=1784239084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rIyfo2VEcxlnkeMECDcWCS4lIF+QfUGCzzimsolaQ9k=;
        b=m3QKUTQ1C5zbX/YpijBIQfKsHGZo+U6y/OV0TwRPisnkmezn6c2BxvvNsyC1cUd5uK
         GChlQIbqGp06MpBOpgY/qP4CSt4tiWzxHSYarYdghDqihf12QtkdHqY+7Tc2Sq2/GW/u
         ECNLCcbyf3olv+xfZeUBIsDp0KJIXnJWos3syNx7VzISIPu+Z6hhKMbi3ndDEz90IH95
         zr6qa0cwwS8R27MsLMMeW9L7Sb2gny+Lnv0oG5RWWUgjdnMAURbOXtCv9Ni0AAZZfh1r
         lRaWdiURFPgRAYDsZ7isZ/GYeH9THrS4FBIG10b7ZqclkvkbRm33AIuqpoIujUAMO/iB
         se6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783634284; x=1784239084;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIyfo2VEcxlnkeMECDcWCS4lIF+QfUGCzzimsolaQ9k=;
        b=rWa2GAav+X+d8m/CWnPI+632faeq8Bwf6MUH2LPIN952SCEXlYzBzjy+Nvilz780Tk
         5sJB3yXXsFHisslReu1Tm/AqW+yqcO2PNJa1c9t442FzcjZn64VX502hF2e6xYCiSPJ9
         3KYO37EBjSuKN1ZoH03Y2D6MGevW81IylcsWpNQccSHwTDNqDvc9taARHbPfkyg0gc8Y
         JLFnqENXdg7PkBndmkKt3E1jqRB3l05ozF0k7uma8FPT1AHzG/e6q/ICuM2Gy0u07UzI
         DQ7iQFaKIlg5KqucVbQ5TmVys44UgG06OjjvCBXqZEgU8o+WvnfyxxSZFbmJZI6eQCMp
         +Uxg==
X-Forwarded-Encrypted: i=1; AHgh+RqOduA4ItKpCQtgVsAu7b/4E8go581mpJGl6GDqJt2UAiR/gUjKYgiA+M71JvRhecGmAzh5TowBkXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6AmpuyngB6TiIHSWJSbDlDy5ODPBmX455NOHi1XUG4E/qkHlY
	r4Mjd9jSu3RyE0m0Kjxqlh361k/a/bla70znu1Ilw4hRUQZaGjMVSA1QyI8Irb6JZZngQoUZ8eN
	eJ2y9
X-Gm-Gg: AfdE7cmz99xrcoagv2V/9VVpNnOb00fnIAAVJxpSABXijfvpncbP1c0GG9lB18rchAv
	S0ikLkcON+fBWz3oHMllnMLTlyXMGpmT+GyvQ3Ba7VU+HNdN56ZiAJgwS5TUTGPg6Iyjcia+vdY
	b8AO6iYCge6NvOJOhmJu04LuBkVTBqeCDnlf8O27fFlEcFbJsHEqU9O/IyTP+7pjy2KeRP5HBdB
	zoHUxCiI1hqrUXhMf9ENrGHTT0f/oQ3VfzsSS1mfP9OievzZcZktSgii+z2rJBtiiWfGHwgk110
	RUS44Uz4ynvUjJJqJBg411/gOBxa4hxXG3316zfMxPMpyGB2+WG9HxEz64LXvhrv6+ECO/1lnej
	xJO6xD1Gkzsw+tOYq97IGOgVFV98WGucUqs1qclzBvG5t4KWmDdBdig+sMB4dxhUzIhWo6Hx2KU
	zmuTk7NYUDuLQK+45KNGRwWoSmVUf4NTE19cAOJ/TfU2oI0FT4deX4rjgHDY9UXzU/i+5+RrmnV
	drjERA=
X-Received: by 2002:a05:622a:11d5:b0:516:dff5:68c4 with SMTP id d75a77b69052e-51c8b403cd3mr96830461cf.7.1783634283862;
        Thu, 09 Jul 2026 14:58:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf9a12csm3563591cf.27.2026.07.09.14.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:58:03 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:57:59 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com
Subject: Re: [PATCH v6 08/10] dax/kmem: extract hotplug/hotremove helper
 functions
Message-ID: <alAZZzO96_ZltrJV@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-9-gourry@gourry.net>
 <151783f1-c0e4-4c2b-a051-1e6e9c546cae@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151783f1-c0e4-4c2b-a051-1e6e9c546cae@intel.com>

On Thu, Jul 09, 2026 at 02:44:25PM -0700, Dave Jiang wrote:
> 
> > +		 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
> > +		 * so that add_memory() can add a child resource.  Do not
> > +		 * inherit flags from the parent since it may set new flags
> > +		 * unknown to us that will break add_memory() below.
> 
> 'later' instead of 'below'? Comment reflects previous function flow that is no longer the case.
> 
> DJ
> 

ack. will pick it up on the respin

~Gregory

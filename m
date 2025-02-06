Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517B41E5B9F
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858454; cv=none; b=HOC0+LChSdGWdclRSK8Q0S0KGPfa9YtqLN+0aZ2HujeaPrl4N7WxUDgsiEuKYhVXkFmh5VsPcV+ybCrOUT6vSr8sJXlMCw4w/UleSVIgxVjesbewNa8b8zFN5l2xGvyHRXcCI7Ad7/udO1Mrc/3A/s8m86Gb6eMwzjPoStM4sI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858454; c=relaxed/simple;
	bh=nrsb/6slrFvGTvXm0j6jKPf8WGzk1y3PJkT9vMo0J6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBSrBykxar8D9xzkws05SVNSZElxdLqbGc+ddzYKJU6DIbKF6IlkGbQEYQpGOMo00yhvvFt9QyRXnpk7JGSnrU4G0Ipt9rKd/UruqKaxTeh/l4oFl7YceHzftEIrNmd6cFSLNwbcKaoeKJgy15NAURjhegMd+f14dRzoyA+Ly/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MXSIOQbK; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MXSIOQbK"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dd43b08674so9548316d6.3
        for <linux-cxl@vger.kernel.org>; Thu, 06 Feb 2025 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738858452; x=1739463252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+lewjv5vC1GR7f3hvHTYC7l4Dem4ZyJ3lIDyklSVdf8=;
        b=MXSIOQbKzUhMJgC2KgT13lK30usYCjG8wmjIQI3l61TJsDYwmYVqM9u0BpBd+LfwA+
         BhsXP1hWS8FGpZ/ZU8WgQly1pvIcIFeGSl0CGB1zzBXGuhw8fbKZKurHmzVUG+bb91b/
         QZ01xuwDDP66llHu8c/Rs1Qw5ElbAOEJiQJgUntOEnAJHsvNpW99ALlLekhS81355jq7
         4uL98hNkH5dbtPvqU33ewYJaP2qgzZqRvWjKsFwxa7ZVufzP9VDN/ttSSMIh9yxT+dDw
         TW7ceMxTXyH3wKyx0gfgT1FMlEkoS28zSD/PbARL7hp+JpLeq6PeRfqJnK/CfKrjtyuM
         X9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858452; x=1739463252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lewjv5vC1GR7f3hvHTYC7l4Dem4ZyJ3lIDyklSVdf8=;
        b=Da8wwFKTDkIeuoMd+Axl7iit78v3vr3sxr7vwaADfmcQelfkqu2jrP0bxnHtIvsV6j
         OWR++/m3wr4j6OiH9AcduoZ/LYt8a1DTnQLZesUr6whYNGIJM6n8ukqVVcUrINzmNXcj
         QRvFwHQ/XUWwetb/4FQUVb2azqoyFbuI1EAYKLmZ1ZJpybTUEcBVERilxHx85Rn2nxH5
         ztHGZNTRpttB2uKqlP/FfiO2h8sxUNSJcaErI4DlN8mkuvXJN66L8/mjTWf54gmFIXsD
         Oeizq25UXjzhBFX66PH8mJqYDZ2h7U250yYZLhQWlRCgU9RtHJnvbmHhKuO2ZysaBYCC
         vjCA==
X-Forwarded-Encrypted: i=1; AJvYcCXhUBuOtKuimuELo6cJBSK+2E6EAPRfRLwsN4/ZH9hIxAvoYoreNfzvgUjkfwgy6McxPmkD3DVXMqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ADjoDg3NVzO49ijaJxCROtHARwkQy/pis5FkvD1wI0MLSVPc
	o+p33JvfPIKNU15gAyCCO40xMRzG93g6UlDCNFPvyHCEsuKfLiLZyi0IRVyt4Fk=
X-Gm-Gg: ASbGncvr8YjqRuRdlTzIg+9ZStdpS2iu1x9MCq+BWDl2TQqTfrpUo8eZQOV21vV6xgg
	Fs8oU2qoLSM7mowQyRSEKiggBhj/LKx84osKuJ5REnAb7rEnDFGrFYddAWDIpuzMmseMjSS7zrH
	VWf8390Tk5PdqGYlN4TzZiEGCtTF2ps6xyaYa8YdsFRQiTZjHACpcYK8IwFX90W5OyI9RUZLtq3
	lzuE7N7rhJfVFxOKlYIqIITg0+YEGtUWo9ma9CgVlZqQ2TPRhCszHyJ5OvALADmgfScTbPNoL2w
	e6LKU1QdqMo5l3JQqO1weZ8fOJlMLoK7JUGapYxY26EYmFfMWx8P9XUzpamMMmI4sfP5G8A1NA=
	=
X-Google-Smtp-Source: AGHT+IHCPJkVR/Y9XWSDTzf6oo12O1B1UvudAIA23zaHHHxZzlraEKKuGMKsqWMkD3DIEDgloKWNDQ==
X-Received: by 2002:ad4:5ca8:0:b0:6d8:a946:eee5 with SMTP id 6a1803df08f44-6e42fbc629bmr106479266d6.23.1738858452144;
        Thu, 06 Feb 2025 08:14:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43babbaf3sm7039996d6.109.2025.02.06.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:14:11 -0800 (PST)
Date: Thu, 6 Feb 2025 11:14:09 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 2/6] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <Z6Tf0ZvZMfqth_t1@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>
 <Z6O5JqL30lFr4S8Q@gourry-fedora-PF4VCD3F>
 <20250206105403.00007062@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206105403.00007062@huawei.com>

On Thu, Feb 06, 2025 at 10:54:03AM +0000, Jonathan Cameron wrote:
> On Wed, 5 Feb 2025 14:16:54 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Jan 23, 2025 at 08:44:17AM +0000, Smita Koralahalli wrote:
> > > In preparation to add tracepoint support, move protocol error UUID
> > > definition to a common location, Also, make struct CXL RAS capability,
> > > cxl_cper_sec_prot_err and CPER validation flags global for use across
> > > different modules.
> > > 
> > > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>  
> > 
> > Reveiwed-by: Gregory Price <gourry@gourry.net>
> 
> Reviewed...
> 
> If Dave picks this up will need to tweak that.
> > 
> 

that egg on your face when someone has to spellcheck your tags
:facepalm:

trivia: The last upstream `Reveiwed` patch was 2017

Funny enough b4 takes the tag as-is.

~Gregory

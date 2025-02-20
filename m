Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BAC2AEFE
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013223; cv=none; b=IGDRMtyCV4Z7FfduXUzFR2PiYm/B0C4Ma/i5pFhEw6sK8NGnH7gAoaDfVYVXvLLjcQ9pnhB/M6Qu5q/uQJWob94bb6dxQ3Y0KE/rXDk8bm3hLzKCqZT54bOkIgocNaD+tC2mpbMFeYhRP2RFnQ3kawCv4jrT+WrQ7WtOzsVMVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013223; c=relaxed/simple;
	bh=S2cqqpLULU681yBCINb9NMRfe7QfoxFetKPWkeHjawA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpYWDsyzRlXM4T4DBC2NzJQfiuhonOhs/1o/WGBBjtpatQoo3yn5lSb5Ug3bLLJpGmfAsyS8gIG/gGnJQZAVU1aPwXIs3C6KAC1R6zmpmrd2cCk2xoyEOnel9iVU3SEWlV8rLrwwlLRFZmsve2Xa7Wi775UqigtdsPHw/a620j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nh3ImEaz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nh3ImEaz"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471eb0e3536so6691281cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 17:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740013220; x=1740618020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoi1brQ3a+Oq6+fnTxf4cmydsWprTu5/N19W7+q7/XE=;
        b=nh3ImEaz3Yf9IM26hAwkkW/lLl/ozABi2loe/l9++69QdWLgRm2gW8jWGZ1NyzxR19
         rjOQJE8smeLAQhbP7AglKbjkqELrzoudeo1FKHQI1rzNs+qkLYqI7uRMGVu0H4UusAZ2
         QCknzqjDlNfDWDF4/IM6heduHvisxBDqwoWwuVI1UYsW+cNZAyD+4LJJ/YIidEcrEJOs
         3ZYSw+efpaeIH84etBNB6MsHvbPhK87wiXg7gG0Znm6BdlR79PRFGmDkRe2toveYeZHc
         c1vGgk1i1cMC8BFtJ4d5OjYFVYODclNCjftYlryj0+p5cDzcvfz+fdfENgE2imhwjL3A
         PI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013220; x=1740618020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoi1brQ3a+Oq6+fnTxf4cmydsWprTu5/N19W7+q7/XE=;
        b=LSX7qeGy4CltmuFRxMRAr4wUZIj8MUuOm5hB19RFK/cfa89dRBEO7fRd82z9Ovmhjp
         ILCRp2QHh1y2YNno55edUqX6m4oPJh3rQLQ3wSKm2Tomu7UmHrEXskePPeflXCVr8Sad
         s2NXeKm3vYHfKG2nkyfduEKNE5nEQGBDE2lk0xYqtevNLNJo4nYtWPQoiSF4Au4psWwy
         lAUmgox2to20KGrvma9ydt84J/Bknmi7ZYeNL13EXlXtPKqBH2ltxSmXHnW8FDiUCVfK
         Tt7e8XjGGvdf4r5KUH9AvyYbhp+9bo1lRHazJoD/0Cu1dlmVfe/M2OUCth2ioWAHcvr9
         htig==
X-Forwarded-Encrypted: i=1; AJvYcCWO8VKhizbxpjmSVRUORRl5i3jnW6l7KnltObb7DlyKEnBKHiGEehbGIkQyZSymNWVPPsHDo3RgDAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjLxM0SmrVu/sWE7VfSRuULEQ1a0vbd14DAWpaREfmFNQhAqMe
	82wR3rKPAAb8ssO7tkqgLJtoAHf3A0y7289NwAXjpuBZ91geOkGxccT4IFmPa6vmBHwqtpiRGVe
	Y
X-Gm-Gg: ASbGncso5GpIGxHJ3JOApZ1+oy94xeg1cQB1gqighLtDGrPjvkb8M6A2e0bFCMk91Uz
	4Fzv0OwL8vKetlkcqs+D7XtDNs9+OF3Ve59M7m4tAaZ5n47IdL5dhNT2jJ636CjoX7ijmCrxHqF
	Il5BIkT3VY9zVvpOQPjwuYoLxZjPSrP93XWGrVa+7nCMXIotU20NAtUF7CmhoRRuyrRlQCNi2bE
	C3dbDIb34iAcf4Oo7wQRcqh5BcaTnCBQhJIaC3P93CLS1j/eJ6l3j1hVoBCGlqme8A7xKBjBgNx
	n96G3WEBuiTkll4Ugp72xQtS+JRvfIM+EF3ykAIxz7yrqNA/Rza9xrrVPtJMTvQkQgb1PWDR2Q=
	=
X-Google-Smtp-Source: AGHT+IHP2N68gFzF7y0BSGx/PGzi5Hy/HoXLhJu7d4/VfDxpgfvOrxwBHyluL04L7qi40nZ87CEp1A==
X-Received: by 2002:a05:6214:627:b0:6e4:2d6d:5394 with SMTP id 6a1803df08f44-6e66ccf197emr301197996d6.28.1740013208049;
        Wed, 19 Feb 2025 17:00:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d784ea4sm80495086d6.33.2025.02.19.17.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:00:07 -0800 (PST)
Date: Wed, 19 Feb 2025 20:00:05 -0500
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
Subject: Re: [PATCH v2 00/15] cxl: Address translation support, part 2:
 Generic support and AMD Zen5 platform enablement
Message-ID: <Z7Z-lcV7BAn1M0Gt@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:41PM +0100, Robert Richter wrote:
> This patch set adds support of address translation and enables this
> for AMD Zen5 platforms. This is a new appoach in response to an
> earlier attempt to implement CXL address translation [1] and the
> comments on it, esp. Dan's [2]. Dan suggested to solve this by walking
> the port hierarchy from the host port to the host bridge. When
> crossing memory domains from one port to the other, HPA translations
> are applied using a callback function to handle platform specifics.
> 
> This series bases on:
> 
>  [PATCH v3 00/18] cxl: Address translation support, part 1: Cleanups and refactoring
> 
> Purpose of patches:
>  * Patches #1-#2: Introduction of address translation callback,
>  * Patches #3-#12: Functional changes for address
>    translation (common code).
>  * #13: Architectural platform setup
>  * Patch #15, #15: AMD Zen5 address translation.
> 
> [1] https://lore.kernel.org/linux-cxl/20240701174754.967954-1-rrichter@amd.com/
> [2] https://lore.kernel.org/linux-cxl/669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch/
> 

With the one build fix i've reported, I have tested this with Part 1 on
a Zen5 system w/ the PRM functionality.

Will review patches individually, but for the set:

Tested-by: Gregory Price <gourry@gourry.net>


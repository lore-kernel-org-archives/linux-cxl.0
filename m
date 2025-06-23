Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F661078F
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706398; cv=none; b=HFK2i/n20RTvpoiGx9SoQLKk91o+BQNUms1mJFf3cPb1RtLogittfxgimrJl/tXzSCpRIFIyFUtyc7eyEME/DPhSTXCDCbEl2QegeezXyYLx6hui/UNBjmtsHnu19n+Sm1Kd8zNX+KWeohRX1fOlOmXQJshv8Q0HrtbR7Tw61Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706398; c=relaxed/simple;
	bh=/KzjYP4jGRkOL8tv1XYhP6PhsnBHTBQpvSmWP9PLkkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgInIjqF/dpEyWMIktoFvdMGPrLcTHRIu4QbRS7ESXV9dztqw6syc1SKkdFmg5VSLzgaaQSW7VYwdl5M8xxmiCeNn4YAG/gds0nbDhdI5crgkHOA9RECScPLaG1BkbD311NS4Qa7LOnDF62SOe+tF63WCtV4NVIMk5al82gNRdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bpvhanDW; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bpvhanDW"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a56cc0def0so77865591cf.3
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1750706394; x=1751311194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sc/yka3hfGiPDvvwtGoDtghN7JXKc2MnzeWxQ4J3bkI=;
        b=bpvhanDWrZRD4KArqodsP1nwH0JPliKlVjUo4dQFo8upKAgTyCVu5/XNHgiAutqk/A
         b2o+o8XCaA9p8OXqZVeyegeTZ6lULObDALj2vFnr5xsp1e6s5Yen9rt0AzJjCy2sBhPI
         34NO+MLFxyJplJ/MIP7sR5zAR6EeBq/VAfhEeJUNuB7z45/DWS5CiWtDQKLh2TjM7dxT
         RhxiX+7tguTY8clfb12xBKogkDhHNZ3cRiAeNUGY8nGg80z7+aH6XDF6ckXyrwkO7n5k
         SlOuGC6My5KTfOLATK2te1ZDnTixhj0n5r3RHeaoaULFzItObTutXQJdAo2Bi/TN+FvN
         InWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750706394; x=1751311194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sc/yka3hfGiPDvvwtGoDtghN7JXKc2MnzeWxQ4J3bkI=;
        b=bOOyTWP3p0eC+CEP3VPv1tuNbB8wcrl889o/tOGOmIgg8w8g9RYmepHhitYLf7uQvp
         kHw5SdG+bXksXo7Y2rAAToimkUfMvrc0vqkYRGaM8Fx/AneLQKiL6ZkKeq5am1lBZvtD
         sBpEDFUSqR235H42Dv35DfkFdaKn92O2dcrhjT3M5WMAzafmCwcGn8U+b8zO4GWjyCxl
         QRAsIBVXOIWcS92i8EuXlw9uzdYxkSApaIQkqLUMjgxbZQHnI6KIXjeEh+3XmxXPlh0r
         YgtQ0GCwLPc9Z2w5Go+XNv80m4C1HoEsyIjU95zYaSuPIumINvHtR1PotwRemn0eTigh
         Y/fg==
X-Gm-Message-State: AOJu0YxDQykVxIT7POyry46l0eVDfD5MTRXXyIWR8KI/3SLJI/GrPldy
	W/lFjV7H4smeTH9N9u2KliHsfMen2tIRm8JFJWDw4ahsMbARBqCT4Tl9122hSxZ5vRI=
X-Gm-Gg: ASbGncuQkRqnRoxOlbd0KltMe2rAtX4yJb3tK3u23ZZUWzAOuG5XiuO1rFSxju8kCJY
	uRBqqLLpkXvZLw8MfEpxcSTR5y7SemQ177eyDfZl/3oUdJVIiV43sLfqgYnUrcFAr18nP89S2r0
	91JZ20xxsMPjVpgTp7RelACv+iRnwadGmFWw0ekXQhoYDYrNWk8lgLwl39CkTM7KdQFFme4qSos
	KF6M6d5nckpmQQBm58w/x+SHo0fB8MEUZ22qadqhrYVyI3U92C98fy17HqhOmNAueXHbE0qMs5d
	fGgKexhCFZG9WmoXo7ZmyHOg/NpU+fyYBTpHQBdxDGFrP8TBeRF02eHNXQ==
X-Google-Smtp-Source: AGHT+IEJDgRZZ4nVCbDO5jD8bXYatavVeTWpCEC8bT+J/SLimj0HRJIsJlld3v5/Yfo/JKK58W+zjw==
X-Received: by 2002:a05:6214:268d:b0:6fb:4f9e:957b with SMTP id 6a1803df08f44-6fd0a600403mr207925346d6.43.1750706393967;
        Mon, 23 Jun 2025 12:19:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:e19e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd1dcf1be2sm28135296d6.71.2025.06.23.12.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 12:19:53 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:19:51 -0500
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts
 btw CFMWS, LMH, ED
Message-ID: <aFmo18OEZGMA2HU8@gourry-fedora-PF4VCD3F>
References: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>

On Mon, Jun 23, 2025 at 05:29:02PM +0200, Fabio M. De Francesco wrote:
> Add documentation on how to resolve conflicts between CXL Fixed Memory
> Windows, Platform Memory Holes, and Endpoint Decoders.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

I won't block a doc update on a suggestion so

Reviewed-by: Gregory Price <gourry@gourry.net>

> +Platform Firmware (BIOS) might reserve part of physical addresses below
> +4 GB (e.g., the Low Memory Hole that describes PCIe memory space for MMIO
> +or a requirement for the greater than 8 way interleave CXL regions starting
> +at address 0). In that case the Window Size value cannot be anymore
> +constrained to the NIW * 256 MB above-mentioned rule.

It might be nice to have a diagram that explains this visually, as it's
difficult for me to understand the implications through words alone...

which is likely why the conflict exists in the first place :]

~Gregory

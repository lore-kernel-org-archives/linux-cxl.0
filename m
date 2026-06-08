Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3D352009
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905302; cv=none; b=EmQVZqXN1H5o5yBRJEZGIYe0uE3nc3+3JaUXysSx5emi8Gg9clk1VM/mDfQ4f6DK3oF39a1YRdDahkSca2VNQn+syMnRuEOL8HlOeZkKZgQXIMja1YvNcuHU0b2tgnBmI8hXJvy+CFDR54uZFnOXDE3k6L4Klxc/kciZ5M4dv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905302; c=relaxed/simple;
	bh=vHKD4pNBVP5yFi9n1sK1jxsbPuVMP2VwTvfvDo5lkK0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UszAT+40X+oquKhVD3C++8p/4UNLaec9pSZCtxlueSeVCex85Cetd0RfIkGYqoeBxi2HgVAxOK58jeTBnYVDtAOQ2Q68mySDVb6fgbe0nkN7IGEC3gXh+b47GG7Igw6cZBcgwFkI1wf+NHGBHG4BFQURPORbdEdZmARv4Srdg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rusEXYWA; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rusEXYWA"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137bd9ed2b1so4339050c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 08 Jun 2026 00:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780905300; x=1781510100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg7vHrN5N+PObzyU44CzppwiRskgouQ+48smFaUfiD0=;
        b=rusEXYWA1r6h55KD8ULTLVNSy/QI1SVgPgDW49YHTs0PduHuvjUFZHr/RgTnZSes+L
         NZMn0qrjKj6IdixpJy7LkGP3R+dbB5T3HgyVQTjGETvsLcgMjiW77h0T2pA6It0D98fW
         VzsVb29jrz4VQ4B4QHLYDYM8pe2FSpaVAxMZhQhF12fyNlcumpOoZjhTZ+RdaU/TmvBH
         RRmqT+Kprv4GwpbsEjVJN5RvB/Q8Z7woU4EI3dQWmM8XS29QTx/yXiCxmmiIJqnGIMDu
         nc0d8AYBqbXdmyUJiqeDhk1ClyGwjQltJ9ZbR7W4DfTqMacLRXyhePL1noweIZ6bD9Qa
         /xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780905300; x=1781510100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg7vHrN5N+PObzyU44CzppwiRskgouQ+48smFaUfiD0=;
        b=EYnjnSKflr73eG6H52Mj+yASzOz1sKzbANuL+ABw0jNpK+0yUWKLV+Nj5SiwR+F18v
         SvVKVESkS0cPRfEOcJq7dTTo9plonIK4dFTi50PgfrJJLtbw82w71AO99o21fyHnII4d
         J8He4jNasDSJrOyt9yHFw1soFCf0oRHg1fsJDaHbO5FJIqnz2aCXLCzGeoTkbOhgo9Om
         chv/YYUpx8AZ2zBXgkmyGdLvl4TZhWssPKMb2pPZsyA/ahGLj0ljaD8A6C6No/u0olsY
         ZUpjSXmK50hjRuodbH4Gv1NtLqwGu0En1A8KyWZSxtJn6aZ0P/9IKyow6A0GkASm6CXf
         vsRw==
X-Forwarded-Encrypted: i=1; AFNElJ/LoiixWuCqog0Yf7IGQIm7psdxs04dpwpmKAMovWLeX/eMiWPmJCVvew0JxH0WIA5zFVIS0/7xeiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0UR6VybdrgyXZmFz65RqVqTH00cgjKlyiFjNZiq/Q7t7YIIM
	dRNw6mBcEBGEKkhX3FnMvjWsIAOw9LDeS2fZTi627s8uv8S9WqXIbJlg
X-Gm-Gg: Acq92OE9sNl2sNQHtWGHS5q4GvFTw0wZFOKo9/xY6/9GgFi4EL2b8WfTSHtfBLRoL3B
	dtmHRuFp3Urh/ICjvw4nzYqySaNbQSUmoPXybFGSJn1bdVIXU7QXLjuwS2zZFlVU1zpZShGckbz
	vtfiXfQNtBCr+agHMSF0h/o4S0U6Y6heLtQ04aoWo1ZTr2uFcULeFtZAx1LwvcylPyXu6Q8va/m
	jkrLzGl6QlDwhJqGBi0bim5dMnU0557oeweOf29h27ACX8hjY0LaIV1O70+j6INvnA8KDkJ+wly
	UEXLa7jUtG9ESuC0yDzyut5c0tGdFw5xv3c1VChy+m/BelNnfTqM7xs2nBy6TZTnDuRlJWIcCxK
	UA7gpichsIjVHNAlCRt3CzjL4OrbAwnmacvI6SgR0Q9FKmgls8dCfqncCIVByeBZslpuu+2+gwk
	Q7kj2TvN1EHWyvHcKHR9NNgM6Cx6W0B9kTytg0gU5/LxH4qx7EIoHKjIgafaRGmCyMF5FaEFYFQ
	n/1YUE/QG0rK/coc331n0fR20Wy
X-Received: by 2002:a05:7300:6d03:b0:307:26a3:75e4 with SMTP id 5a478bee46e88-3077b35801bmr8385334eec.4.1780905299936;
        Mon, 08 Jun 2026 00:54:59 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm20803983eec.6.2026.06.08.00.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 00:54:59 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 8 Jun 2026 00:54:57 -0700
To: Alison Schofield <alison.schofield@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, John Groves <John@groves.net>,
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v10 00/31] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <aiZ1Uc87l7qd1Hvc@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <aiJgBmxiwx0DWduN@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiJgBmxiwx0DWduN@aschofie-mobl2.lan>

On Thu, Jun 04, 2026 at 10:35:02PM -0700, Alison Schofield wrote:
> On Sat, May 23, 2026 at 02:42:54AM -0700, Anisa Su wrote:
> > Table of Contents
> > ==================
> > - Use Case
> > - LSFMM`26 Discussion
> > - Updated Design Overview
> >     - DC Add
> >     - DC Release
> > - Series Info
> > - Changes from v9
> >     - CXL Layer Changes
> >     - DAX Layer Changes
> > - Testing
> > - References
> 
> snip
> 
> The cover letter is missing the list of patches, diffstat, and
> base commit which are all usually at the tail end here.
> 
> I noticed because I went looking for the diffstat to see if there
> might be a Kconfig change. Didn't find that info here, but very
> happy that this seems to require no new config parameter.
> 
> Please bring those sections back in next rev.
> 
Will do, sorry! I accidentally overwrote it when pasting the contents
this time :(

> I did fire it all up and will post in the ndctl patch first
> findings.
> 
Thank you!
Anisa
> > 
> > -- 
> > 2.43.0
> > 

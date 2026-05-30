Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0CD3C2D
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100211; cv=none; b=puTdQNUG0XwN8dm+PWaYmZye5jkv5rHJFQTjXXpmNfvBKoPLLAybRg79T+Lmiy8n507zE88qNd4heoeBB5VPLVhKgzxshf0capF0FpI0ovI4M0sTepjDC+aTORg7Wd0K6bDbKQVyvP7Son3LNYnAb1f4U7ZhTbIWQIw3HWBQsqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100211; c=relaxed/simple;
	bh=DYmADI6IP7uO7YTuaI6/QQAmwTU+7ASPKSPQ73eNSP4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3n+Mv7OxjJiKEGSOR9lE3TkcEVoOyU2HYhJy+lhZTudsXgWT8AMWz9/gHhxvT03xzkBfAXGl7+9K/FsAkceXexNfw+4HIcli0sEI5Zj0eZZpjhazt1bOC/kBuIGjEnSbVDX5CN8aYezKF2lZSkmST5ZyW2b9DIy945S8l8aPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF1kKBMD; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF1kKBMD"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1370417c01cso7454858c88.1
        for <linux-cxl@vger.kernel.org>; Fri, 29 May 2026 17:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780100209; x=1780705009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVXgdiFbBmNELLJoSYJrAzCjvqnh18uX+00qEbp8DyY=;
        b=nF1kKBMDuj0k4QoPVm2GGNeMij/pPYczGwUZIKx4QxCm24eli9iLgxGFQJ0d6hiPbU
         Jm2h9eiyHpA4QSHmQe0MWAb1tv+GYAnduYZ/f4tADlHiCQgh4lVMuOiCs9jyezoL8lU6
         WM75aBN3ZEVY5S18u5AHaYqgqYHpNhg/mjPmI/qK16YrvMoQoGO/cpejcqGFt5gcb53L
         RJrPZqSGM4t9B/dFWK2rUnaTuZfuQFUHGtbJVH2KYWvEo452LxV9Dzmiau6gdPUioZ4P
         8dUxH6VBWp/fqPb9OsGWEP6Ceu/34kLw9Wyv8ul0wscADNE63nHOZuDLS0K3eq/L51mE
         Jr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100209; x=1780705009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVXgdiFbBmNELLJoSYJrAzCjvqnh18uX+00qEbp8DyY=;
        b=DtQFSMlwhPzFwrQy95lRLh2L222rIH1Yajc7cQ2iD92pwpDfkasZVLZ+3fSYG7S9k5
         NEmveyY566TzsqulPNZ7Sw7ytnh2UvLBnT5WdvUKDMQZk8w8pgJACFjOcxZN5dMimPMY
         /fCyY1kyNNoWi1fzQyO8/OQW+GRN5cJNJx3K6fG0lk/BoLmbYIdraNWTmf8RZNjeTmG8
         YaLdIgvjvS2kH09SXFV3ZHCrOXoCOmTaHY2yBDDubBQ5kEKiTrKDS3ujcWe54l0UgP3y
         CF7COfa6i0UgqxmtDyM12OrwjqbBVLmW3KUyGwSPjQTEqEZYBKJGi/SFtkcZpY2uSUW/
         DZCg==
X-Forwarded-Encrypted: i=1; AFNElJ+aY5DaawOusp3oF+FU+Y7fB0CDUjCxpS86jODtmgj3HSNdj+aQNMxOVV3fqcvwqnglEaIUY+wjsYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7INCgr7njd6AVNhx2lDVIUZ4WAUcZUu4XImpH2j0/TrroVtaj
	ea+ZLLJZZGAKHysCSdtAJRojemC4nCvH55OcKe4gx6L7xF9+wqsVpLgQ
X-Gm-Gg: Acq92OFIBds2ayNzdIXU5Z/2pT5yZggRm5wruTFl6WPU9hWdoFvLVV46YUBdPOYPEmW
	q9Ohr7VpxaPoRi+ocjY5ayFnYwzJZBfSIQ0A77E38CbCXE9VM8JolKzMtoUXvBFlSfLlMcz55o9
	W2MFujZrGeJNk2g9RS/oazZ3jIEbzhwzPdgMSnq/5V6lugdiFg/E4dxMhpy+nnKCUvFwLZxpmkk
	NiGF5tEVM+k2PsfsZ1SRPLkNSGaWhh0MDvA6e4TS+9jW/8PWVOOecIvynDY1zEpDVx726phfNN+
	3COzOxZGbClmq4wN24q/j2tqJgatvFm7nOkM+u47r63iEjlxqjjSpAGvEGw5hnso2yxJriP95wz
	piomf/2OvrZABUujluPFMxjdz9+HCaA5boRS1BLzp8GSxzTVCQeUEXrBnKmP7doFxoY0N8r/SQi
	J/9OERxgg/+EnNUdGabk0b88P7+2UFzHiZQOptvbPnYwAysS34zD8o8IX5aPbRGDnQLlkkMPT+K
	qGMAfW8TVTrhG+Lng==
X-Received: by 2002:a05:7301:168a:b0:2d9:a799:3c4f with SMTP id 5a478bee46e88-304fa652e17mr1009889eec.24.1780100209263;
        Fri, 29 May 2026 17:16:49 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c154fsm2455194eec.3.2026.05.29.17.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:16:48 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 29 May 2026 17:16:46 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v10 00/31] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <ahosbq5DgcwlBEHx@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <3b1b2486-d09e-4bfe-8c64-224df8048d44@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b1b2486-d09e-4bfe-8c64-224df8048d44@intel.com>

On Wed, May 27, 2026 at 11:51:13AM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:42 AM, Anisa Su wrote:
> 
> <-- snip -->
> 
> > Series Info
> >   =============
> >   The series builds on top of cxl-next with the famfs-v9 patchset
> >   applied.
> 
> Hi Anisa,
> Just for future reference, I would prefer that you base off of latest Linus tags for future patch submissions. i.e. for this week it should be v7.1-rc5. I would prefer that it does not base on cxl/next unless instructed otherwise. Thankfully this series applies cleanly to v7.1-rc5 so it's not a concern. Thanks!
> 
> DJ
> 
> 
Noted, will remember for next time!

Thanks,
Anisa

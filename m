Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570763515C0
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867005; cv=none; b=FCBN3PXpuExVHS+WfLp7Sjjjzj/kRZnPkMvrD09+p0FBimsgvUZPYdUWrI0V47dsRLxgxH15j+ji0yhFM97lRspjpCd0WK/g1NK4mFaBpnhzbqXN0HRFJp6RG0Fu4x8RXGne5cxs4tKGgaUeagXSt4l27V3Yjt1zCTMR6+klVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867005; c=relaxed/simple;
	bh=4DzNlfV0nu22s4oTVgl3zMJGFMkBmYe8BcT3HGooQ1o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkflF9lHk++gD7BszQIPiIofet4zHT5TWCLr9KPOdnG+Z5YLr3a2zZ+1xduw8ABaZalUKRLy5zG+OH2C7j+093VBwAR5Ambuf11mzfXQLMSVTJOAi1V1NAuGIlYTiwSTQtE4ush+2MQWh6VUJThoPpMAi9oM+a/eGDFSS4I/3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0PgpF1S; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0PgpF1S"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caea3f742bso2379935ad.0
        for <linux-cxl@vger.kernel.org>; Tue, 04 Aug 2026 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785867000; x=1786471800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qs7yGJO2dUWBigiOU3NbR/yvvnHHod0LNbMlLn9fo94=;
        b=l0PgpF1Sfu3cwe2YSI0IX+szdiC9z3c++BNR/Wq30SexBybzOcOHczykQ5bhDGoiiN
         0oQZYTY5y8FraARwrn+SsryXojDcoob+iXns1Jf4UryOgNxnbR2AlGpTEqqRS9eofbg7
         XUBGh7ImNpnoiuMWGlMaWmtvN7qnEEBhkBMhNoMDBYrvuOiZcFbqwTdD1d2znTviLrpo
         BnoCJ4vuXTIfPlJ2I1v5TFqYRF/vVpGsTGWjMxhqr2d/IhIRzbhxzeqM1Djw92bZvSs9
         z/wBQJ2lHOGZzxTYjVGR43WQin+SpuEWeR+2V8BLsu6oUM8dAH90BqOcs1P20R0mNzX7
         6C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867000; x=1786471800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qs7yGJO2dUWBigiOU3NbR/yvvnHHod0LNbMlLn9fo94=;
        b=Jo1KRlL9v5YrUma6DtA0tp1Ml8dksa7WvfMIGwvjOb1ldlvCviv2PKFI0OrZoAsvZU
         QvX1tghIIj6WgYDSPk06Oqw2B/60ScWlnrW3SB2z4Bx/XebGmoJq7n/TPXKsT4RdpmYF
         urF8zkYckNU1LydzuMLJju2TdwdpPO4CoYhWFSKftgXXXFr67WMCKZ81Y0ulW7WVKWtf
         V3Sw+AlKYRvM0il6bKRKnLkiVDl6ImRTFgN+eJNn4e+gsKTnQenLkOTdMLaZonwOti0A
         zIhd7ctHIN++2gpScTAVAcyOoo4uww36NVuMM7iEp3joSoPiWfuV/Y4f9cetPyxWAuDV
         WjiA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5IR0Qfs23INl271hJubSgL8Lkl8bmgSigze91mNsbfWjzTEtVyMEAEt5c12M0l/+NYQA8lX1r0uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqV0YxuJ0t8jRTklgPtYOAE8aZair0M9TopfVIx7ICvj524LhQ
	b+/ujYBHO4E3hqunsvPjF+R3qJQEdnk2Acgl8CFGlqRfaXvUjTbTyodB
X-Gm-Gg: AR+sD11J08u9cWntwdYqG4JGphC02Yk1wx7CRg+xIC2AbPasnYlUXsmyRwObnBpAIcx
	6pdXd5aVzQqfXp/XWJns0n8CPYJCsnvFm+Xb7WX6sMVwNUwVM7MwPHevri3LW5iC43zSWIG/5qn
	N1E5ho2oUSGYMEZACMeUI4k3+hxBjWx5mBZ5uk9IvCRFEccXzkTMcIjHrCgZQsX8Y+ijh3rqJ9i
	6vAhDuPsNb0hQwNVME+uL++IrnlHXvsVjDYVZCHBzMmJnXbJ1u+hFDna4Y8+0A0rFbigfla31I3
	mMqEKy23ghyr9TbOR5d2VgOOtfp4iRIZNTtQJlkgVXoybkALFIRtcG4+SDaAxGigUycHIVSNuUU
	FqRxKkpuHVwNjDtIbPZ6ftsG46FV3cMJ76ySD+o4zRxDDD0a5pQEuEd5LeUdyDHjuRFtfI0VP0b
	liT2M8Z0gs4PZMysVt42CtybGuoqxXuzZ0IAVryUGnMyi4p3YQRH7azhhK
X-Received: by 2002:a17:902:d486:b0:2cf:8363:5ab7 with SMTP id d9443c01a7336-2d0ca9a2657mr5745495ad.26.1785866999776;
        Tue, 04 Aug 2026 11:09:59 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4cf714sm11507535ad.67.2026.08.04.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:09:59 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 5 Aug 2026 03:10:28 +0900
To: Gregory Price <gourry@gourry.net>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v12 1/8] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <anIrFAYITF2L2UOY@cxlqual>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
 <20260731084901.1512819-2-anisa.su@samsung.com>
 <anIJFdtTEmofty6U@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anIJFdtTEmofty6U@gourry-fedora-PF4VCD3F>

On Tue, Aug 04, 2026 at 11:45:34AM -0400, Gregory Price wrote:
> On Fri, Jul 31, 2026 at 01:48:06AM -0700, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Per the CXL 4.0 specification software must check the Command Effects
> > Log (CEL) for dynamic capacity command support.
> > 
> > Detect support for the DCD commands while reading the CEL, including:
> > 
> >         Get DC Config
> >         Get DC Extent List
> >         Add DC Response
> >         Release DC
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > 
> 
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> 
Thanks for taking a look : )
- Anisa

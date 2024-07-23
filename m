Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EF156C6C
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jul 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746234; cv=none; b=bSB5U8ractieSYPthd2fyxNikhwRBmOf+vDthIaqT0wSmoifBayy+qMEWwo9KJXmmoo3G6Ey2ODYIYgmSv3qQy4IqeJ4JR0Jdz/XSHOwnpXFl9FCoLfwo8DNU4wEV91si4Q/rLOHfvyTro3R4DlWJIDpNXBYnJWwT75mKIzLhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746234; c=relaxed/simple;
	bh=Kb5NJNrq1tXYwAFQccq2XyaIJ0jDceX3+10qvJtuDtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE64AtRAumikFF4auRlpcpSRqd/TkcSEOIE9a2zb+6Ap8FIdTcBJ6bVjn6xBQiySUHQCG7L1Y6geiJGspueA3iw9zQeRuTexrSe+j7bzCIRL2YvqcSWsajBW9T28snxKIIpKSXSysYcqjycTkMptlpLgRId+zh6LVC/BPrqQYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YXzleEDs; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YXzleEDs"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e05ecb3dbf6so5417839276.0
        for <linux-cxl@vger.kernel.org>; Tue, 23 Jul 2024 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1721746232; x=1722351032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUDQDkdWLmyDd8onjNy+ZW06VmBfzLOoZpzptDXN9wU=;
        b=YXzleEDsE2jE1Qbw7g1mEN1OFEAd80EVbOvic4UAtnYuef/sLTY+dnVqDivLJDojdV
         Ig85Ww3KE15NzaEUTEYfpuYXd18Do+FAgz2Xy/QwVTRZmzjpdkI3xKwhYXCBVSklzE2X
         kOxwr353ew6/dD9lt5Wzz7kiuqVsRKa+OITTPPbnXp8WKblHuGo0Q+m1XHMraSURBW1Q
         uEzCAaQa+zT/2ZN0h2eX+Es2xxJopu2zBPUF/94PTUwOUTneeA56AJ4Y/9J8lR3wroV5
         S/ZNQX6uBZxXbsz7Zo6SxDj+MWljFrHJRm8ks0wmDBaopkEg+KwBT9jv6jyvTh2uWJyM
         gddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746232; x=1722351032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUDQDkdWLmyDd8onjNy+ZW06VmBfzLOoZpzptDXN9wU=;
        b=hqnIBau8UfqNdwuTvAtuFBSwofDIf31Ajmbx5zmGxQWZw5R5aFkpKqe1WR20iiIKry
         lIkyrX7cihy8wmPGBxs163u38jVCEYyBAcFNYZka1p3MyUJRNm/DjAJ3Nq9QojI3cjOc
         NGcBmy70cNp5mZQR0rEarKOeMlbu9O4rDsuNXAS9Dn2oehiRDEuSP2u2zPZoTxXhDUsb
         Pc2/aucEFshHTo/x8IJQryahzuQiry3zBzSB7cdWQ6yXL2crg4VcEGmzkGFNbg+sp5qF
         Zlvm1iMyLRZUT7mZA5g8KFWi4IaBn9ynupjlIV8hR2uzmuOuzNBweGjOFY1UHL2cgdfy
         xmbA==
X-Forwarded-Encrypted: i=1; AJvYcCWB7nkVuNH+ZtQM8ojpZaVIMi3DzT+/GKajq0gvfNIvE1ntmDqwdY3QDiKGv0zQu/qJCW+ewmgA69ExyswNBCD7aybFBS1cqPYn
X-Gm-Message-State: AOJu0YxdJYz8UmJdaKthFy7eVOvZ8zNK/eaI3BREcZsAtmjEaLfgTlgX
	AWxTIAd3geN6Whp+6Zk+azVL5jGBl8oSnZEVz5dBPo13t8mtinYuSw+GJjrKh/w=
X-Google-Smtp-Source: AGHT+IHLfNRZJV2zPo6ahJW6piWzOpYhIOrEWiTfSMlQH6SvuQOGoZaaz51/4d4J+c4TG14W35pJow==
X-Received: by 2002:a05:6902:2511:b0:e05:fc91:8940 with SMTP id 3f1490d57ef6-e0870181352mr12957269276.22.1721746231888;
        Tue, 23 Jul 2024 07:50:31 -0700 (PDT)
Received: from devbig133.nha1.facebook.com (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e087ca677a1sm1220770276.27.2024.07.23.07.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:50:31 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:50:30 -0700
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] cxl/region: Simplify cxl_region_nid()
Message-ID: <Zp/DNhIP543wx9u2@devbig133.nha1.facebook.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
 <20240618084639.1419629-4-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618084639.1419629-4-ying.huang@intel.com>

On Tue, Jun 18, 2024 at 04:46:39PM +0800, Huang Ying wrote:
> The node ID of the region can be gotten via resource start address
> directly.  This simplifies the implementation of cxl_region_nid().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

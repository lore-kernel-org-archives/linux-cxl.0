Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40A7483
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750119060; cv=none; b=o70wkdZbpLEYNpMUNCGFpTXESNkaIkCKC3iNTWlYMek5yrT3cbBQDyk802BIy/sBlveWieYh+eil/ZHDzXBFUNb83tNJ9mGjWKtABVUvlGLh61tqN5FpkvfzZTg8rLe3KEYKp4YEiCRBxhHslYxKeGryKTnf3ubALQ7SDkstujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750119060; c=relaxed/simple;
	bh=cW9a3H2Jb1XORPCWPEbQXH89DofL90Y/4tlpYncP5Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLx/IuS/DEM0dZJ9NZ3OXLP8rsDMQPsyoVgT6XZuuwfbWTdUwU6t6PUZyiSnKjixeO9LuXuEcKGmQAKK+KKn62a7r/hBMPqB/ZqXyWaPJnRQq11jRZ1XPNVsaPJWJFmMi/2PII1QDDd4LRYxraDvr/pIh54mFXQZQpM/9RsSiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RDXXWZ+K; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RDXXWZ+K"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7cad6a4fae4so1010013285a.2
        for <linux-cxl@vger.kernel.org>; Mon, 16 Jun 2025 17:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1750119057; x=1750723857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5TEqGP1dA1ohDNNPEUIn+95Q5c5y2M6lr7dUEc7k9U=;
        b=RDXXWZ+KwE2+4LSb7ctQH5GYfTiJoYS6MiwgxmT33G10W7tEFaFSkcd388+pg4rE4m
         xiWaBLGZsRGBy14UTyouhU1t7kOqj5KzaKH5QtRLu7CvEhD5+xMqTI9JkeV+kSHVZnRI
         43zoXRjbeXo5ciWP1X2gX70UdSjz4+Mwt5dJfkVvdmyxTF9BYIa5V19n+HLUlgIVKKAs
         XdGL6/eivkNxEeQIpc42ogywATi2GYvM0WYVTdXboz6LcCGTmvg52KaSDHq0+5/YXDPF
         Xxl1ek6rJbsL8DnDnVSa9mlUpKhY30ZqGyqRCkzGgnG2opZDOYn17cpHe0T2Fhd1ek09
         F/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750119057; x=1750723857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5TEqGP1dA1ohDNNPEUIn+95Q5c5y2M6lr7dUEc7k9U=;
        b=gQvGumnIxvs+sVq/g6vZqd/AYjEaao3Q197P8Y/a6wINc/2dNjwFwtMGVLCBT3Qecn
         Nuu4zIbj8wt5vJrvIRCDOmeG2/kLIK82sMDiw/PAYRhew0wz9WCgkqrA1ggMp3+l3FYs
         G3zNcO25ENZzTddFERlNTbNnyHZKrbUui5x+Z1hvmHOJiYErPCT4rx/rHXRI4kVcwDjE
         PDBUXU99KznHP2r5oTuStMTFuP6KX3AAX2MNgBPoL1U4e7jsyZMWaKoyPkOGqlrMxxS3
         +NeB+m7R1MbEktHbQZEMcO3XfmpMYsnaJoo4kh42EqMI5ZS+F4kGNfIbVDZl0FlB3QJ2
         q6gQ==
X-Forwarded-Encrypted: i=1; AJvYcCX59P6YX5jhv4cNsV1vFj1Uj1pi0w9p36qigt1XOsdzVkjVr2CQe46EZNeyl/Qb9PjOD7gQ4KYSYpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70qBEbOcuvUKcp1hO/HqA+Jj5JFM85iFuQJpYOyMPM1OfgCRC
	E8/CY11zH0qutP4iiCUt8GIOcIpitogO6jPXBAyZfTcXNP7DQo8KdZ7ZcW2edjjcQmk=
X-Gm-Gg: ASbGnctO+VbIxUqxLG4ozEklMMAWCdUW0y2NG6O8NVJMaFz3nhAQVX6l7zwxvCzH3Z1
	CgqXni+HEvS3SrY/sp/g7f/5WPh92A0ok6LhHd+lbZ4jjmyRt4BRuZ8YWUPuORo3cBzPsJJqUUy
	BRaA3PLAwHuR6PYdNTatq5SnExIi5mP0bnuxw3ekZnp2wEj7uzftB8Sec01YjAFUvCOkk0o6szo
	5bkl6g+/y9oP1p0vbW99FtAQHhMZkQdpuPNaOjwxbHb41VF//8Sry0uEBeWvcGEI9Cfq9S1jfPI
	JMOdr7uw+4h4Whv5EF0R3avms+fswQPcxianLE7i6o0ohGpZkQBt9PJwwg==
X-Google-Smtp-Source: AGHT+IETz9LYg5ng7mTZU0WsBXmtI5+6OhKkrzdiTTp9Ts5WqaC5ydvNWoYbhaOUC9it+gTF/lSbLw==
X-Received: by 2002:a05:622a:87:b0:4a4:3bae:8dce with SMTP id d75a77b69052e-4a73c597286mr190961541cf.33.1750119057584;
        Mon, 16 Jun 2025 17:10:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:cf64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a3103a5sm54775971cf.30.2025.06.16.17.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 17:10:56 -0700 (PDT)
Date: Mon, 16 Jun 2025 19:10:54 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org, corbet@lwn.net, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
	darren.kenny@oracle.com
Subject: Re: [PATCH] cxl: docs/devices Fix typos and clarify wording in
 device-types.rst
Message-ID: <aFCyjkSB9VwZXjPt@gourry-fedora-PF4VCD3F>
References: <20250616060737.1645393-1-alok.a.tiwari@oracle.com>
 <aFBUGTM4fpwU749k@gourry-fedora-PF4VCD3F>
 <b2acd80e-38ce-488f-a6d8-8bdad425534c@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2acd80e-38ce-488f-a6d8-8bdad425534c@intel.com>

On Mon, Jun 16, 2025 at 03:32:44PM -0700, Dave Jiang wrote:
> > With that change you may add
> > 
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> 
> I fixed it up with your suggestion and applied to cxl/next. Please check and make sure the fix is correct. Thanks!

lgtm

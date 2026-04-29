Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E83838758E
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507136; cv=none; b=tlXInIWC5sJfhA5Ti56j3ZAE5MUZGmhhDLwYVxZg6El15RJcZtCc0coMsR8OaA5/epwz6MGWiysFuln81QvMvQ1aQTsSy4TTHs3R41xOwyHmcOAbvNadgrISdzcfQP0sW87tWNjbKlG6Azc5NzZRYeI06BIVxyd9OmLustxTvm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507136; c=relaxed/simple;
	bh=UP6u1cRk07fUI+6gBqTN1387eMnk0u9rAqi+TNq+K9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ievvJVL/2q7IAEP/87fc6Dt5xH9oqhpROB+alL6wyq1ial7s9vuTt3HGSEL/58WFvKa98lOUXcDMAo3h+bY0QovDmcvrOy+CTUnIXj/Nt+HtYv4wE9OXwt4D5RCYoArlad6hS7eCXGPV7l9S1AwfBuJw+Cg1kb2G0n1yNDCgMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SNMLMaV2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SNMLMaV2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so2817055e9.2
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777507133; x=1778111933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJIuZJ281FjkwI23dF39sBMDbu7btsxau6MlBLTWFw8=;
        b=SNMLMaV2CTD3O+103mzUDbZ3GqBJstcFyfXed7iFEW3R8CQZQuG1OWXZ1zcJ76ycup
         3NwT7TDsnQ5He6fGHJUIYrZrpWzunBDuG8EPSIj9nia08FYZTLEwonOzkg/ElvsmkmRD
         8qCKCMZoz7Nt4stHGjOR2iK7F9UaA5NXd9ATaFYZoQzRK6GAiBR09qY0Q1I2GEBUIOoS
         ipFq0WJ3OenzFumS+OOkq64BwNUvUynKysjGSh/F9Z3OW1a2lU/0KmUUassT4iPQdjOM
         fvY5+ESq0d9lnOz4QNp0r2ixKxHD14GOtOstrFTzqNmcv7NLJjTZBGSDsjlVVd0/+94x
         lr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777507133; x=1778111933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJIuZJ281FjkwI23dF39sBMDbu7btsxau6MlBLTWFw8=;
        b=BG/clFpd5rPy0EJw7RhRwwnB4mQmNppUDAJupKqaGPeT91L6QXSXXFCFF7x80eH0L4
         QMaTmph+m91FaZaT6oFPHL3p0TDp4rh2f/H9MKFq4+KBn1hp97Q3jVAgRG9sijS9tmJ1
         Ve09bi23wzQWoBaA55XVH3W/tqf0Zdhh48GM4GorShV/wAKC0oTO+/vejrV8dTCznWIK
         b7d/fZlRZK7QhqYqXPXiNkizMb6bL+L9lJYAF1hJR3C+7dqwOiAd6xthwR2M0CE6CNqR
         4BjkigFUIHVDdUS1D5Z7ZLK/amK+jSMMoO871hpvaZ1rC9xd0xu9dE66NrtfYcCNa/r0
         GLMg==
X-Forwarded-Encrypted: i=1; AFNElJ+elKxJx07JkzKttssJKfyTYWWD4BNzRb5hGkclTot7bfwxYcBrMaSxmM5HdhsFwZG0XcZfIntb39w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHOZHy13dX4+N0xNVpYJE7T31YdN2x7nVnQoMhTwTAwe37Fq05
	so8bcsOqspvTQNrNwT9R2BlqGS9LsfJXb5pKd4rvd4wRm4DUTjm7eRu5gQQ0rt8XWik=
X-Gm-Gg: AeBDietQGLJ8dU9mJfQPbzDlzNfMK2ETm7y2Fe9s0z/1lyVInJazPfusiVq1P/4FUrt
	3DVnudfuf2F0ghU57T8irnkS4WhEIsvsq8w1mjbyG/jNfWt049Wnvn7HsqlNlyEksmCKiHbSBr7
	afk2Xc5HN4KkInfQigcIFNLAqn8kqiRbCfq56gOPONhKBvFm933/4qUkI2NOPokcNza/424pFfP
	CaTLxOy6+jK/ym3hSIlU9ZtgLx98wYjQK3rjc1xTCytc3x3DYeUf7CBhulWshxa+qlAubmttXbf
	RHaoBuUrhW3ci/jp/1qyfY1xTyybCZfIsd/q3ypH3EWXiNl8NKSGa+cGZvxyQLNTWHXwPiNRsrw
	JQWOccLQNcEl7V7d1g5ip+ImUnYkp5PH7TILIZxGem5QY/qavjMPOXn/Aek8T+iNFJ94lOmc82k
	ukk/E4QWdpc9WviDNY3Ju2P21vFtcoRg8SlmKYU6g=
X-Received: by 2002:a05:600c:4e88:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-48a84444083mr10834495e9.13.1777507132995;
        Wed, 29 Apr 2026 16:58:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2a00:23c8:67a7:3101::e3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6b89sm23797595e9.1.2026.04.29.16.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 16:58:52 -0700 (PDT)
Date: Thu, 30 Apr 2026 00:58:50 +0100
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <iweiny@fastmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, djbw@kernel.org, iweiny@kernel.org,
	pasha.tatashin@soleen.com, mclapinski@google.com, rppt@kernel.org,
	joao.m.martins@oracle.com, jic23@kernel.org, john@groves.net,
	rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/12] dax: Add DAX to guest memfd support for KVM
Message-ID: <afKbOs68Ft8awizg@gourry-fedora-PF4VCD3F>
References: <20260423170219.281618-1-dave.jiang@intel.com>
 <aerm4yDVYpOhxXEF@gourry-fedora-PF4VCD3F>
 <69f205bc6402_3a7a81004d@xwing.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69f205bc6402_3a7a81004d@xwing.notmuch>

On Wed, Apr 29, 2026 at 08:21:00AM -0500, Ira Weiny wrote:
> Gregory Price wrote:

I think we're largely in agreement here, so trimming a bunch of this.

> > 
> > The question is ultimately how much flexibility you need to shuffle this
> > capacity from one guest to another.
> 
> Yep.  And how much control one needs over which exact CXL/DAX devices the
> memory comes from.  As you know from our community calls that is one thing
> I'm not sure the private node idea is great at.  But it could be that is
> not really required.  Or is best handled as a carve out.
> 

If you can do Device<->Node mappings, then this is trivial.

If you need more specific handling, then private nodes are not the way.

The intent of private nodes is to make mmap()/malloc() etc functional in
a heterogenous memory world, which is explicitly different than "give me
a specific chunk of physical capacity".

Which, tl;dr:  "There's a real argument for just handing guest_memfd a
chunk of unmapped memory and making it deal with the problem".

(shared gmem is... odd... given the original intent not do this :P)

~Gregory

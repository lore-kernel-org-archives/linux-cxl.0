Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550C3C1099
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369836; cv=none; b=aDGVC5/kNc2Zc0p4scXs8IlhkfrNslkzUQYN9rVp6P4kvOAXAWkdkdguzPtiNlh4hG/vOx+7FQwFI5mYYIqfzDKF+hV5OYMzze9JWgLZjHj7kc8NzM3GmCx1UoSXHu76Yx7lsSaZVOzgqpqm6LIiTUISbJNr4CHsHvj1XTh6LUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369836; c=relaxed/simple;
	bh=J3ogWlHgltCmMWC539Oq83gosIFEq131LmU2pKtUrtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ2fhk/ZXCl9/DpRmB6H2E/wvG7pgcuVewWxUSVqL5Uv7+HCgPAKFfqljnjat/N+zLiB8xsaGl124swcB2AzNkyEMcmoNIepFO4sQsI0WIJlwUdXfNTVmJJhm1w/wPrQT4D7Yhf40gaxhk7Fn/dL0ZE1sAZjdOyzkeS5J16wHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ppNCiiEh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ppNCiiEh"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51a116f468bso14191821cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782369834; x=1782974634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAbcZ3NxbmsxcgeRZOVz8olu265ZXR9ZINnNyOlf82k=;
        b=ppNCiiEhdCyF124WItgZi302Xrv8VaYfoWT22ULNSNTSg8o5NnPcwA+GwkNSCr8mMq
         gFOmBAq5Spp193FiDc7hjQ5P3RglzvMfa3iVSQIfQnfvGSk9wh8/frHUn6Q07KQzJpbm
         BEZlW+zdpunju+UM1dRLS8qhSIwZOf9DuvO2/smA7cJ+LzgAHhuPQWuUBkMMIJnIgE81
         5Z5Ix5ddIfyTjKRuZ7QRDujd4yhf6IkFk+fBtXdFSO3UUo0uG5cVf3npen8Tg1mxmB5A
         m72o6NMvbylti6d4GePJ18RGsBHjrY2G6bOdjrI1jejek+o55mRCJ4PY+3NQX3NAjicm
         13+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782369834; x=1782974634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAbcZ3NxbmsxcgeRZOVz8olu265ZXR9ZINnNyOlf82k=;
        b=XdWRUsa+ExbqPGrX/mPZ2hly/bstzNmy6h03A3QTffijeN6HtmZfGJIjurJsku68p1
         lyy2Gb5x2ffb39z7tJPGSbQBN/Zot88PFl89l6AD6osFF8yyGziyXy00MT6uTY9/wYTZ
         JsAgvaUdcPjZB/4rauLZ5DZGrhQ77hT34hEtsmALvHjq+fQnLoya+FruxrXRlW0V2z2T
         YDMPZnMpiXng9F+LCcmlJHxYuhqLXHD/w9ydJ6qQSmFi9XENSkbDvIrnyTAe+5RTLrSv
         WzVmC2welWFTHXj91emj2IYXIlx8a27miUTGVJozrNCIbpb4+OEgxXsSQAKGuuFADpO1
         HpXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oG1zSJQ85Q8T9N2T4B02G5F8nvI7CuQaEa3mam66Wi8T+R/vPcbNmFYUMUxWqDc6Gj2skMl7jnCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5H/mByFB1nWJaAFvaAt5BCvLI9j4IIKTSReHEv6rTboanjOok
	pBA4WcWiTMJIehfFpDDBb3WldCeQf9kHSbW+IGu5aaR5FVNgV0QAspVngIZk3A2W9zI=
X-Gm-Gg: AfdE7cmWCgDYG/qnBfHetHcoKBsgEEikXunmSiA0s7rBdSB1zxQ9+Al0hOeTNmx1z5N
	+8xJjvL36VzRRVTYYlBJgy76yTOMVTEEND/pdgFcvnLGXSiFV3kqpZ06BgGVVRwVjEedm/JSDKq
	a8qZogsP14x/J3XwjWS+Pmk4xLFGhU3uOvhVP2XKl4ePCdjNZlfIIT0EaCX9co+5nDFL+bNsP4G
	deG31IxiyL8Sl8MPsjrmxu2Lq81x7iCm7pVDm4aNubW1FvNxJVo6XlvS/uyOKBaIS7piOhU249U
	8F9gBM7XcfsgIxWMhcCX5NMM9GMr2MX4IIQNyKRXVtdZ/6dRHePV4yRnnmLU+c3pjEa6JcA7yjT
	zzQKbmeo37aTfwGndgd+y0MCUnBw6HORmjO6idYvzmNtIVe9zRDXeYtH/NwDeoG2gFQ2orn2Kx+
	zGJpMuf7rQRMAyci7rh/rr66ngyuFjM3GupA1QwktIEPa78jvTWKjFIGpjFAnW5oKBlXVt
X-Received: by 2002:ac8:5f85:0:b0:517:83e5:7859 with SMTP id d75a77b69052e-51a72a8d81fmr15082801cf.53.1782369833788;
        Wed, 24 Jun 2026 23:43:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015e50sm171495166d6.6.2026.06.24.23.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 23:43:53 -0700 (PDT)
Date: Thu, 25 Jun 2026 02:43:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, shuah@kernel.org, alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com, ira.weiny@intel.com,
	apopple@nvidia.com
Subject: Re: [PATCH v5 8/9] dax/kmem: add sysfs interface for atomic
 whole-device hotplug
Message-ID: <ajzOJPgV1acrUfr4@gourry-fedora-PF4VCD3F>
References: <20260624145744.3532049-1-gourry@gourry.net>
 <20260624145744.3532049-9-gourry@gourry.net>
 <8e42587a-d614-4259-ae6b-5bca1479b425@suse.de>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e42587a-d614-4259-ae6b-5bca1479b425@suse.de>

>
> Why do we need to treat the 'unbind' call as a given thing?
> If we know that we cannot handle online memory during unbind,
> can't we just disallow unbind in that case?

No.  Unbind is a violent operation - unbinds cannot fail, and a
straight, uncoordinated unbind is essentially a `--force` flag:
the admin accepts the risks.

To your point, the admin either does the nice thing are they
muck up the system.

But we should still try to do something sane to defend the kernel,
in this case we should try to prevent that task from becoming
deadlocked.  The only way to do that is to leak the resources.

I'm making a small modification to this code to reinstate the
legacy behavior when "state!=UNPLUGGED".

~Gregory

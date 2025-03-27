Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14B20B209
	for <linux-cxl@vger.kernel.org>; Thu, 27 Mar 2025 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743078973; cv=none; b=M8CiJPTkxZciy+zpEshSlRFJBIscIk7vJjKZMJ7jGohkIPLSrfN9H9iWKOV+jk6dlhxks/S0fRCaC2n00sM2DPILPZICF99RXQnYiZWmRVSrm9wXVOVrKfQ09IASSfZ9TDUSGhqR+AaWXRqVCY5aQPULiFV8OQ5zZybxPyIkQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743078973; c=relaxed/simple;
	bh=369H+fsgz2qPrIfTdoR2jJotjmEP80xiDy5h1KP+OyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diV4CH/4oX8sQ7eWzGVLJEUeqQnuAObhU6D/MX2itJ5MPFw4XB4pJSVtHP0GIcdZldOCUwStt6gyldqDJNhm9PMuT+xJMSgP6cO6jT19KfbzDwOWo/4ACGq5qHmAsN64aiQnQ4qwFNaKRbJ/r14eH/KrtjVng+aW0P1rehNSdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K3T98cgw; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K3T98cgw"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5675dec99so124425785a.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Mar 2025 05:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743078971; x=1743683771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4O0U49JEOZzFz31rilD+fLgFi6gQ4U1sxc5Dos5QBcs=;
        b=K3T98cgwjYshZyFiYTZvdHS/JOtk7x6uVuJaQ+X22q5QcUbJkyl28/1TJb2fdrhkZh
         WEm592C2Xw79GvHqOvihgykM6xsQNsONgI8mwNORmTkzWRNSmVtBmBKFumunsBXbdLPl
         5r17Msa9GqFo1mQbWWStdQx+L2rkymHG/lNGBTCLc1wnPCR/Syds23pZeW7A42e4pLFx
         3BdjqWepVIWdEiDHKZKI2M9LSKfFaoE/Kid/UpUSs8hXz6+CCOy3BIzjkzxGOZ8ZTKzx
         rCLdnkG/In20crUszoqMWXohIrvxk1f2jl7LlhrxXBnPBl1RZWRRduDUc8CrQxD+TuY/
         y3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743078971; x=1743683771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O0U49JEOZzFz31rilD+fLgFi6gQ4U1sxc5Dos5QBcs=;
        b=s110Pqj26QtFHsZBfrmxMHXjhH9CNClB2VpVen+veUGbEc0JzhfGU7J+sLpyQVXcHb
         F8t9gkHA1cGyH1gjksCSHluJxK8V9fcsWxIdu7w0e71dAYVOp9+ElXanHbljwMScacm5
         Na6BIuOFSO3AMcaTidIAMhUgTg6L42gqrAOYmKUjRr07nozBXbon8jizi7uEC22OyTtd
         sYUdVZWC87pOdMnKdIShXhFQHFa4CT85NCIIPIVI+1rpIzx1W1HxILP8FAaLiMqyK83I
         USJlQZFkGZ73f4ytP5NvgG9av3QdqBmlI6yeWqCqw4jI3zrx+ehts8vrWIGcZ0KQmtE2
         rkxg==
X-Forwarded-Encrypted: i=1; AJvYcCVeJsNjEP3wsvrNsYoVerorjoaQHIY+FoGSATHYR2VlVS2UOjHUvpDxbZV35xF5T6yv8wqzOSujsQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijOfz5n8HUrLyDNSgJ9Zhzyfr3nAZFZWoqG4gu+2Q7Aqr+oXq
	zz3EJg/dB8b9umdBH6Ft50R3I4zzjBqX6/dhPdsFH2Z3BY5RfrstQDbHhnDEVBEpGHNxxgvK+ob
	ckrkDLA==
X-Gm-Gg: ASbGncuLyui0zrfai8xQ6eXtapqwBlndooDQjkXybYEUwLAqdZcSGFBDWBrrw87F2H5
	MWI38sAvEt4mhfjuCDHHGOyZyik56TnI4Nu3h9LvfCvrvHF3McP5lEchqZD3QWc8rMEj8RE8bS0
	D+PtNsTacomDiiAyTnwE/Nf9Jf7prCGKREJuhj7GHhZqOsQTwoRtpTzo7KFoBn5Qpal0I8KYZN5
	OgmvGwDbVxUE6UWdkRWCunee5tB+65UKuWW6Wz6G6b5nVdW0rpRxKgagnvRDfAN9yo/snFFwUqe
	ISqhcSLjMoaF//NeQ2xc4FqoRyGHFbi0srKCqji3c2MClRurOcRlHsx+
X-Google-Smtp-Source: AGHT+IHgH7h+/jzCsHJSxh1nrW64ZEAq4kmAS0kbFIKO3a5YvmbjvWJD9VOcK3QJ5Pn+QCwg2Z3+qA==
X-Received: by 2002:a05:6214:d03:b0:6e5:a0fc:f663 with SMTP id 6a1803df08f44-6ed236e14b7mr42870076d6.0.1743078970667;
        Thu, 27 Mar 2025 05:36:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([207.164.135.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc5bbesm79616526d6.88.2025.03.27.05.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:36:10 -0700 (PDT)
Date: Thu, 27 Mar 2025 08:36:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z-VGN79KVjuRg41K@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <20250313165539.000001f4@huawei.com>
 <Z+Ubvvrj9DovVs71@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+Ubvvrj9DovVs71@phytium.com.cn>

On Thu, Mar 27, 2025 at 05:34:54PM +0800, Yuquan Wang wrote:
> 
> In the future, srat.c would add one seperate NUMA node for each
> Generic Port in SRAT.
> 
> System firmware should know the performance characteristics between
> CPU/GI to the GP, and the static HMAT should include this coordinate.
> 
> Is my understanding right?
> 
> 

HMAT is static configuration data.  A GI/GP might not have its
performance data known until the device is added.  In this case, the
HMAT may only contain generic (inaccurate) information - or more likely
just nothing.  It's up to the platform vendor.

~Gregory

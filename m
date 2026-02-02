Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA82D061B
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038125; cv=none; b=gCz43URCZTrshVLKAR/3rrZZKeZb4eXIQF8m/9Xm6SP/f7QbLz0svthpPTdc+C3TY1Er3r1duKbztGz5xLD2rl6TfJh//TYHxdnN+Mp9LoHXXB7q0wXHIRVbCNO5qcM+rpFNs6L7eHVKITHpazPFYN66toC38LgMaCjbyLsHJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038125; c=relaxed/simple;
	bh=JhOq8lMhkt76RC4YjwgHGWpQJUoGivQLESVoPbZevMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aELbmbCVd3KTA63m2nxwsXDvdAjCMRG2t5Z71u+m/T1KN4oxUJjcTrR30lhZd0WUedYjmTEinCbl0ew0LSi+zv4hlbzpPoK4/qRe3SRHkbldBdbydI3DBFc2aCcWnXkuJwdGWaR2BVy9ZbwG0Y13kOxWW7OvxM6o4xvGTWbN45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I42uH7MJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I42uH7MJ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d2670932so4081108f8f.2
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 05:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770038122; x=1770642922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQ9VPANLPV2MRMw4JagXV3bIpuMJZSsxWz7UV26Ck/w=;
        b=I42uH7MJLODdZr1EEoePEGGBJzZyCFeOsrfYd1QbcliBoqrZ3E1TduqzLlVBaorB8C
         WRHjmGJ551f8lyLKi1uqKWCg2X/ZVIxTyHhUeOp5bQVtyYyBjr4udiENOTB17y8gRe7g
         gVCzCYLMbktD3XAntUfuugg5axDTupSsry5q7bItPKbERMnIuQgjelMam8FY1a1z5n4v
         jzda1hKjZxna0QXeF9H4gdYpDZqbHDv7OcP/PdYc9jkdhXYxW5yv6zZ5UETFdOSnjrDn
         qdqQWYfshyyJptokuaFduvFw3lbaVr5c9w4h5FchO0EcZZH5MgBAcuhjElyKSe5qVvSu
         gbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770038122; x=1770642922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQ9VPANLPV2MRMw4JagXV3bIpuMJZSsxWz7UV26Ck/w=;
        b=qvyWI9yIUBCCgC1vDQgmKzodKI5P9akXEUDIcoY6eJaIHGeM6bhqBOoegjo0xxjnMW
         dzW1i8qssUxPX3yC8r0zvdfwQ8SjQzkTc6nMOGJE7ExFg4ruzs6VkF5NQzR5YNx3eLFb
         KtFQIRMmP7GSryKDHRA2Ph8pvS83ipe9a2je95DUBHlQuwZD7KfS8qaUBlk1mQn5wb4M
         91xtFAj6R1IeWinQjK9lej0bLLywFWL56gQEhIEIXDthswXYOe4k+xHM+3o/m9vCmXqe
         lHNDxj/K5zCM8UCh0qZ7ZH5YlJWY+8wGTwvm6okN3ynKAXBiiECERJVzFWmoPhjQCG09
         PO+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIcaY3anKUZlJ2qw5ZuEaR4OPupa+J7pdibuEmqYSZTcu50e1RREcuxURKTZjuuER5oJrAr6ZIvfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvANh+EmtNunXq4B55CscaA+UI8ukXfiF6WwVpoFTFDi0XfwB7
	7mlY2mCMRPQEGI6SFzE/C2QwIfU2oHOjD5Z6d2YMmNkVrinim0yK1r7ZDt6DQZ5RxAY=
X-Gm-Gg: AZuq6aKq3EzAFli2xcYf+F8FxmH4CnhU9/yopveIAwsKSILO2yfcC+3zCktP7iCV5Kd
	2dx1sb5Qq9Ks40uNVOmfL8q4OPukz4mPPTLdw3K0iL469awICh274iEFAlfq+iOVw+8i1ui/IHj
	nwdftwgHIePgwj/5v+JHFiIQE0DcG+iS1rJLpwcP58Z/uK/j3aArjscGFUWxuTbprZPnqPFP7ZP
	d+lba3NjOQHk1rHkQSpXUS3NJ7zKels5r0kGEVTpc0k0w+RzQdWbBfA4Af9hI8F6K7Cq8PM3kGE
	Vxs06gH/7O5uRz6/kf/KdpetZ+3s+pOjPu8jcxrd0S4RhWx1Ma29VoK0Rw1zzRGA1dabkIlahV+
	/Ij+G+hQoKlIADt2SoBxd7IcQ6qCIXZpgHrnMXWN4/7dgGFa+AVgCURyAeKXZVcPBylvzomYdao
	FAoEzY2iNY4tQZ+FJP0e0m8h1l
X-Received: by 2002:a05:6000:40c9:b0:431:35a:4a8f with SMTP id ffacd0b85a97d-435f3aaf7d9mr16391654f8f.47.1770038122563;
        Mon, 02 Feb 2026 05:15:22 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1323770sm45183583f8f.32.2026.02.02.05.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:15:22 -0800 (PST)
Date: Mon, 2 Feb 2026 14:15:21 +0100
From: Michal Hocko <mhocko@suse.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
	david@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ziy@nvidia.com, matthew.brost@intel.com,
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	bingjiao@google.com, jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aYCjaVJZLijzk9oe@tiehlicka>
References: <CAC5umygEq6xvpDFnVnDLYLyqJV7qChEsJ_+W-KCBJ+EXj1948g@mail.gmail.com>
 <20260127220003.3993576-1-joshua.hahnjy@gmail.com>
 <CAC5umyhqbW_qXaApO8OGg1wo706GfVPuak5JwdBfBgS751Ka5Q@mail.gmail.com>
 <aYCiboGiXO2lQC0W@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYCiboGiXO2lQC0W@tiehlicka>

Btw. collecting /proc/vmstat during this test could give you a better
insight into what is going on. Especially reclaim stats (pgscan*,
pgsteal*, pgdemote*, workingset*).
-- 
Michal Hocko
SUSE Labs

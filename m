Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6001B142D
	for <linux-cxl@vger.kernel.org>; Mon, 16 Mar 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669720; cv=none; b=g5itn1Bq7pNsnX3nHLD/Kyk7NZPxe6NO92ZwimuHF5gDLH+8yaGNl+/znrF6byYOqKqyH7NBGB0q9GD7VJChObPlU4UXrp9868YYOmgy9JYqsKBSbFKzP5mSqsJjiZoA4g9x7k3yojiWLZrB94KrcRnR/9lQvWJnM07pqGu50ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669720; c=relaxed/simple;
	bh=RBM26SleLoImkQFctLKrxZrqSVoHeEwbowVbfs5flak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3fj+nB/JadqcHnT9TtPmqgTrlTgnZgFJfLOu/CQBp5/8hbquH09b0Xht8AAJLGBLl/tZhLsutDeai2aqCioFszo/DojnCIeP+97xmla7b91sj7c7rX7fDrH3zvLgk5ZXZPj0uZu26IsQ5GKIYewzyAPKhLt+HoAsd+Y5XbikoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qjujnXFJ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qjujnXFJ"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d743ba241aso2408654a34.1
        for <linux-cxl@vger.kernel.org>; Mon, 16 Mar 2026 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773669718; x=1774274518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MtZYwSZiRvxHQC40LhvHohiVgnWOPcD9n8S8sVX1biU=;
        b=qjujnXFJSw1mt/sXu4uMlDl1DnSV/F7Q4irTyRPvOYl9pnA5MPYEzi46jY7gc+zvgu
         XZ5hxVbKZa5fKOm/41x+3s7EqPiNOwBQEA/5kZJem6imHJhao8qeBLW4o1jNqZhWWGRg
         gA7M7mmyfvsO3pkgidx/NBZyE3jV3dGLoSzIVJrdOi+pJBSyfz1Jgi/j4MQiIDTkWuXs
         IUpQcLljrkMT7HTLwGFmpGuyECNh7Oojg4IBkngnOKxv6MmWguUCVRW7CjnubHbEVF00
         UNzFf6fB60D9lgpIs9Y6V9cALLlONZBSCyLPUeXd8OQYfid8qQ8lej3Nrhvt6Krh9B4o
         3Nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669718; x=1774274518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtZYwSZiRvxHQC40LhvHohiVgnWOPcD9n8S8sVX1biU=;
        b=sipAm4y4Nx7vbyJeMLnCgMoHwRVcrIUTrvcuoyWJzqYhocR3PG0ZrI2QQlFnkYOeVd
         jL/X2IkxKw9jmqg2PPsWkeWuy1aE1NmalU9swVV4X1xxIB2I148TklGiiaW1mGSHy/5/
         iWyxd/ECSVcdT327fT/90NsBQiLtU9YpRtKACTyIHt2XfrMFQx89Y+lWQpqSKdvuZ7Vv
         4DBntNAJtj2Z1ZFkH5v/mrkxKy1Bw228Zx9WLOBtPQN9KnNoLmPjlCVpus0LjOHwWAHZ
         O2Rt5iwUm3HD91rfmJDwTPAhrrJQRmdSuJLaEp4mz9TnQenhXsc1y3z1aZbjAGQmxXqv
         RJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzcT1p7yf2Hk4qR7e8YHi7dFMv4/fWySJA+Iec5LhDWTsRvKmcBNSRtKfQVfx/Z3SDkXSlk/HldoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOBHLgIT9IUh+ZsegNzzLzjbkMW5ogQwdyvV2rA6PROKZuHnT
	Uhsj25tDH/6K17t8xx+PEDeVMKIZQeepnK8IYsV/BcufG+9Lkr4awwnKNJ5Lxyz5Odw=
X-Gm-Gg: ATEYQzwiZTnQfc552w/lAtxiEzViWkL5vDbKK2RvfRpfsQZBdrRqrzFaO6mDVpnQfFi
	mttL8lphuLGjhSagSDn8w0MwtN+Ld9022YkqERxHiPPL/S9Y+fVURRGayRwLPeMcRNfBH2+83OW
	nLF8Oc6VKg9FF+weA3PbJhIHTzS7LXdW7JI945S4hqIu/BhL7751rmdimGZVRCbBEWP/rer1hx6
	9KgBc6ZA3DehglqlsuB3YZXhQlEowo9uCT6+UVGes4nBaZL/SFN37WqKeVn/y27fck32zDi8jIC
	jOVX3byc2kuLB/OeUD6zQSMXSpxDrj0sjsHUPzV7bo0CZNtd0KR8en4N+HNZmDTXAR67yjlVN60
	MSj13zCzVRJRrsChRyfSpUSd3eWnSZbISwz9v/Lg3xwGEDvkAW8MTcG8hN+va6AJrKXaov9PoJ7
	Zsk+f6cDZvPAymz9oUdEmn1TSFba6aWf86BKZD8V9GnJfDhfKqXdnsIUiARWVo0ZnEFXyxu58fr
	UWk/slaVw==
X-Received: by 2002:a05:6830:6503:b0:7d7:4b65:e8d2 with SMTP id 46e09a7af769-7d78243bcc4mr8723153a34.1.1773669712512;
        Mon, 16 Mar 2026 07:01:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beeb7dsm134438116d6.19.2026.03.16.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:01:50 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:01:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce
 socket-aware weighted interleave
Message-ID: <abgNTMDM5xhRsWFU@gourry-fedora-PF4VCD3F>
References: <20260316051258.246-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316051258.246-1-rakie.kim@sk.com>

On Mon, Mar 16, 2026 at 02:12:48PM +0900, Rakie Kim wrote:
> This patch series is an RFC to propose and discuss the overall design
> and concept of a socket-aware weighted interleave mechanism. As there
> are areas requiring further refinement, the primary goal at this stage
> is to gather feedback on the architectural approach rather than focusing
> on fine-grained implementation details.
> 

I gave this a brief browse this morning, and I rather like this
approach, more-so than the original proposals for socket-awareness
that encoded the weights in a 2-dimensional array.

I think this would be a great discussion at LSF, and I wonder if
something like memory-package could be used for more purposes than just
weighted interleave.

~Gregory

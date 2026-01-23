Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366B2C0F6D
	for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128461; cv=none; b=BXCLEb9yHz5A85N0tKZbzQZVNzB1UGQ82wUHymazOTCBhy8G8peEkt2KAp7pCAPXuV7oThvl5wir2fLPywd+6vGWN6+CpKINgQoQB63toY21bnpja5bKg0Pz3FMFesk9I0liKpmnSxNH8y46xCP096MaFK/y4Mu+R2LSzBar2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128461; c=relaxed/simple;
	bh=ksTMqewe9wJeVkWUQ6teggTVZqK1udNl0Tl8ePWbE3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0toL6TPDqgbqCCSLZ3St+GgDrlP/WS9txEn7YfUu93d87veazJsOzpfRQieQ7OMYGivz3UtlLGUtPMbN0+8/6cZWKNRQ9EZMxsfRol/r6CRYJEL3SS0cr8F7ZMmUf4UW3FkNAmNkjYyPJ7IaBqh8PTZprG1fnt91Zj3bIz/SMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LAD+KmXa; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LAD+KmXa"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-894723da7dfso26977646d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769128453; x=1769733253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asBGl1upDPy9EBtcWnpVXAcR6hW540Iv+SjDFfHMW0w=;
        b=LAD+KmXaQh6rB+1Krguj+ggwo3qTVf3RXV4ObCa3YthtNpWRX8O98TaQkTCTMWCGOq
         iIaK+2nRWXO5NkyrzMcatolxCudZ1JyYf8pnSIB0e78AfLWVzweTAw00UPvGmBe3Ot7H
         b0q9OCpphZJdIKVWHsBDJsM2dIvezu5Qiko9UXaHoL0D/PRzbo+fiuO3fuqvnPcVdBXp
         jw1ELWV7Cc6twpT/PScO++dGDevJgSFfdqcxMpFP0/F0FMEANIRKcIohZOqAPPQZwf9Y
         oYKW9R/5k14HFppShwW04VtVA8tDjQ5lguY1KkleSJjcRfmE3p+fvsM947WQdDzMTfNk
         Ye/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769128453; x=1769733253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asBGl1upDPy9EBtcWnpVXAcR6hW540Iv+SjDFfHMW0w=;
        b=fJvNp/fPiCiT++bFqiQQ8z6AdrNL242YW0td4o0NacWdrxDqTRLtgOj/gOYysjDx/q
         RdHEw6GzIs0b1l/2lpiZhqf093gpV289AK1iV1jQxeIAXvLx/dbOcwcVC7tZkGeM51qg
         +OD/BFM92GjCdUKw/5ZT4MzjsirHcKyqhEG+KmYtx2wdZ/jGaedC5wl6HdJfKnUF6hbn
         odiTZzx9rtRgIB6WIq7r85qh2Uj4MpO9NlIbkSoLnRax3XQehpN3HAcPpnMRxFu3S9T8
         YIU6aWsy1TmuMahv3rwWjHi+pF2fbMxJ/zH2Pg404JxPjEhgGD1ORxgPlX29vVIdz06Q
         qqow==
X-Forwarded-Encrypted: i=1; AJvYcCXPUyE4QdfVqWwot2+M+021DZCXE0Qfz0wQyL3JfUrRvrZI1gg8TU8f+iynqnpPq1pD+5iquQDzG0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsmxKy37eiduAcGToH7Ci/b3zNKT/8cIcAZIjucMTFwk3NFa8L
	ncBUSPd6/QM4Em8JswAn2R5Z+g9VldD4/W2EjdCKAG1d4TqA1f7lXvzQSIHiNvoEowA=
X-Gm-Gg: AZuq6aK38/xS1Kn8t15P1nDmT2juuPrkr2q2AU9g+LNQKbWTb00BoqnIF6wqE4OA3YD
	zryhMPnkG+ceGFoZ4Ob3hSKf+voQP55w7rfVLjuIYwlmWi/kFFPGbzY99lI5K+uEdWbWKB88FsA
	dC4zRyfZ4HbxZ+hj69/TDBv5P+O7rywuIDOLwxkmo7LgaEeGpN+AFvK6VqjKTheX1nKKHmRuTM8
	mHwwk6hGB4l63h/78KmcezAVXKgVTQbz855Wn0J7j8+WsA8pSbZ39egUrlJex9Rmr6zzHkh7gFO
	70rb9MSORUY6ggCz6FB8HnrZ9atb62B+bgfaW1ZYEEi1JOZ9GEmr7NwyxFXnyXDt5iuodCnrmh3
	SDd7nRZuneyxsxONcZ6aZKwpnoQgnEqFE6bOYPMBINmAaVACyRqjynNROk/7kW7xVgEWLhBbiQ9
	dqWK1kZ3ogKnq6S98+7nD4jSjfssR1OARQomrVnVQSTh7r8VeQUbwoiFKihTLeTKKTQ31XpQ==
X-Received: by 2002:a05:620a:29c7:b0:8a1:b5ab:bbd6 with SMTP id af79cd13be357-8c6e2e369f0mr170716185a.71.1769128453428;
        Thu, 22 Jan 2026 16:34:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c71f8sm54022985a.5.2026.01.22.16.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:34:12 -0800 (PST)
Date: Thu, 22 Jan 2026 19:34:10 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 3/8] mm/memory_hotplug: add APIs for explicit online type
 control
Message-ID: <aXLCAtwMkSMH3DNj@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-4-gourry@gourry.net>
 <b3d435d2-643f-4dad-9928-bc7fb5080181@kernel.org>
 <aWfR86RIKEvyZsh6@gourry-fedora-PF4VCD3F>
 <4520e7b0-8218-404d-8ede-e62d95c50825@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4520e7b0-8218-404d-8ede-e62d95c50825@kernel.org>

On Thu, Jan 22, 2026 at 11:41:24PM +0100, David Hildenbrand (Red Hat) wrote:
> 
> Right, but I don't want any other OOT kernel module to be able to make use
> of add_memory_driver_managed() to do arbitrary things, because we don't know
> if it's really user space setting the policy for that memory then.
> 

Ah, this was lost on me.

> So either restrict add_memory_driver_managed() to kmem+virtio_mem
> completely, or add another variant that will be kmem-only (or however that
> dax/cxl module is called).

unclear to me how to restrict a function to specific drivers, but i can
add add_and_online_memory_driver_managed() trivially so no big issue.

You'd be ok with with this?

add_and_online_memory_driver_managed(..., online_type) {
   ... existing add_memory_driver_managed() code ...
}

add_memory_driver_managed(...) {
   add_and_online_memory_driver_managed(..., mhp_get_default_policy());
}

~Gregory

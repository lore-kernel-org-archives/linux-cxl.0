Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D731E2858
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123543; cv=none; b=h+AQO35Mwig/Bs3f7hc1xh3KcZvSJOLs1sOVK1DqPFzpGWUfrsXl9bndwaCERAXcqRNn9PvyRTCRRmyu6iEnsb/mx/Yh8e9+dilZUZfMNvNkLIiuSIlQI/qf/XaSGqAdtA7IDftQ1EwbIN4mNuo6FFlvjfNTSFenfs8OhD2+c5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123543; c=relaxed/simple;
	bh=KrI/Yd2mD+gi3CKMiXn0mm9c5di5XADjJBmfWz8fca4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4fdxM+jX5kGkpwoC1/PkHVNlL3X+1+J7ikXd8ul8Nf8/pUidxHjmlzco389gZ/4IHIbthnMfp9gt7BvAAlKKy2kVr8qvvgP44UAhmn2ak3cT+aULHfEpskKOnTWPNcTFf23BJIJI6PCEgirp/lAaNJNEhBNffrfkjWdrQlPMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=C1LQlkkK; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="C1LQlkkK"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c55500d08cso532197585a.0
        for <linux-cxl@vger.kernel.org>; Tue, 08 Apr 2025 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744123541; x=1744728341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXhtl/J93/flobwWnEYYmzPTVSjnG16U4TGmrJDFslk=;
        b=C1LQlkkKm1RvwXzs9UJp3PkqPmnnNT3oJmATTyUL8H7eBCWR/QIqalu/80qBjJmqD+
         Zr+ArfQ66a26hV2foml9rcTJgbmV08L7Q47aaJI3yodz5j8cu8oCycUJmHpyNNWAc5CJ
         8qKJipcIx8QLPu5l6i/pPFJugc1njqVbFc1Pchfwpvky5yaKnct/QrDjouTDIVbRWII9
         ZT5djn1X52n0rTRrvNNL/Wnwfs3AffGWTPKV7wXcPI7kvaEnT8lJYIxadEv3j8g0EXaJ
         G8KDiwSN1VKUBAKZCmV0kG6AGC7sitYD8Y90C3GUA9ONB6+8zhKQpoj9fm9hGWQcdJVx
         nlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744123541; x=1744728341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXhtl/J93/flobwWnEYYmzPTVSjnG16U4TGmrJDFslk=;
        b=dcCVxQvkuukkJ9WzKq+lIqH78d1qX9jP+6cia+aVx2YPfFU4FgIHEK1zdqGiFOaAm6
         XFgsFxSSxYkefGT6W/vQsIBWz/k+ejIPUS11DPVDk0scWSE4/OG7dg4mcTbjQJ1H2qjW
         9EHHuFVAIzqpDc38eTF40fU6LoqVg3e3yr62EmA94idaro/tID6MilusKYafzPkGvCOI
         coKYsuqu1vv/xBfVcqKP4i2iLfNJkYkWe2YBxjnP21ibnhZf3eV4uK985mpN6ZwXiATu
         MI804XFdqhJZMd3g4IEswsgdwCS84vD9ylkNWTySEBZE0U7BdF/94x/8pmZddF5Eais1
         a1pg==
X-Forwarded-Encrypted: i=1; AJvYcCVffRKM/vxL8hVELJFWEeltQBfOv3Quln0RgTuLIhZ43SktD7VvPjLlZQFSPgnwiwHn9eJPUJ7F8Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj2q36iBv+oPqAgDyQ3vguiwV7yInOEC4gmOpZLi2XY9GikFDf
	qx9ubIn1kInWSWqEhvLR8mq3owxh1jZrKKz235WUkeY8ySB87C5o2cHvyYDIXhE=
X-Gm-Gg: ASbGncvaWTXcDHQs/frWTCEFs6DiRs9T2VYmwJKuoDk6cmkRzue18JPfFuwoVi84ATd
	qFx7ca42y4QFBN9upS+ZwGE3cxPjYj8+S9FjMFkVVdAYPH/UF4V3fny3GaJq9e9GjGTkAbcy5BS
	axn3o2byZXEATkdf/JKYQ0Ij7uCcI2Vy6isPqD+GQHy+7NhxyCwPjCNcbtStAuyJq/Zdpx4TD//
	Iuaj09Z2JiVX1JNLOPOKkJ9c/YuZY2P6WFYEt+TAOX8vlnrX7EkircA1x8vXs07CY/8HcGmtwwd
	R0TVnGZIqbjJg4LQWUALfZUzUW6JiH3FYgDVpOFe2ihBE19IXfUj5SQfxaCv0x+Whe+2eJziDMI
	ii2LifmPeTASsJnMRpmFyBEboeF4HI4TADgc3jg==
X-Google-Smtp-Source: AGHT+IELkfwSMv11q7mhNQ04DdBgUD6jbBVI+gQh4UyK0hWVyKNA9oi119Et85nPhE76OzCqXdS9nA==
X-Received: by 2002:a05:620a:c4d:b0:7c5:4c6d:7f95 with SMTP id af79cd13be357-7c77dddd504mr1963810685a.48.1744123540676;
        Tue, 08 Apr 2025 07:45:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76eab1667sm763544785a.117.2025.04.08.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:45:40 -0700 (PDT)
Date: Tue, 8 Apr 2025 10:45:38 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, osalvador@suse.de,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z_U2km48N_i-6gPq@gourry-fedora-PF4VCD3F>
References: <20250408073243.488-1-rakie.kim@sk.com>
 <20250408073243.488-4-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408073243.488-4-rakie.kim@sk.com>

On Tue, Apr 08, 2025 at 04:32:42PM +0900, Rakie Kim wrote:
> The weighted interleave policy distributes page allocations across multiple
> NUMA nodes based on their performance weight, thereby improving memory
> bandwidth utilization. The weight values for each node are configured
> through sysfs.
> 
> Previously, sysfs entries for configuring weighted interleave were created
> for all possible nodes (N_POSSIBLE) at initialization, including nodes that
> might not have memory. However, not all nodes in N_POSSIBLE are usable at
> runtime, as some may remain memoryless or offline.
> This led to sysfs entries being created for unusable nodes, causing
> potential misconfiguration issues.
> 
> To address this issue, this patch modifies the sysfs creation logic to:
> 1) Limit sysfs entries to nodes that are online and have memory, avoiding
>    the creation of sysfs entries for nodes that cannot be used.
> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>    based on whether a node transitions into or out of the N_MEMORY state.
> 
> Additionally, the patch ensures that sysfs attributes are properly managed
> when nodes go offline, preventing stale or redundant entries from persisting
> in the system.
> 
> By making these changes, the weighted interleave policy now manages its
> sysfs entries more efficiently, ensuring that only relevant nodes are
> considered for interleaving, and dynamically adapting to memory hotplug
> events.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Gregory Price <gourry@gourry.net>


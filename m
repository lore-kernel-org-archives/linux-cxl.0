Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D77D07D
	for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566159; cv=none; b=ZBW+3s2KZJlbjFQRa9N9gRA3S49OIOJ0JXcR8xCm1kHgwuufotaLkUea/hwedNrHtx/2eqQd8nOwU0T3FDuJ52FywwAtg9HaDZILWEQJAXidbIq0VvY6jxb6dutk3EuEzIAfQl5WJrNkRo2ywv+ntd2Z6ceYJX/yTMmP+iZB5mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566159; c=relaxed/simple;
	bh=CZKwgwIIXJK5jYXBnZ/QYDErx6q9q+UM57HllJCNgIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2Pb3HFuR2b3IlVS4cnBlyWr6tJ4W+aSLb9XaptAa68GHstIsfsJs8ebJAJE+/QgGpQbrfvj5pIuIe8U+YaKHgWdDupzcPdGlGGElJivd48Jd6HC8m/MaMscBAx6cF155/+N8hR1kh+F54awKaBwjOzEozA4bPDiT8i4B3m3+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Bn1/FXCL; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Bn1/FXCL"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c53b9d66fdso267652885a.3
        for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742566155; x=1743170955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+nhgTbLeJKhDFnNTQysneSWHNY3+PqAlhMu5LglW/M=;
        b=Bn1/FXCLuTYk901fwQCPcEGDnJRDDlsRs35vV9xZqVfW5csR8bjZA0iyqeLGBfWNa8
         Tu9iDR0B0ymso4BDupJKSUpb/LzcqX2Yd5dE0UUrpusvkZrSmI7ndPX3H89cf3nFaMOZ
         cpZP+Hc7BQDhiliD6O9HJiIQihtvjA8Bzy5pnwOlVgV63B8TA35UVKVhLWjGqEc/8BVq
         EQL2yGbBphWGh3PliDxquMmGdMZLeLXNZDMx0kGN2Gt84IfYz0dtJkDm5GhZVcVtpr2K
         UyE9LwUIfYaVe3dpZdSGvdS31EnPre8nltUYvNeYmdVz9VTvqRuRo/C2C1r+8Eh0e48H
         KuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566155; x=1743170955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+nhgTbLeJKhDFnNTQysneSWHNY3+PqAlhMu5LglW/M=;
        b=hIbHpUe5qw3zvmaXVyhIusnH2+bDM+rOJjl4oVqDOUtjlN6Gow9sgr3MKvgh5bKBn+
         Uxc4Aikqa7tBPn9/EEUgaP1Tv2hzYt2CP1MdrN71a1JZmxtsgvqprCFUf2elKtiWPwwq
         VsfWSWYZn3/b30PcQpLlY5O0RNHdHyuv1L585TJIGRo3Pzti+sIsMCyOP/G3J918EsP6
         RcmkzoOpO+WRERLaBu9/fBHWbxONTLwX50sG4mawoFYlpX8Qqnv4jJwU5+78UmlSxC7L
         msNYKYbblWDlp8RqtLwjjznR7z+cMSeBjI17CNBYjVxEtwCIAtPiOQ0MYpDUAPM0EeQD
         dSHw==
X-Forwarded-Encrypted: i=1; AJvYcCXp6aDEzNSf8bIY1vp/rIW+fzPRFIh9dAXwMuDc+3xqqyBlN/+5oZlGT1kYngCjpQCFMqEq++C5SjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2WCvnUgqeqPpU0EC7lTRZYqdwf0BYdwcM6tFQOxzqDq0pCFJx
	frHc3iG8Tf4hfhVQdAogkrCYXHgpz7Z/KvSu6nle9KzZ4TQQeMMjLv7dTr8W4ek=
X-Gm-Gg: ASbGncuGutB/C8byCoftp2U6+I9NqNSb26GOloJuQu/7kM2cmaIpZ6H7esJb44dvrqQ
	RoOd7/h6l22800s+/GBR3sYBqKIS7duo3rB5aIGb4PV2fCdRuWVfzJYZwwU22NoCbnD+3Nn6VzG
	odnYVmivBCLQhhPtTQDhdaKISZ/45KZeFp7WNCAN8diL3B4FqfmE5ySdd1L6luYMe0S4DjNfoa/
	1n5kLpl4ZBhFfitznjXHVQrgZNp5q1nDvm5s7bOAXGwCp5QLWC+Lyt+x0LgXxv2H5WA/X9H/6PL
	8HUoKjBrDRKdzwGRy9e2P78hlc/tmf91f2pB/WBded7Yv8eFDGKOMOMB2k7a1jrnrB9pxMF/Ojs
	LwHlttdQlRw3kk6TGuDMxb0S9QxE=
X-Google-Smtp-Source: AGHT+IHYL5PtE1l5A53doJXJiyZ0pMLxq3g63BRJBYsQxz2bFKxwUqG2PxozWwwqOpZAZvNY+68OCw==
X-Received: by 2002:a05:620a:2727:b0:7c5:3c0a:ab77 with SMTP id af79cd13be357-7c5ba1337f0mr490684885a.4.1742566155122;
        Fri, 21 Mar 2025 07:09:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93484d7sm134529085a.81.2025.03.21.07.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:09:14 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:09:12 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 2/3] mm/mempolicy: Support dynamic sysfs updates for
 weighted interleave
Message-ID: <Z91zCELAdts-l3Zp@gourry-fedora-PF4VCD3F>
References: <20250320041749.881-1-rakie.kim@sk.com>
 <20250320041749.881-3-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320041749.881-3-rakie.kim@sk.com>

On Thu, Mar 20, 2025 at 01:17:47PM +0900, Rakie Kim wrote:
> Previously, the weighted interleave sysfs structure was statically
> managed, preventing dynamic updates when nodes were added or removed.
> 
> This patch restructures the weighted interleave sysfs to support
> dynamic insertion and deletion. The sysfs that was part of
> the 'weighted_interleave_group' is now globally accessible,
> allowing external access to that sysfs.
> 
> With this change, sysfs management for weighted interleave is
> more flexible, supporting hotplug events and runtime updates
> more effectively.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

1 nit

> ---
>  mm/mempolicy.c | 70 ++++++++++++++++++++++----------------------------
>  1 file changed, 30 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 5950d5d5b85e..6c8843114afd 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3388,6 +3388,13 @@ struct iw_node_attr {
>  	int nid;
>  };
>  
> +struct sysfs_wi_group {
> +	struct kobject wi_kobj;
> +	struct iw_node_attr *nattrs[];
> +};
> +
> +static struct sysfs_wi_group *sgrp;
> +

sgrp -> wi_group?  Or something similar, sgrp is not very descriptive
for a global.

~Gregory

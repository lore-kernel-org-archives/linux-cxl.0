Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39A242D84
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722626; cv=none; b=Z9l6wh4sK+DUikf3de/l9KpwvVuchT6SMm/QBcdAy1/BUkp7B1NJZJajLMVwO1B6TN6SJq3IB8zG2O4/C7cFGr4jKw1LtJyHHpOU8pelJXT4ydgTlaXY3e0rarqmL8EKAqWkcLlnftb0mxFVPRpb397gpkGWgHVSACy89lTmz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722626; c=relaxed/simple;
	bh=EUT6xo+7c4fR9AjpRdk73GGw88Txx/5nWXpuxkERzDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdagBRoynu1IsUlQJ86TBsoZr1HM9eWG7UGgnsEWqjpzIJUilVPZ/c6l0IK/TII2f0wol2fXoke1WXJmhUT9W7jdu729a3KrLHYjjojEkBYEr+FfFVgSLI8wgf/0FOrJVhjNiKduVIzykJYOkl81c4VRx+vspxQ3bKGDjitxY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J4e8ehjd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="J4e8ehjd"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-930f618435cso70503985a.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784722622; x=1785327422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5mNAYCNl+PvzQVOY++arp3TkG6k570KzmUdhkjTUZ24=;
        b=J4e8ehjdkG8PhCbD4a9R5pp1+Yj6H7EkvNahqfwFzKS41ukJAzqr7cuep2PE/pBg9p
         l7+KsUyXNAbTuqZjbm6yToeKKtTWYFESilmqxJ3Qjigw1wlmK2G1kYo+iwgyMcSvr1/o
         YoI65CN0MFyy4DiF9b3jxFmRy9N6maeTA8HAIzh1jPILs0FPUlV5h4Ffaf/hxA3VmdnI
         oX1vZaMZ4sIo2eYIW1aSLaDFZ/LzKO3se+eV5cYlkYsMPIeqa4Zz0x6q86VRVXPjPua+
         q41JmadsIb7Oml+N56HtrVTAGdVOkxa4DXokMkBhx3N1yz/hobYgQJFJyBPkn3W3iLtZ
         4dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784722622; x=1785327422;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mNAYCNl+PvzQVOY++arp3TkG6k570KzmUdhkjTUZ24=;
        b=lGZuMe3cl1A54Zb2AlpA5cBEUVVnpOkN+fIYxdCjqFdZNS0zSDW6D2XjJ2/FWYahRt
         FOykLs7ENac+DdIxqlVRZ9T8mGLn9DhyY5Os5kQfcm/15SlgrtEraV7b5fLKWrL1lGhe
         9hrq/gcEqrszAI/QOO7fuSG0eExc1fjP7ixen5T1QcWK0hq2h7uvSybv46zNmkqV58Fm
         I3OOQEWi92BmFrk4FOes5ua3dNOh1leSugMfic0hI9U1EgwcuAqOgzwQ7pIoPx8V9aRO
         H/8chKefcA1We8uHrSaXUuyDQ3AHFXcsiMjX3AWcbJiZHny1kif9PE0teRSNL4jcPEk3
         39IQ==
X-Forwarded-Encrypted: i=1; AHgh+RolxxscF+WZg7nrL6DQsPgWVX+EuPyrCngp0SzehX1xY+gBMXZXUI6RxUhJByzK+wHbRj45ja7n4Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9t3s+XaaY+yxUqBlYkbkRVT8G7IuHlnlx5xeQvQ7ylUT7GOk
	rQVEx+Jswj9bUaq3k0lQxps/suK6cjfWo8iPs9DYbM67b4+2jpuD9DZSG1eYBPl1QRY=
X-Gm-Gg: AR+sD13X8GjHhLCLcH+k7AKrlRKqnN9nk45sP6lgj4ANXDLOnb9vdB5mYiMOqdW6OGu
	bgHwc0Xs5Ha4usW2KJ62HZ8L6VEroSaF68jPBlaxPwFJNAIEW2EwfLDtkZC4Tqm9ayUxrSH2Z6C
	0Akz3PhLfK5jXKhb3fXREpjnNJ3d9t8cYvCdxBDqF3CVUzSHSFQot4mPW6TOMSD1gZdEp/livRQ
	OzsHb9K1J6oRTHkfiaj5oSkAyWZoW0osUud/oYAYrYIYRiQ4uRR/Yjq13wpTC614IeHamLS+Cwo
	QP1vYbOMIvw3Qt8XNMwy5XE30QW6u2i4q3kkiCqtItLZTKbLeAeFg2fpHyjxlARJGN0ob4yx88U
	t7ryJWGtqmbW7rq1J7eZbGG2aogAoAgs0QdAIbJxhQgE3Bo4eBWK+YYwwI5yGBTUURCCKunaJ5z
	vEyaAEgWvJL+GJa6tWTvGZImPNvqo48O8TaNS15iRikD6V+JUFlGyvYmu3qw==
X-Received: by 2002:a05:620a:700a:b0:92e:72c4:152b with SMTP id af79cd13be357-930b43155bcmr2298496985a.71.1784722622381;
        Wed, 22 Jul 2026 05:17:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a03834sm149477885a.30.2026.07.22.05.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:17:01 -0700 (PDT)
Date: Wed, 22 Jul 2026 08:16:56 -0400
From: Gregory Price <gourry@gourry.net>
To: SJ Park <sj@kernel.org>
Cc: linux-mm@kvack.org, arun.george@samsung.com, balbirs@nvidia.com, 
	brendan.jackman@linux.dev, yuzenghui@huawei.com, apopple@nvidia.com, alucerop@amd.com, 
	matthew.brost@intel.com, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, 
	vishal.l.verma@intel.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	osandov@osandov.com, jannh@google.com, pfalcato@suse.de, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	lance.yang@linux.dev, usama.arif@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 14/36] mm/damon: skip private node memory in DAMON
 migration and pageout
Message-ID: <amCzmkdOr6AFv_kQ@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-15-gourry@gourry.net>
 <20260721234644.149401-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721234644.149401-1-sj@kernel.org>

On Tue, Jul 21, 2026 at 04:46:43PM -0700, SJ Park wrote:
> On Mon, 20 Jul 2026 15:34:08 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > DAMON operates on physical address ranges, which can cover private
> > node memory. Skip private-node folios in both DAMON's migration
> > and reclaim paths.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  mm/damon/paddr.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index e4f98d67461f5..c741a94319750 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/swap.h>
> >  #include <linux/memory-tiers.h>
> >  #include <linux/mm_inline.h>
> > +#include <linux/node_private.h>
> >  
> >  #include "../internal.h"
> >  #include "ops-common.h"
> > @@ -250,6 +251,10 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
> >  			continue;
> >  		}
> >  
> > +		/* private node memory is not reclaimable by default */
> > +		if (folio_is_private_node(folio))
> > +			goto put_folio;
> > +
> 
> "by default".  Does that mean it could be reclaimable in some situations?  If
> so, could we check if it is reclaimable?
> 

See the damon changes in:

https://lore.kernel.org/linux-mm/al-pkvmgIxGu3LzM@gourry-fedora-PF4VCD3F/T/#mfb99303c85dd9d4c3f58832dc28fc55583a7217a

> Also, what happens if we just try paging out the private node memory?  Will it
> simply fail?  Or, make some problems?
> 

user controls for MADV_ commands that affect private node folios would
skip those folios - exactly same as ZONE_DEVICE folios.

Which I'm not sure damon actually handles correctly presently (zone
device).  I remember looking around damon and thinking to myself "what
if this is a zone device page?" and not being able to find a satisfying
answer.

> >  		if (damos_pa_filter_out(s, folio))
> >  			goto put_folio;
> >  		else
> > @@ -344,6 +349,10 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
> >  		else
> >  			*sz_filter_passed += folio_size(folio) / addr_unit;
> >  
> > +		/* private nodes do not support migration by default */
> > +		if (folio_is_private_node(folio))
> > +			goto put_folio;
> > +
> 
> Same questions.
> 

Technically there is nothing in migration core to prevent migration
operations, it's done on a service basis - hotunplug, reclaim/demotion,
user numa (mbind, migrate/move_pages) etc.

Operations on private nodes/private node folioes are refused if the
capability bit is not set.

~Gregory

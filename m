Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401047DD76
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017960; cv=none; b=UGLhA47nhFTPpzoKr+v8FxBiB5OYGk82PYBYMWrGcpyIy/1KSggrbSjOSkZ4OmoZwZT84btwFFGMbVyDGUmWWvRje6KLI2Trq0Y9E2/nmyoFwppC/tBOHdlrQfsJ3GnCQ9liSCl6X5320/tu4rdi/eMDeQhS2WKEeqJmv7L+fPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017960; c=relaxed/simple;
	bh=0bY3+VnKsZDDkii4NqRrIp5qMNrkGIBYkCIcna1PA6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1e9ZMuEMA+RrWvFUrKRZ66wbXNtGLeXAb/lR6TaYhV2u/xFopoGWVTLv5cgF1J2BZeDTccFiA+tJfRGisNI3hIdA7GxAe8aOh8shj7IddXrJ0vQofNC7/MCMufMC4J3gHy5NcZ5nq1YD8zxVyU/NZISE0+nKn9SEzbnpyUZC+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SPIeTAfq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SPIeTAfq"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-915d17e2721so284241485a.3
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jun 2026 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781017952; x=1781622752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSHte4tw4Fe/hwOe0BydbVQDJ1bfJM9PJbtvHiFr8Bw=;
        b=SPIeTAfq/uVTl/qWnURHgq9vcM2ig2PCso96nfK+CWLcDp9CeWt9zpIcjt/7ZRItjv
         PYzMsTe7GwbPRNzwPXWnqKM5QzYM8fSP9nIZfjKs2jq9vn0W3XF4fZKRzos6e0H4K3oK
         8TS5794ywJKGemb4SgIr87Lb2mNB7ZmzFv/gROITpCWvzJRppDBxsT86OSDYMHXjSNO0
         aL48CnI69GtNAF6Z7KMOY5HdF/BwUiMPmFhbY8hxhWVUAfFJ/f/AcTjQTpQKXKr65AuF
         bHkV679q6101p+i3Jbkk9hSr3LNPI+8CKDGk3Na/uF5cWitQeBwWihsImNRsiLTwXlE2
         6qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781017952; x=1781622752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSHte4tw4Fe/hwOe0BydbVQDJ1bfJM9PJbtvHiFr8Bw=;
        b=Y+Hftt6a98yIjn1y+zjGwTJrFSl8pXamNXgMZ7bhGRNjVH1p54ZGL2Bl80HY0lpSfz
         q6N2anHxyRq/yjO82UaO2uIdcEdycU8qZhuIc0z5NBCII8u3UVhyWL2P+UUhO2wdvy1i
         6YdyIsqogI1Lj0CbVWHF0OWv98qNXys8ckl7ePw7OIdi+DHYPM6hD5BdAl9s5hf6GACr
         2G7l2OsInfWhAUTpEoaVLKvJfB+VHyyB1A9mpylA71Zui0VqMYqWKXsF5HSo4QDCWxxG
         XR2Z5v1KVtQKuKl4ic31DsSJ7ONfyJs9K5M+9QFckaOvxo4MtFKoaCulhzabae0lGidX
         i5Ew==
X-Forwarded-Encrypted: i=1; AFNElJ+J1MdgF2T9gnLiLPDMF7jCWYeCJ+4GnGya0aYXWhlb7GXLr9Qd81xNItCSIU5fWAFibzPZ3RCU6mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc68ebmjUuyFAyOYT92e4zhLOHPgpQy/5UEMBcJ/k/nw0KxrQJ
	sZfHGiFYHWvHsuXqwRLIpvY813Cn9B9U1L5B70BNY/+WefM1dzbDZhA/szxd00MoYfU=
X-Gm-Gg: Acq92OEQQxCv4nhLItN4W3EIXJN6vspCFOxk0mKnbl8tZyfLUq+mtsirECKCipdc/2m
	xPeklZ5QijPB9QhKx1rIKitK3Y2+Oz13EXSbJ+Sgv3IJtGAMVnWvI1YBMWqk8ajQ4X9JMmfbZy6
	lXXerY+PTKICn8VpbVjXUTZEJAH5+fXbZio9IGia2cTVRU4N0htrz3TMDdV5CVaPeu1gPEFAyJj
	Llq+D5Oj3LlYm7PjIP3JECRKzKGQsDLc3ZJwUmy5F985fnGrZnPoccQvAqzzrdNWPMQncphQWEo
	AB+cszMqFum7lbMnJkNkOanEicK1tjbyJ9lVGFUt/noMKulPxNOYnfVUIdETrvXoO3gwp2ILzwE
	eX+3tnQXXa8sGcD+F29cpCMdu/HdY7TXp5cY34kqgJFu2xSdgQWGcTtQY9/eonpocix+aTvDDK7
	quTXzH49LO/OfB99w7RTZGRCsrdR/3UrKJzB9j5MIlNWz8W6xdz7ZI38HUoX5dfvGH7q/Kx2Fpy
	QGj3azqa0B6weWBHg==
X-Received: by 2002:a05:620a:2587:b0:915:9c4b:fdae with SMTP id af79cd13be357-915a9cb2d33mr3324652285a.21.1781017952150;
        Tue, 09 Jun 2026 08:12:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a411333sm2261055685a.46.2026.06.09.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:12:31 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:12:29 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	linux-cxl@vger.kernel.org, linux-kselftest@vger.kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, osalvador@suse.de, shuah@kernel.org,
	alison.schofield@intel.com, Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com, apopple@nvidia.com
Subject: Re: [PATCH v4 4/9] mm/memory_hotplug: add
 __add_memory_driver_managed() with online_type arg
Message-ID: <aigtXQsFhJ4SB39t@gourry-fedora-PF4VCD3F>
References: <20260605211911.2160954-1-gourry@gourry.net>
 <20260605211911.2160954-5-gourry@gourry.net>
 <9361f783-5af4-4380-a901-8d330370491a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9361f783-5af4-4380-a901-8d330370491a@kernel.org>

On Tue, Jun 09, 2026 at 11:55:24AM +0200, David Hildenbrand (Arm) wrote:
> On 6/5/26 23:19, Gregory Price wrote:
> > 
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index f059025f8f8b..d3edeb80aadb 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -294,6 +294,9 @@ extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
> >  extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
> >  extern int add_memory_resource(int nid, struct resource *resource,
> >  			       mhp_t mhp_flags);
> > +int __add_memory_driver_managed(int nid, u64 start, u64 size,
> > +				const char *resource_name, mhp_t mhp_flags,
> > +				enum mmop online_type);
> 
> We prefer two-tab indent on second parameter line while touching code / adding
> new code.
> 
> Same applies to the other instances below.
> 

Will fix on next spin, thanks!

> 
> Apart from that (still) LGTM.
> 
> -- 
> Cheers,
> 
> David

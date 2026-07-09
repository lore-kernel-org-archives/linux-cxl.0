Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B983C37B4;
	Thu,  9 Jul 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581724; cv=none; b=junvx+sP3iShCg3yq0ad/T2hVls3JKFjTHx5wO+euoiBJnOeULDwHzNdCSp+udYihhTyZJvyWwU0DIOS0wtk+hyb+IfckrP5S9ZRbTxkb1jj+2KhrbOXoMWHtzGPXAC8xI9Nlw/QOz3Tb7XoySZxxAI2HZvly/IhTu5o5c5VpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581724; c=relaxed/simple;
	bh=XdLPiaXTE9EROlIVZX7sIHjVpUvY4acBOiBK8ieBWJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNXraXyCZ7zmB0qhklwEVogrC2nQBWkllqaWD9M6sn3cG+/uYaK17fk6fDj/gvjovrrh2ep5a0YuU/z7TdFj0rs8WXR/+7QIVXxWalmia7Lmf76uPf/tsa5+H2R6rBNTFw5C+nIqdTkaaR7+r5ZjrJUzKnw65s6NFX8g3PXn/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcPw5D7t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcPw5D7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998E31F000E9;
	Thu,  9 Jul 2026 07:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783581722;
	bh=1TbC2xsLYMroVwTX3dJX6SSqhg4Lb2dU31//uiqC8tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CcPw5D7tZiRCTZqCNDfMiZdBofeeC17gaHZ18dUQ4adurb8QLuzZulmYVOOgYFLF0
	 2nMD+aegCs4Hgi1AgTeppr12bCml6TaU8BzvF/yDbugPYLg599NECi1RdPqT4d3OBn
	 U/m3b2kx4hDqOZe6UKPR6gznQ8Pi/veoSumnkWJIRVaJ8Er1Mzo///TlKNSmMwywbw
	 ix3KfGIZzMEZY0AlmxVe80+aFJ56jQktGGgSPVFwmHgCXtuCAu+WfDflLTeMnH16NJ
	 reds2wERhngz2xNK5ZDsoKISci2SfUj7oyUWTjydqXd0vOok0Nm177uYDy+XdcnA99
	 N+va3hHA/ZLFA==
Date: Thu, 9 Jul 2026 10:21:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: split out mm_init and memblock declarations from
 internal.h
Message-ID: <ak9MFSjEdOdmZ9ma@kernel.org>
References: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
 <20260709-internal-h-v1-1-956d5092782d@kernel.org>
 <20260709065713.6C0F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709065713.6C0F51F000E9@smtp.kernel.org>

On Thu, Jul 09, 2026 at 06:57:12AM +0000, sashiko-bot@kernel.org wrote:
> > +void memmap_init_range(unsigned long size, int nid, unsigned long zone,
> > +		unsigned long start_pfn, unsigned long zone_end_pfn,
> > +		enum meminit_context context,
> > +		struct vmem_altmap *altmap, int migratetype,
> > +		bool isolate_pageblock)
> 
> [Severity: Low]
> Does this declaration cause a syntax error because it is missing a semicolon
> at the end?

Fixing checkpatch warning didn't go well :)

Will send v2 later.
 
> > +#if defined CONFIG_COMPACTION || defined CONFIG_CMA
> > +/* Free whole pageblock and set its migration type to MIGRATE_CMA. */
> > +void init_cma_reserved_pageblock(struct page *page);
> > +#endif
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709-internal-h-v1-0-956d5092782d@kernel.org?part=1

-- 
Sincerely yours,
Mike.

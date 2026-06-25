Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147FE3264E0
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394520; cv=none; b=gO5SNs4TL0fyj/rS99bvEp9gYQzeNhJ5aO56ob9N128ccFxWrEeWLvNLXbuEtdYE9EtpZjOloTAwfE6vSD9Hg3vpCmXpr/sQFDUcfsEqSp0ZrQCk201z/6AnDgy1mM7vjVK4+czJXSku0Z3nLkH9LEw/+CnwVESWmgCLndyvu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394520; c=relaxed/simple;
	bh=VTl59t5FGNxl9vwIccoBE1FSh1ipsJkGVWNaK8PoD04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cspgHHWYcRurdQJ1g6UI3yGBpwFFWTLtShc8EFcfq5FapUd8PQcvU6rgeXJJH6RpawOInaRdEU13Qv6vOWXEIq5dJTZDjGxljJ33btttnCA/hGYLOVIiYyNqzt4ApZHyBkn6Gzk+UKZORw9CDW1a7YQz8MuO0ucH4452UbW2onY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OiOS7lbG; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OiOS7lbG"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8dfdfe27ba0so29044466d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782394517; x=1782999317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8pz5eRLl5osDfg8s+rI8Lgc8KwmBuE9WN+Pu83DenE=;
        b=OiOS7lbGuAGoryv7Aj5Xq+qNt44gNZnqZSJ2jGRpYCc18SrNWWlhiQnu10IWVmw/2C
         W8Ce6HGLoKEuiXLQnxoTVi11ceKAx0aen+w4gT/UQLrcrTK/vuuhmpuQF3BgcUhbY9Vf
         A0M7UxZ5DzfRn5B5lKXkhbDl/N1r+DlMlOtzp9NfwW82o7feXNyHEEO6VjRTNJ8rbEd6
         9HZ+h18KD7Bq8fooTkS8dJyUjCZ+tmf/QJ5znaTBzNYt2/848khmk+QhqaBJqmhJGKVu
         Bw3WMaIa7tMxYLz6ztoaqctWqv7y4uU40dR0DCyhi12o7bWgtyokohJtZE3Z66JBy/kt
         +Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394517; x=1782999317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8pz5eRLl5osDfg8s+rI8Lgc8KwmBuE9WN+Pu83DenE=;
        b=JZi1ktPsiTO4x+Pa2rBDVpFtR4qQANhZBLo2PRKoouyQ0M0xkj4mlUUeSjZ6x2TiGx
         bRXzQcHQxYW6RafWfP4byjHjST/OW2p5/CK/QOMh3Qc710wmVy+prZ1hf73bTJFibsHa
         DWuBr7HrvmQIqfGuuMYNrQZKSU8hGr8pALFGPpfXfB4//MdLOxW4gqH13vvWMcpRMf5d
         /5sQECnhV0QHE79mBhlJs+/uUQ2hNs8Ar+AOpnsJ7te2J/PNf3WabhZTgEVsVc5vdWKz
         /PG27EohWSBasE/tSlhILtndG5uB7HbcAMqyY2nbPha1QSDGniH06z17bf/txRj2ErW+
         PXVA==
X-Forwarded-Encrypted: i=1; AHgh+RoVGKe8yIl1PK4+0/SyqopFTXcAwZCq4cEE3SJC+60b5D++eoH2Sq1zFfq1r8FCoqEbp06ACw68qyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnMn6FbiA7gIEb1b+jG65evMTIfm/omojN7iSveA9gDdSPNR5
	ZNIJ/Rdd3FLdEpkZdMnnT1SwsJ9beLaZYSVEa6ZpGnSbq6mEQLAHiOwZXv9DZbbBHnM=
X-Gm-Gg: AfdE7cmjqwdIVZR8SE2DWgowcgXA3fn5caTWOhje5WxTs7Wgj4aF41aofK5ZmmleoIS
	439LN0Kvgi57G5MM1gSdmsp7Nn/toDZr94aIiL0VzrnDVrzktfwBmPt6dOCKe5hr7DPqfBEOTIX
	MlR264fKAxNByXAEotBaBkJTLVBsWMWqXLfMot/DdfCm+OPtV8xOPWHlHzK9CFOqur7vXtkG5Xo
	2zZm7gGlRnJ6yvq7vBLjzCLxgn4oROqvqw9ZuV+VkPXYgGDDW842uKDJ45rE2ENw7vfR2YDIv6B
	Xtrwn752evTosYqjpa5Ie/UMP5jUoBjBmVbqlviCblW8yc6jHbtor/z2FjJTZTKjmuejmHhXpPg
	ua+1U97HWFdSfDEtAq0yx+/pM8F0OSfBUrouNdkYEKtk0M7i6cbs4C7HHfjtyWvjsQ31yB5iXQd
	vhfjXgV31VSnvU5p9NgUFk3Vhr5CW8SUBtM70Q9uApGR5JKEyKG9/nat+cZYalKi9+SobN
X-Received: by 2002:a05:6214:2686:b0:8cf:9bd:744 with SMTP id 6a1803df08f44-8e6d2ec8509mr48772246d6.12.1782394516856;
        Thu, 25 Jun 2026 06:35:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde319sm183477356d6.31.2026.06.25.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:35:16 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:35:12 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, osalvador@suse.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, shuah@kernel.org, alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com, ira.weiny@intel.com,
	apopple@nvidia.com, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 8/9] dax/kmem: add sysfs interface for atomic
 whole-device hotplug
Message-ID: <aj0ukAdiKRDEtYeN@gourry-fedora-PF4VCD3F>
References: <20260624145744.3532049-1-gourry@gourry.net>
 <20260624145744.3532049-9-gourry@gourry.net>
 <1d8f74a7-502b-43cb-a0f0-1923049aa213@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d8f74a7-502b-43cb-a0f0-1923049aa213@kernel.org>

On Thu, Jun 25, 2026 at 09:40:02AM +0200, David Hildenbrand (Arm) wrote:
> >  Documentation/ABI/testing/sysfs-bus-dax |  26 +++
> >  drivers/base/memory.c                   |   9 +
> 
> Can we have this ...
> 
> >  drivers/dax/kmem.c                      | 224 ++++++++++++++++++++----
> >  include/linux/memory_hotplug.h          |   1 +
> > 
> 
> ... and this as a separate patch, please?
> 
> Nothing else jumped at me.
> 

ack

~Gregory

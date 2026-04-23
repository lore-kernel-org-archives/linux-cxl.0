Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2A1A0BF3
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776907240; cv=none; b=taCsPzdKPNSKoJY14RMtADaEflaSV74VZWSl1VO7TtHAbz00xy3MrTRx7QJsflxEA39tdDL5GtO38e236BKOZB8/iUFcUi5TyjCT/lSutIVdppEq+8khJP4V9h6Zox5zt/0fkw3+o5GloOq1gPJ63BXiX5oMlJHeQqmnfiJUCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776907240; c=relaxed/simple;
	bh=dA6GElM0fNNMuprztNzP98FDEGCFrMhMZakaZwR3tvg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2KOGzSZKaeG09Vs8tUFrHhb2WqjAZ7eah+O6fvyM0P4tj8Fh6C6UfyErGreVkGOJyNzTacpGz5ria1qdFrCzDJyfKl9x8eg5csz3UV9eyGBW7XfT92SWRV9U7hFc0OSD65xl8d/tVJ+CHCoNs+PdOOionNOkCRkBYKn6k68jjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvIKVhtb; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvIKVhtb"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c8f9846c8so5277016c88.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 18:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776907238; x=1777512038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvh3/DQsA2dabX9bWm8It2tnDzvftm9aNthgppi9fB8=;
        b=nvIKVhtbOabLSyM54FEKrawJmOeRUXAGKewyip6aAToavbDAy8BJMwwj6wgjCT6uaI
         j8zm/3XHsQHpSAelE45JfCWYZ5xqMtLwREL7/DRgEokmc78xSXQGmZ4JqnWEHXN9fBgQ
         oAB9qJPP3dHgGXtJPNGpGGXRLXTZsPhQneJhv4DSBIvh8j0XPJiTOmA+tZyVgF6onG6K
         sraD7ojn8y1EDxPkVDjOIO9tnjUWbhvoN92aZQ/qbayvO2CThWyOcKuVyTNtA0hAfLUw
         BfkaDgzVS2/tNN7FEDZ383pYaYJ9JmOrARazQ8nZa8RSLx58afOTHCVWm54E0jVkXhR0
         zzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776907238; x=1777512038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvh3/DQsA2dabX9bWm8It2tnDzvftm9aNthgppi9fB8=;
        b=QShpuNwh8TIam5aEZHwtHRkb3HHTAYYDm+RE+C02Ihm1mQzdoedDQ9VBbuEHM6ElDK
         tF0RTvjHA5+tFQzVMcJh9eIKUSkAsKykNsn6GIGbY6WOqZPcPueW3YV4ayfWuFD/wH2T
         qFi+TN3tH60cYM/6hM9A1qIkWaBHQ+19CuOdSEAiWY2M0u2QhvIngwqOjT+a0xYJijRt
         C9aX8y5x/Zt+AJ/0ke0btJv4Q4PxACtGn039LaXsXej5Ba1YGrJfol+SSn6d5PedT8M+
         NUXYQBtqDjiRwNwkPXC7H4UbKqw04HoX9aurBttFP44Br5wNCOwBB2s30YkhQu2fYuRK
         LywQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gfyvQZH8aZ9ckVmo34Z+w6QogCqRJHVQ5guGFhqMbH6jJZs5KJAxn2VF1OP/f7FaoS5uSZJKDvHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrV7TZZv0wHxNBdl6M39Ve5GIhX7w7zDZWHay8aMn/9K3d0ti
	wSiNOnwBWbypI2DC/3+FiSZ9TbElMRYeJDbiO5oIwC9H5PRY55YmRCDJ
X-Gm-Gg: AeBDietrOfZ0zpaVRopkiUEP4HyW2DyZYmltDXi8EUWBeLfbD5RVbdz1mMCyYeqn89j
	e420XDjkbIiVBZ83YdY5QufwiG3AKtbnU16OrDCLaVYHHqfLz8XVTmGvE8R4EJRriZ6mDCjUV3d
	0+8P1U+Pfe0R9Tag3T4hoqZJdVv0sTHtosZaAI4jdWZu4CcfF0F5Z3HfTEF0h8hSnnV7Cw7icZp
	I9rEdApKDNa4wExX5nLJ3SNJyfkgqY+dBXssRbqCvB+FZuzFll5GAoYY9bkju58On3PYIddbsLS
	BeJTNUOqZ8GMncKWjSVnDbElVnX5eRDyY+wsU1CYi87rkjBAOCuRyVXMVEzdj9f/iI65Z2gmBwC
	qa1ZwxfKipviAaEmVMPxjPHhYEi7aJgyPnyuXXvFr6Yqs/UFNNKK7LqzY3JubaOtMkTycNPoqtE
	yofAMC24mawOHcJe/AF0+1XqDgJ1iRTRxPB9JFNgvf+T+5IcGdnclJZoZ3tKz5fYFV7DEpnsrW8
	Is7BoiAchPciZUSjEpLuEU=
X-Received: by 2002:a05:7022:6886:b0:12a:6e97:c21f with SMTP id a92af1059eb24-12c73d32ce4mr13536538c88.0.1776907237924;
        Wed, 22 Apr 2026 18:20:37 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm38449742c88.10.2026.04.22.18.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 18:20:37 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 22 Apr 2026 18:20:35 -0700
To: Alison Schofield <alison.schofield@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	john@groves.net, dave.jiang@intel.com, gourry@gourry.net,
	dave@stgolabs.net, jonathan.cameron@huawei.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [RFC PATCH 00/20] DCD: Remove support for sparse regions & add
 tags
Message-ID: <aelz4zxpEwHh7pkT@4470NRD-ASU.ssi.samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
 <aefl3_heFBu6iGe_@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aefl3_heFBu6iGe_@aschofie-mobl2.lan>

On Tue, Apr 21, 2026 at 02:02:23PM -0700, Alison Schofield wrote:
> On Fri, Apr 10, 2026 at 06:22:55PM -0700, Anisa Su wrote:
> > This RFC modifies Ira's DCD patchset to enforce tags and remove sparse DAX region
> > support, which are the requirements that I've understood from the community
> > meetings, with the end goal of FAMFS as the end user for DCD. Feedback would be
> > greatly appreciated to let me know if this is on the right track? Or totally off
> > the mark...
> > 
> > Everything is the same as before except:
> > - extents must have tags (uuids)
> > - 1 tag per region
> > - regions must be contiguous (no more sparse regions)
> > 
> > To achieve this, the main thing is to change the relationship between
> > cxl_dax_region : region_extent from 1 : many to 1 : 1. Each region_extent is
> > comprised of 1+ contiguous device extents with the same tag. Contiguity
> > is enforced by sorting device extents by DPA order. They're re-sorted by the
> > original order in which they were sent for the response, which is required by
> > the spec.
> > 
> > Once valid extents have been collected, it's passed as 1 contiguous capacity
> > to the DAX layer via cxl_dax_region notify(). Once notified, the same region
> > cannot be added to again, unless all extents are released.
> > 
> > For release: upon receiving a release event record, if the extent is within the
> > bounds of any cxl_region, and it has the correct tag, then all extents in the
> > region are released, so the "More" flag is still ignored. Not sure if this is the
> > right way to do it but it was the simplest.
> > 
> > The changes to the DAX layer remain untouched, as all of this extra validation is done
> > in the CXL layer. And since FAMFS already takes care of the devdax -> fsdev conversion,
> > there was no need to add anything there.
> > 
> > Most of the series remains unchanged as I've tried not to make too many big changes
> > right off the bat. Only the following commits were modified:
> > - cxl/extent: Process dynamic partition events and realize region extents
> > - dax/region: Create resources on DAX regions
> > - cxl/region: Read existing extents on region creation
> > 
> > I've tacked on 1 commit at the end to change the driver type of DC regions from
> > DAXDRV_KMEM_TYPE to DAXDRV_DEVICE_TYPE so it can be bound to the new fsdev driver.
> > 
> > Also, I've documented with more detail in the commit messages of the commits
> > that were modified on what exactly was changed, so I hope that's clear.
> > 
> > ================================================================================
> > Git History
> > 
> > This series is based on cxl-next, with base commit:
> > 3939dba00f98 Merge branch 'for-7.1/cxl-misc' into cxl-for-next
> > + bug fix: https://lore.kernel.org/linux-cxl/20260411011137.43545-1-anisa.su@samsung.com/T/#u
> > 
> > GH Branch: https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-rfc-04-10-26
> > 
> > It doesn't apply cleanly onto famfs-v9, although I have the version that's applied
> > onto famfs-v9 here: https://github.com/anisa-su993/anisa-linux-kernel/tree/famfs-v9-dcd
> > - famfs-v9 for reference: https://github.com/jagalactic/linux/tree/famfs-v9
> > 
> > I've tested the current series without famfs as well as the series applied on
> > famfs-v9 with famfs.
> > ================================================================================
> > Testing:
> 
> Where's the CXl unit testing...
> 
> big skip
> 
> 
> >   tools/testing/cxl: Make event logs dynamic
> >   tools/testing/cxl: Add DC Regions to mock mem data
> 
> Hi Anisa,
> 
> I'm inserting here and referencing the last 2 patches above
> that add cxl/test support for DCD testing.
> 
> Let's use it! We'd really like to see the ndctl patches sync'd up
> with this kernel set. That would give us a CXL Unit test 'cxl-dcd.sh'
> to run on each revision. 
> 

Will do for the next version! I wasn't sure if the behavior in this RFC
was what famfs wanted, so I left the tests alone. But anyway, once cleared up
with John, those will be updated :3

Thanks,
Anisa

> This is one link, perhaps the last to the ndctl set, but I think you
> may have posted something long ago too:
> https://lore.kernel.org/nvdimm/20250413-dcd-region2-v5-0-fbd753a2e0e8@intel.com/
> 
> -- Alison
> 

Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3EB12D758
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711540; cv=none; b=gHqe9J5DuY0Tm4nRxXX7qGBBtSCq9fmbubFbLe4ms9GkCBJMvOcVW4ZHr3RS7K4MfNfOTDrvqEY6ihYlSPMqY3t/m/mS61RpZk8i3IQxBeQRqM1U6fMUVi0addz3ftMfdzTSd8oMCLNbSlX2nB2HZsfnCdrXoWJw0Hxbl752094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711540; c=relaxed/simple;
	bh=Azbbv1vncp4gVUYXL0lFc2C3+8Mz72xIK0m3Yd/p6ao=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wazvn6nneWxw3260djSqslo7uYcvSNwla3K1v8g3UVGLV4UJa3dQoMMV8tMGSN3s/ZxokothP1n7zswKeOJePQxAiBbxQsjlCeBwwpPdXrzvLjQznHHVMnHpLD64ov+aIWMLgVIAYiMoi9vUPXLRmuivJt+HVbSQa+xUy4Ple60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jotuFXpU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jotuFXpU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1db6e0996ceso9069615ad.2
        for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 10:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708711538; x=1709316338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eQu9k1UzQBTg1+2+F/9lTUaNsdI0drlaEmh//0+Ixko=;
        b=jotuFXpUw/7Vk8GrDejUvkTHt9pF68Gh4vlhMCNkGgXVFS7yNppr4Xl1aOPK4vIhVp
         geMtI/3sDu1zEpC0nxqrTMLUVZU3GgO2yO0BnEf8S8rZf5gXA2Xgy2ILX1oI6GWlpFx9
         I8AKdR859dx/kam4yWCkDnuGtoP2sMQzEzI2dSC5zBRQJgu3qnvJAmCtnD4O6BJQW/Ev
         6yuiLG8n8OxIUogQB50k6cEAbz6B9DXlFhdNoYThclj8jilhF4NUgA/3IUkna3bnxyOR
         /Awf5L0ok5JPMPi2r28csYo9l81jraYgFW95t3EFgMm4SKX4uSqi1i8STSdS5fPLe9cF
         FswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711538; x=1709316338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQu9k1UzQBTg1+2+F/9lTUaNsdI0drlaEmh//0+Ixko=;
        b=j1JRWSiLowdY10pVM/JEv5OTqRvq6j1ZAYDQtFvy80pLj0oZTMRiFz/PyVi+xsApOp
         44dn+cChs5mob5QkRv7JeJxdeItuIGMYVHetcjqq0yC8NHYAfopzsJE2Y0qerK3N5std
         X0wS92cD5Xf1uliqw0qH3OAMG7Kw7+rMtUbns7LPJ5JTd5L1gMm3p5WmzWBbXMksUW3+
         u/dp1xdGBSwbABwcXlIIDdbzezpQ5PeG5Nrn0Ju7wcWvLO4dxGCF6jIlnRgwKSPOmQFG
         GH5taseKFTL/bV3GgtButZQ3tMp1s4JAylO+SDCi7+xATWUAzx1ng3i5xUqfST1ENn8p
         Cttg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ssqhwoDbrr6gWCASAbziKcDXf4S7nshT2WMjBDBmp3KB9ZHOmsXgRXPZMvnBvPFh84axFHJ2rWQboWK2lavhLX/ATgtIOOVD
X-Gm-Message-State: AOJu0YwnWY+5szIZmXJKz5b5ou3aEWO/jcP1Mfvr3LkVKuCHoJviFwGS
	x2icZJF65IWdYIk+rZYtjbvOg3UczFXA9BUCT9fH13h4sG6srThH48NQATUU
X-Google-Smtp-Source: AGHT+IFn0SQfg5gTo1ErHfP8GnU4kmfGB6tPgeGrlP76MP0bAlBtL9Xi9l8o2ieIevSa0Qktl39emw==
X-Received: by 2002:a17:903:449:b0:1da:2c01:fef5 with SMTP id iw9-20020a170903044900b001da2c01fef5mr544455plb.56.1708711537268;
        Fri, 23 Feb 2024 10:05:37 -0800 (PST)
Received: from debian ([2601:641:300:14de:2595:938c:d7c1:5827])
        by smtp.gmail.com with ESMTPSA id jc13-20020a17090325cd00b001db6de983d3sm11947607plb.85.2024.02.23.10.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 10:05:36 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 23 Feb 2024 10:05:20 -0800
To: nifan.cxl@gmail.com, wj28.lee@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, gregory.price@memverge.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 00/10] Enabling DCD emulation support in Qemu
Message-ID: <ZdjeYMqmik0nszR5@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>

On Wed, Feb 21, 2024 at 10:15:53AM -0800, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> v3[1]->v4: 
> 
> The code is rebased on mainstream QEMU with the following patch series:
> 
> hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
> hw/cxl/mailbox: interface to add CCI commands to an existing CCI
> 
> Main changes include:
> 
> 1. Updated the specification references to align with cxl spec r3.1.
> 2. Add extra elements to get dc region configuration output payload and
> procecced accordingly in mailbox command 4800h.
> 3. Removed the unwanted space.
> 4. Refactored ct3_build_cdat_entries_for_mr and extract it as a separate patch.
> 5. Updated cxl_create_dc_regions function to derive region len from host
> backend size.
> 6. Changed the logic for creating DC regions when host backend and address
> space processing is introduced, now cxl_create_dc_regions is called only
> when host backend exists.
> 7. Updated the name of the definitions related to DC extents for consistency.
> 7. Updated dynamic capacity event record definition to align with spec r3.1.
> 9. Changed the dynamic capacity request process logic, for release request,
> extra checks are done against the pending list to remove the extent yet added.
> 10. Changed the return value of cxl_create_dc_regions so the return can be used
> to Remove the extent for the list if needed.
> 11. offset and size in the qmp interface are changed to be byte-wise while the
> original is MiB-wise.
> 12. Fixed bugs in handling bitmap for dpa range existence.
> 13. NOTE: in previous version DC is set to non-volatile, while in this version
> we change it to volatile per Jonathan's suggestion.
> 14. Updated the doc in qapi/cxl.json.
> 
> Thank Jonathan for the detailed review of the last version[1].
> 
> The code is tested with Ira's last kernel DCD patch set [2] with some minor
> bug fixes[3]. Tested operations include:
> 1. create DC region;
> 2. Add/release DC extents;
> 3. convert DC capacity into system RAM (no real read/write to DCD tested);
> 
> 
> v3: 
> [1] https://lore.kernel.org/linux-cxl/20231107180907.553451-1-nifan.cxl@gmail.com/T/#t
> [2] https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
> [3] https://github.com/moking/linux-dcd/commit/9d24fa6e5d39f934623220953caecc080f93e964
> 
> Fan Ni (10):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
>     type3 memory devices
>   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
>     devices
>   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
>     size insead of mr as argument
>   hw/mem/cxl_type3: Add host backend and address space handling for DC
>     regions
>   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
>     list mailbox support
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
>     extents
>   hw/mem/cxl_type3: Add dpa range validation for accesses to DC regions
> 
>  hw/cxl/cxl-mailbox-utils.c  | 507 +++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 559 +++++++++++++++++++++++++++++++++---
>  hw/mem/cxl_type3_stubs.c    |  14 +
>  include/hw/cxl/cxl_device.h |  61 +++-
>  include/hw/cxl/cxl_events.h |  18 ++
>  qapi/cxl.json               |  61 +++-
>  6 files changed, 1174 insertions(+), 46 deletions(-)
> 
> -- 
> 2.43.0
> 

Hi,

I fixed some issues mentioned by Wonjae Lee (wj28.lee@gmail.com) in his
review comments and pushed the changes to my local tree:
https://github.com/moking/qemu/tree/dcd-v4

This is no functional changes to the code, mainly fixes include:
1. Did spell check for the patchset and fixed 2 typos;
2. Fixed a misuse of stq_le_p and replaced it with stl_le_p in
cmd_dcd_get_dyn_cap_config;
3. Removed unnecessary switch case in patch 9;
4. Capitalized ""opcode" to "Opcode" in two code comments;
5. Updated one reference text to the spec;
6. Minor text change in qapi/cxl.json.

Thanks Wonjae for the careful review.


I will wait until next week to send out v5 to see if there are further
comments to come in.

Fan


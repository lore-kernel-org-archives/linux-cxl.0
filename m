Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E373988E1
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906281; cv=none; b=Vdr1vjgfEtltX2jGWskP4I7rmsMzONlw3e3FsL4GmCWJaC+rd9HgWal5+S2nmC65jZ3z72r5k2GEPd49lYIfhwkZx1v1haYMsvFIeCPQ8fCBjAIoKiCe2TaR54iFnJ39T63i5Zgq+epb4uWjLsoIJWI+2fRgPFqgxMrv9pW+aWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906281; c=relaxed/simple;
	bh=GGy4wHoXtxb5+rb5vKvXmy7ebBL4n+KBywY4VMfgW+c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ah4B5afGSYscR6e/PfWlOMSByNGptAZgZtXrlXG3yffk0VOSS+qKaZNmzbRKuvZIYvwKFrTJCluUYYXp4CBWRy5pMbqjgbResY+QEEMWHeTdkflMuKZNR1dpMdhS++sUfn7OhK7IbyVloDHZzkLx1nWiN0wOsSaRVJ7gfaD5kek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAd+mlRP; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAd+mlRP"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304cf518c9dso4783860eec.1
        for <linux-cxl@vger.kernel.org>; Mon, 08 Jun 2026 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780906279; x=1781511079; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Pk4Oho3OAOJy1uGwbTwzFDNpN5USaQybiPA/+hG3XU=;
        b=aAd+mlRPuf6V4I5nPh73Zgvjsb4Y54C++rWJSEALEFyuVzqq8oyPiHe43xRd9bNiQr
         pynC6xi99W13XGsn79uNn3ROzxeUBDkTyYFBu0LssPZh0RI0QwJh9nyVBQhnw2R0SP6g
         luX0RI0g4RJepMF9tRd+ltx7V8EGrdKsVNAaawWGlXIDa0QzzlCumgHOHsojt0PLplBi
         UJJCUsQb/gBMmxn3SJNIRcuxeZxWcni166bAoKIZ6Th3uiJdhxtm+mpOXN7ev0n0++80
         o4iFqpYelhrXSNO1aatgerhUW0N1DiRVPJyxIP+Nxe7uE5sP5eMVJTc7LlaIZjA5Bz11
         grJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780906279; x=1781511079;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Pk4Oho3OAOJy1uGwbTwzFDNpN5USaQybiPA/+hG3XU=;
        b=MELmXJvHVv0p8obSE8VDtj3VUmfdWyxHIMSGfl/BtYqGeE3y/QlqrhaBlJPIEquPiF
         BWKi7KOTBZKbe60W3+AUUnuFh36FjhmnD/w7nwksva+kMH/wdVel0vh+Shnlh0ntkNoO
         AHYt+FAIFte/0JWo45tfBseoO0t89ZtT/ZBJH/jTegfzXyRCuRnTneagDhSjFveFW4Fr
         JkIhUV6NNCrZlz8wBY28yAAhVXaemigq9uVuE6t1REIzNBMqxGS+aX2d3KSrlDIA3lbm
         SU498tqmYt5Rypm5C+W2Quy7pJmN5tbR27AWUP39cTdTT7O6WAbWfhpRtcGiGBOA5GZy
         k+gg==
X-Forwarded-Encrypted: i=1; AFNElJ8ePtxNTwIQwF7oQWvdyGvz06vqd2pjgilZR2xP+5Peu+rZ9RGGHT/7kfyfWw5BW3rAINCBlncM2WY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wKsNtPkaygPOj4VS0aJOFxU4SNhiWuAsN3dIejKG1gqk7Ilf
	bUxp8tIwnhvpnB1QUD4QN1yt73WmP28OZuHr+nLThLxCB1mOeXmIribc
X-Gm-Gg: Acq92OG/2f8YNWOdq5TsZjd7jh1FoUYTDW4jDEuFTMcrrhAEzCA5uRWI/dQh6b89EeZ
	iR1iZE0UufkivRH2VDYiGHDP8jt/iVmRF21Qj5d/jNDP4X3K9R/YBKRnfzakVc9uW8IiqGw6I4r
	gLTgm8yBFB2tXNjbj48+rLHqrPC6CiGwZcnxFHY+dRffnu7yZ3/gl147k31A7KPx6BSjrTfGYB5
	n7HHSLXPZBTWETSEpZninCnv6nREHQm+3PvDFxdRHD8Uhgj8xNbmyl0k77r1x9Zl7thAmSXp/li
	x6v1yXzzzjZuCIKdHQe3rn0dHyI/GGtl8MZBfnO2Jhx65M3USlS/JeDvX8LCX2Rh1Qd9QPQA+5n
	cv/uQZf4h46yvRHmhQAQssfIYl7sLxLULVw0JUiWlaypnoegH31SYpPAdc+IDHzpBHgY3Mh3l06
	Wm2RZNZGHR2FIb3b/3biTZ+GS0UI7r7oNr0pTWkVPcBVxE6lM1EI9ASNLLJWtMOdSnBQbP0YwzK
	clCXPr7lOnZdZVzIg==
X-Received: by 2002:a05:7300:7488:b0:304:ed85:5f43 with SMTP id 5a478bee46e88-3077b1e1aeemr7285890eec.24.1780906279075;
        Mon, 08 Jun 2026 01:11:19 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df77a0asm17370469eec.27.2026.06.08.01.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:11:18 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 8 Jun 2026 01:11:18 -0700
To: Alison Schofield <alison.schofield@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v6 0/7] ndctl: Dynamic Capacity additions for cxl-cli
Message-ID: <aiZ5JqaW4oWfSxUk@AnisaLaptop.localdomain>
References: <20260523095043.471098-1-anisa.su@samsung.com>
 <aiJh7vcs2u1fMDX4@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiJh7vcs2u1fMDX4@aschofie-mobl2.lan>

On Thu, Jun 04, 2026 at 10:43:10PM -0700, Alison Schofield wrote:
> On Sat, May 23, 2026 at 02:50:35AM -0700, Anisa Su wrote:
> > CXL Dynamic Capacity Device (DCD) support has continued to evolve in the
> > upstream kernel since Ira's v5 posting [1].  The kernel side has settled
> > on a uuid-driven claim model for sparse DAX devices: dax_resources carry
> > the tag delivered with each extent, and userspace selects which ones to
> > claim by writing a UUID to the dax device's sysfs 'uuid' attribute (or
> > "0" to claim a single untagged resource).  Size on a sparse region is
> > determined by the claim, not requested up-front.
> > 
> > This series brings cxl-cli and daxctl in line with that model and
> > extends cxl_test to exercise the new paths end-to-end.
> 
> Hi Anisa,
> 
> I just now picked this up with the kernel side and took it for a quick
> test drive. Based on what's been touched, first meaningful finding is
> all the DAX unit tests pass, and then for CXL unit tests, all but these
> 2 pass: cxl-security.sh and cxl-dcd.sh
> 
> Please let me know if there are known problems with either of those
> before I explore further.

Oh hmm... I would expect cxl-dcd.sh to pass. Let me know what error you
saw? But it's totally possible that I mucked something up with some last
minute change. Let me try it again on my side...

For cxl-security.sh, sorry I was bad and didn't run all of the other CXL
unit tests. Pin of shame for me ;(◞‸ ◟)

Let me figure out how to get the NDCTL test runner working and it should
not be an issue moving forward
> 
> Question below about dependency....
> 
> > 
> > The corresponding kernel patchset is here:
> > https://lore.kernel.org/linux-cxl/cover.1779528761.git.anisa.su@samsung.com/T/#t
> > 
> > Picked up unchanged from v5 (Ira):
> > 
> >   libcxl: Add Dynamic RAM A partition mode support
> >   cxl/region: Add cxl-cli support for dynamic RAM A
> >   libcxl: Add extent functionality to DC regions
> >   cxl/region: Add extent output to region query
> > 
> > New in v6:
> > 
> >   daxctl: Add --uuid option to create-device for DC DAX regions
> >     - Plumbs writes to the new dax 'uuid' sysfs attribute through a new
> >       daxctl_dev_set_uuid() helper (LIBDAXCTL_11).
> >     - --uuid is mutually exclusive with --size; pass "0" to claim a
> >       single untagged dax_resource.  An unmatched UUID surfaces ENOENT
> >       from the kernel and leaves the device at size 0.
> >     - Documents the option in the man page.
> > 
> >   cxl/test: Add Dynamic Capacity tests (rewritten on top of Ira's
> >   original patch to track the post-redesign kernel)
> >     - Routes untagged claims via --uuid "0" so daxctl exercises the
> >       kernel uuid_store path; tagged claims use real UUID strings.
> >     - Asserts that for DC regions, size-grow returns -EOPNOTSUPP (real grow is
> >       --uuid only) and that tag reuse across More-chains is rejected
> >       by the cross-More uniqueness gate.
> >     - Adds coverage for the new validators: test_uuid_no_match,
> >       test_uuid_no_match_seed_intact, test_uuid_show,
> >       test_cross_more_uniqueness, test_alignment_rejection.
> >     - Sharable-partition coverage (test_shared_extent_inject,
> >       test_seq_integrity_gap) is routed at runtime to a dedicated mock
> >       memdev that tools/testing/cxl stamps with serial 0xDCDC, so a
> >       single cxl_test module load exercises both regimes.
> >     - Localizes positional-arg assignments in every helper so functions
> >       no longer clobber caller globals (the previous behavior leaked
> >       the sharable memdev into later tests).
> >     - test_reject_overlapping arithmetic now lands an actual overlap
> >       inside the DC region (the prior math landed past the end).
> > 
> > Depends on the kernel DCD/sparse-DAX series; without it the new tests
> > will skip and 'cxl list -r N -Nu' will simply report no extents.
> 
> What is this dependency- DCD/sparse-DAX series ?
> 
Sorry, I just meant the kernel support for DCD. Poorly worded here. 'sparse'
DAX is just the terminology for DAX regions backed by DCD.
Well, in the kernel patchset, I renamed it to
"DC DAX" to make the association clearer, but then forgot to reflect it
on this side (𖦹ᯅ_𖦹)

Thanks for testing!
Anisa
> > 
> > The branch is also available at:
> > 
> >   https://github.com/anisa-su993/anisa-ndctl/tree/dcd-2026-05-21
> > 
> > Based on pmem/pending commit:
> > 
> >   bbd403a test/cxl-sanitize: avoid sanitize submit/wait race
> > 
> > [1] https://lore.kernel.org/nvdimm/20250413-dcd-region2-v5-0-fbd753a2e0e8@intel.com/
> > 
> > ---
> > Changes in v6:
> > - anisa: New patch — daxctl --uuid option + daxctl_dev_set_uuid() helper
> > - anisa: Rewrite cxl/test DCD tests against the post-redesign kernel
> >          (uuid sysfs claim, tag-group atomic release, cross-More
> >          uniqueness, alignment rejection, DC size-grow refusal)
> > - anisa: Rebase onto bbd403a (pmem/pending)
> > - Link to v5: https://lore.kernel.org/nvdimm/20250413-dcd-region2-v5-0-fbd753a2e0e8@intel.com/
> > 
> > Changes in v5:
> > - iweiny: Adjust all code to view only the dynamic RAM A partition
> > - Alison: s/tag/uuid/ in region query extent output
> > - Link to v4: https://patch.msgid.link/20241214-dcd-region2-v4-0-36550a97f8e2@intel.com
> > 
> > Anisa Su (1):
> >   daxctl: Add --uuid option to create-device for DC regions
> > 
> > Ira Weiny (6):
> >   ndctl: Dynamic Capacity additions for cxl-cli
> >   libcxl: Add Dynamic RAM A partition mode support
> >   cxl/region: Add cxl-cli support for dynamic RAM A
> >   libcxl: Add extent functionality to DC regions
> >   cxl/region: Add extent output to region query
> >   cxl/test: Add Dynamic Capacity tests
> > 
> >  Documentation/cxl/cxl-list.txt                |   29 +
> >  Documentation/cxl/lib/libcxl.txt              |   33 +-
> >  Documentation/daxctl/daxctl-create-device.txt |   12 +
> >  cxl/filter.h                                  |    3 +
> >  cxl/json.c                                    |   67 +
> >  cxl/json.h                                    |    3 +
> >  cxl/lib/libcxl.c                              |  181 +++
> >  cxl/lib/libcxl.sym                            |    9 +
> >  cxl/lib/private.h                             |   14 +
> >  cxl/libcxl.h                                  |   21 +-
> >  cxl/list.c                                    |    3 +
> >  cxl/memdev.c                                  |    4 +-
> >  cxl/region.c                                  |   27 +-
> >  daxctl/device.c                               |   72 +-
> >  daxctl/lib/libdaxctl.c                        |   44 +
> >  daxctl/lib/libdaxctl.sym                      |    5 +
> >  daxctl/libdaxctl.h                            |    1 +
> >  test/cxl-dcd.sh                               | 1267 +++++++++++++++++
> >  test/meson.build                              |    2 +
> >  util/json.h                                   |    1 +
> >  20 files changed, 1771 insertions(+), 27 deletions(-)
> >  create mode 100644 test/cxl-dcd.sh
> > 
> > 
> > base-commit: bbd403a03fa2a1551c1a10bbf78f32027c718758
> > -- 
> > 2.43.0
> > 

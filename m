Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BA8801
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723167464; cv=none; b=GjUqKSINLRN/eackrQu2nb0D1zfgBGyUJ2c6876TfiheCpP4HjhPHc94zhqaiMeoRw/ZDPjnsEh7W0EIgxVBtTPvLsp93OaHVuDlyyTgckVck0mTu8Sn3PWwIth2v1xKCg3VUzrg25qG58cPkqlsJ3nvSu1YfEcxd4EBb3586Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723167464; c=relaxed/simple;
	bh=zr656JXvRFJ9JP6idDYxs3Nxdl2w9wM0q8/Q9LipOdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G2FJObUFZwopKkh1MCz1zdEQ+XDGXv6Ja2wkQfz+wcHwJPg8iz/X1zUqkqSjdGmLAHW6hT4u2kSlQKDNcfBUKcir15DclyVhH7VQZ6s8BrAzRUimK2PA7i/vkf8LlhiHyecJUheikN5sBsOISlBrVtWqb55aE8LX9QcffBRcOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jpqj03CB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jpqj03CB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723167462; x=1754703462;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zr656JXvRFJ9JP6idDYxs3Nxdl2w9wM0q8/Q9LipOdE=;
  b=Jpqj03CBqtGpQovmcFnJ8WlOhLv01qVxZAjcQ7PIrzpMCDrvRqxUT8ef
   GPIXKtXZuBW8lCLF0pSxU7qTdb3q4HmI4CACJSdQiqgkIFk+oobeCGKAe
   bUtuqk1Ob1jkd2Qas5Kh0to+A3MHKE/XG8wDUrHCyuxR3/W4CcgC2EMMO
   +00Fefup4WSg8y7cfiuvQbgyoZfgM/UYvskW9w6uRe/ACTrSU+wFpn+a+
   0183eUGkMcn7I3YyFNjZO1WkDEZG/tK2ynw8zAxOdKuRDQbwmz6S3swbA
   4sOijOA4RObkXFYMJ9Y73uShTTISk6BeUfCLOtp+Z7NOsPm6KKGrhKI1U
   Q==;
X-CSE-ConnectionGUID: TLDMBf0VR7qhBifSBEbLqQ==
X-CSE-MsgGUID: xmc3estHRhqSa2Cs5Mzf/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="20987261"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="20987261"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 18:37:42 -0700
X-CSE-ConnectionGUID: NcuyEMhwRaG9rT2QakQ1lg==
X-CSE-MsgGUID: t2ihD5lSTG25OCBL93nuww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57483888"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 18:37:39 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>,  Dave Jiang <dave.jiang@intel.com>,
  Alison Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Lukas Wunner <lukas.wunner@intel.com>,
  "Zanussi, Tom" <tom.zanussi@intel.com>,  linux-cxl@vger.kernel.org,
  linux-mm@vger.kernel.org
Subject: Re: Odd lockdep splat involving mt_adistance_algorithm
In-Reply-To: <66b4fb7961376_c1448294dd@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Thu, 8 Aug 2024 10:08:09 -0700")
References: <66b44389e7b5f_71e8129499@iweiny-mobl.notmuch>
	<87wmkrzgsu.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<66b4fb7961376_c1448294dd@dwillia2-xfh.jf.intel.com.notmuch>
Date: Fri, 09 Aug 2024 09:34:06 +0800
Message-ID: <878qx6zdgx.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Huang, Ying wrote:
>> Hi, Ira,
>> 
>> Ira Weiny <ira.weiny@intel.com> writes:
>> 
>> > Ying,
>> >
>> > I'm working on the CXL DCD support[0].  After rebasing to v6.11-rc1+ I'm
>> > starting to see the following lockdep splat[1] in my testing.
>> >
>> > I don't understand how lockdep thinks there is a dependency between
>> > (mt_adistance_algorithms).rwsem and cxl_dax_region_key (the
>> > cxl_region->dev mutex).
>> 
>> IIUC cxl_dax_region_key is for cxl_dax_region->dev mutex.
>> 
>> > Do you have any insight into how the notifier rwsem gets associated with
>> > other locks?  I just don't see how the association in this splat is
>> > made.
>> 
>> In v6.11-rc1, a new dependency is added between cxl_dax_region_key and
>> (mt_adistance_algorithms).rwsem via commit 643e8e3e6529 ("cxl/region:
>> Support to calculate memory tier abstract distance").
>> 
>> When probe cxl_dax_region device, cxl_dax_region->dev mutex will be
>> acquired, then dev_dax_kmem_probe() will call
>> mt_calc_adistance() -> acquire (mt_adistance_algorithms).rwsem ->
>> cxl_region_calculate_adistance() -> cxl_region_nid() -> acquire
>> cxl_region_rwsem.
>> 
>> In your new code, cxl_dax_region->dev mutex may be acquired when
>> cxl_region_rwsem is held in the following call stack,
>> 
>>   cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core] <- cxl_dax_region_key
>>   cxled_add_extent+0x376/0x400 [cxl_core]
>>   cxl_mem_get_records_log+0x586/0x760 [cxl_core] <- cxl_region_rwsem cxl_handle_dcd_event_records()
>>   cxl_mem_get_event_records+0x99/0xa0 [cxl_core]
>>   log_dc_event+0xc5/0x180 [cxl_mock_mem]
>>   __dc_inject_extent_store.isra.0+0x30d/0x3e0 [cxl_mock_mem]
>>   kernfs_fop_write_iter+0x141/0x1f0
>>   vfs_write+0x262/0x500
>>   ksys_write+0x59/0xd0
>>   do_syscall_64+0x75/0x190
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Ying, I think it is dangerous to be acquiring locks in notifier
> callbacks. I am not understanding why this needs to be a notifier use
> case at all. Shouldn't the adistance be passed in via dev_dax data
> somehow?
>
> Something like:
>
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 9b29e732b39a..3ac20f4b1c63 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -18,7 +18,8 @@ static int cxl_dax_region_probe(struct device *dev)
>                 nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>  
>         dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
> -                                     PMD_SIZE, IORESOURCE_DAX_KMEM);
> +                                     cxlr_dax->adist, PMD_SIZE,
> +                                     IORESOURCE_DAX_KMEM);
>         if (!dax_region)
>                 return -ENOMEM;
>  
> ...notice how the dax already knows the node id which makes it extra
> unfortunate to need to take locks to recalculate the node-id all over
> again.
>
> Can this be reworked to make all the paths that care pass-in rather than
> ask for a awkward callback in unknown locking context?

Hi, Dan,

Still want to keep mt_calc_adistance() the unified interface to
calculate abstract distance for a NUMA node.

To avoid acquire cxl_region_rwsem in adistance notifier callbacks, can
we store NUMA node in struct cxl_region?  If so, we can avoid to acquire
cxl_region_rwsem in memory hotplug notifier too.

--
Best Regards,
Huang, Ying

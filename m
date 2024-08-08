Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB1D15AD90;
	Thu,  8 Aug 2024 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151546; cv=none; b=VEjWk7+jh5nsYBGOWphFLaEMhq3KW0xBAnh+h31Z76tVNAF8HLX8kGkMDTHUdoIZzfuT/q1vD0jVYM9Im3Mjhix+JNQBXO2S0nSi7kSqnHdisUPXT8gKS+tzgokE0/HZ2HNOghQPSuJj8AWeDdbW6/zZ8ij+uyaPvVYpgQYh2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151546; c=relaxed/simple;
	bh=Vap3umje8kcXqhdxoUlDY+Pkv0QLS2Akuf9ccxkaa/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6K7Lk7t08+jdyZ4qTKCB7u/E7+BtHURMWI3QtmM/t9uf684s3yVepGSOIs7ipG/LmAnmkd6fBcd8dJsWuoTPjn1JehvndPzkqTdBWWWdR4YilNFiVtfxwI2LWhoOeNG/AwAExTqqFpmXrkZg+cnwpTJ8bhtB8cNu188fJWzu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/OrXuzL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/OrXuzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723151545; x=1754687545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vap3umje8kcXqhdxoUlDY+Pkv0QLS2Akuf9ccxkaa/o=;
  b=V/OrXuzLmWSxU6KTsK5+oWZFzrH+tRDJuBEQ7JkgfFb6PSN2zIca5ryC
   R51ARZ806DKTdVgnm4sCPEo2B3cON/rD9P0/15vYIHdaTFEj1rvRNyQ7w
   eCVLB174sHnxaouJWnVCqn9+ctpcydQWswXhNLUkxFnSjVUQcaDB/p9at
   AFh9ayY8m97u/idL8M4F405hZoQMkpNDlxeUlLD8TI9Of49h85trrfazk
   YNV82MWAcFRF7R2dQ4vOfyMT0riFWGNzY/m5zzhj/3fxL6drpksZ/k2ed
   xsv811Crp3sUYzbtRV/xgej4miphlsbjOeW0XtDTxMvbyoK28GGBThXSZ
   g==;
X-CSE-ConnectionGUID: pYcj31G6QqeBcDXJGSQ9og==
X-CSE-MsgGUID: tefbAkBoTfKoz+BAZ4mhLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38763724"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38763724"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 14:12:24 -0700
X-CSE-ConnectionGUID: BzDutUOWSyCFD7hfEA2EIQ==
X-CSE-MsgGUID: mEWhHyCeRpm29qPnsqD+5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="62307790"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.12.215])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 14:12:23 -0700
Date: Thu, 8 Aug 2024 14:12:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
	j.granados@samsung.com, lizhijian@fujitsu.com,
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com,
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz,
	willy@infradead.org, dan.j.williams@intel.com, yi.zhang@redhat.com,
	david@redhat.com, yosryahmed@google.com
Subject: Re: [PATCH v3 4/4] mm: don't account memmap per-node
Message-ID: <ZrU0tQw8EwTTrD4E@aschofie-mobl2>
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-5-pasha.tatashin@soleen.com>
 <ZrUUnm/pEpPS9ltC@aschofie-mobl2>
 <CA+CK2bD6wMh2svqf3vhj=53=EUWYtQJmJXyTRkLBm49q7KJFtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bD6wMh2svqf3vhj=53=EUWYtQJmJXyTRkLBm49q7KJFtg@mail.gmail.com>

On Thu, Aug 08, 2024 at 03:05:32PM -0400, Pasha Tatashin wrote:
> On Thu, Aug 8, 2024 at 2:55 PM Alison Schofield
> <alison.schofield@intel.com> wrote:
> >
> > On Thu, Aug 08, 2024 at 03:42:37PM +0000, Pasha Tatashin wrote:
> > > Currently, when memory is hot-plugged or hot-removed the accounting is
> > > done based on the assumption that memmap is allocated from the same node
> > > as the hot-plugged/hot-removed memory, which is not always the case.
> > >
> > > In addition, there are challenges with keeping the node id of the memory
> > > that is being remove to the time when memmap accounting is actually
> > > performed: since this is done after remove_pfn_range_from_zone(), and
> > > also after remove_memory_block_devices(). Meaning that we cannot use
> > > pgdat nor walking though memblocks to get the nid.
> > >
> >
> > How about directly include the failing cases and user visible impacts as
> > reported in the Tags appended below.
> 
> Do you mean adding panic backtraces or repro steps to the commit log?

Yes. Perhaps abbreviated but something that makes the connection,
like this:

ndctl users reported a GPF when trying to destroy a namespace:
# ndctl destroy-namespace all -r all -f
Segmentation fault
dmesg:
[] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000005650: 0000 [#1] PREEMPT SMP KASAN
PTI
[] KASAN: probably user-memory-access in range
[0x000000000002b280-0x000000000002b287]
[] CPU: 26 UID: 0 PID: 1868 Comm: ndctl Not tainted 6.11.0-rc1 #1
[] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.20.1 09/13/2023
[] RIP: 0010:mod_node_page_state+0x2a/0x110


cxl-test users report a GPF when trying to unload the test module:
# modrpobe -r cxl-test
dmesg
[] BUG: unable to handle page fault for address: 0000000000004200
[] #PF: supervisor read access in kernel mode
[] #PF: error_code(0x0000) - not-present page
[] PGD 0 P4D 0 
[] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[] CPU: 0 UID: 0 PID: 1076 Comm: modprobe Tainted: G           O     N 6.11.0-rc1 #197
[] Tainted: [O]=OOT_MODULE, [N]=TEST
[] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[] RIP: 0010:mod_node_page_state+0x6/0x90




Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1821C14;
	Thu, 11 Jul 2024 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720657621; cv=none; b=HWS9N96wifThCwJR4qcqhEAe9hVIqGn8zmr/Xz9u75Ywk/c4NaMTagOs4ZjicsFbzADp50reDeTcRepsK4r1O1znKIG84jXnqXCZcLsQ8n/kDAxrjRjSWMQNezR3x2RZagyMc4aYYrlQ65ZI+RBXaGuvZS2HX50JAMI8lMoVUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720657621; c=relaxed/simple;
	bh=UULG4kMeS44p/RRr8g5q9aIR1TLkUQFBx3QaxoMQq4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9kiQI4+PMdCwMKCCsquwlb0Tuh1oHMwoXjUK9YsLozXCh8N82FDdU+xDBAZ48fW3z5KtTML78j3zx8fMiDSFRkm9kSQgMM/ocAB16Z67dl7ZpAEwE0fVZcb9EV+GiM86Rm7z87r/ZcWBuPVel0qh33yPUQ0hYj5K1LiTBdh5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTpPN5R6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTpPN5R6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720657619; x=1752193619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UULG4kMeS44p/RRr8g5q9aIR1TLkUQFBx3QaxoMQq4Y=;
  b=MTpPN5R62N9+H9sRrGSrBzCEMJJUex7sQeYuiSmhyv3mmW/kzTGu4zCD
   c/4qGA/Xbm5CbWD3uRahphUSOztMvWVlUWvVX5kf5DC2bs0fTMB9XfTTO
   /HVVlOM5I9bbc9NPLuDCrFHGU67ijDT13euhUjKETXW4YjSMe7nVpZ601
   PtmzzXHUQsdnMFtEOyioZBfILsiSUaLRm9uv5bzHqzHdrghdDJZJyOy13
   uuiBGbYC7T5cBztvmxDkDzSebygYn0EG3t1lddWPeTJDXyl0JNDGlA+CA
   n7QoCiOBh6vuGtN0/txS3lnfbghDG5vtmbffS+tN25eC+ait4bfxlBi/f
   A==;
X-CSE-ConnectionGUID: 5MXozepuTzGp/vaKvMRLRw==
X-CSE-MsgGUID: lQiHLWqnSZamLc/yJqzUdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21886745"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="21886745"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:26:58 -0700
X-CSE-ConnectionGUID: Lo3xxtleTIesld7r1eYkWQ==
X-CSE-MsgGUID: pJOn2XBiRYOcqGdRYH9Q9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48470956"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.164])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:26:58 -0700
Date: Wed, 10 Jul 2024 17:26:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Address translation for HDM decoding
Message-ID: <Zo8mz6uyQBCxsuJ3@aschofie-mobl2>
References: <20240701174754.967954-1-rrichter@amd.com>
 <Zo8hJm7y9VIwhiDk@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo8hJm7y9VIwhiDk@aschofie-mobl2>

On Wed, Jul 10, 2024 at 05:02:46PM -0700, Alison Schofield wrote:
> On Mon, Jul 01, 2024 at 07:47:48PM +0200, Robert Richter wrote:
> > Default expectation of Linux is that HPA == SPA, which means that
> > hardware addresses in the decoders are the same as the kernel sees
> > them. However, there are platforms where this is not the case and an
> > address translation between decoder's (HPA) and the system's physical
> > addresses (SPA) is needed.
> > 
> > This series implements address translation for HDM decoding. The
> > implementation follows the rule that the representation of hardware
> > address ranges in the kernel are all SPA. If decoder registers (HDM
> > decoder cap or register range) are not SPA, a base offset must be
> > applied. Translation happens when accessing the registers back and
> > forth. After a read access an address will be converted to SPA and
> > before a write access the programmed address is translated from an
> > SPA. The decoder register access can be easily encapsulated by address
> > translation and thus there are only a few places where translation is
> > needed and the code must be changed. This is implemented in patch #2,
> > patch #1 is a prerequisite.
> > 
> > Address translation is restricted to platforms that need it. As such a
> > platform check is needed and a flag is introduced for this (patch #3).
> > 
> > For address translation the base offset must be determined for the
> > memory domain. Depending on the platform there are various options for
> > this. The address range in the CEDT's CFWMS entry of the CXL host
> > bridge can be used to determine the decoder's base address (patch
> > #4). This is enabled for AMD Zen4 platforms (patch #5).
> 
> 
> Hi Robert,
> 
> This HPA->SPA work needs to be done for addresses reported directly by
> devices, ie DPAs in poison and other events - right?
> 
> For the XOR case, we discover the need for HPA->SPA while parsing the
> CFMWS and add a cxl_hpa_to_spa_fn to the struct cxl_root_decoder. Later,
> when the driver wants to translate a DPA (to include in a TRACE_EVENT)
> it uses that 'extra mile' HPA->SPA function.
> 
> See Patch 2 in this series:
> https://lore.kernel.org/cover.1719980933.git.alison.schofield@intel.com/T/#m9206e1f872ef252dbb54ce7f0365f0b267179fda

Better link:
https://lore.kernel.org/linux-cxl/cover.1719980933.git.alison.schofield@intel.com/

> 
> It seems the Zen4 extra mile is a simple offset from the base calc.
> Do you think a zen4 hpa->spa function will fit in with what I've done?
> 
> FWIW I took this code for a spin through cxl-test on it's own and combined
> w the xor address tranlation patch set and no collisions, all humming along
> nicely (for non-zen config).
> 
> --Alison
> 
> > 
> snip
> > 
> 

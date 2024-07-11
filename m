Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F1ECC;
	Thu, 11 Jul 2024 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720656170; cv=none; b=nmeZJvToyV0tSa4j4yyDAEv45TuQOgcT2Rqv82r8CNdOS8xTzSrVaSY9sp+PjYCD8M1zK3qA/51iDpK0lb8p2LlT3e6mOEoGohziT4jiQIcW3/ZTzU/bZ5gTcrdmuYL7u1laEoSBeHPc/iKlgYePrry6JSTzFPG2qpkD8cS8ATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720656170; c=relaxed/simple;
	bh=gZXk03tOfI4YysZGGbHWMfDJKWuJQUW7yaSxuNLFCq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0tcAudFBasiM5eak6EhSOJLInCf9yffpNi3/9NOvmn0vvQi7LcchbO1DGHAUAdEaQX+B9/ndm2QU6osPX6RvyBETGMLGIDcX86S7bf7GwK5aiOpurnkyvv4R76oji1TsAK1245FCGEJdVC6KGF3vXh0SAa0qEn22uCz0Hr015c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g34KOyjz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g34KOyjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720656169; x=1752192169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gZXk03tOfI4YysZGGbHWMfDJKWuJQUW7yaSxuNLFCq8=;
  b=g34KOyjzB+VD/Y3lGEir9d8I9G+4i1O0Mp2ow/niPWpeIRfdxo3gXL94
   O1j8GGQFR8wzeLlivEOGdrq5Tjdf2kZm498CBzHvCJr317C5N63deB7Vu
   KA6wKckbvoN7SLo+GHaFA6jHmIAe4y8LakxScpvA0p+ElwlUMSBxjZdu4
   G739japSHTkoYZkOt3WjgiVCgANxR5FnTXTwrJXKxCadUXP+XJQYdf1w1
   Zuk2+P9kWDH4jvCZErIpxtmrUwYuqPHgc3BN8EQtixSRAAaNHcHGXfTFp
   TFa/6UceylS9XmXgn27fh2vT4b7wKslgRJh7RjGNOhEqeoyPQyrfvkMsJ
   Q==;
X-CSE-ConnectionGUID: BnlhVwuGRqK4AVLJf4RQqw==
X-CSE-MsgGUID: e7i0g+vLS9G4qfL8pOtC6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="28677696"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="28677696"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:02:48 -0700
X-CSE-ConnectionGUID: KT7x+a44QH23EwQE/6dAYQ==
X-CSE-MsgGUID: 2tF9IPlOSQKDKNV6XfkcNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="52682005"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.164])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:02:48 -0700
Date: Wed, 10 Jul 2024 17:02:46 -0700
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
Message-ID: <Zo8hJm7y9VIwhiDk@aschofie-mobl2>
References: <20240701174754.967954-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701174754.967954-1-rrichter@amd.com>

On Mon, Jul 01, 2024 at 07:47:48PM +0200, Robert Richter wrote:
> Default expectation of Linux is that HPA == SPA, which means that
> hardware addresses in the decoders are the same as the kernel sees
> them. However, there are platforms where this is not the case and an
> address translation between decoder's (HPA) and the system's physical
> addresses (SPA) is needed.
> 
> This series implements address translation for HDM decoding. The
> implementation follows the rule that the representation of hardware
> address ranges in the kernel are all SPA. If decoder registers (HDM
> decoder cap or register range) are not SPA, a base offset must be
> applied. Translation happens when accessing the registers back and
> forth. After a read access an address will be converted to SPA and
> before a write access the programmed address is translated from an
> SPA. The decoder register access can be easily encapsulated by address
> translation and thus there are only a few places where translation is
> needed and the code must be changed. This is implemented in patch #2,
> patch #1 is a prerequisite.
> 
> Address translation is restricted to platforms that need it. As such a
> platform check is needed and a flag is introduced for this (patch #3).
> 
> For address translation the base offset must be determined for the
> memory domain. Depending on the platform there are various options for
> this. The address range in the CEDT's CFWMS entry of the CXL host
> bridge can be used to determine the decoder's base address (patch
> #4). This is enabled for AMD Zen4 platforms (patch #5).


Hi Robert,

This HPA->SPA work needs to be done for addresses reported directly by
devices, ie DPAs in poison and other events - right?

For the XOR case, we discover the need for HPA->SPA while parsing the
CFMWS and add a cxl_hpa_to_spa_fn to the struct cxl_root_decoder. Later,
when the driver wants to translate a DPA (to include in a TRACE_EVENT)
it uses that 'extra mile' HPA->SPA function.

See Patch 2 in this series:
https://lore.kernel.org/cover.1719980933.git.alison.schofield@intel.com/T/#m9206e1f872ef252dbb54ce7f0365f0b267179fda

It seems the Zen4 extra mile is a simple offset from the base calc.
Do you think a zen4 hpa->spa function will fit in with what I've done?

FWIW I took this code for a spin through cxl-test on it's own and combined
w the xor address tranlation patch set and no collisions, all humming along
nicely (for non-zen config).

--Alison

> 
snip
> 

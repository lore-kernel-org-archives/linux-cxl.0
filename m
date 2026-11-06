Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982863;
	b=1XrVPM1Yqrabe9dLMxSVlCBmnfQ7beQnXbEy10vxTlCfR6sTj5VCGunW9jDcw+UT8x+n
	 8/B9e2HSj0WWr14z8vEsIAlhDuYrUpszx0u/dbyKlOImfEBDsBP8uPaqVc0OPTboBU581
	 MJfgTmy94R4AYsM5Unc7iZDDib/ZKz0NE9sDJD2fV7hV69zA5wDmaFtRpM9YndqSGQ7mD
	 k3k2VjCF5HNMLLrTOYoEmxjHpHw08z1eVkYSVxb+74qN4OcSy/D8tobDow1yEshwoxTHP
	 kLVevxedjnGMvHCGPuaypnIZaiQpzF7TyP9SGwg4XpnQgchHhkCEVM+JduG36FoPiCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982863;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hShiS2wHrplGH57oemILDzUnWRgevM2iDwnDUnnK9Y0=;
	b=a4LUTDEDa9SZJWkcmKve66PX/fxDZVkhDO6XEhEyEtk8RONMUm+gHuE/3NCaSTtIGPJU
	 +D++FzbriJsscKnz047I0uMiy5Rl+hojsH0JME6hQSB/ua1FgW2h0ScDWXKnXwvTGqQll
	 5W013FoKSIG8PpYaqdqtD1OSo9wf+9NAQyVsMYGsx5CVlaqMfuIGn4xnSmNszbIWMtSny
	 aWl3hJW8L4wdjGEcqFnhwHRZMC/YoR+sZlU1HXYb5dRhkg4rLZxhzm3SZbkVwtL2iQaYZ
	 3AGJoFTP5NCKnxU5e+1xgYKvwmCqwsA3lPGcOQwA0/sOkHvYucdacIafG0YCZlMqOdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fmKG1ZnV;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62A606A329
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 16:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F62A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fmKG1ZnV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793982862; x=1825518862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EGO57QjRei49TznZNzY0gANRNtqg2L6nqP4hln4R3t4=;
  b=fmKG1ZnVn3mquknknmebB4gfbDUp91n+sLToC47+7UOiOWx975BaIUor
   4PAarlAgGdJdoAFrs/mEbNBu3LPa9NbxWVQMt5+54WnNj4ByXsm3AuKAB
   PmprKoKRGqyOLi5/6rroVvIr713Fob71KwMIGUGDQJo4Q6TkGTuGUcM0G
   OcXqYTC17uuBWN6Bw3lcvwVkTAJU9c7ezv2mmimDTWFLaoysfhicocFWd
   qEacz3Hd+m7lfgb8DNi4u7D0vDVaVDSSFldmdcq/z3D7CBHkJIQlXmBgT
   46ufv0a3njb3ZiPJSGyZ3zw0dddTA56PF8Bc042E7Tnw3u8ZTTgdsFte/
   A==;
X-CSE-ConnectionGUID: FRd1m+sKSnCnXvEu8sqWcw==
X-CSE-MsgGUID: HT+KsPe7Rjqcogzv1N8KlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2841267"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2841267"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:34:21 -0800
X-CSE-ConnectionGUID: yytzDt9CT6GKnUf0WMpGQg==
X-CSE-MsgGUID: ZWLqyGrOS1ixi4hCvAY9pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7647868"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.110.174]) ([10.125.110.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:34:20 -0800
Message-ID: <4625b582-4efb-4d41-a984-9c70a3d4a26b@intel.com>
Date: Fri, 6 Nov 2026 09:34:18 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] cxl/test: mock fixups and new topology support
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1793850480.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1793850480.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/26 8:57 PM, Alison Schofield wrote:
> 
> Changes in v3:
> - Rebase onto 7.4-rc1
> 
> Changes in v2:
> - Patch 2: Avoid duplicate look up of auto region window (RichardC)
> - CoverLetter: Add link to the ndctl companion series
> 
> While working to enhance the cxl-cli cxl-create-region command to handle
> out-of-order target lists or no user-supplied target list, I ran into some
> basic issues in the existing command that need to be addressed first.
> Developing tests for those fixes exposed two bugs and a topology gap in
> the cxl_test mock module.
> 
> This cxl_test series addresses those issues:
> 1/3 fixes a DPA skip leak across mock decoder reset.
> 2/3 skips auto-region setup when no volatile window is active.
> 3/3 adds two x1 CFMWS windows needed to exercise root decoder selection.
> 
> A companion ndctl series[1] fixes the existing cxl-create-region issues
> in cxl-cli, clearing the way for out-of-order or automatically generated
> target lists.
> 
> These changes preserve the existing cxl_test unit test behavior while
> enabling new create-region test cases.
> 
> [1] https://lore.kernel.org/nvdimm/cover.1790658549.git.alison.schofield@intel.com/
> 
> 
> Alison Schofield (3):
>   tools/testing/cxl: Preserve DPA skip across mock decoder reset
>   tools/testing/cxl: Skip the auto region when no volatile window is active
>   tools/testing/cxl: Add CFMWS windows for region selection tests
> 
>  tools/testing/cxl/test/cxl.c | 116 ++++++++++++++++++++++++++---------
>  1 file changed, 87 insertions(+), 29 deletions(-)
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

Applied to cxl/next
4d9f66751dd4 tools/testing/cxl: Add CFMWS windows for region selection tests
a7c6a06c19d7 tools/testing/cxl: Skip the auto region when no volatile window is active
aa6558a48986 tools/testing/cxl: Preserve DPA skip across mock decoder reset


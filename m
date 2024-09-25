Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC12210E9
	for <linux-cxl@vger.kernel.org>; Wed, 25 Sep 2024 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285256; cv=none; b=LN8k8M1IJV8tRiOSQhNfqbK2vYtO5WRt5cXL8dXnGdIlVb/TXaL/FmPLAB1cVQaImqGASxD+PgK04+jPR+Lt04JR4YLEbKKgTAjkmeuk9ug3t+Z61QHash9JNn8jx7FNNTo+3Au4POUqpCcZhtBueGVu6j73Vdq6f8OtDgmh8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285256; c=relaxed/simple;
	bh=q7QLqjJmkLYwJvlAce+2Dd3xdQJ1kbRIU0M1oOv9qxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CugkwY+g7AeXQBXLtczYH5pk+B4zwXdlfJlKOGHPBBQs4qEwdpIbwbA/AqNomc2ONH8pCxilnM+veI/GNUl0pWZ+9ef/0k7xdxvtgOFTkyjlup8BjHffCZwGIRmaU7hwifLk0yrpHI/MwuEQMFudGaL/+Xl1y6AmfCFhjz2Q4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W24fk0ZR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W24fk0ZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727285255; x=1758821255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7QLqjJmkLYwJvlAce+2Dd3xdQJ1kbRIU0M1oOv9qxM=;
  b=W24fk0ZRH1zk1Md35ub+CHEFCAw3Xivm8Zm4MiTKg6w7W31+jWDvi9N0
   w6wg/rsDS4iSyI7MM9/L1+ygczeXRPVfRrSbxxmX1f8d2BonT2jl12b61
   y5oUQmB2ijdthvcqQUf4HhWN4PbzVYy59lbUSW6MFF0fVU7413uFUpE/x
   EcDIRmgNOZCZ0er1JDX1XDBCElPG8NTHPzijGxXIKcmmHEDct4DVFKBXT
   SgTy5xG0Esp9SaPMXbYRV71OrmcJpzXEI+0O99slGIN6E8Om0cShKvNGi
   7jicYQGBejSTuRp7nPsZcFPnynKoy+dnm//5Vo8WMu2a0jKyzE4Yze0/x
   w==;
X-CSE-ConnectionGUID: NuvSetZgTOaYzWT8GluWxw==
X-CSE-MsgGUID: GUSBEUX5RNyNhs/91vmRPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37494169"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="37494169"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 10:27:34 -0700
X-CSE-ConnectionGUID: DBJ3gCK0Que+K82X3T1P8A==
X-CSE-MsgGUID: vgrw4+cHRmCYDSqi326/tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="72152199"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.94])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 10:27:34 -0700
Date: Wed, 25 Sep 2024 10:27:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: How to start sanitize?
Message-ID: <ZvRIA27BPRQNtzaR@aschofie-mobl2.lan>
References: <TYRPR01MB12335599B869ED3E7716A758790692@TYRPR01MB12335.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYRPR01MB12335599B869ED3E7716A758790692@TYRPR01MB12335.jpnprd01.prod.outlook.com>

On Wed, Sep 25, 2024 at 10:41:46AM +0000, Yasunori Gotou (Fujitsu) wrote:
> Hello,
> 
> I have a question about sanitize feature for cxl memory.
> 
> How to start the sanitize feature for a cxl memory device?
> Is it just writing "1" to /sys/bus/cxl/devices/memX/security/sanitize ?

The CXL unit test, cxl-sanitize.sh, demonstrates the ABI.
5db52b115620 ("cxl/test: Validate sanitize notifications")
Hope that's helpful,
Alison

> 
> I found cxl command has "cxl wait-sanitize" feature, but it seems to just wait the completion of sanitize,
> and not to start it. In my understanding, there is no feature to start sanitize in cxl command.
> 
> Are there any plan to make "cxl start-sanitize" command?
> 
> Thanks,
> 
> 

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8918A950;
	Thu, 29 Aug 2024 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967934; cv=none; b=HOpiLLoHnFTb7zDG+AoLLcQ8B9+M+vkynwsHl4ewVNXJ3iBROSADunDBcAVHSyX85SPqA8Au+Pz78YaEMyMc0NPhn0GY4WTU/4bQyJm+LFvkGtHPXgPxedt88wbk4pHNRtPyEPnswzILc7XrwhASRy4NCrhCZ7cAVZffQ/WpMhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967934; c=relaxed/simple;
	bh=snHuENsOaG18kxcnk2zoqryya43r3DiwgUZuktGuYFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2SGjq6LngJy7IYgLz681jR9nlMjasb1N1UArNqBKpVzc3w0HwEAuxL0DeotKibnnsIfSo/Ve2Jm7lvqMj2vxnH02Oei+YcAIyTeHgp7LVzeCZkn3GMZ16VRrPC6DVm33CSevWFOKnw9t3Es+fVYdbdlTrqid6mzcO6l4duuTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoPJZUZ3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoPJZUZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724967932; x=1756503932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=snHuENsOaG18kxcnk2zoqryya43r3DiwgUZuktGuYFs=;
  b=EoPJZUZ3UM28uCGxWHdlWfMnNfLQH0xgLFInH+rJ+F9Owk04ud+pf7S2
   zhowOO52Ki14fnM4E5Zc7kQLRgIZLEAKLaMoDD7yGDuEEZbT45jSvS0b6
   xngN1QmLZkp5X2OSc6v16IvwWWSiK8qSCBOEdUsuKz/RsdRCmQcSbX/Xk
   O51p+RsYorhQtyF19qxxQct7orQj+X2WJMF5VliX9GM5wj2+2m4/oG/o1
   lQZXLz2kYFkc4g9KRxVJLz+DIW5vX27QBQ3WFHfKyGsjkYnJvKVTmKblk
   VgcJkykzuTtvIlRauS9jCYDLZ86dwaedqy4Py1h8hbJ2grtxflRxBXiGJ
   A==;
X-CSE-ConnectionGUID: I526JoIFTg2ZC77ekMFZ7A==
X-CSE-MsgGUID: bxlAX49gR42SJ3/sFdXv1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34756996"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34756996"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:45:31 -0700
X-CSE-ConnectionGUID: ESQkYWArSsSIMmxIG1I6JA==
X-CSE-MsgGUID: dWlWXyf5StmKlhLL3SV/RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68098790"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.219])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:45:32 -0700
Date: Thu, 29 Aug 2024 14:45:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yuesong Li <liyuesong@vivo.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, rrichter@amd.com, terry.bowman@amd.com,
	Benjamin.Cheatham@amd.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] cxl/port: Convert to use ERR_CAST()
Message-ID: <ZtDr-by3dPFdMuoP@aschofie-mobl2.lan>
References: <20240829125235.3266865-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829125235.3266865-1-liyuesong@vivo.com>

On Thu, Aug 29, 2024 at 08:52:35PM +0800, Yuesong Li wrote:
> Use ERR_CAST() as it is designed for casting an error pointer to
> another type.
> 
> This macro utilizes the __force and __must_check modifiers, which instruct
> the compiler to verify for errors at the locations where it is employed.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> ---
>  drivers/cxl/core/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

snip

> 

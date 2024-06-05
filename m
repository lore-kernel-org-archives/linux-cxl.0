Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE83481B3
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601728; cv=none; b=paz8sgU01lSn2ka+lRw4Zq1h+Hhny5Il0Z91vKvsusNDzGV6xeZ+3BZg4oftBG36i0Bnjl5FS2UgLobyjgg5RDUQ4Dr3IagUJH3lnSbWWUtizZUc2gOXR3vaIL/NGNJmHK31yJJMqFKo0tY7Oh13WZmWnPj1EH1+3B8+SQTw8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601728; c=relaxed/simple;
	bh=pxfLMhTQqsSMto6hdAnX1hOyE18vlTV/ilQk7HVXzmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qwp1Z7aL36YV0s/FpoxFSpFUNAXQran35Z/VH8T9Y0SB2kqifYJdRt/bm6ulhsG4aO+8Soc0Rz0aA4TNff1cDCowpC6ak4Nrxgu40/KWCN+A5Yy3lw4XAeoA9vyvT0O6WjiaXeHTKTPIoquwYNw7hzlrWA0T1MtZrZ9lWoS9xY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLf0S9MQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLf0S9MQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717601726; x=1749137726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pxfLMhTQqsSMto6hdAnX1hOyE18vlTV/ilQk7HVXzmg=;
  b=MLf0S9MQCDrWpQ/QNHPpwTzbdxs4H6XTTDdT+K5+n38qxn9aACAgksAu
   kJCr7UHY897uQVWoJJUqBexSzBFEZVutZrwEMiZQDlx7lXclQss1BAOdA
   sXC9DC0pbM8LdTqREsCqevpUqPTyGdPbfWVfSx3yqejtjbSctKbrBdcJX
   73EsVa1hPnb56M7mtFtpLiISRfCWMZE1WPNBY2pGELGMSSeWjInTEeUnb
   0Jwr1INHQjcqyiNSQHU1vULY1IqlqlxyOBwIz4s0+auPIQ2OI9xCGpyvV
   RHhq88O2+dPISLCAHnjkcjtUszvfTuwXk+Qg/0qkIut01iv6zVUe8YAPe
   w==;
X-CSE-ConnectionGUID: uzPvDdCKRGCd6TQJSrgm9Q==
X-CSE-MsgGUID: uJmMeJvqQuSadJnt0eWXyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25334869"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="25334869"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:35:26 -0700
X-CSE-ConnectionGUID: Hdphm0IlQQy0Qrr8CYwkvA==
X-CSE-MsgGUID: THxSkALhQr6wRL9LVAgHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42575713"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.22.89])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:35:25 -0700
Date: Wed, 5 Jun 2024 08:35:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Foryun Ma <foryun.ma@jaguarmicro.com>
Cc: dan.j.williams@intel.com, angus.chen@jaguarmicro.com,
	dave.jiang@intel.com, dave@stgolabs.net, linux-cxl@vger.kernel.org,
	rrichter@amd.com
Subject: Re: [PATCH v3] cxl/core/pci: Move reading of control register to
 immediately before usage
Message-ID: <ZmCFu0US7IBuPCk2@aschofie-mobl2>
References: <20240604032151.655-1-foryun.ma@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604032151.655-1-foryun.ma@jaguarmicro.com>

On Tue, Jun 04, 2024 at 11:21:51AM +0800, Foryun Ma wrote:
> Relocate the reading of the DVSEC control register to immediately
> before usage and avoid unnecessary PCI config access from the read
> if DVSEC capability check, hdm_count check, or device validity check
> results in failure.
> 
> Signed-off-by: Foryun Ma <foryun.ma@jaguarmicro.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


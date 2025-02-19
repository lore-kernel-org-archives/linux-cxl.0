Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCE8F7D;
	Wed, 19 Feb 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988329; cv=none; b=hYwKai0y9a5eQL9nq01Y5aeyl9GuJeL3VZcsxuHaWX9PoHlrHea7pjlFxT6ger2FovCyaLssuqR+qg/siYfIyu0prYUYizSMBytgLgxG4e0sExyjU/dPqVJ+OjKnbQvYYE/uE3nAjV3TdXq70V/a7TCbFAxtMR/quWsKLeOFFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988329; c=relaxed/simple;
	bh=Ngnc6yPPF9a3q4ynxZspBzCReKVwJEbw+SE2Yv4Oy9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXMugAiOFchoJNA/kBj9wdoyUYxtkXHRWC+XOn0RcJrEB5hr+2rOhF8We4YCHW5BnlSvr3FXl5EPh4XqotCpBJGB6E2c+YViD4HKbeneEb1xbm+8YX8a4cp9TrpKRrZOXee60qOccwmXSaU4XL6hLFtRfM6MJBiz+IqkueanPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwcfDsLr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwcfDsLr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739988328; x=1771524328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ngnc6yPPF9a3q4ynxZspBzCReKVwJEbw+SE2Yv4Oy9k=;
  b=KwcfDsLrRZ8fDrJ+rKznSRU7PSxZE3uYsa17I+H95NfxXcDhG1JMvQoB
   xE6vxXQHmrP2Y9l2fRa0gj9OcOPCXeo1HYt0z6bmO6hAXhe7yfeDGyD+O
   pSl0CIthfleAevVDpAXZum1+6tMXkqFzB/wiuB2NGIsK0XQwpWJaLzkU9
   Lu5lRM+JgiWts+AEk97LoSwyFlQQhW7u0uV+FzSueQF4nPe1NbKE5KydF
   DNoViz+i0FT8dYHmS4b1uMV/vYPzddx5+zIbjMweTq4ymNGzHutj3PaUD
   GSFglI2BiiGyaWPro+TApcAQdQfWdiLB4tcJR7xXT4OzxOt3qkEX+3EGa
   Q==;
X-CSE-ConnectionGUID: jiaFaKBrQw23uiMdjdGIUg==
X-CSE-MsgGUID: EYOHzUrMQC6hLWym+omavg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="66097712"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="66097712"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:05:23 -0800
X-CSE-ConnectionGUID: XDAsImKyRjWFGL1wU6uWXw==
X-CSE-MsgGUID: jXZFRzS4TOuiZNk+OGejbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114534645"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.15])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:35:34 -0800
Date: Wed, 19 Feb 2025 09:35:28 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] cxl/memdev: cxl_memdev_ioctl() cleanup
Message-ID: <Z7YWYDfqR1jc0t1N@aschofie-mobl2.lan>
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-4-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-4-ming.li@zohomail.com>

On Mon, Feb 17, 2025 at 10:48:24PM +0800, Li Ming wrote:
> In cxl_memdev_ioctl(), the down_read(&cxl_memdev_rwsem) and
> up_read(&cxl_memdev_rwsem) can be replaced by a
> guard(rwsem_read)(&cxl_memdev_rwsem), it helps to remove the open-coded
> up_read(&cxl_memdev_rwsem). Besides, the local var 'rc' can be also
> removed to make the code more cleaner.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

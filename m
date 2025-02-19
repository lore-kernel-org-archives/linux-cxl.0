Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BE126BFA;
	Wed, 19 Feb 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989595; cv=none; b=p+QZ3hCu7YeH/TwdJw+EoJVXzINHB83MHFfbh1Eg05IeoaX608QctCADb3PjkFELjkjFr9OCjvHZ7BfcKg8PaJ+B7qudrtcJQqo6mcPrckU8h+XJ+XUfw2Y0U7tn68h7IzLoo0fed1Hrv1eGi7dhoFsKP+0z9iwtE4UnzcBfCKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989595; c=relaxed/simple;
	bh=J9nejIYo+VlPUsyivsCMZuxiVZl3v9sewy19d7xGe48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONUrTPk4vFRk5ug4ovRGJiEqWIKUp8TkfSFk9tGYTfgf9cf9OqS1tTpdKoxEgwsD7GAy2iHOmEaqj0DLcBmbZP4iatU+uqzy0DZ+73lmYn24NUF4f2O/0QynGS1uKETtjOl1U/MNylH//JLnmu57fApx8QrzZAQOGp8EM9ucq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4QxGeeh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4QxGeeh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739989594; x=1771525594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J9nejIYo+VlPUsyivsCMZuxiVZl3v9sewy19d7xGe48=;
  b=H4QxGeehUZ7edq4AWjIP+cA/lucqo3jatXeK+m4uCdnVFbW5HJUrWnXJ
   Birrt7Zdt9HPV4t48EJA7DMYEC5gvorFgkEJ3Z5knjVJMH1eWFVMmBOeJ
   UlvKeMvTXHq5g5jIEk2mlT+yy4irxI3psm6IGhtdRJ45nqo2L5cmG3ibS
   zP2DD0PXBZFsT4sUM3eIEwTFSL7RZ9mKJLl1rS2gZv0GUhjBzESl81zN4
   KLlx9kk0St3KFTwb/nRvfEmKVNDOkONX+1jZjsbtpAh4CzKy+hZhYhVfH
   cMW0AhJGF/KOH2V5GPa/kwOJnf7Gp8tLdSUCs8J5ceasFzx0eXwVIMdd6
   Q==;
X-CSE-ConnectionGUID: ix4thxFmQQKKBKBzk7r+Sw==
X-CSE-MsgGUID: TKN9qzLFQxCsMF7noZeCnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51725362"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="51725362"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:26:33 -0800
X-CSE-ConnectionGUID: 75iN1BC6SciVEJA1N4GuFA==
X-CSE-MsgGUID: 3nOx3ntqRpaO2ywTgdjifg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119907906"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.15])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:38:48 -0800
Date: Wed, 19 Feb 2025 09:38:39 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] cxl/region: Drop goto pattern of
 construct_region()
Message-ID: <Z7YXHwN2LSSC5rVe@aschofie-mobl2.lan>
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-8-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-8-ming.li@zohomail.com>

On Mon, Feb 17, 2025 at 10:48:28PM +0800, Li Ming wrote:
> Some operations need to be protected by the cxl_region_rwsem in
> construct_region(). Currently, construct_region() uses down_write() and
> up_write() for the cxl_region_rwsem locking, so there is a goto pattern
> after down_write() invoked to release cxl_region_rwsem.
> 
> construct region() can be optimized to remove the goto pattern. The
> changes are creating a new function called construct_auto_region() which
> will include all checking and operations protected by the
> cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
> and up_write() in construct_auto_region().
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

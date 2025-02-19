Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA91E47A5;
	Wed, 19 Feb 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986673; cv=none; b=GWGJ8JeKPoBJmgozrZIIHc9IxLGjFj9BKhD0nHfYP38n8BZJV3vawlb52//voly3wuycKdzjUXwALQR+XJphFbDsLA/p/FYlq6MzSP30L6RvXiMUaYI8EdLEJvrSWEYDMrfpe7gjBSR/C/9Sen1OelrabTrLpdyX1XedIzH+vVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986673; c=relaxed/simple;
	bh=u9VRqA03kLPw3+e8FeK1sFHWIeVA9zPZq2v+Hd4BksI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbQXNyoFqfnhS+KMRH3aQ9c3yJH2hK9FraEEnapzfe9+c9UtCmg6ZX9WPlwjcDcT3vS77qs1uWBeLsQYPcbuW9dFIUCLyirt0KxCt8LtFqnIIZh8ydk6/yK9nDvDhrZzQIuqhLmnosvoCax+wp7G9uyP6MDnMs9PSaf5cFa02Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vd04CzTe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vd04CzTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739986672; x=1771522672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u9VRqA03kLPw3+e8FeK1sFHWIeVA9zPZq2v+Hd4BksI=;
  b=Vd04CzTeR40u7/B4uvL8u0QBlIfggAoWfzgsBFTqokk+vHo8mXU3UEZx
   wPg4funaxqtwWyj88WtY0lIaWBkpBPRUR8Wa7y55vj91agSEWzuRg6sM6
   b0ndWL8uVr7jMBHCUM/YoifAJDS8YUOpIqn1DJyjhJVz6/snjWWD1rkWr
   5nMPK1LvSvr+EJ6brwa8+Rlf/v+cE4QWDfuFBxXMESoglen38Y/jq9wRd
   99+qONo3FW6/t/q+iLMRQJ9NgkmGY+aTXfaXR9MBzIp0uB5AFDJ1U4mcK
   SSxD8qoysCP1EwHZGwmqs6CqZzqBqdePjVi41z5iq5+uxuHLRZM7dMSXm
   Q==;
X-CSE-ConnectionGUID: Zr3xlfYKR0qVBxID9BrMcw==
X-CSE-MsgGUID: JTIXOjXYSXitEDvMfHTNwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39968988"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="39968988"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:37:50 -0800
X-CSE-ConnectionGUID: pw6iRB9XQvGj/R1y2hwtuQ==
X-CSE-MsgGUID: lrM1DyJgRKin/vs/ixMrrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114755933"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.15])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:36:14 -0800
Date: Wed, 19 Feb 2025 09:36:07 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] cxl/core: Use guard() to drop the goto pattern of
 cxl_dpa_free()
Message-ID: <Z7YWh3ofR0_KxIL1@aschofie-mobl2.lan>
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-5-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-5-ming.li@zohomail.com>

On Mon, Feb 17, 2025 at 10:48:25PM +0800, Li Ming wrote:
> cxl_dpa_free() has a goto pattern to call up_write() for cxl_dpa_rwsem,
> it can be removed by using a guard() to replace the down_write() and
> up_write().
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip


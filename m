Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6828E214A93;
	Wed, 19 Feb 2025 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994958; cv=none; b=JnfT4uyn0KZYxIbXyW1W9VZKsg785BqnVnmJK8dKHUAaaFZpcnlmkQ6Le1qWoUdxGQFkZy0S2H3cmlpNwnV3/CSKasAxN/WmNlxeaTpYEcW7bFIqgn9galSqC4CZJSiw5vC5DYhDV89++rP1dL0v7q4SPF7rqskPDAZNLPAMcMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994958; c=relaxed/simple;
	bh=XYRLO9Nx/3iNwg2W/mBPrYLGRCXl0xLmYjE0QIkqthc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smWgvJehiPj17z5I+jRQ/JhpDikZ2HqZg0VE8J61OP1lTxU3bqJlm3EBr5oW1VeFGl1A/u0Fm9M//x1rWMVWvb6iham7cSB8u5dXwf4M7vkTLrbkc/09Hhq81guEw51rMPzRXz2JOwIfJCz/CDMHvNcgl7YVd/Va7x25o91MQCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCd8yD67; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCd8yD67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739994956; x=1771530956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XYRLO9Nx/3iNwg2W/mBPrYLGRCXl0xLmYjE0QIkqthc=;
  b=RCd8yD67Gq6zSEi3hck4SFOKTU8KA3+/qpPpPI4jJKjJ4xZo+VFZjde8
   +6n679hxRpbzRr7/kYE9cxNJh53dgKQMnD4LZi72YlAj/TOrU6KYkqQar
   x/wYQffo7kzRbZqBxGuvd5ESXjwu4FvyXAXQQA/4BHGh+BonLLH6aKIdl
   M69ooZYQGvswd71V0qjI/4jyx98BOFO85vExrpBfWMX2UkJzaVBjeRV6a
   /zQpD1+dgSREF11+cSXLyRULJ+1/1J/b4gW52XSXHbU2+ZKPtF5b2ve6u
   +SCY5XEnEvS9idQPiKbn6KH8ScOIvKdISr3uydPDosQswHSr1OBsYnygN
   A==;
X-CSE-ConnectionGUID: TFuIKCP/R/q7+XbCNGoHzw==
X-CSE-MsgGUID: ZHZUKLy8RNSZbm47H0C07A==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40617957"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40617957"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:55:56 -0800
X-CSE-ConnectionGUID: r8AT+bCDRyq5CN6xisywsg==
X-CSE-MsgGUID: 31hUtXCeR8a7kxAUgFFs2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152026501"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:43 -0800
Date: Wed, 19 Feb 2025 11:29:31 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, chenbaozi@phytium.com.cn
Subject: Re: [PATCH v5 1/1] cxl/pmem: debug invalid serial number data
Message-ID: <Z7YxG6o4b5CVNErZ@aschofie-mobl2.lan>
References: <20250219040029.515451-1-wangyuquan1236@phytium.com.cn>
 <20250219040029.515451-2-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219040029.515451-2-wangyuquan1236@phytium.com.cn>

On Wed, Feb 19, 2025 at 12:00:29PM +0800, Yuquan Wang wrote:
> In a nvdimm interleave-set each device with an invalid or zero
> serial number may cause pmem region initialization to fail, but in
> cxl case such device could still set cookies of nd_interleave_set
> and create a nvdimm pmem region.
> 
> This adds the validation of serial number in cxl pmem region creation.
> The event of no serial number would cause to fail to set the cookie
> and pmem region.
> 
> For cxl-test to work properly, always +1 on mock device's serial
> number.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Re-applying my tag-

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip
> 

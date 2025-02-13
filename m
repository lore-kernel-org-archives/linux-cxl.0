Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4D28A2AA;
	Thu, 13 Feb 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465238; cv=none; b=Bmx1ZaBGu0YmQDM1S20yI47qGkIYqD1ynlhCqAeFqVt8pxAmLiKzwg6WPTUB3TEm+LpfwvjnW7Q67zIxQYbo60zx8janLnDN8HnNhcaSsqzWYdEPw8oD5NsPb23r5oaORe2XYvH8OQvoeg+slXmlFfSBF781iIt+ol45/UlKOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465238; c=relaxed/simple;
	bh=2AeFDPvSDQR2jQmWqn2taWIaXObbR+ewkk3H+rYzcmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+xmFKyzIijfaPBKRRxNRapK9qHkqWFgTG5hjEmQZtxEjr0Mdir9vw689l9fF+1iWf3S8+McEGfoggA761wpFhyIQnN0On3xfD3GTFQkJUthOP2R79bLK0X14BkSxv7xTgh9Emt90TCvLDYivP054JT/qKxkEeU+MyKNdCjTGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoL268Ux; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoL268Ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739465237; x=1771001237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2AeFDPvSDQR2jQmWqn2taWIaXObbR+ewkk3H+rYzcmA=;
  b=CoL268Ux3exPBrM598eYd2WbgkCl+c/U+5CxL0TyqleS5Hh78MGWajdG
   JZtWj2WjOxyo/Fe6Ui4k4bbynegvclnwZLKmhHZYyTbN/Z35fARn8JilA
   OtpttXTIJCI48kCCl9cQng/5O5WmeIOijE/KVEBcgy5xSDVYtvA6K37sl
   pHSL4ywp8M3ZWftJBXY3FiYMwFjEBfSIL07Ij1GP0HZDGPdlbhJJdn/uM
   XYuBAwE7nme4UqmKt95rZf9DqkiLRa02K1xIWnPZF8kb8K9g/lWkjRpoz
   jsNrMN6HdhR0Odew1UNuDO/d98+Rnlj89fpTEY9b9BywXA80KMY/1VqKV
   w==;
X-CSE-ConnectionGUID: mzuJrP1JReuIKmsWzSZTRA==
X-CSE-MsgGUID: 1a2beVmLT7aL04UAGQT/ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40301196"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40301196"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 08:47:16 -0800
X-CSE-ConnectionGUID: uZisR2uhTGCSMQFeVH0q7A==
X-CSE-MsgGUID: oswSS3RERG2FpKEk2Ih1Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113688772"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.202])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 08:47:15 -0800
Date: Thu, 13 Feb 2025 08:47:12 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/pmem: debug invalid serial number data
Message-ID: <Z64iEJB6l8xhDsGj@aschofie-mobl2.lan>
References: <20250213064008.4032730-1-wangyuquan1236@phytium.com.cn>
 <20250213064008.4032730-2-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213064008.4032730-2-wangyuquan1236@phytium.com.cn>

On Thu, Feb 13, 2025 at 02:40:08PM +0800, Yuquan Wang wrote:
> In a nvdimm interleave-set each device with an invalid or zero
> serial number may cause pmem region initialization to fail, but in
> cxl case such device could still set cookies of nd_interleave_set
> and create a nvdimm pmem region.
> 
> This adds the validation of serial number in cxl pmem region creation.
> The event of no serial number would cause to fail to set the cookie
> and pmem region.

This trips up cxl-test where a mock serial number is set from the
platform device id and 0 is a valid platform device id.

Take a look at doing this cxl_mock_mem_probe():
-       cxlds->serial = pdev->id;
+       cxlds->serial = pdev->id + 1;

--snip


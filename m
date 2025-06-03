Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDAD238C34
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959253; cv=none; b=Ueix6V1rFq7ZxaC5rYTjLfFfUl0V8kzLlGEQxOHKhRaCtGqsq5oejGPyYwbvsv+3y54byjGdNTxMMlRFLGKima9hdTXulij1zSFxTBLRebepL+aF0nZZOesEXX2xlgPLc+mVEFnBDj6WE+R9UkstgckDlF0gaPP/CzN+TE1tlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959253; c=relaxed/simple;
	bh=NHiib8ex5nQmGUHfV8CWHB2qBWj2cvZKJi/TJZ9JG78=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jc/DIE2fNUPpan9TcL7tei4gwKxEAGRltJCKsBlmicIeKh8Vu6X/+3gvP+Y/2V8SicUWuOBWAA51aE012Ne/461Kl1/aywY51DEwnbsj+lzXHiIaRMP0oJgf/SwOtqV7Zo22Zlma//qXBc5LibYAtqoWo83fX2vANNBHsAT6Z7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJJRKa2w; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJJRKa2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748959252; x=1780495252;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=NHiib8ex5nQmGUHfV8CWHB2qBWj2cvZKJi/TJZ9JG78=;
  b=ZJJRKa2woO3N0lF1ibYo62nS3EgmZiC+6iZ8o7mOWHU6+fQ2ZdMJJJBI
   PXBOgbU8ORG0VXu5pCtMd2wBQVHTbuuii4rbQRwFQLlO84fAry5d143bn
   xJzvLtgAvQCYlY9+eNQc7fzrdv+ZmBs619/FTyNx2XcOx2kVY4b4ba43x
   1GlbYLLb2IRvxnlTI9ln8GLRScg6UcouK5un1oxUK4JiVeptaGXQf6MUA
   rqJ8S2kr9GTGSLKN1SMHvY1feCDX5B/yQO2eykYdsj3jY6XUTYQj9qV0i
   lmZUVpYwUF/nkg5UC/yNB63nuBjePKiwNjDFQKhVlbr1Hh51Xhl4sg3aZ
   A==;
X-CSE-ConnectionGUID: kPR8JoHOQ1uj9QUIZYKycQ==
X-CSE-MsgGUID: +wJ+QzkjTn2PRW59cUgT5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50917413"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="50917413"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:00:51 -0700
X-CSE-ConnectionGUID: zxyhYhu5SYqTM46FZ9xdpw==
X-CSE-MsgGUID: dqy/DmYoRia3loF8iQ67zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144898140"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:00:51 -0700
Message-ID: <48e4eee5-aed0-4ec1-bf2c-88a865be3c9b@intel.com>
Date: Tue, 3 Jun 2025 07:00:50 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel test setup
To: Itaru Kitayama <itaru.kitayama@linux.dev>, linux-cxl@vger.kernel.org
References: <0A157714-A431-4AAB-A4E6-DB0C32DB73E9@linux.dev>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0A157714-A431-4AAB-A4E6-DB0C32DB73E9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/1/25 3:03 PM, Itaru Kitayama wrote:
> Hi Alison, all,
> 
> Your comments cleared up my incorrect assumption (in order for meson test —suite cxl to success, CXL device emulation is required):
> 
> https://lore.kernel.org/linux-cxl/aC_rWIc9TY5F2wGf@aschofie-mobl2.lan/
> 
> Now I wonder, thanks to Jonathan’s QEMU series being proposed to upstream, if it is possible to test the CXL “next" kernel in a fully CXL devices emulated environment be it on arm/virt or q35 machine. What do you think?

I think a new group of tests are needed if we (the community) want tests against QEMU emulation. I would love to see that addition to add more robustness to kernel CXL regression testing. The current tests are written exclusively for cxl_test. There are certain design choices made and certain test cases specifically created by cxl_test to exercise kernel paths. As always, patches are welcome to augment CXL CLI package testing. :)

> 
> Itaru.


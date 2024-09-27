Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B9169397
	for <linux-cxl@vger.kernel.org>; Fri, 27 Sep 2024 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456143; cv=none; b=lLeBzggti0JNyKLs2XAJzLmgE8iz+OyLOwGdUu0TCP0QGlrvbwRRdS+tufnvlhMNFhEjwZktF0EGak04J7kbgxnTh9HRSCjWgqf3wqlhWQp0p6MxL07WkZHncnO5LyQahU/FmSx7iQOqntpJyOec7PSfd/UojP1c2evf8/2i7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456143; c=relaxed/simple;
	bh=KrmWNmS7xURzFUe6K/r7NS+2OY6UzzyHZpo7cB8DyzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBOHQtsLs5YZVSRifwdOIaTREziEvEvrkFYW947KCm+bF0RqpEDYGX93q7yM6I1/Tu7LZEY5UTpYycpJCQOr6QZWeTBBVep5oRUAM/0nyHbzaS+8OyvO/SKJ06eeRLSF/Ys3Tlc8G4TqxGsapBgL1MT+fJMyZMtqK0deTdhI10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDuWSd9f; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDuWSd9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727456142; x=1758992142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KrmWNmS7xURzFUe6K/r7NS+2OY6UzzyHZpo7cB8DyzI=;
  b=jDuWSd9fbSSXmOXrGnsXYmasywTOl7BdQdTOSVDhaTH6o9Hwehk5Jp5F
   ohz4+0bkNjK0S3piGaBV2W3qWStYbJCuNLRnQvmK28Q/t3GdTJsXeRea7
   oTnk6tUEn5CHpeblV6GEhd41m7i1Q/9CSAw027uAHS1GhwokLtCI1ZENy
   fjCd2aovxOJdQ1NKcpuJhq5d5cgx3tlKU8uPlz2a7FXg8kN6I3VToByuI
   suyZdFohOKVXB77FQfx4wSOdkA3mYhehjhuCOm9Gq6N0PuCZI5aBIdahV
   Ms9yIIMV4Z3cs3sXRR1em6dbhtu9E31CqUsJYvo9rsq6HVKydDI/QKGqi
   Q==;
X-CSE-ConnectionGUID: 20x6HIM2TxqPpnRzY0YANA==
X-CSE-MsgGUID: d0Dq4lKuQqa3sqtH2QPVEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="37968265"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="37968265"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 09:55:41 -0700
X-CSE-ConnectionGUID: sCmJm2yJSTqmOqZeFhmETA==
X-CSE-MsgGUID: xSbFCQB8Q0OEtuJI8/g7Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="72474270"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.33]) ([10.125.108.33])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 09:55:39 -0700
Message-ID: <d79a7ae5-0324-4ebe-b2ee-d1647138509a@intel.com>
Date: Fri, 27 Sep 2024 09:55:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <9c4d4de9-5c24-4644-ba41-875bf19da10b@intel.com>
 <CAHk-=wiDV8FZ1orKBAXt9dV5iCQUY6_APGajH8ta94burg9KEQ@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAHk-=wiDV8FZ1orKBAXt9dV5iCQUY6_APGajH8ta94burg9KEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/24 9:22 AM, Linus Torvalds wrote:
> On Fri, 27 Sept 2024 at 07:03, Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-for-6.12
> 
> No such tag.
> 
> I see the top commit you reference in the 'next' branch, but I think
> you forgot to push out the signed tag.

Ooops sorry about that. I accidentally pushed to my personal kernel.org tree instead of the cxl korg tree and thinking I had the tag pushed out. Should be there now. Thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tag/?h=cxl-for-6.12


> 
>                Linus


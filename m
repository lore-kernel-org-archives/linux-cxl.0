Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED222087;
	Thu, 20 Feb 2025 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085427; cv=none; b=lp+dWA+vwjO5NHyW7qE8z3MKltAmz8w0e0RBb9ioMR6PUc2Y8o0TDz36OGrso1z5Kv982wJhBzNtGHG4gT8kmIEIsoWlIFVdqUvk0gdXyHlojrDToPuAVNZeTrID94sa2iDmMOBoUuVywYUeNBxl9Kn5uHHcHgZ24wFuFPf9Tgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085427; c=relaxed/simple;
	bh=rkSiACBg6yH6Wh57AsJ2Ha+dHnFxsBhGAna6YaneR7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEEFaiK3mxSNLm7EDc+ywaMVbg1STODpgbHfsOohqFW31Z7uv4IXvKVm8OgQVxuj5mYIQV8TX0NWpdIse6yPOBh70jg8GJx914EJLTApSTMeikqQuYN1WvZhR6zalMcT/bqq1v6tf5KDnLDm3Nw9SJO4nrqj34aMFuf5pOmvY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cV/p1Gqh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cV/p1Gqh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740085425; x=1771621425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rkSiACBg6yH6Wh57AsJ2Ha+dHnFxsBhGAna6YaneR7Y=;
  b=cV/p1GqhDkiXxIAAWPe3etX77LiC/SYxgKoolh0rYCRQoCIFZ+8NFnta
   CirH6Su3XUYOLA+Wcd87lNyA5NQxrB3lsq5D7nBwtvNhlf0eH8Ku/Hbef
   BwoJdFhjwb31qLKU/64lIs4HXQ0/8yP50imian45GQ48fivhDMk36fcnM
   7OyphbC9ibZvIIkeyW4oVEEDEUAMp2IolwH97DEK5uLJGBxmnFUp5VqV1
   VFvsXZJLX6l6WYGCnDexHX63HtM9c1Q+TCmoEIuOlDyiVxZWGLyvv0ue0
   +2H4+ThIdA2ZaTSNYoBs10ytMK0r5Z/T+ZTfEqRXpFQojeX4K6SZlzmpZ
   w==;
X-CSE-ConnectionGUID: VqtrV4z/QtiGG/xah4yd4w==
X-CSE-MsgGUID: TcZCSIz/SF+biMl10Pub+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41150841"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="41150841"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 13:03:45 -0800
X-CSE-ConnectionGUID: iWasBvpKR1q5d8ehRJGJnw==
X-CSE-MsgGUID: 1apVVLN1RjSTQH3UniS6ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120401941"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 13:03:44 -0800
Message-ID: <6db41e2e-4a88-4b1b-9cd3-6cb74ea2e846@intel.com>
Date: Thu, 20 Feb 2025 14:03:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] cxl: Modify address translation callback for
 generic use
To: Gregory Price <gourry@gourry.net>, Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-2-rrichter@amd.com>
 <Z7dRrz9D22p3urfI@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z7dRrz9D22p3urfI@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/25 9:00 AM, Gregory Price wrote:
> On Tue, Feb 18, 2025 at 02:23:42PM +0100, Robert Richter wrote:
>> The root decoder address translation callback could be reused for
>> other decoders too. For generic use of the callback, change the
>> function interface to use a decoder argument instead of the root
>> decoder.
>>
>> Note that a root decoder's HPA is equal to its SPA, but else it may be
> 
> slighlty better wording:
> "but it may different for non-root decoders"

This change helped me understand what that sentence was trying to say.

> 
>> different. Thus, change the name of the function type to
>> cxl_to_hpa_fn.

I would also drop the "thus" so it's in imperative tone. 

>>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> 


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816CD2D46AB;
	Thu, 21 Aug 2025 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797953; cv=none; b=IW2kb1og2nui4Ac0jImnw8Tfted3+0A4sCL7Xd7Y2NiawpxNZDZhL8+4u7MdUYgYStg79ppH7c4cTM61hH6FQQ4azpzVvj+uLmIKSHoIzKhobciIxr2Cl5y1yCUt0FKfoYuMaiDJMH/acyEWSQ9Y1uQ8S0FFHaQJvGCWKfGBQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797953; c=relaxed/simple;
	bh=QkUqQ3zvMKz0kwF5LuYb7dPTc8lI1Aq+1yTo+jAi8q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8KC331K+O7p1/I01oA2BInWG4h5tNitWOmHSKCValyetoEYifJXYbKY0WHI7dAlox+bJ2YUBeG/IFEcsC3bge6Psqkn4c05yomtf2CRujWxG7pVtU7ITC9M+jxjHZl6qSNpuoMZ689VE9H/c78RioZ+Y7TJ5+4KmHtNTuLI0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpNSHfY1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpNSHfY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755797951; x=1787333951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QkUqQ3zvMKz0kwF5LuYb7dPTc8lI1Aq+1yTo+jAi8q4=;
  b=IpNSHfY1Ci6rw58Dc5Z49i11uWK3JQ99kHYprKSdwgOm82YZRo66GXPt
   iVE5jqKE62woBwiUfXzY1pULRPP0OMG60N+ARpkzqhkZpLkMM+nu9bO1k
   ZxmtVRZcn8/+p/vc952PLnJ+wirpCd5syMdndC8KyfgOXOnK8MP6ia7jZ
   PYA8ngNu7wBF5aRYKsDdpgnnSReVx/PKoRksVDLadGWGGpiOwtwrqXm2k
   Qk4N8F8eHnIwSLU2psWmt8+/1epof86xEYYOoe+TlGndthSRV7ZjrplDL
   kVQO15ed/8DClDfCNjWjrAV7D5lEPe2JTF6CezouVZDE2wTJtZMOS99MQ
   w==;
X-CSE-ConnectionGUID: o2EgGGkTT5mRTycqavb8Aw==
X-CSE-MsgGUID: Kt4EigyDQHC7d1r/VAq4nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58166496"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58166496"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:39:10 -0700
X-CSE-ConnectionGUID: 0g9v6kcyRjG2mrRUEjPaaQ==
X-CSE-MsgGUID: 7vEKTR1VRdqY9c/BKGa2mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="199346532"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.210]) ([10.247.119.210])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:39:04 -0700
Message-ID: <690d68e2-1efd-4de4-8b78-3a75c71d944e@intel.com>
Date: Thu, 21 Aug 2025 10:38:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation/driver-api: Fix typo error in cxl
To: Rakuram Eswaran <rakuram.e96@gmail.com>, linux-doc@vger.kernel.org
Cc: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 alison.schofield@intel.com, gourry@gourry.net, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net
References: <20250818175335.5312-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250818175335.5312-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/25 10:53 AM, Rakuram Eswaran wrote:
> Fixed the following typo errors
> 
> intersparsed ==> interspersed
> in Documentation/driver-api/cxl/platform/bios-and-efi.rst
> 
> ---
> Changelog:
> 
> Changes since v2:
> - Fixed Signed-off-by line to include fullname
>   (feedback from Jonathan Corbet)
> 
> Changes since v1:
> - Dropped fix for page-allocator.rst as requested by Gregory
> 
> Suggested-by: Gregory Price <gourry@gourry.net> 
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>

applied to cxl/next
561c4e30bff93b3c33e694a459f8580f8a6b3c8c

> ---
>  Documentation/driver-api/cxl/platform/bios-and-efi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> index 645322632cc9..a9aa0ccd92af 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -202,7 +202,7 @@ future and such a configuration should be avoided.
>  
>  Memory Holes
>  ------------
> -If your platform includes memory holes intersparsed between your CXL memory, it
> +If your platform includes memory holes interspersed between your CXL memory, it
>  is recommended to utilize multiple decoders to cover these regions of memory,
>  rather than try to program the decoders to accept the entire range and expect
>  Linux to manage the overlap.


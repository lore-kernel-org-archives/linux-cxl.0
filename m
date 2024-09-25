Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580791D5ACD
	for <linux-cxl@vger.kernel.org>; Wed, 25 Sep 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279638; cv=none; b=uhEchsLehOEt7izsBPExJ6PVbtXFLMJOr9ZQJnrk8/oTnrx8ZBykFxrHAXP+9Kzaq2tWpZoIrrwhcNopfEjvIOrAt1mBZmZaYTFYmV+Qdvl1z/nPVLlJB7pbDiypBRS5GJf1Y6Wj7bsCs1pB56bc4P1R3P4uKmDTilGa2Txooe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279638; c=relaxed/simple;
	bh=xbNzagmFfT/JWgGozQxA+RR3EfRBzCUORkag6vx6YXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RaZM3rperOxFmmHsr93aBVCPStEvIos1mzGnsnUcHupVszqJnWlNkVfw8VnrwjvkDMnKfii50I/b/c91BZQroDbkS2hUkrbCJ3dGUF/FH0OrLGJI8JI4jP430GPxrHKf7DWLi+mLqRZ3VEDvl/kEJqlLovCYCAvYPUrleJ9Wr5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzwvSNNw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzwvSNNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727279637; x=1758815637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xbNzagmFfT/JWgGozQxA+RR3EfRBzCUORkag6vx6YXo=;
  b=hzwvSNNwUPiJCr1wtL6SjMCsk9zytMtZFXj1oa3Kyw4SJ/DCVClV246t
   7PhA+9AtbY8QGBtxsHOy0mcVkjKEsy5yPwr0Kuk4ZX5v2P6zkNlBggz6G
   HkyIUdOG3VjbOHbcnTkwGqFOI3s7lX6aLiZ0tiAhN0m1vOvvZKQYW/1KG
   fB7UlSbU98xVl+kIALe6YTn54wybjJkXHUrWv9oFfXr1VjByxLHAxq2Dx
   6EVxTfK5UCv5xOFRdOWW4++YPeaiT7MOmfMU2NzVINWBI9yQbXgcH1v4U
   a8RolwT+YPoA+4lKf7mG0AhAulKQzNywCyPqd3PgX+gmqoX6K+duqgID9
   A==;
X-CSE-ConnectionGUID: qmDTLXJZQCeoCmUFFPKgAg==
X-CSE-MsgGUID: WBSoQxavR+6p9ijP64ez7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26210221"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26210221"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 08:53:56 -0700
X-CSE-ConnectionGUID: 4eYblus8SI2Kh9M0cV8b8Q==
X-CSE-MsgGUID: l47KLLK+QpivSuhEKWWfYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71967598"
Received: from cmdeoliv-mobl.amr.corp.intel.com (HELO [10.125.111.90]) ([10.125.111.90])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 08:53:55 -0700
Message-ID: <a77d3247-8ef9-40dc-9bf3-69ab44aa27d8@intel.com>
Date: Wed, 25 Sep 2024 08:53:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to start sanitize?
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
References: <TYRPR01MB12335599B869ED3E7716A758790692@TYRPR01MB12335.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <TYRPR01MB12335599B869ED3E7716A758790692@TYRPR01MB12335.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/24 3:41 AM, Yasunori Gotou (Fujitsu) wrote:
> Hello,
> 
> I have a question about sanitize feature for cxl memory.
> 
> How to start the sanitize feature for a cxl memory device?
> Is it just writing "1" to /sys/bus/cxl/devices/memX/security/sanitize ?

Technically yes. I'm surprised that there wasn't the accompanied cxl CLI enabling for it. 


> 
> I found cxl command has "cxl wait-sanitize" feature, but it seems to just wait the completion of sanitize,
> and not to start it. In my understanding, there is no feature to start sanitize in cxl command.
> 
> Are there any plan to make "cxl start-sanitize" command?

+Davidlohr

Davidlohr,
Do you have cxl cli enabling bits for cxl sanitize when you added the kernel enabling a while back?

> 
> Thanks,
> 
> 


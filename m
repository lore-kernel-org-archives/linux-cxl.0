Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0E53D9E5;
	Thu, 15 Oct 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077443; cv=none; b=RVj/hM0rW+2XU3fkSW0Rrdb+/eLDTalVBe+n2zhTcDr3Jneokz0dW4karlDCJLUpnf9nMnQBFeIafd4Sc2FGsXpZ8H9fuSXJ643eEAC+xgBdFNES6FjXoZMMW2TP17mI8z4lE7ZjssAPSsHreFh3jJd5RDqpBbpg1VJiZXZDoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077443; c=relaxed/simple;
	bh=eratc61k+xFteainm9vSjMnlPgx/Ez5KiMnSaKZZ80w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBJuqokDvd2vwYjNXIMSCPFtTwykHuA2TbPEDqiPZeDHysOrpf2lwqHP9jiYFJiWOcXCr3hhVFVs7W6QDCo4FSCL9JYSpzbG1bmWTlD0FjUre5Pu7QUBOn4fRs7cM6e79WHtaZXMTa2ISAmKtkzgCyAQ87qKnaMG/tLgIAr0WR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSCIfEH9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSCIfEH9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792077442; x=1823613442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eratc61k+xFteainm9vSjMnlPgx/Ez5KiMnSaKZZ80w=;
  b=HSCIfEH9HaMx4QibucGwIg0dK1vwWVu3tCsLLdLcaxfZJqE/gaS2d9OX
   3ByxllrKHkjdWNndvSvtfP5wAlAimRJXOfNRPT7jbiNklPjgxjKZqyCQu
   GH5zFWbo4AzYPs4CNJPjPQ6usTTsg58qchEsf8gDWhvbiEd5fXHtpSwXq
   VbKfltcXHKfQjneEhu9RwE02beqAvY7mxYA/IdrFfeyzvEGO/G5CvChDi
   QEbotyF16ZdcC8jAea43FR72fjTMXc9EwiXe+fcZ4RftnBph5BtQbW3Dm
   1JVsFc1cHakBy3+Gf2xtH0h1yaDicY20aP/EvKEWRTk76ZaqeUMZ2ZRTl
   Q==;
X-CSE-ConnectionGUID: JA8euHECQ4+iUheGcBUIPA==
X-CSE-MsgGUID: aFMph0W/SyGVQMFmshDbXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="836469"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="836469"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:17:21 -0700
X-CSE-ConnectionGUID: EMZqyF0FTxqnlz3gGKk3nQ==
X-CSE-MsgGUID: 5ng47E4gRAe0TnBypvHQUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1648019"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.113]) ([10.125.110.113])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:17:20 -0700
Message-ID: <ec305690-a036-406e-8185-d93632a5dcb7@intel.com>
Date: Thu, 15 Oct 2026 08:17:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mbox: Add the CXL 4.0 command return codes 001Fh and
 0020h
To: =?UTF-8?B?6buE6auY5b2s?= <huanggaobin23@semi.ac.cn>,
 Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-kernel@vger.kernel.org
References: <20261015055048.1765042-1-huanggaobin23@semi.ac.cn>
 <atCLjvE5xJp9jo6L@MWDK4CY14F>
 <31c53d8e.42202.1a13eba4ae8.Coremail.huanggaobin23@semi.ac.cn>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <31c53d8e.42202.1a13eba4ae8.Coremail.huanggaobin23@semi.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/15/26 1:42 AM, 黄高彬 wrote:
> Hi Richard,
> 
>> Do we have users for them ? or potential users ?
> 
> I checked the related code, and the honest answer is no for both today.
> 
> 001Fh is the code Perform Maintenance (opcode 0600h) returns when the input
> parameters are transferred in parts and the parts arrive out of order --
> Action = Initiate Transfer, Continue Transfer, End Transfer (CXL r4.0,
> 8.2.10.7).  Linux does issue Perform Maintenance: PPR and the sparing
> operations in edac.c both go through cxl_perform_maintenance().  That helper
> always transfers the parameters in a single command though -- it returns
> -ENOMEM when they do not fit in the mailbox payload instead of chunking --
> so the ordering condition cannot arise from the driver.  The multi-chunk
> flow in the specification is described for the Built-In Self-Test test
> parameters, and there is no BIST support in the driver.
> 
> 0020h is only the return code of Request Abort Background Operation (opcode
> 0005h).  Linux does not issue that command either.
> 
> So neither code has a producer in the driver today.  Both are defined in the
> command return code table (CXL r4.0 Table 8-208) that CMD_CMD_RC_TABLE
> transcribes, and carrying them costs two lines and no behavior change: a
> device that reports either already comes back as -ENXIO through the
> unknown-code path, so what the entries buy is a name instead of "unknown
> return code".
> 
> If the point is that a definition should arrive with the code that can
> produce it, that is a fair position too.  I can withdraw this patch and
> resend it together with chunked maintenance transfer support, or with abort
> support, whichever is implemented first. 

Yes lets do that.
> 
> Thanks,
> Gaobin


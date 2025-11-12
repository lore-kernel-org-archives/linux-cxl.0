Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10B25C6E2;
	Wed, 12 Nov 2025 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983932; cv=none; b=dnrvFyZg1nsfx/orA0qDKCzB8EOCatgGAYT23oj5cF2XRSUAUBK7YRZIiIdj8m5SAjvg6F1Ico+JF769DiVrNrNEdTknPLODBFWhUUINgV8ah8C6eTQz0uTWHuQkcyJ3niJjPgZVGe6X3JoceIC42xSzczMb6vTCUYt/b0z7LQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983932; c=relaxed/simple;
	bh=wUpfeAHbI+GekUXuhrCo5oPDqGAHlmbMf3iv5QYquxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZPwk+1gxOkRketDRwPSTX/48KwQDUhrxeX75wGMUqPd7hSzMUXmvprOFzDxdQpjLo+TABCW8tXGMpqDabF/fFINvZftoMq5hVkZNGi1X5hTABBolQDiIWwffHFKlS9mNnBLg3GBgyqDbtxy6aGCuSMNLvHfspft8zNhLW51Thc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmWDDpCP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmWDDpCP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762983931; x=1794519931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wUpfeAHbI+GekUXuhrCo5oPDqGAHlmbMf3iv5QYquxk=;
  b=LmWDDpCPQs5uFixIBROUVaO9xVYZiCmZBrXWnDTCM5rkod7IYEmjeVwt
   jj/XqYNPX7F1eVjl27P8R7yZ1/4eL9vgIWM+rcarxz4IOO9FgKinLxkpX
   6UpnqQ+X6/1BLHnWiil4+HPSz9b7KV0DGqV6m7JHRf48tqBsPLX45o4Ld
   6LispTINtBgTzfOi/QcsMnBlRseS+FLfu7rFHKskRimRG8WMrPaowycWr
   87brzaYbYk2OqGHXhMb8c5rQooQuxFkHCL6wd/Vh5+3JWGqB/jTtXdMn6
   aNZfg/97x8rU6uU815Uptm5n4PPAObCrCG/qs1MirviyMsfY/rViLPc9v
   w==;
X-CSE-ConnectionGUID: uHgoGg3GQJSkp8u9HIqLdQ==
X-CSE-MsgGUID: +8HkX7zYSV6mwuMI6+bnzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="52620479"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="52620479"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 13:45:30 -0800
X-CSE-ConnectionGUID: PnyoS8eNTe62FZU1n8mDNQ==
X-CSE-MsgGUID: d70LY4p9TGWgMrOHHbXcbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="220084887"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.30]) ([10.125.108.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 13:45:29 -0800
Message-ID: <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
Date: Wed, 12 Nov 2025 14:45:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] CXL updates for v6.19
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251112205105.1271726-1-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251112205105.1271726-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/12/25 1:51 PM, Robert Richter wrote:
> Sending optional and rather independent patches from v5 of the CXL
> address translation series [1] separately in this series. The patches
> could be applied together with early pick up candidates from the
> address translation series (namely patch #1 to #4 or #5).
> 
> [1] https://patchwork.kernel.org/project/cxl/cover/20251112203143.1269944-1-rrichter@amd.com/
> 
> Robert Richter (3):
>   cxl: Simplify cxl_rd_ops allocation and handling
>   cxl/acpi: Group xor arithmetric setup code in a single block
>   cxl/region: Remove local variable @inc in cxl_port_setup_targets()
> 
>  drivers/cxl/acpi.c        | 15 ++++-----------
>  drivers/cxl/core/region.c | 25 +++++++------------------
>  drivers/cxl/cxl.h         |  2 +-
>  3 files changed, 12 insertions(+), 30 deletions(-)
> 

Hi Robert, I'm having issues applying to 6.18-rc4.

Applying: cxl: Simplify cxl_rd_ops allocation and handling
Patch failed at 0001 cxl: Simplify cxl_rd_ops allocation and handling
error: patch failed: drivers/cxl/core/region.c:2958
error: drivers/cxl/core/region.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Also:
---
  ✓ [PATCH 1/3] cxl: Simplify cxl_rd_ops allocation and handling
    + Link: https://patch.msgid.link/20251112205105.1271726-2-rrichter@amd.com
    + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
    ● checkpatch.pl: 118: WARNING: 'existance' may be misspelled - perhaps 'existence'?

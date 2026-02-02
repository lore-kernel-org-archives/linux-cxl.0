Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A227261C
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062474; cv=none; b=R+nW7d5L0jPCmCQWKjpod6sv1k6h2O64MXHlMaeZfpxZB4HCpo2vkQCNXd6rTXjtcOfcIjjExhG8OSyNVi6tA/77FUCI2E0lSZayL2RNZdMH9NN2EBeByTMb2eJgJbqS6gHARgY60oOM9xtPWadZHI/2qEbmaeXX1v2hROq59WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062474; c=relaxed/simple;
	bh=ixTQq4nUfvOpjDXKb5OkveJjRFKaZw3E0ulDvFbpw88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7HNxHLQ2BVWKInkqSwDtnz1XwACJIGIgP8iN2ejX5tMXnzO5TcU8OjpdzXPRHkNk+xJlGcs7KHwUa1XZ0TFacfus/p0twwl8rHHTWTY1MyX9hWU4tEwK3oLH7mbQU4MHG0Obk/Xm7qVvpJsK7+/RxA3NeO4nzWJMwZQIUOARxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUlS1toU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUlS1toU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770062472; x=1801598472;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ixTQq4nUfvOpjDXKb5OkveJjRFKaZw3E0ulDvFbpw88=;
  b=XUlS1toUqP9hIRUL8WByCuzHVNkmov08x0Lu3qRUXMT3s5gPHrgB2mdF
   osiLYsC/4ovYD4F1Laq5fy8IrLAGqGwVY3K4pggMWIrGCNIwCDY39GVCx
   mDlDbB4entitdDq56xcYYBSzx73pV4iiEPZ/PA2d/PQHUDWQHfZxS5lEm
   qus3LOr0lAKlbEjkaehSbiJUJKbRsDka7CLC+ZryKGz1l79h7g2hsyEn/
   dyVwRJWesYV2vzvZGHM3L3F4CPvWCKmqJRUPwZU40/tsGTlZpFPY+v1TL
   tEDejN17g1OnVd4lGRUGBzcvGIaQlccAQfsGT3hkN0dmVnX1FPeeR+IsV
   A==;
X-CSE-ConnectionGUID: 6RjNaPwtTkOgxwpDfdnsuQ==
X-CSE-MsgGUID: 3aHp8XOdTg2zJm+AcMjVfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71125796"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71125796"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 12:01:11 -0800
X-CSE-ConnectionGUID: HJq1zMMvQ8essJYNb7M/jQ==
X-CSE-MsgGUID: JU22kzCDRCedDgliiA6mYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="209846226"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.162]) ([10.125.110.162])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 12:01:10 -0800
Message-ID: <d70a77f5-33ab-4d68-8427-dde5ce3f8486@intel.com>
Date: Mon, 2 Feb 2026 13:01:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] cxl/port: Unify RAS setup across port types
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, terry.bowman@amd.com
References: <20260131000403.2135324-1-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260131000403.2135324-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/30/26 5:03 PM, Dan Williams wrote:
> Changes since v1 [1]:
> - Cleanup the diff by keeping the order of dport_exists() relative to
>   the dev->driver check in cxl_port_add_dport() (Jonathan)
> - Drop some repetitive de-referencing with a local @port variable in
>   dport_to_host() (Jonathan)
> - s/group/dr_group/ throughout to clarify "devres group" (Jonathan)
> - Reuse del_dport() for cxl_dport_release_dr_group() (Jonathan)
> - Drop the thin wrappers for devres_{open,close}_group() for the port
>   group.
> - Add a comment and a cleanup TODO for the 'add_dport()' operation in
>   'struct cxl_driver'. (Jonathan)
> - Change patch 7 subject to just: "cxl/port: Map Port RAS registers"
>   since it is only introducing a helper that is later used in the
>   endpoint case. (Jonathan)
> 
> [1]: http://lore.kernel.org/20260122033330.1622168-1-dan.j.williams@intel.com

Applied to cxl/next
0da3050bdded5f121aaca6b5247ea50681d7129e

> 
> Original cover letter:
> 
> ---
> 
> The CXL Port Protocol error handling series grew to be over 30 patches
> which is too much to handle at once given the various topics involved.
> One of the sub-threads of the v14 review was confusion about the new
> devres groups to manage port setup unwind failures [2].
> 
> [2]: http://lore.kernel.org/20260115144605.00000666@huawei.com
> 
> Given that review indicated a need to break up and better explain the
> conversion, do that in a separate patch set. Build on top of the first
> 18 patches of that series [3] that are ready to merge.
> 
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.0/cxl-aer-prep
> 
> The wider goals of the port protocol handling series are:
> 
> 1/ Be minimally invasive to the ongoing maintenance burden of PCIe error
>    handling. Just do the minimal enlightenment to forward "internal"
>    errors for device with active CXL links to the CXL core.
> 
> 2/ Build a framework for any driver that registers a 'struct cxl_memdev'
>    (or in the future a 'struct cxl_cachedev') gets protocol error
>    handling support.
> 
> This "Unify RAS setup across port types" set supports goal 2/. It
> enables a model where all CXL error handling is relative to the common
> 'struct cxl_port' and 'struct cxl_dport' objects and is agnostic to
> whether those objects are in support of the memory expansion class
> device (driven by cxl_pci) or any other CXL endpoint in the system that
> supports CXL.cachemem operation.
> 
> In support of that unification, the setup of RAS registers needs to be
> centralized. That in turn requires new handling for early exit setup
> failures and additional teardown support for resources optionally
> acquired at port / dport creation time.
> 
> The devres group mechanism is deployed to cleanup some open coded
> devm_release_action() calls. The devres group facility also comes in
> handy for unwinding conditional setup steps in the port creation
> process. Recall that ports defer probing their CXL resources until after
> they are known to have a downstream CXL connection. So, early exit during
> setup of a new dport may have more or less work to do depending on
> whether the first or subsequent dport is being added.
> 
> Given probing port resources is a 'probe' action it fits more naturally
> as a driver operation. If cxl_port_add_dport() then moves to cxl_port
> driver operation alongside ->probe(), it enables a cxl_test cleanup. The
> cxl_test approach has a hard time mocking interfaces that are internal
> to the cxl_core.
> 
> The rest of the patches in this set finish off the conversion of 'struct
> cxl_port' and 'struct cxl_dport' to be the only CXL objects that
> interact with the CXL RAS.
> 
> Dan Williams (8):
>   cxl/port: Cleanup handling of the nr_dports 0 -> 1 transition
>   cxl/port: Reduce number of @dport variables in cxl_port_add_dport()
>   cxl/port: Cleanup dport removal with a devres group
>   cxl/port: Move decoder setup before dport creation
>   cxl/port: Move dport probe operations to a driver event
>   cxl/port: Move dport RAS setup to dport add time
>   cxl/port: Move endpoint component register management to cxl_port
>   cxl/port: Unify endpoint and switch port lookup
> 
> Terry Bowman (1):
>   cxl/port: Map Port RAS registers
> 
>  drivers/cxl/core/core.h              |  10 ++
>  drivers/cxl/cxl.h                    |  33 +++---
>  drivers/cxl/cxlmem.h                 |   4 +-
>  drivers/cxl/cxlpci.h                 |  12 +-
>  tools/testing/cxl/exports.h          |  13 ---
>  drivers/cxl/core/hdm.c               |   6 +-
>  drivers/cxl/core/pci.c               |   8 +-
>  drivers/cxl/core/port.c              | 159 +++++++++++++++++----------
>  drivers/cxl/core/ras.c               |  50 ++++++---
>  drivers/cxl/mem.c                    |   2 -
>  drivers/cxl/pci.c                    |  63 +----------
>  drivers/cxl/port.c                   | 122 ++++++++++++++++++++
>  tools/testing/cxl/cxl_core_exports.c |  22 ----
>  tools/testing/cxl/test/mock.c        |  36 ++----
>  tools/testing/cxl/Kbuild             |   3 +-
>  15 files changed, 310 insertions(+), 233 deletions(-)
>  delete mode 100644 tools/testing/cxl/exports.h
> 
> 
> base-commit: 9a8920ca8ebfb99604f639e7fbc681d0d04518a0


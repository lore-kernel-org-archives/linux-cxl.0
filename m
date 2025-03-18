Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EACBDDC5
	for <linux-cxl@vger.kernel.org>; Tue, 18 Mar 2025 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336277; cv=none; b=KJOofI7B0ivU/jKXdwTMS6WBejBWuk7bMxpiR/8+7kmOL+F7LhIt5YCtBspLhuo1wDxXXCAZGqiYQSTk+PXgrDOCsx4e+01VmIM70GYtVVcQIxvsG/IDDIArV6NtXmxZRYNMOzy0Bi7yKdut0ZAW1i0lNPNQRWD/fEyUvSkPvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336277; c=relaxed/simple;
	bh=Z+kJ3z1e38yZmBKEyTYs/sw0DrOtE43wjIYIthx3jDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFPEUMzuN7Sf9XbjUrxuReUo9jSz7PkRYrp6iSWXfbJD7Xi1mM0CTltbqljhZUhGud7Rrwaq8iXvmIwjxz2ihHx3l/nGCZBHpiZutt8IQJ+SjDKezVeRMPVkzFpCegtMHkauxHHSsGNTGu/b0yDWw0nwWOjDW4RJKSGVemSH2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Or1EfZmT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Or1EfZmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742336276; x=1773872276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+kJ3z1e38yZmBKEyTYs/sw0DrOtE43wjIYIthx3jDc=;
  b=Or1EfZmTBwAjzGjXRAtgNLExdiuIBWodToeCT0h2yMFJPXvGnapV2cJ8
   WrSQCg1cmSObTrZc/aTNHHhIIlnKir4EpqqmwbPQoyb1p5TNlyW+U+raf
   XvDmCLVxIFUUxhpfH+YNaNSOZlJiV6aDDmkXMxkheS9vfZcPHpwfEHnmt
   MleoVcUelBln7WV2QCHLfW8ym6645Ace2TEvf+NOp59uUb1CRUho+Qk18
   EAaNQQ1QynsIlZo/TNJj7QAZf7kka3YsCka/QtIdbPWCcJkmpDYwD/2oF
   QM47/DHjCgI1TBB072Iy+T+nd3polosEfenDeiBVDizqN9JOkL53b4Qup
   A==;
X-CSE-ConnectionGUID: EFTusCfsTU2KoCOoNI6pGw==
X-CSE-MsgGUID: koovmD28T6KKgVPOT2PLXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54881827"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="54881827"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:17:55 -0700
X-CSE-ConnectionGUID: QgchTsryQBaEP2221lmfZw==
X-CSE-MsgGUID: i4VqjhmZTEmV6ySd2yg0NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="122865477"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.213])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:17:54 -0700
Date: Tue, 18 Mar 2025 15:17:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 -ndctl] cxl/memdev: Introduce sanitize-memdev
 functionality
Message-ID: <Z9nxEGrBCsot1eeJ@aschofie-mobl2.lan>
References: <20250318215013.560215-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318215013.560215-1-dave@stgolabs.net>

On Tue, Mar 18, 2025 at 02:50:13PM -0700, Davidlohr Bueso wrote:
> Add a new cxl_memdev_sanitize() to libcxl to support triggering memory
> device sanitation, in either Sanitize and/or Secure Erase, per the
> CXL 3.0 spec.
> 
> This is analogous to 'ndctl sanitize-dimm'.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Changes from v2: resend, corrupted patch file
> Changes from v1:
>  - remove '-s' option and allow sanitize and secure erase to
>    be exclusive. (Vishal)
>  - update cxl-sanitize test cases (Alison)
>  - update wait-sanitize manpage to include sanitize-memdev cmd
> 
>  Documentation/cxl/cxl-wait-sanitize.txt |  1 +
>  Documentation/cxl/meson.build           |  1 +
>  cxl/builtin.h                           |  1 +
>  cxl/cxl.c                               |  1 +
>  cxl/lib/libcxl.c                        | 15 ++++++++++
>  cxl/lib/libcxl.sym                      |  1 +
>  cxl/libcxl.h                            |  1 +
>  cxl/memdev.c                            | 38 +++++++++++++++++++++++++
>  test/cxl-sanitize.sh                    |  4 +--
>  9 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/cxl/cxl-wait-sanitize.txt b/Documentation/cxl/cxl-wait-sanitize.txt
> index e8f2044e4882..9391c66eec52 100644
> --- a/Documentation/cxl/cxl-wait-sanitize.txt
> +++ b/Documentation/cxl/cxl-wait-sanitize.txt
> @@ -42,3 +42,4 @@ include::../copyright.txt[]
>  SEE ALSO
>  --------
>  linkcxl:cxl-list[1],
> +linkcxl:cxl-sanitize-memdev[1],
> diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
> index 8085c1c2c87e..99e6ee782a1c 100644
> --- a/Documentation/cxl/meson.build
> +++ b/Documentation/cxl/meson.build
> @@ -49,6 +49,7 @@ cxl_manpages = [
>    'cxl-monitor.txt',
>    'cxl-update-firmware.txt',
>    'cxl-set-alert-config.txt',
> +  'cxl-sanitize-memdev.txt',

Oops - the new .txt file is not in this version.
When you resend, add To: nvdimm@lists.linux.dev
Thanks!

snip

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76B3BC687;
	Thu, 19 Mar 2026 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959439; cv=none; b=K7L/8NCSkLWhQ73yOxuvq+bS0cYCDODUJrCWGTMLj+jcndh9r91fGiyVbDg7eLE6uFDFnIgWdzNO1Wfh/q6XoUWbYipC6TMyUrUMQjjsFTTb+Ax+84bGuqR+X60VSs1TXt6SOdozQoJXKCfaWeycwJ80oPtehgKPYfHWtfgXmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959439; c=relaxed/simple;
	bh=GSmh01TI+tUxEiixWhIp+rzE37rCWixe1ShKAvCI1n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foTeZJdl3rYvdUun5qg5KLy3j6wcY4FIsvJS4PKu6t4RMiBfn7p1bU9lYsl2HkLwybH7R2W5ysPOSSD1AvefBwvhk2IpTAfQ/TkekN6DF14CYbACIrHH79NvKCM2d/NbMzl7EOhDOc+LS5Xv+JKbDnakH1rlLuzjSB7ryYUpWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKNZ/F9r; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKNZ/F9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773959438; x=1805495438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GSmh01TI+tUxEiixWhIp+rzE37rCWixe1ShKAvCI1n0=;
  b=HKNZ/F9roeOV0ScHu520FmT7ZRzErzMq7lSV+zed1nQRZ4b7ofcmy1XU
   9oAld7tbiVOMIqEiMd3/wgySvOxP5O4s4njubPRzwSC+GwitiMdSpMV7k
   bRJGkolCkVYQKooV9YCI1Gf2Fh1TfwD0EMrtCHdA6Dzm8GKOs+1v/3n/O
   kirYP2spDsC1jc5iUu6K3YoDq6z9Bhpiz42F84TrLrYXK/qKNwU+s5tjy
   BeKnzS1jD52RL9dFZEAZslUXS8iRt7gKaYa+VZrTxrW+Qyjf7/ATqhlhd
   ZrMC6CABnqMrleUtfh4RUirpQdy2vW8T1BNQsCnxHFW4GT2y/0ZpLxT03
   Q==;
X-CSE-ConnectionGUID: chnVPTvDR/qii1UFfYeXvg==
X-CSE-MsgGUID: apmvh04iSfysOh/3358K8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="77651152"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="77651152"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 15:30:38 -0700
X-CSE-ConnectionGUID: 6kxmqmWCQDqS4yjIhwQwsw==
X-CSE-MsgGUID: oUdKaFgURGeW7LGphmxZQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="246129160"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 19 Mar 2026 15:30:33 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3LsB-000000001jN-24aY;
	Thu, 19 Mar 2026 22:29:54 +0000
Date: Fri, 20 Mar 2026 06:28:21 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ahmed Tiba <ahmed.tiba@arm.com>, Michael.Zhao2@arm.com,
	robh@kernel.org, linux-arm-kernel@lists.infradead.org,
	Dmitry.Lamerov@arm.com, rafael@kernel.org, conor@kernel.org,
	will@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
	krzk+dt@kernel.org, linux-doc@vger.kernel.org,
	mchehab+huawei@kernel.org, tony.luck@intel.com
Subject: Re: [PATCH v3 10/10] RAS: add firmware-first CPER provider
Message-ID: <202603200642.s4i4HaHu-lkp@intel.com>
References: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-10-48e6a1c249ef@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-10-48e6a1c249ef@arm.com>

Hi Ahmed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2d1373e4246da3b58e1df058374ed6b101804e07]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Tiba/ACPI-APEI-GHES-share-macros-via-a-private-header/20260319-115432
base:   2d1373e4246da3b58e1df058374ed6b101804e07
patch link:    https://lore.kernel.org/r/20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-10-48e6a1c249ef%40arm.com
patch subject: [PATCH v3 10/10] RAS: add firmware-first CPER provider
config: riscv-randconfig-002-20260320 (https://download.01.org/0day-ci/archive/20260320/202603200642.s4i4HaHu-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 4abb927bacf37f18f6359a41639a6d1b3bffffb5)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603200642.s4i4HaHu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603200642.s4i4HaHu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/apei/ghes_cper.c:44:
>> include/acpi/ghes_cper.h:105:30: warning: declaration of 'enum fixed_addresses' will not be visible outside of this function [-Wvisibility]
     105 |                       u64 *buf_paddr, enum fixed_addresses fixmap_idx);
         |                                            ^
   include/acpi/ghes_cper.h:108:24: warning: declaration of 'enum fixed_addresses' will not be visible outside of this function [-Wvisibility]
     108 |                         u64 buf_paddr, enum fixed_addresses fixmap_idx);
         |                                             ^
   include/acpi/ghes_cper.h:111:25: warning: declaration of 'enum fixed_addresses' will not be visible outside of this function [-Wvisibility]
     111 |                         u64 *buf_paddr, enum fixed_addresses fixmap_idx);
         |                                              ^
   include/acpi/ghes_cper.h:115:24: warning: declaration of 'enum fixed_addresses' will not be visible outside of this function [-Wvisibility]
     115 |                         u64 buf_paddr, enum fixed_addresses fixmap_idx,
         |                                             ^
   4 warnings generated.


vim +105 include/acpi/ghes_cper.h

7f6d32e88c31e2 Ahmed Tiba 2026-03-18  102  
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  103  int ghes_read_estatus(struct ghes *ghes,
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  104  		      struct acpi_hest_generic_status *estatus,
7f6d32e88c31e2 Ahmed Tiba 2026-03-18 @105  		      u64 *buf_paddr, enum fixed_addresses fixmap_idx);
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  106  void ghes_clear_estatus(struct ghes *ghes,
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  107  			struct acpi_hest_generic_status *estatus,
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  108  			u64 buf_paddr, enum fixed_addresses fixmap_idx);
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  109  int __ghes_peek_estatus(struct ghes *ghes,
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  110  			struct acpi_hest_generic_status *estatus,
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  111  			u64 *buf_paddr, enum fixed_addresses fixmap_idx);
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  112  int __ghes_check_estatus(struct ghes *ghes,
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  113  			 struct acpi_hest_generic_status *estatus);
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  114  int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  115  			u64 buf_paddr, enum fixed_addresses fixmap_idx,
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  116  			size_t buf_len);
dacb62d12abb41 Ahmed Tiba 2026-03-18  117  int ghes_estatus_cached(struct acpi_hest_generic_status *estatus);
dacb62d12abb41 Ahmed Tiba 2026-03-18  118  void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
dacb62d12abb41 Ahmed Tiba 2026-03-18  119  			    struct acpi_hest_generic_status *estatus);
40686d3c8f0a4d Ahmed Tiba 2026-03-18  120  int ghes_register_vendor_record_notifier(struct notifier_block *nb);
40686d3c8f0a4d Ahmed Tiba 2026-03-18  121  void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
648c11f76ec605 Ahmed Tiba 2026-03-18  122  void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
648c11f76ec605 Ahmed Tiba 2026-03-18  123  				   int sev);
0eb637ae58ed14 Ahmed Tiba 2026-03-18  124  int ghes_severity(int severity);
0eb637ae58ed14 Ahmed Tiba 2026-03-18  125  bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
0eb637ae58ed14 Ahmed Tiba 2026-03-18  126  				int sev, bool sync);
0eb637ae58ed14 Ahmed Tiba 2026-03-18  127  bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
0eb637ae58ed14 Ahmed Tiba 2026-03-18  128  			      int sev, bool sync);
0eb637ae58ed14 Ahmed Tiba 2026-03-18  129  void ghes_handle_aer(struct acpi_hest_generic_data *gdata);
0eb637ae58ed14 Ahmed Tiba 2026-03-18  130  void ghes_log_hwerr(int sev, guid_t *sec_type);
0eb637ae58ed14 Ahmed Tiba 2026-03-18  131  void __ghes_print_estatus(const char *pfx,
0eb637ae58ed14 Ahmed Tiba 2026-03-18  132  			  const struct acpi_hest_generic *generic,
0eb637ae58ed14 Ahmed Tiba 2026-03-18  133  			  const struct acpi_hest_generic_status *estatus);
0eb637ae58ed14 Ahmed Tiba 2026-03-18  134  int ghes_print_estatus(const char *pfx,
0eb637ae58ed14 Ahmed Tiba 2026-03-18  135  		       const struct acpi_hest_generic *generic,
0eb637ae58ed14 Ahmed Tiba 2026-03-18  136  		       const struct acpi_hest_generic_status *estatus);
0eb637ae58ed14 Ahmed Tiba 2026-03-18  137  void ghes_cper_handle_status(struct device *dev,
0eb637ae58ed14 Ahmed Tiba 2026-03-18  138  			     const struct acpi_hest_generic *generic,
0eb637ae58ed14 Ahmed Tiba 2026-03-18  139  			     const struct acpi_hest_generic_status *estatus,
0eb637ae58ed14 Ahmed Tiba 2026-03-18  140  			     bool sync);
baccdf38fe1b81 Ahmed Tiba 2026-03-18  141  void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
baccdf38fe1b81 Ahmed Tiba 2026-03-18  142  			    int severity);
baccdf38fe1b81 Ahmed Tiba 2026-03-18  143  int cxl_cper_register_prot_err_work(struct work_struct *work);
baccdf38fe1b81 Ahmed Tiba 2026-03-18  144  int cxl_cper_unregister_prot_err_work(struct work_struct *work);
baccdf38fe1b81 Ahmed Tiba 2026-03-18  145  int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
baccdf38fe1b81 Ahmed Tiba 2026-03-18  146  void cxl_cper_post_event(enum cxl_event_type event_type,
baccdf38fe1b81 Ahmed Tiba 2026-03-18  147  			 struct cxl_cper_event_rec *rec);
baccdf38fe1b81 Ahmed Tiba 2026-03-18  148  int cxl_cper_register_work(struct work_struct *work);
baccdf38fe1b81 Ahmed Tiba 2026-03-18  149  int cxl_cper_unregister_work(struct work_struct *work);
baccdf38fe1b81 Ahmed Tiba 2026-03-18  150  int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
7f6d32e88c31e2 Ahmed Tiba 2026-03-18  151  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

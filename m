Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D014A4F0
	for <linux-cxl@vger.kernel.org>; Fri,  1 May 2026 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777609946; cv=none; b=aMGS8J9cRnhKDIoQd27Cm3oxbtPNiJ18riIbdzlnolUV8e/aoyYEG9iulmX/CB21+ClSf4v6vjonO73okwpC8pd3xHfWOsdZrd4kJUhzJ3fDsEReEddJLvk+JPKzOF/s1/Td1085j6JMo1m3IyKVnptxCPKj9tmcTTqdXj5BBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777609946; c=relaxed/simple;
	bh=xh8QU9snk7BibNbIqlJ/b1pHVOYvVQrX9J347oFssVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJsNIY94MjGzU76smaYvfj3UcMZD0i1aE+KrpLR8K6dtIZMYwe86CJ7sbPiW96A3Z5W3SU1BshUXCU2UH9Rt9QBf1L8q5wow/OYQNOWuc4hJ2KA8IFNcwC86Lpdas6SCJbv7a4WpuXaFhzRd0LcoWnKAEImyGUUtpR55aMo2r7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ef+FGTFx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ef+FGTFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777609944; x=1809145944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xh8QU9snk7BibNbIqlJ/b1pHVOYvVQrX9J347oFssVY=;
  b=ef+FGTFxczvLPSPk7L1AapcYMOaDBBG3CAVM8qMgBfem99LjELbTO7a8
   YTc9Tc0ejU74fLiFkS1xsAn/FcjlWQTaVsAnlGRIIKTX9vwet4t9t6wgP
   dCtm/GKw3X720h+uyFiWFgUp5RVDv/ddILp8gEGvEEheUbLc/titv2V3B
   4SHsgIDR/0pBiRn0QGovP6B70bWS0chgrU8kLl00g1yFgkWQlvKdbiJk/
   jFdk6c2hQB0xsFmzu0Ke69mhn+YBJW/owXYuGDyCufDq/LKn25ZGEWaHr
   A8GEofC34jCmNvVVZM6M1KYu6JkvjdeucoklyWeelkTLRgnKkSXLj7V0e
   w==;
X-CSE-ConnectionGUID: M3ksrIEYS1GtPAmMAaScTw==
X-CSE-MsgGUID: fQqpCiFlS+W8Ptjl51eScQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78770988"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="78770988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 21:32:24 -0700
X-CSE-ConnectionGUID: nZXSTiSlSg6KeRO7DpQtcA==
X-CSE-MsgGUID: CUQGVr3HSL6J4gDBm4E7gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233913377"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 30 Apr 2026 21:32:22 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIfY3-000000000Ar-01ge;
	Fri, 01 May 2026 04:32:19 +0000
Date: Fri, 1 May 2026 12:31:41 +0800
From: kernel test robot <lkp@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org,
	alison.schofield@intel.com, ira.weiny@intel.com, djbw@kernel.org,
	dongjoo.seo1@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] cxl/mbox: Support Media Operation
Message-ID: <202605011237.9gVT596v-lkp@intel.com>
References: <20260428000220.587249-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428000220.587249-1-dave@stgolabs.net>

Hi Davidlohr,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master v7.1-rc1 next-20260430]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Davidlohr-Bueso/cxl-mbox-Support-Media-Operation/20260429-230352
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20260428000220.587249-1-dave%40stgolabs.net
patch subject: [PATCH] cxl/mbox: Support Media Operation
config: i386-randconfig-016-20260321 (https://download.01.org/0day-ci/archive/20260501/202605011237.9gVT596v-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260501/202605011237.9gVT596v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605011237.9gVT596v-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/cxl/core/mbox.o: in function `cxl_media_op_discover':
>> drivers/cxl/core/mbox.c:973:(.text+0x2718): undefined reference to `__umoddi3'


vim +973 drivers/cxl/core/mbox.c

   901	
   902	/**
   903	 * cxl_media_op_discover() - Discover supported media operation
   904	 * @mds: The device data for the operation
   905	 *
   906	 * Discover any available Media Operations.
   907	 *
   908	 * Return: 0 on success or if Media Operation is not supported,
   909	 * negative error code on failure.
   910	 */
   911	int cxl_media_op_discover(struct cxl_memdev_state *mds)
   912	{
   913		int rc, i;
   914		u16 num_returned;
   915		u64 granularity;
   916		struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
   917		struct cxl_mbox_media_op_discovery_out *disc_out __free(kfree) = NULL;
   918		struct cxl_mbox_media_op_discovery_in *disc_in __free(kfree) = NULL;
   919	
   920		if (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
   921			      mds->security.enabled_cmds))
   922			return 0;
   923	
   924		disc_in = kzalloc_obj(*disc_in);
   925		if (!disc_in)
   926			return -ENOMEM;
   927	
   928		disc_in->class = CXL_MEDIA_OP_CLASS_GENERAL;
   929		disc_in->subclass = CXL_MEDIA_OP_GENERAL_DISCOVERY;
   930		disc_in->dpa_range_count = 0;
   931		disc_in->start_index = 0;
   932		disc_in->num_ops = cpu_to_le16(CXL_MEDIA_OP_MAX_OPS);
   933	
   934		disc_out = kzalloc_flex(*disc_out, ops, CXL_MEDIA_OP_MAX_OPS);
   935		if (!disc_out)
   936			return -ENOMEM;
   937	
   938		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
   939			.opcode = CXL_MBOX_OP_MEDIA_OPERATION,
   940			.payload_in = disc_in,
   941			.size_in = sizeof(*disc_in),
   942			.payload_out = disc_out,
   943			.size_out = struct_size(disc_out, ops, CXL_MEDIA_OP_MAX_OPS),
   944			.min_out = sizeof(*disc_out),
   945			.poll_count = 1,
   946			.poll_interval_ms = 1000,
   947		};
   948	
   949		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
   950		if (rc < 0) {
   951			dev_dbg(cxl_mbox->host,
   952				"Media Operation Discovery failed: %d\n", rc);
   953			return rc;
   954		}
   955	
   956		num_returned = le16_to_cpu(disc_out->num_returned);
   957		if (num_returned > CXL_MEDIA_OP_MAX_OPS) {
   958			dev_dbg(cxl_mbox->host,
   959				"Discovery returned %u ops, expected max %u\n",
   960				num_returned, CXL_MEDIA_OP_MAX_OPS);
   961			return -EINVAL;
   962		}
   963	
   964		granularity = le64_to_cpu(disc_out->granularity);
   965		/* spec requires granularity to be a power of 2 and a multiple of 0x40 */
   966		if (!is_power_of_2(granularity) || !IS_ALIGNED(granularity, SZ_64)) {
   967			dev_dbg(cxl_mbox->host,
   968				"Discovery returned invalid granularity: %llu\n",
   969				granularity);
   970			return -EINVAL;
   971		}
   972		mds->media_op.granularity = granularity;
 > 973		mds->media_op.range_limit = rounddown(SZ_1G, granularity);
   974	
   975		for (i = 0; i < num_returned; i++) {
   976			u8 cls = disc_out->ops[i].class;
   977			u8 sub = disc_out->ops[i].subclass;
   978	
   979			if (cls == CXL_MEDIA_OP_CLASS_SANITIZE &&
   980			    sub == CXL_MEDIA_OP_SANITIZE_SANITIZE)
   981				mds->media_op.sanitize_supported = true;
   982			if (cls == CXL_MEDIA_OP_CLASS_SANITIZE &&
   983			    sub == CXL_MEDIA_OP_SANITIZE_ZERO)
   984				mds->media_op.zero_supported = true;
   985		}
   986	
   987		dev_dbg(cxl_mbox->host,
   988			"Media Operation: granularity=%llu sanitize=%d zero=%d\n",
   989			mds->media_op.granularity,
   990			mds->media_op.sanitize_supported,
   991			mds->media_op.zero_supported);
   992	
   993		return 0;
   994	}
   995	EXPORT_SYMBOL_NS_GPL(cxl_media_op_discover, "CXL");
   996	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

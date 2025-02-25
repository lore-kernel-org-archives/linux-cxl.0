Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C72AE72
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740459792; cv=none; b=G6PcPfkLcgkQI6LUhYIFh29fYGocygJhMrwFUbdpdDuw+BfO/wJuiV0pZ4/n+3RIEG9AR68GruARIIbbIeikdifpk29v3C+WL79vfiGzjpUH5RVhnK58J3vCT/QVzKkGtfZafLbPoZ7FsnwmS0uA1BWONqfoW35Utjha9DpP4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740459792; c=relaxed/simple;
	bh=T/PHvP7RJ3qeFxngOY7GDIvGVwQCrFvEwnEAWxQp65k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkLk7mLL6oCnVReBx/9DpIXc/EFhO/+CeAGK9RENgVZGF9xkcl+QHPegZP/GGCQGBspsZZzJbO3mCkEPwRzfbRlCqbGMTkkGKKEqwHEew4eT/VZxw5TVBk2dZBzy13Bk+Nt7EYduRBwE6zMYgFu7ekrpZzJ43oApNDY06dJH1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BX5K0CYu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BX5K0CYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740459791; x=1771995791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T/PHvP7RJ3qeFxngOY7GDIvGVwQCrFvEwnEAWxQp65k=;
  b=BX5K0CYueCPyUXvckaKpfneVdb19fCf69gYFK9a2sN6V4kEuhSdxDrZN
   AGBh0WFj+Tv2esUYGLeCMqMVrs1v9kOE3Wlo3rDYXIXQ9XU0+6i35saXQ
   kEwpkgR/ub8OqrgeHHYZweP+3Jn69Kww3Skaxmr0/6EuzakrdDSRnbE3B
   dwna96tzpQrqADNkGtSIKa8p3PocveAj9SHF+gKsZacw8Nrmz9kA+iEgp
   N1/br9pSXkn5w1WPfJKPimIkSs2hpoKUUrIvsI59cljZ2MQeONEPQLXbB
   m8FggH5l3ivJAjMkjjkUEqpxNoo5pBDkUX5i5jRqdE6aXc3G8fi9Jzb3c
   A==;
X-CSE-ConnectionGUID: fENKDdXPTNux0kU3xtqIfA==
X-CSE-MsgGUID: hVvOXPpnTJKwdB+nucLZOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58791622"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="58791622"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 21:03:10 -0800
X-CSE-ConnectionGUID: FTtwx+E9R/S3kATFv4pcnQ==
X-CSE-MsgGUID: 7R5/+2ZHSn2fa9x4WY1E3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="120899348"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2025 21:03:08 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmn5e-0009lj-37;
	Tue, 25 Feb 2025 05:02:49 +0000
Date: Tue, 25 Feb 2025 13:02:21 +0800
From: kernel test robot <lkp@intel.com>
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
Message-ID: <202502251245.NLuc888W-lkp@intel.com>
References: <20250224235817.2259508-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224235817.2259508-1-alison.schofield@intel.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2bb67004903cfd35710750654669a77e7223fcd1]

url:    https://github.com/intel-lab-lkp/linux/commits/alison-schofield-intel-com/cxl-region-Allow-6-12-way-regions-on-3-way-HB-interleaves/20250225-080107
base:   2bb67004903cfd35710750654669a77e7223fcd1
patch link:    https://lore.kernel.org/r/20250224235817.2259508-1-alison.schofield%40intel.com
patch subject: [PATCH] cxl/region: Allow 6 & 12 way regions on 3-way HB interleaves
config: riscv-randconfig-001-20250225 (https://download.01.org/0day-ci/archive/20250225/202502251245.NLuc888W-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250225/202502251245.NLuc888W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502251245.NLuc888W-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/region.c:1852: warning: Function parameter or struct member 'multiple' not described in 'cxl_calc_interleave_pos'


vim +1852 drivers/cxl/core/region.c

a3e00c964fb9439 Alison Schofield 2023-10-27  1834  
a3e00c964fb9439 Alison Schofield 2023-10-27  1835  /**
a3e00c964fb9439 Alison Schofield 2023-10-27  1836   * cxl_calc_interleave_pos() - calculate an endpoint position in a region
a3e00c964fb9439 Alison Schofield 2023-10-27  1837   * @cxled: endpoint decoder member of given region
a3e00c964fb9439 Alison Schofield 2023-10-27  1838   *
a3e00c964fb9439 Alison Schofield 2023-10-27  1839   * The endpoint position is calculated by traversing the topology from
a3e00c964fb9439 Alison Schofield 2023-10-27  1840   * the endpoint to the root decoder and iteratively applying this
a3e00c964fb9439 Alison Schofield 2023-10-27  1841   * calculation:
a3e00c964fb9439 Alison Schofield 2023-10-27  1842   *
a3e00c964fb9439 Alison Schofield 2023-10-27  1843   *    position = position * parent_ways + parent_pos;
a3e00c964fb9439 Alison Schofield 2023-10-27  1844   *
a3e00c964fb9439 Alison Schofield 2023-10-27  1845   * ...where @position is inferred from switch and root decoder target lists.
a3e00c964fb9439 Alison Schofield 2023-10-27  1846   *
a3e00c964fb9439 Alison Schofield 2023-10-27  1847   * Return: position >= 0 on success
a3e00c964fb9439 Alison Schofield 2023-10-27  1848   *	   -ENXIO on failure
a3e00c964fb9439 Alison Schofield 2023-10-27  1849   */
22639743643957e Alison Schofield 2025-02-24  1850  static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
22639743643957e Alison Schofield 2025-02-24  1851  				   int multiple)
a3e00c964fb9439 Alison Schofield 2023-10-27 @1852  {
a3e00c964fb9439 Alison Schofield 2023-10-27  1853  	struct cxl_port *iter, *port = cxled_to_port(cxled);
a3e00c964fb9439 Alison Schofield 2023-10-27  1854  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
a3e00c964fb9439 Alison Schofield 2023-10-27  1855  	struct range *range = &cxled->cxld.hpa_range;
a3e00c964fb9439 Alison Schofield 2023-10-27  1856  	int parent_ways = 0, parent_pos = 0, pos = 0;
a3e00c964fb9439 Alison Schofield 2023-10-27  1857  	int rc;
a3e00c964fb9439 Alison Schofield 2023-10-27  1858  
a3e00c964fb9439 Alison Schofield 2023-10-27  1859  	/*
a3e00c964fb9439 Alison Schofield 2023-10-27  1860  	 * Example: the expected interleave order of the 4-way region shown
a3e00c964fb9439 Alison Schofield 2023-10-27  1861  	 * below is: mem0, mem2, mem1, mem3
a3e00c964fb9439 Alison Schofield 2023-10-27  1862  	 *
a3e00c964fb9439 Alison Schofield 2023-10-27  1863  	 *		  root_port
a3e00c964fb9439 Alison Schofield 2023-10-27  1864  	 *                 /      \
a3e00c964fb9439 Alison Schofield 2023-10-27  1865  	 *      host_bridge_0    host_bridge_1
a3e00c964fb9439 Alison Schofield 2023-10-27  1866  	 *        |    |           |    |
a3e00c964fb9439 Alison Schofield 2023-10-27  1867  	 *       mem0 mem1        mem2 mem3
a3e00c964fb9439 Alison Schofield 2023-10-27  1868  	 *
a3e00c964fb9439 Alison Schofield 2023-10-27  1869  	 * In the example the calculator will iterate twice. The first iteration
a3e00c964fb9439 Alison Schofield 2023-10-27  1870  	 * uses the mem position in the host-bridge and the ways of the host-
a3e00c964fb9439 Alison Schofield 2023-10-27  1871  	 * bridge to generate the first, or local, position. The second
a3e00c964fb9439 Alison Schofield 2023-10-27  1872  	 * iteration uses the host-bridge position in the root_port and the ways
a3e00c964fb9439 Alison Schofield 2023-10-27  1873  	 * of the root_port to refine the position.
a3e00c964fb9439 Alison Schofield 2023-10-27  1874  	 *
a3e00c964fb9439 Alison Schofield 2023-10-27  1875  	 * A trace of the calculation per endpoint looks like this:
a3e00c964fb9439 Alison Schofield 2023-10-27  1876  	 * mem0: pos = 0 * 2 + 0    mem2: pos = 0 * 2 + 0
a3e00c964fb9439 Alison Schofield 2023-10-27  1877  	 *       pos = 0 * 2 + 0          pos = 0 * 2 + 1
a3e00c964fb9439 Alison Schofield 2023-10-27  1878  	 *       pos: 0                   pos: 1
a3e00c964fb9439 Alison Schofield 2023-10-27  1879  	 *
a3e00c964fb9439 Alison Schofield 2023-10-27  1880  	 * mem1: pos = 0 * 2 + 1    mem3: pos = 0 * 2 + 1
a3e00c964fb9439 Alison Schofield 2023-10-27  1881  	 *       pos = 1 * 2 + 0          pos = 1 * 2 + 1
a3e00c964fb9439 Alison Schofield 2023-10-27  1882  	 *       pos: 2                   pos = 3
a3e00c964fb9439 Alison Schofield 2023-10-27  1883  	 *
a3e00c964fb9439 Alison Schofield 2023-10-27  1884  	 * Note that while this example is simple, the method applies to more
a3e00c964fb9439 Alison Schofield 2023-10-27  1885  	 * complex topologies, including those with switches.
a3e00c964fb9439 Alison Schofield 2023-10-27  1886  	 */
a3e00c964fb9439 Alison Schofield 2023-10-27  1887  
a3e00c964fb9439 Alison Schofield 2023-10-27  1888  	/* Iterate from endpoint to root_port refining the position */
a3e00c964fb9439 Alison Schofield 2023-10-27  1889  	for (iter = port; iter; iter = next_port(iter)) {
a3e00c964fb9439 Alison Schofield 2023-10-27  1890  		if (is_cxl_root(iter))
a3e00c964fb9439 Alison Schofield 2023-10-27  1891  			break;
a3e00c964fb9439 Alison Schofield 2023-10-27  1892  
a3e00c964fb9439 Alison Schofield 2023-10-27  1893  		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
a3e00c964fb9439 Alison Schofield 2023-10-27  1894  		if (rc)
a3e00c964fb9439 Alison Schofield 2023-10-27  1895  			return rc;
a3e00c964fb9439 Alison Schofield 2023-10-27  1896  
22639743643957e Alison Schofield 2025-02-24  1897  		if (multiple > 1 && is_cxl_root(next_port(iter))) {
22639743643957e Alison Schofield 2025-02-24  1898  			pos = pos + multiple * parent_pos;
22639743643957e Alison Schofield 2025-02-24  1899  			break;
22639743643957e Alison Schofield 2025-02-24  1900  		}
22639743643957e Alison Schofield 2025-02-24  1901  
a3e00c964fb9439 Alison Schofield 2023-10-27  1902  		pos = pos * parent_ways + parent_pos;
a3e00c964fb9439 Alison Schofield 2023-10-27  1903  	}
a3e00c964fb9439 Alison Schofield 2023-10-27  1904  
a3e00c964fb9439 Alison Schofield 2023-10-27  1905  	dev_dbg(&cxlmd->dev,
a3e00c964fb9439 Alison Schofield 2023-10-27  1906  		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
a3e00c964fb9439 Alison Schofield 2023-10-27  1907  		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
a3e00c964fb9439 Alison Schofield 2023-10-27  1908  		dev_name(&port->dev), range->start, range->end, pos);
a3e00c964fb9439 Alison Schofield 2023-10-27  1909  
a3e00c964fb9439 Alison Schofield 2023-10-27  1910  	return pos;
a3e00c964fb9439 Alison Schofield 2023-10-27  1911  }
a3e00c964fb9439 Alison Schofield 2023-10-27  1912  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

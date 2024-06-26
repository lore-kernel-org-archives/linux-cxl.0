Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E307F;
	Wed, 26 Jun 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719360606; cv=none; b=PPWH62nFp7uaugOEYa0FkJU0ofyT/+oJPvcWYCdWZSexQXlu15uPXpLMDJI4Gapcs+eRDLbfX2WEeMHIN5fZlxlE9M0L4aMcwzPZGo9omJCtE6pjviIuS6ERI1V387rg7EvnQrGwiPRwhtOcH+Z+TVIPoSFasf9P/vDQKtZv+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719360606; c=relaxed/simple;
	bh=dB+q9SXCmgblK6huzubzEYiI5y+MRgII+TE/QeqpFcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swGBsMbzau982nqsiG4f+1OGSDsQhxPFE9qNFCxCllmFRtZpOv1jvfShfJSxcun1qtKEiihKgqdDNM/xq3VgzsHr58cRLUTxQNqL35z2QX2m+ry+aKsZjRbv7/el8ZB1uZZ9srMocM0F5QNTHjWsR6emP4HX4utvF+dpjME9t/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=httPedXo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="httPedXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719360605; x=1750896605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dB+q9SXCmgblK6huzubzEYiI5y+MRgII+TE/QeqpFcw=;
  b=httPedXoh9AB08l4zWWhJBJwcFJ4RFrPi04kelrYttUt7ZIKQQUbgtwL
   dEqLGCUNJp1iLGxknc5sXfUfkj2onI5/wjq00JPsNJsL5KjR6jGxbJG0q
   JU9PvaEIKYc0IwTd1uBNlGMNa3p7R/i/+TqNC8NuBFrtJ6Lu06jjLTEgx
   ROOSJqy7wqZGyMZhm0KxZukM7UphR8cAjxY8fqUGy+wUf4ZilAh3HvH+S
   3H2xiib/aiinniaghgLlOBAL5qlhzlot7jgkOZodjtnrL9oHkBguGJRf4
   rSSKu2nhErdkSi5KPt24uVwdv2dsPu6OTyYxU2AYxje/egRBNW0y4CBcu
   w==;
X-CSE-ConnectionGUID: T4am8ZaFT+ujzcV55NwUtA==
X-CSE-MsgGUID: YxY+gmQkR8iRM0TtqDXIIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16555580"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="16555580"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 17:10:04 -0700
X-CSE-ConnectionGUID: q5o93v8eTheytNGsibSGeQ==
X-CSE-MsgGUID: KCs9W1AAS2SQ2ZYJJ84f4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="43682292"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.71.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 17:10:03 -0700
Date: Tue, 25 Jun 2024 17:10:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Warn on unsupported platform config detection
Message-ID: <ZntcWQ7pMtOpuT4a@aschofie-mobl2>
References: <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>

On Wed, Jun 19, 2024 at 02:59:41PM +0200, Fabio M. De Francesco wrote:

Fabio,

cxl/acpi does a lot of platform config work. "...unsupported platform
config detection" gives no hint that this is about CHBS's or an eRCD.
Please offer something more specific. Thanks.

--Alison

snip...


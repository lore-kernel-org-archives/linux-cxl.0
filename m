Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FF481CD;
	Mon, 17 Nov 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387849; cv=none; b=HB1EECHZ6Rs+swE/Ssk5jwn+N0o1PLZdRXSWKTqlHZ8mX793Va67b9wwr//0Ej3/eWLwTuTBiF5QigrV5enWYNOHOBnaPkN2ifzBiGO+WvlnkeMVB33phj10snojNCstohUx38OdEC3EMLL/3YpAt/dAN27SUuG9JKMtMxtWLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387849; c=relaxed/simple;
	bh=unjiJwKDpnqTfSBmyNn5Nl3+yyfJMsy8A9tWjLJ5QJs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVFp1EBp0wauNjQpccJ5RJnJPksW8qu/QexNzbFRE72cKOdwge2JZQ0k+ri1Dml2bE+U8c3Fp6nhYHe0H/uvlgEncLO5qLE9CzHEN4Oj+uOciHzkNA5fTNrwWfQHyFuuKs9ZXxoCyvknVF2TcA2KYv/8nczClNMgcw6OpiCGeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d98S6113hzHnGgr;
	Mon, 17 Nov 2025 21:56:54 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BBAC14022E;
	Mon, 17 Nov 2025 21:57:23 +0800 (CST)
Received: from localhost (10.48.145.13) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 17 Nov
 2025 13:57:22 +0000
Date: Mon, 17 Nov 2025 13:57:20 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v7 06/11] cxl/region: Add @hpa_range argument to
 function cxl_calc_interleave_pos()
Message-ID: <20251117135720.00006500@huawei.com>
In-Reply-To: <20251114213931.30754-7-rrichter@amd.com>
References: <20251114213931.30754-1-rrichter@amd.com>
	<20251114213931.30754-7-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 14 Nov 2025 22:39:19 +0100
Robert Richter <rrichter@amd.com> wrote:

> cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
> determine its interleaving position. This requires the endpoint
> decoders to be an SPA, which is not the case for systems that need
> address translation.
> 
> Add a separate @hpa_range argument to function
> cxl_calc_interleave_pos() to specify the address range. Now it is
> possible to pass the SPA translated address range of an endpoint
> decoder to function cxl_calc_interleave_pos().
> 
> Refactor only, no functional changes.
> 
> Patch is a prerequisite to implement address translation.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

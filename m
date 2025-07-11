Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED21CDA3F;
	Fri, 11 Jul 2025 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251806; cv=none; b=hdxH6hQR9t8W5jktDKA6x/CqbqglWdlwqqAaCZ1kb6egBlWurycHdbo6G9TJnfvwtKP6tTixzb+Zr2wvaOxS7wq6d3QvNPyqBZcaLjv56za3JhBlhyBKw8R8zycmD4HhSle+L04M3C8hC/qpzEflNMxQ7u2Cfxi3Lyt2u/QaOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251806; c=relaxed/simple;
	bh=VIXdnSJaAUs17NaCKV/OnSMEBJJg/cL8Kr6HPHedEmI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jE1i8QVZPwFP/kzUyQExf9Gq2y3428bmsO0We1Yy0jjEwZr96iwoLELuCTujnyCVrPQAYclTPGLylBZywsSh1mtLxSYI6jEIx8JvLiuGnwkcAWoYPIhftR+vo7rfJXgaoH1FrOV1YKVF7r31NF6O156Z+3IrWTSGn82XEL8pgh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdy2971xbz6L56m;
	Sat, 12 Jul 2025 00:33:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 854621402FF;
	Sat, 12 Jul 2025 00:36:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 18:36:40 +0200
Date: Fri, 11 Jul 2025 17:36:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Remove core/acpi.c and cxl core dependency on ACPI
Message-ID: <20250711173638.00003270@huawei.com>
In-Reply-To: <20250711151529.787470-1-rrichter@amd.com>
References: <20250711151529.787470-1-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 17:15:27 +0200
Robert Richter <rrichter@amd.com> wrote:

> From Dave [1]:
> 
> """
> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
> cxl_core when adding the extended linear cache support.
> """
> 
> Current implementation calls hmat_get_extended_linear_cache_size() of
> the ACPI subsystem. That external reference causes issue running
> cxl_test as there is no way to "mock" that function and ignore it when
> using cxl test.
> 
> Instead of working around that using cxlrd ops and extensively
> expanding cxl_test code [1], just move HMAT calls out of the core
> module to cxl_acpi. Implement this by adding a @cache_size member to
> struct cxl_root_decoder. During initialization the cache size is
> determined and added to the root decoder object in cxl_acpi. Later on
> in cxl_core the cache_size parameter is used to setup extended linear
> caching.
> 
> [1] https://patch.msgid.link/20250610172938.139428-1-dave.jiang@intel.com
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


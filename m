Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B745267728;
	Fri, 14 Feb 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550573; cv=none; b=L4SiKXSgh4u0/vlDE1IEkqE6fzbGMaa0RSF22z0kJQSy/CBy2x9q8XS93KqeOwXk6Yo3Ul2c4zDEz1le9Bxxs4NEA5zXvLuCfy5dvbS+5g1bIowKED9DdH70PHejCerz5CAtAYbESNnA626YjQigM0VBQMm6EgkqQ84kMA8r7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550573; c=relaxed/simple;
	bh=GmZxlBT8tGF12YiTfduX+xqCPEniiVXUPfWZQ++ovfU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idS2VYJyguJpfLN3ALVzsrIJY8fr28lCpnGEIR37AHfD07pH+CIGYixK0PbXRMQDSbu9La7AOhj10syxZO8mwYYMR91Mf0iCYtM0GyuDC/CRuzI3xjpW8AXTpy2xz836PDgI7Fg9fr2Fj+xfc7mE95RPj+STgeU54JpsRKr5ZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvcsx4cx7z6HJfY;
	Sat, 15 Feb 2025 00:28:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 68F1F140A77;
	Sat, 15 Feb 2025 00:29:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 17:29:26 +0100
Date: Fri, 14 Feb 2025 16:29:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 13/18] cxl/region: Add function to find a port's
 switch decoder by range
Message-ID: <20250214162925.000065e5@huawei.com>
In-Reply-To: <20250211095349.981096-14-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-14-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 10:53:43 +0100
Robert Richter <rrichter@amd.com> wrote:

> Factor out code to find the switch decoder of a port for a specific
> address range. Reuse the code to search a root decoder, create the
> function cxl_port_find_switch_decoder() and rework
> match_root_decoder_by_range() to be usable for switch decoders too.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

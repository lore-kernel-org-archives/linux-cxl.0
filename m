Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281B311C20;
	Tue, 11 Nov 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872736; cv=none; b=dTDPL6r/eQbr+9A1Fzzf0ONqNYdC2mjXHq6hUkpiO5Tolyqq5BEDcwS4DMGWNIsbPx+cJnHstDrthkpd2LeCSWvUoRqZK7E0EO8IzoTNy242akouxhnIgwy7mrEYcGxT2A8HBkTDulmVQ1ayDtZs7qvTStPl5XdrTyBgeCyw8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872736; c=relaxed/simple;
	bh=7GIiBPTAcSlxa1iJJiu0qJfenoNcaUIlQuqVWGcSTRI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6NFdIHEq5vzJsIO12q10Z1WlhsC9wo78+yKPXw6UTEhpqD/iRP1xMqA9IUYMjQmCbVPrLCzCrMdBmws0kBm5YbkFRutNJiLYYe/L2RGiqc6IJvuephiii1CXHQET/CGXAKFId6dqZZTTLoLLmuYXu4t2j0ecSuTIbIANPhjNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5TyK1z8xzHnGhV;
	Tue, 11 Nov 2025 22:51:53 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8805D140370;
	Tue, 11 Nov 2025 22:52:10 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 14:52:09 +0000
Date: Tue, 11 Nov 2025 14:52:08 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 05/14] cxl: Simplify cxl_root_ops allocation and
 handling
Message-ID: <20251111145208.00004b9a@huawei.com>
In-Reply-To: <20251103184804.509762-6-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-6-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 3 Nov 2025 19:47:46 +0100
Robert Richter <rrichter@amd.com> wrote:

> A root port's callback handlers are collected in struct cxl_root_ops.
> The structure is dynamically allocated, though it contains only a
> single pointer in it. This also requires to check two pointers to
> check for the existance of a callback.
> 
> Simplify the allocation, release and handler check by embedding the
> ops statical in struct cxl_root.

statically

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Make sense on it's own.  Maybe one to pick up early if there are blockers
on later patches.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



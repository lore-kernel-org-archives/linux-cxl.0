Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96D28A1F3
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181836; cv=none; b=RzcakAf3bglnRch3cHFRnuXD0T0CtGH4dTaoK63rFMWrtK5a7htn9jldc+GM+ln7n5VSEKuWYmrkyAmY6mXPrkbeyh1eayOaB1yyyoIoGCwG1O96N+/MqtGBJ3+T1uRq9MWSqaVsbV5KUzOqCY/lHNzL5iK8E7Xm0OydH6yjwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181836; c=relaxed/simple;
	bh=SlfrlqwwSHE73rBbQqNbUM+sfp3jXM9aXw6vvGYdgSU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vea/G5sJY3v/TLIY7UJCKfHYxW1ZhtappptUSuU7fEH/moaN6Q+BZZf3ZvNg144Hu/7ermQjHr+5cq6+IaFaBY/AyWJjRYPUSDxfKI3/uJQRyZc87+JoS+bq1uiH/wGn39ilARsdf+OV8suuMxanx8baojTUKlMh3ND9glbFhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bmYym3LdFz6GDCN;
	Tue, 22 Jul 2025 18:53:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6407E1402F7;
	Tue, 22 Jul 2025 18:57:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Jul
 2025 12:57:09 +0200
Date: Tue, 22 Jul 2025 11:57:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>, Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
Message-ID: <20250722115708.00003b16@huawei.com>
In-Reply-To: <20250721170415.285961-1-dave.jiang@intel.com>
References: <20250721170415.285961-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 21 Jul 2025 10:04:15 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Remove from core/pci_aer.c and move the CONFIG_PCIEAER_CXL ifdef to
> cxlpci.h to deal with the exported symbols as needed. There is enough
> AER handling code (and more to come) to move the AER code to its own
> C file.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080130F94E
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209558; cv=none; b=YEz7FUTcavqXC7H2tYQ5cKhGZDAWdtKJE8aL9CJfzkRQ4xi6TR/SzhvOaRrZF7ncfjxJ2MrVB0XctTbbavVgkUiORtyZgjle6Q46SGyVuIZ5aehIGxbbbmFvzAS32KzVMBYUM/IlrvWc83EoP4f3g1s3Ld7zDFKN6q9z3hxlBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209558; c=relaxed/simple;
	bh=cBabSSxrKzYykqnWceCQT+SBiou9PZCQ6HjKf7CjUmI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIn+Uk2EDPZ5t+NalpiQLAw9Ow/qHoPy7oPiCXn865ZH1Nh0hD3Wk0sQDwH8v9Y8f5l5VgfaBMO9IcMKGHGIV39oCXpTQuQTlS+y+F4zuTYswxq8ZCRE5MbLYzI5r85Zvj8qhCwlYJcF9hvhvAGLhPjkSz4FuaJ+QUjfBKibp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSKJq2Jz6z6K6kj;
	Thu, 18 Sep 2025 23:27:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 321DC14033F;
	Thu, 18 Sep 2025 23:32:31 +0800 (CST)
Received: from localhost (10.47.69.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Sep
 2025 17:32:30 +0200
Date: Thu, 18 Sep 2025 16:32:29 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] cxl/acpi: Make the XOR calculations available
 for testing
Message-ID: <20250918163229.00000393@huawei.com>
In-Reply-To: <76808ea6eb83a33dad50abc9707a4cf972d822d3.1758150087.git.alison.schofield@intel.com>
References: <cover.1758150087.git.alison.schofield@intel.com>
	<76808ea6eb83a33dad50abc9707a4cf972d822d3.1758150087.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 17 Sep 2025 17:10:31 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> In preparation for adding a test module that can exercise the address
> translation functions performed by the CXL Driver, refactor the XOR
> implementation like this:
> 
> - Extract the core calculation into a standalone helper function,
> - Export the new function for use by test module cxl_translate only,
> - Enhance the parameter validation since this new function will be
>   called from a test module with no guarantee of valid parameters,
> - Move the define of struct cxl_cxims_data to cxl.h so the test module
>   can build xormaps.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Seems fine to me
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

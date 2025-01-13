Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBC22A4FD
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jan 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772862; cv=none; b=j7Mk2so9dNoKUts4D31UxvZNIs3kH03FEBvkwUscccoP+vAPSMuX2KlwXq4IZbnis6vFeocPc7B8TMV2OD7Iql9zk3o7dOokvyVKsNC6wNTemRrDUGMwW+lcysj6Y7DmG/H2/fZn2JNBvPK/+0Tt7De0m/FNqGuZAF5TUsc3vzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772862; c=relaxed/simple;
	bh=xUQy8JZBqLR/fbckW7ScaJAzP57ueJcyxRETK2JJDKw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfNZf+0P/ChwLJD74jaCyCgWZEyyG6LKEKndTf98clN53j6t+/jBEODOIx0cy1AjbokHrGJ6+v1XBiDn+SLIzhjRpx2JQljwi3E/12a/M75xOTIFu1AIvneVoApVVYz7p0lCuddAcHcpOe2lR4zJ9a8VcqCjx/Ob3GZ1piREg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YWscQ5dThz6K6h4;
	Mon, 13 Jan 2025 20:52:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 80CA6140B55;
	Mon, 13 Jan 2025 20:54:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 13:54:18 +0100
Date: Mon, 13 Jan 2025 12:54:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl: Plug typos in ABI doc
Message-ID: <20250113125416.00002aa9@huawei.com>
In-Reply-To: <20250113025240.327124-2-dave@stgolabs.net>
References: <20250113025240.327124-1-dave@stgolabs.net>
	<20250113025240.327124-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 12 Jan 2025 18:52:39 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Trivially update where necessary.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

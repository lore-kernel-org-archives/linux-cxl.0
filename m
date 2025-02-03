Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B40205512
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590697; cv=none; b=YHWoo/O/a+G+7cX6k4cqJFqjrxX/YO/xA0NAyM3YkaOIrLu4VwNZQmSKdyvbumTNCtIHnU9FwX6VlXkllpelb52EcQMyJVgJBZOnfkEHtZxYUGxNtjfY7SU+6k9HmAhZfMpyAM4L7ZyLIBFgb096kyKILDs0hA6fA24b8DHGAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590697; c=relaxed/simple;
	bh=qqe40gXgbdSs336JpELiY7589iKwHXZomZbxKr4OkOM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gESKx+oKp3qRykIEcPRNLWEm9RZ4LVrQmzp+dXw4CwmQEwnZaQ89Xcvqtk7kEscbRTrPNe957/Sr6MYkbgoz7PTE9HCAc5AE+4npZAVM2OPKNuC1TJnqJMGOKt7ftka6PgTIAiQl7Z5IGGzQDU7h6GlT/Y9IuJtyPwmSo9CKYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmnvQ4JTJz6K9Ft;
	Mon,  3 Feb 2025 21:50:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7693914011B;
	Mon,  3 Feb 2025 21:51:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 14:51:32 +0100
Date: Mon, 3 Feb 2025 13:51:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>
Subject: Re: [NDCTL PATCH resend v2 2/3] cxl: Enumerate major/minor of FWCTL
 char device
Message-ID: <20250203135130.00004033@huawei.com>
In-Reply-To: <20250201004815.474741-3-dave.jiang@intel.com>
References: <20250201004815.474741-1-dave.jiang@intel.com>
	<20250201004815.474741-3-dave.jiang@intel.com>
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

On Fri, 31 Jan 2025 17:47:30 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add major/minor discovery for the FWCTL character device that is associated
> with supprting CXL Features under the cxl_memdev. Add libcxl API functions
> to retrieve the major and minor of the FWCTL character device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Looks fine to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
